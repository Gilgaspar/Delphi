unit vcl.wwimagecombo;
{
//
// Components : TwwImagecombo
//
// Copyright (c) 2007 by Woll2Woll Software
}

interface

uses
  Messages, Windows, SysUtils, CommCtrl, Classes, Controls, Forms, Menus,
  Graphics, StdCtrls, ImgList, ExtCtrls, DB, comctrls, dbctrls, wwdbcomb, listActns,
  wwtypes, wwcommon, wwframe, system.uitypes;

type

//  TCustomComboBoxEx = class;

  TwwComboExItem = class;
  TwwComboExItems = class;
  TwwComboItemsSortType = (icstNone, icstDisplayedText, icstStoredText);
  TwwComboItemsCompareEvent = function(List: TwwComboExItems;
    Item1, Item2: TwwComboExItem): Integer of object;
  TwwComboItemsCompare = function(List: TwwComboExItems;
    Index1, Index2: Integer): Integer;


  TwwPopupImageListBox = class(TwwPopupListbox)
    protected
      procedure DrawItem(Index: Integer; ARect: TRect;
        State: TOwnerDrawState); override;
    public
      property Style;
  end;

  TwwComboExItem = class(TCollectionItem)
  private
    FDisplayedText: String;
    FStoredText: String;
    FImageIndex: System.UITypes.TImageIndex;
    FSelectedImageIndex: System.UITypes.TImageIndex;
//    FOverlayImageIndex: TImageIndex;
    FIndent: Integer;
  protected
//    procedure SetOverlayImageIndex(const Value: TImageIndex); virtual;
    procedure SetSelectedImageIndex(const Value: System.UITypes.TImageIndex); virtual;
    procedure SetDisplayedText(const Value: String); virtual;
    procedure SetStoredText(const Value: String); virtual;
    procedure SetImageIndex(const Value: System.UITypes.TImageIndex); virtual;
    procedure SetIndex(Value: Integer); override;
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property DisplayedText: string read FDisplayedText write FDisplayedText;
    property StoredText : string read FStoredText write FStoredText;
    property ImageIndex: System.UITypes.TImageIndex read FImageIndex write SetImageIndex default -1;
    property Indent: Integer read FIndent write FIndent default -1;
//    property OverlayImageIndex: TImageIndex read FOverlayImageIndex
//      write SetOverlayImageIndex default -1;
    property SelectedImageIndex: System.UITypes.TImageIndex read FSelectedImageIndex
      write SetSelectedImageIndex default -1;
  end;

  TwwComboExItems = class(TOwnedCollection)
  private
    FSortType:  TwwComboItemsSortType;
    FOnCompare: TwwComboItemsCompareEvent;
    FCaseSensitive: boolean;
    function GetComboItem(const Index: Integer): TwwComboExItem;
    procedure SetSortType(const Value: TwwComboItemsSortType);
    procedure ExchangeItems(Index1, Index2: Integer);
    procedure QuickSort(L, R: Integer; SCompare: TwwComboItemsCompare);
    procedure CustomSort(Compare: TwwComboItemsCompare);

  protected
    procedure Notify(Item: TCollectionItem;
      Action: TCollectionNotification); override;
    function CompareItems(I1, I2: TwwComboExItem): Integer; virtual;

//    procedure SetItem(const Index: Integer); virtual;
  public
    function Add: TwwComboExItem;
    procedure Sort; virtual;
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

//    function AddItem(const Caption: String; const ImageIndex, SelectedImageIndex,
//      OverlayImageIndex, Indent: Integer; Data: Pointer): TwwComboExItem;
    function Insert(Index: Integer): TwwComboExItem;
    property Items[const Index: Integer]: TwwComboExItem read GetComboItem; default;
