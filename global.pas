unit global;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,IniFiles,LConvEncoding;
const
  Environment='Environment';
var
  ww:integer;
  hh:integer;
  isMirrorShow:boolean;
  needCreateNewMirror:boolean;
  top_most : boolean;


  Lu,LangLu, fileconf: String;
  Lang, FallbackLang: String;
  IniReader : TIniFile;



  MYDefaultTextEncoding: String;

resourcestring
  nAppTitle = 'Cam Mirror Ver 1.05 Powered by Lazarus.';
  nLookForCam = 'looking for camera ... ';
  nShowMirror = 'Show mirror';
  nFullSceeen = 'Full Screen';
  nAbout = 'About';
  nExit = 'Exit';
  nScreenShot = 'Screen Shot';


  nTop ='Top';
  nTopMost = 'Top Most';
  nNormal = 'Normal';
  nResolution = 'Resolution';
  nHide = 'Hide';
  nExitApplication = 'Exit Application';
  nLanguagePrompt = 'you must restart this appliction to use new language.';
  nLanguages = 'Select Languages 选择语言 選擇語言';

  function GetSysDefaultEncodeing():String;
implementation
    function GetSysDefaultEncodeing():String;
begin
       MYDefaultTextEncoding:=GetDefaultTextEncoding();
       Result:= MYDefaultTextEncoding;
end;
function ToLocalString(ss : string) : String;
begin
    Result:=   LConvEncoding.ConvertEncoding(ss,EncodingUTF8,MYDefaultTextEncoding);
end;
end.

