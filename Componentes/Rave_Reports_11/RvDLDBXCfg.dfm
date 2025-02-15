object DlDBXConfigureForm: TDlDBXConfigureForm
  Left = 434
  Top = 416
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Database Connection Parameters'
  ClientHeight = 354
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 313
    Width = 442
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      442
      41)
    object butnOk: TButton
      Left = 278
      Top = 8
      Width = 75
      Height = 25
      Action = actnOk
      Anchors = [akTop, akRight]
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object butnCancel: TButton
      Left = 358
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 442
    Height = 313
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Connection'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 285
        Align = alLeft
        BorderWidth = 6
        TabOrder = 0
        object lboxConnection: TListBox
          Left = 7
          Top = 57
          Width = 171
          Height = 221
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = lboxConnectionClick
        end
        object Panel4: TPanel
          Left = 7
          Top = 7
          Width = 171
          Height = 50
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label1: TLabel
            Left = 0
            Top = 8
            Width = 88
            Height = 13
            Caption = 'Connection Name:'
            Transparent = False
          end
          object editConnection: TEdit
            Left = 0
            Top = 25
            Width = 169
            Height = 21
            TabOrder = 0
            OnChange = editConnectionChange
            OnKeyPress = editConnectionKeyPress
          end
        end
      end
      object Panel3: TPanel
        Left = 185
        Top = 0
        Width = 249
        Height = 285
        Align = alClient
        TabOrder = 1
        object sgridConnectionSettings: TStringGrid
          Left = 1
          Top = 32
          Width = 247
          Height = 252
          Align = alClient
          ColCount = 2
          DefaultColWidth = 120
          DefaultRowHeight = 21
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
          TabOrder = 0
          OnClick = sgridConnectionSettingsClick
        end
        object Panel5: TPanel
          Left = 1
          Top = 1
          Width = 247
          Height = 31
          Align = alTop
          TabOrder = 1
          object Label2: TLabel
            Left = 6
            Top = 13
            Width = 98
            Height = 13
            Caption = 'Connection Settings:'
            Transparent = False
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Authentication'
      ImageIndex = 1
      object Label3: TLabel
        Left = 15
        Top = 25
        Width = 51
        Height = 13
        Caption = '&Username:'
        FocusControl = editUsername
        Transparent = False
      end
      object Label4: TLabel
        Left = 17
        Top = 49
        Width = 49
        Height = 13
        Caption = '&Password:'
        FocusControl = editPassword
        Transparent = False
      end
      object editPassword: TEdit
        Left = 72
        Top = 44
        Width = 185
        Height = 21
        PasswordChar = '*'
        TabOrder = 0
      end
      object editUsername: TEdit
        Left = 72
        Top = 20
        Width = 185
        Height = 21
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Test Connection'
      ImageIndex = 2
      object Label6: TLabel
        Left = 8
        Top = 40
        Width = 46
        Height = 13
        Caption = 'Table List'
      end
      object Button1: TButton
        Left = 128
        Top = 8
        Width = 137
        Height = 25
        Caption = 'Test Connection'
        TabOrder = 0
        OnClick = Button1Click
      end
      object lboxTables: TListBox
        Left = 8
        Top = 56
        Width = 417
        Height = 209
        ItemHeight = 13
        TabOrder = 1
      end
    end
  end
  object ActionList1: TActionList
    Left = 8
    Top = 320
    object actnOk: TAction
      Caption = '&Ok'
      OnUpdate = actnOkUpdate
    end
  end
end
