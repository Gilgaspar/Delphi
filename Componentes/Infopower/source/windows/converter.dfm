object RTFImportExportForm: TRTFImportExportForm
  Left = 115
  Top = 181
  Caption = 'Demo for Import/Export from RTF'
  ClientHeight = 339
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    536
    339)
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBRichEdit1: TwwDBRichEdit
    Left = 0
    Top = 0
    Width = 536
    Height = 273
    ScrollBars = ssVertical
    MSVersion = 4
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoURLDetect = False
    BorderStyle = bsNone
    Frame.Enabled = True
    HideSelection = False
    PrintJobName = 'Delphi 6'
    TabOrder = 0
    EditorCaption = 'Edit Rich Text'
    EditorPosition.Left = 0
    EditorPosition.Top = 0
    EditorPosition.Width = 0
    EditorPosition.Height = 0
    MeasurementUnits = muInches
    PrintMargins.Top = 1.000000000000000000
    PrintMargins.Bottom = 1.000000000000000000
    PrintMargins.Left = 1.000000000000000000
    PrintMargins.Right = 1.000000000000000000
    PrintHeader.VertMargin = 0.500000000000000000
    PrintHeader.Font.Charset = DEFAULT_CHARSET
    PrintHeader.Font.Color = clWindowText
    PrintHeader.Font.Height = -11
    PrintHeader.Font.Name = 'MS Sans Serif'
    PrintHeader.Font.Style = []
    PrintFooter.VertMargin = 0.500000000000000000
    PrintFooter.Font.Charset = DEFAULT_CHARSET
    PrintFooter.Font.Color = clWindowText
    PrintFooter.Font.Height = -11
    PrintFooter.Font.Name = 'MS Sans Serif'
    PrintFooter.Font.Style = []
    RichEditVersion = 2
    Data = {
      A70100007B5C727466315C616E73695C616E7369637067313235325C64656666
      305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C66726F6D61
      6E5C66707271325C6663686172736574302054696D6573204E657720526F6D61
      6E3B7D7B5C66315C666E696C5C666368617273657430204D532053616E732053
      657269663B7D7D0D0A5C766965776B696E64345C7563315C706172645C726931
      38305C736135375C716A5C66305C6673323020537570706F72747320696D706F
      7274696E672066726F6D204D6963726F736F667420576F7264206F72206D706F
      7274696E6720616E64206578706F7274696E6720746F2048544D4C20204F7468
      657220666F726D61747320616C736F20737570706F7274656420626173656420
      6F6E2074686520746578742066696C7465727320696E7374616C6C6564206F6E
      2074686520636C69656E7420636F6D70757465722E2020466F7220696E737461
      6E63652C20796F752063616E20696D706F72742066726F6D20616E2045786365
      6C2073707265616473686565742E5C7061720D0A5C706172645C66315C667331
      365C7061720D0A7D0D0A00}
  end
  object OpenButton: TBitBtn
    Left = 312
    Top = 280
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Import'
    TabOrder = 1
    OnClick = OpenButtonClick
  end
  object SaveButton: TButton
    Left = 424
    Top = 280
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Export'
    TabOrder = 2
    OnClick = SaveButtonClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 320
    Width = 536
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object OpenDialog1: TOpenDialog
    Left = 232
    Top = 280
  end
  object SaveDialog1: TSaveDialog
    Left = 272
    Top = 288
  end
end
