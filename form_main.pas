unit form_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls,form_mirror,global,form_about,Windows;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    MenuItem_160_120: TMenuItem;
    MenuItem_full_screen: TMenuItem;
    MenuItem_1024_768: TMenuItem;
    MenuItem_320_240: TMenuItem;
    MenuItem_800_600: TMenuItem;
    MenuItem_640_480: TMenuItem;
    MenuItemAbout: TMenuItem;
    MenuItemExit: TMenuItem;
    PopupMenu1: TPopupMenu;
    TrayIcon1: TTrayIcon;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem_160_120Click(Sender: TObject);
    procedure MenuItemAboutClick(Sender: TObject);
    procedure MenuItem_1024_768Click(Sender: TObject);
    procedure MenuItem_320_240Click(Sender: TObject);
    procedure MenuItem_800_600Click(Sender: TObject);
    procedure MenuItem_640_480Click(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItem_full_screenClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
    procedure ShowMirror(tf:boolean);
  end; 

var
  frmMain: TfrmMain;
  fm:TfrmMirror;

implementation

{$R *.lfm}

{ TfrmMain }
procedure TfrmMain.ShowMirror(tf:boolean);
begin
  if tf=true then
     begin
          if fm<>nil then
          begin
               fm.Close;
               fm.Free;
          end;
          self.MenuItem_160_120.Enabled:=false;
          self.MenuItem_320_240.Enabled:=false;
          self.MenuItem_640_480.Enabled:=false;
          self.MenuItem_800_600.Enabled:=false;
          self.MenuItem_1024_768.Enabled:=false;
          self.MenuItemAbout.Enabled:=false;

          global.isMirrorShow:=true;
          fm:=TfrmMirror.Create(nil);
          fm.Width:=global.ww;
          fm.Height:=global.hh;
          fm.Show;
     end
  else
      if fm<> nil  then
      begin
            fm.Close;
            fm.Free;
            fm:=nil;

      end;
      begin
          self.MenuItem_160_120.Enabled:=true;
          self.MenuItem_320_240.Enabled:=true;
          self.MenuItem_640_480.Enabled:=true;
          self.MenuItem_800_600.Enabled:=true;
          self.MenuItem_1024_768.Enabled:=true;
          self.MenuItemAbout.Enabled:=true;
          global.isMirrorShow:=false;
      end;
end;

procedure TfrmMain.MenuItem_640_480Click(Sender: TObject);
begin

   self.ShowMirror(false);
   Application.ProcessMessages;
   global.ww:=640;
   global.hh:=480;

   self.ShowMirror(true);

end;

procedure TfrmMain.MenuItemExitClick(Sender: TObject);
begin
  if fm<> nil then fm.Close;
  self.Close;
  halt;
end;

procedure TfrmMain.MenuItem_full_screenClick(Sender: TObject);
begin
   self.ShowMirror(false);
   Application.ProcessMessages;
   global.ww:=screen.Width;
   global.hh:=screen.Height;

   self.ShowMirror(true);
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
   Application.ProcessMessages;
   //self.Timer1.Enabled:=false;
   if needCreateNewMirror=true then
   begin
        Application.ProcessMessages;
        Application.ProcessMessages;
        Application.ProcessMessages;

        needCreateNewMirror:=false;
        frmMirror.Close;
        Application.ProcessMessages;
        Application.ProcessMessages;
        Application.ProcessMessages;
        frmMirror.Width:=global.ww;
        frmMirror.Height:=global.hh;
        self.ShowMirror(true);
   end;

end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
begin
 if  global.isMirrorShow=false then
 begin
      self.ShowMirror(false);
 end;
end;

procedure TfrmMain.TrayIcon1DblClick(Sender: TObject);
begin
   global.isMirrorShow:=true;
   frmMirror.Close;
   self.ShowMirror(true);
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
      needCreateNewMirror:=true;
      self.Hide;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
 var
  mHandle: System.THandle;

begin
  fm:=nil;
  mHandle := Windows.CreateMutex(nil, true, pchar('cam_mirror_lazarus'));

  if (mHandle=0) or (GetLastError = Windows.ERROR_ALREADY_EXISTS) then
  begin

        showmessage('Cam Mirror already runing...');
        Windows.ReleaseMutex(mHandle);
        Halt;

  end;


  self.MenuItem_160_120.Caption:= global.nShowMirror + ' 160*120';
  self.MenuItem_320_240.Caption:= global.nShowMirror + ' 320*240';
  self.MenuItem_640_480.Caption:= global.nShowMirror + ' 640*480';
  self.MenuItem_800_600.Caption:= global.nShowMirror + ' 800*600';
  self.MenuItem_1024_768.Caption:= global.nShowMirror + ' 1024*768';
  self.MenuItem_full_screen.Caption:= global.nShowMirror + ' '+ nFullSceeen ;
  self.MenuItemAbout.Caption:= global.nAbout;
  self.MenuItemExit.Caption:= global.nExit;
  self.ShowMirror(true);
  self.TrayIcon1.Hint:= global.nAppTitle;

end;

procedure TfrmMain.MenuItem_160_120Click(Sender: TObject);
begin
   self.ShowMirror(false);
   Application.ProcessMessages;
   global.top_most:=true;
   global.ww:=160;
   global.hh:=120  ;

   self.ShowMirror(true);
end;

procedure TfrmMain.MenuItemAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.MenuItem_1024_768Click(Sender: TObject);
begin
   global.top_most:=false;
   self.ShowMirror(false);
   Application.ProcessMessages;
   global.ww:=1024;
   global.hh:=768   ;

   Application.ProcessMessages;
   self.ShowMirror(true);
end;

procedure TfrmMain.MenuItem_320_240Click(Sender: TObject);
begin
   self.ShowMirror(false);
   Application.ProcessMessages;
   global.ww:=320;
   global.hh:=240   ;
   Application.ProcessMessages;

   Application.ProcessMessages;
   self.ShowMirror(true);
end;

procedure TfrmMain.MenuItem_800_600Click(Sender: TObject);
begin
   self.ShowMirror(false);
   Application.ProcessMessages;
   global.ww:=800;
   global.hh:=600;

   Application.ProcessMessages;
   self.ShowMirror(true);
end;

end.

