object dm_PCM: Tdm_PCM
  Height = 480
  Width = 640
  object con_PCM: TFDConnection
    Params.Strings = (
      'Database=pcm'
      'User_Name=root'
      'Password=pcm'
      'Server=127.0.0.1'
      'Port=3307'
      'DriverID=MySQL')
    LoginPrompt = False
    BeforeConnect = con_PCMBeforeConnect
    Left = 408
    Top = 40
  end
  object qry_Work: TFDQuery
    Connection = con_PCM
    Left = 304
    Top = 224
  end
end
