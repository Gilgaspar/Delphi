object PackMain: TPackMain
  Left = 221
  Top = 87
  Hint = 'Click here to select tables'
  BorderStyle = bsDialog
  Caption = 'InfoPower - Pack Table Demo'
  ClientHeight = 259
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 228
    Top = 220
    Width = 120
    Height = 29
    Hint = 'Click here to pack the selected tables'
    Caption = 'Pack Tables'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
      FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
      FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
      FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
      FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
      FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
      C8807FF7777777777FF700000000000000007777777777777777333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 80
    Top = 220
    Width = 120
    Height = 29
    Caption = 'Select Tables'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00303333333333
      333337F3333333333333303333333333333337F33FFFFF3FF3FF303300000300
      300337FF77777F77377330000BBB0333333337777F337F33333330330BB00333
      333337F373F773333333303330033333333337F3377333333333303333333333
      333337F33FFFFF3FF3FF303300000300300337FF77777F77377330000BBB0333
      333337777F337F33333330330BB00333333337F373F773333333303330033333
      333337F3377333333333303333333333333337FFFF3FF3FFF333000003003000
      333377777F77377733330BBB0333333333337F337F33333333330BB003333333
      333373F773333333333330033333333333333773333333333333}
    NumGlyphs = 2
  end
  object TableList: TwwDBGrid
    Left = 0
    Top = 29
    Width = 441
    Height = 181
    IniAttributes.FileName = 'delphi32.ini'
    IniAttributes.SectionName = 'PackMainTableList'
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = wwDataSource1
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 121
    Height = 29
    BevelInner = bvLowered
    TabOrder = 3
    object AliasLabel: TLabel
      Left = 12
      Top = 8
      Width = 101
      Height = 13
      Caption = 'Selected Tables :'
    end
  end
  object Panel2: TPanel
    Left = 116
    Top = 0
    Width = 325
    Height = 29
    BevelInner = bvLowered
    TabOrder = 4
    object AliasName: TLabel
      Left = 8
      Top = 8
      Width = 31
      Height = 13
      Caption = 'None'
    end
  end
  object Button1: TButton
    Left = 172
    Top = 280
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object PackTable: TwwTable
    DatabaseName = 'InfoDemo5'
    SyncSQLByRange = True
    NarrowSearch = False
    ValidateWithMask = True
    Left = 336
    Top = 4
  end
  object wwDataSource1: TwwDataSource
    DataSet = ResultsTable
    Left = 364
    Top = 4
  end
  object ResultsTable: TwwTable
    SyncSQLByRange = True
    NarrowSearch = False
    ValidateWithMask = True
    Left = 392
    Top = 4
  end
end
