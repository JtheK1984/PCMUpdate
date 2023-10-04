object frm_DB: Tfrm_DB
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frm_DB'
  ClientHeight = 488
  ClientWidth = 517
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object con_PCManager: TFDConnection
    Params.Strings = (
      'Database=pcm_manager'
      'User_Name=root'
      'Password=pcm'
      'Server=127.0.0.1'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 8
  end
  object qPCManager: TFDQuery
    Connection = con_PCManager
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS `VERSION`'
      '(`Major` integer NOT NULL,'
      ' Minor integer NOT NULL)')
    Left = 168
    Top = 8
  end
  object con_Notenrechner: TFDConnection
    Params.Strings = (
      'Database=pcm_notenrechner'
      'User_Name=root'
      'Password=pcm'
      'Server=127.0.0.1'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 152
  end
  object qNotenrechner: TFDQuery
    Connection = con_Notenrechner
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS `VERSION`'
      '(`Major` integer NOT NULL,'
      ' Minor integer NOT NULL)')
    Left = 168
    Top = 152
  end
  object con_Vokabel: TFDConnection
    Params.Strings = (
      'Database=pcm_vokabeltrainer'
      'User_Name=root'
      'Password=pcm'
      'Server=127.0.0.1'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 248
  end
  object qVokabel: TFDQuery
    Connection = con_Vokabel
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS `VERSION`'
      '(`Major` integer NOT NULL,'
      ' Minor integer NOT NULL)')
    Left = 168
    Top = 248
  end
  object con_Lizenz: TFDConnection
    Params.Strings = (
      'Database=pcm_lizenzgenerator'
      'User_Name=root'
      'Password=pcm'
      'Server=127.0.0.1'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 56
  end
  object qService: TFDQuery
    Connection = con_Service
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS `VERSION`'
      '(`Major` integer NOT NULL,'
      ' Minor integer NOT NULL)')
    Left = 168
    Top = 200
  end
  object con_mp3: TFDConnection
    Params.Strings = (
      'Database=pcm_mp3'
      'User_Name=root'
      'Password=pcm'
      'Server=127.0.0.1'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 104
  end
  object qmp3: TFDQuery
    Connection = con_mp3
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS `VERSION`'
      '(`Major` integer NOT NULL,'
      ' Minor integer NOT NULL)')
    Left = 168
    Top = 104
  end
  object con_Service: TFDConnection
    Params.Strings = (
      'Database=pcm_service'
      'User_Name=root'
      'Password=pcm'
      'Server=127.0.0.1'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 200
  end
  object con_WebRadio: TFDConnection
    Params.Strings = (
      'Database=pcm_mediacenter'
      'User_Name=root'
      'Password=pcm'
      'Server=127.0.0.1'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 296
  end
  object qWebradio: TFDQuery
    Connection = con_WebRadio
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS `VERSION`'
      '(`Major` integer NOT NULL,'
      ' Minor integer NOT NULL)')
    Left = 168
    Top = 296
  end
  object qLizenz: TFDQuery
    Connection = con_Lizenz
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS `VERSION`'
      '(`Major` integer NOT NULL,'
      ' Minor integer NOT NULL)')
    Left = 168
    Top = 56
  end
end
