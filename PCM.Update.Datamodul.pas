unit PCM.Update.Datamodul;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXMySQL, Data.FMTBcd, Data.DB,
  Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,inifiles;

type
  Tfrm_DB = class(TForm)
    con_PCManager: TFDConnection;
    qPCManager: TFDQuery;
    con_Notenrechner: TFDConnection;
    qNotenrechner: TFDQuery;
    con_Vokabel: TFDConnection;
    qVokabel: TFDQuery;
    con_Lizenz: TFDConnection;
    qService: TFDQuery;
    con_mp3: TFDConnection;
    qmp3: TFDQuery;
    con_Service: TFDConnection;
    con_WebRadio: TFDConnection;
    qWebradio: TFDQuery;
    qLizenz: TFDQuery;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure ReadServerAdress;
  end;

var
  frm_DB: Tfrm_DB;

implementation

{$R *.dfm}

uses 
	PCM.Helper,PCM.Update.Strings;
	
procedure Tfrm_DB.ReadServerAdress;
var
  iniFile: TIniFile;
  sServer: String;
begin
  iniFile:=TIniFile.create(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCM.ini');
  sServer:= iniFile.ReadString('PCM','Server','localhost');
  iniFile.Free;

  try
    con_PCManager.Params.Values['Server'] := sServer;
    con_Notenrechner.Params.Values['Server'] := sServer;
    con_Vokabel.Params.Values['Server'] := sServer;
    con_mp3.Params.Values['Server'] := sServer;
    con_Service.Params.Values['Server'] := sServer;
    con_WebRadio.Params.Values['Server'] := sServer;
    con_Lizenz.Params.Values['Server'] := sServer;

    con_PCManager.Connected:= True;
    con_Notenrechner.Connected:= True;
    con_Vokabel.Connected:= True;
    con_mp3.Connected:= True;
    con_Service.Connected:= True;
    con_WebRadio.Connected:= True;
  except
		SetMessageDialog(2,'Es konnte keine Verbindung zur Datenbank hergestellt werden.'
    + 'Bitte überprüfen Sie die Serveraddresse in der Konfigurationsdatei:' + sLineBreak + GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCM.ini.' + sLineBreak
    + 'Das Programm wird beendet.',[rs_general_BTN_ok,'',''],[mrOk,mrNone,mrNone]);
    Application.Terminate;
  end;
  try
    con_Lizenz.Connected:= True;
  except
  end;
end;

procedure Tfrm_DB.FormCreate(Sender: TObject);
begin
  ReadServerAdress;
end;

end.
