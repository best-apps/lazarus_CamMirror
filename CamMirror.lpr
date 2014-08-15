program CamMirror;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces,SysUtils,Process,Classes,IniFiles, // this includes the LCL widgetset
  Forms, form_main, form_mirror,form_about, global,LCLProc, my_pub_functions,Translations,Dialogs
  { you can add units after this };

{$R *.res}
procedure TranslateLCL;
var
  AProcess: TProcess;
  AStringList: TStringList;
  Conffile: Tinifile;
  mHandle : longint;
  hMutex : longint;
begin
   {$IFDEF LINUX}


     AProcess := TProcess.Create(nil);
     AStringList := TStringList.Create;
     AProcess.CommandLine := '';
     AProcess.Options := AProcess.Options + [poWaitOnExit, poUsePipes];
     AProcess.Execute;
     AStringList.LoadFromStream(AProcess.Output);
     Lu:=AStringList.Strings[0];
     AProcess.Free;
     AStringList.Free;
     fileconf:=(Lu+'/Conf.ini');
     LangLu:=Lu+'/locale/';
  {$ELSE}
     Lu := ExtractFilePath(ParamStr(0));
     fileconf:=(Lu+'Conf.ini');
     LangLu:=Lu+'locale\';
  {$ENDIF}
  global.ww := 640;
  global.hh := 480;
  global.GetSysDefaultEncodeing();
  lang:='en';
  FallbackLang:='en';
  if global.MYDefaultTextEncoding = 'cp936' then   lang :='zh';
  LCLGetLanguageIDs(Lang,FallbackLang); // in unit LCLProc
  if lang = 'ch_CH' then lang:='zh';
  if FallbackLang = 'ch' then FallbackLang:='zh';
  if global.MYDefaultTextEncoding='cp950' then
  begin
      lang:='big5';
  end;
  if FileExists(fileconf) then
  begin
   Conffile := TInifile.Create(fileconf) ;
   try
     lang:= Conffile.ReadString(Environment,'Lang',lang);
     FallbackLang:= Conffile.ReadString(Environment,'FallbackLang',FallbackLang);
     global.ww:= Conffile.ReadInteger(Environment,'width',640);
     global.hh:= Conffile.ReadInteger(Environment,'height',480);;
   finally
     Conffile.Free;
   end;
  end;
  if Lang = 'Default' then
  begin
    LCLGetLanguageIDs(Lang,FallbackLang);
    if lang = 'ch_CH' then lang:='zh';
    if FallbackLang = 'ch' then FallbackLang:='en';

    if global.MYDefaultTextEncoding='cp950' then
    begin
      lang:='big5';
      FallbackLang:='en'
    end;
  end;
  if    (global.ww < 160) or (global.hh < 120) then
  begin
       global.ww := 640;
       global.hh := 480;
  end;


 Translations.TranslateUnitResourceStrings('Global',
                      'locale/CamMirror.%s.po',Lang,FallbackLang);
end;
begin
  TranslateLCL;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  //Application.CreateForm(TfrmMirror, frmMirror);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.

