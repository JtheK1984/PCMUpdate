unit PCM.Main;

interface

uses
  {$Region Uses}
  SYSTEM.uitypes, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ImgList, Vcl.Menus, NTTranslator, Strutils, DateUtils,shellapi, Vcl.Themes,
  FireDAC.Phys.ADSDef, FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.Phys.ADS,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.DBChart, cxGeometry, cxVariants, dxCustomData,
  cxCustomCanvas, dxCoreGraphics, dxChartCore, dxChartData, dxChartLegend,
  dxChartSimpleDiagram, dxChartXYDiagram, dxChartXYSeriesLineView,
  dxChartXYSeriesAreaView, dxChartMarkers, dxChartXYSeriesBarView,
  dxChartDBData, dxCoreClasses, dxChartControl, VCLTee.TeeDBCrossTab,
  cxGridChartView, cxPivotGridChartConnection, cxCustomPivotGrid, cxDBPivotGrid,
  dxBarExtItems, cxBarEditItem,
  cxSplitter, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxEdit, cxClasses, System.ImageList, cxContainer, dxBarBuiltInMenu,
  Vcl.ExtCtrls, cxPC, dxNavBarCollns, dxNavBarBase, dxNavBar,
  dxBar, cxLocalization, cxLabel, cxGroupBox, dxNavBarStyles,inifiles,
  dxUIAClasses;
  {$EndRegion Uses}
type
  {$Region Type}
  TdxBarControlAccess = class(TdxBarControl);
  TdxBarAccess = class(TdxBar);
  TdxBarManagerAccess = class(TdxBarManager);


  TMethod = procedure of object;
  TModuleType = (mtForm, mtEvent);
  TModule = class(TCollectionItem)
  protected
    FFormClass: TFormClass;
    FInstance: Pointer;
    FEvent: TMethod;
    FType: TModuleType;
    FRight: Integer;
    FModuleName: String;
    FImageIndex: Integer;

    procedure SetFormClass(Value: TFormClass);
    procedure SetEvent(Value: TMethod);
  public
    property FormClass: TFormClass read FFormClass write SetFormClass;
    property Instance: Pointer read FInstance write FInstance;
    property Event: TMethod read FEvent write SetEvent;
    property Typ: TModuleType read FType;
    property Right: Integer read FRight write FRight;
    property ModuleName: String read FModuleName write FModuleName;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
  end;

  Tfrm_PCM_Main = class(TForm)
    brmgr_main: TdxBarManager;
    brstc_OpenModule: TdxBarStatic;
    brstc_User: TdxBarStatic;
    btn_CloseModul: TdxBarLargeButton;
    btn_Modulleiste: TdxBarLargeButton;
    btn_RefreshRights: TdxBarLargeButton;
    grpbx_Design: TcxGroupBox;
    iAbmelden: TdxNavBarItem;
    iUpdate: TdxNavBarItem;
    iBeenden: TdxNavBarItem;
    iBenutzerverwaltung: TdxNavBarItem;
    iDesign: TdxNavBarItem;
    iHandbuch: TdxNavBarItem;
    iInfo: TdxNavBarItem;
    img_Icons: TImageList;
    iSprache: TdxNavBarItem;
    iSysteminfo: TdxNavBarItem;
    lafCtrl_Main: TcxLookAndFeelController;
    loc_Lang: TcxLocalizer;
    navbr_main: TdxNavBar;
    navbrgrp_Info: TdxNavBarGroup;
    navbrgrp_Optionen: TdxNavBarGroup;
    navbrgrp_Programm: TdxNavBarGroup;
    navbrit_ChangePW: TdxNavBarItem;
    navbrStyleIt_main: TdxNavBarStyleItem;
    nb_Medien: TdxNavBarGroup;
    pc_main: TcxPageControl;
    ppm_Main: TPopupMenu;
    ppmbtn_Abmelden: TMenuItem;
    ppmbtn_Beenden: TMenuItem;
    ppmbtn_Benutzer: TMenuItem;
    ppmbtn_Handbuch: TMenuItem;
    ppmbtn_Info: TMenuItem;
    ppmbtn_Konfiguration: TMenuItem;
    ppmbtn_Music: TMenuItem;
    ppmbtn_Sprache: TMenuItem;
    ppmbtn_Systeminfo: TMenuItem;
    ppmbtn_Trenn1: TMenuItem;
    ppmbtn_Trenn2: TMenuItem;
    ppmbtn_Trenn6: TMenuItem;
    tb_Main: TdxBar;
    trayic_Main: TTrayIcon;
    procedure btn_CloseModulClick(Sender: TObject);
    procedure btn_ModulleisteClick(Sender: TObject);
    procedure btn_RefreshRightsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure iSpracheClick(Sender: TObject);
    procedure NavBarClick(Sender: TObject);
    procedure pc_mainPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure ppmbtn_AbmeldenClick(Sender: TObject);
    procedure ppmbtn_BeendenClick(Sender: TObject);
    procedure ppmbtn_BenutzerClick(Sender: TObject);
    procedure ppmbtn_HandbuchClick(Sender: TObject);
    procedure ppmbtn_InfoClick(Sender: TObject);
    procedure ppmbtn_MusicClick(Sender: TObject);
    procedure ppmbtn_SpracheClick(Sender: TObject);
    procedure ppmbtn_SysteminfoClick(Sender: TObject);
  private
    { Private-Deklarationen }

  public
    { Public-Deklarationen }
    bStyle: boolean;
    bAbmelden: Boolean;
    Modules: TCollection;
    function CurrentModule: TForm;
    procedure Abmelden;
    procedure CloseModules;
    procedure LoadData;
    procedure RegisterNavBarItems;
  end;
  {$EndRegion Type}
