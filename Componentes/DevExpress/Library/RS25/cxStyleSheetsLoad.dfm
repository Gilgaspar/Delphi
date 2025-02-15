object frmcxStyleSheetsLoad: TfrmcxStyleSheetsLoad
  Left = 303
  Top = 129
  BorderIcons = [biSystemMenu]
  Caption = 'Predefined StyleSheets'
  ClientHeight = 329
  ClientWidth = 659
  Color = clBtnFace
  Constraints.MinHeight = 296
  Constraints.MinWidth = 315
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 286
    Width = 643
    Height = 35
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Bevel: TBevel
      Left = 0
      Top = 0
      Width = 643
      Height = 2
      Align = alTop
      Shape = bsTopLine
    end
    object btnLoad: TButton
      AlignWithMargins = True
      Left = 487
      Top = 7
      Width = 75
      Height = 25
      Margins.Top = 5
      Align = alRight
      Caption = 'Load'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnClose: TButton
      AlignWithMargins = True
      Left = 568
      Top = 7
      Width = 75
      Height = 25
      Margins.Top = 5
      Margins.Right = 0
      Align = alRight
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 643
    Height = 270
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object pnlStyles: TPanel
      Left = 5
      Top = 5
      Width = 297
      Height = 260
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object pnlStyleSheetClasses: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 297
        Height = 27
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 6
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbStyleSheetClass: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 94
          Height = 21
          Align = alLeft
          AutoSize = False
          Caption = 'Style Sheet Class:'
          Layout = tlCenter
        end
        object cbStyleSheetClasses: TComboBox
          AlignWithMargins = True
          Left = 103
          Top = 3
          Width = 191
          Height = 21
          Align = alClient
          Style = csDropDownList
          DropDownCount = 10
          TabOrder = 0
        end
      end
      object lbStyleSheets: TListBox
        Left = 0
        Top = 33
        Width = 297
        Height = 227
        Align = alClient
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 1
      end
    end
    object pnlPreview: TPanel
      Left = 302
      Top = 5
      Width = 336
      Height = 260
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 5
        Height = 260
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 5
        Top = 0
        Width = 331
        Height = 260
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 331
          Height = 27
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          TabOrder = 0
          object lbPreview: TLabel
            Left = 0
            Top = 0
            Width = 331
            Height = 27
            Align = alClient
            AutoSize = False
            Caption = 'Preview'
            Layout = tlCenter
          end
        end
        object pnlPreviewClient: TPanel
          Left = 0
          Top = 33
          Width = 331
          Height = 227
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
    end
  end
end
