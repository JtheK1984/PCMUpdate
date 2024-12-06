unit PCM.Data;

interface

uses
  System.SysUtils, System.Classes,inifiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Phys.ADSDef, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.Phys.ADS,
  FireDAC.Comp.DataSet,Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.Controls,
  cxImageList, cxGraphics, winapi.Windows,vcl.forms, System.UITypes;

type
  Tdm_PCM = class(TDataModule)
    con_PCM: TFDConnection;
    qry_Work: TFDQuery;
    procedure con_PCMBeforeConnect(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    iModulTab: integer;
    slocale: String;
    bNewLiceneCheck: boolean;
    bCLose: Boolean;
    bLogin: Boolean;
    bStyle: boolean;
    iIDBenutzerPCM: integer;
    iDBType: integer;
    sServer,sStyle,sDesign: String;
    int_optionenRight: integer;
    int_mp3Right: integer;
    Firma, Nummer: string;
    bDemo: boolean;
    bAppTerm: boolean;
    dtGueltig,dtCurrDate: Tdate;
    function ReadServerAdress: boolean;
  end;

var
  dm_PCM: Tdm_PCM;

const
  DB_MYSQL = 0;
  DB_MSSQL = 1;
  DB_ADS = 2;
  DB_FB = 3;

  {$IFDEF WIN64}
  PCM_Programmname = 'PCM - Update 64-Bit';
  {$else}
  PCM_Programmname = 'PCM - Update 32-Bit';
  {$ENDIF}
  PCM_Logname =  'PCMUpdate';
  PCM_Connectionname = 'MP3';
  PCM_Programmnummer = 5;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses PCM.Main;

function Tdm_PCM.ReadServerAdress: boolean;
var
  iniFile: TIniFile;
begin
  iniFile:=TIniFile.create(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCM.ini');
  sServer:= iniFile.ReadString('PCM','Server','localhost');
  sStyle:= iniFile.ReadString('PCMManager','Style','Windows10');
  sDesign:= iniFile.ReadString('PCMManager','Design','Basic');
  iDBType:= iniFile.ReadInteger('Database','Type',0);
  frm_PCM_Main.lafCtrl_Main.SkinName:= sDesign;
  iniFile.Free;

  try
    con_PCM.Params.Values['Server'] := sserver;
    con_PCM.Connected:= True;

    result:= true;
  except
    MessageDlg('Es konnte keine Verbindung zur Datenbank hergestellt werden.'
    + 'Bitte überprüfen Sie die Serveraddresse in der Konfigurationsdatei:' + sLineBreak + GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCM.ini.' + sLineBreak
    + 'Das Programm wird beendet.', mtError, [mbOk], 0);
    result:= false;
  end;
end;
procedure Tdm_PCM.con_PCMBeforeConnect(Sender: TObject);
begin
  con_PCM.LoginPrompt := False;
  con_PCM.Params.Clear;
  case iDBType of
    DB_MYSQL:
    begin
      con_PCM.Params.Add('Database=pcm');
      con_PCM.Params.Add('User_Name=root');
      con_PCM.Params.Add('Password=pcm');
      con_PCM.Params.Add('Server='+ sServer);
      con_PCM.Params.Add('Port=3307');
      con_PCM.Params.Add('DriverID=MySQL');
    end;
    DB_MSSQL:
    begin
      con_PCM.Params.Add('OSAuthent=No');
      con_PCM.Params.Add('User_Name=sa');
      con_PCM.Params.Add('Password=Nh2020+5');
      con_PCM.Params.Add('Server='+ sServer);
      con_PCM.Params.Add('Database=pcm');
      con_PCM.Params.Add('DriverID=MSSQL');
    end;
    DB_ADS:
     begin
      con_PCM.Params.Add('Alias=pcm');
      con_PCM.Params.Add('ServerTypes=REMOTE|LOCAL');
      con_PCM.Params.Add('User_Name=adssys');
      con_PCM.Params.Add('Password=pcm');
      con_PCM.Params.Add('DriverID=ADS');
     end;
  end;
end;



end.
