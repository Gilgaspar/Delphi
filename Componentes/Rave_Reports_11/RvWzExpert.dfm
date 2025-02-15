object FormReportExpert: TFormReportExpert
  Left = 263
  Top = 119
  Width = 525
  Height = 454
  BorderStyle = bsSizeToolWin
  Caption = 'Rave Report Expert'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    517
    427)
  PixelsPerInch = 96
  TextHeight = 13
  object butnDoneContinue: TButton
    Left = 431
    Top = 388
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Done'
    ModalResult = 1
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 517
    Height = 375
    ActivePage = TabSheetReport
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsFlatButtons
    TabOrder = 1
    object TabSheetSettings: TTabSheet
      Caption = 'Settings'
      ImageIndex = 1
      object Label3: TLabel
        Left = 8
        Top = 64
        Width = 30
        Height = 13
        Caption = 'Ignore'
      end
      object Label4: TLabel
        Left = 56
        Top = 64
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object Label6: TLabel
        Left = 6
        Top = 46
        Width = 367
        Height = 13
        Caption = 
          'The settings below are used to enable/disable specific tests acr' +
          'oss all reports.'
      end
      object Bevel1: TBevel
        Left = 6
        Top = 37
        Width = 497
        Height = 3
      end
      object Bevel2: TBevel
        Left = 7
        Top = 4
        Width = 497
        Height = 3
      end
      object GlobalList: TCheckListBox
        Left = 0
        Top = 82
        Width = 509
        Height = 262
        OnClickCheck = GlobalListClickCheck
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
      object ckboxExpertEnabled: TCheckBox
        Left = 9
        Top = 14
        Width = 417
        Height = 17
        Caption = 'Report Expert Enabled'
        TabOrder = 1
        OnClick = ckboxExpertEnabledClick
      end
    end
    object TabSheetReport: TTabSheet
      Caption = 'Report'
      object Label5: TLabel
        Left = 5
        Top = 0
        Width = 485
        Height = 26
        Caption = 
          'This page is used to enable/disable specific tests for the curre' +
          'ntly active report.  Double-clicking on an item will highlight t' +
          'hat component in the designer allowing you to correct the error ' +
          'or warning.'
        WordWrap = True
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 32
        Width = 509
        Height = 312
        ActivePage = TabSheet3
        Align = alBottom
        MultiLine = True
        TabOrder = 0
        object TabSheet3: TTabSheet
          Caption = 'Errors, Warnings and Hints'
          object Splitter1: TSplitter
            Left = 0
            Top = 143
            Width = 501
            Height = 3
            Cursor = crVSplit
            Align = alBottom
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 501
            Height = 143
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              501
              143)
            object Label9: TLabel
              Left = 8
              Top = 5
              Width = 489
              Height = 20
              Alignment = taCenter
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Caption = 'Report Items'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 56
              Top = 7
              Width = 53
              Height = 13
              Caption = 'Description'
            end
            object Label1: TLabel
              Left = 8
              Top = 7
              Width = 30
              Height = 13
              Caption = 'Ignore'
            end
            object ReportItems: TCheckListBox
              Left = 0
              Top = 33
              Width = 501
              Height = 110
              OnClickCheck = ReportItemsClickCheck
              Align = alBottom
              Anchors = [akTop, akBottom]
              ItemHeight = 13
              TabOrder = 0
              OnDblClick = ReportItemsDblClick
            end
          end
          object Panel2: TPanel
            Left = 0
            Top = 146
            Width = 501
            Height = 138
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            DesignSize = (
              501
              138)
            object Label10: TLabel
              Left = 8
              Top = 5
              Width = 489
              Height = 21
              Alignment = taCenter
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Caption = 'Ignored Items'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label7: TLabel
              Left = 8
              Top = 8
              Width = 30
              Height = 13
              Caption = 'Ignore'
            end
            object Label8: TLabel
              Left = 55
              Top = 8
              Width = 53
              Height = 13
              Caption = 'Description'
            end
            object IgnoredItems: TCheckListBox
              Left = 0
              Top = 29
              Width = 501
              Height = 109
              OnClickCheck = ReportItemsClickCheck
              Align = alBottom
              Anchors = [akTop, akBottom]
              ItemHeight = 13
              TabOrder = 0
              OnDblClick = ReportItemsDblClick
            end
          end
        end
      end
    end
  end
  object butnAbort: TButton
    Left = 350
    Top = 388
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Abort'
    ModalResult = 2
    TabOrder = 2
  end
end
