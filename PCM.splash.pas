unit PCM.splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.ExtCtrls,
  dxGDIPlusClasses, dxActivityIndicator, cxContainer, cxEdit, cxProgressBar,
  cxImage, cxLabel, cxGroupBox, cxClasses, inifiles, dxUIAClasses;

type
  TSplashScreen = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    Timer5: TTimer;
    Timer6: TTimer;
    Panel1: TPanel;
    img_Splash: TImage;
    ActivityIndicator: TdxActivityIndicator;
    lbl_Progname: TcxLabel;
    lbl_ProgVersion: TcxLabel;
    prgbr_Splash: TcxProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    bRestart: boolean;
    function Execute(ARestart: boolean): boolean;
    procedure SetAppVersion;
  end;

var
  SplashScreen: TSplashScreen;

implementation

{$R *.dfm}

uses
  PCM.Main,
  PCM.Data,
  PCM.Functions,
  PCM.Functions.Login,
  PCM.Helper,
  PCM.SQL,
  PCM.Strings;

procedure TSplashScreen.SetAppVersion;
var
  dwVerInfoSize: DWord;
  poiVerInfo: Pointer;
  dwVerValueSize: DWord;
  ffiVerValue: PVSFixedFileInfo;
  dwdDummy: DWord;
  Result: String;
  itest: integer;
begin
  dwVerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), dwdDummy);
  if dwVerInfoSize = 0 then
    exit;
  GetMem(poiVerInfo, dwVerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, dwVerInfoSize, poiVerInfo);
  VerQueryValue(poiVerInfo, '\', Pointer(ffiVerValue), dwVerValueSize);
  with ffiVerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(poiVerInfo, dwVerInfoSize);
  lbl_ProgVersion.Caption := 'Version ' + Result;
  lbl_Progname.Caption := PCM_Programmname;
  lbl_Progname.Left:= Round((1000 - 340) /2);
end;
function TSplashScreen.Execute(ARestart: boolean): boolean;
begin
  SetAppVersion;
  bRestart:= ARestart;
  if bRestart then
    prgbr_Splash.Properties.Max:= 1
  else
    prgbr_Splash.Properties.Max:= 6;
  prgbr_Splash.Properties.Text:= rs_Splash_Sprache;
  timer1.Enabled:= true;
  if ShowModal = mrOk then
  begin
    Result := True;
  end
  else begin
    Result := False;
  end;
  Release;
end;
procedure TSplashScreen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TSplashScreen.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  prgbr_Splash.Position:= prgbr_Splash.Position + 1;
  Application.ProcessMessages;
  frm_PCm_Main.loc_lang.LoadFromFile(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\cxLocalLang.ini');
  frm_PCm_Main.loc_lang.LanguageIndex := 1;
  if not bRestart then
  begin
    prgbr_Splash.Properties.Text:= rs_Splash_Login;
    Timer2.enabled:= true;
  end
  else begin
    ModalResult := mrOk;
  end;
  Application.ProcessMessages;
end;
procedure TSplashScreen.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  prgbr_Splash.Position:= prgbr_Splash.Position + 1;
  Application.ProcessMessages;
  if not frm_PCm_Main.bAbmelden then
    dm_PCM.bLogin := Autologin
  else
    dm_PCM.bLogin := false;
  if not dm_PCM.bLogin then
  begin
    Application.CreateForm(Tfrm_PCM_Login, frm_PCM_Login);
    dm_PCM.bLogin := frm_pcm_login.Login_User;
    frm_PCM_Login.Free;
  end;
  if not dm_PCM.bLogin then
    Application.Terminate;
  frm_PCm_Main.bAbmelden:= False;
  Application.ProcessMessages;
  prgbr_Splash.Properties.Text:= rs_Splash_Rechte;
  Timer3.Enabled:= true;
end;
procedure TSplashScreen.Timer3Timer(Sender: TObject);
begin
  Timer3.Enabled := False;
  prgbr_Splash.Position:= prgbr_Splash.Position + 1;
  Application.ProcessMessages;
  prgbr_Splash.Properties.Text:= rs_Splash_Konfig;
  Timer4.Enabled:= true;
end;
procedure TSplashScreen.Timer4Timer(Sender: TObject);
begin
  Timer4.Enabled := False;
  prgbr_Splash.Position:= prgbr_Splash.Position + 1;
  frm_pcm_main.LoadData;
  Application.ProcessMessages;
  prgbr_Splash.Properties.Text:= rs_Splash_MenuLaden;
  Timer5.Enabled:= true;
end;
procedure TSplashScreen.Timer5Timer(Sender: TObject);
begin
  Timer5.Enabled := False;
  prgbr_Splash.Position:= prgbr_Splash.Position + 1;
  frm_pcm_Main.Caption:= PCM_Programmname;
  frm_pcm_Main.trayIC_Main.PopupMenu:= frm_pcm_Main.ppm_main;
  if dm_PCM.bDemo then
    frm_pcm_main.Caption:=PCM_Programmname + rs_Function_Lizenz_LizenzGueltig + DateTostr(dm_PCM.dtGueltig);
  Application.ProcessMessages;
  prgbr_Splash.Properties.Text:= rs_Splash_MenuReg;
  Timer6.Enabled:= true;
end;
procedure TSplashScreen.Timer6Timer(Sender: TObject);
begin
  Timer6.Enabled := False;
  prgbr_Splash.Position:= prgbr_Splash.Position + 1;
  frm_pcm_Main.RegisterNavBarItems;
  Application.ProcessMessages;
  ModalResult := mrOk;
end;

end.
