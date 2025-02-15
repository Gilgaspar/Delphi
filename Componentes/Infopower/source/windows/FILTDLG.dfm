object FilterDialogForm: TFilterDialogForm
  Left = 201
  Top = 129
  ActiveControl = BitBtn1
  BorderStyle = bsDialog
  Caption = 'InfoPower'#39's Visual Filtering Dialog'
  ClientHeight = 448
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PrintScale = poNone
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 608
    Top = 256
    Width = 68
    Height = 13
    Caption = 'Visual Query 2'
    Visible = False
  end
  object Label2: TLabel
    Left = 632
    Top = 80
    Width = 98
    Height = 13
    Caption = 'Visual Filter on Table'
    Visible = False
  end
  object Label3: TLabel
    Left = 608
    Top = 168
    Width = 68
    Height = 13
    Caption = 'Visual Query 1'
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 478
    Top = 351
    Width = 129
    Height = 30
    Caption = 'Specify Criteria'
    Glyph.Data = {
      96010000424D9601000000000000760000002800000018000000180000000100
      0400000000002001000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      77777777777777777777777777777777777778000000000000000000000778BB
      BBBBBBBBBBBBBBBBBB0778BBBBBBBBBBBBBBBBBBBB0778B0BBBB0B0BB0BB00B0
      BB0778B0BBBB0B0B0BB0BBB0BB0778B0BBBB0B0B0BB0B0B0BB0778B000BB0B0B
      00BB0BB00B0778B0BBBBBB0B0BBBBBBBBB0770B0000B0B0BBBBBBBBBBB07000B
      BBBBBBBBBBBBBBBBBB070F008888888888888888880770F00FFFFFFFFFFFFFFF
      FF07780F0000008FFFFFFFFFFF0778F0F0087780FFFFFFFFFF0778F000877F78
      0FFFFFFFFF0778FF087777F788FFFFFFFF0778FF0877777F70FFFFFFFF0778FF
      087FF77770000000000778FF888FF77788CCCC0F0F0778888088777808888888
      8887777777088880777777777777777777780087777777777777}
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object GroupBox1: TGroupBox
    Left = 453
    Top = 14
    Width = 172
    Height = 144
    Caption = 'Display Options'
    TabOrder = 1
    object SearchTypeCheckbox: TCheckBox
      Left = 8
      Top = 20
      Width = 142
      Height = 17
      Caption = 'Search Type Tab Control'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = SearchTypeCheckboxClick
    end
    object ShowFieldOrderCheckbox: TCheckBox
      Left = 8
      Top = 40
      Width = 142
      Height = 17
      Caption = 'Field Order Radio Button'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = ShowFieldOrderCheckboxClick
    end
    object ViewSummaryCheckbox: TCheckBox
      Left = 8
      Top = 60
      Width = 142
      Height = 17
      Caption = 'View Summary Button'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = ViewSummaryCheckboxClick
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 80
      Width = 142
      Height = 17
      Caption = 'OK and Cancel Buttons'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 100
      Width = 161
      Height = 17
      Caption = 'Show Nonmatching Records'
      TabOrder = 4
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 8
      Top = 120
      Width = 161
      Height = 17
      Caption = 'Resizable (NEW!)'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = CheckBox3Click
    end
  end
  object TabbedNotebook1: TTabbedNotebook
    Left = -7
    Top = 14
    Width = 462
    Height = 427
    TabsPerRow = 4
    TabFont.Charset = DEFAULT_CHARSET
    TabFont.Color = clBtnText
    TabFont.Height = -11
    TabFont.Name = 'MS Sans Serif'
    TabFont.Style = []
    TabOrder = 2
    OnChange = TabbedNotebook1Change
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Local Filtering'
      object wwDBGrid1: TwwDBGrid
        Left = 6
        Top = 2
        Width = 427
        Height = 202
        Selected.Strings = (
          'Customer No'#9'6'#9'Cust~No'
          'Buyer'#9'5'#9'Buyer'
          'Company Name'#9'9'#9'Company~Name'
          'First Name'#9'10'#9'First Name'
          'Last Name'#9'10'#9'Last Name'
          'Street'#9'15'#9'Street'
          'City'#9'11'#9'City'
          'State'#9'25'#9'State'
          'Zip'#9'15'#9'Zip'
          'First Contact Date'#9'15'#9'First Contact Date'
          'Phone Number'#9'20'#9'Phone Number'
          'Information'#9'10'#9'Information'
          'Requested Demo'#9'14'#9'Requested Demo'
          'Logical'#9'6'#9'Logical')
        IniAttributes.FileName = 'delphi32.ini'
        IniAttributes.SectionName = 'FilterDialogFormwwDBGrid1'
        IniAttributes.Delimiter = ';;'
        IniAttributes.UnicodeIniFile = False
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = CustomerDS
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit]
        RowHeightPercent = 185
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 2
        TitleButtons = False
      end
      object wwDBRichEdit3: TwwDBRichEdit
        Left = 5
        Top = 208
        Width = 434
        Height = 165
        AutoURLDetect = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GutterWidth = 3
        HideSelection = False
        ParentFont = False
        PrintJobName = 'Delphi 3'
        TabOrder = 1
        EditorOptions = [reoShowSaveExit, reoShowPrint, reoShowPrintPreview, reoShowPageSetup, reoShowFormatBar, reoShowToolBar, reoShowStatusBar, reoShowHints, reoShowRuler, reoShowInsertObject, reoCloseOnEscape, reoFlatButtons, reoShowSpellCheck, reoShowMainMenuIcons, reoShowZoomCombo]
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
        PrintHeader.Font.Name = 'Tahoma'
        PrintHeader.Font.Style = []
        PrintFooter.VertMargin = 0.500000000000000000
        PrintFooter.Font.Charset = DEFAULT_CHARSET
        PrintFooter.Font.Color = clWindowText
        PrintFooter.Font.Height = -11
        PrintFooter.Font.Name = 'Tahoma'
        PrintFooter.Font.Style = []
        RichEditVersion = 2
        Data = {
          470200007B5C727466315C616E73695C64656666305C6465666C616E67313033
          337B5C666F6E7474626C7B5C66305C66726F6D616E2054696D6573204E657720
          526F6D616E3B7D7D0D0A7B5C636F6C6F7274626C203B5C726564385C67726565
          6E305C626C7565303B7D0D0A5C766965776B696E64345C7563315C706172645C
          736134335C6366315C66305C6673323020496E666F506F77657220616C6C6F77
          7320796F757220656E642D757365727320746F2076697375616C6C7920706572
          666F726D2061206C6F63616C2066696C746572206F6E20616E7920496E666F50
          6F77657220636F6D70617469626C6520446174615365742E2046696C74657220
          63726974657269612063616E2062652073706563696669656420617320612076
          616C75652C206120737562737472696E672C206F7220612072616E67652E2057
          68656E207573696E67206C6F63616C2066696C746572696E67206F6E20612071
          7565727920726573756C742C20746865207175657279206973206E6F74207265
          2D65786563757465642C206275742073696D706C792072652D66696C74657265
          642E202054686973206D65616E73207468617420746865206261636B2D656E64
          20646F6573206E6F74206E65656420746F20646F20616E79206164646974696F
          6E616C2070726F63657373696E672E205C7061720D0A4C6F63616C2066696C74
          6572696E67206F6E207461626C657320616C736F2067756172616E7465657320
          61206C697665206564697461626C652076696577206F66207468652064617461
          2E5C7061720D0A7D0D0A00}
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Visual Querying 1'
      object wwDBGrid4: TwwDBGrid
        Left = 8
        Top = 0
        Width = 425
        Height = 209
        Selected.Strings = (
          'CustomerID'#9'5'#9'CustomerID'
          'CompanyName'#9'40'#9'CompanyName'
          'ContactName'#9'30'#9'ContactName'
          'ContactTitle'#9'30'#9'ContactTitle'
          'Address'#9'60'#9'Address'
          'City'#9'15'#9'City'
          'Region'#9'15'#9'Region'
          'PostalCode'#9'10'#9'PostalCode'
          'Country'#9'15'#9'Country'
          'Phone'#9'24'#9'Phone'
          'Fax'#9'24'#9'Fax')
        IniAttributes.FileName = 'delphi32.ini'
        IniAttributes.SectionName = 'FilterDialogFormwwDBGrid4'
        IniAttributes.Delimiter = ';;'
        IniAttributes.UnicodeIniFile = False
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = Customer1QueryDS
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit]
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
      end
      object wwDBRichEdit2: TwwDBRichEdit
        Left = 8
        Top = 216
        Width = 425
        Height = 153
        AutoURLDetect = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GutterWidth = 3
        HideSelection = False
        ParentFont = False
        PrintJobName = 'Delphi 3'
        TabOrder = 1
        EditorOptions = [reoShowSaveExit, reoShowPrint, reoShowPrintPreview, reoShowPageSetup, reoShowFormatBar, reoShowToolBar, reoShowStatusBar, reoShowHints, reoShowRuler, reoShowInsertObject, reoCloseOnEscape, reoFlatButtons, reoShowSpellCheck, reoShowMainMenuIcons, reoShowZoomCombo]
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
        PrintHeader.Font.Name = 'Tahoma'
        PrintHeader.Font.Style = []
        PrintFooter.VertMargin = 0.500000000000000000
        PrintFooter.Font.Charset = DEFAULT_CHARSET
        PrintFooter.Font.Color = clWindowText
        PrintFooter.Font.Height = -11
        PrintFooter.Font.Name = 'Tahoma'
        PrintFooter.Font.Style = []
        RichEditVersion = 2
        Data = {
          C40200007B5C727466315C616E73695C64656666305C6465666C616E67313033
          337B5C666F6E7474626C7B5C66305C66726F6D616E2054696D6573204E657720
          526F6D616E3B7D7D0D0A7B5C636F6C6F7274626C203B5C726564305C67726565
          6E305C626C7565303B7D0D0A5C766965776B696E64345C7563315C706172645C
          66305C6673323020496E666F506F77657227732076697375616C207175657279
          206D656368616E69736D20706572666F726D732072656D6F74652066696C7465
          72696E67206279207574696C697A696E67206578697374696E672053514C2071
          7565726965732C20616E64206D6F64696679696E67207468656D206163636F72
          64696E6720746F2061207573657220646566696E656420736561726368206372
          6974657269612E2054686F7567682066756E6374696F6E616C6C792076657279
          2073696D696C617220746F206C6F63616C2066696C746572696E672C20746865
          2061637475616C206D656368616E69736D206F662066696C74657269696E6720
          6973206E6F7420706572666F726D6564206C6F63616C6C792C2062757420696E
          737465616420617420746865206261636B2D656E642E205C7061720D0A5C7061
          720D0A546865206261636B2D656E642063616E207468656E2065666669636965
          6E746C7920706572666F726D2074686520736561726368206279207574696C69
          7A696E6720617661696C61626C6520696E64657865732E202056697375616C20
          5175657279696E6720616C736F206861732074686520616476616E7461676520
          6F66207265647563696E67206E6574776F726B20747261666669632073696E63
          65207468652066696C746572696E6720697320706572666F726D6564206F6E20
          7468652073616D65206D616368696E65207468617420636F6E7461696E73205C
          7061720D0A74686520646174612E5C7061720D0A5C7061720D0A5C6366315C70
          61720D0A7D0D0A00}
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Visual Querying 2'
      object GroupBox2: TGroupBox
        Left = 3
        Top = 140
        Width = 430
        Height = 149
        Caption = 'Orders for Customer'
        TabOrder = 0
        object wwDBGrid3: TwwDBGrid
          Left = 10
          Top = 14
          Width = 417
          Height = 115
          Selected.Strings = (
            'OrderID'#9'10'#9'OrderID'
            'CustomerID'#9'5'#9'CustomerID'
            'EmployeeID'#9'10'#9'EmployeeID'
            'OrderDate'#9'18'#9'OrderDate'
            'RequiredDate'#9'18'#9'RequiredDate'
            'ShippedDate'#9'18'#9'ShippedDate'
            'ShipVia'#9'10'#9'ShipVia'
            'Freight'#9'20'#9'Freight'
            'ShipName'#9'40'#9'ShipName'
            'ShipAddress'#9'60'#9'ShipAddress'
            'ShipCity'#9'15'#9'ShipCity'
            'ShipRegion'#9'15'#9'ShipRegion'
            'ShipPostalCode'#9'10'#9'ShipPostalCode')
          IniAttributes.FileName = 'delphi32.ini'
          IniAttributes.SectionName = 'FilterDialogFormwwDBGrid3'
          IniAttributes.Delimiter = ';;'
          IniAttributes.UnicodeIniFile = False
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = CustInvDS
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit]
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = False
          OnCalcCellColors = wwDBGrid3CalcCellColors
        end
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 8
        Width = 430
        Height = 125
        Caption = 'Customers'
        TabOrder = 1
        object wwDBGrid2: TwwDBGrid
          Left = 8
          Top = 16
          Width = 417
          Height = 90
          Selected.Strings = (
            'CustomerID'#9'5'#9'CustomerID'#9'F'#9
            'CompanyName'#9'40'#9'CompanyName'#9'F'#9
            'ContactName'#9'30'#9'ContactName'#9'F'#9
            'ContactTitle'#9'30'#9'ContactTitle'#9'F'#9
            'Address'#9'60'#9'Address'#9'F'#9
            'City'#9'15'#9'City'#9#9
            'Region'#9'15'#9'Region'#9'F'#9
            'PostalCode'#9'10'#9'PostalCode'#9'F'#9
            'Country'#9'15'#9'Country'#9'F'#9
            'Phone'#9'24'#9'Phone'#9'F'#9
            'Fax'#9'24'#9'Fax'#9'F'#9)
          IniAttributes.FileName = 'delphi32.ini'
          IniAttributes.SectionName = 'FilterDialogFormwwDBGrid2'
          IniAttributes.Delimiter = ';;'
          IniAttributes.UnicodeIniFile = False
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = Customer2QueryDS
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit]
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = False
        end
      end
      object Memo3: TMemo
        Left = 10
        Top = 307
        Width = 425
        Height = 66
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        Lines.Strings = (
          
            'InfoPower performs remote filtering with multi-table sql queries' +
            ', and '
          
            'modifies them according to a user defined search criteria.  As a' +
            ' result you '
          'can even specify search criteria in joined tables.'
          ''
          
            'For instance click on the "Specify Criteria" button to the right' +
            ' and enter a '
          
            '"Starting Range" of 25 for the "Balance Due" field.  Then click ' +
            'the OK '
          
            'button. You will then see only customers who have at least one o' +
            'rder '
          'where the balance due field is more than $25.')
        ParentFont = False
        TabOrder = 2
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'And, Or, Not, Null'
      object wwDBGrid5: TwwDBGrid
        Left = 8
        Top = 16
        Width = 427
        Height = 209
        Selected.Strings = (
          'Customer No'#9'6'#9'Cust~No'
          'Buyer'#9'5'#9'Buyer'
          'Company Name'#9'9'#9'Company~Name'
          'First Name'#9'10'#9'First Name'
          'Last Name'#9'10'#9'Last Name'
          'Street'#9'15'#9'Street'
          'City'#9'11'#9'City'
          'State'#9'25'#9'State'
          'Zip'#9'15'#9'Zip'
          'First Contact Date'#9'15'#9'First Contact Date'
          'Phone Number'#9'20'#9'Phone Number'
          'Information'#9'10'#9'Information'
          'Requested Demo'#9'14'#9'Requested Demo'
          'Logical'#9'6'#9'Logical')
        IniAttributes.FileName = 'delphi32.ini'
        IniAttributes.SectionName = 'FilterDialogFormwwDBGrid5'
        IniAttributes.Delimiter = ';;'
        IniAttributes.UnicodeIniFile = False
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = CustomerDS
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 2
        TitleButtons = False
      end
      object wwDBRichEdit1: TwwDBRichEdit
        Left = 8
        Top = 232
        Width = 425
        Height = 137
        AutoURLDetect = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GutterWidth = 3
        HideSelection = False
        ParentFont = False
        PrintJobName = 'Delphi 3'
        TabOrder = 1
        EditorOptions = [reoShowSaveExit, reoShowPrint, reoShowPrintPreview, reoShowPageSetup, reoShowFormatBar, reoShowToolBar, reoShowStatusBar, reoShowHints, reoShowRuler, reoShowInsertObject, reoCloseOnEscape, reoFlatButtons, reoShowSpellCheck, reoShowMainMenuIcons, reoShowZoomCombo]
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
        PrintHeader.Font.Name = 'Tahoma'
        PrintHeader.Font.Style = []
        PrintFooter.VertMargin = 0.500000000000000000
        PrintFooter.Font.Charset = DEFAULT_CHARSET
        PrintFooter.Font.Color = clWindowText
        PrintFooter.Font.Height = -11
        PrintFooter.Font.Name = 'Tahoma'
        PrintFooter.Font.Style = []
        RichEditVersion = 2
        Data = {
          200200007B5C727466315C616E73695C64656666305C6465666C616E67313033
          337B5C666F6E7474626C7B5C66305C66726F6D616E2054696D6573204E657720
          526F6D616E3B7D7D0D0A7B5C636F6C6F7274626C203B5C726564305C67726565
          6E305C626C7565303B7D0D0A5C766965776B696E64345C7563315C706172645C
          66305C667332302050726F6772616D6D61626C65206B6579776F72647320666F
          7220414E442C204F522C20616E64204E554C4C20737570706F72742E20205468
          697320616C6C6F777320796F7520746F2073706563696679206D756C7469706C
          652066696C7465722076616C75657320666F722065616368206669656C642C20
          73756368206173204A6F686E204F52205061756C2E5C7061720D0A5C7061720D
          0A41206E6577206F7074696F6E20686173206265656E20616464656420746F20
          68616E646C65204E4F5420737570706F72742E20205C7061720D0A5768656E20
          666453686F774E6F6E4D61746368696E672069732073657420746F2054727565
          2C206120636865636B626F78206170706561727320696E207468652046696C74
          65726469616C6F672077686963682C207768656E20656E61626C65642C207769
          6C6C2073686F7720616C6C20746865207265636F726473207468617420646F20
          5C625C69206E6F745C62305C693020206669742074686520656E746572656420
          636F6E646974696F6E2E5C7061720D0A5C7061720D0A5C6366315C7061720D0A
          7D0D0A00}
      end
    end
  end
  object wwFilterDialog1: TwwFilterDialog
    DataSource = CustomerDS
    Options = [fdShowCaseSensitive, fdShowOKCancel, fdShowViewSummary, fdShowFieldOrder, fdShowValueRangeTab, fdSizeable]
    SortBy = fdSortByFieldNo
    Caption = 'Search using local filtering'
    FilterMethod = fdByFilter
    DefaultMatchType = fdMatchStart
    DefaultFilterBy = fdSmartFilter
    FieldOperators.OrChar = 'or'
    FieldOperators.AndChar = 'and'
    FieldOperators.NullChar = 'null'
    Rounding.Epsilon = 0.000100000000000000
    Rounding.RoundingMethod = fdrmFixed
    FilterPropertyOptions.LikeWildcardChar = '%'
    FilterOptimization = fdNone
    QueryFormatDateMode = qfdMonthDayYear
    SQLTables = <>
    OnSelectField = wwFilterDialog1SelectField
    Left = 632
    Top = 96
  end
  object CustomerDS: TDataSource
    DataSet = ClientDataSet1
    Left = 632
    Top = 128
  end
  object Customer2QueryDS: TDataSource
    DataSet = ADOQuery1
    Left = 608
    Top = 304
  end
  object wwFilterDialog3: TwwFilterDialog
    DataSource = Customer2QueryDS
    Options = [fdShowCaseSensitive, fdShowOKCancel, fdShowViewSummary, fdShowFieldOrder, fdShowValueRangeTab, fdSizeable]
    SortBy = fdSortByFieldNo
    Caption = 'Search on multiple tables using a visual query'
    FilterMethod = fdByQueryModify
    DefaultMatchType = fdMatchStart
    DefaultFilterBy = fdSmartFilter
    FieldsFetchMethod = fmUseSQL
    FieldOperators.OrChar = 'or'
    FieldOperators.AndChar = 'and'
    FieldOperators.NullChar = 'null'
    Rounding.Epsilon = 0.000100000000000000
    Rounding.RoundingMethod = fdrmFixed
    FilterPropertyOptions.LikeWildcardChar = '%'
    SelectedFields.Strings = (
      'CustomerID'
      'EmployeeID'
      'Freight'
      'OrderDate'
      'OrderID'
      'RequiredDate'
      'ShipAddress'
      'ShipCity'
      'ShipCountry'
      'ShipName'
      'ShippedDate'
      'ShipPostalCode'
      'ShipRegion'
      'ShipVia'
      'CompanyName'
      'ContactName'
      'ContactTitle'
      'Address'
      'City'
      'Region'
      'PostalCode'
      'Country'
      'Phone'
      'Fax')
    FilterOptimization = fdNone
    QueryFormatDateMode = qfdMonthDayYear
    SQLTables = <
      item
        TableName = 'Customers'
        TableAliasName = 'Customers'
      end
      item
        TableName = 'Orders'
        TableAliasName = 'Orders'
      end>
    Left = 608
    Top = 272
  end
  object CustInvDS: TDataSource
    DataSet = ADOQuery2
    Left = 672
    Top = 298
  end
  object wwFilterDialog2: TwwFilterDialog
    DataSource = Customer1QueryDS
    Options = [fdShowCaseSensitive, fdShowOKCancel, fdShowViewSummary, fdShowFieldOrder, fdShowValueRangeTab, fdSizeable]
    SortBy = fdSortByFieldNo
    Caption = 'Search query using remote filtering'
    FilterMethod = fdByQueryModify
    DefaultMatchType = fdMatchStart
    DefaultFilterBy = fdSmartFilter
    FieldsFetchMethod = fmUseTFields
    FieldOperators.OrChar = 'or'
    FieldOperators.AndChar = 'and'
    FieldOperators.NullChar = 'null'
    Rounding.Epsilon = 0.000100000000000000
    Rounding.RoundingMethod = fdrmFixed
    FilterPropertyOptions.LikeWildcardChar = '%'
    FilterOptimization = fdNone
    QueryFormatDateMode = qfdMonthDayYear
    SQLTables = <>
    SQLUpperString = 'Ucase'
    SQLPropertyName = 'CommandText'
    Left = 608
    Top = 184
  end
  object Customer1QueryDS: TDataSource
    DataSet = Customer1Query
    Left = 608
    Top = 216
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    AggregatesActive = False
    Constraints = <>
    DisableStringTrim = False
    FieldDefs = <
      item
        Name = 'Customer No'
        Attributes = [faUnNamed]
        DataType = ftInteger
      end
      item
        Name = 'Buyer'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Company Name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 40
      end
      item
        Name = 'First Name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Last Name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Street'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 60
      end
      item
        Name = 'City'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 25
      end
      item
        Name = 'State'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Zip'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'First Contact Date'
        Attributes = [faUnNamed]
        DataType = ftDate
      end
      item
        Name = 'Phone Number'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Information'
        Attributes = [faUnNamed]
        DataType = ftMemo
        Size = 80
      end
      item
        Name = 'RichEdit'
        Attributes = [faUnNamed]
        DataType = ftBlob
        Size = 80
      end
      item
        Name = 'Requested Demo'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Logical'
        Attributes = [faUnNamed]
        DataType = ftBoolean
      end>
    IndexDefs = <>
    FetchOnDemand = True
    ObjectView = True
    Params = <>
    ReadOnly = False
    StoreDefs = False
    Left = 664
    Top = 128
    Data = {
      334300009619E0BD01000000180000000F0076000000030000007B070B437573
      746F6D6572204E6F040001001000000005427579657201004900100001000557
      494454480200020003000C436F6D70616E79204E616D65010049001000010005
      57494454480200020028000A4669727374204E616D6501004900100001000557
      49445448020002001900094C617374204E616D65010049001000010005574944
      5448020002001900065374726565740100490010000100055749445448020002
      003C000443697479010049001000010005574944544802000200190005537461
      74650100490010000100055749445448020002001900035A6970010049001000
      0100055749445448020002000A0012466972737420436F6E7461637420446174
      6504000600100000000C50686F6E65204E756D62657201004900100001000557
      494454480200020014000B496E666F726D6174696F6E04004B00100002000753
      5542545950450200490005005465787400055749445448020002005000085269
      63684564697404004B0010000200075355425459504502004900070042696E61
      7279000557494454480200020050000E5265717565737465642044656D6F0100
      490010000100055749445448020002000300074C6F676963616C020003001000
      000001000A4348414E47455F4C4F470400820062010000010000000000000004
      0000000200000000000000040000000300000000000000040000000400000000
      0000000400000005000000000000000400000006000000000000000400000007
      0000000000000004000000080000000000000004000000090000000000000004
      0000000A00000000000000040000000B00000000000000040000000C00000000
      000000040000000D00000000000000040000000E00000000000000040000000F
      0000000000000004000000100000000000000004000000110000000000000004
      0000001200000000000000040000001300000000000000040000001400000000
      0000000400000015000000000000000400000016000000000000000400000017
      0000000000000004000000180000000000000004000000190000000000000004
      0000001A00000000000000040000001B00000000000000040000001C00000000
      000000040000001D00000000000000040000001E00000000000000040000001F
      0000000000000004000000200000000000000004000000210000000000000004
      0000002200000000000000040000002300000000000000040000002400000000
      0000000400000025000000000000000400000026000000000000000400000027
      0000000000000004000000280000000000000004000000290000000000000004
      0000002A00000000000000040000002B00000000000000040000002C00000000
      000000040000002D00000000000000040000002E00000000000000040000002F
      0000000000000004000000300000000000000004000000310000000000000004
      0000003200000000000000040000003300000000000000040000003400000000
      0000000400000035000000000000000400000036000000000000000400000037
      0000000000000004000000380000000000000004000000390000000000000004
      0000003A00000000000000040000003B00000000000000040000003C00000000
      000000040000003D00000000000000040000003E00000000000000040000003F
      0000000000000004000000400000000000000004000000410000000000000004
      0000004200000000000000040000004300000000000000040000004400000000
      0000000400000045000000000000000400000046000000000000000400000047
      0000000000000004000000480000000000000004000000490000000000000004
      0000004A00000000000000040000004B00000000000000040000004C00000000
      000000040000004D00000000000000040000004E00000000000000040000004F
      0000000000000004000000500000000000000004000000510000000000000004
      0000005200000000000000040000005300000000000000040000005400000000
      0000000400000055000000000000000400000056000000000000000400000057
      0000000000000004000000580000000000000004000000590000000000000004
      0000005A00000000000000040000005B00000000000000040000005C00000000
      000000040000005D00000000000000040000005E00000000000000040000005F
      0000000000000004000000600000000000000004000000610000000000000004
      0000006200000000000000040000006300000000000000040000006400000000
      0000000400000065000000000000000400000066000000000000000400000067
      0000000000000004000000680000000000000004000000690000000000000004
      0000006A00000000000000040000006B00000001000000080000006C00000002
      000000080000006D00000003000000080000006E00000004000000080000006F
      0000000500000008000000700000002D00000008000000710000007000000008
      000000720000006600000008000000730000006B000000080000007400000073
      0000000800000075000000710000000800000076000000740000000800000005
      000040105C010000024E6F0E4769616E7420506C756D62696E67044A6F686E07
      536368756C747A1547726567657273656E7376656A2C20504F20313431104665
      726E616E64696E6120426561636802464C0536363533347C1B0B000C3435322D
      3737332D30343434A20200007B5C727466315C616E73695C64656666305C6465
      667461623732307B5C666F6E7474626C7B5C66305C667377697373204D532053
      616E732053657269663B7D7B5C66315C66726F6D616E5C666368617273657432
      2053796D626F6C3B7D7B5C66325C66726F6D616E5C6663686172736574312054
      696D6573204E657720526F6D616E3B7D7B5C66335C66726F6D616E5C66636861
      72736574312054696D6573204E657720526F6D616E3B7D7B5C66345C66726F6D
      616E5C66707271322054696D6573204E657720526F6D616E3B7D7B5C66355C66
      7377697373204D532053616E732053657269663B7D7B5C66365C66726F6D616E
      2054696D6573204E657720526F6D616E3B7D7B5C66375C6673776973735C6663
      68617273657431204D532053616E732053657269663B7D7B5C66385C66737769
      73735C666368617273657431204D532053616E732053657269663B7D7D0D0A7B
      5C636F6C6F7274626C5C726564305C677265656E305C626C7565303B5C726564
      3132385C677265656E305C626C7565303B5C726564305C677265656E305C626C
      75653235353B7D0D0A5C6465666C616E67313033335C706172645C706C61696E
      5C66355C667331365C636631205468697320697320736F6D655C706C61696E5C
      66385C6673313620205C706C61696E5C66365C667334305C6366325C62205269
      6368204564697420546578740D0A5C706172205C706C61696E5C66365C667332
      305C6366325C62200D0A5C706172205C706C61696E5C66365C667332305C6366
      305C62204A7573742075736520746865206D6F75736520616E64207269676874
      2D636C69636B20746F20676574206D6F72652072696368207465787420656469
      74696E67206F7074696F6E732E0D0A5C706172205C706C61696E5C66385C6673
      3136200D0A5C706172207D0D0A00024E6F0500000010EC010000035965730C50
      6970205072696E74696E67044361726C064C6576696E65173936303720436F6D
      6D6F6E7765616C746820426C76642E0853616E204A6F73650243410539353131
      37A51B0B000C3037332D3537302D36373533DD01000057697468207468652049
      6E666F506F776572204F6E46696C746572206576656E742C20796F752063616E
      20636F6D706172652074776F206461746162617365206669656C647320776974
      682065616368206F746865722028666F72206578616D706C653A204669656C64
      31203C204669656C6432292C20646F206269747769736520636F6D7061726973
      6F6E7320696E206669656C64732C20686176652066696C746572732064657065
      6E64656E742075706F6E206F746865722072656C61746564207461626C65732C
      206F7220616E797468696E6720656C736520796F752063616E20657870726573
      7320696E20636F64652E2054686973206576656E74206973206D6F7374207072
      6163746963616C207768656E207573656420616761696E7374206C6F63616C20
      7461626C6573202850617261646F78206F722064424153452920626563617573
      65207768656E207573656420616761696E73742053514C207461626C65732C20
      746865206261636B2D656E642064617461626173652073797374656D20697320
      70726576656E7465642066726F6D206F7074696D697A696E6720746865206669
      6C7465722C2073696E6365206576657279207265636F72642069732070617373
      656420746F2074686973206576656E742E0D0AA20200007B5C727466315C616E
      73695C64656666305C6465667461623732307B5C666F6E7474626C7B5C66305C
      667377697373204D532053616E732053657269663B7D7B5C66315C66726F6D61
      6E5C6663686172736574322053796D626F6C3B7D7B5C66325C66726F6D616E5C
      6663686172736574312054696D6573204E657720526F6D616E3B7D7B5C66335C
      66726F6D616E5C6663686172736574312054696D6573204E657720526F6D616E
      3B7D7B5C66345C66726F6D616E5C66707271322054696D6573204E657720526F
      6D616E3B7D7B5C66355C667377697373204D532053616E732053657269663B7D
      7B5C66365C66726F6D616E2054696D6573204E657720526F6D616E3B7D7B5C66
      375C6673776973735C666368617273657431204D532053616E73205365726966
      3B7D7B5C66385C6673776973735C666368617273657431204D532053616E7320
      53657269663B7D7D0D0A7B5C636F6C6F7274626C5C726564305C677265656E30
      5C626C7565303B5C7265643132385C677265656E305C626C7565303B5C726564
      305C677265656E305C626C75653235353B7D0D0A5C6465666C616E6731303333
      5C706172645C706C61696E5C66355C667331365C636631205468697320697320
      736F6D655C706C61696E5C66385C6673313620205C706C61696E5C66365C6673
      34305C6366325C622052696368204564697420546578740D0A5C706172205C70
      6C61696E5C66365C667332305C6366325C62200D0A5C706172205C706C61696E
      5C66365C667332305C6366305C62204A7573742075736520746865206D6F7573
      6520616E642072696768742D636C69636B20746F20676574206D6F7265207269
      636820746578742065646974696E67206F7074696F6E732E0D0A5C706172205C
      706C61696E5C66385C66733136200D0A5C706172207D0D0A00024E6F05000000
      10FA010000035965730954656C652D5061746806526162626974054F6C64656E
      1B3134363020496E666F726D6174696F6E20546563682E20496E632E03417274
      0254580537363832302E1C0B000C3138372D3531372D303536309B0000004D6F
      7665204D6F757365204F7665722043656C6C730D0A0D0A4175746F6D61746963
      20546F6F6C20546970732048696E747320646973706C617920666F7220746578
      7420746861742077696C6C206E6F742066697420696E20746865206375727265
      6E742063656C6C2E0D0A48696E747320737570706F727420776F726477726170
      20616E6420637573746F6D697A6564207769647468732E0D0AA20200007B5C72
      7466315C616E73695C64656666305C6465667461623732307B5C666F6E747462
      6C7B5C66305C667377697373204D532053616E732053657269663B7D7B5C6631
      5C66726F6D616E5C6663686172736574322053796D626F6C3B7D7B5C66325C66
      726F6D616E5C6663686172736574312054696D6573204E657720526F6D616E3B
      7D7B5C66335C66726F6D616E5C6663686172736574312054696D6573204E6577
      20526F6D616E3B7D7B5C66345C66726F6D616E5C66707271322054696D657320
      4E657720526F6D616E3B7D7B5C66355C66726F6D616E2054696D6573204E6577
      20526F6D616E3B7D7B5C66365C6673776973735C666368617273657431204D53
      2053616E732053657269663B7D7B5C66375C667377697373204D532053616E73
      2053657269663B7D7B5C66385C6673776973735C666368617273657431204D53
      2053616E732053657269663B7D7D0D0A7B5C636F6C6F7274626C5C726564305C
      677265656E305C626C7565303B5C726564305C677265656E305C626C75653235
      353B5C7265643132385C677265656E305C626C7565303B7D0D0A5C6465666C61
      6E67313033335C706172645C706C61696E5C66375C667331365C636632205468
      697320697320736F6D655C706C61696E5C66385C6673313620205C706C61696E
      5C66355C667334305C6366315C622052696368204564697420546578740D0A5C
      706172205C706C61696E5C66355C667332305C6366315C62200D0A5C70617220
      5C706C61696E5C66355C667332305C6366305C62204A75737420757365207468
      65206D6F75736520616E642072696768742D636C69636B20746F20676574206D
      6F7265207269636820746578742065646974696E67206F7074696F6E732E0D0A
      5C706172205C706C61696E5C66385C66733136200D0A5C706172207D0D0A0002
      4E6F0500004011DC0200000359657303484D5303526564064361726E65791F31
      30303020506173656F2043616D6172696C6C6F2C205375697465203231350447
      75797302544E053338333339D61C0B000C3533392D3830352D30363830024E6F
      05000040115E030000035965730B53746172205265636F7273054A6F616E6E05
      526F7965720C502E4F2E20426F78203732370842656576696C6C650254580537
      38313032AF1B0B000C3539352D3130322D30313738024E6F0400004011690300
      00035965731C496E7465726E6174696F6E616C20466F6F642045717569706D65
      6E7403426F62074D634D6168656C1F3130303020506173656F2043616D617269
      6C6C6F2C20537569746520323135065075746E616D024354053036323630AC1C
      0B000C3535312D3732362D38313636024E6F040000401190030000024E6F1448
      6F6C646572277320436F756E74727920496E6E07436861726C65730554726163
      7911313534312041646469736F6E20526F61640C42656C6C6520506C61696E65
      024941053532323038EB1B0B000C3536302D3338382D34323739024E6F040000
      4011C5030000024E6F0C466F616D20526F6F66696E67044D61726B0652616E6B
      696E0D36303030204A205374726565740941504F204D69616D6902464C053334
      3033334A1C0B000C3236312D3436362D39363635024E6F04000040114C040000
      024E6F1244616C6C6173205368656574204D6574616C0648616E6E616805546F
      7272651033333020436F6D6D657263652053742E074368696361676F02494C05
      36303634348E1C0B000C3035342D3133322D38363838024E6F04000040115C04
      0000024E6F0C546172616E636520436F7270064C65616E6E6508426F72726573
      656E16504F20426F78203631393631362C204D442033313130054E656F6C6102
      4941053531353539071C0B000C3031362D3033372D32383934024E6F04000040
      116604000003596573094153415020436F72700D456D706C6F79656520323536
      30064865737365722254686520477265656E7761792C20363320576172646C65
      20526F61642C2053616C65074D63204C65616E025458053739303537A11B0B00
      0C3634322D3133352D31343834024E6F040000401119050000035965730D4D6F
      7573652053797374656D73084A616D657320462E094C6F72656E747A656E1337
      35303120466F6F7468696C6C20426C76642E084A61726269646765024E560538
      393832366B1C0B000C3933362D3230392D31373730024E6F0400004011400500
      000359657314446976657273696669656420436F6D70757465720548656E7279
      054B6F666F641334363230204D696E6E65736F7461204176652E0B4761696E65
      7376696C6C6502464C053332363130861C0B000C3232352D3135322D30373432
      024E6F040000401147050000024E6F0B412644205265736561726303526F640A
      4D63436C696E746F636B0D48434F3120426F78203432414106497276696E6702
      5458053735303135D41C0B000C3036302D3531322D39383636024E6F04000040
      1162050000024E6F0D4A616D6573202620426C6F636B034A696D085363687761
      72747A123633303020537761696E6C616E642052642E0757617665726C790256
      41053731363734B51B0B000C3837372D3338352D38393833024E6F0400004011
      7C050000024E6F0E4265726B656C65792047726F757007526963686172640552
      6561676F0E3134303120426F6767732044722E0C44756E63616E7376696C6C65
      0250410531363633359E1B0B000C3637362D3239312D31393833024E6F040000
      401131060000035965731447726F757020313320436F6E73756C74616E747307
      45726E6573746F0B53616C76657374726F6E691132353420576573746669656C
      642053742E07446574726F6974024D49053438323130AF1B0B000C3134362D37
      38322D30353036024E6F04000040114D060000035965730B4865616C7468496D
      61676505537465766505526F757365113834313620436861737461696E204472
      2E084D696C6C776F6F64024B59053432373632AF1B0B000C3937342D3235352D
      30383736024E6F04000040114F0600000359657318486F7573746F6E204C6967
      6874696E67202620506F7765720448756768055768797465123139204F6C6420
      4869636B6F72792052642E0741746C616E7461024741053330333637811C0B00
      0C3437312D3130362D37303536024E6F0400004011DA070000024E6F18436169
      6E264162656C20436F6D6D756E69636174696F6E7305436C697665084E6F7274
      68726F70143735303120466F6F7468696C6C7320426C76642E094C6F6E652053
      746172025343053239303737981B0B000C3331372D3233342D39323237024E6F
      0400004011EA07000003596573094769616E744C616E64044E69636B064C6974
      746C6511526F7574652031382C20426F78203432300943726F6F6B73746F6E02
      4E45053639323132C41C0B000C3336312D3930352D32323230024E6F04000040
      1105080000024E6F0F546F797320457665727977686572650752696368617264
      0259751F323437392050656163687472656520526F61642C2053756974652031
      3731300B506F727420417274687572025458053737363433C21B0B000C343734
      2D3637392D36343232024E6F04000040112B080000024E6F104164766F636174
      652053797374656D730553636F7474064C6F7669636B1332325733333020576F
      6F64766965772044722E09537461726C696768740250410531383436312E1C0B
      000C3535312D3733302D35383337024E6F040000401183080000024E6F0B5370
      696E6520436F72702E08504F2334363430340750696E68617369123736353520
      4561737420343674682053742E0748616D70746F6E025641053233363637A01B
      0B000C3730342D3537322D30313934024E6F0400004011F20800000359657311
      4372797374616C20426C756520496E632E044465616E074A696D656E657A1D31
      313120416E7A6120426F756C65766172642C205375697465203230300D4E6F72
      7468204368617468616D024D41053032363530D11B0B000C3338352D3636302D
      30323938024E6F04000040118A090000035965730C4144412050726F64756374
      73074A6F686E20452E05536361666611313430204361736361646520426C7664
      2E0457697365025641053234323933AA1C0B000C3637332D3735322D31323932
      024E6F0400004011A609000003596573165370656369616C2053657276696365
      20262043617265084A616D657320462E07466F726468616D1D33372045617374
      2043656E7465722053742E2C20537569746520323130064D656C76696E02494C
      0536303935325D1C0B000C3737352D3431372D36363739024E6F0400004011D1
      090000035965730B425341204C696D69746564044D696B650553657272610C4B
      616E61616C7765672033330D57696E7465722047617264656E02464C05333237
      38372E1C0B000C3537362D3534382D33373630024E6F0400004011EC09000003
      59657313416C756D696E756D20546563686E6F6C6F677907446F726F74687906
      426F776C65721B3132313820337264204176656E75652C205375697465203138
      30390857696C6C69616D73024F520539373534348E1C0B000C3630382D303639
      2D35333438024E6F04000040110A0A0000035965731C57696E64736F72205265
      616C747920262045717569747920436F7270035975650443686F650F32303820
      56616C6C657920526F61640A53636F747473626F726F02414C053335373638CE
      1C0B000C3035312D3939302D31393131024E6F0400004011BD0A000003596573
      1153696D736275727920417175617469637305456C76696E064361726E657921
      3333303020426174746C6567726F756E64204176652E2C205375697465203232
      32074375747368696E024B59053431373332A81C0B000C3538362D3639342D39
      353032024E6F0400004011E70A0000035965730F53696C76657220536F667477
      6172650653616E647261084B656E647269636B2033383820477265656E776963
      682053742E2C20466C6F6F7220313520576573740B4E6577204F726C65616E73
      024C41053730313436701B0B000C3537382D3236332D30313230024E6F040000
      40114B0B0000035965730B54617267657420496E632E084861727265736F6E05
      4F6C64656E1B323130204561737420313574682053742E2C2053756974652039
      520847617076696C6C65024B59053431343333AA1C0B000C3837362D3735382D
      31343336024E6F0400004011530B00000359657310536F6C7665497420436F6D
      7075746572044D617474074272696467657315323830383120536F7574686669
      656C6420526F6164044D616C6F025741053939313530051D0B000C3433302D32
      31312D30373838024E6F0400004011570B000003596573094D6F62696C204F69
      6C0A436861726C6573204C2E094D6F7272697373657915352046697220436F75
      72742C20537569746520314109436861726C6F747465024E430532383233335F
      1C0B000C3731392D3139372D39323834024E6F04000040119A0B0000024E6F04
      536F6E7909476572616C6420502E04536175720C31343020486F6C742052642E
      0B42726F6F6B65736D697468025458053736383237A11C0B000C3435322D3937
      342D37373434024E6F0400004011C40B0000035965730F4D6579657220417070
      6C69616E636503426F620553746F6E6511353130204F6365616E204176652E20
      2331045A61686C024E44053538383536C11B0B000C3537392D3837352D373936
      38024E6F0400004011D30B000003596573065A656E697468064861726F6C6408
      536368616566657222555620436F6C6C6567652053616C666F72642C20467265
      64657269636B20526F61640B50616E6E61204D61726961025458053738313434
      B01B0B000C3731352D3430322D31363533024E6F0400004011190C0000024E6F
      0F4869676820546563686E6F6C6F67790553746576650743616C617961671132
      34333020436F6E7361756C20526F61640E506C656173616E742047726F766502
      5554053834303632741B0B000C3936312D3633342D33313531024E6F04000000
      11710C00000359657312496E74656772617465642053797374656D7303456473
      05416E69646F133130333135204D6F756E7461696E205061726B084F616B2048
      616C6C025641053233343136CA1B0B000C3238342D3237332D343034309D0000
      005468697320697320736F6D652073616D706C65207465787420746861742067
      6F657320696E746F2061206D656D6F206669656C642E0D0A0D0A546F20706F70
      2D7570207468697320656469746F722C2065697468657220646F75626C652D63
      6C69636B20746865206D656D6F206669656C64206F7220656E74657220463220
      7768656E20746865206D656D6F206669656C64206973206163746976652E024E
      6F0400004011810C0000035965731853797374656D20456C6576656E20417373
      6F636961746573044A6F686E05426C61636B08426F7820353233310B4C616B65
      20417274687572024E4D053838323533381D0B000C3738302D3136342D343232
      33024E6F0400004011AC0C00000359657312537072696E7420436F72706F7261
      74696F6E054A616D657306486F75736572133434392053696C6173204465616E
      65204877790744616E62757279024354053036383136A01B0B000C3230352D38
      39312D32323838024E6F0400004011CB0C0000024E6F104F72616E676520436F
      6D707574657273074A6F686E20482E0642696C69636B15323334362050616E6F
      72616D6120546572726163650654656E646F79024944053833343632B01C0B00
      0C3736382D3133392D31323530024E6F0400004011640D0000035965730E416D
      6920436F6D706F6E656E747303426F620749756C69616E6F1132343830204C61
      6B65736964652044722E064C6177746F6E025041053138383238C21B0B000C32
      39362D3231312D32363835024E6F0500000011D20E0000024E6F0B576865656C
      20576F726B73044361726C04426167651B3133343535204E6F656C20526F6164
      2C20537569746520313735300641796C657474025641053233303039A41B0B00
      0C3737312D3834392D37383839020100004D6F7665204D6F757365204F766572
      205468697320477269642043656C6C2E0D0A0D0A496E666F506F776572203230
      3030206175746F6D61746963616C6C7920646973706C61797320746865206675
      6C6C2074657874206F6620612063656C6C206173206120746F6F6C2074697020
      7768656E20746865206D6F757365206973206D6F766564206F76657220612063
      656C6C2074686174206973206E6F74206C6172676520656E6F75676820746F20
      646973706C617920616C6C206F662074686520746578742E2054686520746F6F
      6C207469707320616C736F20737570706F7274206D656D6F206669656C647320
      616E64206D756C7469706C65206C696E65732E024E6F0400004011330F000003
      59657312416D65726963612773205469726520436F2E0654686F6D6173044675
      6E67213333303020426174746C6567726F756E64204176652E2C205375697465
      20323232064C616D6F6E74024D490534393433308B1C0B000C3630342D383536
      2D33353038024E6F040000401129100000035965730F54726176656C20496E73
      69646572730447726567054869636B73143534204176656E7565206465204368
      616D70656C074E6F76656C7479024D4F0536333436306B1C0B000C3735322D31
      33322D38333733024E6F040000401195100000024E6F1743656E7472616C2041
      6E696D616C20486F73706974616C0A5269636861726420422E0442656C6C1534
      3431372050697463682050696E6520436F7572740942726164656E746F6E0246
      4C053334303933A51B0B000C3636312D3131382D33383339024E6F0400004011
      D1100000024E6F0D44696E6120536572766963657303546F6D054C6577697310
      3139323220416C62657274612044722E07446563617475720247410533303033
      34741B0B000C3038322D3038382D32333236024E6F0400004011011100000359
      65730B4F666669636520496E632E0757696C6C69616D0A56616E6465726C6161
      6E1A313239352053746174652053742E2C20446570742E204B313632064D616E
      64616E024E44053538353534751B0B000C3033342D3236382D38303231024E6F
      0400004011B8120000024E6F0E4D65747269632053797374656D73034B696D0A
      4D63436C696E746F636B103231323020532E2054686F6D70736F6E064175726F
      726102434F0538303031350B1C0B000C3630302D3439322D37373137024E6F04
      000040118B130000035965731054656C6C61204379636C652053686F70045061
      756C07537769747A657210323138204361726F6C696E612043742E075374616E
      6C6579024B59053432333735EF1B0B000C3933352D3334342D37343632024E6F
      040000401138140000035965730F526F636B657420536F667477617265084465
      76696E646572094A61696B6F77736B6910353038322047617A616E6961204472
      2E0857616B6172757361024B53053636353436EB1B0B000C3031392D3433302D
      36373336024E6F04000040117A140000024E6F1753742E204C6F75697320486F
      7573696E6720446570742E03526F6E095363686F656E6572740B373020426F77
      20526F61640950656E7361636F6C6102464C053332353935DE1B0B000C333633
      2D3133392D35303837024E6F040000401129150000035965730E466C6F707079
      2053797374656D730553636F74740553686172701D353733372054686F726E68
      696C6C2044722E2C20537569746520323037095761746572666F726402574905
      3533313835B71C0B000C3836312D3431342D37393638024E6F0400004011A115
      0000035965730D53757072656D6520466F6F6473084861727265736F6E054672
      69736B10353730302047726967677320526F616406546F6C65646F024F480534
      33363233CF1B0B000C3035392D3533362D35313530024E6F0400004011AD1500
      00035965731442756C6C65742D70726F6F662053797374656D730444616C6504
      4D61726B1E507269766174652042616720343030352C204B696D6265726C7920
      52642E0B4761696E657376696C6C6502464C0533323630388B1C0B000C363533
      2D3438372D30313436024E6F0400004011331600000359657313416C61736B61
      20437275697365204C696E657309446F6D696E69717565084970706F6C69746F
      1831313520572E2039397468205465727261636520233330360943726F636865
      726F6E024D44053231363237C21B0B000C3434312D3336372D38373238024E6F
      040000401170160000035965730A4D656C6F6E2053686F70044E69636B064661
      6C6C6F6E0D3834313920357468204176652E09436F6E6F77696E676F024D4405
      3231393138AE1B0B000C3830322D3431322D32353337024E6F04000040118016
      0000035965730C506163696669632042656C6C044E65616C07436F6C656D616E
      0C352057616C6C65722043742E0B416E676C6520496E6C6574024D4E05353637
      3131FD1B0B000C3738392D3137332D34393530024E6F04000040118416000002
      4E6F0D4C6F6769632053797374656D73044D617474044B696E67123739333220
      4265616368776F6F642043742E06546F70656B61024B53053636363039BD1B0B
      000C3931362D3836372D39313431024E6F0400004011D2160000035965731A53
      616E746120436C617261204D65646963616C2043656E74657205537465766507
      4875626265727418323520572E20343574682053742E2C20526F6F6D20323031
      09526F63686573746572024E59053134363532AF1B0B000C3531392D3837352D
      32333436024E6F0400004011FC160000035965731448656C6D20506174696F20
      4675726E69747572650A4174746E3A204361726C0452616D701931205075626C
      6963205371756172652C205374652E20323035085374616D666F726402435405
      30363931337B1B0B000C3231342D3238372D31373331024E6F04000040111417
      0000035965730F426C61636B6265727279204661726D074761796E6172640853
      63686163686174103531362042757263686574742053742E0552616D65720241
      4C053336303639741B0B000C3938342D3733382D35313630024E6F0400004011
      7717000003596573134C696265727479205375706572205072696E74054C6F67
      616E07536166746C657213363020576573742031337468205374726565740548
      616E6E61025759053832333237751B0B000C3236332D3334322D39373339024E
      6F0400004011B6170000035965731044617461626173652044657369676E7309
      41647269616E20522E08537465726C696E6712383031204E6F72746820333173
      742053742E074C696C6C69616E02414C0533363534393F1C0B000C3033372D30
      36302D36303037024E6F04000040111E180000024E6F0B5265636F7264204261
      726E044D696B6504526565730E3130313737204C616B65736964650B57657761
      68697463686B6102464C053332343439C81B0B000C3836362D3232332D373539
      36024E6F0400004011671800000359657312416D65726963616E205265642043
      726F73730941647269616E20522E07436F6E6472656E15323135312043616E79
      6F6E20437265656B2044722E085768697474696572024341053930363033931C
      0B000C3038312D3738372D30333034024E6F0400004011021900000359657311
      537472617465677920536F667477617265044A6F686E0749756C69616E6F1D31
      333130205761756B6567616E20526F61642C205375697465203130340852616E
      64616C6961024941053532313634D01B0B000C3538302D3433342D3333393002
      4E6F040000401129190000035965731150617274792054696D652043656E7465
      7202416C06486174746F6E0F32382048657269746167652052642E064372656F
      6C65024C41053730363332101C0B000C3930372D3539302D37333330024E6F04
      0000401147190000035965730C50595445204C696D6974656405436C61726B07
      466F67657274791338303032205061726B2043726573742044722E0654697074
      6F6E024B53053637343835D21B0B000C3130322D3430352D37343731024E6F04
      0000401197190000024E6F16416D65726963616E2052656E74616C2043656E74
      657203546F6D074265617264656E0C31343020486F6C742052642E0D57696E73
      746F6E2D53616C656D024E43053237313536C11B0B000C3931322D3732382D38
      343831024E6F0400004011A21900000359657311496E7465725472616B205379
      7374656D73055761796E650557616C6C730C33353135205720546F7568790C57
      696C6C69616D7362757267024E4D053837393432C41B0B000C3533322D333538
      2D37363836024E6F0400004011A9190000024E6F1A50726F6772616D20537570
      706F7274204173736F63696174657303526F6E074D6F75726176611132353420
      576573746669656C642053742E0B5374726F6E672043697479024B5305363638
      3639711C0B000C3035352D3137362D36343436024E6F04000040114A1A000003
      5965730B393920536F667477617265074D69636861656C06506F736E65720A50
      4F20426F78203434310E4E6F7274682042726F6F6B6C696E024D450530343636
      31CB1C0B000C3034362D3332302D39393937024E6F0400004011791A00000359
      657313416C6D6F6E6420546563686E6F6C6F67696573034D656C074F274E6569
      6C6C1231373820426C61636B666F7264204176652E0D4E6F72746820486F6F73
      69636B024E59053132313333BB1C0B000C3239382D3034312D37313335024E6F
      0400004011891A00000359657305496E74656C07436861726C65730943617270
      656E746572113234303720436861726C6573204176652E06576178686177024E
      43053238313733B51B0B000C3234392D3832352D35353539024E6F0400004011
      B51A000003596573144F7368204B6F736820547275636B20436F72702E055761
      796E65044B6F6F741231323635352042656174726963652053742E0448616C6C
      024E59053134343633DA1B0B000C3335322D3638392D36363737024E6F040000
      4011F71A0000035965730E4B696E6B6F277320436F7069657306546F70616E69
      07537665746C696B0F3536303520476F6C64636F2044722E0646616E6E696E02
      5458053737393630661C0B000C3536382D3230342D38323633024E6F04000040
      11331C0000035965731E556E697465642050686F746F6772617068696320496E
      6475737472696573084A616D657320462E0543726F73731231363435204E6F72
      746820426172636C61790941737361776F6D616E0256410532333330327C1B0B
      000C3136362D3831382D31353038024E6F04000040113F1C000003596573134C
      69676874686F75736520536572766963657305576F6F64790346727912373720
      42726F61642041637265732052642E07526F616E6F6B65025641053234303134
      801C0B000C3339392D3730342D33333833024E6F0400004011C41C0000035965
      730D4361726565722043656E74657206446F6E616C64075061636865636F0F32
      333037204F7265676F6E2053742E07486F7573746F6E025458053737303039C4
      1C0B000C3237332D3834342D33353136024E6F0400004011141D0000024E6F0F
      416E646572736F6E205374616D707305416C6C656E084F6C69766172657A1736
      31302057657374204C6F75697369616E6E612053742E074A7570697465720246
      4C053333343738B91B0B000C3131352D3832312D30373033024E6F0400004011
      E91D00000359657316456666696369656E74204C69676874696E6720436F2E07
      46656C65636961044B756E7A0B504F20426F782037313531094C6F7474736275
      72670256410532323531317B1C0B000C3034322D3333322D37323135024E6F04
      00004011651E0000035965731155534B204D616E75666163747572696E670653
      79646E6579064D6347726177113637323020506F747265726F204176652E0946
      61726D76696C6C65025641053233393433FD1B0B000C3635332D3131392D3133
      3137024E6F0400004011721E0000024E6F15457665205072696E74696E672053
      657276696365730653616E64726107456C6C696F747426323030206861727279
      20532E205472756D616E205061726B7761792C20537569746520323230074465
      6572696E67024D4F053633383430CF1C0B000C3434322D3133352D3332333402
      4E6F0400004011A11E0000024E6F135374617465206F662057617368696E6774
      6F6E0354696D08536368616566657211333630352050656C75636361204C616E
      65084D696E6E656F7461024D4E053536323634B31B0B000C3636332D3731382D
      31343933024E6F0400004011C41E0000024E6F204172697A6F6E612044657074
      2E206F66204865616C74682053657276696365730752616E64656C6C04487572
      6410363020456173742034326E642053742E0F5368656C646F6E20537072696E
      6773025654053035343835151C0B000C3038302D3832302D34383137024E6F04
      00004011211F00000359657305525043494F0354696D0743616E646C65721131
      38204C6976696E6773746F6E2044722E0942616C74696D6F7265024D44053231
      323230751B0B000C3433342D3633352D39383335024E6F04000040114B1F0000
      035965731B416C61736B61205065726D616E656E742046756E6420436F72702E
      064A6F73657068075175657665646F1834313220536F7574682050656E646C65
      746F6E204176652E07436C696E746F6E024F480534343231361E1C0B000C3437
      322D3431322D35303330024E6F0400004011EA1F0000024E6F154A6170616E20
      54726164696E6720436F6D70616E79034A696D07426172746173681436353232
      20452E2046726565706F72742044722E0D506F7274204D6F6E6D6F757468024E
      4A0530373734365F1B0B000C3438332D3838302D31393639024E6F0400004011
      86200000035965731C54616D70612042617920496E666F726D6174696F6E2043
      656E74657206546F70616E690644654D6F6F790E313239352053746174652053
      742E07486F7573746F6E025458053737303237741B0B000C3435372D3638352D
      39373434024E6F040000401106210000035965730953746172686F7573650644
      6F7269616E064361726E65791D343430205765737420456E64204176656E7565
      2C2053756974652033450C4561737420436F72696E7468024D45053034343237
      B91C0B000C3038392D3837322D37393835024E6F0400004011A7210000035965
      73115072756E65796172642056696C6C61676504416C616E074265636B68616D
      27446570742E206F66204465636973696F6E202620496E666F726D6174696F6E
      2053797374656D73054F6764656E0255540538343430302A1C0B000C3633392D
      3636322D31353332024E6F0400004011AF210000024E6F0B4461746120446972
      656374074D656C696E6461064C696E646572163830312053696D70736F6E2C20
      53756974652031303008436F6C756D6275730247410533313930347C1B0B000C
      3432342D3935392D38343535024E6F040000401155220000035965731753696D
      706C696669656420504320536F6C7574696F6E73054C61727279045061636B26
      4F6E65204D61726B65742C2053706561722053742E20546F7765722C20537465
      2E203135303105536F647573024D49053439313236A41B0B000C3134382D3436
      332D34363332024E6F0400004011CD2200000359657312466F7820436F6D6D75
      6E69636174696F6E73074361726C20422E0652696363696F1931205075626C69
      63205371756172652C205374652E203230350641706F706B6102464C05333237
      3033EB1B0B000C3232382D3738322D39333733024E6F04400040110C23000003
      5965731C42206F6620412C204D6F7274676167652053616C65732047726F7570
      054B6F6C74731131313436205661737075657A204176652E0A53616E20416361
      636961024E4D0538373833316B1C0B000C3636332D3738372D38323131024E6F
      0400004011A023000003596573104567676865616420536F6674776172650454
      6F6E79054973616B69133135303020452E2044756172746520526F61640C4150
      4F204E657720596F726B024E59053039303735D41C0B000C3237322D3535342D
      37343938024E6F040000401130240000024E6F16496E7465726E6174696F6E61
      6C20536F667477617265074265726E61726407526573736C65720E3232363020
      32367468204E2E572E04416C766102464C0533333932306B1C0B000C3337302D
      3337382D38323333024E6F0400004011CB240000035965731356697375616C20
      446174612053797374656D7306536C6174657208486174686177617915526F6F
      6D20353033382C204F78666F72642052642E08576F727468696E670253440535
      37303737AF1B0B000C3335332D3834342D31363934024E6F0500000011F82400
      00035965730D446176697320526F6F66696E67044A6566660742617274617368
      17313136204D61696E2053742E2C205375697465203238320854616D696D656E
      74025041053134313235C21B0B000C3530322D3536302D343032322400000044
      6F75626C6520636C69636B206865726520746F2065646974206D656D6F206669
      656C64024E6F04000040111A250000024E6F18477265656E62726F6F6B205069
      616E6F20536572766963650354696D08466C656D6D696E6711353130204F6365
      616E204176652E20233106536F6E746167024D53053339363635C71C0B000C36
      39392D3134302D32363939024E6F040000401160250000024E6F11524C572050
      6572736F6E616C2043617265054A6F68616E05426C61636B1A31323935205374
      6174652053742E2C20446570742E204B313632074D616469736F6E0257490535
      33373037D21B0B000C3131352D3436372D39303432024E6F04000040119F2500
      00024E6F165261796E652047617264656E696E672043656E7465720550657465
      72044465616E1532313339204E2E2041636164656D7920426C76642E0C4D756E
      666F726476696C6C65024B59053432373635751B0B000C3330362D3930382D31
      323332024E6F040000401167260000024E6F0743686576726F6E044A6F686E05
      4D6F6F72651E4E6F727468676174652045786563204374722049492C20537465
      203430300E54686F7573616E64737469636B73024B590534313736362E1C0B00
      0C3538312D3438352D34383434024E6F0D000040125C010000024E6F0E476961
      6E7420506C756D62696E67044A6F686E07536368756C747A1547726567657273
      656E7376656A2C20504F20313431104665726E616E64696E6120426561636802
      464C0534333232367C1B0B000C3435322D3737332D30343434024E6F0C000080
      12EC010000035965730C506970205072696E74696E67044361726C064C657669
      6E65173936303720436F6D6D6F6E7765616C746820426C76642E0853616E204A
      6F7365024341053332373230A51B0B000C3037332D3537302D36373533024E6F
      0C00008012FA010000035965730954656C652D5061746806526162626974054F
      6C64656E1B3134363020496E666F726D6174696F6E20546563682E20496E632E
      0341727402545801002E1C0B000C3138372D3531372D30353630024E6F0C0000
      4011DC0200000359657303484D5303526564064361726E65791F313030302050
      6173656F2043616D6172696C6C6F2C2053756974652032313504477579730254
      4E053334303233D61C0B000C3533392D3830352D30363830024E6F0C00004011
      5E030000035965730B53746172205265636F7273054A6F616E6E05526F796572
      0C502E4F2E20426F78203732370842656576696C6C65025458053636353334AF
      1B0B000C3539352D3130322D30313738024E6F0D00008011D20E0000024E6F0B
      576865656C20576F726B73044361726C04426167651B3133343535204E6F656C
      20526F61642C20537569746520313735300641796C6574740256410533303030
      31A41B0B000C3737312D3834392D37383839024E6F0D00008011D20E0000024E
      6F0B576865656C20576F726B73044361726C04426167651B3133343535204E6F
      656C20526F61642C20537569746520313735300641796C657474025641053636
      353334A41B0B000C3737312D3834392D37383839024E6F0C00008011F8240000
      035965730D446176697320526F6F66696E67044A656666074261727461736817
      313136204D61696E2053742E2C205375697465203238320854616D696D656E74
      025041053636353334C21B0B000C3530322D3536302D34303232024E6F0D0000
      40125C010000024E6F0E4769616E7420506C756D62696E67044A6F686E075363
      68756C747A1547726567657273656E7376656A2C20504F20313431104665726E
      616E64696E6120426561636802464C0534333232368D1C0B00083332342D3332
      3432024E6F0D000040125C010000024E6F0E4769616E7420506C756D62696E67
      044A6F686E07536368756C747A1547726567657273656E7376656A2C20504F20
      313431104665726E616E64696E6120426561636802464C0533323033348D1C0B
      00083332342D33323432024E6F0C00008011D20E0000024E6F0B576865656C20
      576F726B73044361726C04426167651B3133343535204E6F656C20526F61642C
      20537569746520313735300641796C657474025641053432303031A41B0B000C
      3737312D3834392D37383839024E6F0C000040125C010000024E6F0E4769616E
      7420506C756D62696E67044A6F686E07536368756C747A154772656765727365
      6E7376656A2C20504F20313431104665726E616E64696E612042656163680246
      4C0532343331318D1C0B00083332342D33323432024E6F}
  end
  object Customer1Query: TADOQuery
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=..\db\nwind.mdb;Per' +
      'sist Security Info=False'#9
    CursorType = ctStatic
    CommandTimeout = 30
    ParamCheck = True
    Parameters = <>
    Prepared = False
    SQL.Strings = (
      'Select * from Customers')
    Left = 640
    Top = 216
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandTimeout = 30
    ParamCheck = True
    Parameters = <>
    Prepared = False
    SQL.Strings = (
      'Select distinct '
      ' Customers.CustomerID,'
      ' Customers.CompanyName,'
      ' Customers.City'
      ' from Customers,Orders'
      'WHERE (CUSTOMERS.CUSTOMERID=ORDERS.CUSTOMERID)')
    Left = 640
    Top = 304
    object ADOQuery1CustomerID: TWideStringField
      DisplayWidth = 5
      FieldName = 'CustomerID'
      Size = 5
    end
    object ADOQuery1CompanyName: TWideStringField
      DisplayWidth = 40
      FieldName = 'CompanyName'
      Size = 40
    end
    object ADOQuery1City: TWideStringField
      DisplayWidth = 15
      FieldName = 'City'
      Size = 15
    end
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandTimeout = 30
    DataSource = Customer2QueryDS
    ParamCheck = True
    Parameters = <
      item
        Name = 'CustomerID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = 'ANTON'
      end>
    Prepared = False
    SQL.Strings = (
      'Select * from Orders'
      'where Orders.CustomerID=:CustomerID')
    Left = 704
    Top = 304
    object ADOQuery2OrderID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'OrderID'
      ReadOnly = True
    end
    object ADOQuery2CustomerID: TWideStringField
      DisplayWidth = 5
      FieldName = 'CustomerID'
      Size = 5
    end
    object ADOQuery2EmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
    end
    object ADOQuery2OrderDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'OrderDate'
    end
    object ADOQuery2RequiredDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'RequiredDate'
    end
    object ADOQuery2ShippedDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ShippedDate'
    end
    object ADOQuery2ShipVia: TIntegerField
      DisplayWidth = 10
      FieldName = 'ShipVia'
    end
    object ADOQuery2Freight: TBCDField
      DisplayWidth = 20
      FieldName = 'Freight'
      Precision = 19
    end
    object ADOQuery2ShipName: TWideStringField
      DisplayWidth = 40
      FieldName = 'ShipName'
      Size = 40
    end
    object ADOQuery2ShipAddress: TWideStringField
      DisplayWidth = 60
      FieldName = 'ShipAddress'
      Size = 60
    end
    object ADOQuery2ShipCity: TWideStringField
      DisplayWidth = 15
      FieldName = 'ShipCity'
      Size = 15
    end
    object ADOQuery2ShipRegion: TWideStringField
      DisplayWidth = 15
      FieldName = 'ShipRegion'
      Size = 15
    end
    object ADOQuery2ShipPostalCode: TWideStringField
      DisplayWidth = 10
      FieldName = 'ShipPostalCode'
      Size = 10
    end
    object ADOQuery2ShipCountry: TWideStringField
      DisplayWidth = 15
      FieldName = 'ShipCountry'
      Visible = False
      Size = 15
    end
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=..\db\nwind.mdb;Per' +
      'sist Security Info=False'#9';'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 472
    Top = 208
  end
end
