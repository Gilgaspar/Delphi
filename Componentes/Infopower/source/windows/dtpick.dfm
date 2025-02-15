object DateTimePickerForm: TDateTimePickerForm
  Left = 180
  Top = 139
  BorderStyle = bsDialog
  Caption = 'DateTimePicker Demo'
  ClientHeight = 434
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 5
    Top = 24
    Width = 236
    Height = 393
    TabOrder = 0
    object Label5: TLabel
      Left = 9
      Top = 9
      Width = 38
      Height = 13
      Caption = 'As Date'
    end
    object Label8: TLabel
      Left = 9
      Top = 48
      Width = 100
      Height = 13
      Caption = 'As Long Date Format'
    end
    object Label9: TLabel
      Left = 124
      Top = 9
      Width = 38
      Height = 13
      Caption = 'As Time'
    end
    object Label7: TLabel
      Left = 9
      Top = 89
      Width = 167
      Height = 13
      Caption = 'As Custom Format (mmmm dd, yyyy)'
    end
    object wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 123
      Top = 22
      Width = 100
      Height = 21
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateTime'
      DataSource = wwDataSource1
      Epoch = 1990
      Time = 0.877106481479131600
      ShowButton = True
      TabOrder = 1
      DisplayFormat = 'hh:mm:ss AMPM'
      OnCalcBoldDay = wwDBDateTimePicker1CalcBoldDay
    end
    object wwDBDateTimePicker2: TwwDBDateTimePicker
      Left = 8
      Top = 22
      Width = 100
      Height = 21
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateTime'
      DataSource = wwDataSource1
      Date = 33239.000000000000000000
      Epoch = 1990
      Time = 0.877106481479131600
      ShowButton = True
      TabOrder = 0
      DisplayFormat = 'mm/dd/yyyy'
      OnCalcBoldDay = wwDBDateTimePicker1CalcBoldDay
    end
    object wwDBDateTimePicker3: TwwDBDateTimePicker
      Left = 8
      Top = 62
      Width = 215
      Height = 21
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateTime'
      DateFormat = dfLong
      DataSource = wwDataSource1
      Date = 33239.000000000000000000
      Epoch = 1990
      Time = 0.877106481479131600
      ShowButton = True
      TabOrder = 2
      OnCalcBoldDay = wwDBDateTimePicker1CalcBoldDay
    end
    object wwDBDateTimePicker4: TwwDBDateTimePicker
      Left = 8
      Top = 102
      Width = 215
      Height = 21
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateTime'
      DateFormat = dfLong
      DataSource = wwDataSource1
      Date = 33239.000000000000000000
      Epoch = 1990
      Time = 0.877106481479131600
      ShowButton = True
      TabOrder = 3
      DisplayFormat = 'mmmm dd, yyyy'
      OnCalcBoldDay = wwDBDateTimePicker1CalcBoldDay
    end
  end
  object wwDBNavigator1: TwwDBNavigator
    Left = 0
    Top = 0
    Width = 609
    Height = 21
    AutosizeStyle = asSizeNavButtons
    DataSource = wwDataSource1
    RepeatInterval.InitialDelay = 500
    RepeatInterval.Interval = 100
    object wwDBNavigator1First: TwwNavButton
      Left = 0
      Top = 0
      Width = 44
      Height = 21
      Hint = 'Move to first record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1First'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 0
      Style = nbsFirst
    end
    object wwDBNavigator1PriorPage: TwwNavButton
      Left = 44
      Top = 0
      Width = 44
      Height = 21
      Hint = 'Move backward 10 records'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1PriorPage'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 1
      Style = nbsPriorPage
    end
    object wwDBNavigator1Prior: TwwNavButton
      Left = 88
      Top = 0
      Width = 44
      Height = 21
      Hint = 'Move to prior record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Prior'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 2
      Style = nbsPrior
    end
    object wwDBNavigator1Next: TwwNavButton
      Left = 132
      Top = 0
      Width = 44
      Height = 21
      Hint = 'Move to next record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Next'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 3
      Style = nbsNext
    end
    object wwDBNavigator1NextPage: TwwNavButton
      Left = 176
      Top = 0
      Width = 44
      Height = 21
      Hint = 'Move forward 10 records'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1NextPage'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 4
      Style = nbsNextPage
    end
    object wwDBNavigator1Last: TwwNavButton
      Left = 220
      Top = 0
      Width = 44
      Height = 21
      Hint = 'Move to last record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Last'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 5
      Style = nbsLast
    end
    object wwDBNavigator1Insert: TwwNavButton
      Left = 264
      Top = 0
      Width = 44
      Height = 21
      Hint = 'Insert new record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Insert'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 6
      Style = nbsInsert
    end
    object wwDBNavigator1Delete: TwwNavButton
      Left = 308
      Top = 0
      Width = 43
      Height = 21
      Hint = 'Delete current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Delete'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 7
      Style = nbsDelete
    end
    object wwDBNavigator1Edit: TwwNavButton
      Left = 351
      Top = 0
      Width = 43
      Height = 21
      Hint = 'Edit current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Edit'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 8
      Style = nbsEdit
    end
    object wwDBNavigator1Post: TwwNavButton
      Left = 394
      Top = 0
      Width = 43
      Height = 21
      Hint = 'Post changes of current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Post'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 9
      Style = nbsPost
    end
    object wwDBNavigator1Cancel: TwwNavButton
      Left = 437
      Top = 0
      Width = 43
      Height = 21
      Hint = 'Cancel changes made to current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Cancel'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 10
      Style = nbsCancel
    end
    object wwDBNavigator1Refresh: TwwNavButton
      Left = 480
      Top = 0
      Width = 43
      Height = 21
      Hint = 'Refresh the contents of the dataset'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Refresh'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 11
      Style = nbsRefresh
    end
    object wwDBNavigator1SaveBookmark: TwwNavButton
      Left = 523
      Top = 0
      Width = 43
      Height = 21
      Hint = 'Bookmark current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1SaveBookmark'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 12
      Style = nbsSaveBookmark
    end
    object wwDBNavigator1RestoreBookmark: TwwNavButton
      Left = 566
      Top = 0
      Width = 43
      Height = 21
      Hint = 'Go back to saved bookmark'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1RestoreBookmark'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 13
      Style = nbsRestoreBookmark
    end
  end
  object PageControl1: TPageControl
    Left = 248
    Top = 24
    Width = 345
    Height = 393
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Usability, Display and Edit formats'
      object wwDBRichEdit3: TwwDBRichEdit
        Left = 7
        Top = 152
        Width = 322
        Height = 209
        ScrollBars = ssVertical
        AutoURLDetect = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GutterWidth = 3
        HideSelection = False
        ParentFont = False
        PrintJobName = 'C++Builder'
        TabOrder = 0
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
          BE0300007B5C727466315C616E73695C616E7369637067313235325C64656666
          305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C20
          54696D6573204E657720526F6D616E3B7D7B5C66315C66726F6D616E2054696D
          6573204E657720526F6D616E3B7D7B5C66325C666E696C204D532053616E7320
          53657269663B7D7B5C66335C666E696C5C6663686172736574322053796D626F
          6C3B7D7D0D0A7B5C636F6C6F7274626C203B5C726564305C677265656E305C62
          6C7565303B7D0D0A5C766965776B696E64345C7563315C706172645C73613238
          5C625C66305C66733138205370656369616C20617474656E74696F6E20686173
          206265656E20676976656E20746F20656E68616E63696E672074686520757361
          62696C69747920647572696E672065646974696E672062792074686520656E64
          2D757365725C7061720D0A5C706172647B5C706E746578745C66335C2742375C
          7461627D7B5C2A5C706E5C706E6C766C626C745C706E66335C706E696E64656E
          74307B5C706E747874625C2742377D7D5C66692D3138305C6C693138305C7361
          34335C6366315C623020536D617274206461746120656E747279203A205C6366
          30204F7074696F6E616C6C79206175746F2D616476616E63657320746F207468
          65206E65787420646174652F74696D6520746F6B656E20616674657220612076
          616C6964206461792C206D6F6E74682C20796561722C20686F75722C20657463
          2E20686173206265656E20656E74657265642E5C6366315C66315C7061720D0A
          7B5C706E746578745C66335C2742375C7461627D4175746F6D61746963206669
          6C6C696E67206F66207468652064617465206F722074696D65207768656E2074
          6865207370616365206B657920697320656E74657265645C7061720D0A7B5C70
          6E746578745C66335C2742375C7461627D59656172203230303020636F6D706C
          69616E74206576656E207769746820322064696769742079656172732E202044
          6576656C6F7065722063616E20616C736F207370656369667920616E2065706F
          6368206461746520746F20686176652066756C6C20636F6E74726F6C206F7665
          7220686F772032206469676974207965617273206172652073746F7265642E5C
          7061720D0A5C6366305C66307B5C706E746578745C66335C2742375C7461627D
          5370696E732075702F646F776E207769746820746865206172726F77206B6579
          7320616E64207072657365727665732074686520646973706C617920666F726D
          617420647572696E67207370696E6E696E672E5C625C66325C7061720D0A7D0D
          0A00}
      end
      object wwDBRichEdit2: TwwDBRichEdit
        Left = 9
        Top = 8
        Width = 320
        Height = 137
        AutoURLDetect = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GutterWidth = 3
        HideSelection = False
        ParentFont = False
        PrintJobName = 'C++Builder'
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
          260200007B5C727466315C616E73695C616E7369637067313235325C64656666
          305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C20
          54696D6573204E657720526F6D616E3B7D7D0D0A7B5C636F6C6F7274626C203B
          5C726564305C677265656E305C626C75653132383B7D0D0A5C766965776B696E
          64345C7563315C706172645C72693138305C6366315C625C66305C6673313820
          437573746F6D697A652074686520646973706C617920616E6420656469742066
          6F726D6174733A5C63663020205C62302054686520636F6E74726F6C7320746F
          20746865206C6566742061726520616C6C20617474616368656420746F207468
          652073616D65206461746162617365206669656C642C20616E64207965742079
          6F752063616E20646973706C6179206F722065646974207468656D20696E2063
          6F6D706C6574656C7920646966666572656E7420776179732E2020466F722069
          6E7374616E636520796F752063616E20646973706C61792F6564697420612054
          4461746554696D654669656C64206173206120446174652C20612054696D652C
          206F7220626F74682E2020596F752063616E20616C736F20757365206120666F
          726D617474696E67206D61736B20666F7220636F6D706C65746520636F6E7472
          6F6C206F76657220626F746820746865205C6220646973706C617920616E6420
          6564697420666F726D61745C6230202E5C625C7061720D0A5C706172645C6230
          5C7061720D0A7D0D0A00}
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Calendar Drop-down Properties'
      object Label1: TLabel
        Left = 11
        Top = 73
        Width = 97
        Height = 13
        Caption = 'DropDownAlignment'
      end
      object CheckBox3: TCheckBox
        Left = 11
        Top = 16
        Width = 146
        Height = 19
        Caption = 'Show Today Circle'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CheckBox3Click
      end
      object CheckBox2: TCheckBox
        Left = 11
        Top = 33
        Width = 210
        Height = 19
        Caption = 'Show Today'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox2Click
      end
      object CheckBox1: TCheckBox
        Left = 11
        Top = 50
        Width = 202
        Height = 19
        Caption = 'Show Week Numbers'
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object ComboBox1: TComboBox
        Left = 10
        Top = 88
        Width = 112
        Height = 21
        TabOrder = 3
        Text = 'Left'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Left'
          'Center'
          'Right')
      end
      object RadioGroup1: TRadioGroup
        Left = 152
        Top = 17
        Width = 169
        Height = 93
        Caption = 'Automatically boldface...'
        ItemIndex = 1
        Items.Strings = (
          'None'
          'Weekend Days'
          'U.S. Holidays'
          'Pay Days (1st and 3rd Friday)')
        TabOrder = 4
        OnClick = RadioGroup1Click
      end
      object wwDBRichEdit4: TwwDBRichEdit
        Left = 8
        Top = 118
        Width = 321
        Height = 255
        ScrollBars = ssVertical
        AutoURLDetect = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GutterWidth = 3
        HideSelection = False
        ParentFont = False
        PrintJobName = 'C++Builder'
        TabOrder = 5
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
          130400007B5C727466315C616E73695C616E7369637067313235325C64656666
          305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C20
          54696D6573204E657720526F6D616E3B7D7B5C66315C666E696C5C6663686172
          736574322053796D626F6C3B7D7D0D0A7B5C636F6C6F7274626C203B5C726564
          305C677265656E305C626C75653132383B7D0D0A5C766965776B696E64345C75
          63315C706172645C736132385C6366315C625C66305C6673313820437573746F
          6D697A6520746865206C6F6F6B206F66207468652064726F702D646F776E2063
          616C656E6461723A205C6366305C623020496E666F506F776572277320446174
          6554696D655069636B65722068617320612076617269657479206F662070726F
          7065727469657320746F20636F6E74726F6C20746865206C6F6F6B206F662074
          68652064726F702D646F776E2063616C656E6461722E2020546F67676C652073
          6F6D65206F66207468652073656C656374696F6E732061626F766520616E6420
          6E6F746520686F7720746865206C6F6F6B206F66207468652064726F702D646F
          776E2063616C656E646172206973206368616E6765642E5C7061720D0A5C7061
          72647B5C706E746578745C66315C2742375C7461627D7B5C2A5C706E5C706E6C
          766C626C745C706E66315C706E696E64656E74307B5C706E747874625C274237
          7D7D5C66692D3138305C6C693138305C7361343320426F6C646661636520616E
          792064617920696E207468652064726F702D646F776E2063616C656E6461722E
          2020546869732064656D6F20626F6C646661636573205C62207765656B656E64
          735C6230202C205C6220686F6C69646179735C6230202C205C6220616E645C62
          3020205C6220706179646179735C6230202E5C7061720D0A7B5C706E74657874
          5C66315C2742375C7461627D48696465732F53686F777320746865207765656B
          206E756D62657273206F6E2074686520666172206C6566742068616E64207369
          64655C7061720D0A7B5C706E746578745C66315C2742375C7461627D48696465
          732F53686F777320746F646179277320646174652061742074686520626F7474
          6F6D206F66207468652063616C656E6461725C7061720D0A5C706172645C7361
          34335C6220506F702D7570206D656E75732077697468696E207468652064726F
          707065642D646F776E2063616C656E6461723A205C62302054686520656E642D
          757365722063616E20636C69636B206F6E207468652079656172206F72206D6F
          6E7468206F66207468652064726F707065642D646F776E2063616C656E646172
          20616E64206120706F702D7570206D656E752077696C6C207265737065637469
          76656C7920646973706C6179207965617273206F72206D6F6E7468732E5C7061
          720D0A5C706172645C736132385C7061720D0A7D0D0A00}
      end
    end
  end
  object wwDataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 528
    Top = 8
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 496
    Top = 8
    Data = {
      1E0100009619E0BD010000001800000005000400000003000000BF0008446174
      6554696D6508000800000001000950524F56464C414753040001800700000004
      466C64320100490000000100055749445448020002000A00074C6F6E67696E74
      0400010000000000044461746504000600000000000454696D65040007000000
      000003000D44454641554C545F4F524445520400820001000000010000000B50
      52494D4152595F4B4559040082000100000001000000044C4349440400010009
      04000000000000B8F98FB38ECC42023332E800000055210B0060138C00000000
      000CF736CAA2CC4205393939393902000000751E0B00E8C3D4010000010080F3
      9117A3CC420133030000003D00000000140000503CCF6AB3CC429B1B0B002833
      1503}
  end
end