var
  frm_PCM_Main: Tfrm_PCM_Main;

implementation

{$R *.dfm}

uses  PCM.Benutzerverwaltung,
      PCM.Data,
      PCM.Design,
      PCM.Functions,
      PCM.Functions.Appinfo,
      PCM.Functions.ChangePW,
      PCM.Functions.Languages,
      PCM.Functions.Lizenz,
      PCM.Functions.Login,
      PCM.Functions.Synch.Wait,
      PCM.Handbuch,
      PCM.Helper,
      PCM.Update,
      PCM.SQL,
			PCM.Strings, PCM.splash;

////////////////////////////////////////////////////////////////////////////////
// Hilfsfunktionen                                                            //
////////////////////////////////////////////////////////////////////////////////
{$Region Helperfunctions}
function Tfrm_PCM_Main.CurrentModule: TForm;
begin
  if pc_Main.ControlCount > 0 then
    Result := TForm(pc_Main.ActivePage.Controls[0])
  else
    Result := nil;
end;
procedure TModule.SetEvent(Value: TMethod);
begin
  if @Value <> @FEvent then
  begin
    FEvent := Value;
    FType := mtEvent;
  end;
end;
procedure TModule.SetFormClass(Value: TFormClass);
begin
  if Value <> FFormClass then
  begin
    FFormClass := Value;
    FType := mtForm;
  end;
end;
procedure Tfrm_PCM_Main.Abmelden;
begin
  bAbmelden := True;
  dm_PCM.bLogin := false;
  dm_PCM.bStyle:= false;
  Hide;
  Show;
end;
procedure Tfrm_PCM_Main.CloseModules;
var
  iPage: Integer;
begin
  for iPage := pc_Main.PageCount - 1 downto 1 do
  begin
    try
      TForm(pc_Main.Pages[iPage].Controls[0]).Close;
      TForm(pc_Main.Pages[iPage].Controls[0]).Free;
    except
    end;
    pc_Main.Pages[iPage].Free;
  end;
end;
procedure Tfrm_PCM_Main.LoadData;
begin
  dm_PCM.qry_Work.SQL.Text:= ASSQL_GetUsername[dm_PCM.iDBType];
  dm_PCM.qry_Work.ParamByName('ID').AsInteger:= dm_PCM.iIDBenutzerPCM;
  dm_PCM.qry_Work.Open;
  brstc_User.Caption:= dm_PCM.qry_Work.FieldByName('Benutzer').AsString;
  dm_PCM.qry_Work.Close;
