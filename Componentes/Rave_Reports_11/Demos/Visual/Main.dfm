object Form1: TForm1
  Left = 437
  Top = 130
  BorderStyle = bsDialog
  Caption = 'Sample Rave Project'
  ClientHeight = 444
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelAvailableReports: TLabel
    Left = 30
    Top = 15
    Width = 128
    Height = 13
    Caption = 'AVAILABLE REPORTs'
  end
  object LabelReportDescription: TLabel
    Left = 282
    Top = 15
    Width = 140
    Height = 13
    Caption = 'REPORT DESCRIPTION'
  end
  object lbReportsAvailable: TListBox
    Left = 8
    Top = 35
    Width = 169
    Height = 400
    ItemHeight = 13
    TabOrder = 0
    OnClick = lbReportsAvailableClick
  end
  object MemoReportDescription: TMemo
    Left = 200
    Top = 35
    Width = 300
    Height = 350
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      'DescMemo')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ButtonPrint: TButton
    Left = 200
    Top = 400
    Width = 75
    Height = 25
    Hint = 'Print currently selected report'
    Caption = '&Print'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = ButtonPrintClick
  end
  object ButtonClose: TBitBtn
    Left = 425
    Top = 400
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = ButtonCloseClick
    Kind = bkClose
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Report Setup'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.MarginPercent = 2.500000000000000000
    SystemPreview.ShadowDepth = 5
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 440
    Top = 8
  end
  object RvProject: TRvProject
    Engine = RvSystem1
    ProjectFile = 'RaveDemo.rav'
    Left = 480
    Top = 8
  end
end