//    property Items[const Index: Integer]: TListControlItem read GetListItem; default;
  published
    property SortType: TwwComboItemsSortType read FSortType write SetSortType default icstNone;
    property OnCompare: TwwComboItemsCompareEvent read FOnCompare write FOnCompare;
    property CaseSensitive:  boolean read FCaseSensitive write FCaseSensitive default false;
  end;

  TwwCustomImageCombo = class(TwwDBCustomComboBox)
  private
    FItemsEx: TwwComboExItems;
    FImages: TCustomImageList;
    FValue: string;
    FNullTextDisplay: string;
    procedure SetImages(Value: TCustomImageList);
    procedure SetItemsEx(const Value: TwwComboExItems);
    function GetValue: string; virtual;

  protected
    procedure SetValue(value: string); override;
    Function CustomDraw: boolean; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function CreateListBox: TwwPopupListBox; override;
    Procedure ShowText(ACanvas: TCanvas;
          ARect: TRect; indentLeft, indentTop: integer; AText: string; transparent: boolean = false); override;
    procedure Loaded; override;
    procedure DataChange(Sender: TObject); override;
//    Function GetStoredText: string; override;  { Map Text to stored value }
    procedure CloseUp(Accept: Boolean); override;
    procedure SetItemIndex(val: integer); override;
    function GetItemIndexFromText(DisplayedText: string): integer; virtual;    
    procedure SetEditRect; override;
    procedure Paint; override; // inherited Paint;
    function GetImageRect: TRect; virtual;
    procedure UpdateData(Sender: TObject); override;
    procedure DrawFocusRect(ACanvas: TCanvas; ARect: TRect); override;
    function CalcItemHeight: integer; override;
//    function IsItemsExStored: Boolean;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure DropDown; override;
    procedure ApplyList; override;
    procedure RefreshDisplay;
    Function GetComboValue(DisplayText: string): string; override;
    Function GetComboDisplay(Value: string): string; override;

  public
    property Controller;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;

    property DisableThemes;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
    property ShowButton;  { Publish before Style property for SetStyle code }
    property Style;
    property MapList;

    property AllowClearKey;
    property AutoDropDown;
    property ShowMatchText;
    property AutoFillDate;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property ButtonStyle default cbsDownArrow;
    property CharCase;
    property Color;
//    property Column1Width;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DisableDropDownList;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Font;
    property ButtonEffects;
    property Frame;
    property ButtonWidth;
    property ButtonGlyph;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Picture;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UnboundDataType;
    property UsePictureMask;
    property Visible;
    property UnboundAlignment;

    property Images: TCustomImageList read FImages write SetImages;
    property ItemsEx: TwwComboExItems read FItemsEx write SetItemsEx;// stored IsItemsExStored;
    property ItemHeight;
    property Value :String read GetValue write SetValue;
    property NullTextDisplay: string read FNullTextDisplay write FNullTextDisplay;

    property OnAddHistoryItem;
    property OnChange;
    property OnCheckValue;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnCloseUp;
    property OnDrawItem;
    property OnMeasureItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;

  end;

  TwwImageCombo = class(TwwCustomImageCombo)
  published
    property Controller;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;

    property DisableThemes;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
    property ShowButton;  { Publish before Style property for SetStyle code }
    property Style;
    property MapList;

    property AllowClearKey;
    property AutoDropDown;
    property ShowMatchText;
    property AutoFillDate;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property ButtonStyle default cbsDownArrow;
    property CharCase;
    property Color;
//    property Column1Width;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DisableDropDownList;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Font;
    property ButtonEffects;
    property Frame;
    property ButtonWidth;
    property ButtonGlyph;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Picture;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UnboundDataType;
    property UsePictureMask;
    property Visible;
    property UnboundAlignment;
    {$ifdef wwDELPHI2010Up}
    property Touch;
    {$endif}

    property Images;
    property ItemsEx;
    property ItemHeight;
    property Value;
    property NullTextDisplay;

    property OnAddHistoryItem;
    property OnChange;
    property OnCheckValue;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnCloseUp;
    property OnDrawItem;
    property OnMeasureItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    {$ifdef wwDELPHI2010Up}
    property OnGesture;
    {$endif}

  end;

 (*
  TwwImageCombo2 = class(TCustomComboBoxEx)
  private
    FDataLink: TFieldDataLink;

    function GetDataField: string;
    procedure SetDataField(const Value: string);
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);

    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure EditingChange(Sender: TObject); virtual;

    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;

  protected
    procedure BeginEdit; virtual;
    procedure EndEdit; virtual;
  public
    property DataLink: TFieldDataLink read FDataLink;

    constructor Create(AOwner:tcomponent); override;
    destructor Destroy; override;

  published
    property Align;
    property AutoCompleteOptions default [acoAutoAppend];
    property ItemsEx;
    property Style; {Must be published before Items}
    property StyleEx;
    property Action;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnBeginEdit;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndEdit;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseMove;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
