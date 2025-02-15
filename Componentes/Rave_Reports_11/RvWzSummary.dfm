object SummaryForm: TSummaryForm
  Left = 252
  Top = 107
  BorderStyle = bsToolWindow
  Caption = 'Print Report Options'
  ClientHeight = 352
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelButtons: TPanel
    Left = 0
    Top = 311
    Width = 441
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 344
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Ok'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 254
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 441
    Height = 311
    ActivePage = TabSheetColors
    Align = alClient
    TabOrder = 1
    object TabSheetMain: TTabSheet
      Caption = 'Main'
      object ckboxPrintClassNames: TCheckBox
        Left = 26
        Top = 256
        Width = 97
        Height = 17
        Caption = 'Print Class Names'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object rgrpPropertyOptions: TRadioGroup
        Left = 26
        Top = 77
        Width = 377
        Height = 73
        Caption = 'Property Options'
        ItemIndex = 2
        Items.Strings = (
          'All Properties'
          'Changed Properties'
          'Changed Excluding Size and Position Changes')
        TabOrder = 1
      end
      object rgrpReportType: TRadioGroup
        Left = 26
        Top = 8
        Width = 377
        Height = 49
        Caption = 'Report Type'
        ItemIndex = 1
        Items.Strings = (
          'All Definitions'
          'Currently Active Report')
        TabOrder = 0
      end
      object rgrpEventOptions: TRadioGroup
        Left = 27
        Top = 166
        Width = 377
        Height = 73
        Caption = 'Event Options'
        ItemIndex = 0
        Items.Strings = (
          'Do NOT Print Events'
          'Print Events'
          'Print Events Only')
        TabOrder = 2
      end
    end
    object TabSheetColors: TTabSheet
      Caption = 'Colors'
      ImageIndex = 1
      object Label5: TLabel
        Left = 29
        Top = 28
        Width = 88
        Height = 13
        Caption = 'Component Name:'
      end
      object Label6: TLabel
        Left = 30
        Top = 80
        Width = 73
        Height = 13
        Caption = 'Property Name:'
      end
      object Label7: TLabel
        Left = 29
        Top = 54
        Width = 84
        Height = 13
        Caption = 'Component Type:'
      end
      object Label8: TLabel
        Left = 30
        Top = 106
        Width = 59
        Height = 13
        Caption = 'Event Code:'
      end
      object ColorBoxComponentName: TColorBox
        Left = 256
        Top = 24
        Width = 145
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 1
      end
      object ColorBoxPropertyName: TColorBox
        Left = 257
        Top = 76
        Width = 145
        Height = 22
        Selected = clTeal
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 5
      end
      object ckBoxComponentNameBold: TCheckBox
        Left = 204
        Top = 28
        Width = 45
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Bold'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object ckBoxPropertyNameBold: TCheckBox
        Left = 204
        Top = 77
        Width = 45
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Bold'
        TabOrder = 4
      end
      object ckboxComponentTypeBold: TCheckBox
        Left = 204
        Top = 54
        Width = 45
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Bold'
        TabOrder = 2
      end
      object ColorBoxComponentType: TColorBox
        Left = 256
        Top = 50
        Width = 145
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 3
      end
      object ckboxEventCodeBold: TCheckBox
        Left = 204
        Top = 103
        Width = 45
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Bold'
        TabOrder = 6
      end
      object ColorBoxEventCode: TColorBox
        Left = 257
        Top = 102
        Width = 145
        Height = 22
        Selected = clTeal
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 7
      end
    end
    object TabSheetMargins: TTabSheet
      Caption = 'Margins'
      ImageIndex = 2
      object Label1: TLabel
        Left = 27
        Top = 35
        Width = 53
        Height = 13
        Caption = 'Margin Left'
      end
      object Label2: TLabel
        Left = 27
        Top = 59
        Width = 60
        Height = 13
        Caption = 'Margin Right'
      end
      object Label3: TLabel
        Left = 27
        Top = 83
        Width = 54
        Height = 13
        Caption = 'Margin Top'
      end
      object Label4: TLabel
        Left = 27
        Top = 107
        Width = 68
        Height = 13
        Caption = 'Margin Bottom'
      end
      object EditMarginBottom: TEdit
        Left = 283
        Top = 103
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '1.0'
        OnKeyPress = EditKeyPress
      end
      object EditMarginLeft: TEdit
        Left = 283
        Top = 31
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '1.0'
        OnKeyPress = EditKeyPress
      end
      object EditMarginRight: TEdit
        Left = 283
        Top = 55
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '1.0'
        OnKeyPress = EditKeyPress
      end
      object EditMarginTop: TEdit
        Left = 283
        Top = 79
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '1.0'
        OnKeyPress = EditKeyPress
      end
    end
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Rave Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    OnPrint = RvSystem1Print
    OnPrintHeader = RvSystem1PrintHeader
    Left = 16
    Top = 317
  end
end
