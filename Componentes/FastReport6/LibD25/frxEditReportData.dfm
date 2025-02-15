object frxReportDataForm: TfrxReportDataForm
  Left = 185
  Top = 107
  BorderIcons = []
  Caption = 'Select Report Datasets'
  ClientWidth = 288
  ClientHeight = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    277
    265)
  PixelsPerInch = 96
  TextHeight = 13
  object SelAllCB: TCheckBox
    Left = 4
    Top = 242
    Width = 114
    Height = 17
    AllowGrayed = True
    Anchors = [akLeft, akBottom]
    Caption = 'SelAllCB'
    TabOrder = 3
    OnClick = SelAllCBClick
  end
  object OKB: TButton
    Left = 124
    Top = 240
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object CancelB: TButton
    Left = 204
    Top = 240
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object DatasetsLB: TCheckListBox
    Left = 4
    Top = 8
    Width = 277
    Height = 225
    OnClickCheck = DatasetsLBClickCheck
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 16
    Style = lbOwnerDrawFixed
    TabOrder = 2
  end
end
