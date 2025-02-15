object TableQueryForm: TTableQueryForm
  Left = 213
  Top = 80
  BorderStyle = bsDialog
  Caption = 'Lookup list from Query'
  ClientHeight = 402
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 144
    Top = 423
    Width = 61
    Height = 21
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 537
    Height = 401
    ActivePage = TabSheet2
    TabOrder = 1
    object TabSheet2: TTabSheet
      Caption = 'Using a Parameterized Query to Fill a Drop-down List'
      object wwDBGrid1: TwwDBGrid
        Left = 8
        Top = 0
        Width = 521
        Height = 177
        ControlType.Strings = (
          'Zip;CustomEdit;wwDBLookupCombo1;F'
          'Buyer;CustomEdit;wwDBComboBox1;F')
        Selected.Strings = (
          'Customer No'#9'6'#9'No'#9#9
          'Company Name'#9'18'#9'Company Name'#9#9
          'State'#9'8'#9'State'#9#9
          'Zip'#9'13'#9'Zip'#9#9
          'Buyer'#9'8'#9'Buyer'#9#9
          'First Name'#9'25'#9'First Name'#9#9
          'Last Name'#9'25'#9'Last Name'#9#9
          'Street'#9'60'#9'Street'#9#9
          'First Contact Date'#9'14'#9'First Contact Date'#9#9
          'Phone Number'#9'20'#9'Phone Number'#9#9
          'Information'#9'10'#9'Information'#9#9
          'RichEdit'#9'10'#9'RichEdit'#9#9
          'Requested Demo'#9'14'#9'Requested Demo'#9#9
          'Logical'#9'6'#9'Logical'#9#9)
        IniAttributes.FileName = 'delphi32.ini'
        IniAttributes.SectionName = 'TableQueryFormwwDBGrid1'
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = CustDS
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
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 16
        Top = 140
        Width = 153
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ZIP'#9'5'#9'ZIP'
          'CITY'#9'25'#9'CITY'
          'STATE'#9'5'#9'STATE')
        DataField = 'Zip'
        DataSource = CustDS
        LookupTable = ZipQuery
        LookupField = 'ZIP'
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBRichEdit1: TwwDBRichEdit
        Left = 8
        Top = 232
        Width = 513
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
        PrintJobName = 'Delphi 5'
        TabOrder = 2
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
          910200007B5C727466315C616E73695C64656666305C6465666C616E67313033
          337B5C666F6E7474626C7B5C66305C66726F6D616E2054696D6573204E657720
          526F6D616E3B7D7D0D0A7B5C636F6C6F7274626C203B5C726564305C67726565
          6E305C626C7565303B7D0D0A5C766965776B696E64345C7563315C706172645C
          6366315C66305C6673323020496E666F506F77657220737570706F727473206C
          6F6F6B75707320612076617269657479206F6620646174617365742074797065
          7320746F2066696C6C20612064726F702D646F776E206C6973742C20696E636C
          7564696E67205451756572792C205477775142452C20616E6420547777436C69
          656E74446174615365742E5C7061720D0A5C7061720D0A496E666F506F776572
          20737570706F727473206C6F6F6B757073207573696E675C625C692020706172
          616D65746572697A656420717565726965735C62305C69302020746F2066696C
          6C20796F75722064726F702D646F776E206C6973742E20205468697320676976
          657320796F75206175746F6D61746963616C6C792066696C7465726564206C6F
          6F6B757073206261736564206F6E207468652063757272656E74207265636F72
          64277320646174612E2020466F7220696E7374616E636520696E207468652061
          626F7665206578616D706C6520746865207468652064726F702D646F776E206C
          69737420696E20746865205A697020636F6465206669656C6420697320617574
          6F6D61746963616C6C792066696C746572656420746F2073686F77206F6E6C79
          20746865207A697020636F646573207468617420636F7272656C617465207769
          74682074686520225374617465222076616C7565206F66207468652063757272
          656E74207265636F72642E5C7061720D0A7D0D0A00}
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 184
        Width = 513
        Height = 41
        Caption = 'Lookup Component Type'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Use LookupCombo Component'
          'Use LookupComboDlg Component')
        TabOrder = 3
        OnClick = RadioGroup1Click
      end
      object wwDBLookupComboDlg1: TwwDBLookupComboDlg
        Left = 16
        Top = 112
        Width = 153
        Height = 21
        GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
        GridColor = clWhite
        GridTitleAlignment = taLeftJustify
        Caption = 'Lookup'
        MaxWidth = 0
        MaxHeight = 209
        Selected.Strings = (
          'ZIP'#9'10'#9'Zip'
          'CITY'#9'25'#9'City'
          'state'#9'2'#9'State')
        LookupTable = ZipQuery
        LookupField = 'Zip'
        SeqSearchOptions = [ssoEnabled, ssoCaseSensitive]
        TabOrder = 4
        Visible = False
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        UseTFields = False
      end
      object wwDBComboBox1: TwwDBComboBox
        Left = 280
        Top = 72
        Width = 121
        Height = 21
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        DropDownCount = 8
        HistoryList.FileName = 'delphi32.ini.ini'
        ItemHeight = 0
        Items.Strings = (
          'one'
          'two'
          'three')
        Sorted = False
        TabOrder = 5
        UnboundDataType = wwDefault
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Using a Query to Fill a Drop-down List'
      object Label1: TLabel
        Left = 16
        Top = 32
        Width = 139
        Height = 13
        Caption = 'LookupCombo from a TQuery'
      end
      object Label2: TLabel
        Left = 16
        Top = 88
        Width = 155
        Height = 13
        Caption = 'LookupComboDlg from a TQuery'
      end
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 16
        Top = 48
        Width = 185
        Height = 21
        DropDownAlignment = taLeftJustify
        LookupTable = wwQuery1
        LookupField = 'State'
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        ShowMatchText = True
      end
      object wwDBLookupComboDlg2: TwwDBLookupComboDlg
        Left = 16
        Top = 104
        Width = 185
        Height = 21
        Options = [opShowOKCancel]
        GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
        GridColor = clWhite
        GridTitleAlignment = taLeftJustify
        Caption = 'Lookup'
        MaxWidth = 0
        MaxHeight = 209
        LookupTable = wwQuery1
        LookupField = 'state'
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        ShowMatchText = True
      end
      object wwDBRichEdit2: TwwDBRichEdit
        Left = 8
        Top = 184
        Width = 505
        Height = 177
        AutoURLDetect = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GutterWidth = 3
        HideSelection = False
        ParentFont = False
        PrintJobName = 'Delphi 5'
        TabOrder = 2
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
          490200007B5C727466315C616E73695C64656666305C6465666C616E67313033
          337B5C666F6E7474626C7B5C66305C66726F6D616E2054696D6573204E657720
          526F6D616E3B7D7B5C66315C666D6F6465726E20436F7572696572204E65773B
          7D7D0D0A7B5C636F6C6F7274626C203B5C726564305C677265656E305C626C75
          65303B7D0D0A5C766965776B696E64345C7563315C706172645C6C6937325C66
          305C667332302054686973206578616D706C65207573657320616E2053514C20
          636F6D6D616E6420746F2066696C6C2061206C6F6F6B7570206C6973742E2054
          686520666F6C6C6F77696E672053514C206973207573656420696E2074686973
          205C7061720D0A64656D6F2E5C7061720D0A5C7061720D0A5C66312053656C65
          63742044697374696E63742053746174652066726F6D204950325A49505C7061
          720D0A5C66305C7061720D0A436C69636B206F6E207468652069636F6E20696E
          206569746865722074686520777744424C6F6F6B7570436F6D626F206F722074
          68652054777744424C6F6F6B7570436F6D626F446C6720616E6420796F752077
          696C6C2073656520746865206C6973742067656E657261746564206279207468
          652071756572792E2020416C736F206E6F7465207468617420696E6372656D65
          6E74616C20736561726368696E6720616E6420517569636B656E207374796C65
          206175746F2D66696C6C696E6720617265207374696C6C20737570706F727465
          642E206576656E20616761696E73742061205451756572792E5C7061720D0A5C
          6366315C7061720D0A7D0D0A00}
      end
    end
  end
  object ZipDS: TDataSource
    DataSet = ZipQuery
    Left = 592
    Top = 64
  end
  object CustDS: TDataSource
    DataSet = CustQuery
    Left = 592
    Top = 32
  end
  object CustQuery: TQuery
    Active = True
    DatabaseName = 'InfoDemo5'
    RequestLive = True
    SQL.Strings = (
      'Select * from ip4cust')
    Left = 624
    Top = 32
    object CustQueryCustomerNo: TIntegerField
      DisplayLabel = 'No'
      DisplayWidth = 6
      FieldName = 'Customer No'
    end
    object CustQueryCompanyName: TStringField
      DisplayWidth = 18
      FieldName = 'Company Name'
      Size = 40
    end
    object CustQueryState: TStringField
      DisplayWidth = 8
      FieldName = 'State'
      Size = 25
    end
    object CustQueryZip: TStringField
      DisplayWidth = 13
      FieldName = 'Zip'
      Size = 10
    end
    object CustQueryBuyer: TStringField
      DisplayWidth = 8
      FieldName = 'Buyer'
      Size = 3
    end
    object CustQueryFirstName: TStringField
      DisplayWidth = 25
      FieldName = 'First Name'
      Size = 25
    end
    object CustQueryLastName: TStringField
      DisplayWidth = 25
      FieldName = 'Last Name'
      Size = 25
    end
    object CustQueryStreet: TStringField
      DisplayWidth = 60
      FieldName = 'Street'
      Size = 60
    end
    object CustQueryFirstContactDate: TDateField
      DisplayWidth = 14
      FieldName = 'First Contact Date'
    end
    object CustQueryPhoneNumber: TStringField
      DisplayWidth = 20
      FieldName = 'Phone Number'
    end
    object CustQueryInformation: TMemoField
      DisplayWidth = 10
      FieldName = 'Information'
      BlobType = ftMemo
      Size = 80
    end
    object CustQueryRichEdit: TBlobField
      DisplayWidth = 10
      FieldName = 'RichEdit'
      Size = 80
    end
    object CustQueryRequestedDemo: TStringField
      DisplayWidth = 14
      FieldName = 'Requested Demo'
      Size = 3
    end
    object CustQueryLogical: TBooleanField
      DisplayWidth = 6
      FieldName = 'Logical'
    end
    object CustQueryCity: TStringField
      DisplayWidth = 15
      FieldName = 'City'
      Visible = False
      Size = 25
    end
  end
  object ZipQuery: TQuery
    Active = True
    DatabaseName = 'InfoDemo5'
    DataSource = CustDS
    RequestLive = True
    SQL.Strings = (
      'Select * from ip4zip'
      'where ip4zip."state"=:state')
    Left = 624
    Top = 64
    ParamData = <
      item
        DataType = ftString
        Name = 'State'
        ParamType = ptUnknown
        Size = 26
      end>
  end
  object wwQuery1: TQuery
    DatabaseName = 'InfoDemo5'
    SQL.Strings = (
      'Select distinct state from ip4zip')
    Left = 596
    Top = 104
  end
end