//    property Items;
    property Images;
    property DropDownCount;

    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;
*)

implementation

procedure TwwPopupImageListBox.DrawItem(Index: Integer; ARect: TRect;
      State: TOwnerDrawState);
var combo: TwwImageCombo;
    comboItem: TwwComboExItem;
    imageRect, textRect: TRect;
    imageIndex: integer;
    RowRect: TRect;
    DoDefault: boolean;
begin
  Combo:= owner as TwwImageCombo;
  RowRect:= ARect;
  RowRect.Left:= 0;

  DoDefault:= True;
  if Assigned(Combo.OnDrawItem) then begin
     if not (odSelected in State) then begin
        Canvas.Brush.Color:= Color;
        Canvas.Font.Color:= Font.Color;
        ARect.Left:=0;
        Canvas.TextRect(RowRect, RowRect.Left, RowRect.Top, '');
     end;

     try
       Combo.OnDrawItem(Combo, Index, RowRect, State)
     except
       DoDefault:= False;
     end
  end;

  if not DoDefault then exit;

  comboItem:= combo.ItemsEx.Items[Index] as TwwComboExItem;
  if (comboItem.Indent<>-1) then
     ARect.Left:= ARect.Left + comboItem.Indent;

  if Combo.Images<>nil then
  begin
     if (odSelected in State) then begin
        Canvas.Brush.Color:= clHighlight;
        Canvas.Font.Color:= clHighlightText;
        Canvas.FillRect(RowRect);
        imageIndex:= comboItem.SelectedImageIndex;
     end
     else begin
        Canvas.Brush.Color:= Color;
        Canvas.Font.Color:= Font.Color;
        Canvas.FillRect(RowRect);
        imageIndex:= comboItem.ImageIndex;
     end;
     textRect:= ARect;
     textRect.Left:= textRect.Left + Combo.Images.Width + 5;
     textRect.Top:= textRect.Top + 1 + (textRect.Bottom-textRect.Top-Canvas.TextHeight('W')) div 2;
     Canvas.TextRect(textRect, textRect.Left, textRect.Top, comboItem.DisplayedText);

     imageRect:= ARect;
     imageRect.Left:= imageRect.Left + 2;
     imageRect.Right:= ARect.Left + Combo.Images.Width;


     Combo.Images.Draw(Canvas, imageRect.left, imageRect.Top + (imageRect.Bottom-imageRect.Top-TImageList(Combo.Images).Height) div 2, imageIndex)
  end
  else inherited;
end;

