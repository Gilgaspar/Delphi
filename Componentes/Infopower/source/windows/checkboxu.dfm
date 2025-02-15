object CheckBoxDemo: TCheckBoxDemo
  Left = 229
  Top = 214
  Caption = 'InfoPower - CheckBox Demo'
  ClientHeight = 369
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 561
    Height = 369
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Checkbox Transparency'
      OnShow = TabSheet1Show
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 553
        Height = 341
        Align = alClient
        Caption = 'Panel1'
        TabOrder = 0
        object Image1: TImage
          Left = 1
          Top = 1
          Width = 551
          Height = 146
          Align = alClient
          Stretch = True
          ExplicitTop = -5
        end
        object Bevel1: TBevel
          Left = 8
          Top = 32
          Width = 121
          Height = 96
          Shape = bsFrame
        end
        object Label1: TLabel
          Left = 8
          Top = 4
          Width = 129
          Height = 29
          AutoSize = False
          Caption = 'Delphi'#39's TDBCheckbox w/No Transparency'
          Transparent = True
          WordWrap = True
        end
        object Bevel2: TBevel
          Left = 146
          Top = 36
          Width = 127
          Height = 85
          Shape = bsFrame
        end
        object Label2: TLabel
          Left = 144
          Top = 3
          Width = 401
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Infopower Checkbox'
          Transparent = True
          WordWrap = True
        end
        object Label3: TLabel
          Left = 144
          Top = 23
          Width = 129
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Transparency'
          Transparent = True
          WordWrap = True
        end
        object Bevel3: TBevel
          Left = 280
          Top = 36
          Width = 130
          Height = 85
          Shape = bsFrame
        end
        object Label4: TLabel
          Left = 282
          Top = 23
          Width = 129
          Height = 18
          Alignment = taCenter
          AutoSize = False
          Caption = 'Framing On Focus'
          Transparent = True
          WordWrap = True
        end
        object Bevel4: TBevel
          Left = 418
          Top = 36
          Width = 127
          Height = 85
          Shape = bsFrame
        end
        object Bevel5: TBevel
          Left = 138
          Top = 17
          Width = 415
          Height = 111
          Shape = bsFrame
        end
        object Label5: TLabel
          Left = 418
          Top = 23
          Width = 129
          Height = 18
          Alignment = taCenter
          AutoSize = False
          Caption = 'Hot-Tracking'
          Transparent = True
          WordWrap = True
        end
        object wwCheckBox1: TwwCheckBox
          Left = 152
          Top = 43
          Width = 114
          Height = 17
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'Owns Car'
          TabOrder = 0
        end
        object DBCheckBox1: TDBCheckBox
          Left = 15
          Top = 43
          Width = 106
          Height = 17
          Caption = 'Check here.'
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object wwCheckBox2: TwwCheckBox
          Left = 152
          Top = 69
          Width = 113
          Height = 17
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'Owns Home'
          TabOrder = 2
        end
        object wwCheckBox3: TwwCheckBox
          Left = 152
          Top = 96
          Width = 114
          Height = 17
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'Has Children'
          TabOrder = 3
        end
        object DBCheckBox2: TDBCheckBox
          Left = 15
          Top = 69
          Width = 106
          Height = 17
          Caption = 'Check here.'
          TabOrder = 4
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox3: TDBCheckBox
          Left = 15
          Top = 97
          Width = 106
          Height = 17
          Caption = 'Check here.'
          TabOrder = 5
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object wwCheckBox4: TwwCheckBox
          Left = 287
          Top = 42
          Width = 116
          Height = 19
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Has Insurance'
          TabOrder = 6
        end
        object wwCheckBox5: TwwCheckBox
          Left = 287
          Top = 66
          Width = 115
          Height = 19
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Has HMO'
          TabOrder = 7
        end
        object wwCheckBox6: TwwCheckBox
          Left = 288
          Top = 92
          Width = 115
          Height = 19
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Has Boat'
          TabOrder = 8
        end
        object wwCheckBox7: TwwCheckBox
          Left = 426
          Top = 44
          Width = 116
          Height = 17
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show A'
          TabOrder = 9
        end
        object wwCheckBox8: TwwCheckBox
          Left = 426
          Top = 70
          Width = 115
          Height = 17
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show B'
          TabOrder = 10
        end
        object wwCheckBox9: TwwCheckBox
          Left = 426
          Top = 96
          Width = 115
          Height = 17
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          Frame.MouseEnterSameAsFocus = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          ShowFocusRect = False
          NullAndBlankState = cbUnchecked
          Caption = 'Show C'
          TabOrder = 11
        end
        object wwDBRichEdit1: TwwDBRichEdit
          Left = 1
          Top = 147
          Width = 551
          Height = 193
          TabStop = False
          Align = alBottom
          AutoURLDetect = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          GutterWidth = 3
          HideSelection = False
          ParentFont = False
          PrintJobName = 'Delphi 5'
          TabOrder = 12
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
          PrintHeader.Font.Height = -13
          PrintHeader.Font.Name = 'Tahoma'
          PrintHeader.Font.Style = []
          PrintFooter.VertMargin = 0.500000000000000000
          PrintFooter.Font.Charset = DEFAULT_CHARSET
          PrintFooter.Font.Color = clWindowText
          PrintFooter.Font.Height = -13
          PrintFooter.Font.Name = 'Tahoma'
          PrintFooter.Font.Style = []
          RichEditVersion = 2
          Data = {
            910500007B5C727466315C616E73695C616E7369637067313235325C64656666
            305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C5C
            666368617273657430204D532053616E732053657269663B7D7B5C66315C666E
            696C204D532053616E732053657269663B7D7B5C66325C666E696C5C66636861
            72736574322053796D626F6C3B7D7D0D0A7B5C636F6C6F7274626C203B5C7265
            64305C677265656E305C626C75653235353B7D0D0A5C766965776B696E64345C
            7563315C706172645C66305C6673313820496E666F506F776572277320547777
            4442436865636B626F7820686173206D616E7920616476616E7461676573206F
            7665722061207374616E646172642044656C70686920544442436865636B626F
            782E5C7061720D0A5C7061720D0A496E20746869732054616220706167652E20
            20596F752063616E207365652074686520666F6C6C6F77696E673A5C7061720D
            0A5C706172647B5C706E746578745C66325C2742375C7461627D7B5C2A5C706E
            5C706E6C766C626C745C706E66325C706E696E64656E74307B5C706E74787462
            5C2742377D7D5C66692D3138305C6C693534305C736137325C6366315C622054
            72616E73706172656E6379202D205C6366305C623020417320796F752063616E
            20736565206279206C6F6F6B696E672061742044656C70686927732054444243
            6865636B626F782C20776974686F7574207472616E73706172656E6379206368
            65636B626F786573206F6E2061206261636B67726F756E64206C6F6F6B207072
            65747479206261642E2020436F6D70617265207468697320746F207468652049
            6E666F506F77657220436865636B626F78207769746820697473205472616E73
            706172656E63792073657474696E677320656E61626C65642E5C6366315C625C
            66315C7061720D0A5C66307B5C706E746578745C66325C2742375C7461627D43
            7573746F6D204672616D696E67205374796C6573202D205C6366305C62302057
            69746820496E666F506F776572277320637573746F6D206672616D696E672073
            657474696E677320796F752063616E20616368696576652061206C6172676520
            6E756D626572206F6620646966666572656E7420656666656374732062792065
            6E61626C696E6720626F72646572732061726F756E642074686520636F6E7472
            6F6C207768656E206974206861732074686520666F637573206F72207768656E
            20697420646F65736E27742E2020596F752063616E2073656520746865206164
            76616E74616765206F6620696E6469636174696E6720666F6375732062792065
            6E61626C696E6720626F726465727320696E207468652061626F766520657861
            6D706C652E2020496E206D616E7920636173657320696E6469636174696E6720
            666F63757320627920626F7264657273206F766572206120666F637573726563
            7420686173206D756368206D6F72652076697375616C20696D7061637420616E
            64206973206D756368206D6F7265206F6276696F757320776869636820636F6E
            74726F6C206861732074686520666F6375732E5C6366315C625C66315C706172
            0D0A5C706172647B5C706E746578745C66325C2742375C7461627D7B5C2A5C70
            6E5C706E6C766C626C745C706E66325C706E696E64656E74307B5C706E747874
            625C2742377D7D5C66692D3138305C6C693534305C663020486F742D54726163
            6B696E67204672616D696E67205374796C6573202D205C6366305C623020496E
            206164646974696F6E20746F20496E666F506F7765722773206672616D696E67
            206361706162696C69746965732C20496E666F506F776572203330303020656E
            61626C657320796F7520746F2061636869657665206120686F742D747261636B
            696E67206672616D696E67206566666563742061732073686F776E2061626F76
            652E5C6366315C625C66315C7061720D0A7D0D0A00}
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Custom Checkbox Glyphs'
      ImageIndex = 1
      OnShow = TabSheet2Show
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 553
        Height = 341
        Align = alClient
        Caption = 'Panel1'
        TabOrder = 0
        object Image2: TImage
          Left = 1
          Top = 1
          Width = 551
          Height = 146
          Align = alClient
          Stretch = True
          Visible = False
          ExplicitWidth = 553
          ExplicitHeight = 151
        end
        object Bevel10: TBevel
          Left = 8
          Top = 23
          Width = 540
          Height = 115
          Shape = bsFrame
        end
        object Bevel7: TBevel
          Left = 17
          Top = 37
          Width = 127
          Height = 85
          Shape = bsFrame
        end
        object Label7: TLabel
          Left = 8
          Top = 3
          Width = 537
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Custom Glyphs'
          Transparent = True
          WordWrap = True
        end
        object Label8: TLabel
          Left = 16
          Top = 23
          Width = 129
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Macintosh-Style'
          Transparent = True
          WordWrap = True
        end
        object Bevel8: TBevel
          Left = 151
          Top = 37
          Width = 120
          Height = 85
          Shape = bsFrame
        end
        object Label9: TLabel
          Left = 151
          Top = 23
          Width = 119
          Height = 18
          Alignment = taCenter
          AutoSize = False
          Caption = 'Cool Checkbox'
          Transparent = True
          WordWrap = True
        end
        object Bevel9: TBevel
          Left = 278
          Top = 37
          Width = 126
          Height = 85
          Shape = bsFrame
        end
        object Label10: TLabel
          Left = 279
          Top = 23
          Width = 125
          Height = 18
          Alignment = taCenter
          AutoSize = False
          Caption = 'Shadowed Checkbox'
          Transparent = True
          WordWrap = True
        end
        object Bevel6: TBevel
          Left = 411
          Top = 37
          Width = 128
          Height = 85
          Shape = bsFrame
        end
        object Label6: TLabel
          Left = 410
          Top = 23
          Width = 129
          Height = 18
          Alignment = taCenter
          AutoSize = False
          Caption = 'Image Toggle'
          Transparent = True
          WordWrap = True
        end
        object wwCheckBox10: TwwCheckBox
          Left = 24
          Top = 45
          Width = 113
          Height = 17
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          AllowGrayed = True
          Caption = 'Show Option A'
          Checked = True
          Images = ImageList1
          State = cbChecked
          TabOrder = 0
        end
        object wwCheckBox11: TwwCheckBox
          Left = 24
          Top = 71
          Width = 113
          Height = 17
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          AllowGrayed = True
          Caption = 'Show Option B'
          Images = ImageList1
          TabOrder = 1
        end
        object wwCheckBox12: TwwCheckBox
          Left = 24
          Top = 96
          Width = 113
          Height = 17
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          AllowGrayed = True
          Caption = 'Show Option C'
          Images = ImageList1
          State = cbGrayed
          TabOrder = 2
        end
        object wwCheckBox13: TwwCheckBox
          Left = 158
          Top = 45
          Width = 105
          Height = 28
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'Hide A'
          Checked = True
          Images = ImageList3
          State = cbChecked
          TabOrder = 3
        end
        object wwCheckBox14: TwwCheckBox
          Left = 158
          Top = 87
          Width = 105
          Height = 26
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'Hide B'
          Images = ImageList3
          TabOrder = 4
        end
        object wwCheckBox18: TwwCheckBox
          Left = 284
          Top = 96
          Width = 113
          Height = 17
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          AllowGrayed = True
          Caption = 'Sort By C'
          Images = ImageList2
          State = cbGrayed
          TabOrder = 7
        end
        object wwCheckBox17: TwwCheckBox
          Left = 284
          Top = 69
          Width = 113
          Height = 17
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          AllowGrayed = True
          Caption = 'Sort By B'
          Images = ImageList2
          TabOrder = 6
        end
        object wwCheckBox16: TwwCheckBox
          Left = 284
          Top = 43
          Width = 113
          Height = 17
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          AllowGrayed = True
          Caption = 'Sort By A'
          Checked = True
          Images = ImageList2
          State = cbChecked
          TabOrder = 5
        end
        object wwCheckBox19: TwwCheckBox
          Left = 417
          Top = 42
          Width = 114
          Height = 20
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'Option 1'
          Checked = True
          Images = ImageList4
          State = cbChecked
          TabOrder = 8
        end
        object wwCheckBox20: TwwCheckBox
          Left = 417
          Top = 67
          Width = 113
          Height = 20
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'Option 2'
          Checked = True
          Images = ImageList4
          State = cbChecked
          TabOrder = 9
        end
        object wwCheckBox21: TwwCheckBox
          Left = 417
          Top = 92
          Width = 114
          Height = 25
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          DynamicCaption = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'Male'
          DisplayValueUnchecked = 'Female'
          NullAndBlankState = cbUnchecked
          Caption = 'Female'
          Images = ImageList5
          TabOrder = 10
        end
        object wwDBRichEdit2: TwwDBRichEdit
          Left = 1
          Top = 147
          Width = 551
          Height = 193
          TabStop = False
          Align = alBottom
          AutoURLDetect = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          GutterWidth = 3
          HideSelection = False
          ParentFont = False
          PrintJobName = 'Delphi 5'
          TabOrder = 11
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
          PrintHeader.Font.Height = -13
          PrintHeader.Font.Name = 'Tahoma'
          PrintHeader.Font.Style = []
          PrintFooter.VertMargin = 0.500000000000000000
          PrintFooter.Font.Charset = DEFAULT_CHARSET
          PrintFooter.Font.Color = clWindowText
          PrintFooter.Font.Height = -13
          PrintFooter.Font.Name = 'Tahoma'
          PrintFooter.Font.Style = []
          RichEditVersion = 2
          Data = {
            5D0100007B5C727466315C616E73695C616E7369637067313235325C64656666
            305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C5C
            666368617273657430204D532053616E732053657269663B7D7B5C66315C666E
            696C204D532053616E732053657269663B7D7D0D0A5C766965776B696E64345C
            7563315C706172645C66305C6673313820596F752063616E206F766572726964
            652074686520676C79706873207468617420696E64696361746520746865205C
            6220636865636B65642C20756E636865636B6564205C623020616E64205C6220
            677261796564205C623020737461746573206F662074686520636865636B626F
            782E2020427920646F696E6720736F20796F752063616E206163686965766520
            61206C61726765206E756D626572206F6620646966666572656E74206C6F6F6B
            7320696E20796F75722070726F6A656374732E205C66315C7061720D0A7D0D0A
            00}
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Display Mapping && Dynamic Captions'
      ImageIndex = 2
      OnShow = TabSheet3Show
      object Image4: TImage
        Left = 0
        Top = 0
        Width = 553
        Height = 341
        Align = alClient
        Picture.Data = {
          0A544A504547496D616765CE090000FFD8FFE000104A46494600010100000100
          010000FFDB004300090607080706090807080A0A090B0D160F0D0C0C0D1B1415
          1016201D2222201D1F1F2428342C242631271F1F2D3D2D3135373A3A3A232B3F
          443F384334393A37FFDB0043010A0A0A0D0C0D1A0F0F1A37251F253737373737
          3737373737373737373737373737373737373737373737373737373737373737
          37373737373737373737373737FFC000110800B5011703012200021101031101
          FFC400190000030101010000000000000000000000000102030405FFC4002710
          00020301000103040203010000000000000102112131411251610322718191A1
          133242B1FFC4001801010101010100000000000000000000000001020304FFC4
          00191101010101010100000000000000000000001101213141FFDA000C030100
          02110311003F00E1FA4BDCE9FA7E2CE785A66D17A8E0F43A66FED5EE6135EA5A
          8D14B012B56D120CD615156D065D9A455A0833BEC6D0DA44256E8B86016A1812
          4DF06DE0A2DDE851E848A8AF4855A2920AAEF4A94555931F946C92AE14AC6316
          69154A90DAA616B811215BD1BF912DE6014EDFC90EAF85B7C1340479545C5792
          68A52AA0A72B7D329A2A6FD886C18CA71B31FF0016FC9D3D7F043A4EEC2B0F4D
          1A2CA1B4EC497B81BFD2AB34F525491CF097A6CABB6E8B45FD4958295221AB65
          344535368C65BE4D5AFB6DF4CDAB7EC1184B00DFFC716B6A808AF2611F9B46F1
          5496042194CD1452456492B29093F4BA609BFD041FA2E2F7D8856D9A24AF8416
          96E0EB704BA52E1505AA4526BC0946C744554597768C7C8E2DA96F00D53BF26B
          192472A74F0A8DBD651D0E7ACCFD572C17EC6953B614FD579EC1EACAF904B472
          F84105A2A2EDE99A5EE6897F002BA7D264FC8DA25BA40542DAF727D3BA384B68
          B7E02B371339C4D659E44D26AC0E771D1354F4DDAC2251DF90A84AD6151D743E
          60A1D22B48A745A8AA04AD0D26CA82B09F4B36AA6097F2119AFA606F14BAC090
          AF0D58EFEEA65B8D710AB78509D3A1D5F07E9D2D477422630B3650AA14235FB3
          4AA74C09AA6552C1F3F21FA0173285AFF05F69052B021C76C22AFC14E3D292A2
          2A258960D72D0DFB12F9805C7EE58695C33FA6CD3C5D9703FD0DABE04236EEFF
          0003F808951B2D2CA17C22BF0044956233717E4D5689AC1AAC637EABF62BD4CA
          51AFD8D46DD0114DEF8069F8E1AAA6A89C4E8151E97E78271B668DDA222B7429
          3892A26AA3684E3BD01C729229E09265536F7C840F6ACA48229234A4028C5B02
          93F4F3A0588F1DBC06A89437640DBAC1DD916527F1A06BF4FB469256631B358A
          7E9E807A454EF0D37D384B4C012AFC83BBD2973E43C6A008A4FA3695244A7439
          3BC00A4F44D58E2B0BA5D0A88AA7F0691D7F04522D26105D31A56EC12FE8A8F6
          900A83C7E4BA5C25BF8008D8D46D0AF06A5FD80340FA37EE0A396CA21AD25AB6
          6925842BBA2096F013FD1557FA12A682852A09668A55EC34ED0029782D2D4671
          5F769B790A15265D89C6D7449B2A34B404C6BCB01C1E2C257D345DDE18464BC2
          364EDA321D6D50D94932BD210BE9C6BA6C9264457F45A4F19453AAA44B5FC949
          5079E14447BA3B56C2897C640C2DDF013CB60F1580ECA52DA12A15FC00DDD950
          7EA64D5AE97F4F02AA2BA545D650A2B74728D68434F43AAC4931EA5802CAB26D
          27681B69E936BDB00B4FC9AAFF00530BF62E2DD8034D7922BA692F9E0AB00CF8
          11568B7141C0A969705C2E5C33A02E2AF4A8F7A669F8B1A6C0E98A4D749AAE13
          1972D8E5256803D493F0073FD492B0148F31249E69B453467F4E26F1568C8712
          D32147B43A68A8D5522A2F0C5F8A2A2E9AB28D240F12A784DD93BC02BD4BA4BD
          131C7B5EE015880BAF71A8AE804565852654452D604FC23449246788A5BC0AD6
          146B499CF1E9AC675D081E0AFC03974CD49DE0553EF04A35683D5652D7758110
          93B348D58BD2545500E956849A5A8AAF2C8A026C13FEC749AB25D27A14A5DC33
          93D2DBF6225175D00525627269F44AB881E2B229FADBE70AB74669E602760134
          DBC0297340B158282E8F9C4107E06F35119095790ADE8395EAE80024FC8FD817
          807ACA292690536525CB2BD295819D670B8D469FB8D20AC085E7160EC7545348
          094FFA25FBF82F984BFBB3C010DFB8D3B55C09469D82568292957BB295F96278
          D60374BE082C715577E498EAC2E8A051F05D251C1254F02B69308A4D7469ABD2
          52BE035FC014DFB09EDDE2136AC96DD014DA15E12DB40BDD8512544C931CA5F0
          0B58109504BD997E9A544495F3C1159B7499307A5CD2FD99D5056DD03372AC5A
          05425C7415F20927E428324B0B554AC4A95F963BBF003E71093DE0D3E0EA9D00
          265C5DF4875C1DDAA0348AB748AAA62FA6F7F05495B0162FC8BF43689D02BAE8
          9AD1ACE7456ED012E36524528DA612A5FA0ACE5A449E1A579264AC81FD378686
          7154F4A4FF00828D23BA34BC21FF00C136FC843C49FF0062C6A89BA0BBE0035E
          68173E424D550A2D500AFCD0D6A168BD5BD0AA7AE894E98DBDE92F407295A210
          DC952159143568CDADE9764B56CA279D013A5D6065612C5816FC84552AE96965
          B34C26C17691514AEC3F0054550DD8E2B34A4B5DA033BF81DFC68F1BE0DF4071
          B3549D74882F7344801DD612EF0D1D7110D34543F925F2D8E2F7457D229290A7
          A3E6D12DEF029A580D79158EEC09AF91A1563058C0D632F052DBB14551493EB0
          8874C4B4A93DE13F8014AB84553AE972443F80AAB5740FA25CB0B2509AD12D1B
          7B80960035E4969559691127D4C09C4C4B44E8717615138DF7501B7A535A0215
          9C5694BC8FD3EC5FA6A8ACA520AE15F91AE0092698F2C4C38BDC06BA1409FF00
          0526035EE525A24EBBD2D3C004ABA2F707F2379F8026BDC87EE6964357F800F1
          A0D50EB81580449244DE52093F744B7F0157E0715D1479A5A5A034F33A558955
          8DD2548213E612979655DB0AFEC287F227ED4555D89A4B5810E384B8B5CA347A
          F3C09AF2419BC7F052580D68A1D02E9611F522BA5A764B79F206128AA6884E9D
          1736FD884B48AD2134BA06724EBED5A068E3A63169D3639AB42F02BE9584B40B
          B436F2BC99B6C0A72564A6F817426F48AB5CC2959307F3D1D328D1F70A8BDE99
          ABF25A56C82AEC4ADAA638A69077100EB3012C04A950B6C8AAAD1BA564D8EF34
          A339A57546734B0D24EB7A44BEE7604459AA93AF821E3E0D3AC08B52F62EF34C
          D703CA0AABAF257A97510C2D55016A412D56478072B78034D535E45EAFE8992D
          04D375640DEB05C058C6BE7A4079444D34F0D53C267651CEEFA4C5EE9B4A2D46
          CC1A76456B1925D03095F8028E84DB6C6F000D63286FECB32B76C006FA8A426F
          4008AD17DB45BE5801425D469077240045537F7FA4D3E9A4D30027D0BFE7F64D
          F400A62E934449ED7C800133AA329BF4D5000455ED093D6BD80018D23FEB6383
          B4006B447D41C229DBF64006554D7FE92BB600029BA748515A004DF436ADD079
          00206BFD92F82E4AE3600518F55333FAB89D0005650FBD6800128FFFD9}
        Visible = False
        ExplicitLeft = 1
        ExplicitTop = -5
        ExplicitWidth = 551
        ExplicitHeight = 146
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 553
        Height = 341
        Align = alClient
        Caption = 'Panel3'
        TabOrder = 0
        object Image3: TImage
          Left = 1
          Top = 1
          Width = 551
          Height = 146
          Align = alClient
          Stretch = True
          Visible = False
          ExplicitWidth = 553
          ExplicitHeight = 151
        end
        object Label11: TLabel
          Left = 8
          Top = 3
          Width = 537
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Other powerful features'
          Transparent = True
          WordWrap = True
        end
        object Bevel11: TBevel
          Left = 8
          Top = 17
          Width = 539
          Height = 115
          Shape = bsFrame
        end
        object Label12: TLabel
          Left = 168
          Top = 31
          Width = 353
          Height = 17
          AutoSize = False
          Caption = '<------ Dynamic Caption.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label13: TLabel
          Left = 168
          Top = 55
          Width = 353
          Height = 17
          AutoSize = False
          Caption = '<------ Dynamic and Mapped Value to Display Caption'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object wwCheckBox23: TwwCheckBox
          Left = 16
          Top = 53
          Width = 145
          Height = 21
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          DynamicCaption = True
          ValueChecked = 'Yes'
          ValueUnchecked = 'No'
          DisplayValueChecked = 'You are a Buyer'
          DisplayValueUnchecked = 'You are not a Buyer'
          NullAndBlankState = cbUnchecked
          Caption = 'You are not a Buyer'
          DataField = 'Buyer'
          DataSource = DataSource1
          TabOrder = 0
        end
        object wwCheckBox22: TwwCheckBox
          Left = 16
          Top = 28
          Width = 145
          Height = 21
          DisableThemes = False
          AlwaysTransparent = False
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          Frame.FocusStyle = efsFrameSunken
          DynamicCaption = True
          ValueChecked = 'Yes'
          ValueUnchecked = 'No'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'False'
          DataField = 'Requested Demo'
          DataSource = DataSource1
          TabOrder = 1
        end
        object wwDBRichEdit3: TwwDBRichEdit
          Left = 1
          Top = 147
          Width = 551
          Height = 193
          TabStop = False
          Align = alBottom
          AutoURLDetect = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
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
          PrintHeader.Font.Height = -13
          PrintHeader.Font.Name = 'Tahoma'
          PrintHeader.Font.Style = []
          PrintFooter.VertMargin = 0.500000000000000000
          PrintFooter.Font.Charset = DEFAULT_CHARSET
          PrintFooter.Font.Color = clWindowText
          PrintFooter.Font.Height = -13
          PrintFooter.Font.Name = 'Tahoma'
          PrintFooter.Font.Style = []
          RichEditVersion = 2
          Data = {
            EE0300007B5C727466315C616E73695C616E7369637067313235325C64656666
            305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C5C
            666368617273657430204D532053616E732053657269663B7D7B5C66315C666E
            696C204D532053616E732053657269663B7D7D0D0A5C766965776B696E64345C
            7563315C706172645C625C66305C6673313820466C65786962696C6974795C70
            61720D0A5C623020496E666F506F776572277320636865636B626F7820616C6C
            6F777320796F7520746F20686176652074686520666C65786962696C69747920
            746F2064657465726D696E6520776861742076616C756520696E646963617465
            73206120636865636B626F78207468617420697320636865636B6564206F7220
            756E636865636B65642E205468697320697320706172746963756C61726C7920
            75736566756C20666F72206578616D706C652C20696620796F75206172652063
            757272656E746C792073746F72696E6720696E20746865206461746162617365
            20737472696E672076616C75657320286C696B6520227965732220616E642022
            6E6F222920666F72206120626F6F6C65616E2074797065206669656C642E2020
            596F752063616E20616C736F206F7074696F6E616C6C79207365742077686174
            20636865636B626F7820676C7970682073686F756C6420626520646973706C61
            79656420666F72204E756C6C206669656C64732E205C625C7061720D0A5C7061
            720D0A44796E616D69632043617074696F6E3A5C7061720D0A5C623020557369
            6E6720746869732070726F70657274792C2074686520636865636B626F782773
            2063617074696F6E2077696C6C206368616E676520746F20646973706C617920
            7468652076616C756520746861742069732073746F72656420696E2074686520
            6461746162617365206261736564206F6E207468652063757272656E74207374
            617465206F662074686520636865636B626F782E2020486F77657665722C2077
            69746820496E666F506F7765722033303030277320636865636B626F782C2079
            6F752063616E20616C736F206D6170207468652064617461626173652076616C
            756520746F2061206D6F726520646573637269707469766520636865636B626F
            782063617074696F6E2E5C7061720D0A5C7061720D0A5C62204164646974696F
            6E616C6C795C6230203A5C7061720D0A596F752063616E20656D62656420496E
            666F506F7765722033303030277320636865636B626F7820696E20496E666F50
            6F7765722773205477774442477269642C2054777744617461496E7370656374
            6F722C20616E64205477775265636F72645669657720636F6E74726F6C732E5C
            7061720D0A5C66315C7061720D0A7D0D0A00}
        end
        object wwDBNavigator1: TwwDBNavigator
          Left = 16
          Top = 98
          Width = 521
          Height = 25
          AutosizeStyle = asSizeNavButtons
          DataSource = DataSource1
          RepeatInterval.InitialDelay = 500
          RepeatInterval.Interval = 100
          TransparentClearsBackground = True
          Transparent = True
          object wwDBNavigator1First: TwwNavButton
            Left = 0
            Top = 0
            Width = 38
            Height = 25
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
            Left = 38
            Top = 0
            Width = 38
            Height = 25
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
            Left = 76
            Top = 0
            Width = 38
            Height = 25
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
            Left = 114
            Top = 0
            Width = 37
            Height = 25
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
            Left = 151
            Top = 0
            Width = 37
            Height = 25
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
            Left = 188
            Top = 0
            Width = 37
            Height = 25
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
            Left = 225
            Top = 0
            Width = 37
            Height = 25
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
            Left = 262
            Top = 0
            Width = 37
            Height = 25
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
            Left = 299
            Top = 0
            Width = 37
            Height = 25
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
            Left = 336
            Top = 0
            Width = 37
            Height = 25
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
            Left = 373
            Top = 0
            Width = 37
            Height = 25
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
            Left = 410
            Top = 0
            Width = 37
            Height = 25
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
            Left = 447
            Top = 0
            Width = 37
            Height = 25
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
            Left = 484
            Top = 0
            Width = 37
            Height = 25
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
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 468
    Top = 32
  end
  object ImageList1: TImageList
    Left = 20
    Top = 32
    Bitmap = {
      494C0101030004000C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000052424A005242
      4A0052424A0052424A0052424A0052424A0052424A0052424A0052424A005242
      4A0052424A00000000000000000000000000000000000000000052424A005242
      4A0052424A0052424A0052424A0052424A0052424A0052424A0052424A005242
      4A0052424A0000000000000000000000000000000000000000004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A003942
      39004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C7373008C847300EFB5
      9400EFB59400EFB59400EFB59400EFB59400EFB59400EFB59400EFB59400EFB5
      94008C8473008C8473000000000000000000000000008C7373008C847300EFB5
      9400EFB59400EFB59400EFB59400EFB59400EFB59400EFB59400EFB59400EFB5
      94008C8473008C8473000000000000000000000000007373730084848400ADAD
      AD00B5B5B500B5B5B500B5B5B500ADADAD00B5B5B500B5B5B500B5B5B500B5B5
      B500848484007373730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFB59400FFF7E700FFF7
      E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700EFB59400000000000000000000000000EFB59400FFF7E700FFF7
      E700FFF7E700FFF7E700E7946B00F7CEA500FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700EFB594000000000000000000000000009CA59C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B5B5B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFB59400FFF7E700FFF7
      E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700EFB59400000000000000000000000000EFB59400FFF7E700FFF7
      E700FFF7E700E7946B0000000000C6422100F7CEA500FFF7E700FFF7E700FFF7
      E700FFF7E700F7CEA500000000000000000000000000B5B5B500EFEFEF00FFFF
      FF00EFEFEF0094949400636363004A4A4A00BDBDBD00EFEFEF00EFEFEF00FFFF
      FF00EFEFEF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFAD9400FFF7E700FFF7
      E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700F7CEAD00000000000000000000000000E7A57B00FFF7E700FFF7
      E700E7946B00000000000000000000000000C6422100F7CEA500FFF7E700FFD6
      D600FFF7E700F7CEA5000000000000000000000000009CA59C00EFEFEF00D6D6
      D600949494006363630063636300636363004A4A4A00C6C6C600EFEFEF00D6D6
      D600EFEFEF00BDBDBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7A57B00FFD6D600F7CE
      AD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00FFD6
      D600F7CEAD00EFAD9400000000000000000000000000E7A57B00FFD6D600E794
      6B000000000000000000F7CEA5000000000000000000C6422100F7CEA500FFD6
      D600F7CEA500EFB594000000000000000000000000009CA59C00D6D6D6009494
      94006363630063636300C6C6C60063636300636363004A4A4A00BDBDBD00D6D6
      D600D6D6D600ADADAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7946B00F7CEAD00EFB5
      9400F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CE
      AD00F7CEAD00E7A57B00000000000000000000000000E7946B00F7CEA5000000
      000000000000F7CEA500F7CEA500F7CEA5000000000000000000C6422100F7CE
      A500F7CEA500E7A57B0000000000000000000000000094949400C6C6C6006363
      630063636300C6C6C600C6C6C600BDBDBD0063636300636363004A4A4A00C6C6
      C600BDBDBD009CA59C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7946B00EFB59400EFB5
      9400EFB59400EFB59400EFB59400EFB59400EFB59400EFB59400EFB59400EFB5
      9400EFB59400E7946B00000000000000000000000000E7946B00EFB59400EFB5
      9400EFB59400EFB59400EFB59400EFB59400EFB594000000000000000000C642
      2100EFB59400E7946B0000000000000000000000000084848400B5B5B500BDBD
      BD00B5B5B500B5B5B500BDBDBD00B5B5B500B5B5B50063636300636363004A4A
      4A00B5B5B5009494940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DE735200E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A5
      7B00E7A57B00DE735200000000000000000000000000D6734A00E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00000000000000
      0000C6422100EFB59400000000000000000000000000737373009CA59C009CA5
      9C009CA59C009CA59C009CA59C009CA59C009CA59C0094949400636363006363
      63004A4A4A00B5B5B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B54A1800E7946B00E794
      6B00E7946B00E7946B00E7946B00E7946B00E7946B00E7946B00E7946B00E794
      6B00E7946B00B54A1800000000000000000000000000C6422100E7946B00E794
      6B00E7946B00E7946B00E7946B00E7946B00E7946B00E7946B00E7946B000000
      000000000000C64221000000000000000000000000004A4A4A00949494009494
      9400949494009494940094949400949494009494940094949400949494006363
      6300636363003942390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5391800F7CEAD00F7CE
      AD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CEAD00F7CE
      AD00F7CEAD00B54A1800000000000000000000000000A5391800F7CEA500F7CE
      A500F7CEA500F7CEA500F7CEA500F7CEA500F7CEA500F7CEA500F7CEA500F7CE
      A500000000000000000000000000000000000000000039423900C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600636363006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063000800DE8C8400FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6
      D600DE8C84006300080000000000000000000000000063000800DE8C8400FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6
      D600DE8C8400630008000000000000000000000000001010100084848400D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600949494001010100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000630008006300
      0800630008006300080063000800630008006300080063000800630008006300
      0800630008000000000000000000000000000000000000000000630008006300
      0800630008006300080063000800630008006300080063000800630008006300
      0800630008000000000000000000000000000000000000000000101010001010
      1000101010001010100010101000101010001010100010101000101010001010
      1000101010000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      C007C007C0070000800380038003000080038003800300008003800380030000
      8003800380030000800380038003000080038003800300008003800380030000
      8003800380030000800380038003000080038003800300008003800380030000
      C007C007C0070000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object ImageList2: TImageList
    Left = 284
    Top = 32
    Bitmap = {
      494C0101030004000C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00BDBDBD00BDBDBD00BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00BDBD
      BD00BDBDBD00FFFFFF00BDBDBD00BDBDBD00BDBDBD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00BDBD
      BD00FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00BDBDBD00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00BDBDBD00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBD
      BD00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDBD
      BD00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000E000E000E0000000
      E000E000E0000000800080008000000080008000800000008000800080000000
      8000800080000000800080008000000080008000800000008000800080000000
      8000800080000000800080008000000080008000800000008000800080000000
      8003800380030000800380038003000000000000000000000000000000000000
      000000000000}
  end
  object ImageList3: TImageList
    Height = 19
    Width = 27
    Left = 156
    Top = 32
    Bitmap = {
      494C0101020004000C001B001300FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000006C0000001300000001002000000000001020
      000000000000000000000000000000000000000000003939FF003939FF003939
      FF003939FF003939FF003939FF003939FF003939FF003939FF003939FF003939
      FF003939FF003939FF003939FF003939FF003939FF003939FF00A5ADF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003939FF003939FF003939FF003939FF003939FF003939FF003939FF003939
      FF003939FF003939FF003939FF003939FF003939FF003939FF003939FF003939
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF003939FF00A5ADF700000000000000000000000000000000000000
      0000000000000000000000000000000000003939FF00A5ADF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF00A5ADF700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00ADADAD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF008C8C
      8C004A4A4A00C6C6E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF003939FF00A5ADF700000000000000000000000000000000000000
      0000000000000000000000000000000000003939FF00A5ADF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF00A5ADF700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008C8C8C00000000004A4A4A00ADADAD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00ADADAD006B6B
      6B00000000000000000031293100ADADAD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF003939FF00A5ADF700000000000000000000000000000000000000
      0000000000000000000000000000000000003939FF00A5ADF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF00A5ADF700FFFF
      FF00FFFFFF00FFFFFF00ADADAD004A4A4A000000000000000000000000001010
      10008C8C8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939FF00A5ADF700FFFFFF00FFFFFF00ADADAD006B6B6B001010
      1000000000006B6B6B001010100000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF003939FF00A5ADF700000000000000000000000000000000000000
      0000000000000000000000000000000000003939FF00A5ADF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF00A5ADF700FFFF
      FF00C6C6E7008C8C8C004A4A4A000000000000000000C6C6E700ADADAD001010
      100000000000000000004A4A4A00C6C6E700FFFFFF003939FF00A5ADF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939FF00A5ADF700FFFFFF008C8C8C006B6B6B00000000000000
      000031293100FFFFFF00FFFFFF00ADADAD000000000000000000000000003129
      3100ADADAD003939FF00A5ADF700000000000000000000000000000000000000
      0000000000000000000000000000000000003939FF00A5ADF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF00A5ADF700FFFF
      FF00C6C6E7001010100000000000000000006B6B6B00FFFFFF00FFFFFF00FFFF
      FF00ADADAD0010101000000000000000000010101000636B8400A5ADF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939FF00A5ADF700FFFFFF00FFFFFF00ADADAD00312931000000
      0000C6C6E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00ADADAD00101010000000
      000000000000000000004A4A4A006B6B6B000000000000000000000000000000
      0000000000000000000000000000000000003939FF00A5ADF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF00A5ADF700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008C8C8C00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6E700101010000000000000000000000000001010
      10006B6B6B000000000000000000000000000000000000000000000000000000
      00003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004A4A4A0000000000000000000000000000000000312931006B6B6B000000
      0000000000000000000000000000000000003939FF00A5ADF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003939FF00A5ADF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF00A5ADF700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0042429C00000000000000
      0000000000000000000000000000101010003129310000000000000000000000
      00003939FF00A5ADF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939FF00A5ADF700A5ADF700A5ADF700A5ADF700A5ADF700A5AD
      F700A5ADF700A5ADF700A5ADF700A5ADF700A5ADF700A5ADF700A5ADF700A5AD
      F700A5ADF7003939FF00A5ADF7004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000003939FF00A5ADF700A5ADF700A5AD
      F700A5ADF700A5ADF700A5ADF700A5ADF700A5ADF700A5ADF700A5ADF700A5AD
      F700A5ADF700A5ADF700A5ADF700A5ADF7003939FF00A5ADF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF003939FF003939
      FF003939FF003939FF003939FF003939FF003939FF003939FF003939FF003939
      FF003939FF003939FF003939FF003939FF003939FF003939FF00A5ADF7000000
      0000000000003129310000000000000000000000000000000000000000000000
      00003939FF003939FF003939FF003939FF003939FF003939FF003939FF003939
      FF003939FF003939FF003939FF003939FF003939FF003939FF003939FF003939
      FF003939FF00A5ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A4A
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000006C0000001300000001000100
      00000000300100000000000000000000000000000000000000000000FFFFFF00
      80001FF00003FC00000000000000000080001FF00003FC000000000000000000
      80001FF00003FC00000000000000000080001FF00003FC000000000000000000
      80001FF00003FC00000000000000000080001FF00003FC000000000000000000
      80001FF00003FC00000000000000000080001FF00003FC000000000000000000
      80001FF00003FC00000000000000000080001FF00003FC000000000000000000
      80001FF00003FC00000000000000000080000FF00003FC000000000000000000
      800007F00003FC000000000000000000800001F00003FC000000000000000000
      800000700003FC000000000000000000800000300003FC000000000000000000
      800018300003FC000000000000000000FFFFFE7FFFFFFC000000000000000000
      FFFFFFFFFFFFFC00000000000000000000000000000000000000000000000000
      000000000000}
  end
  object ImageList4: TImageList
    Height = 23
    Width = 19
    Left = 412
    Top = 32
    Bitmap = {
      494C0101020004000C0013001700FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000004C000000170000000100200000000000501B
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000734A6300734A630052314A0052314A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094638400A56B9400946384008452
      7300734A6300734A630052314A0052314A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5739C00B5739C00A56B940094638400945A840084527300734A63005231
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BD7BAD00CE84B500B5739C00BD7BAD00B573
      9C00A56B9400945A840084527300734A630052314A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A4A004A4A4A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE84
      B500CE84B500CE84B500CE84B500B5739C00B5739C00A56B9400945A8400734A
      63005A3952000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A4A
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DE8CC600DE8CC600E794CE00F7B5DE00CE84
      B500BD7BAD00B5739C00A56B940084527300734A630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006B6B6B004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E794
      CE00E794CE00F7A5DE00FFFFFF00F7B5DE00CE84B500B5739C00A56B94009463
      8400734A63000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B004A4A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E794CE00E794CE00F7A5DE00E794
      CE00CE84B500BD7BAD00B5739C00946384000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B6B6B006B6B6B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E794CE00E794CE00E794CE00DE8CC600CE84B500CE84B500B5739C009463
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B6B6B006B6B6B004A4A4A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E794CE00DE8C
      C600CE84B500BD7BAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000734A6300734A630052314A0052314A006B6B
      6B004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094638400946384009463
      8400945A8400734A6300734A630052314A0052314A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5739C00B5739C00A56B9400A56B9400945A840084527300734A
      630052314A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BD7BAD00CE84B500B5739C00B573
      9C00B5739C00A56B9400945A840084527300734A630052314A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE84B500CE84B500E794CE00CE84B500B5739C00B5739C00A56B9400945A
      8400734A630052314A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CE84B500E794CE00E794CE00E794
      CE00E794CE00CE84B500A56B9400A56B940084527300734A6300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E794CE00E794CE00E794CE00FFFFFF00E794CE00CE84B500BD7BAD00A56B
      940094638400734A630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E794CE00E794CE00E794
      CE00E794CE00CE84B500B5739C00B5739C009463840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E794CE00E794CE00E794CE00CE84B500E794CE00BD7BAD00B573
      9C00946384000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E794
      CE00E794CE00CE84B500BD7BAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000004C0000001700000001000100
      00000000140100000000000000000000000000000000000000000000FFFFFF00
      FFFFFFFFFC00000000000000FFFFFFFFFC00000000000000FFFFFFFFFC000000
      00000000FFC3FFFFFC00000000000000FF00FFFFBC00000000000000FF00FFFF
      7C00000000000000FE007FFE7C00000000000000FE007FFEFC00000000000000
      FE007FFCFC00000000000000FE007FF9FC00000000000000FF00FFF3FC000000
      00000000FF00FFE3FC00000000000000FFC3FE07FC00000000000000FFFFF807
      FC00000000000000FFFFF807FC00000000000000FFFFF003FC00000000000000
      FFFFF003FC00000000000000FFFFF003FC00000000000000FFFFF003FC000000
      00000000FFFFF807FC00000000000000FFFFF807FC00000000000000FFFFFE1F
      FC00000000000000FFFFFFFFFC00000000000000000000000000000000000000
      00000000000000000000}
  end
  object ImageList5: TImageList
    Height = 21
    Width = 15
    Left = 516
    Top = 120
    Bitmap = {
      494C0101020004000C000F001500FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000003C000000150000000100200000000000B013
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000313931000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B0000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B000000000000000000000000007B7B7B00000000000000
      0000000000007B7B7B000000000000000000101010007B7B7B00000000000000
      00007B7B7B001010100000000000000000000000000000000000000000000000
      0000000000000000000000000000101010007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000008
      00007B7B7B00000000000000000000000000000000007B7B7B00000800000000
      0000000000000000000000000000000000000000000000000000000800007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000008000000000000000000000000
      00000000000000000000000800007B7B7B000000000000000000000000000000
      000000000000000000007B7B7B00000800000000000000000000000000000000
      000000000000000800007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B0000080000000000000000000000000000000800007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B0000000000000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0031393100313931003139
      31007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B002929
      2900292929000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00292929002929
      2900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000000000000000000029292900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B000000000000000000000000002929290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      0000000000002929290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0000000000000000000000
      0000292929000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00313931003139310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0031393100313931000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000003C0000001500000001000100
      00000000A80000000000000000000000000000000000000000000000FFFFFF00
      F93FF27C00000000F93FF27C00000000F93FF27C00000000F93FF27C00000000
      F93FF27C00000000F93FF27C00000000F93FF27C00000000C007F07C00000000
      C007F07C00000000E00FF07C0000000090133064000000008823104400000000
      C447800C00000000E00FC01C00000000F01FE03C00000000F83FF07C00000000
      FFFFFFFC00000000FC7FF8FC00000000F83FF07C00000000F83FF07C00000000
      FC7FF8FC0000000000000000000000000000000000000000000000000000}
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 496
    Top = 32
    Data = {
      413900009619E0BD01000000180000000F006A0000000300000031020B437573
      746F6D6572204E6F04000100000001000950524F56464C414753040001800700
      000005427579657201004900000001000557494454480200020003000C436F6D
      70616E79204E616D6501004900000001000557494454480200020028000A4669
      727374204E616D650100490000000100055749445448020002001900094C6173
      74204E616D650100490000000100055749445448020002001900065374726565
      740100490000000100055749445448020002003C000443697479010049000000
      0100055749445448020002001900055374617465010049000000010005574944
      5448020002001900035A69700100490000000100055749445448020002000A00
      12466972737420436F6E74616374204461746504000600000000000C50686F6E
      65204E756D62657201004900000001000557494454480200020014000B496E66
      6F726D6174696F6E04004B000000020007535542545950450200490005005465
      78740005574944544802000200500008526963684564697404004B0000000200
      075355425459504502004900070042696E617279000557494454480200020050
      000E5265717565737465642044656D6F01004900000001000557494454480200
      02000300074C6F676963616C020003000000000003000D44454641554C545F4F
      524445520400820001000000010000000B5052494D4152595F4B455904008200
      0100000001000000044C434944040001000904000000000040105C010000024E
      6F0E4769616E7420506C756D62696E67044A6F686E07536368756C747A154772
      6567657273656E7376656A2C20504F20313431104665726E616E64696E612042
      6561636802464C0536373632357C1B0B000C3435322D3737332D30343434A202
      00007B5C727466315C616E73695C64656666305C6465667461623732307B5C66
      6F6E7474626C7B5C66305C667377697373204D532053616E732053657269663B
      7D7B5C66315C66726F6D616E5C6663686172736574322053796D626F6C3B7D7B
      5C66325C66726F6D616E5C6663686172736574312054696D6573204E65772052
      6F6D616E3B7D7B5C66335C66726F6D616E5C6663686172736574312054696D65
      73204E657720526F6D616E3B7D7B5C66345C66726F6D616E5C66707271322054
      696D6573204E657720526F6D616E3B7D7B5C66355C667377697373204D532053
      616E732053657269663B7D7B5C66365C66726F6D616E2054696D6573204E6577
      20526F6D616E3B7D7B5C66375C6673776973735C666368617273657431204D53
      2053616E732053657269663B7D7B5C66385C6673776973735C66636861727365
      7431204D532053616E732053657269663B7D7D0D0A7B5C636F6C6F7274626C5C
      726564305C677265656E305C626C7565303B5C7265643132385C677265656E30
      5C626C7565303B5C726564305C677265656E305C626C75653235353B7D0D0A5C
      6465666C616E67313033335C706172645C706C61696E5C66355C667331365C63
      6631205468697320697320736F6D655C706C61696E5C66385C6673313620205C
      706C61696E5C66365C667334305C6366325C6220526963682045646974205465
      78740D0A5C706172205C706C61696E5C66365C667332305C6366325C62200D0A
      5C706172205C706C61696E5C66365C667332305C6366305C62204A7573742075
      736520746865206D6F75736520616E642072696768742D636C69636B20746F20
      676574206D6F7265207269636820746578742065646974696E67206F7074696F
      6E732E0D0A5C706172205C706C61696E5C66385C66733136200D0A5C70617220
      7D0D0A00024E6F0000000010EC010000035965730C506970205072696E74696E
      67044361726C064C6576696E65173936303720436F6D6D6F6E7765616C746820
      426C76642E0853616E204A6F7365024341053935313137A51B0B000C3037332D
      3537302D36373533DD010000576974682074686520496E666F506F776572204F
      6E46696C746572206576656E742C20796F752063616E20636F6D706172652074
      776F206461746162617365206669656C647320776974682065616368206F7468
      65722028666F72206578616D706C653A204669656C6431203C204669656C6432
      292C20646F206269747769736520636F6D70617269736F6E7320696E20666965
      6C64732C20686176652066696C7465727320646570656E64656E742075706F6E
      206F746865722072656C61746564207461626C65732C206F7220616E79746869
      6E6720656C736520796F752063616E206578707265737320696E20636F64652E
      2054686973206576656E74206973206D6F73742070726163746963616C207768
      656E207573656420616761696E7374206C6F63616C207461626C657320285061
      7261646F78206F72206442415345292062656361757365207768656E20757365
      6420616761696E73742053514C207461626C65732C20746865206261636B2D65
      6E642064617461626173652073797374656D2069732070726576656E74656420
      66726F6D206F7074696D697A696E67207468652066696C7465722C2073696E63
      65206576657279207265636F72642069732070617373656420746F2074686973
      206576656E742E0D0AA20200007B5C727466315C616E73695C64656666305C64
      65667461623732307B5C666F6E7474626C7B5C66305C667377697373204D5320
      53616E732053657269663B7D7B5C66315C66726F6D616E5C6663686172736574
      322053796D626F6C3B7D7B5C66325C66726F6D616E5C66636861727365743120
      54696D6573204E657720526F6D616E3B7D7B5C66335C66726F6D616E5C666368
      6172736574312054696D6573204E657720526F6D616E3B7D7B5C66345C66726F
      6D616E5C66707271322054696D6573204E657720526F6D616E3B7D7B5C66355C
      667377697373204D532053616E732053657269663B7D7B5C66365C66726F6D61
      6E2054696D6573204E657720526F6D616E3B7D7B5C66375C6673776973735C66
      6368617273657431204D532053616E732053657269663B7D7B5C66385C667377
      6973735C666368617273657431204D532053616E732053657269663B7D7D0D0A
      7B5C636F6C6F7274626C5C726564305C677265656E305C626C7565303B5C7265
      643132385C677265656E305C626C7565303B5C726564305C677265656E305C62
      6C75653235353B7D0D0A5C6465666C616E67313033335C706172645C706C6169
      6E5C66355C667331365C636631205468697320697320736F6D655C706C61696E
      5C66385C6673313620205C706C61696E5C66365C667334305C6366325C622052
      696368204564697420546578740D0A5C706172205C706C61696E5C66365C6673
      32305C6366325C62200D0A5C706172205C706C61696E5C66365C667332305C63
      66305C62204A7573742075736520746865206D6F75736520616E642072696768
      742D636C69636B20746F20676574206D6F726520726963682074657874206564
      6974696E67206F7074696F6E732E0D0A5C706172205C706C61696E5C66385C66
      733136200D0A5C706172207D0D0A00024E6F0000000010FA0100000359657309
      54656C652D5061746806526162626974054F6C64656E1B3134363020496E666F
      726D6174696F6E20546563682E20496E632E034172740254580537363832302E
      1C0B000C3138372D3531372D303536309B0000004D6F7665204D6F757365204F
      7665722043656C6C730D0A0D0A4175746F6D6174696320546F6F6C2054697073
      2048696E747320646973706C617920666F72207465787420746861742077696C
      6C206E6F742066697420696E207468652063757272656E742063656C6C2E0D0A
      48696E747320737570706F727420776F72647772617020616E6420637573746F
      6D697A6564207769647468732E0D0AA20200007B5C727466315C616E73695C64
      656666305C6465667461623732307B5C666F6E7474626C7B5C66305C66737769
      7373204D532053616E732053657269663B7D7B5C66315C66726F6D616E5C6663
      686172736574322053796D626F6C3B7D7B5C66325C66726F6D616E5C66636861
      72736574312054696D6573204E657720526F6D616E3B7D7B5C66335C66726F6D
      616E5C6663686172736574312054696D6573204E657720526F6D616E3B7D7B5C
      66345C66726F6D616E5C66707271322054696D6573204E657720526F6D616E3B
      7D7B5C66355C66726F6D616E2054696D6573204E657720526F6D616E3B7D7B5C
      66365C6673776973735C666368617273657431204D532053616E732053657269
      663B7D7B5C66375C667377697373204D532053616E732053657269663B7D7B5C
      66385C6673776973735C666368617273657431204D532053616E732053657269
      663B7D7D0D0A7B5C636F6C6F7274626C5C726564305C677265656E305C626C75
      65303B5C726564305C677265656E305C626C75653235353B5C7265643132385C
      677265656E305C626C7565303B7D0D0A5C6465666C616E67313033335C706172
      645C706C61696E5C66375C667331365C636632205468697320697320736F6D65
      5C706C61696E5C66385C6673313620205C706C61696E5C66355C667334305C63
      66315C622052696368204564697420546578740D0A5C706172205C706C61696E
      5C66355C667332305C6366315C62200D0A5C706172205C706C61696E5C66355C
      667332305C6366305C62204A7573742075736520746865206D6F75736520616E
      642072696768742D636C69636B20746F20676574206D6F726520726963682074
      6578742065646974696E67206F7074696F6E732E0D0A5C706172205C706C6169
      6E5C66385C66733136200D0A5C706172207D0D0A00024E6F0000004011DC0200
      000359657303484D5303526564064361726E65791F3130303020506173656F20
      43616D6172696C6C6F2C20537569746520323135044775797302544E05333833
      3339D61C0B000C3533392D3830352D30363830024E6F00000040115E03000003
      5965730B53746172205265636F7273054A6F616E6E05526F7965720C502E4F2E
      20426F78203732370842656576696C6C65025458053738313032AF1B0B000C35
      39352D3130322D30313738024E6F000000401169030000035965731C496E7465
      726E6174696F6E616C20466F6F642045717569706D656E7403426F62074D634D
      6168656C1F3130303020506173656F2043616D6172696C6C6F2C205375697465
      20323135065075746E616D024354053036323630AC1C0B000C3535312D373236
      2D38313636024E6F000000401190030000024E6F14486F6C646572277320436F
      756E74727920496E6E07436861726C6573055472616379113135343120416464
      69736F6E20526F61640C42656C6C6520506C61696E65024941053532323038EB
      1B0B000C3536302D3338382D34323739024E6F0000004011C5030000024E6F0C
      466F616D20526F6F66696E67044D61726B0652616E6B696E0D36303030204A20
      5374726565740941504F204D69616D6902464C0533343033334A1C0B000C3236
      312D3436362D39363635024E6F00000040114C040000024E6F1244616C6C6173
      205368656574204D6574616C0648616E6E616805546F7272651033333020436F
      6D6D657263652053742E074368696361676F02494C0536303634348E1C0B000C
      3035342D3133322D38363838024E6F00000040115C040000024E6F0C54617261
      6E636520436F7270064C65616E6E6508426F72726573656E16504F20426F7820
      3631393631362C204D442033313130054E656F6C61024941053531353539071C
      0B000C3031362D3033372D32383934024E6F0000004011660400000359657309
      4153415020436F72700D456D706C6F7965652032353630064865737365722254
      686520477265656E7761792C20363320576172646C6520526F61642C2053616C
      65074D63204C65616E025458053739303537A11B0B000C3634322D3133352D31
      343834024E6F000000401119050000035965730D4D6F7573652053797374656D
      73084A616D657320462E094C6F72656E747A656E133735303120466F6F746869
      6C6C20426C76642E084A61726269646765024E560538393832366B1C0B000C39
      33362D3230392D31373730024E6F000000401140050000035965731444697665
      7273696669656420436F6D70757465720548656E7279054B6F666F6413343632
      30204D696E6E65736F7461204176652E0B4761696E657376696C6C6502464C05
      3332363130861C0B000C3232352D3135322D30373432024E6F00000040114705
      0000024E6F0B412644205265736561726303526F640A4D63436C696E746F636B
      0D48434F3120426F78203432414106497276696E67025458053735303135D41C
      0B000C3036302D3531322D39383636024E6F000000401162050000024E6F0D4A
      616D6573202620426C6F636B034A696D08536368776172747A12363330302053
      7761696E6C616E642052642E0757617665726C79025641053731363734B51B0B
      000C3837372D3338352D38393833024E6F00000040117C050000024E6F0E4265
      726B656C65792047726F7570075269636861726405526561676F0E3134303120
      426F6767732044722E0C44756E63616E7376696C6C650250410531363633359E
      1B0B000C3637362D3239312D31393833024E6F00000040113106000003596573
      1447726F757020313320436F6E73756C74616E74730745726E6573746F0B5361
      6C76657374726F6E691132353420576573746669656C642053742E0744657472
      6F6974024D49053438323130AF1B0B000C3134362D3738322D30353036024E6F
      00000040114D060000035965730B4865616C7468496D61676505537465766505
      526F757365113834313620436861737461696E2044722E084D696C6C776F6F64
      024B59053432373632AF1B0B000C3937342D3235352D30383736024E6F000000
      40114F0600000359657318486F7573746F6E204C69676874696E67202620506F
      7765720448756768055768797465123139204F6C64204869636B6F7279205264
      2E0741746C616E7461024741053330333637811C0B000C3437312D3130362D37
      303536024E6F0000004011DA070000024E6F184361696E264162656C20436F6D
      6D756E69636174696F6E7305436C697665084E6F727468726F70143735303120
      466F6F7468696C6C7320426C76642E094C6F6E65205374617202534305323930
      3737981B0B000C3331372D3233342D39323237024E6F0000004011EA07000003
      596573094769616E744C616E64044E69636B064C6974746C6511526F75746520
      31382C20426F78203432300943726F6F6B73746F6E024E45053639323132C41C
      0B000C3336312D3930352D32323230024E6F000000401105080000024E6F0F54
      6F7973204576657279776865726507526963686172640259751F323437392050
      656163687472656520526F61642C20537569746520313731300B506F72742041
      7274687572025458053737363433C21B0B000C3437342D3637392D3634323202
      4E6F00000040112B080000024E6F104164766F636174652053797374656D7305
      53636F7474064C6F7669636B1332325733333020576F6F64766965772044722E
      09537461726C696768740250410531383436312E1C0B000C3535312D3733302D
      35383337024E6F000000401183080000024E6F0B5370696E6520436F72702E08
      504F2334363430340750696E6861736912373635352045617374203436746820
      53742E0748616D70746F6E025641053233363637A01B0B000C3730342D353732
      2D30313934024E6F0000004011F208000003596573114372797374616C20426C
      756520496E632E044465616E074A696D656E657A1D31313120416E7A6120426F
      756C65766172642C205375697465203230300D4E6F727468204368617468616D
      024D41053032363530D11B0B000C3338352D3636302D30323938024E6F000000
      40118A090000035965730C4144412050726F6475637473074A6F686E20452E05
      536361666611313430204361736361646520426C76642E045769736502564105
      3234323933AA1C0B000C3637332D3735322D31323932024E6F0000004011A609
      000003596573165370656369616C205365727669636520262043617265084A61
      6D657320462E07466F726468616D1D333720456173742043656E746572205374
      2E2C20537569746520323130064D656C76696E02494C0536303935325D1C0B00
      0C3737352D3431372D36363739024E6F0000004011D1090000035965730B4253
      41204C696D69746564044D696B650553657272610C4B616E61616C7765672033
      330D57696E7465722047617264656E02464C0533323738372E1C0B000C353736
      2D3534382D33373630024E6F0000004011EC0900000359657313416C756D696E
      756D20546563686E6F6C6F677907446F726F74687906426F776C65721B313231
      3820337264204176656E75652C20537569746520313830390857696C6C69616D
      73024F520539373534348E1C0B000C3630382D3036392D35333438024E6F0000
      0040110A0A0000035965731C57696E64736F72205265616C7479202620457175
      69747920436F7270035975650443686F650F3230382056616C6C657920526F61
      640A53636F747473626F726F02414C053335373638CE1C0B000C3035312D3939
      302D31393131024E6F0000004011BD0A0000035965731153696D736275727920
      417175617469637305456C76696E064361726E6579213333303020426174746C
      6567726F756E64204176652E2C20537569746520323232074375747368696E02
      4B59053431373332A81C0B000C3538362D3639342D39353032024E6F00000040
      11E70A0000035965730F53696C76657220536F6674776172650653616E647261
      084B656E647269636B2033383820477265656E776963682053742E2C20466C6F
      6F7220313520576573740B4E6577204F726C65616E73024C4105373031343670
      1B0B000C3537382D3236332D30313230024E6F00000040114B0B000003596573
      0B54617267657420496E632E084861727265736F6E054F6C64656E1B32313020
      4561737420313574682053742E2C2053756974652039520847617076696C6C65
      024B59053431343333AA1C0B000C3837362D3735382D31343336024E6F000000
      4011530B00000359657310536F6C7665497420436F6D7075746572044D617474
      074272696467657315323830383120536F7574686669656C6420526F6164044D
      616C6F025741053939313530051D0B000C3433302D3231312D30373838024E6F
      0000004011570B000003596573094D6F62696C204F696C0A436861726C657320
      4C2E094D6F7272697373657915352046697220436F7572742C20537569746520
      314109436861726C6F747465024E430532383233335F1C0B000C3731392D3139
      372D39323834024E6F00000040119A0B0000024E6F04536F6E7909476572616C
      6420502E04536175720C31343020486F6C742052642E0B42726F6F6B65736D69
      7468025458053736383237A11C0B000C3435322D3937342D37373434024E6F00
      00004011C40B0000035965730F4D65796572204170706C69616E636503426F62
      0553746F6E6511353130204F6365616E204176652E202331045A61686C024E44
      053538383536C11B0B000C3537392D3837352D37393638024E6F0000004011D3
      0B000003596573065A656E697468064861726F6C640853636861656665722255
      5620436F6C6C6567652053616C666F72642C2046726564657269636B20526F61
      640B50616E6E61204D61726961025458053738313434B01B0B000C3731352D34
      30322D31363533024E6F0000004011190C0000024E6F0F486967682054656368
      6E6F6C6F67790553746576650743616C61796167113234333020436F6E736175
      6C20526F61640E506C656173616E742047726F7665025554053834303632741B
      0B000C3936312D3633342D33313531024E6F0000000011710C00000359657312
      496E74656772617465642053797374656D7302456405416E69646F1331303331
      35204D6F756E7461696E205061726B084F616B2048616C6C0256410532333431
      36CA1B0B000C3238342D3237332D343034309D0000005468697320697320736F
      6D652073616D706C652074657874207468617420676F657320696E746F206120
      6D656D6F206669656C642E0D0A0D0A546F20706F702D75702074686973206564
      69746F722C2065697468657220646F75626C652D636C69636B20746865206D65
      6D6F206669656C64206F7220656E746572204632207768656E20746865206D65
      6D6F206669656C64206973206163746976652E024E6F0000004011810C000003
      5965731853797374656D20456C6576656E204173736F636961746573044A6F68
      6E05426C61636B08426F7820353233310B4C616B6520417274687572024E4D05
      3838323533381D0B000C3738302D3136342D34323233024E6F0000004011AC0C
      00000359657312537072696E7420436F72706F726174696F6E054A616D657306
      486F75736572133434392053696C6173204465616E65204877790744616E6275
      7279024354053036383136A01B0B000C3230352D3839312D32323838024E6F00
      00004011CB0C0000024E6F104F72616E676520436F6D707574657273074A6F68
      6E20482E0642696C69636B15323334362050616E6F72616D6120546572726163
      650654656E646F79024944053833343632B01C0B000C3736382D3133392D3132
      3530024E6F0000004011640D0000035965730E416D6920436F6D706F6E656E74
      7303426F620749756C69616E6F1132343830204C616B65736964652044722E06
      4C6177746F6E025041053138383238C21B0B000C3239362D3231312D32363835
      024E6F0000000011D20E0000024E6F0B576865656C20576F726B73044361726C
      04426167651B3133343535204E6F656C20526F61642C20537569746520313735
      300641796C657474025641053233303039A41B0B000C3737312D3834392D3738
      3839020100004D6F7665204D6F757365204F7665722054686973204772696420
      43656C6C2E0D0A0D0A496E666F506F7765722032303030206175746F6D617469
      63616C6C7920646973706C617973207468652066756C6C2074657874206F6620
      612063656C6C206173206120746F6F6C20746970207768656E20746865206D6F
      757365206973206D6F766564206F76657220612063656C6C2074686174206973
      206E6F74206C6172676520656E6F75676820746F20646973706C617920616C6C
      206F662074686520746578742E2054686520746F6F6C207469707320616C736F
      20737570706F7274206D656D6F206669656C647320616E64206D756C7469706C
      65206C696E65732E024E6F0000004011330F00000359657312416D6572696361
      2773205469726520436F2E0654686F6D61730446756E67213333303020426174
      746C6567726F756E64204176652E2C20537569746520323232064C616D6F6E74
      024D490534393433308B1C0B000C3630342D3835362D33353038024E6F000000
      401129100000035965730F54726176656C20496E736964657273044772656705
      4869636B73143534204176656E7565206465204368616D70656C074E6F76656C
      7479024D4F0536333436306B1C0B000C3735322D3133322D38333733024E6F00
      0000401195100000024E6F1743656E7472616C20416E696D616C20486F737069
      74616C0A5269636861726420422E0442656C6C15343431372050697463682050
      696E6520436F7572740942726164656E746F6E02464C053334303933A51B0B00
      0C3636312D3131382D33383339024E6F0000004011D1100000024E6F0D44696E
      6120536572766963657303546F6D054C65776973103139323220416C62657274
      612044722E0744656361747572024741053330303334741B0B000C3038322D30
      38382D32333236024E6F000000401101110000035965730B4F66666963652049
      6E632E0757696C6C69616D0A56616E6465726C61616E1A313239352053746174
      652053742E2C20446570742E204B313632064D616E64616E024E440535383535
      34751B0B000C3033342D3236382D38303231024E6F0000004011B8120000024E
      6F0E4D65747269632053797374656D73034B696D0A4D63436C696E746F636B10
      3231323020532E2054686F6D70736F6E064175726F726102434F053830303135
      0B1C0B000C3630302D3439322D37373137024E6F00000040118B130000035965
      731054656C6C61204379636C652053686F70045061756C07537769747A657210
      323138204361726F6C696E612043742E075374616E6C6579024B590534323337
      35EF1B0B000C3933352D3334342D37343632024E6F0000004011381400000359
      65730F526F636B657420536F66747761726508446576696E646572094A61696B
      6F77736B6910353038322047617A616E69612044722E0857616B617275736102
      4B53053636353436EB1B0B000C3031392D3433302D36373336024E6F00000040
      117A140000024E6F1753742E204C6F75697320486F7573696E6720446570742E
      03526F6E095363686F656E6572740B373020426F7720526F61640950656E7361
      636F6C6102464C053332353935DE1B0B000C3336332D3133392D35303837024E
      6F000000401129150000035965730E466C6F7070792053797374656D73055363
      6F74740553686172701D353733372054686F726E68696C6C2044722E2C205375
      69746520323037095761746572666F7264025749053533313835B71C0B000C38
      36312D3431342D37393638024E6F0000004011A1150000035965730D53757072
      656D6520466F6F6473084861727265736F6E05467269736B1035373030204772
      6967677320526F616406546F6C65646F024F48053433363233CF1B0B000C3035
      392D3533362D35313530024E6F0000004011AD150000035965731442756C6C65
      742D70726F6F662053797374656D730444616C65044D61726B1E507269766174
      652042616720343030352C204B696D6265726C792052642E0B4761696E657376
      696C6C6502464C0533323630388B1C0B000C3635332D3438372D30313436024E
      6F0000004011331600000359657313416C61736B6120437275697365204C696E
      657309446F6D696E69717565084970706F6C69746F1831313520572E20393974
      68205465727261636520233330360943726F636865726F6E024D440532313632
      37C21B0B000C3434312D3336372D38373238024E6F0000004011701600000359
      65730A4D656C6F6E2053686F70044E69636B0646616C6C6F6E0D383431392035
      7468204176652E09436F6E6F77696E676F024D44053231393138AE1B0B000C38
      30322D3431322D32353337024E6F000000401180160000035965730C50616369
      6669632042656C6C044E65616C07436F6C656D616E0C352057616C6C65722043
      742E0B416E676C6520496E6C6574024D4E053536373131FD1B0B000C3738392D
      3137332D34393530024E6F000000401184160000024E6F0D4C6F676963205379
      7374656D73044D617474044B696E671237393332204265616368776F6F642043
      742E06546F70656B61024B53053636363039BD1B0B000C3931362D3836372D39
      313431024E6F0000004011D2160000035965731A53616E746120436C61726120
      4D65646963616C2043656E746572055374657665074875626265727418323520
      572E20343574682053742E2C20526F6F6D2032303109526F6368657374657202
      4E59053134363532AF1B0B000C3531392D3837352D32333436024E6F00000040
      11FC160000035965731448656C6D20506174696F204675726E69747572650A41
      74746E3A204361726C0452616D701931205075626C6963205371756172652C20
      5374652E20323035085374616D666F72640243540530363931337B1B0B000C32
      31342D3238372D31373331024E6F000000401114170000035965730F426C6163
      6B6265727279204661726D074761796E61726408536368616368617410353136
      2042757263686574742053742E0552616D657202414C053336303639741B0B00
      0C3938342D3733382D35313630024E6F00000040117717000003596573134C69
      6265727479205375706572205072696E74054C6F67616E07536166746C657213
      363020576573742031337468205374726565740548616E6E6102575905383233
      3237751B0B000C3236332D3334322D39373339024E6F0000004011B617000003
      5965731044617461626173652044657369676E730941647269616E20522E0853
      7465726C696E6712383031204E6F72746820333173742053742E074C696C6C69
      616E02414C0533363534393F1C0B000C3033372D3036302D36303037024E6F00
      000040111E180000024E6F0B5265636F7264204261726E044D696B6504526565
      730E3130313737204C616B65736964650B5765776168697463686B6102464C05
      3332343439C81B0B000C3836362D3232332D37353936024E6F00000040116718
      00000359657312416D65726963616E205265642043726F73730941647269616E
      20522E07436F6E6472656E15323135312043616E796F6E20437265656B204472
      2E085768697474696572024341053930363033931C0B000C3038312D3738372D
      30333034024E6F0000004011021900000359657311537472617465677920536F
      667477617265044A6F686E0749756C69616E6F1D31333130205761756B656761
      6E20526F61642C205375697465203130340852616E64616C6961024941053532
      313634D01B0B000C3538302D3433342D33333930024E6F000000401129190000
      035965731150617274792054696D652043656E74657202416C06486174746F6E
      0F32382048657269746167652052642E064372656F6C65024C41053730363332
      101C0B000C3930372D3539302D37333330024E6F000000401147190000035965
      730C50595445204C696D6974656405436C61726B07466F676572747913383030
      32205061726B2043726573742044722E06546970746F6E024B53053637343835
      D21B0B000C3130322D3430352D37343731024E6F000000401197190000024E6F
      16416D65726963616E2052656E74616C2043656E74657203546F6D0742656172
      64656E0C31343020486F6C742052642E0D57696E73746F6E2D53616C656D024E
      43053237313536C11B0B000C3931322D3732382D38343831024E6F0000004011
      A21900000359657311496E7465725472616B2053797374656D73055761796E65
      0557616C6C730C33353135205720546F7568790C57696C6C69616D7362757267
      024E4D053837393432C41B0B000C3533322D3335382D37363836024E6F000000
      4011A9190000024E6F1A50726F6772616D20537570706F7274204173736F6369
      6174657303526F6E074D6F75726176611132353420576573746669656C642053
      742E0B5374726F6E672043697479024B53053636383639711C0B000C3035352D
      3137362D36343436024E6F00000040114A1A0000035965730B393920536F6674
      77617265074D69636861656C06506F736E65720A504F20426F78203434310E4E
      6F7274682042726F6F6B6C696E024D45053034363631CB1C0B000C3034362D33
      32302D39393937024E6F0000004011791A00000359657313416C6D6F6E642054
      6563686E6F6C6F67696573034D656C074F274E65696C6C1231373820426C6163
      6B666F7264204176652E0D4E6F72746820486F6F7369636B024E590531323133
      33BB1C0B000C3239382D3034312D37313335024E6F0000004011891A00000359
      657305496E74656C07436861726C65730943617270656E746572113234303720
      436861726C6573204176652E06576178686177024E43053238313733B51B0B00
      0C3234392D3832352D35353539024E6F0000004011B51A000003596573144F73
      68204B6F736820547275636B20436F72702E055761796E65044B6F6F74123132
      3635352042656174726963652053742E0448616C6C024E59053134343633DA1B
      0B000C3335322D3638392D36363737024E6F0000004011F71A0000035965730E
      4B696E6B6F277320436F7069657306546F70616E6907537665746C696B0F3536
      303520476F6C64636F2044722E0646616E6E696E025458053737393630661C0B
      000C3536382D3230342D38323633024E6F0000004011331C0000035965731E55
      6E697465642050686F746F6772617068696320496E6475737472696573084A61
      6D657320462E0543726F73731231363435204E6F72746820426172636C617909
      41737361776F6D616E0256410532333330327C1B0B000C3136362D3831382D31
      353038024E6F00000040113F1C000003596573134C69676874686F7573652053
      6572766963657305576F6F6479034672791237372042726F6164204163726573
      2052642E07526F616E6F6B65025641053234303134801C0B000C3339392D3730
      342D33333833024E6F0000004011C41C0000035965730D436172656572204365
      6E74657206446F6E616C64075061636865636F0F32333037204F7265676F6E20
      53742E07486F7573746F6E025458053737303039C41C0B000C3237332D383434
      2D33353136024E6F0000004011141D0000024E6F0F416E646572736F6E205374
      616D707305416C6C656E084F6C69766172657A173631302057657374204C6F75
      697369616E6E612053742E074A75706974657202464C053333343738B91B0B00
      0C3131352D3832312D30373033024E6F0000004011E91D000003596573164566
      66696369656E74204C69676874696E6720436F2E0746656C65636961044B756E
      7A0B504F20426F782037313531094C6F74747362757267025641053232353131
      7B1C0B000C3034322D3333322D37323135024E6F0000004011651E0000035965
      731155534B204D616E75666163747572696E67065379646E6579064D63477261
      77113637323020506F747265726F204176652E094661726D76696C6C65025641
      053233393433FD1B0B000C3635332D3131392D31333137024E6F000000401172
      1E0000024E6F15457665205072696E74696E672053657276696365730653616E
      64726107456C6C696F74742632303020686172727920532E205472756D616E20
      5061726B7761792C205375697465203232300744656572696E67024D4F053633
      383430CF1C0B000C3434322D3133352D33323334024E6F0000004011A11E0000
      024E6F135374617465206F662057617368696E67746F6E0354696D0853636861
      6566657211333630352050656C75636361204C616E65084D696E6E656F746102
      4D4E053536323634B31B0B000C3636332D3731382D31343933024E6F00000040
      11C41E0000024E6F204172697A6F6E6120446570742E206F66204865616C7468
      2053657276696365730752616E64656C6C044875726410363020456173742034
      326E642053742E0F5368656C646F6E20537072696E6773025654053035343835
      151C0B000C3038302D3832302D34383137024E6F0000004011211F0000035965
      7305525043494F0354696D0743616E646C6572113138204C6976696E6773746F
      6E2044722E0942616C74696D6F7265024D44053231323230751B0B000C343334
      2D3633352D39383335024E6F00000040114B1F0000035965731B416C61736B61
      205065726D616E656E742046756E6420436F72702E064A6F7365706807517565
      7665646F1834313220536F7574682050656E646C65746F6E204176652E07436C
      696E746F6E024F480534343231361E1C0B000C3437322D3431322D3530333002
      4E6F0000004011EA1F0000024E6F154A6170616E2054726164696E6720436F6D
      70616E79034A696D0742617274617368143635323220452E2046726565706F72
      742044722E0D506F7274204D6F6E6D6F757468024E4A0530373734365F1B0B00
      0C3438332D3838302D31393639024E6F000000401186200000035965731C5461
      6D70612042617920496E666F726D6174696F6E2043656E74657206546F70616E
      690644654D6F6F790E313239352053746174652053742E07486F7573746F6E02
      5458053737303237741B0B000C3435372D3638352D39373434024E6F00000040
      1106210000035965730953746172686F75736506446F7269616E064361726E65
      791D343430205765737420456E64204176656E75652C2053756974652033450C
      4561737420436F72696E7468024D45053034343237B91C0B000C3038392D3837
      322D37393835024E6F0000004011A721000003596573115072756E6579617264
      2056696C6C61676504416C616E074265636B68616D27446570742E206F662044
      65636973696F6E202620496E666F726D6174696F6E2053797374656D73054F67
      64656E0255540538343430302A1C0B000C3633392D3636322D31353332024E6F
      0000004011AF210000024E6F0B4461746120446972656374074D656C696E6461
      064C696E646572163830312053696D70736F6E2C205375697465203130300843
      6F6C756D6275730247410533313930347C1B0B000C3432342D3935392D383435
      35024E6F000000401155220000035965731753696D706C696669656420504320
      536F6C7574696F6E73054C61727279045061636B264F6E65204D61726B65742C
      2053706561722053742E20546F7765722C205374652E203135303105536F6475
      73024D49053439313236A41B0B000C3134382D3436332D34363332024E6F0000
      004011CD2200000359657312466F7820436F6D6D756E69636174696F6E730743
      61726C20422E0652696363696F1931205075626C6963205371756172652C2053
      74652E203230350641706F706B6102464C053332373033EB1B0B000C3232382D
      3738322D39333733024E6F00400040110C230000035965731C42206F6620412C
      204D6F7274676167652053616C65732047726F7570054B6F6C74731131313436
      205661737075657A204176652E0A53616E20416361636961024E4D0538373833
      316B1C0B000C3636332D3738372D38323131024E6F0000004011A02300000359
      6573104567676865616420536F66747761726504546F6E79054973616B691331
      35303020452E2044756172746520526F61640C41504F204E657720596F726B02
      4E59053039303735D41C0B000C3237322D3535342D37343938024E6F00000040
      1130240000024E6F16496E7465726E6174696F6E616C20536F66747761726507
      4265726E61726407526573736C65720E323236302032367468204E2E572E0441
      6C766102464C0533333932306B1C0B000C3337302D3337382D38323333024E6F
      0000004011CB240000035965731356697375616C20446174612053797374656D
      7306536C6174657208486174686177617915526F6F6D20353033382C204F7866
      6F72642052642E08576F727468696E67025344053537303737AF1B0B000C3335
      332D3834342D31363934024E6F0000000011F8240000035965730D4461766973
      20526F6F66696E67044A656666074261727461736817313136204D61696E2053
      742E2C205375697465203238320854616D696D656E74025041053134313235C2
      1B0B000C3530322D3536302D3430323224000000446F75626C6520636C69636B
      206865726520746F2065646974206D656D6F206669656C64024E6F0000004011
      1A250000024E6F18477265656E62726F6F6B205069616E6F2053657276696365
      0354696D08466C656D6D696E6711353130204F6365616E204176652E20233106
      536F6E746167024D53053339363635C71C0B000C3639392D3134302D32363939
      024E6F000000401160250000024E6F11524C5720506572736F6E616C20436172
      65054A6F68616E05426C61636B1A313239352053746174652053742E2C204465
      70742E204B313632074D616469736F6E025749053533373037D21B0B000C3131
      352D3436372D39303432024E6F00000040119F250000024E6F165261796E6520
      47617264656E696E672043656E746572055065746572044465616E1532313339
      204E2E2041636164656D7920426C76642E0C4D756E666F726476696C6C65024B
      59053432373635751B0B000C3330362D3930382D31323332024E6F0000004011
      67260000024E6F0743686576726F6E044A6F686E054D6F6F72651E4E6F727468
      676174652045786563204374722049492C20537465203430300E54686F757361
      6E64737469636B73024B590534313736362E1C0B000C3538312D3438352D3438
      3434024E6F}
  end
end
