object ExeForm: TExeForm
  Left = 252
  Top = 110
  BorderStyle = bsDialog
  Caption = 'Load Into Exe'
  ClientHeight = 154
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PrintScale = poNone
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 154
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 55
      Top = 69
      Width = 161
      Height = 13
      Caption = 'File To Be Compiled Into The EXE'
    end
    object Bevel1: TBevel
      Left = 280
      Top = 8
      Width = 3
      Height = 139
    end
    object SpeedButton1: TSpeedButton
      Left = 240
      Top = 85
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
      OnClick = SpeedButton1Click
    end
    object ClearBtn: TBitBtn
      Left = 299
      Top = 112
      Width = 75
      Height = 25
      Hint = 'Clear the StoreRAV property'
      Caption = 'Clea&r'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = ClearBtnClick
    end
    object SaveBtn: TBitBtn
      Left = 299
      Top = 78
      Width = 75
      Height = 25
      Hint = 'Save StoreRAV to disk'
      Caption = '&Save'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = SaveBtnClick
    end
    object LoadBtn: TBitBtn
      Left = 299
      Top = 43
      Width = 75
      Height = 25
      Hint = 'Load from Disk into StoreRAV'
      Caption = '&Load'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = LoadBtnClick
    end
    object CloseBtn: TBitBtn
      Left = 299
      Top = 9
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Close'
      Default = True
      ModalResult = 2
      TabOrder = 3
    end
    object FileNameEdit: TEdit
      Left = 28
      Top = 85
      Width = 209
      Height = 21
      TabOrder = 4
      Text = 'FileNameEdit'
    end
    object Panel2: TPanel
      Left = 8
      Top = 8
      Width = 265
      Height = 33
      BorderWidth = 8
      TabOrder = 5
      object DateTimeLabel: TLabel
        Left = 90
        Top = 9
        Width = 166
        Height = 15
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'DateTimeLabel'
      end
      object Label2: TLabel
        Left = 9
        Top = 9
        Width = 81
        Height = 15
        Align = alLeft
        Caption = 'Last Updated:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'rav'
    Filter = 'Project File (*.rav)|*.rav'
    Left = 248
    Top = 120
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Project File (*.rav)|*.rav'
    Left = 216
    Top = 120
  end
end
