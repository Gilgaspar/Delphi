object frmCameraDialog: TfrmCameraDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Camera Dialog'
  ClientHeight = 262
  ClientWidth = 330
  Color = clBtnFace
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  object ccCamera: TdxCameraControl
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 310
    Height = 201
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Active = True
    Align = alClient
  end
  object pnlBottom: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 221
    Width = 310
    Height = 31
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alBottom
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 1
    object btnAssign: TButton
      AlignWithMargins = True
      Left = 154
      Top = 3
      Width = 75
      Height = 25
      Align = alRight
      Caption = 'Assign'
      Enabled = False
      ModalResult = 1
      TabOrder = 1
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 235
      Top = 3
      Width = 75
      Height = 25
      Margins.Right = 0
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object btnSnapshot: TButton
      AlignWithMargins = True
      Left = 73
      Top = 3
      Width = 75
      Height = 25
      Align = alRight
      Caption = 'Snapshot'
      Default = True
      TabOrder = 0
      OnClick = btnSnapshotClick
    end
  end
end
