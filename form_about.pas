unit form_about;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, global,my_pub_functions;

type

  { TfrmAbout }

  TfrmAbout = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblTitle: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmAbout: TfrmAbout;

implementation

{$R *.lfm}

{ TfrmAbout }

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
   self.Caption:=global.nAppTitle;
   self.lblTitle.Caption:=global.nAppTitle;

end;

procedure TfrmAbout.Label2Click(Sender: TObject);
begin
  my_pub_functions.OpenUrl(self.Label2.Caption);
end;

procedure TfrmAbout.Label3Click(Sender: TObject);
begin
   my_pub_functions.OpenUrl(self.Label3.Caption);
end;

procedure TfrmAbout.Button1Click(Sender: TObject);
begin
  self.Close;
end;

end.