end;
procedure Tfrm_PCM_Main.RegisterNavBarItems;
  procedure RegisterForm(SideBarItemName: string; FormClass: TFormClass; Instance: Pointer; Right: Integer);
  var
    NewModule: TModule;
    Item: TdxNavBarItem;
  begin
    Item := navbr_main.Items.Items[navbr_main.Items.ItemByName(SideBarItemName).index];
    if Assigned(Item) then
    begin
      NewModule := TModule(Modules.Add);
      Item.Tag := NewModule.ID;
      NewModule.FormClass := FormClass;
      NewModule.Instance := Instance;
      NewModule.Right := Right;
      NewModule.ModuleName := SideBarItemName;
      NewModule.ImageIndex := Item.SmallImageIndex;
    end;
  end;
  procedure RegisterEvent(SideBarItemName: string; Event: TMethod);
  var
    NewModule: TModule;
    Item: TdxNavBarItem;
  begin
    Item := navbr_main.Items.Items[navbr_main.Items.ItemByName(SideBarItemName).index];
    if Assigned(Item) then
    begin
      NewModule := TModule(Modules.Add);
      Item.Tag := NewModule.ID;
      NewModule.Event := Event;
      NewModule.ModuleName := SideBarItemName;
    end
  end;
begin
  Modules.Clear;
  RegisterForm('iBenutzerverwaltung', Tfrm_PCM_User, @frm_PCM_User, 1);
  RegisterForm('iDesign', Tfrm_PCM_Design, @frm_PCM_Design, 1);
  RegisterForm('iUpdate', Tfrm_Update, @frm_Update,1);
  RegisterForm('iSysteminfo',Tfrm_PCM_System, @frm_PCM_System, 1);
  RegisterForm('iInfo',Tfrm_PCM_InfoApp, @frm_PCM_InfoApp, 1);
  RegisterForm('iHandbuch',Tfrm_PCM_Handbuch,@frm_PCM_Handbuch, 1);
  RegisterEvent('iAbmelden', Abmelden);
  RegisterEvent('iBeenden', Close);
end;
{$EndRegion Helperfunctions}
////////////////////////////////////////////////////////////////////////////////
// Toolbar                                                                    //
////////////////////////////////////////////////////////////////////////////////
{$Region Toolbar}
procedure Tfrm_PCM_Main.btn_CloseModulClick(Sender: TObject);
begin
  if pc_Main.PageCount > 0 then
  begin
    if pc_Main.PageCount = 1 then
      brstc_OpenModule.Caption := 'Bitte Modul wählen';
    TForm(pc_Main.ActivePage.Controls[0]).Close;
    TForm(pc_Main.ActivePage.Controls[0]).Free;
    pc_Main.ActivePage.Free;
  end;
end;
procedure Tfrm_PCM_Main.btn_ModulleisteClick(Sender: TObject);
begin
  navbr_main.Visible := not navbr_main.Visible;
  if navbr_main.Visible then
    btn_Modulleiste.Caption := rs_PCM_Modulliste_verstecken
  else
    btn_Modulleiste.Caption := rs_PCM_Modulliste_anzeigen;
end;
procedure Tfrm_PCM_Main.btn_RefreshRightsClick(Sender: TObject);
var
  Item: TdxNavBarItem;
  Module: TModule;
begin
  btn_RefreshRights.Enabled := False;
  try
    if pc_Main.PageCount > 1 then
    begin
      Module := TModule(Modules.FindItemID(pc_Main.ActivePage.Tag));
      if Module.Typ = mtForm then
      begin
        Item := navbr_main.Items.Items[navbr_main.Items.ItemByName(Module.ModuleName).index];
        TForm(pc_Main.ActivePage.Controls[0]).Close;
        TForm(pc_Main.ActivePage.Controls[0]).Free;
        pc_Main.ActivePage.Free;
        NavBarClick(Item);
      end;
    end;
  finally
    btn_RefreshRights.Enabled := True;
  end;
