object FormReports: TFormReports
  Left = 458
  Top = 128
  Width = 640
  Height = 480
  Caption = 'Select Demo Report'
  Color = clBtnFace
  Constraints.MaxHeight = 480
  Constraints.MaxWidth = 640
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    624
    444)
  PixelsPerInch = 96
  TextHeight = 13
  object lblNevrona1: TLabel
    Left = 200
    Top = 340
    Width = 400
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Rave Code Based Demo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNevrona2: TLabel
    Left = 200
    Top = 360
    Width = 400
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Nevrona Designs - Copyright 1995-2009'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnClose: TButton
    Left = 525
    Top = 400
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object btnPrintLandscape: TButton
    Left = 200
    Top = 400
    Width = 125
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Print &Landscape'
    Enabled = False
    TabOrder = 1
    OnClick = btnPrintLandscapeClick
  end
  object rgAvailable: TRadioGroup
    Left = 25
    Top = 20
    Width = 150
    Height = 400
    Caption = 'Available Reports'
    Items.Strings = (
      'Bitmaps'
      'Labels'
      'Listing'
      'Master Detail'
      'Memos'
      'Test Page')
    TabOrder = 2
    TabStop = True
    OnClick = rgAvailableClick
  end
  object MemoDesc: TMemo
    Left = 200
    Top = 20
    Width = 400
    Height = 300
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Please select the Demo Report that you want to see.'
      ''
      'These demos use the DbDemos data tables that were '
      'installed with your CodeGear or Borland product '
      '(C++Builder or Delphi).'
      ''
      'Coding style is often an individual issue. The code used '
      'in these demos is provided solely as an example of one '
      'way to accomplish the selected task.'
      ''
      'Nevrona Designs'
      'Copyright 1995 - 2009')
    ParentFont = False
    TabOrder = 4
  end
  object btnPrintPortrait: TButton
    Left = 367
    Top = 400
    Width = 100
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Print &Portrait'
    Enabled = False
    TabOrder = 0
    OnClick = btnPrintPortraitClick
  end
  object dsBioLife: TDataSource
    DataSet = tBioLife
    Left = 210
    Top = 280
  end
  object tBioLife: TTable
    DatabaseName = 'DBDEMOS'
    IndexDefs = <
      item
        Name = 'tBioLifeIndex1'
        Fields = 'Species No'
        Options = [ixPrimary, ixUnique]
      end>
    StoreDefs = True
    TableName = 'biolife.db'
    TableType = ttParadox
    Left = 210
    Top = 232
  end
  object rsCodeBase: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.RulerType = rtBothIn
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Rave Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    OnBeforePrint = rsCodeBaseBeforePrint
    OnPrintHeader = rsCodeBasePrintHeader
    OnPrintFooter = rsCodeBasePrintFooter
    Left = 408
    Top = 260
  end
  object RvRenderPDF1: TRvRenderPDF
    DisplayName = 'Adobe Acrobat (PDF)'
    FileExtension = '*.pdf'
    EmbedFonts = False
    ImageQuality = 90
    MetafileDPI = 300
    FontEncoding = feWinAnsiEncoding
    DocInfo.Creator = 'Rave Reports (http://www.nevrona.com/rave)'
    DocInfo.Producer = 'Nevrona Designs'
    BufferDocument = True
    DisableHyperlinks = False
    Left = 544
    Top = 216
  end
  object RvRenderHTML1: TRvRenderHTML
    DisplayName = 'Web Page (HTML)'
    FileExtension = '*.html;*.htm'
    ServerMode = False
    UseBreakingSpaces = False
    Left = 544
    Top = 280
  end
  object dsCustomer: TDataSource
    DataSet = tCustomer
    Left = 275
    Top = 280
  end
  object tCustomer: TTable
    DatabaseName = 'DBDEMOS'
    FieldDefs = <
      item
        Name = 'CustNo'
        DataType = ftFloat
      end
      item
        Name = 'Company'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Addr1'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Addr2'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'City'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'State'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Zip'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'FAX'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'TaxRate'
        DataType = ftFloat
      end
      item
        Name = 'Contact'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LastInvoiceDate'
        DataType = ftDateTime
      end>
    IndexDefs = <
      item
        Name = 'tCustomerIndex1'
        Fields = 'CustNo'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'ByCompany'
        Fields = 'Company'
        Options = [ixCaseInsensitive]
      end>
    StoreDefs = True
    TableName = 'customer'
    TableType = ttParadox
    Left = 275
    Top = 232
  end
  object tOrders: TTable
    DatabaseName = 'DBDEMOS'
    FieldDefs = <
      item
        Name = 'OrderNo'
        DataType = ftFloat
      end
      item
        Name = 'CustNo'
        Attributes = [faRequired]
        DataType = ftFloat
      end
      item
        Name = 'SaleDate'
        DataType = ftDateTime
      end
      item
        Name = 'ShipDate'
        DataType = ftDateTime
      end
      item
        Name = 'EmpNo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ShipToContact'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ShipToAddr1'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ShipToAddr2'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ShipToCity'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ShipToState'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ShipToZip'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ShipToCountry'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ShipToPhone'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ShipVIA'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'PO'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Terms'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'PaymentMethod'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'ItemsTotal'
        DataType = ftCurrency
      end
      item
        Name = 'TaxRate'
        DataType = ftFloat
      end
      item
        Name = 'Freight'
        DataType = ftCurrency
      end
      item
        Name = 'AmountPaid'
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'tOrdersIndex1'
        Fields = 'OrderNo'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'CustNo'
        Fields = 'CustNo'
      end>
    MasterSource = dsCustomer
    StoreDefs = True
    TableName = 'orders'
    TableType = ttParadox
    Left = 338
    Top = 232
  end
  object dsOrders: TDataSource
    DataSet = tOrders
    Left = 338
    Top = 280
  end
end
