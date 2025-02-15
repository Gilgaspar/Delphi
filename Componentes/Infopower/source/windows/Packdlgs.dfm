object GetTablesForm: TGetTablesForm
  Left = 219
  Top = 222
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Select Tables to Pack'
  ClientHeight = 313
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 429
    Height = 253
    Shape = bsFrame
    IsControl = True
  end
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 59
    Height = 13
    Caption = 'Database:'
  end
  object Label2: TLabel
    Left = 24
    Top = 60
    Width = 99
    Height = 13
    Caption = 'Available Tables:'
  end
  object Label3: TLabel
    Left = 252
    Top = 20
    Width = 97
    Height = 13
    Caption = 'Selected Tables:'
  end
  object OKBtn: TBitBtn
    Left = 232
    Top = 276
    Width = 77
    Height = 27
    TabOrder = 0
    Kind = bkOK
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 332
    Top = 276
    Width = 77
    Height = 27
    TabOrder = 1
    Kind = bkCancel
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object TableListBox: TListBox
    Left = 24
    Top = 76
    Width = 165
    Height = 173
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 2
    OnDblClick = TableListDblClick
  end
  object DBListBox: TComboBox
    Left = 24
    Top = 32
    Width = 169
    Height = 21
    Hint = 'Select the Database Alias'
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = 'DBListBox'
    OnChange = DBListBoxClick
  end
  object SelectedTables: TListBox
    Left = 252
    Top = 36
    Width = 169
    Height = 213
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 4
    OnClick = SelectedTablesClick
    OnDblClick = SelectedTablesDblClick
  end
  object IncludeBtn: TBitBtn
    Left = 200
    Top = 88
    Width = 41
    Height = 28
    TabOrder = 5
    OnClick = IncludeBtnClick
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000017000000120000000100
      040000000000D800000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777777707777777777777777777777707777777777777FF7777777707777
      77777777F00F77777770777777777777F000F7777771777777777777F0000F77
      77717FFFFFFFFFFFF00000F777717F00000000000000000F77717F0000000000
      00000000F7717F00000000000000000007717F00000000000000000077707F00
      0000000000000007777077777777777770000077777077777777777770000777
      7770777777777777700077777770777777777777700777777770777777777777
      777777777770777777777777777777777770}
  end
  object ExcludeBtn: TBitBtn
    Left = 200
    Top = 122
    Width = 41
    Height = 28
    TabOrder = 6
    OnClick = ExcludeBtnClick
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000018000000120000000100
      040000000000D800000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      77777777777777777777777777777777777777777777FF777777777777777777
      777F00F7777777777777777777F000F777777777777777777F0000F777777777
      77777777F00000FFFFFFFFFFFF77777F00000000000000000F7777F000000000
      000000000F777F0000000000000000000F77777000000000000000000F777777
      00000000000000000F7777777000007777777777777777777700007777777777
      7777777777700077777777777777777777770077777777777777777777777777
      777777777777777777777777777777777777}
  end
end