end;
procedure Tfrm_PCM_Main.pc_mainPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  brstc_OpenModule.Caption := NewPage.Caption;
end;
{$EndRegion Toolbar}
////////////////////////////////////////////////////////////////////////////////
// Navbarfunktionen                                                           //
////////////////////////////////////////////////////////////////////////////////
{$Region Navbar}
procedure Tfrm_PCM_Main.iSpracheClick(Sender: TObject);
var
  iniFile: TIniFile;
begin
  Application.CreateForm(Tfrm_PCM_Language,frm_PCM_Language);
  frm_PCM_Language.Position:= poScreenCenter;
  frm_PCM_Language.ClientHeight:= 214;
  frm_PCM_Language.ShowModal;
  TNtTranslator.SetNew(dm_PCM.slocale,[],'de');
  TNtTranslator.TranslateForms;
  iniFile := TIniFile.Create(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCM.ini');
  try
    iniFile.WriteString(PCM_Logname, 'Language', dm_PCm.sLocale);
  finally
    iniFile.Free;
  end;
  Caption:= PCM_Programmname;
  trayic_Main.popupmenu:= ppm_Main;
  LoadData;
  btn_RefreshRightsClick(Self);
end;
procedure Tfrm_PCM_Main.NavBarClick(Sender: TObject);
var
  Module: TModule;
  fTabForm: TForm;
  iPageIndex: Integer;

  function TabExist(sTabName: String): Integer;
  var
    iCount: Integer;
  begin
    Result := -1;
    for iCount := 0 to pc_Main.PageCount -1 do
    begin
      if pc_Main.Pages[iCount].Name = sTabName then
      begin
        Result := iCount;
        Break;
      end;
    end;
  end;

  function CreateNewTabSheet(sTabName: String): Integer;
  var
    tshNew: TcxTabSheet;
  begin
    tshNew := TcxTabSheet.Create(pc_Main);
    tshNew.PageControl := pc_Main;
    tshNew.Name := sTabName;
    pc_Main.ActivePage := tshNew;
    Result := pc_Main.ActivePageIndex;
  end;
var
  sModul,sModulCaption: String;
begin
  if navbr_main.Enabled then
  begin
    navbr_main.Enabled := False;
    TRY
      Module := TModule(Modules.FindItemID((Sender AS TdxNavBarItem).Tag));
      if Assigned(Module) then
      begin
        sModul:= Module.ModuleName;
        sModulCaption:= Module.ModuleName;
        case AnsiIndexStr(sModul, ['iBenutzerverwaltung','iKonfiguration','iAudioplayer','iWebradio','iVideoplayer','iFotos','iSysteminfo','iInfo','iHandbuch']) of

        0:
          begin
            sModulCaption := 'i'  + rs_PCM_Benutzerverwaltung;
            dm_PCM.iModulTab:= 1;
          end;
        1:
          begin
            sModulCaption := 'i'  + rs_PCM_Konfiguration ;
            dm_PCM.iModulTab:= 1;
          end;
        2:
          begin
            sModul:= 'Mediacenter';
            sModulCaption := 'i'  + rs_PCMMediacenter_Musikplayer;
            dm_PCM.iModulTab:= 1;
          end;

        3:
          begin
            sModul:= 'Mediacenter';
            sModulCaption := 'i'  + rs_PCMMediacenter_Webradio;
            dm_PCM.iModulTab:= 2;
          end;
        4:
          begin
            sModul:= 'Mediacenter';
            sModulCaption := 'i'  + rs_PCMMediacenter_Videoplayer;
            dm_PCM.iModulTab:= 3;
          end;
        5:
          begin
            sModul:= 'Mediacenter';
            sModulCaption := 'i'  + rs_PCMMediacenter_Fotos;
            dm_PCM.iModulTab:= 4;
          end;
        6:
          begin
            sModulCaption := 'i'  + rs_PCM_Systeminformation;
            dm_PCM.iModulTab:= 3;
          end;
        7:
          begin
            sModulCaption := 'i'  + rs_PCM_Programminfo;
            dm_PCM.iModulTab:= 3;
          end;
				8:
					begin
            sModulCaption := 'i'  + rs_PCM_Handbuch;
            dm_PCM.iModulTab:= 3;
          end;
        end;
        iPageIndex := TabExist('tsh' + sModul);
        if iPageIndex > -1 then
        begin
          pc_Main.ActivePageIndex := iPageIndex;
          fTabForm := CurrentModule;
          if fTabForm <> nil then
            if not fTabForm.Focused then
              if Assigned(fTabForm.OnActivate) then
              begin
                fTabForm.OnActivate(Sender);
                brstc_OpenModule.Caption := Copy(sModulCaption, 2, Length(sModulCaption));
              end;
          Exit;
        end;
        if Module.Typ = mtForm then
        begin
          Screen.Cursor := crHourglass;
          try
            ShowWaitForm(TForm(Self), PWideChar('Formular wird geladen'), 1,417, 65);
            Application.ProcessMessages;
            WaitFormStep;
            TForm(Module.Instance^) := Module.FormClass.Create(Nil);
          finally
            Screen.Cursor := crDefault;
          end;
          fTabForm := TForm((Module.Instance)^);
          iPageIndex := CreateNewTabSheet('tsh' + sModul);
          fTabForm.Parent := pc_Main.Pages[iPageIndex];
          pc_Main.Pages[iPageIndex].Caption := Copy(sModulCaption, 2, Length(sModulCaption));
          pc_Main.Pages[iPageIndex].Tag := (Sender AS TdxNavBarItem).Tag;
          pc_Main.Pages[iPageIndex].ImageIndex := Module.ImageIndex;
          pc_Main.Pages[iPageIndex].InsertComponent(fTabForm);
          fTabForm.BorderStyle := bsNone;
          fTabForm.ALign:= AlClient;
          fTabForm.Enabled := True;
          fTabForm.Show;
       		CloseWaitform;
          brstc_OpenModule.Caption := Copy(sModulCaption, 2, Length(sModulCaption));
        end
        else
          if Module.Typ = mtEvent then
          begin
            Module.Event;
          end;
      end
    FINALLY
      navbr_main.Enabled := True;
      Application.ProcessMessages;
    END;
  end;
end;
{$EndRegion Navbar}
////////////////////////////////////////////////////////////////////////////////
// Formfunktionen                                                             //
////////////////////////////////////////////////////////////////////////////////
{$Region Formfunktionen}
procedure Tfrm_PCM_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseModules;
  WriteLog(PCM_Logname,rs_PCM_Beenden,0);
end;
procedure Tfrm_PCM_Main.FormCreate(Sender: TObject);
begin
  Modules := TCollection.Create(TModule);
end;
procedure Tfrm_PCM_Main.FormDestroy(Sender: TObject);
begin
  Modules.Free;
end;
procedure Tfrm_PCM_Main.FormHide(Sender: TObject);
begin
  CloseModules;
end;
procedure Tfrm_PCM_Main.FormKeyPress(Sender: TObject; var Key: Char);
var
  m: TForm;
begin
  m := CurrentModule;
  if m <> nil then
    if not m.Focused then
      if Assigned(m.OnKeyPress) then
        m.OnKeyPress(Sender, Key);
end;
procedure Tfrm_PCM_Main.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  m: TForm;
begin
  m := CurrentModule;
  if m <> nil then
    if not m.Focused then
      if Assigned(m.OnKeyUp) then
        m.OnKeyUp(Sender, Key, Shift);
end;
procedure Tfrm_PCM_Main.FormResize(Sender: TObject);
  procedure BarResize;
  var
    rRect: TRect;
    iTemp, iUsedSpace: Integer;
    BarControl: TdxBarControlAccess;
  begin
    if (brmgr_main.Bars[0] <> nil) and (brmgr_main.Bars[0].Control <> nil) then
    begin
      BarControl := TdxBarControlAccess(brmgr_main.Bars[0].Control);

      iUsedSpace := 0;

      brstc_OpenModule.Width := 0;

      for iTemp := 0 to BarControl.Bar.ItemLinks.Count - 1 do
      begin
        if BarControl.Bar.ItemLinks.Items[iTemp].Item = btn_Modulleiste then
        begin
          Inc(iUsedSpace, 0);
        end
        else
        begin
          if BarControl.Bar.ItemLinks.Items[iTemp].Item <> brstc_OpenModule then
          begin
            Inc(iUsedSpace, BarControl.Bar.ItemLinks.Items[iTemp].ItemRect.Width);
          end;
        end;
      end;

      if BarControl.MarkExists then
      begin
        rRect := BarControl.MarkRect;
        Inc(iUsedSpace, rRect.Right - rRect.Left);
      end;
       brmgr_main.BeginUpdate;
      Try
        brstc_OpenModule.Width := (brmgr_main.Bars[0].Control as TdxBarControl).Width -  iUsedSpace - btn_Modulleiste.Width  - 45;
      Finally
        brmgr_main.EndUpdate();
      End;
    end;
  end;
begin
  BarResize;
end;
procedure Tfrm_PCM_Main.FormShow(Sender: TObject);
begin
  {$ifdef WIn32}
  iSprache.Visible:= true;
  ppmbtn_Sprache.Visible:= true;
  {$endif}
  lafCtrl_Main.NativeStyle:= false;
  if (ParamStr(1) = '/s') then
  begin
    Application.CreateForm(Tfrm_update,frm_Update);
    frm_Update.bExecute.Click;
    Application.Terminate;
  end;
  dm_PCM.iDBType:= 0;
  if not ReadServerAdress then
  begin
    Application.Terminate;
  end
  else begin
  	lafCtrl_Main.SkinName:= dm_PCM.sDesign;
    SplashScreen := TSplashScreen.Create(nil);
    SplashScreen.Update;
    SplashScreen.Execute(dm_PCM.bStyle);
    if dm_PCM.bStyle then
    begin
      NavBarClick(iDesign);
    end
    else begin
      WriteLog(PCM_Logname,rs_PCM_Start,0);
    end;
  end;
end;
{$EndRegion Formfunktionen}
////////////////////////////////////////////////////////////////////////////////
// Traymenü                                                                   //
////////////////////////////////////////////////////////////////////////////////
{$Region Traymenu}
procedure Tfrm_PCM_Main.ppmbtn_BenutzerClick(Sender: TObject);
begin
  navbarclick(iBenutzerverwaltung);
  WindowState:= TWindowState.wsMaximized;
  SetForegroundWindow(frm_PCM_main.Handle);
end;
procedure Tfrm_PCM_Main.ppmbtn_MusicClick(Sender: TObject);
begin
//  navbarclick(iAudioplayer);
  WindowState:= TWindowState.wsMaximized;
  SetForegroundWindow(frm_PCM_main.Handle);
end;
procedure Tfrm_PCM_Main.ppmbtn_SysteminfoClick(Sender: TObject);
begin
  navbarclick(iSysteminfo);
  WindowState:= TWindowState.wsMaximized;
  SetForegroundWindow(frm_PCM_main.Handle);
end;
procedure Tfrm_PCM_Main.ppmbtn_InfoClick(Sender: TObject);
begin
  navbarclick(iInfo);
  WindowState:= TWindowState.wsMaximized;
  SetForegroundWindow(frm_PCM_main.Handle);
end;
procedure Tfrm_PCM_Main.ppmbtn_HandbuchClick(Sender: TObject);
begin
  navbarclick(iHandbuch);
  WindowState:= TWindowState.wsMaximized;
  SetForegroundWindow(frm_PCM_main.Handle);
end;
procedure Tfrm_PCM_Main.ppmbtn_SpracheClick(Sender: TObject);
begin
  navbarclick(iSprache);
  WindowState:= TWindowState.wsMaximized;
  SetForegroundWindow(frm_PCM_main.Handle);
end;
procedure Tfrm_PCM_Main.ppmbtn_AbmeldenClick(Sender: TObject);
begin
  Abmelden
end;
procedure Tfrm_PCM_Main.ppmbtn_BeendenClick(Sender: TObject);
begin
  Close;
end;
{$EndRegion Traymenu}
end.


