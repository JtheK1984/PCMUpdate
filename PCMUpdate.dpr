program PCMUpdate;

uses
  Vcl.Forms,
  inifiles,
  System.SysUtils,
  PCM.Main in 'PCM.Main.pas' {frm_Main},
  Vcl.Themes,
  Vcl.Styles,
  PCm.Update.XMLParse in 'Helper\PCm.Update.XMLParse.pas',
  PCM.Update.Libxml2 in 'Helper\PCM.Update.Libxml2.pas',
  PCM.DAta in 'PCM.DAta.pas' {dm_PCM: TDataModule};

{$R *.res}
var
  iniFile: TIniFile;
  sStyle: String;

begin
  iniFile:=TIniFile.create(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCM.ini');
  sStyle:= iniFile.ReadString('PCMManager','Style','Windows');
  iniFile.Free;

  Application.Initialize;
  TStyleManager.TrySetStyle(sStyle);
  Application.Title:= 'PCM - Update 32-Bit';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm_PCM, dm_PCM);
  Application.CreateForm(Tfrm_Main, frm_Main);
  Application.Run;
end.
