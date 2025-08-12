program PCMUpdate;

uses
  inifiles,
  NtTranslator,
  System.SysUtils,
  uWVLoader,
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  PCM.Helper,
  Windows,
  PCM.Main in 'PCM.Main.pas' {frm_PCM_Main},
  PCM.DAta in 'PCM.DAta.pas' {dm_PCM: TDataModule},
  PCm.Update.XMLParse in 'Helper\PCm.Update.XMLParse.pas',
  PCM.Update.Libxml2 in 'Helper\PCM.Update.Libxml2.pas',
  PCM.splash in 'PCM.splash.pas' {SplashScreen},
  PCM.Update in 'Module\PCM.Update.pas' {frm_Update},
  PCMUpdate.dxSettings in 'PCMUpdate.dxSettings.pas',
  PCM.Update.Strings in 'Module\PCM.Update.Strings.pas';

{$R *.res}

{$IFDEF WIN64}
  {$R 'Versioninfo64.res'}
{$else}
  {$R 'Versioninfo32.res'}
{$ENDIF}

{$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE}
{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP or IMAGE_FILE_LARGE_ADDRESS_AWARE}

var
  ifini: TIniFile;
  slocale: String;

begin
  Checkinis;
  ifini:=TIniFile.create(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCM.ini');
  slocale:=ifini.ReadString('PCMUpdate','Language','de');
  ifini.Free;
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\CustomCache';
  GlobalWebView2Loader.StartWebView2;
  Application.Initialize;
  {$IFDEF WIN64}
  Application.Title:= 'PCM - Update 64-Bit';
  {$else}
  Application.Title:= 'PCM - Update 32-Bit';
  {$ENDIF}
  TNtTranslator.SetNew(slocale,[],'de');
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm_PCM, dm_PCM);
  Application.CreateForm(Tfrm_pcm_Main, frm_pcm_Main);
  Application.Run;
end.
