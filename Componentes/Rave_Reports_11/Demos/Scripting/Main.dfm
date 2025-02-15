object Form1: TForm1
  Left = 200
  Top = 107
  Caption = 'Form1'
  ClientHeight = 172
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 96
    Top = 16
    Width = 145
    Height = 25
    Caption = 'Simple Table Listing'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 48
    Width = 145
    Height = 25
    Caption = 'Highlighting Sample'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 96
    Top = 80
    Width = 145
    Height = 25
    Caption = 'Line Count Table Report'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 96
    Top = 112
    Width = 145
    Height = 25
    Caption = 'GotoPage Sample'
    TabOrder = 3
    OnClick = Button4Click
  end
  object RvProject1: TRvProject
    ProjectFile = 'RaveDemo.rav'
    Left = 24
    Top = 24
  end
end
