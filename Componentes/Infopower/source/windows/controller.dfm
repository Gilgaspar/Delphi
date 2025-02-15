object Form1: TForm1
  Left = 192
  Top = 140
  Width = 544
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 256
    Top = 56
    Width = 41
    Height = 33
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 352
    Top = 56
    Width = 33
    Height = 33
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 216
    Top = 240
    Width = 33
    Height = 33
    OnClick = SpeedButton3Click
  end
  object wwDBEdit1: TwwDBEdit
    Left = 88
    Top = 64
    Width = 113
    Height = 19
    Controller = wwController1
    BorderStyle = bsNone
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBEdit2: TwwDBEdit
    Left = 88
    Top = 104
    Width = 113
    Height = 19
    Controller = wwController1
    BorderStyle = bsNone
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBEdit3: TwwDBEdit
    Left = 96
    Top = 136
    Width = 113
    Height = 19
    Controller = wwController1
    BorderStyle = bsNone
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBComboBox1: TwwDBComboBox
    Left = 96
    Top = 16
    Width = 121
    Height = 19
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    BorderStyle = bsNone
    DropDownCount = 8
    ButtonEffects.Flat = True
    Frame.Enabled = True
    ItemHeight = 0
    Sorted = False
    TabOrder = 3
    UnboundDataType = wwDefault
  end
  object wwDBRichEdit1: TwwDBRichEdit
    Left = 272
    Top = 168
    Width = 169
    Height = 113
    AutoURLDetect = False
    PrintJobName = 'Delphi 6'
    TabOrder = 4
    EditorCaption = 'Edit Rich Text'
    EditorPosition.Left = 0
    EditorPosition.Top = 0
    EditorPosition.Width = 0
    EditorPosition.Height = 0
    MeasurementUnits = muInches
    PrintMargins.Top = 1
    PrintMargins.Bottom = 1
    PrintMargins.Left = 1
    PrintMargins.Right = 1
    PrintHeader.VertMargin = 0.5
    PrintHeader.Font.Charset = DEFAULT_CHARSET
    PrintHeader.Font.Color = clWindowText
    PrintHeader.Font.Height = -11
    PrintHeader.Font.Name = 'MS Sans Serif'
    PrintHeader.Font.Style = []
    PrintFooter.VertMargin = 0.5
    PrintFooter.Font.Charset = DEFAULT_CHARSET
    PrintFooter.Font.Color = clWindowText
    PrintFooter.Font.Height = -11
    PrintFooter.Font.Name = 'MS Sans Serif'
    PrintFooter.Font.Style = []
    RichEditVersion = 2
    Data = {
      810000007B5C727466315C616E73695C616E7369637067313235325C64656666
      305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C20
      4D532053616E732053657269663B7D7D0D0A5C766965776B696E64345C756331
      5C706172645C66305C6673313620777744425269636845646974315C7061720D
      0A7D0D0A00}
  end
  object wwDBSpinEdit1: TwwDBSpinEdit
    Left = 296
    Top = 8
    Width = 105
    Height = 21
    Increment = 1
    TabOrder = 5
    UnboundDataType = wwDefault
  end
  object wwDBComboDlg1: TwwDBComboDlg
    Left = 304
    Top = 104
    Width = 105
    Height = 21
    ShowButton = True
    Style = csDropDown
    TabOrder = 6
    WordWrap = False
    UnboundDataType = wwDefault
  end
  object wwDBLookupCombo1: TwwDBLookupCombo
    Left = 304
    Top = 136
    Width = 97
    Height = 21
    DisableThemes = False
    DropDownAlignment = taLeftJustify
    Navigator = False
    TabOrder = 7
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object wwKeyCombo1: TwwKeyCombo
    Left = 88
    Top = 176
    Width = 121
    Height = 19
    Controller = wwController1
    Style = csDropDownList
    BorderStyle = bsNone
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 8
    Text = 'wwKeyCombo1'
    ShowAllIndexes = False
    PrimaryKeyName = 'PrimaryKey'
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
  end
  object wwIncrementalSearch1: TwwIncrementalSearch
    Left = 96
    Top = 216
    Width = 97
    Height = 19
    Controller = wwController1
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
    BorderStyle = bsNone
    TabOrder = 9
  end
  object wwCheckBox1: TwwCheckBox
    Left = 80
    Top = 272
    Width = 65
    Height = 33
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'wwCheckBox1'
    TabOrder = 10
  end
  object wwRadioGroup1: TwwRadioGroup
    Left = 96
    Top = 296
    Width = 177
    Height = 33
    DisableThemes = False
    Caption = 'wwRadioGroup1'
    TabOrder = 11
  end
  object wwDBDateTimePicker1: TwwDBDateTimePicker
    Left = 344
    Top = 304
    Width = 121
    Height = 19
    Controller = wwController1
    BorderStyle = bsNone
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
    ShowButton = True
    TabOrder = 12
  end
  object wwDBLookupCombo2: TwwDBLookupCombo
    Left = 392
    Top = 40
    Width = 121
    Height = 19
    BorderStyle = bsNone
    Controller = wwController1
    DisableThemes = False
    DropDownAlignment = taLeftJustify
    Navigator = False
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
    TabOrder = 13
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object fcTreeCombo1: TfcTreeCombo
    Left = 24
    Top = 248
    Width = 121
    Height = 21
    ButtonStyle = cbsDownArrow
    Text = 'fcTreeCombo1'
    DropDownCount = 8
    Items.StreamVersion = 1
    Items.Data = {00000000}
    Options = [icoExpanded]
    ReadOnly = False
    ShowMatchText = True
    Sorted = False
    Style = csDropDown
    TabOrder = 14
  end
  object fcColorCombo1: TfcColorCombo
    Left = 32
    Top = 280
    Width = 121
    Height = 21
    ColorListOptions.Font.Charset = DEFAULT_CHARSET
    ColorListOptions.Font.Color = clWindowText
    ColorListOptions.Font.Height = -11
    ColorListOptions.Font.Name = 'MS Sans Serif'
    ColorListOptions.Font.Style = []
    DropDownCount = 8
    ReadOnly = False
    SelectedColor = 268435455
    TabOrder = 15
  end
  object fcFontCombo1: TfcFontCombo
    Left = 24
    Top = 224
    Width = 121
    Height = 19
    Controller = wwController1
    BorderStyle = bsNone
    ButtonStyle = cbsDownArrow
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
    ImmediateHints = False
    ReadOnly = False
    TabOrder = 16
    TreeOptions = [tvoHideSelection, tvoRowSelect, tvoShowButtons, tvoToolTips]
  end
  object fcColorList1: TfcColorList
    Left = 232
    Top = 24
    Width = 25
    Height = 41
    ColorWidth = 12
    GreyScaleIncrement = 10
    Options = [ccoShowStandardColors, ccoShowColorNames]
    SelectedColor = 268435455
    TabOrder = 17
    ItemHeight = 16
  end
  object wwRecordViewPanel1: TwwRecordViewPanel
    Left = 248
    Top = 112
    Width = 281
    Height = 161
    HorzScrollBar.Margin = 6
    HorzScrollBar.Range = 243
    VertScrollBar.Increment = 23
    VertScrollBar.Margin = 6
    VertScrollBar.Range = 307
    AutoScroll = False
    TabOrder = 18
    DataSource = DataSource1
    ControlOptions = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
  end
  object wwController1: TwwController
    Frame.Enabled = True
    Frame.FocusBorders = [efBottomBorder]
    Left = 16
    Top = 32
  end
  object wwController2: TwwController
    Frame.Enabled = True
    Frame.MouseEnterSameAsFocus = True
    Left = 16
    Top = 64
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'InfoDemo5'
    TableName = 'customer.db'
    Left = 48
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 16
    Top = 120
  end
  object wwRecordViewDialog1: TwwRecordViewDialog
    DataSource = DataSource1
    FormPosition.Left = 0
    FormPosition.Top = 0
    FormPosition.Width = 0
    FormPosition.Height = 0
    NavigatorButtons = [nbsFirst, nbsPrior, nbsNext, nbsLast, nbsInsert, nbsDelete, nbsEdit, nbsPost, nbsCancel, nbsRefresh, nbsPriorPage, nbsNextPage, nbsSaveBookmark, nbsRestoreBookmark]
    ControlOptions = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Caption = 'Record View'
    NavigatorFlat = True
    Left = 312
    Top = 48
  end
  object wwFilterDialog1: TwwFilterDialog
    DataSource = DataSource1
    Options = [fdShowCaseSensitive, fdShowOKCancel, fdShowViewSummary, fdShowFieldOrder, fdShowValueRangeTab, fdSizeable]
    SortBy = fdSortByFieldNo
    FilterMethod = fdByFilter
    DefaultMatchType = fdMatchStart
    DefaultFilterBy = fdSmartFilter
    FieldOperators.OrChar = 'or'
    FieldOperators.AndChar = 'and'
    FieldOperators.NullChar = 'null'
    Rounding.Epsilon = 0.0001
    Rounding.RoundingMethod = fdrmFixed
    FilterPropertyOptions.LikeWildcardChar = '%'
    FilterOptimization = fdNone
    QueryFormatDateMode = qfdMonthDayYear
    SQLTables = <>
    OnInitDialog = wwFilterDialog1InitDialog
    OnAcceptFilterRecord = wwFilterDialog1AcceptFilterRecord
    Left = 16
    Top = 160
  end
  object wwLocateDialog1: TwwLocateDialog
    Caption = 'Locate Field Value'
    DataSource = DataSource1
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldName
    DefaultButton = dbFindNext
    FieldSelection = fsAllFields
    ShowMessages = True
    Left = 64
    Top = 160
  end
end
