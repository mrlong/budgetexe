object Form1: TForm1
  Left = 200
  Top = 334
  Width = 712
  Height = 440
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 200
    Top = 320
    Width = 137
    Height = 13
    Caption = '10'#31186#19968#27425
  end
  object btn1: TBitBtn
    Left = 64
    Top = 40
    Width = 113
    Height = 25
    Caption = #36830#25509#26381#21153#22120
    TabOrder = 0
    OnClick = btn1Click
  end
  object edt1: TEdit
    Left = 200
    Top = 40
    Width = 257
    Height = 21
    TabOrder = 1
    Text = '192.168.1.104'
  end
  object edt2: TEdit
    Left = 200
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '1377'
  end
  object btn2: TButton
    Left = 64
    Top = 120
    Width = 113
    Height = 25
    Caption = #21457#36865#25968#25454
    TabOrder = 3
    OnClick = btn2Click
  end
  object mmo1: TMemo
    Left = 200
    Top = 120
    Width = 233
    Height = 161
    Lines.Strings = (
      'mmo1')
    TabOrder = 4
  end
  object btn3: TBitBtn
    Left = 64
    Top = 152
    Width = 113
    Height = 25
    Caption = #33719#21462#26381#21153#22120#26102#38388
    TabOrder = 5
    OnClick = btn3Click
  end
  object chk1: TCheckBox
    Left = 64
    Top = 296
    Width = 249
    Height = 17
    Caption = #27979#35797#21709#24212#30340#36895#24230
    TabOrder = 6
  end
  object edt3: TEdit
    Left = 200
    Top = 296
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '10'
  end
  object btn4: TButton
    Left = 359
    Top = 294
    Width = 75
    Height = 25
    Caption = #24320#22987#27979#35797
    TabOrder = 8
    OnClick = btn4Click
  end
  object idtcpclnt1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 0
    Left = 104
    Top = 80
  end
end
