object CustomDrawDemoDataDM: TCustomDrawDemoDataDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 534
  Top = 172
  Height = 229
  Width = 325
  object dsDepartments: TDataSource
    DataSet = mdDepartments
    Left = 40
    Top = 120
  end
  object dsPersons: TDataSource
    DataSet = mdPersons
    Left = 160
    Top = 120
  end
  object StyleRepository: TcxStyleRepository
    Left = 236
    Top = 8
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14652517
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = 8200196
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 15252642
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = 11032875
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16247513
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 15253902
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16247513
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16776183
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clNavy
    end
    object cxStyle9: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle10: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 4707838
      TextColor = clBlack
    end
    object cxStyle11: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle12: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16776183
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clNavy
    end
    object cxStyle13: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16048336
      TextColor = clBlack
    end
    object styNoVacancy: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14671839
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10658466
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = 10658466
    end
    object styVacancy: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 15253902
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = 14916958
    end
    object TreeListStyleSheetDevExpress: TcxTreeListStyleSheet
      Caption = 'DevExpress'
      Styles.Background = cxStyle1
      Styles.Content = cxStyle5
      Styles.Inactive = cxStyle9
      Styles.Selection = cxStyle13
      Styles.BandBackground = cxStyle2
      Styles.BandHeader = cxStyle3
      Styles.ColumnHeader = cxStyle4
      Styles.ContentEven = cxStyle7
      Styles.ContentOdd = cxStyle6
      Styles.Footer = cxStyle8
      Styles.IncSearch = cxStyle10
      Styles.Indicator = cxStyle11
      Styles.Preview = cxStyle12
      BuiltIn = True
    end
  end
  object mdDepartments: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0A000000040000000C000300494400040000000300
      0900504152454E544944000400000003000A004D414E41474552494400320000
      00010005004E414D450008000000060007004255444745540032000000010009
      004C4F434154494F4E00320000000100060050484F4E45003200000001000400
      46415800FF00000001000600454D41494C000200000005000800564143414E43
      5900}
    SortOptions = []
    Left = 40
    Top = 68
    object mdDepartmentsID: TAutoIncField
      FieldName = 'ID'
    end
    object mdDepartmentsPARENTID: TIntegerField
      FieldName = 'PARENTID'
    end
    object mdDepartmentsMANAGERID: TIntegerField
      FieldName = 'MANAGERID'
    end
    object mdDepartmentsNAME: TStringField
      FieldName = 'NAME'
      Size = 50
    end
    object mdDepartmentsBUDGET: TFloatField
      FieldName = 'BUDGET'
    end
    object mdDepartmentsLOCATION: TStringField
      FieldName = 'LOCATION'
      Size = 50
    end
    object mdDepartmentsPHONE: TStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object mdDepartmentsFAX: TStringField
      FieldName = 'FAX'
      Size = 50
    end
    object mdDepartmentsEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
    object mdDepartmentsVACANCY: TBooleanField
      FieldName = 'VACANCY'
    end
  end
  object mdPersons: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0B000000040000000C000300494400320000000100
      05004E616D65000F00000001000800436F756E747279000A00000001000B0050
      6F7374616C436F6465000F000000010005004369747900640000000100080041
      64647265737300180000000100060050686F6E65001800000001000400466178
      006400000001000600454D41494C006400000001000900484F4D455041474500
      0400000003000D004465706172746D656E74494400}
    SortOptions = []
    Left = 160
    Top = 68
    object mdPersonsID: TAutoIncField
      FieldName = 'ID'
    end
    object mdPersonsName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object mdPersonsCountry: TStringField
      FieldName = 'Country'
      Size = 15
    end
    object mdPersonsPostalCode: TStringField
      FieldName = 'PostalCode'
      Size = 10
    end
    object mdPersonsCity: TStringField
      FieldName = 'City'
      Size = 15
    end
    object mdPersonsAddress: TStringField
      FieldName = 'Address'
      Size = 100
    end
    object mdPersonsPhone: TStringField
      FieldName = 'Phone'
      Size = 24
    end
    object mdPersonsFax: TStringField
      FieldName = 'Fax'
      Size = 24
    end
    object mdPersonsEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object mdPersonsHOMEPAGE: TStringField
      FieldName = 'HOMEPAGE'
      Size = 100
    end
    object mdPersonsDepartmentID: TIntegerField
      FieldName = 'DepartmentID'
    end
  end
end
