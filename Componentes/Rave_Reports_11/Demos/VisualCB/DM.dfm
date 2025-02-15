object DataModule1: TDataModule1
  OldCreateOrder = True
  Height = 412
  Width = 388
  object CustomerTable: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'CUSTOMER.DB'
    Left = 48
    Top = 16
  end
  object OrdersTable: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'ORDERS.DB'
    Left = 48
    Top = 64
  end
  object CustrOrdQuery: TQuery
    DatabaseName = 'DBDEMOS'
    SQL.Strings = (
      'SELECT * '
      'FROM Customer, Orders '
      'WHERE Customer.CustNo = Orders.CustNo'
      'ORDER BY Customer.CustNo, Orders.OrderNo')
    Left = 48
    Top = 112
  end
  object ClientsTable: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'CLIENTS.DBF'
    Left = 48
    Top = 160
  end
  object PartsTable: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'PARTS.DB'
    Left = 48
    Top = 208
  end
  object BioLifeTable: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'BIOLIFE.DB'
    Left = 48
    Top = 256
  end
  object MasterTable: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'MASTER.DBF'
    Left = 48
    Top = 304
  end
  object ItemsTable: TTable
    OnCalcFields = ItemsTableCalcFields
    DatabaseName = 'DBDEMOS'
    TableName = 'ITEMS.DB'
    Left = 216
    Top = 16
    object ItemsTableOrderNo: TFloatField
      FieldName = 'OrderNo'
      DisplayFormat = #39'#'#39'0000'
    end
    object ItemsTableItemNo: TFloatField
      FieldName = 'ItemNo'
    end
    object ItemsTablePartNo: TFloatField
      Alignment = taLeftJustify
      FieldName = 'PartNo'
    end
    object ItemsTableQty: TIntegerField
      FieldName = 'Qty'
    end
    object ItemsTableDiscount: TFloatField
      FieldName = 'Discount'
      DisplayFormat = '#%'
      MaxValue = 100.000000000000000000
    end
    object ItemsTableListPrice: TCurrencyField
      FieldKind = fkLookup
      FieldName = 'ListPrice'
      LookupDataSet = PartsTable
      LookupKeyFields = 'PartNo'
      LookupResultField = 'ListPrice'
      KeyFields = 'PartNo'
      Lookup = True
    end
    object ItemsTableTotalPrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotalPrice'
      Calculated = True
    end
  end
  object VendorsTable: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'VENDORS.DB'
    Left = 216
    Top = 64
  end
  object CustomerCXN: TRvTableConnection
    RuntimeVisibility = rtEndUser
    Table = CustomerTable
    Left = 128
    Top = 16
  end
  object OrdersCXN: TRvTableConnection
    RuntimeVisibility = rtEndUser
    Table = OrdersTable
    Left = 128
    Top = 64
  end
  object CustOrdCXN: TRvQueryConnection
    RuntimeVisibility = rtEndUser
    Query = CustrOrdQuery
    Left = 128
    Top = 112
  end
  object ClientsCXN: TRvTableConnection
    RuntimeVisibility = rtEndUser
    Table = ClientsTable
    Left = 128
    Top = 160
  end
  object PartsCXN: TRvTableConnection
    RuntimeVisibility = rtEndUser
    Table = PartsTable
    Left = 128
    Top = 208
  end
  object BioLifeCXN: TRvTableConnection
    RuntimeVisibility = rtEndUser
    Table = BioLifeTable
    Left = 128
    Top = 256
  end
  object MasterCXN: TRvTableConnection
    RuntimeVisibility = rtEndUser
    Table = MasterTable
    Left = 128
    Top = 304
  end
  object ItemsCXN: TRvTableConnection
    RuntimeVisibility = rtEndUser
    Table = ItemsTable
    Left = 296
    Top = 16
  end
  object VendorsCXN: TRvTableConnection
    RuntimeVisibility = rtEndUser
    Table = VendorsTable
    Left = 296
    Top = 64
  end
  object CustomCXN: TRvCustomConnection
    RuntimeVisibility = rtEndUser
    OnEOF = CustomCXNEOF
    OnGetCols = CustomCXNGetCols
    OnGetRow = CustomCXNGetRow
    Left = 296
    Top = 112
  end
  object CustomMasterCXN: TRvCustomConnection
    RuntimeVisibility = rtDeveloper
    OnGetCols = CustomMasterCXNGetCols
    OnGetRow = CustomMasterCXNGetRow
    OnOpen = CustomMasterCXNOpen
    Left = 224
    Top = 176
  end
  object CustomDetail1CXN: TRvCustomConnection
    RuntimeVisibility = rtDeveloper
    OnGetCols = CustomDetail1CXNGetCols
    OnGetRow = CustomDetail1CXNGetRow
    OnOpen = CustomDetail1CXNOpen
    Left = 224
    Top = 224
  end
  object CustomDetail2CXN: TRvCustomConnection
    RuntimeVisibility = rtDeveloper
    OnGetCols = CustomDetail2CXNGetCols
    OnGetRow = CustomDetail2CXNGetRow
    OnOpen = CustomDetail2CXNOpen
    Left = 224
    Top = 272
  end
end
