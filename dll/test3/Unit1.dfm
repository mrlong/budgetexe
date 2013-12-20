object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 528
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 40
    Width = 107
    Height = 25
    Caption = #36830#25509#26381#21153#22120
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 121
    Top = 42
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'localhost'
  end
  object Edit2: TEdit
    Left = 121
    Top = 69
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '1377'
  end
  object Button2: TButton
    Left = 8
    Top = 152
    Width = 107
    Height = 25
    Caption = #33719#21462#26381#21153#22120#26102#38388
    TabOrder = 3
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 121
    Top = 154
    Width = 200
    Height = 167
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object Button3: TButton
    Left = 8
    Top = 352
    Width = 107
    Height = 25
    Caption = #27979#35797#26159#21542#33021#19978#32593
    TabOrder = 5
    OnClick = Button3Click
  end
  object IdTCPClient1: TIdTCPClient
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 328
    Top = 24
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.CertFile = 'D:\git\budgetexe\keys\client1.crt'
    SSLOptions.KeyFile = 'D:\git\budgetexe\keys\client.key'
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 264
    Top = 336
  end
end
