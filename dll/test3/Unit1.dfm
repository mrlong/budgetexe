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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 6
    Top = 8
    Width = 107
    Height = 25
    Caption = #36830#25509#26381#21153#22120
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 119
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'localhost'
  end
  object Edit2: TEdit
    Left = 119
    Top = 35
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
  object Button4: TButton
    Left = 152
    Top = 408
    Width = 75
    Height = 25
    Caption = 'JSON'#30340#35835#20889
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 246
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Memo2: TMemo
    Left = 246
    Top = 8
    Width = 257
    Height = 48
    TabOrder = 8
  end
end
