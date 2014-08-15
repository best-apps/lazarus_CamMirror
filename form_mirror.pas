unit form_mirror;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls,IniFiles, Graphics, Dialogs, ExtCtrls,VFW,
  StdCtrls, Menus,windows,form_about,global;

type

  { TfrmMirror }

  TfrmMirror = class(TForm)
    Image1: TImage;
    MenuItemAbout: TMenuItem;
    MenuItemLanEnglish: TMenuItem;
    MenuItemLanBig5: TMenuItem;
    MenuItemLanZh: TMenuItem;
    MenuItemLanguages: TMenuItem;
    MenuItemTop: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItemTopMost: TMenuItem;
    MenuItemNormal: TMenuItem;
    MenuItemScreenShot: TMenuItem;
    MenuItemResolution: TMenuItem;
    MenuItemHide: TMenuItem;
    MenuItemExitApplication: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem_160_120: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image1Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItemAboutClick(Sender: TObject);
    procedure MenuItemLanBig5Click(Sender: TObject);
    procedure MenuItemLanEnglishClick(Sender: TObject);
    procedure MenuItemLanguagesClick(Sender: TObject);
    procedure MenuItemLanZhClick(Sender: TObject);
    procedure MenuItemTopClick(Sender: TObject);
    procedure MenuItemTopMostClick(Sender: TObject);
    procedure MenuItemNormalClick(Sender: TObject);
    procedure MenuItemScreenShotClick(Sender: TObject);
    procedure MenuItemHideClick(Sender: TObject);
    procedure MenuItemExitApplicationClick(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItem_160_120Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);
    procedure RadioButton4ChangeBounds(Sender: TObject);
    procedure RadioButton5Change(Sender: TObject);
    procedure RadioButton5ChangeBounds(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    booHaveCap:boolean;
    hCapWnd: HWND;
    procedure ShowVideo();
    procedure CloseVideo() ;
    procedure ResetVideoSize(w,h : Integer);
  public
    { public declarations }
  end; 

var
  frmMirror: TfrmMirror;

implementation

{$R *.lfm}

{ TfrmMirror }

procedure TfrmMirror.ResetVideoSize(w,h : Integer);
begin

  self.Panel1.Caption:= global.nLookForCam;
  capDriverDisconnect(self.hCapWnd) ;
  DestroyWindow(self.hCapWnd);
  global.isMirrorShow:=false;
  global.ww:=w;
  global.hh:=h;
  self.Caption:= global.nAppTitle  + '  ' + inttostr(global.ww) + '*' + inttostr(global.hh);
  self.Height:=h;
  self.Width:=w;
  self.Refresh;
  Application.ProcessMessages;
  Application.ProcessMessages;
  self.ShowVideo();
end;

procedure TfrmMirror.CloseVideo();
begin
    if self.hCapWnd <> 0 then
    begin
         capDriverDisconnect(self.hCapWnd) ;
         DestroyWindow(self.hCapWnd);
         global.isMirrorShow:=false;
    end;
end;

procedure TfrmMirror.ShowVideo() ;
   var
    ScanDriver: boolean;
    i: integer;
begin

  self.CloseVideo();
  hCapWnd:=0;
  self.Timer1.Interval:=0;
  self.booHaveCap:=false;

  application.ProcessMessages;
  hCapWnd := capCreateCaptureWindow('Camera as Mirror ',
                                   WS_VISIBLE or WS_CHILD ,
                                   0,
                                   0,
                                   global.ww,
                                   global.hh,
                                   Panel1.Handle,
                                   0);

  ScanDriver := false;
  for i:= 0 to 9 do
  begin
    ScanDriver:=capDriverConnect(hCapWnd,i);
    if (ScanDriver) then break;
  end;
  if not ScanDriver then
  begin
    hCapWnd:=0;
    ShowMessage('Did not find any Camera.');
    Close;
    exit;
  end;

  capDriverConnect (hCapWnd, 0);
  capPreviewScale(hCapWnd,true)  ;
  capPreviewRate(hCapWnd,25);
  capPreview(hCapWnd,true);

end;

procedure TfrmMirror.Panel1Click(Sender: TObject);
begin

end;

procedure TfrmMirror.Panel2Click(Sender: TObject);
begin

end;

procedure TfrmMirror.RadioButton1Change(Sender: TObject);
begin
  global.ww:=320;
  global.hh:=240+50;
  global.needCreateNewMirror:=true;
  self.Close;
end;

procedure TfrmMirror.RadioButton2Change(Sender: TObject);
begin
  self.Close;
  global.ww:=640;
  global.hh:=480+50;
  global.needCreateNewMirror:=true;

end;

procedure TfrmMirror.RadioButton3Change(Sender: TObject);
begin
  self.Close;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  global.ww:=800;
  global.hh:=600+150;
  global.needCreateNewMirror:=true;

end;

procedure TfrmMirror.RadioButton4Change(Sender: TObject);
begin
  self.Close;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  global.ww:=1024;
  global.hh:=768+50;
  global.needCreateNewMirror:=true;

end;

procedure TfrmMirror.RadioButton4ChangeBounds(Sender: TObject);
begin

end;

procedure TfrmMirror.RadioButton5Change(Sender: TObject);
begin
  self.Close;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  application.ProcessMessages;
  global.ww:=Screen.Width;
  global.hh:=Screen.Height;
  global.needCreateNewMirror:=true;

end;

procedure TfrmMirror.RadioButton5ChangeBounds(Sender: TObject);
begin

end;

procedure TfrmMirror.Timer1Timer(Sender: TObject);
begin
  self.Timer1.Interval:=0;
  self.ShowVideo();
end;

procedure TfrmMirror.FormActivate(Sender: TObject);
begin

    // self.Caption:= global.nAppTitle  + '  ' + inttostr(global.ww) + '*' + inttostr(global.hh-50);
end;

procedure TfrmMirror.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   self.CloseVideo();

   OpenDialog1.FileName:=fileconf;
   IniReader := TIniFile.Create(OpenDialog1.FileName);
   IniReader.WriteInteger('Environment','width',global.ww);
   IniReader.WriteInteger('Environment','height',global.hh);
   IniReader.WriteString('Environment','Lang',Lang);


   IniReader.Free;
end;

procedure TfrmMirror.FormCreate(Sender: TObject);

begin
     self.Timer1.Interval:=20;
     self.Timer1.Enabled:=true;
     self.Caption:= global.nAppTitle  + '  ' + inttostr(global.ww) + '*' + inttostr(global.hh);
     self.Panel1.Caption:= global.nLookForCam;

     self.MenuItemTop.Caption:= global.nTop;
     self.MenuItemTopmost.Caption:= global.nTopMost;
     self.MenuItemNormal.Caption:= global.nNormal;
     self.MenuItemResolution.Caption:= global.nResolution;
     self.MenuItemHide.Caption:= global.nHide;
     self.MenuItemExitApplication.Caption:= global.nExitApplication;
     self.MenuItemScreenShot.Caption:= global.nScreenShot;

     self.MenuItemAbout.Caption:= global.nAbout;
end;

procedure TfrmMirror.FormDblClick(Sender: TObject);
begin

end;

procedure TfrmMirror.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = VK_ESCAPE  then close;
end;

procedure TfrmMirror.Image1Click(Sender: TObject);
begin

end;

procedure TfrmMirror.MenuItem10Click(Sender: TObject);
begin
  self.ResetVideoSize(800,600);
end;

procedure TfrmMirror.MenuItem11Click(Sender: TObject);
begin
  self.ResetVideoSize(1024,768);
end;

procedure TfrmMirror.MenuItem12Click(Sender: TObject);
begin
  self.Left:=0;
  self.Top :=0;
  self.ResetVideoSize(screen.Width,screen.Height);
end;

procedure TfrmMirror.MenuItemAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMirror.MenuItemLanBig5Click(Sender: TObject);
begin
      OpenDialog1.FileName:=fileconf;
      IniReader := TIniFile.Create(OpenDialog1.FileName);
      global.Lang:= 'big5';
      IniReader.WriteString('Environment','Lang','big5');
      IniReader.WriteString('Environment','FallbackLang','en');
      IniReader.Free;
      ShowMessage(nLanguagePrompt);

end;

procedure TfrmMirror.MenuItemLanEnglishClick(Sender: TObject);
begin
      OpenDialog1.FileName:=fileconf;
      IniReader := TIniFile.Create(OpenDialog1.FileName);
      global.Lang:= 'en';
      IniReader.WriteString('Environment','Lang','en');
      IniReader.WriteString('Environment','FallbackLang','en');
      IniReader.Free;
      ShowMessage(nLanguagePrompt);
end;

procedure TfrmMirror.MenuItemLanguagesClick(Sender: TObject);
begin

end;

procedure TfrmMirror.MenuItemLanZhClick(Sender: TObject);
begin
      OpenDialog1.FileName:=fileconf;
      IniReader := TIniFile.Create(OpenDialog1.FileName);
      global.Lang:= 'zh';
      IniReader.WriteString('Environment','Lang','zh');
      IniReader.WriteString('Environment','FallbackLang','en');
      IniReader.Free;
      ShowMessage(nLanguagePrompt);
end;

procedure TfrmMirror.MenuItemTopClick(Sender: TObject);
begin

end;

procedure TfrmMirror.MenuItemTopMostClick(Sender: TObject);
begin
  SetWindowPos(Handle,HWND_TOPMOST,Left,Top,global.ww,global.hh+25,0) ;
end;

procedure TfrmMirror.MenuItemNormalClick(Sender: TObject);
begin
  SetWindowPos(Handle,HWND_NOTOPMOST,Left,Top,global.ww,global.hh+25,0);
end;

procedure TfrmMirror.MenuItemScreenShotClick(Sender: TObject);
var
   ScreenDC:HDC;
begin
  ScreenDC:= GetDC(hCapWnd);
  image1.picture.bitmap.LoadFromDevice(ScreenDC);
  ReleaseDc(0, ScreenDC);
  self.SaveDialog1.FileName:='';
  self.SaveDialog1.Execute;

  if self.SaveDialog1.FileName<>'' then
  begin
      Image1.Picture.SaveToFile(self.SaveDialog1.FileName);
      ShowMessage ('screen shot saved to file:' + self.SaveDialog1.FileName);
  end;
end;

procedure TfrmMirror.MenuItemHideClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmMirror.MenuItemExitApplicationClick(Sender: TObject);
begin
  self.Close;
  halt;
end;

procedure TfrmMirror.MenuItem8Click(Sender: TObject);
begin
     self.ResetVideoSize(320,240);
end;

procedure TfrmMirror.MenuItem9Click(Sender: TObject);
begin
    self.ResetVideoSize(640,480);
end;

procedure TfrmMirror.MenuItem_160_120Click(Sender: TObject);
begin
    self.ResetVideoSize(160,120);
end;

procedure TfrmMirror.Button1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmMirror.Button2Click(Sender: TObject);
var
   ScreenDC:HDC;
begin
  ScreenDC:= GetDC(hCapWnd);
  image1.picture.bitmap.LoadFromDevice(ScreenDC);
  ReleaseDc(0, ScreenDC);
  self.SaveDialog1.FileName:='';
  self.SaveDialog1.Execute;

  if self.SaveDialog1.FileName<>'' then
  begin
      Image1.Picture.SaveToFile(self.SaveDialog1.FileName);
      ShowMessage ('Snap Image saved to file:' + self.SaveDialog1.FileName);
  end;
end;

procedure TfrmMirror.Button3Click(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMirror.CheckBox1Change(Sender: TObject);
begin

end;

end.

