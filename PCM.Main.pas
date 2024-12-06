unit PCM.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMemo, cxClasses, cxProgressBar, Vcl.ExtCtrls,
  Vcl.StdCtrls, cxButtons, dxGDIPlusClasses, Data.FMTBcd,
  Data.DB, Data.SqlExpr,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, dxSkinsCore, dxSkinMetropolisDark,inifiles, cxLabel,
  cxGroupBox, dxSkinBasic, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinOffice2019Black,
  dxSkinOffice2019Colorful, dxSkinOffice2019DarkGray, dxSkinOffice2019White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringtime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinTheBezier, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, System.ImageList, Vcl.ImgList, cxImageList,PCM.Functions,
  dxSkinWXI;

type
  Tfrm_PCM_Main = class(TForm)
    Image1: TImage;
    bExecute: TcxButton;
    bClose: TcxButton;
    pbMain: TcxProgressBar;
    mLog: TcxMemo;
    cxGroupBox1: TcxGroupBox;
    Label1: TcxLabel;
    Label2: TcxLabel;
    lafCtrl_Main: TcxLookAndFeelController;
    panel1: TcxGroupBox;
    Label3: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    TrayIcon1: TTrayIcon;
    cxImageList1: TcxImageList;
    procedure bExecuteClick(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ASSQL_GET_Version: string;
    procedure CreateInsertTable(AQuery: TFDQuery);
    procedure ProcessDataBase(Alias: string);
  public
    iMajor_PCManager: integer;
    iMinor_PCManager: integer;
    iMajor_Notenrechner: integer;
    iMinor_Notenrechner: integer;
    iMajor_Vokabel: integer;
    iMinor_Vokabel: integer;
    iMajor_Lizenz: integer;
    iMinor_Lizenz: integer;
    iMajor_mp3: integer;
    iMinor_mp3: integer;
    iMajor_Service: integer;
    iMinor_Service: integer;
    iMajor_Webradio: integer;
    iMinor_Webradio: integer;
    procedure Log(s: string;iError: integer);
  end;

var
  frm_PCM_Main: Tfrm_PCM_Main;

  //  strlstLog: TStringList;

implementation

{$R *.dfm}

uses PCM.Update.XMLParse, PCM.Update.Datamodul,PCM.Data, PCM.Strings;
procedure Tfrm_PCM_Main.Log(s: string;iError: integer);
begin
  mLog.Lines.Add(s);
  WriteLog(PCM_Logname,s,iError);
end;
procedure Tfrm_PCM_Main.bCloseClick(Sender: TObject);
begin
  Close;
end;
procedure Tfrm_PCM_Main.CreateInsertTable(AQuery: TFDQuery);
var
  irc: integer;
begin
  AQuery.sql.text:=   'CREATE TABLE IF NOT EXISTS `VERSION_DB`(' +
                      ' `ID` int(1) NOT NULL AUTO_INCREMENT, ' +
                      ' `Major` int(11) NOT NULL DEFAULT ''0'', ' +
                      ' `Minor` int(11) NOT NULL DEFAULT ''0'', ' +
                      '  PRIMARY KEY (`ID`)); ';
  AQuery.ExecSQL;
  AQuery.sql.text:= 'Select Count(*) as Anzahl From Version_DB';
  AQuery.open;
  irc:= AQuery.FieldByName('Anzahl').AsInteger;
  AQuery.Close;
  if irc = 0 then
  begin
    AQuery.sql.text:= 'INSERT INTO `version_db`(Major,Minor) VALUES (1,0);';
    AQuery.ExecSQL;
  end;
end;
procedure Tfrm_PCM_Main.bExecuteClick(Sender: TObject);
//var
//  i: Integer;
begin
  bExecute.Enabled := False;
  bClose.Enabled := False;
  mLog.Clear;
  Log('MYSQL-Version prüfen...',0);
  Panel1.Visible := True;
  ClientHeight:=  399;
  Application.ProcessMessages;
  cxLabel1.Style.Font.Style:= [fsbold];
  cxLabel2.Style.Font.Style:= [];
  cxLabel3.Style.Font.Style:= [];
  Application.ProcessMessages;
  Sleep(500);
  CreateInsertTable(dm_PCM.qry_work);
  Application.ProcessMessages;
  cxLabel1.Style.Font.Style:= [];
  cxLabel2.Style.Font.Style:= [fsbold];
  cxLabel3.Style.Font.Style:= [];
  Application.ProcessMessages;
  Application.ProcessMessages;
  Log('Datenbankversionen abfragen...',0);
  Sleep(500);
  // PCMAnager
  dm_PCM.qry_work.sql.Text:= ASSQL_GET_Version;
  dm_PCM.qry_work.open;
  iMajor_PCManager:=dm_PCM.qry_work.FieldByName('Major').AsInteger;
  iMinor_PCManager:=dm_PCM.qry_work.FieldByName('Minor').AsInteger;
  dm_PCM.qry_work.Close;
  cxLabel1.Style.Font.Style:= [];
  cxLabel2.Style.Font.Style:= [];
  cxLabel3.Style.Font.Style:= [fsbold];
  Application.ProcessMessages;
  Log('Datenbankupdate ausführen...',0);
  Sleep(500);
  ProcessDatabase('PCM_MANAGER');
  cxLabel1.Style.Font.Style:= [];
  cxLabel2.Style.Font.Style:= [];
  cxLabel3.Style.Font.Style:= [];
  Application.ProcessMessages;
  bClose.Enabled := True;
end;
procedure Tfrm_PCM_Main.FormDestroy(Sender: TObject);
begin
  WriteLog(PCM_Logname,rs_PCM_Beenden,0);
end;
procedure Tfrm_PCM_Main.FormShow(Sender: TObject);
var
  iniFile: TIniFile;
  sDesign: String;
begin
  dm_PCm.ReadServerAdress;
  ASSQL_GET_Version:= 'Select Major, Minor From VERSION_DB';
  iniFile:=TIniFile.create(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCM.ini');
  sDesign:= iniFile.ReadString('PCMManager','Design','Basic');
  lafCtrl_Main.SkinName:= sDesign;
  iniFile.Free;

  WriteLog(PCM_Logname,rs_PCM_Start,0);
  if (ParamStr(1) = '/s') then
  begin
    bExecute.Click;
    Application.Terminate;
  end;
end;
procedure Tfrm_PCM_Main.ProcessDataBase(Alias: string);
var
  db: TZMIUpdateDatabase;
  i, j: Integer;
//  Major, Minor, Len: Word;
  nMajor, nMinor: Word;
  iMajor, iMinor: integer;
  Ver: TZMIUpdateVersion;
//  s: string;
begin

  Log('-- Update von Alias ' + Alias + ' --',0);
  Log('XML-Datei wird eingelesen...',0);
  db := ReadDatabase(Alias);
  nMajor := 0;
  nMinor := 0;
  if Assigned(db) then
  begin
    Log('Verbinde mit Datenbank...',0);
//    Len := 2;

    if Alias = 'PCM_MANAGER' then
    begin
      iMajor := iMajor_PCManager;
      iMinor := iMinor_PCManager;
      Log(Format('Datenbank hat Version %d.%d', [iMajor, iMinor]),0);
      for i := 0 to db.Versions.Count - 1 do
      begin
        Ver := TZMIUpdateVersion(db.Versions[i]);
        if (Ver.Major * 1000 + Ver.Minor > iMajor * 1000 + iMinor) then
        begin
          // neue Version aktualisieren
          if Ver.Major > nMajor then
          begin
            nMajor := Ver.Major;
            nMinor := Ver.Minor;
          end
          else if (Ver.Major = nMajor) and (Ver.Minor > nMinor) then
          begin
            nMinor := Ver.Minor;
          end;
          Log(Format('Update auf Version %d.%d (%s)...', [Ver.Major, Ver.Minor,Ver.Date]),0);
          for j := 0 to Ver.Statements.Count - 1 do
          begin
            TRY
              dm_PCM.qry_work.SQL.Text := Ver.Statements[j];
              dm_PCM.qry_work.ExecSQL;
            EXCEPT
              on E: Exception do
              begin
                Log(Format('FEHLER beim Ausführen von "%s": "%s"',[Ver.Statements[j], E.Message]),2);
              end;
            END;
          end;
        end;
      end;
      if (nMajor = 0) and (nMinor = 0) then
      begin
        Log('Die Datenbank ist bereits auf dem neuesten Stand!',0);
      end
      else
      begin
       // Update db
        Log(Format('Die Datenbank hat jetzt Version %d.%d!', [nMajor, nMinor]),0);
      end;
    end;
    //alle Versionen durchgehen
    Log('Fertig!',0);
    FreeAndNil(db);
  end
  else begin
    Log('Fehler im XML-Dokument!',2);
  end;
end;

end.
