inherited frmInvoiceReport: TfrmInvoiceReport
  Caption = 'DX SpreadSheet - Invoice Report Demo'
  ClientHeight = 430
  ClientWidth = 896
  PixelsPerInch = 96
  TextHeight = 13
  inherited sbMain: TStatusBar
    Top = 411
    Width = 896
  end
  inherited ReportDesigner: TdxSpreadSheetReportDesigner
    Width = 558
    Height = 411
    DataBinding.DataGroups = <
      item
        FieldName = 'OrderID'
      end>
    DataBinding.DataSource = dsInvoice
    DataBinding.Options.DisplayName = 'Invoice'
    Options.ReportMode = rmMultipleSheets
    OnAfterBuild = ReportDesignerAfterBuild
    Data = {
      E101000044585353763242460900000042465320000000000000000001000101
      010100000000000001004246532000000000424653200200000001000000200B
      00000007000000430061006C0069006200720069000000000000200000002000
      000000200000000020000000002000000000200007000000470045004E004500
      520041004C0000000000000200000000000000000101000000200B0000000700
      0000430061006C00690062007200690000000000002000000020000000002000
      00000020000000002000000000200007000000470045004E004500520041004C
      000000000000020000000000000000014246532001000000424653201D000000
      5400640078005300700072006500610064005300680065006500740052006500
      70006F00720074005400610062006C0065005600690065007700060000005300
      6800650065007400310001FFFFFFFFFFFFFFFF64000000020000000200000002
      0000005500000014000000020000000200000000020000000000000100000000
      0001010000424653205500000000000000424653200000000042465320140000
      0000000000424653200000000000000000000000000100000000000000000000
      0000000000000000004246532000000000000000000000000042465320000000
      0000000000}
  end
  inherited cxSplitter1: TcxSplitter
    Left = 558
    Height = 411
  end
  inherited Panel1: TPanel
    Left = 566
    Height = 411
    inherited cxSplitter2: TcxSplitter
      Top = 133
    end
    inherited cxgFieldChooserSite: TcxGroupBox
      Height = 133
    end
    inherited cxgFilter: TcxGroupBox
      Top = 137
    end
  end
  object mdsInvoice: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 392
    Top = 240
    object mdsInvoiceShipName: TWideStringField
      FieldName = 'ShipName'
      Size = 40
    end
    object mdsInvoiceShipAddress: TWideStringField
      FieldName = 'ShipAddress'
      Size = 60
    end
    object mdsInvoiceShipCity: TWideStringField
      FieldName = 'ShipCity'
      Size = 15
    end
    object mdsInvoiceShipRegion: TWideStringField
      FieldName = 'ShipRegion'
      Size = 15
    end
    object mdsInvoiceShipPostalCode: TWideStringField
      FieldName = 'ShipPostalCode'
      Size = 10
    end
    object mdsInvoiceShipCountry: TWideStringField
      FieldName = 'ShipCountry'
      Size = 15
    end
    object mdsInvoiceCustomerID: TWideStringField
      FieldName = 'CustomerID'
      Size = 5
    end
    object mdsInvoiceCustomers_CompanyName: TWideStringField
      FieldName = 'Customers.CompanyName'
      Size = 40
    end
    object mdsInvoiceAddress: TWideStringField
      FieldName = 'Address'
      Size = 60
    end
    object mdsInvoiceCity: TWideStringField
      FieldName = 'City'
      Size = 15
    end
    object mdsInvoiceRegion: TWideStringField
      FieldName = 'Region'
      Size = 15
    end
    object mdsInvoicePostalCode: TWideStringField
      FieldName = 'PostalCode'
      Size = 10
    end
    object mdsInvoiceCountry: TWideStringField
      FieldName = 'Country'
      Size = 15
    end
    object mdsInvoiceSalesperson: TWideStringField
      FieldName = 'Salesperson'
      Size = 255
    end
    object mdsInvoiceOrderID: TAutoIncField
      FieldName = 'OrderID'
    end
    object mdsInvoiceOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
    object mdsInvoiceRequiredDate: TDateTimeField
      FieldName = 'RequiredDate'
    end
    object mdsInvoiceShippedDate: TDateTimeField
      FieldName = 'ShippedDate'
    end
    object mdsInvoiceShippers_CompanyName: TWideStringField
      FieldName = 'Shippers.CompanyName'
      Size = 40
    end
    object mdsInvoiceProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object mdsInvoiceProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 40
    end
    object mdsInvoiceUnitPrice: TBCDField
      FieldName = 'UnitPrice'
    end
    object mdsInvoiceQuantity: TSmallintField
      FieldName = 'Quantity'
    end
    object mdsInvoiceDiscount: TFloatField
      FieldName = 'Discount'
    end
    object mdsInvoiceExtendedPrice: TBCDField
      FieldName = 'ExtendedPrice'
    end
    object mdsInvoiceFreight: TBCDField
      FieldName = 'Freight'
    end
  end
  object dsInvoice: TDataSource
    DataSet = mdsInvoice
    Left = 320
    Top = 240
  end
end
