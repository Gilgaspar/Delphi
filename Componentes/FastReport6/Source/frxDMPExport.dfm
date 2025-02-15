object frxDMPExportDialog: TfrxDMPExportDialog
  Left = 215
  Top = 168
  ActiveControl = OK
  BorderStyle = bsDialog
  Caption = 'Print'
  ClientHeight = 276
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  DesignSize = (
    481
    276)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 219
    Top = 236
    Width = 18
    Height = 16
    AutoSize = True
    Picture.Data = {
      07544269746D617036010000424D360100000000000076000000280000001200
      0000100000000100040000000000C00000000000000000000000100000001000
      000000000000000080000080000000808000800000008000800080800000C0C0
      C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00333333333333333333000000333333300033333333000000333330088800
      33333300000033300887888800333300000030088777888888003300000038F7
      777F888888880300000038F77FF7778888880300000038FFF779977788880300
      000038F77AA777770788030000003388F77777FF070033000000333388F8FFFF
      F0333300000033333388FFFFFF0333000000333333338FFFFFF0030000003333
      333338FFF8833300000033333333338883333300000033333333333333333300
      0000}
    Visible = False
  end
  object OK: TButton
    Left = 321
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Cancel: TButton
    Left = 401
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object PrinterL: TGroupBox
    Left = 4
    Top = 4
    Width = 473
    Height = 53
    Caption = 'Printer'
    TabOrder = 2
    object PrinterCB: TComboBox
      Left = 8
      Top = 20
      Width = 457
      Height = 22
      HelpContext = 142
      Style = csOwnerDrawFixed
      ItemHeight = 16
      TabOrder = 0
      OnClick = PrinterCBClick
      OnDrawItem = PrinterCBDrawItem
    end
  end
  object EscL: TGroupBox
    Left = 4
    Top = 60
    Width = 261
    Height = 53
    Caption = 'Command type'
    TabOrder = 3
    object EscCB: TComboBox
      Left = 8
      Top = 20
      Width = 244
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object CopiesL: TGroupBox
    Left = 272
    Top = 60
    Width = 205
    Height = 53
    Caption = 'Copies'
    TabOrder = 4
    object CopiesNL: TLabel
      Left = 8
      Top = 20
      Width = 101
      Height = 13
      AutoSize = False
      Caption = 'Number of copies'
    end
    object CopiesE: TEdit
      Left = 116
      Top = 16
      Width = 37
      Height = 21
      MaxLength = 5
      TabOrder = 0
      Text = '1'
    end
    object CopiesUD: TUpDown
      Left = 153
      Top = 16
      Width = 16
      Height = 21
      Associate = CopiesE
      Min = 1
      Max = 9999
      Position = 1
      TabOrder = 1
    end
  end
  object PagesL: TGroupBox
    Left = 4
    Top = 116
    Width = 261
    Height = 121
    Caption = 'Pages'
    TabOrder = 5
    object DescrL: TLabel
      Left = 8
      Top = 84
      Width = 249
      Height = 29
      AutoSize = False
      Caption = 
        'Enter page numbers and/or page ranges, separated by commas. For ' +
        'example, 1,3,5-12'
      WordWrap = True
    end
    object AllRB: TRadioButton
      Left = 8
      Top = 20
      Width = 125
      Height = 17
      HelpContext = 108
      Caption = 'All'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object CurPageRB: TRadioButton
      Left = 8
      Top = 40
      Width = 125
      Height = 17
      HelpContext = 118
      Caption = 'Current page'
      TabOrder = 1
    end
    object PageNumbersRB: TRadioButton
      Left = 8
      Top = 60
      Width = 77
      Height = 17
      HelpContext = 124
      Caption = 'Pages:'
      TabOrder = 2
    end
    object RangeE: TEdit
      Left = 88
      Top = 60
      Width = 165
      Height = 21
      TabOrder = 3
      OnEnter = RangeEEnter
    end
  end
  object OptionsL: TGroupBox
    Left = 272
    Top = 116
    Width = 205
    Height = 121
    Caption = 'Options'
    TabOrder = 6
    object SaveToFileCB: TCheckBox
      Left = 8
      Top = 20
      Width = 185
      Height = 17
      Caption = 'Print to file'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object PageBreaksCB: TCheckBox
      Left = 8
      Top = 44
      Width = 185
      Height = 13
      Caption = 'Page breaks'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object OemCB: TCheckBox
      Left = 8
      Top = 64
      Width = 185
      Height = 17
      Caption = 'OEM codepage'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object PseudoCB: TCheckBox
      Left = 8
      Top = 86
      Width = 185
      Height = 17
      Caption = 'Pseudographic'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.prn'
    Left = 248
    Top = 232
  end
end
