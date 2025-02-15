object FMain: TFMain
  Left = 229
  Top = 148
  Width = 558
  Height = 324
  Caption = 'Example of printing the self-reference DataSet'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000003
    333300000000033B3BBB3300000003B3BBB77777777703333337FFFFFFF7033B
    3BB7F889FFF703B3BBB7F8FFFFF703333337F88CFFF7033B3BB7F8FFFFF703B3
    BBB7F8F889F703333337F8F8FFF7033BBBB7F882FFF700033337F8FFFFF70000
    0007F8FFFFF700000007FFFFFFF700000007777777F70000000000000000E0FF
    0000803F00008000000080000000800000008000000080000000800000008000
    00008000000080000000E0000000FE000000FE000000FE000000FFFF0000}
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 231
    Width = 550
    Height = 66
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 232
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Levels'
    end
    object RadioGroup: TRadioGroup
      Left = 8
      Top = 3
      Width = 217
      Height = 56
      Caption = 'RootValue'
      ItemIndex = 0
      Items.Strings = (
        'Print all'
        'Print the structure of the current node')
      TabOrder = 0
    end
    object ELevels: TEdit
      Left = 269
      Top = 12
      Width = 70
      Height = 21
      TabOrder = 1
      Text = '0'
      OnExit = ELevelsExit
      OnKeyPress = ELevelsKeyPress
    end
    object Button1: TButton
      Left = 346
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Print'
      TabOrder = 2
      OnClick = Button1Click
    end
    object BitBtn1: TBitBtn
      Left = 467
      Top = 6
      Width = 75
      Height = 25
      TabOrder = 3
      Kind = bkClose
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 550
    Height = 231
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = 'Panel2'
    TabOrder = 1
    object DBTreeView1: TdxDBTreeView
      Left = 4
      Top = 4
      Width = 542
      Height = 223
      ShowNodeHint = True
      DataSource = DataSource1
      KeyField = 'Pr_id'
      ListField = 'Pr_name'
      ParentField = 'Pr_parent'
      SeparatedSt = ' - '
      Indent = 19
      Align = alClient
      Color = clWhite
      ParentColor = False
      Options = [trDBCanDelete, trDBConfirmDelete, trCanDBNavigate, trSmartRecordCopy, trCheckHasChildren]
      SelectedIndex = -1
      TabOrder = 0
      OnAddNewItem = DBTreeView1AddNewItem
      Images = ImageList1
    end
  end
  object Table: TTable
    DatabaseName = 'DBDEMOS'
    FieldDefs = <
      item
        Name = 'Pr_id'
        DataType = ftInteger
        Precision = 0
        Required = True
        Size = 0
      end
      item
        Name = 'Pr_parent'
        DataType = ftInteger
        Precision = 0
        Required = True
        Size = 0
      end
      item
        Name = 'Pr_name'
        DataType = ftString
        Precision = 0
        Required = True
        Size = 50
      end
      item
        Name = 'Pr_bdate'
        DataType = ftDate
        Precision = 0
        Required = False
        Size = 0
      end
      item
        Name = 'Pr_edate'
        DataType = ftDate
        Precision = 0
        Required = False
        Size = 0
      end
      item
        Name = 'Pr_info'
        DataType = ftMemo
        Precision = 0
        Required = False
        Size = 1
      end>
    StoreDefs = True
    TableName = 'project.db'
    Left = 112
    Top = 256
  end
  object DataSource1: TDataSource
    DataSet = Table
    Left = 144
    Top = 256
  end
  object ImageList1: TImageList
    Left = 136
    Top = 72
    Bitmap = {
      360C000003000000424D360C0000000000003600000028000000300000001000
      00000100200000000000000C000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000808080008080800000000000FFFFFF00FFFFFF0080000000800000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000808080008000
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000800080008000800080008000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000C0C0C000C0C0C0008080800000000000FF000000FF000000FF000000FF00
      0000FF000000FF00000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000080808000C0C0C000FFFFFF00C0C0
      C0008000800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000800080000000000000000000800080008000
      8000800080008000800080008000800080008000800080008000000000000000
      0000C0C0C000C0C0C000C0C0C0008080800080000000FF000000FF000000FF00
      0000FF000000FF000000FF00000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000080808000C0C0C000FFFFFF00FFFFFF0080808000C0C0
      C000C0C0C0008000800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080008000FFFFFF0000000000000000000000
      000080808000C0C0C000C0C0C000FFFFFF00FFFFFF008000800000000000FFFF
      FF0000000000C0C0C000C0C0C000C0C0C0008080800080000000FF000000FF00
      0000FF000000FF000000FF000000FF00000080000000FFFFFF00FFFFFF000000
      000080808000C0C0C000FFFFFF00FFFFFF008080800080808000000000008080
      8000C0C0C000C0C0C0008000800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000008000800080008000FFFFFF0000000000C0C0C000FFFF
      FF0080808000000000000000000000000000FFFFFF008000800000000000FFFF
      FF00FFFFFF0080000000C0C0C000C0C0C000C0C0C0008080800080000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000FFFFFF008000
      800080808000FFFFFF0080808000808080000000000000000000800080000000
      000080808000C0C0C000C0C0C0008000800000000000FFFFFF00FFFFFF00FFFF
      FF00000000008000800080008000FFFFFF00FFFFFF0000000000C0C0C000FFFF
      FF00FFFFFF00FFFFFF0000FFFF0080808000FFFFFF008000800000000000FFFF
      FF00800000008000000080000000C0C0C000C0C0C000C0C0C000808080008000
      0000800000008000000080000000800000008000000080000000FFFFFF008000
      8000808080008080800000000000000000008000800080008000800080008000
      80000000000080808000C0C0C000C0C0C0008000800000000000FFFFFF00FFFF
      FF000000000080008000FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFF
      FF0000FFFF00FFFFFF00FFFFFF0080808000FFFFFF008000800000000000FFFF
      FF0080000000800000008000000080000000C0C0C000C0C0C000808080008080
      8000000000008000000080000000800000008000000080000000FFFFFF008000
      8000000000000000000080008000800080008000800080008000800080008000
      8000800080000000000080808000C0C0C000C0C0C0008000800000000000FFFF
      FF000000000080008000FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFF
      FF00FFFFFF00FFFFFF0000FFFF0080808000FFFFFF008000800000000000FFFF
      FF008000000080000000800000008000000080000000C0C0C000808080008080
      8000C0C0C0000000000080808000808080008080800080000000FFFFFF008000
      8000808080008000800080008000800080008000800000FFFF00008080008000
      800080008000800080000000000080808000C0C0C0000000000000000000FFFF
      FF000000000080008000FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFF
      FF0000FFFF00FFFFFF00FFFFFF0080808000FFFFFF008000800000000000FFFF
      FF0080000000800000008000000080000000800000008080800080808000C0C0
      C000808080008080800000FFFF000000FF008080800080000000FFFFFF00FFFF
      FF00800080008080800080008000800080008000800080008000C0C0C00000FF
      FF0000FFFF008000800080008000000000008080800000000000FFFFFF00FFFF
      FF000000000080008000FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFF
      FF00FFFFFF00FFFFFF0000FFFF0080808000FFFFFF008000800000000000FFFF
      FF0000000000800000008000000080000000800000008080800080808000C0C0
      C000C0C0C000C0C0C00000FFFF000000FF000000FF0080000000FFFFFF00FFFF
      FF00FFFFFF008000800080808000800080008000800000808000008080008000
      800000FFFF0000FFFF0080008000800080000000000000000000FFFFFF00FFFF
      FF000000000080008000FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000FFFF
      FF0000FFFF00FFFFFF00FFFFFF0080808000FFFFFF008000800000000000FFFF
      FF00FFFFFF008000000080000000800000008000000080808000C0C0C0008080
      800000FFFF0000FFFF0000FFFF000000FF000000FF0080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008000800080808000800080008000800000FFFF0000FF
      FF0000FFFF000080800080008000800080008000800000000000FFFFFF00FFFF
      FF000000000080008000FFFFFF00FFFFFF00C0C0C0008080800080808000FFFF
      FF00FFFFFF00FFFFFF0000FFFF00808080000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000080000000800000008000000080808000808080000000
      FF0000FFFF000000FF000000FF000000FF000000FF008080800000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800080008080800080008000800080008000
      8000800080008000800080008000800080000000000000000000FFFFFF00FFFF
      FF000000000080008000FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000800000008000000080000000808080008080
      80000000FF000000FF000000FF000000FF000000FF008080800000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000800080808000800080008000
      800080008000800080000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080008000FFFFFF00C0C0C00080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000000080000000800000008000
      0000C0C0C00080808000808080000000FF000000FF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080008000808080008000
      80000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000C0C0C00080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C0000000FF000000FF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00808080008080800000000000FFFFFF00FFFFFF00424D
      BE000000000000003E0000002800000030000000100000000100010000000000
      800000000000000000000000020000000200000000000000FFFFFF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000}
  end
  object DBTreePrintDataSet: TdxDBTreePrintData
    SortOptions = []
    DataSource = DataSource1
    KeyField = 'Pr_id'
    LevelCount = 0
    ParentField = 'Pr_parent'
    Left = 80
    Top = 255
  end
end