{ TCustomComboBoxStrings }
(*
function TwwCustomComboBoxStrings.GetCount: Integer;
begin
  Result := SendMessage(ComboBox.Handle, CB_GETCOUNT, 0, 0);
end;

function TwwCustomComboBoxStrings.GetObject(Index: Integer): TObject;
begin
  Result := TObject(SendMessage(ComboBox.Handle, CB_GETITEMDATA, Index, 0));
  // Do additional checking on Count and Index here is so in the event
  // the object being retrieved is the integer -1 the call will succeed
  if (Longint(Result) = CB_ERR) and ((Count = 0) or (Index < 0) or (Index > Count)) then
    Error(SListIndexError, Index);
end;

procedure TwwCustomComboBoxStrings.PutObject(Index: Integer; AObject: TObject);
begin
  SendMessage(ComboBox.Handle, CB_SETITEMDATA, Index, Longint(AObject));
end;

function TwwCustomComboBoxStrings.Get(Index: Integer): string;
var
  Len: Integer;
begin
  Len := SendMessage(ComboBox.Handle, CB_GETLBTEXTLEN, Index, 0);
  // When style = csSimple we need to also check the Len > 0
  if (Len <> CB_ERR) and (Len > 0) then
  begin
    SetLength(Result, Len);
    SendMessage(ComboBox.Handle, CB_GETLBTEXT, Index, Longint(PChar(Result)));
  end
  else
    SetLength(Result, 0);
end;

procedure TwwCustomComboBoxStrings.Clear;
var
  S: string;
begin
  S := ComboBox.Text;
  SendMessage(ComboBox.Handle, CB_RESETCONTENT, 0, 0);
  ComboBox.Text := S;
  ComboBox.Update;
end;

procedure TwwCustomComboBoxStrings.Delete(Index: Integer);
begin
  SendMessage(ComboBox.Handle, CB_DELETESTRING, Index, 0);
end;

function TwwCustomComboBoxStrings.IndexOf(const S: string): Integer;
begin
  Result := SendMessage(ComboBox.Handle, CB_FINDSTRINGEXACT, -1, LongInt(PChar(S)));
end;

procedure TwwCustomComboBoxStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(ComboBox.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then ComboBox.Refresh;
end;

*)

procedure TwwCustomImageCombo.SetItemsEx(const Value: TwwComboExItems);
begin
  FItemsEx.Assign(Value);
  RefreshDisplay;
end;

constructor TwwCustomImageCombo.Create;
begin
  inherited Create(AOwner);
  FItemsEx:= TwwComboExItems.Create(self, TwwComboExItem);
  LimitEditRect:= True;
  if wwGridEssentials then
  begin
      DisplayProfessionalVersionOnlyMessage(self, 'ImageCombo is only supported in the professional version');
  end;

end;

destructor TwwCustomImageCombo.Destroy;
begin
//  Items.Free;
  FItemsEx.Free;
  inherited Destroy;
end;

procedure TwwCustomImageCombo.DataChange(Sender: TObject);
begin
  if Patch[1] then exit;  // 2/24/99 - Fix for ItemIndex being incorrect at time of OnCloseUp

  if DataLink.Field <> nil then
  begin
    if not (csDesigning in ComponentState) then
    begin
      if (DataLink.Field.DataType = ftString) and (MaxLength = 0) then
        MaxLength := DataLink.Field.Size;
    end;
    FValue:= DataLink.Field.AsString;
    RefreshDisplay;
  end else
  begin
    if csDesigning in ComponentState then
      Text := Name else
      Text := '';
  end;

end;

Function TwwCustomImageCombo.GetComboValue(DisplayText: string): string;
var i: integer;
begin
    if not MapList then
    begin
       result:= DisplayText
    end
    else begin
       for i := 0 to ItemsEx.Count - 1 do
       begin
          if  ItemsEx[i].DisplayedText = DisplayText then
          begin
             result:= ItemsEx[i].Storedtext;
             exit;
          end;
       end;
       result:= '';
   end;
end;

Function TwwCustomImageCombo.GetComboDisplay(Value: string): string;
var i: integer;
begin
   Result:= '';
   if not MapList then
   begin
     result:= value;
   end
   else begin
       for i := 0 to ItemsEx.Count - 1 do
       begin
          if  ItemsEx[i].StoredText = Value then
          begin
             result:= ItemsEx[i].Displayedtext;
             exit;
          end;
       end;
   end
end;



procedure TwwCustomImageCombo.UpdateData(Sender: TObject);
begin
  inherited UpdateData(Sender);
  FValue:= Field.AsString;
  RefreshDisplay;
end;


function ListItemsCompare(List: TwwComboExItems; Index1, Index2: Integer): Integer;
begin
  Result := List.CompareItems(List.Items[Index1], List.Items[Index2]);
end;

constructor TwwComboExItems.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
  FCaseSensitive := False;
  FSortType := icstNone;
end;

procedure TwwComboExItems.Sort;
begin
  CustomSort(ListItemsCompare);
end;

procedure TwwComboExItems.ExchangeItems(Index1, Index2: Integer);
var
  Item1, Item2: TwwComboExItem;
  I1, I2: Integer;
begin
  Item1 := Items[Index1];
  Item2 := Items[Index2];
  I1 := Items[Index1].Index;
  I2 := Items[Index2].Index;
  Item1.Index := I2;
  Item2.Index := I1;
end;

procedure TwwComboExItems.CustomSort(Compare: TwwComboItemsCompare);
begin
  if (SortType <> icstNone) and (Count > 1) then
    QuickSort(0, Count - 1, Compare);
end;

procedure TwwComboExItems.QuickSort(L, R: Integer; SCompare: TwwComboItemsCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;


procedure TwwComboExItems.SetSortType(const Value: TwwComboItemsSortType);
begin
  if FSortType <> Value then
  begin
    FSortType := Value;
    if Value <> icstNone then
      CustomSort(ListItemsCompare);
  end;
end;

function TwwComboExItems.Add: TwwComboExItem;
begin
  Result := TwwComboExItem(inherited Add);
end;
{
function TwwComboExItems.AddItem(const Caption: String; const ImageIndex,
  SelectedImageIndex, OverlayImageIndex, Indent: Integer;
  Data: Pointer): TwwComboExItem;
begin
  Result := Add;
  Result.DisplayTextg := DisplayText;
  Result.StoredValue:= StoredValue;
  Result.ImageIndex := ImageIndex;
  Result.SelectedImageIndex := SelectedImageIndex;
  Result.OverlayImageIndex := OverlayImageIndex;
  Result.Indent := Indent;
//  SetItem(Result.Index);
end;
}


function TwwComboExItems.GetComboItem(const Index: Integer): TwwComboExItem;
begin
  Result := TwwComboExItem(self.GetItem(Index));
end;

function TwwComboExItems.Insert(Index: Integer): TwwComboExItem;
begin
  Result := TwwComboExItem(inherited Insert(Index));
end;


function TwwComboExItems.CompareItems(I1, I2: TwwComboExItem): Integer;
begin
  Result:=0;
  if Assigned(OnCompare) then
    Result := OnCompare(Self, I1, I2)
  else begin
     if self.SortType=icstDisplayedText then
     begin
         if CaseSensitive then
            Result := AnsiCompareStr(I1.DisplayedText, I2.DisplayedText)
         else
            Result := AnsiCompareText(I1.DisplayedText, I2.DisplayedText)
     end
     else if self.SortType = icstStoredtext then
     begin
         if CaseSensitive then
            Result := AnsiCompareStr(I1.StoredText, I2.StoredText)
         else
            Result := AnsiCompareText(I1.StoredText, I2.StoredText)
     end
  end;

end;

procedure TwwComboExItems.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
 // case Action of
//    cnAdded:
//      with TwwComboExItem(Item) do
//      begin
//        FImageIndex := -1;
//        FSelectedImageIndex := -1;
//        FIndent := -1;
////        FOverlayImageIndex := -1;
//        FDisplayedText := '';
//        FStoredText:= '';
//     end;
//    cnExtracting:
//      if not (csDestroying in TWinControl(Owner).ComponentState) then
//        SendMessage(TWinControl(Owner).Handle, CBEM_DELETEITEM, Item.Index, 0);
//  end;
end;

{procedure TwwComboExItems.SetItem(const Index: Integer);
var
  AnItem: TComboBoxExItem;
  Insert: BOOL;
begin
  FillChar(AnItem, SizeOf(TComboBoxExItem), 0);
  AnItem.iItem := Index;
  AnItem.cchTextMax := 0;
  Insert := SendMessage(TWinControl(Owner).Handle, CBEM_GETITEM, 0, Integer(@AnItem)) = 0;
  with AnItem, ComboItems[Index] do
  begin
    mask := CBEIF_TEXT or CBEIF_IMAGE or CBEIF_SELECTEDIMAGE or
      CBEIF_INDENT or CBEIF_LPARAM;
    pszText := PChar(Caption);
    iItem := Index;
    cchTextMax := Length(Caption);
    iImage := ImageIndex;
    iSelectedImage := SelectedImageIndex;
    iOverlay := OverlayImageIndex;
    iIndent := Indent;
    lParam :=  Integer(Data);
  end;
  if Insert then
    SendMessage(TWinControl(Owner).Handle, CBEM_INSERTITEM, Index, Integer(@AnItem))
  else
    SendMessage(TWinControl(Owner).Handle, CBEM_SETITEM, Index, Integer(@AnItem));
end;
}
{ TwwComboExItem }

procedure TwwComboExItem.Assign(Source: TPersistent);
begin
  if Source is TwwComboExItem then
  begin
    FSelectedImageIndex := TwwComboExItem(Source).SelectedImageIndex;
    FIndent := TwwComboExItem(Source).Indent;
//    FOverlayImageIndex := TwwComboExItem(Source).OverlayImageIndex;
    FImageIndex := TwwComboExItem(Source).ImageIndex;
    FDisplayedText := TwwComboExItem(Source).DisplayedText;
    FStoredText := TwwComboExItem(Source).StoredText;
  end
  else
    inherited Assign(Source);
end;

procedure TwwComboExItem.SetDisplayedText(const Value: String);
begin
  FDisplayedText:= value;
end;

procedure TwwComboExItem.SetStoredText(const Value: String);
begin
  FStoredText:= value;
end;

procedure TwwComboExItem.SetImageIndex(const Value: System.UITypes.TImageIndex);
begin
  if (FSelectedImageIndex = -1) or (FSelectedImageIndex = ImageIndex) then
    FSelectedImageIndex := Value;
  FImageIndex:= Value;
//  TwwComboExItems(Collection).SetItem(Index);
end;

procedure TwwComboExItem.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
//  TwwComboExItems(Collection).SetItem(Value);
end;

function TwwComboExItem.GetDisplayName: string;
begin
   if DisplayedText<>'' then result:= DisplayedText
   else result:= inherited GetDisplayName;
end;
{
procedure TwwComboExItem.SetOverlayImageIndex(const Value: TImageIndex);
begin
  FOverlayImageIndex := Value;
//  TwwComboExItems(Collection).SetItem(Index);
end;
}
procedure TwwComboExItem.SetSelectedImageIndex(const Value: System.UITypes.TImageIndex);
begin
  FSelectedImageIndex := Value;
//  TwwComboExItems(Collection).SetItem(Index);
end;

function TwwCustomImageCombo.CreateListBox: TwwPopupListBox;
begin
  result:=  TwwPopupImageListBox.create(self);
end;

procedure TwwCustomImageCombo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
  end;
end;

procedure TwwCustomImageCombo.DropDown;
begin
//  (Listbox as TwwPopupImageListBox).Style:= lbOwnerDrawFixed;
  inherited DropDown;
end;

procedure TwwCustomImageCombo.ApplyList;
var i:integer;
begin
  ListBoxNeeded;  { 8/16/96 - Listbox needed before applying list }
  (Listbox.Items).clear;

  if Listbox.sorted and (not Sorted) then Listbox.sorted:= False;
  if ItemsEx.SortType<>icstNone then
     self.ItemsEx.Sort;

  for i:= 0 to FItemsEx.count-1 do
  begin
     ListBox.AddItem(FItemsEx[i].DisplayedText, FItemsEx[i]);
  end;
end;

procedure TwwCustomImageCombo.SetImages(Value: TCustomImageList);
begin
  if Images <> value then
  begin
    FImages:=value;
    SetEditRect;

    Invalidate;
  end;
end;

Function TwwCustomImageCombo.CustomDraw: boolean;
begin
   result:= true;
end;

function TwwCustomImageCombo.GetImageRect: TRect;
var imageRect: TRect;
begin
   imageRect:= ClientRect;
   if Frame.IsFrameEffective then
   begin
     imageRect.Left:= imageRect.Left +2;
     imageRect.Top:= imageRect.Top + 2;
   end;

   imageRect.Left:= imageRect.Left + 1;
   imageRect.Right:= imageRect.Left + Images.Width;
   result:= imageRect;
end;

procedure TwwCustomImageCombo.Paint;  // Paint called for control part
var imageRect: TRect;
    comboItem: TwwComboExItem;
begin
   if (images<>nil) then
   begin
      if self.ItemIndex>=0 then
      begin
         comboItem:= ItemsEx.Items[ItemIndex] as TwwComboExItem;
         imageRect:= GetImageRect;
         Images.Draw(ControlCanvas, imageRect.left,
               imageRect.Top + (imageRect.Bottom-imageRect.Top-TImageList(Images).Height) div 2, comboItem.ImageIndex)
      end;
   end;

{   if ItemIndex<0 then
   begin
       textRect:= ClientRect;
       ShowText(ControlCanvas, textRect, 0, 0,
           NullTextDisplay, true);
   end;
}
end;

procedure TwwCustomImageCombo.DrawFocusRect(ACanvas: TCanvas; ARect: TRect);
begin
      ACanvas.Pen.Color:= clHighlight;
      if Images<>nil then
//         ARect.Left:= ARect.Left + Images.Width + 2;
//      ARect.Right:= ARect.Right;
      if not (self.IsVistaComboNonEditable) then
      begin
         ACanvas.FrameRect(ARect);
         SetTextColor(ACanvas.Handle, clBlack);
         SetBkColor(ACanvas.Handle, clWhite);
      end
      else begin
         SetTextColor(ACanvas.Handle, clBlack);
         SetBkColor(ACanvas.Handle, clWhite);
      end;

      ACanvas.DrawFocusRect(ARect);

end;

Procedure TwwCustomImageCombo.ShowText(ACanvas: TCanvas;
          ARect: TRect; indentLeft, indentTop: integer; AText: string; transparent: boolean = false);
var FCanvas: TCanvas;
    textRect, imageRect: TRect;
    caption: string;
    imageIndex: integer;
    comboItem: TwwComboExItem;
    WriteOptions: TwwWriteTextOptions;
    tempItemIndex: integer;
//    IPStudioREg: TRegIniFile;
//    path: string;
begin
    FCanvas:= ACanvas;
   if isDroppedDown then begin
      FCanvas.Brush.Color:= Color;
      FCanvas.Font.Color:= Font.Color;
   end;


   ARect:= ClientRect;
   textRect:= ARect;
   if Images<>nil then
      textRect.Left:= textRect.Left + Images.Width + 4;
   textRect.Top:= textRect.Top + 1;
   if Frame.IsFrameEffective then begin
     textRect.Left:= textRect.Left +2;
     textRect.Top:= textRect.Top + 1;
   end;

   caption:= '';
   imageIndex:=-1;
   if csPaintCopy in ControlState then
   begin
      caption:= AText;
      tempItemIndex:= GetItemIndexFromText(AText);
      if tempItemIndex>=0 then
      begin
          imageIndex:= ItemsEx.Items[tempItemIndex].ImageIndex;
      end;
   end
   else begin
      if ItemIndex>=0 then
      begin
         comboItem:= ItemsEx.Items[ItemIndex] as TwwComboExItem;
         caption:= comboItem.DisplayedText;
         imageIndex:= comboItem.ImageIndex;
      end
      else begin
//         comboItem:= nil;
         caption:= NullTextDisplay;
      end;
   end;

   WriteOptions:= [];
   if transparent then WriteOptions:= WriteOptions + [wtoTransparent];

   if UseRightToLeftAlignment and (GetEffectiveAlignment = taLeftJustify) then
      wwWriteTextLinesT(FCanvas, textRect, 1, 1,
                pchar(caption), taRightJustify, WriteOptions)
   else
      wwWriteTextLinesT(FCanvas, textRect, 1, 1, //TempLeft-1, TempIndent-1,
                   pchar(caption), GetEffectiveAlignment, WriteOptions);


   if (imageIndex>=0) then
   begin
      imageRect:= GetImageRect;
      if Images<>nil then
         Images.Draw(FCanvas, imageRect.left,
               imageRect.Top + (imageRect.Bottom-imageRect.Top-TImageList(Images).Height) div 2, ImageIndex)
   end;

end;

function TwwCustomImageCombo.GetValue: string;
begin
//  result:= inherited Text;
  result:= FValue;
end;

procedure TwwCustomImageCombo.RefreshDisplay;
var
  i: Integer;
  found: boolean;
begin
   found:= false;
   for i := 0 to ItemsEx.Count - 1 do
   begin
     if not MapList then
     begin
       if  ItemsEx[i].DisplayedText = Value then
       begin
          ItemIndex:= i;
          found:=true;
          break;
       end;
     end
     else begin
       if  ItemsEx[i].StoredText = Value then
       begin
          ItemIndex:= i;
          found:=true;
          break;
       end;

     end;
   end;
   if not found then ItemIndex:=-1;
end;

procedure TwwCustomImageCombo.SetValue(value: string);
begin
   EnableEdit;
//   ListBoxItemsNeeded;

   FValue:= value;
   RefreshDisplay;
end;

Procedure TwwCustomImageCombo.Loaded;
begin
  inherited Loaded;
end;

procedure TwwCustomImageCombo.CloseUp(Accept: Boolean);
var comboItem: TwwComboExItem;
begin
   if IsDroppedDown and Accept then
   begin
     inherited CloseUp(Accept);

     if ListBox.ItemIndex>=0 then
     begin
       comboItem:= TwwComboExItem(ListBox.Items.Objects[ListBox.ItemIndex]);
       if MapList then
          Value:= comboItem.StoredText
       else
          Value:= comboItem.DisplayedText;
     end;
   end;
end;

function TwwCustomImageCombo.GetItemIndexFromText(DisplayedText: string): integer;
var i: integer;
begin
   for i := 0 to ItemsEx.Count - 1 do
   begin
     if not MapList then
     begin
       if  ItemsEx[i].DisplayedText = DisplayedText then
       begin
          result:= i;
          exit;
       end;
     end
     else begin
       if  ItemsEx[i].DisplayedText = DisplayedText then
       begin
          result:= i;
          exit;
       end;
     end;
   end;
   result:= -1;


end;

procedure TwwCustomImageCombo.SetItemIndex(val: integer);
var comboItem: TwwComboExItem;
begin
   inherited SetItemIndex(val);

   if (itemIndex<0) then
   begin
      FValue:= '';
//      Text:= '';
      exit;
   end;

   comboItem:= TwwComboExItem(ListBox.Items.Objects[ItemIndex]);
   if (comboItem=nil) then exit;

   if MapList then
       FValue:= comboItem.StoredText
   else
       FValue:= comboItem.DisplayedText;
   Text:= comboItem.DisplayedText;

end;


procedure TwwCustomImageCombo.SetEditRect;
var
  Loc: TRect;
begin
  Loc.Bottom :=ClientHeight+1; {+1 is workaround for windows paint bug}

  if UseRightToLeftAlignment then // Support bidimode for button - 8/26/08
    Loc.Right:= ClientWidth - 0
  else begin
    if ShowButton then Loc.Right := BtnControl.Left - 2
    else Loc.Right:= ClientWidth - 2;
  end;

  if (Frame.IsFrameEffective) then
  begin
     Frame.GetEditRectForFrame(Loc);
     Loc.Top:= Loc.Top +1;
     Loc.Left:= Loc.Left +1;
  end
  else if (BorderStyle = bsNone) and
     (IsInwwObjectView(self)) then begin
     Loc.Top := 1;
     Loc.Left := 1;
  end
  else if (BorderStyle = bsNone) then begin
     Loc.Top := 2;
     Loc.Left := 2;
  end
  else begin
     Loc.Top := 0;
     Loc.Left := 0;
  end;

  if Images<>nil then
  begin
     Loc.Left:= Loc.Left + Images.Width + 4;
  end;

  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

function TwwCustomImageCombo.CalcItemHeight: integer;
begin
   result:= Listbox.Canvas.TextHeight('A') + 3;
   if Images<>nil then
      result:= wwMax(Images.Height+2, result);
   
end;

end.
