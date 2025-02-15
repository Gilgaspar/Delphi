unit vcl.wwgridfilter;
{
//
// Components : TwwFormGridFilterTypes
//
// Copyright (c) 2009 by Woll2Woll Software
//
// Description: Define GridTitleMenu menu items
//
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, db, wwcommon, wwstr, ImgList, wwmenuitem, comctrls,
  CommCtrl, themes, wwtreeview, wwintl;
type

  TwwFormGridFilterTypes = class(TForm)
    ImageList1: TImageList;
    PopupFilterMenu: TPopupMenu;
    SortSmallesttoLargest1: TwwMenuItem;
    SortLargesttoSmallest1: TwwMenuItem;
    N1: TwwMenuItem;
    ClearFilter1: TwwMenuItem;
    NumberFilters1: TwwMenuItem;
    Equals1: TwwMenuItem;
    Doesnotequal1: TwwMenuItem;
    LessThan1: TwwMenuItem;
    GreaterThan1: TwwMenuItem;
    Between1: TwwMenuItem;
    TextFilters1: TwwMenuItem;
    Equals2: TwwMenuItem;
    Doesnotequal2: TwwMenuItem;
    Startswith1: TwwMenuItem;
    Doesnotstartwith1: TwwMenuItem;
    Contains1: TwwMenuItem;
    Doesnotcontain1: TwwMenuItem;
    Endswith1: TwwMenuItem;
    Doesnotendwith1: TwwMenuItem;
    N2: TwwMenuItem;
    GroupBy1: TwwMenuItem;
    DateFilters1: TMenuItem;
    Equals3: TMenuItem;
    N3: TMenuItem;
    Before1: TMenuItem;
    After1: TMenuItem;
    Between2: TMenuItem;
    N4: TMenuItem;
    Tomorrow1: TMenuItem;
    Today1: TMenuItem;
    Yesterday1: TMenuItem;
    N5: TMenuItem;
    NextWeek1: TMenuItem;
    ThisWeek1: TMenuItem;
    LastWeek1: TMenuItem;
    N6: TMenuItem;
    NextMonth1: TMenuItem;
    ThisMonth1: TMenuItem;
    LastMonth1: TMenuItem;
    N7: TMenuItem;
    NextQuarter1: TMenuItem;
    ThisQuarter1: TMenuItem;
    LastQuarter1: TMenuItem;
    N8: TMenuItem;
    NextYear1: TMenuItem;
    ThisYear1: TMenuItem;
    LastYear1: TMenuItem;
    AddRemoveColumns1: TMenuItem;
    N9: TMenuItem;
    RemoveColumn1: TMenuItem;
    AddColumnsAfter1: TMenuItem;
    AddColumnsBefore1: TMenuItem;
    ClearGroupBy1: TMenuItem;
    IsNull1: TMenuItem;
    IsNotNull1: TMenuItem;
    IsNull2: TMenuItem;
    IsNotNull2: TMenuItem;
    IsNull3: TMenuItem;
    IsNotNull3: TMenuItem;
    NullSeparatorDate: TMenuItem;
    NullSeparatorText: TMenuItem;
    NullSeparatorNumber: TMenuItem;
    procedure SortSmallesttoLargest1Click(Sender: TObject);
    procedure SortLargesttoSmallest1Click(Sender: TObject);
    procedure PopupFilterMenuPopup(Sender: TObject);
    procedure FilterMenuItemClick(Sender: TObject);
    procedure ClearFilter1Click(Sender: TObject);
    procedure GroupBy1Click(Sender: TObject);
    procedure AddColumnsBefore1Click(Sender: TObject);
    procedure RemoveColumn1Click(Sender: TObject);
    procedure AddColumnsAfter1Click(Sender: TObject);
    procedure AddRemoveColumns1Click(Sender: TObject);
    procedure ClearGroupBy1Click(Sender: TObject);
  private
    { Private declarations }
    function HaveAscendingIndexDefs: boolean;
    function HaveDescendingIndexDefs: boolean;
    function GetDataSet: TDataSet;
    procedure RemoveItem(fieldName: string);
    function GetFieldName: string;
    function GetField: TField;
    procedure ApplyIntl;
  public
    Grid: TCustomGrid;
    Column: TObject; // TwwColumn;
    FilterDialog: TComponent; // TwwFilterDialog;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindItem(fieldName: string): TObject;
    function IsClientCursor: boolean;
    procedure SortAscending(fieldName: string = '');
    procedure SortDescending(fieldName: string = '');
  end;

  TwwfcItemState = (wwfcisSelected, wwfcisGrayed, wwfcisDisabled, wwfcisChecked,
    wwfcisFocused, wwfcisDefault, wwfcisHot, wwfcisMarked, wwfcisIndeterminate);
  TwwfcItemStates = set of TwwfcItemState;
  TwwTreeViewCheckboxType = (wwtvctNone, wwtvctCheckbox, wwtvctRadioGroup);
{  TwwfcHitTest = (wwfchtAbove, wwfchtBelow, wwfchtNowhere, wwfchtOnItem, wwfchtOnButton, wwfchtOnIcon,
    wwfchtOnIndent, wwfchtOnLabel, wwfchtOnRight, wwfchtOnStateIcon, wwfchtToLeft, wwfchtToRight);
  TwwfcHitTests = set of TwwfcHitTest;
}
{
  TwwSelectColumnsTreeNode = class(TwwTreeNode)
  private
      FFieldName: string;
      FIsCategory: boolean;
    public
      property FieldName: string read FFieldName write FFieldName;
      property IsCategory: boolean read FIsCategory write FIsCategory;
  end;

  TwwSelectColumnsTreeView = class(TwwTreeView)
  protected
     function CreateNode: TwwTreeNode; override;
  end;
}
{
  TwwTreeNode = class(TTreeNode)
    private
      FFieldName: string;
      FIsCategory: boolean;
      FMultiSelected: boolean;
      FCheckboxType: TwwTreeViewCheckboxType;
      FGrayed: boolean;
      FOwner: TTreeNodes;

      function GetMultiSelected: Boolean;
      procedure SetMultiSelected(Value: Boolean);
      procedure SetCheckboxType(val: TwwTreeViewCheckboxType);
      function GetState: integer;
      function GetChecked: boolean;
      procedure SetChecked(val: boolean);
      function GetIsCategory: boolean;
      procedure SetIsCategory(value: boolean);
      function GetStateIndex: integer;
      function GetParent: TwwTreeNode;
    public
      constructor Create(AOwner: TTreeNodes); virtual;

      property Checked : boolean read GetChecked write SetChecked;
      property FieldName: string read FFieldName write FFieldName;
      property IsCategory: boolean read GetIsCategory write SetIsCategory;
      property MultiSelected: Boolean read GetMultiSelected write SetMultiSelected;
      property Parent: TwwTreeNode read GetParent;
      property CheckboxType:TwwTreeViewCheckboxType read FCheckboxType write SetCheckboxType;
      property Grayed: boolean read FGrayed write FGrayed;
  end;

  TwwTreeView = class(TTreeView)
    private
       FIndent: integer;
       FCanvas: TControlCanvas;
       FLineColor: TColor;
       FExpandButtons3d: boolean;
       FFlatCheckboxes: boolean;
       DisplayedItems: integer;
       ClickedNode: TwwTreeNode;
       FStateChanging: Boolean;

       procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    protected
       procedure CreateParams(var Params: TCreateParams); override;
       function CreateNode: TTreeNode; override;
       function GetNodeFromItem(const Item: TTVItem): TwwTreeNode;
       Function CheckboxNeeded(Node: TwwTreeNode): boolean;

       procedure BeginPainting; virtual;
       procedure EndPainting; virtual;
       procedure EndItemPainting(Node: TwwTreeNode; ARect: TRect; AItemState: TwwfcItemStates);
       procedure LoadCanvasDefaults(Node: TwwTreeNode; AItemState: TwwfcItemStates);

       function UseImages(Node: TwwTreeNode): Boolean;
       function UseStateImages(Node: TwwTreeNode): Boolean;
       function ItemRect(Node: TwwTreeNode; LabelOnly: Boolean): TRect;
       Function GetCenterPoint(ARect: TRect): TPoint;
       procedure PaintButton(Node: TwwTreeNode; pt: TPoint; size: integer); virtual;
//       function GetPaintCanvas: TCanvas;
       procedure PaintLines(Node: TwwTreeNode);
       procedure PaintImage(Node: TwwTreeNode; State: TwwfcItemStates);
       Function MultiSelectCheckboxNeeded(Node: TwwTreeNode): boolean;
       procedure CreateWnd; override;
       procedure DestroyWnd; override;
    public
       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
      procedure DottedLine(p1, p2: TPoint);
      function LevelRect(ANode: TwwTreeNode): TRect;
      property Canvas: TControlCanvas read FCanvas; //GetPaintCanvas;
      property LineColor: TColor read FLineColor write FLineColor;
      property ExpandButtons3d: boolean read FExpandButtons3d write FExpandButtons3d;
      property FlatCheckboxes: boolean read FFlatCheckboxes write FFlatCheckboxes;

//       procedure BeginItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates); virtual;
//       procedure EndItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates); virtual;
//       procedure PaintItem(Node: TfcTreeNode); virtual;

  end;
 }
var
  wwFormGridFilterTypes: TwwFormGridFilterTypes;

implementation

{$R *.dfm}

uses wwinputstring, wwinputstring2, buttons, wwfltdlg, wwdbigrd, wwgridselectcolumns,
  uxtheme;

const MaxCheckboxSize = 6;
      FixBugImageListSize = 16;
//var FFixBugImageList: TImageList;
//    RefCount: integer;

function fcRectWidth(Rect: TRect): Integer;
begin
  result := Rect.Right - Rect.Left;
end;

function fcRectHeight(Rect: TRect): Integer;
begin
  result := Rect.Bottom - Rect.Top;
end;

{procedure TwwTreeView.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or TVS_CHECKBOXES;
end;
}
procedure TwwFormGridFilterTypes.AddColumnsAfter1Click(Sender: TObject);
var doDefault: boolean;
begin
  doDefault:=true;
  if Assigned(TwwCustomDBGrid(Grid).OnBeforeMenuColumnAdd) then
  begin
      TwwCustomDBGrid(Grid).OnBeforeMenuColumnAdd(Grid, GetFieldName, false, doDefault);
  end;
  TwwCustomDBGrid(Grid).ExecuteSelectGridColumnsDialog(GetFieldName, false);

end;

procedure TwwFormGridFilterTypes.AddColumnsBefore1Click(Sender: TObject);
var doDefault: boolean;
begin
  doDefault:=true;
  if Assigned(TwwCustomDBGrid(Grid).OnBeforeMenuColumnAdd) then
  begin
      TwwCustomDBGrid(Grid).OnBeforeMenuColumnAdd(Grid, GetFieldName, true, doDefault);
  end;
  TwwCustomDBGrid(Grid).ExecuteSelectGridColumnsDialog(GetFieldName, true);

end;

procedure TwwFormGridFilterTypes.AddRemoveColumns1Click(Sender: TObject);
var canAdd: boolean;
    i: integer;
    column: TwwColumn;
    dataset: TDataSet;
    nodeGroups: string;
    oneAdded: boolean;  // 9/14/10
begin
   //Determine if Add should be enabled
  dataset:= GetDataSet;
  oneAdded:= false;
  for i:= 0 to dataSet.FieldCount-1 do
  begin
       column:= (Grid as TwwCustomDBGrid).ColumnByName(dataset.Fields[i].FieldName);
       if not Column.Visible then
       begin
          (Grid as TwwCustomDBGrid).DoOnAddSelectColumn(dataset.Fields[i],
             nodeGroups, canAdd);
          if canAdd then begin
             oneAdded:=true;
             AddColumnsAfter1.Enabled:= true;
             AddColumnsBefore1.Enabled:= true;
          end;
       end;
  end;
  if not oneAdded then
  begin
     AddColumnsAfter1.Enabled:= false;
     AddColumnsBefore1.Enabled:= false;
  end;

end;

procedure TwwFormGridFilterTypes.ClearFilter1Click(Sender: TObject);
begin
  RemoveItem(GetFieldName); (FilterDialog as TwwFilterDialog)
  .ApplyFilter;
end;

procedure TwwFormGridFilterTypes.ClearGroupBy1Click(Sender: TObject);
var cgrid: TwwCustomDBGrid;
    doDefault: boolean;
begin
  doDefault:=true;
  if Assigned(TwwCustomDBGrid(Grid).OnBeforeMenuClearGroup) then
  begin
     TwwCustomDBGrid(Grid).OnBeforeMenuClearGroup(Grid, GetFieldName, doDefault);
  end;
  if not doDefault then exit;

  cgrid:= TwwCustomDBGrid(grid);
  cgrid.GroupFieldName := '';
  //cgrid.ColumnByName(GetFieldName).index := 0;
  //cgrid.ApplySelected;
  //SortAscending(cgrid.GroupFieldName);
  //cgrid.invalidate;

end;

constructor TwwFormGridFilterTypes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FilterDialog := TwwFilterDialog.Create(AOwner);
  TwwFilterDialog(FilterDialog).FieldsFetchMethod := fmUseTFields;
//  TwwFilterDialog(FilterDialog).FilterPropertyOptions.DatasetFilterType:= fdUseFilterProp;

end;

destructor TwwFormGridFilterTypes.Destroy;
begin
  FilterDialog.Free;
  inherited Destroy;
end;

function TwwFormGridFilterTypes.GetFieldName: string;
begin
  result := TwwColumn(Column).fieldName;
end;

procedure TwwFormGridFilterTypes.GroupBy1Click(Sender: TObject);
var cgrid: TwwCustomDBGrid;
    doDefault: boolean;
begin
  doDefault:=true;
  if Assigned(TwwCustomDBGrid(Grid).OnBeforeMenuGroup) then
  begin
     TwwCustomDBGrid(Grid).OnBeforeMenuGroup(Grid, GetFieldName, doDefault);
  end;
  if not doDefault then exit;

  cgrid:= TwwCustomDBGrid(grid);
  cgrid.GroupFieldName := GetFieldName;
  cgrid.ColumnByName(GetFieldName).index := 0;
  cgrid.ApplySelected;
  SortAscending(cgrid.GroupFieldName);
  cgrid.invalidate;

end;

function TwwFormGridFilterTypes.GetField: TField;
var
  dataset: TDataSet;
begin
  result := nil;
  dataset := GetDataSet;
  if dataset = nil then
    exit;

  result := dataset.FindField(GetFieldName)
end;

procedure TwwFormGridFilterTypes.RemoveColumn1Click(Sender: TObject);
var doDefault: boolean;
begin
  doDefault:=true;
  if Assigned(TwwCustomDBGrid(Grid).OnBeforeMenuColumnRemove) then
  begin
      TwwCustomDBGrid(Grid).OnBeforeMenuColumnRemove(Grid, GetFieldName, doDefault);
  end;

  if doDefault then
     TwwCustomDBGrid(Grid).ColumnByName(GetFieldName).Visible:=false;
end;

procedure TwwFormGridFilterTypes.RemoveItem(fieldName: string);
var
  i: integer;
  fDialog: TwwFilterDialog;
begin
  fDialog := FilterDialog as TwwFilterDialog;
  for i := 0 to fDialog.FieldInfo.Count - 1 do
  begin
    if wwEqualStr(TwwFieldInfo(fDialog.FieldInfo.Items[i]).fieldName,
      fieldName) then
    begin
      fDialog.FieldInfo.Delete(i);
      break;
    end;
  end;
end;

function TwwFormGridFilterTypes.FindItem(fieldName: string): TObject;
var
  i: integer;
  fDialog: TwwFilterDialog;
begin
  fDialog := FilterDialog as TwwFilterDialog;
  for i := 0 to fDialog.FieldInfo.Count - 1 do
  begin
    if wwEqualStr(TwwFieldInfo(fDialog.FieldInfo.Items[i]).fieldName,
      fieldName) then
    begin
      result := TwwFieldInfo(fDialog.FieldInfo.Items[i]);
      exit;
    end;
  end;
  result := nil;
end;

procedure TwwFormGridFilterTypes.FilterMenuItemClick(Sender: TObject);
var
  menuCaption: string;
  filterValue, filterValue2: string;
  fDialog: TwwFilterDialog;
  item: TwwFieldInfo;
  year, month, day: word;
  tempDate: TDateTime;
  quarterMonth, quarterYear: word;
  canUseDefault: boolean;
  doDefaultDialog: boolean;
  applyFilter: boolean;
  filterCaption: string;
  nonMatching: boolean;

  function DoEqual: TwwFieldInfo;
  var
    item: TwwFieldInfo;
  begin
    item := TwwFieldInfo.Create;
    item.fieldName := GetFieldName;
    item.DisplayLabel := item.fieldName;
    item.MatchType := fdMatchExact;
    item.filterValue := filterValue;
    item.MinValue := '';
    item.MaxValue := '';
    item.CaseSensitive := false;
    item.nonMatching := nonMatching;
    result := item;
  end;
  function DoLessThan: TwwFieldInfo;
  var
    item: TwwFieldInfo;
  begin
    item := TwwFieldInfo.Create;
    item.fieldName := GetFieldName;
    item.DisplayLabel := item.fieldName;
    item.MatchType := fdMatchRange;
    item.filterValue := '';
    item.MinValue := '';
    item.MaxValue := filterValue;
    item.CaseSensitive := false;
    item.nonMatching := false;
    result := item;
  end;

  function DoStartsWith: TwwFieldInfo;
  var
    item: TwwFieldInfo;
  begin
    item := TwwFieldInfo.Create;
    item.fieldName := GetFieldName;
    item.DisplayLabel := item.fieldName;
    item.MatchType := fdMatchStart;
    item.filterValue := filterValue;
    item.MinValue := '';
    item.MaxValue := '';
    item.CaseSensitive := false;
    item.nonMatching := false;
    result := item;
  end;

function DaysThisMonth(Month,Year:integer): Integer;
const
  DaysPerMonth: array[1..12] of Integer =
    (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);	    { usual numbers of days }
begin
  Result := DaysPerMonth[Month];                        { normally, just return number }
  if (Month = 2) and IsLeapYear(Year) then Inc(Result); { plus 1 in leap February }
end;

begin
  menuCaption := TMenuItem(Sender).caption;
  menuCaption := StrRemoveChar(menuCaption, '&');
  menuCaption := Lowercase(menuCaption);
  filterValue := '';
  filterValue2:= '';
  nonMatching:= false;
  strStripTrailing(menuCaption, '.');
  item := TwwFieldInfo(FindItem(GetFieldName));
  fDialog := FilterDialog as TwwFilterDialog;

  if item <> nil then
  begin
    case TMenuItem(Sender).Tag of
      0:
        ;
      1, 11:
        if (item.MatchType = fdMatchExact) and (item.nonMatching = false) then
          filterValue := item.filterValue;

      2, 12:
        if (item.MatchType = fdMatchExact) and item.nonMatching then
          filterValue := item.filterValue;
      3:
        if (item.MatchType = fdMatchRange) and (item.MaxValue <> '') and
          (item.MinValue = '') then // Les than
          filterValue := item.MaxValue;
      4:
        if (item.MatchType = fdMatchRange) and (item.MinValue <> '') and
          (item.MaxValue = '') then // Greater than
          filterValue := item.MinValue;
      5:
        if (item.MatchType = fdMatchRange) and // Between
          ((item.MinValue <> '') or (item.MaxValue <> '')) then
        begin
          filterValue := item.MinValue;
          filterValue2:= item.MaxValue;
        end;
      13:
        if (item.MatchType = fdMatchStart) and (item.nonMatching = false) then
          filterValue := item.filterValue;
      14:
        if (item.MatchType = fdMatchStart) and (item.nonMatching) then
          filterValue := item.filterValue;
      15:
        if (item.MatchType = fdMatchAny) and (not item.nonMatching) then
          filterValue := item.filterValue;
      16:
        if (item.MatchType = fdMatchAny) and (item.nonMatching) then
          filterValue := item.filterValue;
      17:
        if (item.MatchType = fdMatchEnd) and (not item.nonMatching) then
          filterValue := item.filterValue;
      18:
        if (item.MatchType = fdMatchEnd) and (item.nonMatching) then
          filterValue := item.filterValue;

    end;
  end;
  if (TMenuItem(Sender).Tag >=301) and (TMenuItem(Sender).Tag<=302) then
  begin
     case (TMenuItem(Sender).Tag) of
      301:
        begin
            filterValue := fDialog.FieldOperators.NullChar;
            nonMatching:=false;
        end;

      302:
        begin
            filterValue := fDialog.FieldOperators.NullChar;
            nonMatching:= true;
        end;

    end;
  end
  else if (TMenuItem(Sender).Tag >=111) and (TMenuItem(Sender).Tag<=125) then begin // Tomorrow
      RemoveItem(GetFieldName);
      item := DoEqual;
      item.Tag:= TMenuItem(Sender).Tag;

      case (TMenuItem(Sender).Tag) of
        111: item.FilterValue:= DateToStr(Date + 1); // Tomorrow
        112: item.FilterValue:= DateToStr(Date);
        113: item.FilterValue:= DateToStr(Date - 1);
        114: begin  // Next Week
           item.MinValue:= DateToStr(Trunc(Date)-Sysutils.DayOfWeek(Date)+8);
           item.MaxValue:= DateToStr(Trunc(Date)-Sysutils.DayOfWeek(date)+14);
           item.MatchType :=fdMatchRange;
             end;
        115: begin // This Week
           item.MinValue:= DateToStr(Trunc(Date)-Sysutils.DayOfWeek(Date)+1);
           item.MaxValue:= DateToStr(Trunc(Date)-Sysutils.DayOfWeek(date)+7);
           item.MatchType :=fdMatchRange;
             end;
        116: begin // Last Week
           item.MinValue:= DateToStr(Trunc(Date)-Sysutils.DayOfWeek(Date)-6);
           item.MaxValue:= DateToStr(Trunc(Date)-Sysutils.DayOfWeek(date));
           item.MatchType :=fdMatchRange;
             end;
        117: begin // Next Month
           DecodeDate(Date, year, month, day);
           TempDate:=
               Sysutils.EncodeDate(Year, Month, 1) + DaysThisMonth(Month, Year); // First day of next month

           DecodeDate(TempDate, year, month, day);

           item.MinValue:= DateToStr(TempDate);
           item.MaxValue:= DateToStr(TempDate + DaysThisMonth(Month, Year)-1);
//           item.MaxValue:= DateToStr(TempDate +Sysutils.EncodeDate(Year, Month+DaysThisMonth(Year, Month), 1));
           item.MatchType :=fdMatchRange;
             end;
        118: begin
           DecodeDate(Date, year, month, day);
           TempDate:=
               Sysutils.EncodeDate(Year, Month, 1);

           item.MinValue:= DateToStr(TempDate);
           item.MaxValue:= DateToStr(TempDate + DaysThisMonth(Month, Year)-1);
           item.MatchType :=fdMatchRange;
             end;
        119: begin
           DecodeDate(Date, year, month, day);
           TempDate:=
               Sysutils.EncodeDate(Year, Month, 1) -1; // Last day of prior month
           DecodeDate(TempDate, year, month, Day);

           item.MinValue:= DateToStr(EncodeDate(Year, Month, 1)); // First day of last month
           item.MaxValue:= DateToStr(EncodeDate(Year, Month, DaysThisMonth(Month, Year))); //11/9/11 - Remove -1 as it would not include the last day
           item.MatchType :=fdMatchRange;
             end;
        120: begin
               DecodeDate(Date, year, month, day);
               if month>10 then begin
                  quarterMonth:= 1;
                  quarterYear:= year+1;
               end
               else begin
                  quarterMonth:= 3 * ((month+3-1) div 3) + 1;
                  quarterYear:= year;
               end;
               TempDate:=
                 Sysutils.EncodeDate(quarterYear, quarterMonth, 1); // First day of next year

               item.MinValue:= DateToStr(TempDate);
               item.MaxValue:= DateToStr(EncodeDate(quarterYear, quarterMonth+2, DaysThisMonth(quarterMonth+2, quarterYear)));
               item.MatchType :=fdMatchRange;
             end;

        121: begin // This Quarter
               DecodeDate(Date, year, month, day);
               quarterMonth:= 3 * ((month-1) div 3) + 1;

               TempDate:=
                 Sysutils.EncodeDate(Year, quarterMonth, 1); // First day of quarterr

               item.MinValue:= DateToStr(TempDate);
               item.MaxValue:= DateToStr(EncodeDate(Year, quarterMonth+2, DaysThisMonth(quarterMonth+2, Year)));
               item.MatchType :=fdMatchRange;
             end;

        122: begin
               DecodeDate(Date, year, month, day);
               if month<3 then begin
                  quarterMonth:= 10;
                  quarterYear:= year-1;
               end
               else begin
                  quarterMonth:= 3 * ((month-3-1) div 3) + 1;
                  quarterYear:= year;
               end;
               TempDate:=
                 Sysutils.EncodeDate(quarterYear, quarterMonth, 1); // First day of next year

               item.MinValue:= DateToStr(TempDate);
               item.MaxValue:= DateToStr(EncodeDate(quarterYear, quarterMonth+2, DaysThisMonth(quarterMonth+2, quarterYear)));
               item.MatchType :=fdMatchRange;
             end;

        123: begin  // Next Year
               DecodeDate(Date, year, month, day);
               TempDate:=
                 Sysutils.EncodeDate(Year+1, 1, 1); // First day of next year

               item.MinValue:= DateToStr(TempDate);
               item.MaxValue:= DateToStr(EncodeDate(Year+1, 12, 31));
               item.MatchType :=fdMatchRange;
             end;
        124: begin
               DecodeDate(Date, year, month, day);
               TempDate:=
                 Sysutils.EncodeDate(Year, 1, 1); // First day of this year

               item.MinValue:= DateToStr(TempDate);
               item.MaxValue:= DateToStr(EncodeDate(Year, 12, 31));
               item.MatchType :=fdMatchRange;
             end;
        125: begin
               DecodeDate(Date, year, month, day);
               TempDate:=
                 Sysutils.EncodeDate(Year-1, 1, 1); // First day of last year

               item.MinValue:= DateToStr(TempDate);
               item.MaxValue:= DateToStr(EncodeDate(Year-1, 12, 31));
               item.MatchType :=fdMatchRange;
             end;

      end;
      fDialog.FieldInfo.Add(item);
      fDialog.ApplyFilter;
      exit;
  end
  else if (TMenuItem(Sender).Tag =5) then
  begin
     doDefaultDialog:=true;
     filterCaption:= TwwColumn(Column).DisplayLabel + ' ' + menuCaption;

     if Assigned(TwwCustomDBGrid(Grid).OnBeforeMenuGetFilterRange) then
     begin
        try
           applyFilter:= true;
           TwwCustomDBGrid(Grid).OnBeforeMenuGetFilterRange(Grid, GetFieldName,
              filterCaption,
              filterValue, filterValue2, doDefaultDialog, applyFilter);
           if not applyFilter then exit;
        except
           exit; // Don't apply filter
        end;
     end;
     if DoDefaultDialog then
{        TwwCustomDBGrid(Grid).ExecuteInputTwoStringDialog(Grid, GetFieldName,
            TwwColumn(Column).DisplayLabel + ' ' + menuCaption,
            filterValue, filterValue2, doDefault);
}
        if not wwInputTwoStringDialog(self, GetField, filterCaption,
           filterValue, filterValue2) then
           exit;
  end
  else begin
     //! Event here to initialize default filter values

     canUseDefault:= sfoUseCurrentValueForFilter in TwwCustomDBGrid(Grid).TitleMenuAttributes.Options;
     if canUseDefault and ((TMenuItem(Sender).Tag=11) or (TMenuItem(Sender).Tag=1)) then
        filterValue:= GetField.AsString; // 11/17/10 - Use active value as default

     doDefaultDialog:=true;
     filterCaption:= TwwColumn(Column).DisplayLabel + ' ' + menuCaption;

     if Assigned(TwwCustomDBGrid(Grid).OnBeforeMenuGetFilterValue) then
     begin
        try
           applyFilter:= true;
           TwwCustomDBGrid(Grid).OnBeforeMenuGetFilterValue(Grid, GetFieldName,
              filterCaption,
              filterValue, doDefaultDialog, applyFilter);
           if not applyFilter then exit;
        except
           exit; // Don't apply filter
        end;
     end;

     if not wwInputStringDialog(self, GetField, filterCaption, filterValue) then
         exit;
  end;

  RemoveItem(GetFieldName);
  case TMenuItem(Sender).Tag of
    0:
      ;
    1, 11, 301, 302:
      begin
        item := DoEqual;
        fDialog.FieldInfo.Add(item);
        fDialog.ApplyFilter;
      end;
    2, 12:
      begin // Not equal
        item := DoEqual;
        item.nonMatching := true;
        fDialog.FieldInfo.Add(item);
        fDialog.ApplyFilter;
      end;
    3:
      begin // Less than
        item := DoLessThan;
        fDialog.FieldInfo.Add(item);
        fDialog.ApplyFilter;
      end;
    4:
      begin // Greater than
        item := DoLessThan;
        item.MinValue:= filterValue;
        item.MaxValue:= filterValue2;
        fDialog.FieldInfo.Add(item);
        fDialog.ApplyFilter;
      end;
    5:
      // Between
      begin // Greater than
        item := DoLessThan;
        item.MinValue := filterValue;
        item.MaxValue := filterValue2;
        fDialog.FieldInfo.Add(item);
        fDialog.ApplyFilter;
      end;

    13, 14:
      begin // MatchStart
        item := DoStartsWith;
        if TMenuItem(Sender).Tag = 14 then
          item.nonMatching := true;
        fDialog.FieldInfo.Add(item);
        fDialog.ApplyFilter;
      end;
    15, 16:
      begin
        item := DoStartsWith;
        if TMenuItem(Sender).Tag = 16 then
          item.nonMatching := true;
        item.MatchType := fdMatchAny;
        fDialog.FieldInfo.Add(item);
        fDialog.ApplyFilter;
      end;
    17, 18:
      begin
        item := DoStartsWith;
        if TMenuItem(Sender).Tag = 18 then
          item.nonMatching := true;
        item.MatchType := fdMatchEnd;
        fDialog.FieldInfo.Add(item);
        fDialog.ApplyFilter;
      end;
  end;
end;

function TwwFormGridFilterTypes.GetDataSet: TDataSet;
var
  //dataset: TDataSet;
  datasource: TDataSource;
begin
  result:= nil;
  datasource := wwGetDatasource(Grid);
  if datasource = nil then
    exit;
  result := wwGetDataSet(datasource);
end;

function TwwFormGridFilterTypes.HaveAscendingIndexDefs: boolean;
var
  indexDefs: TIndexDefs;
  tempFieldName: string;
  i: integer;
  curPos: integer;
begin
  result := false;
  if wwGetIndexDefs(GetDataSet, indexDefs) then
  begin
    for i := 0 to indexDefs.Count - 1 do
    begin
      tempFieldName := indexDefs.Items[i].Fields;
      curPos := 1;
      tempFieldName := strGetToken(tempFieldName, ';', curPos);

      if AnsiUpperCase(tempFieldName) = AnsiUpperCase(GetFieldName) then
      begin
        if not(ixDescending in indexDefs.Items[i].Options) then
        begin
          result := true;
          exit;
        end;
      end
    end;
  end
end;

function TwwFormGridFilterTypes.HaveDescendingIndexDefs: boolean;
var
  indexDefs: TIndexDefs;
  tempFieldName: string;
  i: integer;
  curPos: integer;
begin
  result := false;
  if wwGetIndexDefs(GetDataSet, indexDefs) then
  begin
    // IndexFieldNames:= wwGetIndexFieldNames(GetDataSet);
    // indexName:= wwGetIndexName(DataSet);

    for i := 0 to indexDefs.Count - 1 do
    begin
      tempFieldName := indexDefs.Items[i].Fields;
      curPos := 1;
      tempFieldName := strGetToken(tempFieldName, ';', curPos);

      if AnsiUpperCase(tempFieldName) = AnsiUpperCase(GetFieldName) then
      begin
        if (ixDescending in indexDefs.Items[i].Options) then
        begin
          result := true;
          exit;
        end;
      end
    end;
  end
end;

function TwwFormGridFilterTypes.IsClientCursor: boolean;
var
  dataset: TDataSet;
begin
  result := false;
  if (([sfoClientCursor] * TwwCustomDBGrid(Grid).TitleMenuAttributes.Options)
      = [sfoClientCursor]) then
    result := true
  else if wwIsClass(GetDataSet.ClassType, 'TClientDataSet') then
    result := true
  else
  begin
    dataset := GetDataSet;
    if dataset = nil then
      exit;

    if ((wwGetDatabaseCursorType(dataset) = 1) and
        (wwIsClass(dataset.ClassType, 'TADOTable') or wwIsClass
          (dataset.ClassType, 'TADODataSet'))) then
      result := true
  end;
end;

procedure TwwFormGridFilterTypes.PopupFilterMenuPopup(Sender: TObject);
var
  ActiveIndexDef: TIndexDef;
  curPos: integer;
  tempFieldName: string;
  havedescending, haveAscending: boolean;
  item: TwwFieldInfo;
  canFilter, canAscend, canDescend: boolean;
  canGroup: boolean;
  canSelectColumns: boolean;
  allowNull: boolean;
  title: string;
  column: TwwColumn;
begin
  ApplyIntl;

  TwwFilterDialog(FilterDialog).datasource := wwGetDatasource(Grid);
  canDescend:= true;
  canAscend:=true;
  canGroup:=true;
  canSelectColumns:= sfoSelectColumns in TwwCustomDBGrid(Grid).TitleMenuAttributes.Options;

  // Check if have ascending and descending indexes for field and disable menu options when not available
  if GetDataSet.FindField(GetFieldName) is TBlobField then
  begin
    canDescend:= false;
    canAscend:= false;
    canGroup:=false;
  end
  else
  begin
    if sfoSortDescending in TwwCustomDBGrid(Grid)
      .TitleMenuAttributes.Options then
    begin
      if HaveDescendingIndexDefs then
        CanDescend:= true
      else if IsClientCursor and (sfoCreateIndexes in TwwCustomDBGrid(Grid)
          .TitleMenuAttributes.Options) then
          CanDescend:=true
      else
        CanAscend:=false;
    end
    else
    begin
      SortLargesttoSmallest1.Enabled := false;
      canDescend:=false;
    end;


    GroupBy1.caption := wwInternational.GridTitleMenu.GroupByCaption;

    // 9/14/10 - Use displaylabel instead of tfield.fieldname so grid settings are used
    column:= TwwCustomDBGrid(Grid).ColumnByName(GetField.FieldName);
    if column<>nil then title:= column.DisplayLabel
    else title:= GetField.DisplayName;

    if GroupBy1.Caption='' then
       GroupBy1.Caption:= 'Group By ' + title
    else
       GroupBy1.Caption:= GroupBy1.Caption + title ;//GetField.DisplayName;

    GroupBy1.Checked := wwEqualStr(TwwCustomDBGrid(Grid).GroupFieldName,
      GetField.fieldName);
    ClearGroupBy1.Visible:= GroupBy1.Checked;


    if sfoSortAscending in TwwCustomDBGrid(Grid)
      .TitleMenuAttributes.Options then
    begin
      if IsClientCursor then
        canAscend:=true
      else if HaveAscendingIndexDefs then // Check IndexDefs
        CanAscend:=true
      else
        CanAscend:=false;
    end
    else
    begin
      CanAscend:=false;
    end;

    if sfoGrouping in TwwCustomDBGrid(Grid).TitleMenuAttributes.Options then
    begin
       canGroup:= true;
    end
    else
       canGroup:=false;

    allowNull := sfoAllowNullFilters in TwwCustomDBGrid(Grid).TitleMenuAttributes.Options;
    IsNull1.visible:= allowNull;
    IsNull2.visible:= allowNull;
    IsNull3.visible:= allowNull;
    IsNotNull1.visible:= allowNull;
    IsNotNull2.visible:= allowNull;
    IsNotNull3.visible:= allowNull;
    NullSeparatorDate.Visible:= allowNull;
    NullSeparatorText.Visible:= allowNull;
    NullSeparatorNumber.Visible:= allowNull;


    if Assigned(TwwCustomDBGrid(Grid).OnCanGroup) then
    begin
        TwwCustomDBGrid(Grid).OnCanGroup(Grid, GetFieldName, canGroup);
    end;

    if Assigned(TwwCustomDBGrid(Grid).OnCanSort) then
    begin
        TwwCustomDBGrid(Grid).OnCanSort(Grid, GetFieldName, true, canAscend);
        TwwCustomDBGrid(Grid).OnCanSort(Grid, GetFieldName, false, canDescend);
    end;

    SortLargesttoSmallest1.Visible := SortLargesttoSmallest1.Enabled;
    SortSmallesttoLargest1.Visible := SortSmallesttoLargest1.Enabled;
    havedescending := false;
    haveAscending := false;
    if wwDataSetActiveIndexDef(GetDataSet, ActiveIndexDef) then
    begin
      curPos := 1;
      tempFieldName := strGetToken(ActiveIndexDef.Fields, ';', curPos);
      if AnsiUpperCase(tempFieldName) = AnsiUpperCase(GetFieldName) then
      begin
        havedescending := ixDescending in ActiveIndexDef.Options;
        haveAscending := not havedescending;
      end;
    end
    else
    begin
      haveAscending := AnsiUpperCase(wwGetIndexFieldName(GetDataSet))
        = AnsiUpperCase(GetFieldName);
    end;
    SortLargesttoSmallest1.Checked := havedescending;
    SortSmallesttoLargest1.Checked := haveAscending;
  end;

  SortSmallestToLargest1.Enabled:= canAscend;
  SortLargestToSmallest1.Enabled:= canDescend;
  GroupBy1.Enabled:= canGroup;

  SortLargesttoSmallest1.Visible := SortLargesttoSmallest1.Enabled;
  SortSmallesttoLargest1.Visible := SortSmallesttoLargest1.Enabled;
  AddRemoveColumns1.Visible:= canSelectColumns;
  GroupBy1.Visible:= GroupBy1.Enabled;
  if GroupBy1.Enabled and GroupBy1.Checked then
     GroupBy1.Enabled:= false;

  // Now check filtering criteria
  item := TwwFieldInfo(FindItem(GetFieldName));
  ClearFilter1.Enabled := item <> nil;
  NumberFilters1.Checked := item <> nil;
  TextFilters1.Checked := item <> nil;
  DateFilters1.Checked := item <> nil;

  if sfoFilter in TwwCustomDBGrid(Grid).TitleMenuAttributes.Options then
  begin
    TextFilters1.Visible := (GetField.DataType in [ftString, ftWideString,
      ftMemo, ftWideMemo, ftBlob]);
    NumberFilters1.Visible := (GetField.DataType in [ftBCD, ftFMTBcd, ftFloat, ftCurrency, ftSmallInt, ftInteger,
      ftWord]);
    DateFilters1.Visible:= (GetField.DataType in [ftDate, ftTime, ftDateTime,
      ftTimeStamp]);

    CanFilter:=TextFilters1.Visible or NumberFilters1.Visible or DateFilters1.Visible;
    if Assigned(TwwCustomDBGrid(Grid).OnCanFilter) then
    begin
        TwwCustomDBGrid(Grid).OnCanFilter(Grid, GetFieldName, canFilter);
        if not canFilter then begin
           TextFilters1.Visible:=false;
           NumberFilters1.Visible:=false;
           DateFilters1.Visible:=false;
        end;
    end;
    ClearFilter1.Visible:= canFilter;
  end
  else
  begin
    TextFilters1.Visible := false;
    NumberFilters1.Visible := false;
    DateFilters1.Visible:=false;
    ClearFilter1.Visible := false;
  end;

      if  (item<>nil) and (item.FilterValue = TwwFilterDialog(FilterDialog).FieldOperators.NullChar) then
      begin
        IsNull1.Checked:= (item <> nil) and (item.MatchType = fdMatchExact) and
          (item.nonMatching = false);
        IsNotNull1.Checked:= (item <> nil) and (item.MatchType = fdMatchExact) and
          (item.nonMatching = True);
      end
      else begin
        IsNull1.Checked:= false;
        IsNotNull1.Checked:= false;
      end;

      IsNull2.Checked:= IsNull1.Checked;
      IsNotNull2.Checked:= IsNotNull1.Checked;
      IsNull3.Checked:= IsNull1.Checked;
      IsNotNull3.Checked:= IsNotNull1.Checked;

  if NumberFilters1.Visible then
  begin
    Equals1.Checked := (item <> nil) and (item.MatchType = fdMatchExact) and
      (item.nonMatching = false);
    Doesnotequal1.Checked := (item <> nil) and (item.MatchType = fdMatchExact)
      and (item.nonMatching);
    LessThan1.Checked := (item <> nil) and (item.MatchType = fdMatchRange) and
      (item.MinValue = '') and (item.MaxValue <> '');
    GreaterThan1.Checked := (item <> nil) and (item.MatchType = fdMatchRange)
      and (item.MinValue <> '') and (item.MaxValue = '');
    Between1.Checked := (item <> nil) and (item.MatchType = fdMatchRange) and
      (item.MinValue <> '') and (item.MaxValue <> '');
  end
  else if DateFilters1.Visible then
  begin
    Equals3.Checked := false;
    Before1.Checked := false;
    After1.Checked := false;
    Between2.Checked := false;
    Tomorrow1.Checked:=false;
    Today1.Checked:=false;
    Yesterday1.Checked:=false;
    NextWeek1.Checked:= false;
    ThisWeek1.Checked:= false;
    LastWeek1.Checked:=false;
    NextMonth1.Checked:=false;
    ThisMonth1.Checked:=false;
    LastMonth1.Checked:=false;
    NextQuarter1.Checked:=false;
    ThisQuarter1.Checked:=false;
    LastQuarter1.Checked:=false;
    NextYear1.Checked:=false;
    ThisYear1.Checked:=false;
    LastYear1.Checked:=false;

    if (item<>nil) and (item.Tag<>0) then
    begin
      case item.Tag of
        111: Tomorrow1.Checked:= true;
        112: Today1.Checked:= true;
        113: Yesterday1.Checked:= true;
        114: NextWeek1.Checked:= true;
        115: ThisWeek1.Checked:= true;
        116: LastWeek1.Checked:= true;
        117: NextMonth1.Checked:= true;
        118: ThisMonth1.Checked:= true;
        119: LastMonth1.Checked:= true;
        120: NextQuarter1.Checked:= true;
        121: ThisQuarter1.Checked:= true;
        122: LastQuarter1.Checked:= true;
        123: NextYear1.Checked:= true;
        124: ThisYear1.Checked:= true;
        125: LastYear1.Checked:= true;
      end;
    end
    else begin

      Equals3.Checked := (item <> nil) and (item.MatchType = fdMatchExact) and
          (item.nonMatching = false) and
          (item.FilterValue <> TwwFilterDialog(FilterDialog).FieldOperators.NullChar);

 //    Doesnotequal1.Checked := (item <> nil) and (item.MatchType = fdMatchExact)
//      and (item.nonMatching);
      Before1.Checked := (item <> nil) and (item.MatchType = fdMatchRange) and
        (item.MinValue = '') and (item.MaxValue <> '');
      After1.Checked := (item <> nil) and (item.MatchType = fdMatchRange)
        and (item.MinValue <> '') and (item.MaxValue = '');
      Between2.Checked := (item <> nil) and (item.MatchType = fdMatchRange) and
         (item.MinValue <> '') and (item.MaxValue <> '');
    end;
  end
  else if TextFilters1.Visible then
  begin
    Equals2.Checked := (item <> nil) and (item.MatchType = fdMatchExact) and
      (item.nonMatching = false);
    Doesnotequal2.Checked := (item <> nil) and (item.MatchType = fdMatchExact)
      and (item.nonMatching);
    Startswith1.Checked := (item <> nil) and (item.MatchType = fdMatchStart)
      and (item.filterValue <> '') and (not item.nonMatching);
    Doesnotstartwith1.Checked := (item <> nil) and
      (item.MatchType = fdMatchStart) and (item.filterValue <> '') and
      (item.nonMatching);
    Contains1.Checked := (item <> nil) and (item.MatchType = fdMatchAny) and
      (item.filterValue <> '') and (not item.nonMatching);
    Doesnotcontain1.Checked := (item <> nil) and (item.MatchType = fdMatchAny)
      and (item.filterValue <> '') and (item.nonMatching);
    Endswith1.Checked := (item <> nil) and (item.MatchType = fdMatchEnd) and
      (item.filterValue <> '') and (not item.nonMatching);
    Doesnotendwith1.Checked := (item <> nil) and (item.MatchType = fdMatchEnd)
      and (item.filterValue <> '') and (item.nonMatching);

  end
  else
  begin
    Equals1.Checked := false;
    Doesnotequal1.Checked := false;
    LessThan1.Checked := false;
    GreaterThan1.Checked := false;
    Between1.Checked := false;
  end;

    if Assigned(TwwCustomDBGrid(Grid).OnPopupTitleDropDown) then
    begin
        TwwCustomDBGrid(Grid).OnPopupTitleDropDown(Grid, PopupFilterMenu);
    end;

end;

procedure TwwFormGridFilterTypes.SortLargesttoSmallest1Click(Sender: TObject);
begin
   SortDescending;
end;

procedure TwwFormGridFilterTypes.SortDescending(fieldName: string='');
begin
  if fieldName='' then
     fieldName:= GetFieldName;
  TwwCustomDBGrid(Grid).Sort(fieldName, true);
end;

procedure TwwFormGridFilterTypes.SortAscending(fieldName: string='');
begin
  if fieldName='' then
     fieldName:= GetFieldName;
  TwwCustomDBGrid(Grid).Sort(fieldName, false);
end;

procedure TwwFormGridFilterTypes.SortSmallesttoLargest1Click(Sender: TObject);
begin
  SortAscending;
end;


procedure TwwFormGridFilterTypes.ApplyIntl;
  procedure SetCaption(item : TMenuItem; val: string);
  begin
      if val<>'' then item.Caption:=val;
  end;

begin
  with wwInternational.GridTitleMenu do
  begin
     SetCaption(SortSmallestToLargest1, SortSmallesttoLargestCaption);
     SetCaption(SortLargestToSmallest1, SortLargesttoSmallestCaption);
     SetCaption(ClearFilter1, ClearFilterCaption);
     SetCaption(NumberFilters1, NumberFiltersCaption);
     SetCaption(Equals1, NumberFiltersCaptionEquals);
     SetCaption(DoesNotEqual1, NumberFiltersCaptionDoesNotEqual);
     SetCaption(LessThan1, NumberFiltersCaptionLessThan);
     SetCaption(GreaterThan1, NumberFiltersCaptionGreaterThan);
     SetCaption(Between1, NumberFiltersCaptionBetween);

     SetCaption(DateFilters1, DateFiltersCaption);
     SetCaption(Equals3, DateFiltersCaptionEquals);
     SetCaption(Before1, DateFiltersCaptionBefore);
     SetCaption(After1, DateFiltersCaptionAfter);
     SetCaption(Between2, DateFiltersCaptionBetween);
     SetCaption(Tomorrow1, DateFiltersCaptionTomorrow);
     SetCaption(Today1, DateFiltersCaptionToday);
     SetCaption(Yesterday1, DateFiltersCaptionYesterday);
     SetCaption(NextWeek1, DateFiltersCaptionNextWeek);
     SetCaption(ThisWeek1, DateFiltersCaptionThisWeek);
     SetCaption(LastWeek1, DateFiltersCaptionLastWeek);
     SetCaption(NextMonth1, DateFiltersCaptionNextMonth);
     SetCaption(ThisMonth1, DateFiltersCaptionThisMonth);
     SetCaption(LastMonth1, DateFiltersCaptionLastMonth);
     SetCaption(NextQuarter1, DateFiltersCaptionNextQuarter);
     SetCaption(ThisQuarter1, DateFiltersCaptionThisQuarter);
     SetCaption(LastQuarter1, DateFiltersCaptionLastQuarter);
     SetCaption(NextYear1, DateFiltersCaptionNextYear);
     SetCaption(ThisYear1, DateFiltersCaptionThisYear);
     SetCaption(LastYear1, DateFiltersCaptionLastYear);

     SetCaption(TextFilters1, TextFiltersCaption);
     SetCaption(Equals2, TextFiltersCaptionEquals);
     SetCaption(DoesNotEqual2, TextFiltersCaptionDoesNotEqual);
     SetCaption(StartsWith1, TextFiltersCaptionStartsWith);
     SetCaption(DoesNotStartWith1, TextFiltersCaptionDoesNotStartWith);
     SetCaption(EndsWith1, TextFiltersCaptionEndsWith);
     SetCaption(DoesNotEndWith1, TextFiltersCaptionDoesNotEndWith);

     SetCaption(Contains1, TextFiltersCaptionContains);
     SetCaption(DoesNotContain1, TextFiltersCaptionDoesNotContain);
     SetCaption(ClearGroupBy1, ClearGroupByCaption);
     SetCaption(GroupBy1, GroupByCaption);
     SetCaption(AddRemoveColumns1, ColumnsCaption);
     SetCaption(RemoveColumn1, ColumnsCaptionRemove);
     SetCaption(AddColumnsAfter1, ColumnsCaptionAddAfter);
     SetCaption(AddColumnsBefore1, ColumnsCaptionAddBefore);
   end
end;

end.
