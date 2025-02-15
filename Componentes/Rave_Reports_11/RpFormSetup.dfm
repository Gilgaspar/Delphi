object RPSetupForm: TRPSetupForm
  Left = 434
  Top = 222
  BorderStyle = bsDialog
  Caption = 'Output Options'
  ClientHeight = 242
  ClientWidth = 295
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object bbtnOK: TButton
    Left = 209
    Top = 52
    Width = 75
    Height = 25
    Caption = '   OK   '
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
    OnClick = bbtnOKClick
  end
  object CancelBB: TButton
    Left = 209
    Top = 84
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
  end
  object SetupBB: TButton
    Left = 209
    Top = 116
    Width = 75
    Height = 25
    Caption = '&Setup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = SetupBBClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 3
    Width = 281
    Height = 36
    Caption = 'Selected Printer'
    TabOrder = 3
    object PrinterLabel: TLabel
      Left = 10
      Top = 15
      Width = 250
      Height = 13
      AutoSize = False
      Caption = '(none)'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 167
    Width = 184
    Height = 65
    Caption = 'Options'
    TabOrder = 4
    object CopiesLabel: TLabel
      Left = 17
      Top = 19
      Width = 33
      Height = 14
      Caption = '&Copies'
    end
    object CopiesED: TEdit
      Left = 18
      Top = 35
      Width = 49
      Height = 22
      TabOrder = 0
      OnKeyPress = FormKeyPress
    end
    object CollateCK: TCheckBox
      Left = 115
      Top = 17
      Width = 51
      Height = 17
      Caption = 'C&ollate'
      TabOrder = 1
    end
    object DuplexCK: TCheckBox
      Left = 115
      Top = 40
      Width = 52
      Height = 17
      Caption = '&Duplex'
      TabOrder = 2
    end
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 40
    Width = 193
    Height = 121
    ActivePage = TabSheet1
    Style = tsButtons
    TabOrder = 5
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      TabVisible = False
      object DestGB: TGroupBox
        Left = 0
        Top = 0
        Width = 185
        Height = 111
        Align = alClient
        Caption = 'Report Destination'
        TabOrder = 0
        object FileNameSB: TSpeedButton
          Left = 160
          Top = 54
          Width = 20
          Height = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            0800000000000001000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
            A600000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000FFFF0003030000
            00000000FFFF000300FFFF000303000000000000FFFF000300FFFF0003030000
            00000000FFFF000300FFFF0003030000000000000000000300FFFF0003030303
            030303030303030300FFFF0003030000000000000000030300FFFF000300FFFF
            FFFFFFFFFFFF000300FFFF000300FFFFFFFFFFFFFFFF000300FFFF000300FFFF
            FFFFFFFFFFFF000300FFFF000300FFFFFFFFFFFFFFFF000300FFFF000300FFFF
            FFFFFFFFFFFF000000FFFF000300FFFFFFFFFFFFFFFF00FF00FFFF0000000000
            000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentFont = False
          OnClick = FileNameSBClick
        end
        object Label1: TLabel
          Left = 8
          Top = 82
          Width = 36
          Height = 14
          Caption = 'Format:'
        end
        object PrinterRB: TRadioButton
          Left = 8
          Top = 16
          Width = 153
          Height = 17
          Caption = '&Printer'
          TabOrder = 0
          OnClick = PrinterRBClick
        end
        object PreviewRB: TRadioButton
          Left = 8
          Top = 36
          Width = 153
          Height = 17
          Caption = 'Pre&view'
          TabOrder = 1
          OnClick = PrinterRBClick
        end
        object FileRB: TRadioButton
          Left = 8
          Top = 56
          Width = 153
          Height = 17
          Caption = '&File'
          TabOrder = 2
          OnClick = FileRBClick
        end
        object editFileName: TEdit
          Left = 46
          Top = 54
          Width = 113
          Height = 22
          TabOrder = 3
          OnChange = editFileNameChange
        end
        object cboxFormat: TComboBox
          Left = 46
          Top = 79
          Width = 134
          Height = 22
          Style = csDropDownList
          ItemHeight = 14
          ItemIndex = 0
          TabOrder = 4
          Text = 'Rave Format (NDR)'
          OnChange = cboxFormatChange
          Items.Strings = (
            'Rave Format (NDR)'
            'Native Printer Output')
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      TabVisible = False
      object RangeGB: TGroupBox
        Left = 0
        Top = 0
        Width = 185
        Height = 111
        Align = alClient
        Caption = 'Print Range'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object FromLabel: TLabel
          Left = 8
          Top = 84
          Width = 23
          Height = 13
          Caption = 'From'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SelectionLabel: TLabel
          Left = 8
          Top = 84
          Width = 44
          Height = 13
          Caption = 'Selection'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ToLabel: TLabel
          Left = 88
          Top = 84
          Width = 9
          Height = 13
          Caption = 'to'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SelectionED: TEdit
          Left = 56
          Top = 80
          Width = 105
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnKeyPress = SelectionEDKeyPress
        end
        object AllRB: TRadioButton
          Left = 8
          Top = 16
          Width = 153
          Height = 17
          Caption = 'All'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = AllRBClick
        end
        object SelectionRB: TRadioButton
          Left = 8
          Top = 36
          Width = 153
          Height = 17
          Caption = 'Selection'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = SelectionRBClick
        end
        object PagesRB: TRadioButton
          Left = 8
          Top = 56
          Width = 153
          Height = 17
          Caption = 'Pages'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = PagesRBClick
        end
        object FromED: TEdit
          Left = 40
          Top = 80
          Width = 41
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnKeyPress = FormKeyPress
        end
        object ToED: TEdit
          Left = 104
          Top = 80
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnKeyPress = FormKeyPress
        end
      end
    end
  end
  object dlogSave: TSaveDialog
    DefaultExt = 'ndr'
    Filter = 'All Files|*.*'
    Options = [ofOverwritePrompt, ofPathMustExist, ofNoReadOnlyReturn]
    Left = 240
    Top = 8
  end
end
