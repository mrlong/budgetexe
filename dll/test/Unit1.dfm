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
    Text = '127.0.0.1'
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
  object idtcpclnt1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 0
    Left = 104
    Top = 80
  end
end
