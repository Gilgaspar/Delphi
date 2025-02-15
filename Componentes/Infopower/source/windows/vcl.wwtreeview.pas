unit vcl.wwtreeview;
{
//
// Components : TwwTreeView
//
}
interface

{$i wwIfdef.pas}
{$R-}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommCtrl, ComStrs, consts, comctrls, extctrls, wwcommon,
  system.Types, system.UITypes,
{$ifdef wwdelphi6Up}
variants,
{$endif}
{$ifdef wwdelphi7Up}
  themes,
{$endif}
  {$ifdef ThemeManager}
  thememgr, themesrv, uxtheme,
  {$endif}
  shellapi
  {$ifdef wwDelphi4Up}, ImgList{$endif};

type
  TwwCustomTreeView = class;
  TwwTreeNode = class;
  TwwItemState = (wwisSelected, wwisGrayed, wwisDisabled, wwisChecked,
    wwisFocused, wwisDefault, wwisHot, wwisMarked, wwisIndeterminate);
  TwwItemStates = set of TwwItemState;
  TwwTVDrawTextEvent = procedure (TreeView: TwwCustomTreeview;
    Node: TwwTreeNode; ARect: TRect; AItemState: TwwItemStates;
    var DefaultDrawing: boolean) of object;
  TwwTreeMouseMoveEvent = procedure(TreeView: TwwCustomTreeView;
      Node: TwwTreeNode;
      Shift: TShiftState; X, Y: Integer)of object;
  TwwTreeMouseEvent = procedure(TreeView: TwwCustomTreeView;
      Node: TwwTreeNode;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;


  TwwTreeNodes = class;

  TwwNodeState = (wwnsCut, wwnsDropHilited, wwnsFocused, wwnsSelected,
                  wwnsExpanded);
  TwwNodeAttachMode = (wwnaAdd, wwnaAddFirst, wwnaAddChild, wwnaAddChildFirst,
                       wwnaInsert, wwnaInsertAfter);
  TwwAddMode = (wwtaAddFirst, wwtaAdd, wwtaInsert);

  TwwTreeViewCheckboxType = (wwtvctNone, wwtvctCheckbox, wwtvctRadioGroup);

  TwwTreeViewOption = (wwtvoExpandOnDblClk, wwtvoExpandButtons3D,
     wwtvoFlatCheckBoxes, wwtvoHideSelection,
     wwtvoRowSelect, wwtvoShowButtons,
     wwtvoShowLines, wwtvoShowRoot,
     {tvoUnderscoreAllowed,} wwtvoHotTrack, wwtvoAutoURL, wwtvoToolTips,
     wwtvoEditText, wwtvo3StateCheckbox);
  TwwTreeViewOptions = set of TwwTreeViewOption;

  PwwNodeInfo = ^TwwNodeInfo;
  TwwNodeInfo = packed record
    ImageIndex: Integer;
    SelectedIndex: Integer;
    StateIndex: Integer;
    OverlayIndex: Integer;
    CheckboxType: TwwTreeViewCheckboxType;
    Checked: byte;
    Expanded: boolean;
    {$ifdef wwDelphi2009Up}
    DummyPad: packed array[1..3] of ansichar;  { Allow Future growth }
    {$else}
    DummyPad: packed array[1..3] of char;  { Allow Future growth }
    {$endif}
    Data: Pointer;
    StringDataSize1: integer;
    StringDataSize2: integer;
    Count: Integer;
    Text: string[255];

    { Future growth so that old executables can still run with newer tree view formats }
//    Dummy1: integer;
//    Dummy2: integer;
//    Dummy3: integer;
//    Dummy4: integer;
  end;

  TwwTreeNode = class(TPersistent)
  private
    FMultiSelected: boolean;
    FCheckboxType: TwwTreeViewCheckboxType;
    FChecked: boolean;

    FOwner: TwwTreeNodes;
    FText: string;
    FStringData1, FStringData2: String;

    FData: Pointer;
    FItemId: HTreeItem;
    FImageIndex: Integer;
    FSelectedIndex: Integer;
    FOverlayIndex: Integer;
    FStateIndex: Integer;
    FDeleting: Boolean;
    FInTree: Boolean;
    FGrayed: boolean;

    procedure SetCheckboxType(val: TwwTreeViewCheckboxType);

    function CompareCount(CompareMe: Integer): Boolean;
    function DoCanExpand(Expand: Boolean): Boolean;
    procedure DoExpand(Expand: Boolean);
    procedure ExpandItem(Expand: Boolean; Recurse: Boolean);
    function GetAbsoluteIndex: Integer;
    function GetExpanded: Boolean;
    function GetLevel: Integer;
    function GetParent: TwwTreeNode;
    function GetChildren: Boolean;
    function GetCut: Boolean;
    function GetDropTarget: Boolean;
    function GetFocused: Boolean;
    function GetIndex: Integer;
    function GetItem(Index: Integer): TwwTreeNode;
    function GetSelected: Boolean;
    function GetState(NodeState: TwwNodeState): Boolean;
    function GetCount: Integer;
    function GetTreeView: TwwCustomTreeView;
    procedure InternalMove(ParentNode, Node: TwwTreeNode; HItem: HTreeItem;
      AddMode: TwwAddMode);
//    function IsEqual(Node: TwwTreeNode): Boolean;
    function IsNodeVisible: Boolean;
    procedure SetChildren(Value: Boolean);
    procedure SetCut(Value: Boolean);
    procedure SetData(Value: Pointer);
    procedure SetDropTarget(Value: Boolean);
    procedure SetItem(Index: Integer; Value: TwwTreeNode);
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetOverlayIndex(Value: Integer);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetSelected(Value: Boolean);
    procedure SetStateIndex(Value: Integer);
    procedure SetText(const S: string);

    function GetMultiSelected: Boolean;
    procedure SetMultiSelected(Value: Boolean);

    procedure SetChecked(val: boolean);
    procedure SetGrayed(val: boolean);
  protected
//    function ShowBlankImage: boolean; virtual;
    {$ifdef wwDelphi4Up}
    ReadDataSize: integer;
    {$endif}
    procedure Invalidate; virtual;
    Function GetSizeOfNodeInfo: integer; virtual;
    procedure ReadData(Stream: TStream; Info: PwwNodeInfo); virtual;
    procedure WriteData(Stream: TStream; Info: PwwNodeInfo); virtual;
  public
    Patch: Variant;
    function GetStateIndex: integer;
    Function IsRadioGroup: boolean;
    function GetSortText: string; virtual;

    constructor Create(AOwner: TwwTreeNodes); virtual;
    destructor Destroy; override;
    function AlphaSort: Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure Collapse(Recurse: Boolean);
    function CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
    procedure Delete;
    procedure DeleteChildren;
    function DisplayRect(TextOnly: Boolean): TRect;
    function EditText: Boolean;
    procedure EndEdit(Cancel: Boolean);
    procedure Expand(Recurse: Boolean);
    function GetFirstChild: TwwTreeNode;
    function GetHandle: HWND;
    function GetLastChild: TwwTreeNode;
    function GetNext: TwwTreeNode;
    function GetNextChild(Value: TwwTreeNode): TwwTreeNode;
    function GetNextSibling: TwwTreeNode;
    function GetNextVisible: TwwTreeNode;
    function GetPrev: TwwTreeNode;
    function GetPrevChild(Value: TwwTreeNode): TwwTreeNode;
    function GetPrevSibling: TwwTreeNode;
    function GetPrevVisible: TwwTreeNode;
    function HasAsParent(Value: TwwTreeNode): Boolean;
    function IndexOf(Value: TwwTreeNode): Integer;
    procedure MakeVisible;
    procedure MoveTo(Destination: TwwTreeNode; Mode: TwwNodeAttachMode); virtual;
    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property Count: Integer read GetCount;
    property Cut: Boolean read GetCut write SetCut;
    property Data: Pointer read FData write SetData;
    property Deleting: Boolean read FDeleting;
    property Focused: Boolean read GetFocused write SetFocused;
    property DropTarget: Boolean read GetDropTarget write SetDropTarget;
    property Selected: Boolean read GetSelected write SetSelected;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Handle: HWND read GetHandle;
    property HasChildren: Boolean read GetChildren write SetChildren;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Index: Integer read GetIndex;
    property IsVisible: Boolean read IsNodeVisible;
    property Item[Index: Integer]: TwwTreeNode read GetItem write SetItem; default;
    property ItemId: HTreeItem read FItemId;
    property Level: Integer read GetLevel;
    property OverlayIndex: Integer read FOverlayIndex write SetOverlayIndex;
    property Owner: TwwTreeNodes read FOwner;
    property Parent: TwwTreeNode read GetParent;
    property SelectedIndex: Integer read FSelectedIndex write SetSelectedIndex;
    property StateIndex: Integer read FStateIndex write SetStateIndex;
    property Text: string read FText write SetText;
    property StringData: String read FStringData1 write FStringData1;
    property StringData2: String read FStringData2 write FStringData2;
    property TreeView: TwwCustomTreeView read GetTreeView;

    property Checked: boolean read FChecked write SetChecked;
    property Grayed: boolean read FGRayed write SetGrayed;
    property CheckboxType: TwwTreeViewCheckboxType read FCheckboxType write SetCheckboxType;
    property MultiSelected: Boolean read GetMultiSelected write SetMultiSelected;
  end;

{ TwwTreeNodes }

  PwwNodeCache = ^TwwNodeCache;
  TwwNodeCache = record
    CacheNode: TwwTreeNode;
    CacheIndex: Integer;
  end;

  TwwStoreData = (sdStoreText, sdStoreData1, sdStoreData2);

  TwwTreeNodes = class(TPersistent)
  private
    FOwner: TwwCustomTreeView;
    FUpdateCount: Integer;
    FNodeCache: TwwNodeCache;
    InDestroy: boolean;
    procedure AddedNode(Value: TwwTreeNode);
    function GetHandle: HWND;
    function GetNodeFromIndex(Index: Integer): TwwTreeNode;
    procedure ReadData(Stream: TStream);
    procedure Repaint(Node: TwwTreeNode);
    procedure WriteData(Stream: TStream);
    procedure ClearCache;
    procedure ReadStreamVersion(Reader: TReader);
    procedure WriteStreamVersion(Writer: TWriter);
  protected
    function AddItem(Parent, Target: HTreeItem; const Item: TTVItem;
      AddMode: TwwAddMode): HTreeItem;
    function InternalAddObject(Node: TwwTreeNode; const S: string;
      Ptr: Pointer; AddMode: TwwAddMode): TwwTreeNode;
    procedure DefineProperties(Filer: TFiler); override;
    function CreateItem(Node: TwwTreeNode): TTVItem;
    function GetCount: Integer;
    procedure SetItem(Index: Integer; Value: TwwTreeNode);
    procedure SetUpdateState(Updating: Boolean);
  public
    constructor Create(AOwner: TwwCustomTreeView);
    destructor Destroy; override;
    function AddChildFirst(Node: TwwTreeNode; const S: string): TwwTreeNode;
    function AddChild(Node: TwwTreeNode; const S: string): TwwTreeNode;
    function AddChildObjectFirst(Node: TwwTreeNode; const S: string;
      Ptr: Pointer): TwwTreeNode;
    function AddChildObject(Node: TwwTreeNode; const S: string;
      Ptr: Pointer): TwwTreeNode;
    function AddFirst(Node: TwwTreeNode; const S: string): TwwTreeNode;
    function Add(Node: TwwTreeNode; const S: string): TwwTreeNode;
    function AddObjectFirst(Node: TwwTreeNode; const S: string;
      Ptr: Pointer): TwwTreeNode;
    function AddObject(Node: TwwTreeNode; const S: string;
      Ptr: Pointer): TwwTreeNode;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure Clear;
    procedure Delete(Node: TwwTreeNode);
    procedure EndUpdate;
    function GetFirstNode: TwwTreeNode;
    function GetNode(ItemId: HTreeItem): TwwTreeNode;
    function Insert(Node: TwwTreeNode; const S: string): TwwTreeNode;
    function InsertObject(Node: TwwTreeNode; const S: string;
      Ptr: Pointer): TwwTreeNode;
    function FindNode(SearchText: string; VisibleOnly: Boolean): TwwTreeNode;
    function FindNodeInfo(SearchText: string; VisibleOnly: Boolean;
       StoreDataUsing: TwwStoreData = sdStoreText): TwwTreeNode;
    property Count: Integer read GetCount;
    property Handle: HWND read GetHandle;
    property Item[Index: Integer]: TwwTreeNode read GetNodeFromIndex; default;
    property Owner: TwwCustomTreeView read FOwner;
  end;

{ TwwCustomTreeView }

  TwwTVMultiSelectAttributes = class(TPersistent)
  private
     FEnabled: Boolean;
     FAutoUnselect: boolean;
//     FAlwaysIncludeSelectedItem: Boolean;
     FMultiSelectLevel: integer;
     FMultiSelectCheckbox: boolean;
     TreeView: TwwCustomTreeView;
     procedure SetEnabled(val: boolean);
     procedure SetMultiSelectLevel(val: integer);
     procedure SetMultiSelectCheckBox(val: boolean);

  public
     constructor Create(Owner: TComponent);
     procedure Assign(Source: TPersistent); override;

  published
     property AutoUnselect : boolean read FAutoUnselect write FAutoUnselect default True;
//     property AlwaysIncludeSelectedItem: Boolean read FAlwaysIncludeSelectedItem write FAlwaysIncludeSelectedItem default False;
     property Enabled: boolean read FEnabled write SetEnabled default False;
     property MultiSelectLevel: integer read FMultiSelectLevel write SetMultiSelectLevel default 0;
     property MultiSelectCheckbox: boolean read FMultiSelectCheckbox write SetMultiSelectCheckbox default True;
  end;

  TwwHitTest = (wwhtAbove, wwhtBelow, wwhtNowhere, wwhtOnItem, wwhtOnButton, wwhtOnIcon,
    wwhtOnIndent, wwhtOnLabel, wwhtOnRight, wwhtOnStateIcon, wwhtToLeft, wwhtToRight);
  TwwHitTests = set of TwwHitTest;
  TwwSortType = (wwtstNone, wwtstData, wwtstText, wwtstBoth);
  EwwTreeViewError = class(Exception);

  TwwTVChangingEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode;
    var AllowChange: Boolean) of object;
  TwwTVChangedEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode) of object;
  TwwTVEditingEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode;
    var AllowEdit: Boolean) of object;
  TwwTVEditedEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode; var S: string) of object;
  TwwTVExpandingEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode;
    var AllowExpansion: Boolean) of object;
  TwwTVCollapsingEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode;
    var AllowCollapse: Boolean) of object;
  TwwTVExpandedEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode) of object;
  TwwTVCompareEvent = procedure(TreeView: TwwCustomTreeView; Node1, Node2: TwwTreeNode;
    Data: Integer; var Compare: Integer) of object;
  TwwTVCustomDrawEvent = procedure(TreeView: TwwCustomTreeView; const ARect: TRect;
    var DefaultDraw: Boolean) of object;
  TwwCalcNodeAttributesEvent = procedure(TreeView: TwwCustomTreeView;
          Node: TwwTreeNode; State: TwwItemStates) of object;

  TwwItemChangeAction = (icaAdd, icaDelete, icaText, icaImageIndex);
  TwwItemChangeEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode;
    Action: TwwItemChangeAction; NewValue: Variant) of object;
  TwwToggleCheckboxEvent = procedure(TreeView: TwwCustomTreeView; Node: TwwTreeNode) of object;

  TwwTreeNodeClass = class of TwwTreeNode;

  TwwCustomTreeView = class(TWinControl)
  private
    FOnItemChange: TwwItemChangeEvent;
//    FOnItemChanging: TwwItemChangeEvent;
    FAutoExpand: Boolean;
    FBorderStyle: TBorderStyle;
    FCanvas: TControlCanvas;
    //FPaintCanvas: TwwCanvas;
    FCanvasChanged: Boolean;
    FDefEditProc: Pointer;
    FDragged: Boolean;
    FDragImage: {$ifdef wwDelphi4Up}TDragImageList{$else}TCustomImageList{$endif};
    FDragNode: TwwTreeNode;
    FEditHandle: HWND;
    FEditInstance: Pointer;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FLastDropTarget: TwwTreeNode;
    FManualNotify: Boolean;
    FMemStream: TMemoryStream;
    FRClickNode: TwwTreeNode;
    FRightClickSelects: Boolean;
    FReadOnly: Boolean;
    FSaveIndex: Integer;
    FSaveIndent: Integer;
    FSaveItems: TStringList;
    FSaveTopIndex: Integer;
    FSortType: TwwSortType;
    FStateChanging: Boolean;
    FStateImages: TCustomImageList;
    FStateChangeLink: TChangeLink;
    FStreamExpandedNode: Boolean;
//    FToolTips: Boolean;
    FTreeNodes: TwwTreeNodes;
    FWideText: WideString;
    FOnEditing: TwwTVEditingEvent;
    FOnEdited: TwwTVEditedEvent;
    FOnExpanded: TwwTVExpandedEvent;
    FOnExpanding: TwwTVExpandingEvent;
    FOnCollapsed: TwwTVExpandedEvent;
    FOnCollapsing: TwwTVCollapsingEvent;
    FOnChanging: TwwTVChangingEvent;
    FOnChange: TwwTVChangedEvent;
    FOnCompare: TwwTVCompareEvent;
    FOnDeletion: TwwTVExpandedEvent;
    FOnGetImageIndex: TwwTVExpandedEvent;
    FOnGetSelectedIndex: TwwTVExpandedEvent;
    FLineColor: TColor;
    FInactiveFocusColor: TColor;
    FOnMouseDown, FOnMouseUp, FOnDblClick: TwwTreeMouseEvent;
    FOnMouseMove: TwwTreeMouseMoveEvent;
    FOnToggleCheckbox: TwwToggleCheckboxEvent;

    FNodeClass: TwwTreeNodeClass;
    FMultiSelectAttributes: TwwTVMultiSelectAttributes;
    FOnCalcNodeAttributes: TwwCalcNodeAttributesEvent;
    FBorderWidth: Integer;
    FOnDrawText: TwwTVDrawTextEvent;
//    FFixBugImageList: TImageList;
    FOptions: TwwTreeViewOptions;
    FDisableThemes: boolean;

    FPaintBitmap: TBitmap;
    FIndent: Integer;
    LastSelectedNode: TwwTreeNode;
    MouseNode: TwwTreeNode;
    LastMouseMoveNode: TwwTreeNode;  // For themes with checkboxes and radiobuttons invalidation
    LastMouseHitTest: TwwHitTests;
    ClickedNode: TwwTreeNode;
    Down: boolean;
    EditNode, BeforeMouseDownNode: TwwTreeNode;
    FStreamVersion: integer;
    FUsePaintBuffering: boolean;
//    FEditControl: TWinControl;

    procedure DottedLine(p1, p2: TPoint);
    procedure CanvasChanged(Sender: TObject);
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure EditWndProc(var Message: TMessage);
    procedure DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
    function GetChangeDelay: Integer;
    function GetDropTarget: TwwTreeNode;
    function GetIndent: Integer;
    function GetNodeFromItem(const Item: TTVItem): TwwTreeNode;
    function GetSelection: TwwTreeNode;
    function GetTopItem: TwwTreeNode;
    procedure ImageListChange(Sender: TObject);
    procedure SetAutoExpand(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetChangeDelay(Value: Integer);
    procedure SetDropTarget(Value: TwwTreeNode);
    procedure SetImageList(Value: HImageList; Flags: Integer);
    procedure SetIndent(Value: Integer);
    procedure SetImages(Value: TCustomImageList);
    procedure SetReadOnly(Value: Boolean);
    procedure SetSelection(Value: TwwTreeNode);
    procedure SetSortType(Value: TwwSortType);
    procedure SetStateImages(Value: TCustomImageList);
//    procedure SetToolTips(Value: Boolean);
    procedure SeTwwTreeNodes(Value: TwwTreeNodes);
    procedure SetTopItem(Value: TwwTreeNode);
    procedure OnChangeTimer(Sender: TObject);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;

    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    function ValidMultiSelectLevel(ALevel: Integer): Boolean;
    Function CheckboxNeeded(Node: TwwTreeNode): boolean;
    Function GetCenterPoint(ARect: TRect): TPoint;
    procedure SetOptions(Value: TwwTreeViewOptions);
    procedure SetLineColor(Value: TColor);
    procedure SetInactiveFocusColor(Value: TColor);
    function GetItemHeight: ShortInt;
    procedure SetItemHeight(Value: ShortInt);
    function GetScrollTime: Integer;
    procedure SetScrollTime(Value: Integer);
    function GetMultiSelectListCount: integer;
    function GetMultiSelectItem(Index: integer): TwwTreeNode;
    procedure HintTimerEvent(Sender: TObject);
    function GetPaintCanvas: TControlCanvas;
  protected
    FMultiSelectList: TList;
    SkipErase: boolean;
    SkipChangeMessages: boolean;  { Notify method skips processing of change notifications }
    InLoading: boolean; { During expansion of Reference tree,
                          do not recursively expand item's children.
                          Calling MoveTo expands parent so we prevent this}

    FChangeTimer: TTimer;
    DisplayedItems: integer;
    FMouseInControl : boolean;

    { Implement hint handling }
    HintWindow: THintWindow;
    HintTimer: TTimer;
    HintTimerCount: integer;
    LastHintNode: TwwTreeNode;

    function CanEdit(Node: TwwTreeNode): Boolean; dynamic;
    function CanChange(Node: TwwTreeNode): Boolean; dynamic;
    function CanCollapse(Node: TwwTreeNode): Boolean; dynamic;
    function CanExpand(Node: TwwTreeNode): Boolean; dynamic;
    procedure Change(Node: TwwTreeNode); dynamic;
    procedure Collapse(Node: TwwTreeNode); dynamic;
    function CreateNode: TwwTreeNode; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Delete(Node: TwwTreeNode); dynamic;
    procedure DestroyWnd; override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure Edit(const Item: TTVItem); dynamic;
    procedure Expand(Node: TwwTreeNode); dynamic;
    function GetDragImages: {$ifdef wwDelphi4Up}TDragImageList{$else}TCustomImageList{$endif}; override;
    procedure GetImageIndex(Node: TwwTreeNode); virtual;
    procedure GetSelectedIndex(Node: TwwTreeNode); virtual;
    procedure Loaded; override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetDragMode(Value: TDragMode); override;
    procedure WndProc(var Message: TMessage); override;
    property AutoExpand: Boolean read FAutoExpand write SetAutoExpand default False;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ChangeDelay: Integer read GetChangeDelay write SetChangeDelay default 0;
    property Images: TCustomImageList read FImages write SetImages;
    property Indent: Integer read GetIndent write SetIndent;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property RightClickSelects: Boolean read FRightClickSelects write FRightClickSelects default False;
    property SortType: TwwSortType read FSortType write SetSortType default wwtstNone;
    property StateImages: TCustomImageList read FStateImages write SetStateImages;
    property StreamExpandedNode: Boolean read FStreamExpandedNode write FStreamExpandedNode default False;
//    property ToolTips: Boolean read FToolTips write SetToolTips default False;
    property OnEditing: TwwTVEditingEvent read FOnEditing write FOnEditing;
    property OnEdited: TwwTVEditedEvent read FOnEdited write FOnEdited;
    property OnExpanding: TwwTVExpandingEvent read FOnExpanding write FOnExpanding;
    property OnExpanded: TwwTVExpandedEvent read FOnExpanded write FOnExpanded;
    property OnCollapsing: TwwTVCollapsingEvent read FOnCollapsing write FOnCollapsing;
    property OnCollapsed: TwwTVExpandedEvent read FOnCollapsed write FOnCollapsed;
    property OnChanging: TwwTVChangingEvent read FOnChanging write FOnChanging;
    property OnChange: TwwTVChangedEvent read FOnChange write FOnChange;
    property OnCompare: TwwTVCompareEvent read FOnCompare write FOnCompare;
    property OnDeletion: TwwTVExpandedEvent read FOnDeletion write FOnDeletion;
    property OnGetImageIndex: TwwTVExpandedEvent read FOnGetImageIndex write FOnGetImageIndex;
    property OnGetSelectedIndex: TwwTVExpandedEvent read FOnGetSelectedIndex write FOnGetSelectedIndex;

    procedure MultiSelectNode(Node: TwwTreeNode; Select: boolean; redraw: boolean); virtual;
    function IsVisible(Node: TwwTreeNode; PartialOK: Boolean): Boolean; virtual;
    function ItemRect(Node: TwwTreeNode; LabelOnly: Boolean): TRect;
    procedure PaintButton(Node: TwwTreeNode; pt: TPoint; size: integer);
    procedure PaintLines(Node: TwwTreeNode);
    procedure PaintImage(Node: TwwTreeNode; State: TwwItemStates);
    function LevelRect(ANode: TwwTreeNode): TRect;
    procedure DoDrawText(TreeView: TwwCustomTreeView;
         Node: TwwTreeNode; ARect: TRect; AItemState: TwwItemStates;
         var DefaultDrawing: boolean); virtual;
    procedure Compare(Node1, Node2: TwwTreeNode; lParam: integer; var Result: integer); virtual;
    procedure CalcNodeAttributes(Node: TwwTreeNode; AItemState: TwwItemStates); virtual;
    function GetDisplayText(Node: TwwTreeNode): string; virtual;
    procedure LoadCanvasDefaults(Node: TwwTreeNode; AItemState: TwwItemStates);
    function ProcessKeyPress(Key: char; shift: TShiftState): boolean; virtual;
    function IsRowSelect: boolean; virtual;
    procedure MouseLoop(X, Y: Integer); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                 X, Y: Integer); override;
    function UseImages(Node: TwwTreeNode): Boolean;
    function UseStateImages(Node: TwwTreeNode): Boolean;
    procedure BeginPainting; virtual;
    procedure EndPainting; virtual;
    procedure BeginItemPainting(Node: TwwTreeNode; ARect: TRect; AItemState: TwwItemStates); virtual;
    procedure EndItemPainting(Node: TwwTreeNode; ARect: TRect; AItemState: TwwItemStates); virtual;
    procedure PaintItem(Node: TwwTreeNode); virtual;
    procedure ClearStateImageIndexes;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DoToggleCheckbox(Node: TwwTreeNode); virtual;
    procedure FreeHintWindow; virtual;
    Function CreateHintWindow(Node: TwwTreeNode): THintWindow; virtual;
    Procedure UnselectAllNodes(IgnoreNode: TwwTreeNode);
    procedure InvalidateNoErase;

    property ItemHeight: ShortInt read GetItemHeight write SetItemHeight;
    property OnCalcNodeAttributes: TwwCalcNodeAttributesEvent read FOnCalcNodeAttributes write FOnCalcNodeAttributes;
    property ScrollTime: Integer read GetScrollTime write SetScrollTime;
    property NodeClass: TwwTreeNodeClass read FNodeClass write FNodeClass;
  public
    Patch: Variant;

    procedure ResetStateImages;
    property StreamVersion: integer read FStreamVersion;
    Function GetFirstSibling(Node: TwwTreeNode): TwwTreeNode;
    Procedure InvalidateNode(Node: TwwTreeNode);
    Function MultiSelectCheckboxNeeded(Node: TwwTreeNode): boolean;
    Procedure UnselectAll;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AlphaSort: Boolean;
    function CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
    procedure FullCollapse;
    procedure FullExpand;
    function GetHitTestInfoAt(X, Y: Integer): TwwHitTests;
    function GetNodeAt(X, Y: Integer): TwwTreeNode;
    function IsEditing: Boolean;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    property Canvas: TControlCanvas read GetPaintCanvas;
    property DropTarget: TwwTreeNode read GetDropTarget write SetDropTarget;
    property Selected: TwwTreeNode read GetSelection write SetSelection;
    property TopItem: TwwTreeNode read GetTopItem write SetTopItem;

    property RightClickNode: TwwTreeNode read FRClickNode;
    property Options: TwwTreeViewOptions read FOptions write SetOptions default
        [wwtvoExpandOnDblClk, wwtvoShowButtons, wwtvoShowRoot, wwtvoShowLines, wwtvoHideSelection, wwtvoToolTips];
    property Items: TwwTreeNodes read FTreeNodes write SeTwwTreeNodes;
    property MultiSelectAttributes: TwwTVMultiSelectAttributes
        read FMultiSelectAttributes write FMultiSelectAttributes;
    property OnDrawText: TwwTVDrawTextEvent read FOnDrawText write FOnDrawText;
    property OnItemChange: TwwItemChangeEvent read FOnItemChange write FOnItemChange;


    property MultiSelectList[Index: Integer]: TwwTreeNode read GetMultiSelectItem;
    property MultiSelectListCount : integer read GetMultiSelectListCount;
    property LineColor: TColor read FLineColor write SetLineColor default clBtnShadow;
    property InactiveFocusColor: TColor read FInactiveFocusColor write SetInactiveFocusColor default clBtnFace;
    property OnMouseMove: TwwTreeMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseDown: TwwTreeMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TwwTreeMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnDblClick: TwwTreeMouseEvent read FOnDblClick write FOnDblClick;
    property OnToggleCheckbox: TwwToggleCheckboxEvent read FOnToggleCheckbox write FOnToggleCheckbox;
    property UsePaintBuffering: boolean read FUsePaintBuffering write FUsePaintBuffering default False;
    property DisableThemes : boolean read FDisableThemes write FDisableThemes default False;

  end;

  TwwTreeView = class(TwwCustomTreeView)
  published
    property DisableThemes;
    property Align;
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderStyle;

    property ChangeDelay;
    property Color;
    property LineColor;
    property InactiveFocusColor;
    property Ctl3D;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property Indent;
    property MultiSelectAttributes;
    property Options;
    property Items;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property UsePaintBuffering;
    property PopupMenu;
    property ReadOnly;
    property RightClickSelects;

    property ShowHint;
    property SortType;
    property StateImages;
    property StreamExpandedNode;
    property TabOrder;
    property TabStop default True;
    {$ifdef wwDELPHI2010Up}
    property Touch;
    {$endif}

    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsing;
    property OnCollapsed;
    property OnCompare;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnToggleCheckbox;
    property OnStartDock;
    property OnStartDrag;

    property OnCalcNodeAttributes;
    property OnDrawText;
    {$ifdef wwDELPHI2010Up}
    property OnGesture;
    {$endif}

  end;

  procedure wwTreeViewError(const Msg: string);

implementation
{ TwwTreeNode }

{$ifdef wwDelphi6Up}
uses RTLConsts;
{$endif}

const MaxCheckboxSize = 6;
      FixBugImageListSize = 16;

var FFixBugImageList: TImageList;
    RefCount: integer;

procedure SetComCtlStyle(Ctl: TWinControl; Value: Integer; UseStyle: Boolean);
var
  Style: Integer;
begin
  if Ctl.HandleAllocated then
  begin
    Style := GetWindowLong(Ctl.Handle, GWL_STYLE);
    if not UseStyle then Style := Style and not Value
    else Style := Style or Value;
    SetWindowLong(Ctl.Handle, GWL_STYLE, Style);
  end;
end;

function DefaultTreeViewSort(Node1, Node2: TwwTreeNode; lParam: Integer): Integer; stdcall;
begin
//    Result := lstrcmp(PChar(Node1.Text), PChar(Node2.Text));
   Node1.TreeView.Compare(Node1, Node2, lParam, Result);
end;

{
function DefaultTreeViewSort(Node1, Node2: TwwTreeNode; lParam: Integer): Integer; stdcall;
begin
  with Node1 do
    if Assigned(TreeView.OnCompare) then
      TreeView.OnCompare(TreeView, Node1, Node2, lParam, Result)
    else Result := lstrcmp(PChar(Node1.Text), PChar(Node2.Text));
end;
}

procedure TreeViewError(const Msg: string);
begin
  raise ETreeViewError.Create(Msg);
end;

{procedure TreeViewErrorFmt(const Msg: string; Format: array of const);
begin
  raise ETreeViewError.CreateFmt(Msg, Format);
end;
}
constructor TwwTreeNode.Create(AOwner: TwwTreeNodes);
begin
  inherited Create;
  FOverlayIndex := -1;
  FStateIndex := -1;
  FOwner := AOwner;
end;

destructor TwwTreeNode.Destroy;
var
  Node: TwwTreeNode;
  CheckValue: Integer;
  i: integer;
  MultiSelectList: TList;
begin
   Owner.ClearCache;
   FDeleting := True;

   // 6/30/03 - Clear LastMouseMoveNode
   if wwUseThemes(TreeView) then
   begin
      if TwwCustomTreeView(TreeView).LastMouseMoveNode = Self then
         TwwCustomTreeView(TreeView).LastMouseMoveNode:= nil;
   end;

   if FMultiSelected then begin
      if TwwCustomTreeView(TreeView).LastSelectedNode= self then
         TwwCustomTreeView(TreeView).LastSelectedNode:= nil;

      MultiSelectList:= (TreeView as TwwCustomTreeView).FMultiSelectList;
      for i:= 0 to MultiSelectList.count-1 do begin  { Bad code }
         if self=TwwTreeNode(MultiSelectList[i]) then
         begin
            MultiSelectList.delete(i);
            break;
         end
      end
   end;

   if Owner.Owner.FLastDropTarget = Self then
      Owner.Owner.FLastDropTarget := nil;
   Node := Parent;
   if (Node <> nil) and (not Node.Deleting) then
   begin
      if Node.IndexOf(Self) <> -1 then CheckValue := 1
      else CheckValue := 0;
      if Node.CompareCount(CheckValue) then
      begin
         Expanded := False;
         Node.HasChildren := False;
      end;
   end;
   if ItemId <> nil then TreeView_DeleteItem(Handle, ItemId);
   Data := nil;
   inherited Destroy;
end;

function TwwTreeNode.GetHandle: HWND;
begin
  Result := TreeView.Handle;
end;

function TwwTreeNode.GetTreeView: TwwCustomTreeView;
begin
  Result := Owner.Owner;
end;

function TwwTreeNode.HasAsParent(Value: TwwTreeNode): Boolean;
begin
  if Value <> Nil then
  begin
    if Parent = nil then Result := False
    else if Parent = Value then Result := True
    else Result := Parent.HasAsParent(Value);
  end
  else Result := True;
end;

procedure TwwTreeNode.SetText(const S: string);
var
  Item: TTVItem;
  AVariant: Variant;
begin
  if s = '' then AVariant := NULL else AVariant := s;
  if Assigned(TreeView.OnItemChange) then TreeView.OnItemChange(TreeView, self, icaText, AVariant);
  FText := S;
  with Item do
  begin
    mask := TVIF_TEXT;
    hItem := ItemId;
    pszText := LPSTR_TEXTCALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
  if (TreeView.SortType in [wwtstText, wwtstBoth]) and FInTree then
  begin
    if (Parent <> nil) then Parent.AlphaSort
    else TreeView.AlphaSort;
  end;
end;

procedure TwwTreeNode.SetData(Value: Pointer);
begin
  FData := Value;
  if (TreeView.SortType in [wwtstData, wwtstBoth]) and Assigned(TreeView.OnCompare)
    and (not Deleting) and FInTree then
  begin
    if Parent <> nil then Parent.AlphaSort
    else TreeView.AlphaSort;
  end;
end;

function TwwTreeNode.GetState(NodeState: TwwNodeState): Boolean;
var
  Item: TTVItem;
begin
  Result := False;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    if TreeView_GetItem(Handle, Item) then
      case NodeState of
        wwnsCut: Result := (state and TVIS_CUT) <> 0;
        wwnsFocused: Result := (state and TVIS_FOCUSED) <> 0;
        wwnsSelected: Result := (state and TVIS_SELECTED) <> 0;
        wwnsExpanded: Result := (state and TVIS_EXPANDED) <> 0;
        wwnsDropHilited: Result := (state and TVIS_DROPHILITED) <> 0;
      end;
  end;
end;

procedure TwwTreeNode.SetImageIndex(Value: Integer);
var
  Item: TTVItem;
begin
  if Assigned(TreeView.OnItemChange) then TreeView.OnItemChange(TreeView, self, icaImageIndex, Value);
  FImageIndex := Value;
  with Item do
  begin
    mask := TVIF_IMAGE or TVIF_HANDLE;
    hItem := ItemId;
    iImage := I_IMAGECALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TwwTreeNode.SetSelectedIndex(Value: Integer);
var
  Item: TTVItem;
begin
  FSelectedIndex := Value;
  with Item do
  begin
    mask := TVIF_SELECTEDIMAGE or TVIF_HANDLE;
    hItem := ItemId;
    iSelectedImage := I_IMAGECALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TwwTreeNode.SetOverlayIndex(Value: Integer);
var
  Item: TTVItem;
begin
  FOverlayIndex := Value;
  with Item do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    stateMask := TVIS_OVERLAYMASK;
    hItem := ItemId;
    state := IndexToOverlayMask(OverlayIndex + 1);
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TwwTreeNode.SetStateIndex(Value: Integer);
var
  Item: TTVItem;
begin
  if Value=0 then Value:= -1;  // 11/21/98 - (RSW) Don't allow 0 as state index
  if (CheckboxType = wwtvctCheckbox) and (Value<>-1) and (Value<>1) then exit; { 3/8/99}

  FStateIndex := Value;
  if Value >= 0 then Dec(Value);
  with Item do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    stateMask := TVIS_STATEIMAGEMASK;
    hItem := ItemId;
    state := IndexToStateImageMask(Value + 1);
  end;
  TreeView_SetItem(Handle, Item);
end;

function TwwTreeNode.CompareCount(CompareMe: Integer): Boolean;
var
  Count: integer;
  Node: TwwTreeNode;
Begin
  Count := 0;
  Result := False;
  Node := GetFirstChild;
  while Node <> nil do
  begin
    Inc(Count);
    Node := Node.GetNextChild(Node);
    if Count > CompareMe then Exit;
  end;
  if Count = CompareMe then Result := True;
end;

function TwwTreeNode.DoCanExpand(Expand: Boolean): Boolean;
begin
  Result := False;
  if HasChildren then
  begin
    if Expand then Result := TreeView.CanExpand(Self)
    else Result := TreeView.CanCollapse(Self);
  end;
end;

procedure TwwTreeNode.DoExpand(Expand: Boolean);
begin
  if HasChildren then
  begin
    if Expand then TreeView.Expand(Self)
    else TreeView.Collapse(Self);
  end;
end;

procedure TwwTreeNode.ExpandItem(Expand: Boolean; Recurse: Boolean);
var
  Flag: Integer;
  Node: TwwTreeNode;
begin
  if Recurse then
  begin
    Node := Self;
    repeat
      Node.ExpandItem(Expand, False);
      Node := Node.GetNext;
    until (Node = nil) or (not Node.HasAsParent(Self));
  end
  else begin
    TreeView.FManualNotify := True;
    try
      Flag := 0;
      if Expand then
      begin
        if DoCanExpand(True) then
        begin
          Flag := TVE_EXPAND;
          DoExpand(True);
        end;
      end
      else begin
        if DoCanExpand(False) then
        begin
          Flag := TVE_COLLAPSE;
          DoExpand(False);
        end;
      end;
      if Flag <> 0 then TreeView_Expand(Handle, ItemId, Flag);
    finally
      TreeView.FManualNotify := False;
    end;
  end;
end;

procedure TwwTreeNode.Expand(Recurse: Boolean);
begin
  ExpandItem(True, Recurse);
end;

procedure TwwTreeNode.Collapse(Recurse: Boolean);
begin
  ExpandItem(False, Recurse);
end;

function TwwTreeNode.GetExpanded: Boolean;
begin
  Result := GetState(wwnsExpanded);
end;

procedure TwwTreeNode.SetExpanded(Value: Boolean);
begin
  if Value then Expand(False)
  else Collapse(False);
end;

function TwwTreeNode.GetSelected: Boolean;
begin
  Result := GetState(wwnsSelected);
end;

procedure TwwTreeNode.SetSelected(Value: Boolean);
begin
  if Value then TreeView_SelectItem(Handle, ItemId)
  else if Selected then TreeView_SelectItem(Handle, nil);
end;

function TwwTreeNode.GetCut: Boolean;
begin
  Result := GetState(wwnsCut);
end;

procedure TwwTreeNode.SetCut(Value: Boolean);
var
  Item: TTVItem;
  Template: DWORD;
begin
  if Value then Template := DWORD(-1)
  else Template := 0;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    stateMask := TVIS_CUT;
    state := stateMask and Template;
  end;
  TreeView_SetItem(Handle, Item);
end;

function TwwTreeNode.GetDropTarget: Boolean;
begin
  Result := GetState(wwnsDropHilited);
end;

procedure TwwTreeNode.SetDropTarget(Value: Boolean);
begin
  if Value then TreeView_SelectDropTarget(Handle, ItemId)
  else if DropTarget then TreeView_SelectDropTarget(Handle, nil);
end;

function TwwTreeNode.GetChildren: Boolean;
var
  Item: TTVItem;
begin
  Item.mask := TVIF_CHILDREN;
  Item.hItem := ItemId;
  if TreeView_GetItem(Handle, Item) then Result := Item.cChildren > 0
  else Result := False;
end;

procedure TwwTreeNode.SetFocused(Value: Boolean);
var
  Item: TTVItem;
  Template: DWORD;
begin
  if Value then Template := DWORD(-1)
  else Template := 0;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    stateMask := TVIS_FOCUSED;
    state := stateMask and Template;
  end;
  TreeView_SetItem(Handle, Item);
end;

function TwwTreeNode.GetFocused: Boolean;
begin
  Result := GetState(wwnsFocused);
end;

procedure TwwTreeNode.SetChildren(Value: Boolean);
var
  Item: TTVItem;
begin
  with Item do
  begin
    mask := TVIF_CHILDREN;
    hItem := ItemId;
    cChildren := Ord(Value);
  end;
  TreeView_SetItem(Handle, Item);
end;

function TwwTreeNode.GetParent: TwwTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetParent(Handle, ItemId));
end;

function TwwTreeNode.GetNextSibling: TwwTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetNextSibling(Handle, ItemId));
end;

function TwwTreeNode.GetPrevSibling: TwwTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetPrevSibling(Handle, ItemId));
end;

function TwwTreeNode.GetNextVisible: TwwTreeNode;
begin
  if IsVisible then
    with FOwner do
      Result := GetNode(TreeView_GetNextVisible(Handle, ItemId))
  else Result := nil;
end;

function TwwTreeNode.GetPrevVisible: TwwTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetPrevVisible(Handle, ItemId));
end;

function TwwTreeNode.GetNextChild(Value: TwwTreeNode): TwwTreeNode;
begin
  if Value <> nil then Result := Value.GetNextSibling
  else Result := nil;
end;

function TwwTreeNode.GetPrevChild(Value: TwwTreeNode): TwwTreeNode;
begin
  if Value <> nil then Result := Value.GetPrevSibling
  else Result := nil;
end;

function TwwTreeNode.GetFirstChild: TwwTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetChild(Handle, ItemId));
end;

function TwwTreeNode.GetLastChild: TwwTreeNode;
var
  Node: TwwTreeNode;
begin
  Result := GetFirstChild;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetNextSibling;
    until Node = nil;
  end;
end;

function TwwTreeNode.GetNext: TwwTreeNode;
var
  NodeID, ParentID: HTreeItem;
  Handle: HWND;
begin
  Handle := FOwner.Handle;
  NodeID := TreeView_GetChild(Handle, ItemId);
  if NodeID = nil then NodeID := TreeView_GetNextSibling(Handle, ItemId);
  ParentID := ItemId;
  while (NodeID = nil) and (ParentID <> nil) do
  begin
    ParentID := TreeView_GetParent(Handle, ParentID);
    NodeID := TreeView_GetNextSibling(Handle, ParentID);
  end;
  Result := FOwner.GetNode(NodeID);
end;

function TwwTreeNode.GetPrev: TwwTreeNode;
var
  Node: TwwTreeNode;
begin
  Result := GetPrevSibling;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetLastChild;
    until Node = nil;
  end else
    Result := Parent;
end;

function TwwTreeNode.GetAbsoluteIndex: Integer;
var
  Node: TwwTreeNode;
begin
  if Owner.FNodeCache.CacheNode = Self then
    Result := Owner.FNodeCache.CacheIndex
  else begin
    Result := -1;
    Node := Self;
    while Node <> nil do
    begin
      Inc(Result);
      Node := Node.GetPrev;
    end;
  end;
end;

function TwwTreeNode.GetIndex: Integer;
var
  Node: TwwTreeNode;
begin
  Result := -1;
  Node := Self;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetPrevSibling;
  end;
end;

function TwwTreeNode.GetItem(Index: Integer): TwwTreeNode;
begin
  Result := GetFirstChild;
  while (Result <> nil) and (Index > 0) do
  begin
    Result := GetNextChild(Result);
    Dec(Index);
  end;
  if Result = nil then TreeViewError(SListIndexError);
end;

procedure TwwTreeNode.SetItem(Index: Integer; Value: TwwTreeNode);
begin
  item[Index].Assign(Value);
end;

function TwwTreeNode.IndexOf(Value: TwwTreeNode): Integer;
var
  Node: TwwTreeNode;
begin
  Result := -1;
  Node := GetFirstChild;
  while (Node <> nil) do
  begin
    Inc(Result);
    if Node = Value then Break;
    Node := GetNextChild(Node);
  end;
  if Node = nil then Result := -1;
end;

function TwwTreeNode.GetCount: Integer;
var
  Node: TwwTreeNode;
begin
  Result := 0;
  Node := GetFirstChild;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetNextChild(Node);
  end;
end;

procedure TwwTreeNode.EndEdit(Cancel: Boolean);
begin
  TreeView_EndEditLabelNow(Handle, Cancel);
end;

procedure TwwTreeNode.InternalMove(ParentNode, Node: TwwTreeNode;
  HItem: HTreeItem; AddMode: TwwAddMode);
var
  I: Integer;
  NodeId: HTreeItem;
  TreeViewItem: TTVItem;
  Children: Boolean;
  IsSelected: Boolean;
begin
  { if ParentNode = Node then Exit; }
  Owner.ClearCache;
  if (AddMode = wwtaInsert) and (Node <> nil) then
    NodeId := Node.ItemId else
    NodeId := nil;
  Children := HasChildren;
  IsSelected := Selected;
  if (Parent <> nil) and (Parent.CompareCount(1)) then
  begin
    Parent.Expanded := False;
    Parent.HasChildren := False;
  end;
  with TreeViewItem do
  begin
    mask := TVIF_PARAM;
    hItem := ItemId;
    lParam := 0;
  end;
  TreeView_SetItem(Handle, TreeViewItem);
  with Owner do
    HItem := AddItem(HItem, NodeId, CreateItem(Self), AddMode);
  if HItem = nil then
    raise EOutOfResources.Create(sInsertError);
  for I := Count - 1 downto 0 do
    Item[I].InternalMove(Self, nil, HItem, wwtaAddFirst);
  TreeView_DeleteItem(Handle, ItemId);
  FItemId := HItem;
  Assign(Self);
  HasChildren := Children;
  Selected := IsSelected;
end;

procedure TwwTreeNode.MoveTo(Destination: TwwTreeNode; Mode: TwwNodeAttachMode);
var
  AddMode: TwwAddMode;
  Node: TwwTreeNode;
  HItem: HTreeItem;
  OldOnChanging: TwwTVChangingEvent;
  OldOnChange: TwwTVChangedEvent;
begin
  OldOnChanging := TreeView.OnChanging;
  OldOnChange := TreeView.OnChange;
  TreeView.OnChanging := nil;
  TreeView.OnChange := nil;
  try
    if (Destination = nil) or not Destination.HasAsParent(Self) then
    begin
      AddMode := wwtaAdd;
      if (Destination <> nil) and not (Mode in [wwnaAddChild, wwnaAddChildFirst]) then
        Node := Destination.Parent else
        Node := Destination;
      case Mode of
        wwnaAdd,
        wwnaAddChild: AddMode := wwtaAdd;
        wwnaAddFirst,
        wwnaAddChildFirst: AddMode := wwtaAddFirst;
        wwnaInsert:
          begin
            Destination := Destination.GetPrevSibling;
            if Destination = Self then exit;
            if Destination = nil then AddMode := wwtaAddFirst
            else AddMode := wwtaInsert;
          end;
        wwnaInsertAfter:
          begin
            if Destination.GetNextSibling = nil then AddMode := wwtaAdd
            else AddMode := wwtaInsert;
          end;
      end;
      if Node <> nil then
        HItem := Node.ItemId else
        HItem := nil;
      InternalMove(Node, Destination, HItem, AddMode);
      Node := Parent;
      if Node <> nil then
      begin
        Node.HasChildren := True;
        Node.Expanded := True;
      end;
    end;
  finally
    TreeView.OnChanging := OldOnChanging;
    TreeView.OnChange := OldOnChange;
    Invalidate;
  end;
end;

procedure TwwTreeNode.MakeVisible;
begin
  TreeView_EnsureVisible(Handle, ItemId);
end;

function TwwTreeNode.GetLevel: Integer;
var
  Node: TwwTreeNode;
begin
  Result := 0;
  Node := Parent;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.Parent;
  end;
end;

function TwwTreeNode.IsNodeVisible: Boolean;
var
  Rect: TRect;
begin
  Result := TreeView_GetItemRect(Handle, ItemId, Rect, True);
end;

function TwwTreeNode.EditText: Boolean;
begin
  Result := TreeView_EditLabel(Handle, ItemId) <> 0;
end;

{function TwwTreeNode.ShowBlankImage: boolean;
begin
  result:= not ((TreeView.Images<>nil) and (ImageIndex=-2));
end;
}
function TwwTreeNode.DisplayRect(TextOnly: Boolean): TRect;
begin
  FillChar(Result, SizeOf(Result), 0);
  TreeView_GetItemRect(Handle, ItemId, Result, TextOnly);

  { Special case of imageindex=-2, do not show blank image }
  if TextOnly and (TreeView.Images<>nil) and not TreeView.UseImages(self) then
      result.Left:= result.Left - TImageList(TreeView.Images).Width-1
end;

function TwwTreeNode.AlphaSort: Boolean;
begin
  Result := CustomSort(nil, 0);
end;

function TwwTreeNode.CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
var
  SortCB: TTVSortCB;
begin
  Owner.ClearCache;
  with SortCB do
  begin
    if not Assigned(SortProc) then lpfnCompare := @DefaultTreeViewSort
    else lpfnCompare := SortProc;
    hParent := ItemId;
    lParam := Data;
  end;
  Result := TreeView_SortChildrenCB(Handle, SortCB, 0);
end;

procedure TwwTreeNode.Delete;
begin
  if not Deleting then Free;
end;

procedure TwwTreeNode.DeleteChildren;
begin
  Owner.ClearCache;
  TreeView_Expand(TreeView.Handle, ItemID, TVE_COLLAPSE or TVE_COLLAPSERESET);
  HasChildren := False;
end;

procedure TwwTreeNode.Assign(Source: TPersistent);
var
  Node: TwwTreeNode;
begin
  Owner.ClearCache;
  if Source is TwwTreeNode then
  begin
    Node := TwwTreeNode(Source);
    Text := Node.Text;
    Data := Node.Data;
    CheckboxType:= Node.CheckboxType;  { 4/26/99 - Do before assign State Index }
    StringData:= Node.StringData;
    StringData2:= Node.StringData2;
    ImageIndex := Node.ImageIndex;
    SelectedIndex := Node.SelectedIndex;
    StateIndex := Node.StateIndex;
    OverlayIndex := Node.OverlayIndex;
    Focused := Node.Focused;
    DropTarget := Node.DropTarget;
    Cut := Node.Cut;
    HasChildren := Node.HasChildren;
//    CheckboxType:= Node.CheckboxType;
    Checked:= Node.Checked;
  end
  else inherited Assign(Source);
end;

{function TwwTreeNode.IsEqual(Node: TwwTreeNode): Boolean;
begin
  Result := (Text = Node.Text) and (Data = Node.Data);
end;
}
procedure TwwTreeNode.ReadData(Stream: TStream; Info: PwwNodeInfo);
var
  I, Size, ItemCount: Integer;
  {$ifdef wwDELPHI2009UP}
  StrBuffer: PAnsiChar;
  {$else}
  StrBuffer: PChar;
  {$endif}
  Temp: Integer;
  UseExpanded:Boolean;
begin
  Owner.ClearCache;
  Stream.ReadBuffer(Size, SizeOf(Size));

  { 7/6/99 - Save for fcTreeCombo streaming }
  {$ifdef wwDelphi4Up}
  ReadDataSize:= Size;
  {$endif}

  { RSW - Advance if somehow size is greater than node size }
  Stream.ReadBuffer(Info^, wwmin(Size, SizeOf(Info^)));
  Temp := SizeOf(TwwNodeInfo) - (255 - Length(Info^.Text));

  { Support StringData property }
  if Info^.StringDataSize1>0 then
  begin
     {$ifdef WWDELPHI2009UP}
     StrBuffer:= AnsiStrAlloc(Info^.StringDataSize1+1);
     {$else}
     StrBuffer:= StrAlloc(Info^.StringDataSize1+1);
     {$endif}
     StrBuffer[Info^.StringDataSize1]:= #0;
     Stream.ReadBuffer(StrBuffer^, Info^.StringDataSize1);
     {$Warnings off}
     StringData:= StrPas(StrBuffer);
     {$warnings on}
     StrDispose(StrBuffer);
  end
  else StringData:= '';

  { Support StringData property }
  if Info^.StringDataSize2>0 then
  begin
     {$ifdef WWDELPHI2009UP}
     StrBuffer:= AnsiStrAlloc(Info^.StringDataSize2+1);
     {$else}
     StrBuffer:= StrAlloc(Info^.StringDataSize2+1);
     {$endif}
     StrBuffer[Info^.StringDataSize2]:= #0;
     Stream.ReadBuffer(StrBuffer^, Info^.StringDataSize2);
     {$Warnings off}
     StringData2:= StrPas(StrBuffer);
     {$Warnings on}
     StrDispose(StrBuffer);
  end
  else StringData2:= '';

  {$warnings off}
  Text := Info^.Text;
  {$warnings on}
  ImageIndex := Info^.ImageIndex;
  SelectedIndex := Info^.SelectedIndex;
  StateIndex := Info^.StateIndex;
  OverlayIndex := Info^.OverlayIndex;
  Data := Info^.Data;
  ItemCount := Info^.Count;
  CheckboxType:= Info^.CheckboxType;
  Checked:= (Info^.Checked and $01)<>0;

  Grayed:= (Info^.Checked and $02)<>0;

  UseExpanded:= Info^.Expanded;

  for I := 0 to ItemCount - 1 do
    with Owner.AddChild(Self, '') do ReadData(Stream, Info);

  // 1/31/2002-PYW-Added new property to respect expanded node settings.
  if (Owner.Owner<>nil) and (Owner.Owner.StreamExpandedNode) then
     Expanded := UseExpanded;

  if TreeView.StreamVersion=1 then
     if Size > Temp then Stream.Position:= Stream.Position + (Size - Temp);
end;

Function TwwTreeNode.GetSizeOfNodeInfo: integer;
begin
  result:= SizeOf(TwwNodeInfo);
end;

procedure TwwTreeNode.WriteData(Stream: TStream; Info: PwwNodeInfo);
var
  Size, L, ItemCount: Integer;
  Node: TwwTreeNode;
  tempString: AnsiString;
begin
  L := Length(Text);
  if L > 255 then L := 255;
  Size := GetSizeOfNodeInfo + L - 255;
//  Size := SizeOf(TwwNodeInfo) + L - 255;
  FillChar(Info^, SizeOf(TwwNodeInfo), 0);
  {$warnings off}
  Info^.Text := Text;
  {$warnings on}
  Info^.ImageIndex := ImageIndex;
  Info^.SelectedIndex := SelectedIndex;
  Info^.OverlayIndex := OverlayIndex;
  Info^.StateIndex := StateIndex;
  Info^.Data := Data;
  ItemCount := Count;
  Info^.Count := ItemCount;
  Info^.CheckboxType:= CheckboxType;
  Info^.Checked:= ord(Checked) + $02 * Ord(Grayed);
  Info^.Expanded := Expanded;
  Info^.StringDataSize1:= length(StringData);
  Info^.StringDataSize2:= length(StringData2);
  Stream.WriteBuffer(Size, SizeOf(Size));
  Stream.WriteBuffer(Info^, Size);

  { Support StringData properties }

  {$warnings off}
  if Info^.StringDataSize1>0 then begin
     tempString:= StringData;
     Stream.WriteBuffer(PAnsiChar(TempString)^, length(StringData));  // 12/19/08 - Use PAnsiChar
  end;

  if Info^.StringDataSize2>0 then begin
     tempString:= StringData2;
     Stream.WriteBuffer(PAnsiChar(TempString)^, length(StringData2));
  end;
  {$warnings on}

  Node := GetFirstChild;
  while Node <> nil do
  begin
    Node.WriteData(Stream, Info);
    Node := Node.GetNextSibling;
  end;

//  for I := 0 to ItemCount - 1 do Item[I].WriteData(Stream, Info);
end;

{ TwwTreeNodes }

constructor TwwTreeNodes.Create(AOwner: TwwCustomTreeView);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TwwTreeNodes.Destroy;
begin
  InDestroy:= True;
  Clear;
//  FOwner := nil;
  inherited Destroy;
end;

function TwwTreeNodes.GetCount: Integer;
begin
  if Owner.HandleAllocated then Result := TreeView_GetCount(Handle)
  else Result := 0;
end;

function TwwTreeNodes.GetHandle: HWND;
begin
  Result := Owner.Handle;
end;

procedure TwwTreeNodes.Delete(Node: TwwTreeNode);
begin
  if (Node.ItemId = nil) then
    Owner.Delete(Node);
  Node.Delete;
end;

procedure TwwTreeNodes.Clear;
var PrevNode, Node: TwwTreeNode;
begin
  ClearCache;
  if { (Owner <> nil) and ksw - prevent problem }Owner.HandleAllocated then
  begin
     if count<=0 then exit;

     Owner.SkipChangeMessages:= True;

     try
        BeginUpdate;

        Owner.Selected:= nil;

        { Clearing by scanning backwards seems to be significantly faster }
        { TreeView_DeleteAllItem's current implementation is slower than this
        { technique. Scanning forwards is also slower. }
        Node := GetFirstNode;
        Owner.TopItem:= Node;

        { Retrieve last node }
        while Node.GetNextSibling <> nil do Node:= Node.GetNextSibling;
        while Node.GetNext <> nil do Node:= Node.GetNext;

        While Node<>Nil do
        begin
            PrevNode:= Node;
            Node := Node.GetPrev;
            TreeView_DeleteItem(PrevNode.Handle, PrevNode.ItemId);
        end;
     finally
        Owner.SkipChangeMessages:= False;
        if not inDestroy then EndUpdate;
     end
  end
end;

{procedure TwwTreeNodes.Clear;
begin
  ClearCache;
  if Owner.HandleAllocated then
    TreeView_DeleteAllItems(Handle);
end;}

function TwwTreeNodes.AddChildFirst(Node: TwwTreeNode; const S: string): TwwTreeNode;
begin
  Result := AddChildObjectFirst(Node, S, nil);
end;

function TwwTreeNodes.AddChildObjectFirst(Node: TwwTreeNode; const S: string;
  Ptr: Pointer): TwwTreeNode;
begin
  Result := InternalAddObject(Node, S, Ptr, wwtaAddFirst);
end;

function TwwTreeNodes.AddChild(Node: TwwTreeNode; const S: string): TwwTreeNode;
begin
  Result := AddChildObject(Node, S, nil);
end;

function TwwTreeNodes.AddChildObject(Node: TwwTreeNode; const S: string;
  Ptr: Pointer): TwwTreeNode;
begin
  Result := InternalAddObject(Node, S, Ptr, wwtaAdd);
end;

function TwwTreeNodes.AddFirst(Node: TwwTreeNode; const S: string): TwwTreeNode;
begin
  Result := AddObjectFirst(Node, S, nil);
end;

function TwwTreeNodes.AddObjectFirst(Node: TwwTreeNode; const S: string;
  Ptr: Pointer): TwwTreeNode;
begin
  if Node <> nil then Node := Node.Parent;
  Result := InternalAddObject(Node, S, Ptr, wwtaAddFirst);
end;

function TwwTreeNodes.Add(Node: TwwTreeNode; const S: string): TwwTreeNode;
begin
  Result := AddObject(Node, S, nil);
end;

procedure TwwTreeNodes.Repaint(Node: TwwTreeNode);
var
  R: TRect;
begin
  if FUpdateCount < 1 then
  begin
    while (Node <> nil) and not Node.IsVisible do Node := Node.Parent;
    if Node <> nil then
    begin
      R := Node.DisplayRect(False);
      InvalidateRect(Owner.Handle, @R, True);
    end;
  end;
end;

function TwwTreeNodes.AddObject(Node: TwwTreeNode; const S: string;
  Ptr: Pointer): TwwTreeNode;
begin
  if Node <> nil then Node := Node.Parent;
  Result := InternalAddObject(Node, S, Ptr, wwtaAdd);
end;

function TwwTreeNodes.Insert(Node: TwwTreeNode; const S: string): TwwTreeNode;
begin
  Result := InsertObject(Node, S, nil);
end;

procedure TwwTreeNodes.AddedNode(Value: TwwTreeNode);
begin
  if Value <> nil then
  begin
    Value.HasChildren := True;
    Repaint(Value);
  end;
end;

function TwwTreeNodes.InsertObject(Node: TwwTreeNode; const S: string;
  Ptr: Pointer): TwwTreeNode;
var
  Item, ItemId: HTreeItem;
  Parent: TwwTreeNode;
  AddMode: TwwAddMode;
begin
  Result := Owner.CreateNode;
  try
    Item := nil;
    ItemId := nil;
    Parent := nil;
    AddMode := wwtaInsert;
    if Node <> nil then
    begin
      Parent := Node.Parent;
      if Parent <> nil then Item := Parent.ItemId;
      Node := Node.GetPrevSibling;
      if Node <> nil then ItemId := Node.ItemId
      else AddMode := wwtaAddFirst;
    end;
    Result.Data := Ptr;
    Result.Text := S;
    Item := AddItem(Item, ItemId, CreateItem(Result), AddMode);
    if Item = nil then
      raise EOutOfResources.Create(sInsertError);
    Result.FItemId := Item;
    AddedNode(Parent);
    if not Owner.MultiSelectCheckboxNeeded(Result) then
       Result.StateIndex:= -1; { 5/15/98 - Required since its not initialized to -1}
  except
    Result.Free;
    raise;
  end;
end;

function TwwTreeNodes.InternalAddObject(Node: TwwTreeNode; const S: string;
  Ptr: Pointer; AddMode: TwwAddMode): TwwTreeNode;
var
  Item: HTreeItem;
begin
  Result := Owner.CreateNode;
  try
    if Node <> nil then Item := Node.ItemId
    else Item := nil;
    Result.Data := Ptr;
    Result.Text := S;
    Item := AddItem(Item, nil, CreateItem(Result), AddMode);
    if Item = nil then
      raise EOutOfResources.Create(sInsertError);
    Result.FItemId := Item;
    AddedNode(Node);
    if not Owner.MultiSelectCheckboxNeeded(Result) then
       Result.StateIndex:= -1; { 5/15/98 - Required since its not initialized to -1}
  except
    Result.Free;
    raise;
  end;
end;

function TwwTreeNodes.CreateItem(Node: TwwTreeNode): TTVItem;
begin
  Node.FInTree := True;
  with Result do
  begin
    mask := TVIF_TEXT or TVIF_PARAM or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
    lParam := Longint(Node);
    pszText := LPSTR_TEXTCALLBACK;
    iImage := I_IMAGECALLBACK;
    iSelectedImage := I_IMAGECALLBACK;
  end;
end;

function TwwTreeNodes.AddItem(Parent, Target: HTreeItem;
  const Item: TTVItem; AddMode: TwwAddMode): HTreeItem;
var
  InsertStruct: TTVInsertStruct;
begin
  ClearCache;
  with InsertStruct do
  begin
    hParent := Parent;
    case AddMode of
      wwtaAddFirst:
        hInsertAfter := TVI_FIRST;
      wwtaAdd:
        hInsertAfter := TVI_LAST;
      wwtaInsert:
        hInsertAfter := Target;
    end;
  end;
  InsertStruct.item := Item;
  FOwner.FChangeTimer.Enabled := False;
  Result := TreeView_InsertItem(Handle, InsertStruct);
end;

function TwwTreeNodes.GetFirstNode: TwwTreeNode;
begin
  Result := GetNode(TreeView_GetRoot(Handle));
end;

function TwwTreeNodes.GetNodeFromIndex(Index: Integer): TwwTreeNode;
var
  I: Integer;
begin
  if Index < 0 then TreeViewError(sInvalidIndex);
  if (FNodeCache.CacheNode <> nil) and (Abs(FNodeCache.CacheIndex - Index) <= 1) then
  begin
    with FNodeCache do
    begin
      if Index = CacheIndex then Result := CacheNode
      else if Index < CacheIndex then Result := CacheNode.GetPrev
      else Result := CacheNode.GetNext;
    end;
  end
  else begin
    Result := GetFirstNode;
    I := Index;
    while (I <> 0) and (Result <> nil) do
    begin
      Result := Result.GetNext;
      Dec(I);
    end;
  end;
  if Result = nil then TreeViewError(sInvalidIndex);
  FNodeCache.CacheNode := Result;
  FNodeCache.CacheIndex := Index;
end;

function TwwTreeNodes.GetNode(ItemId: HTreeItem): TwwTreeNode;
var
  Item: TTVItem;
begin
  with Item do
  begin
    hItem := ItemId;
    mask := TVIF_PARAM;
  end;
  if TreeView_GetItem(Handle, Item) then Result := TwwTreeNode(Item.lParam)
  else Result := nil;
end;

procedure TwwTreeNodes.SetItem(Index: Integer; Value: TwwTreeNode);
begin
  GetNodeFromIndex(Index).Assign(Value);
end;

procedure TwwTreeNodes.BeginUpdate;
begin
  if FUpdateCount = 0 then SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TwwTreeNodes.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then Owner.Refresh;
end;

procedure TwwTreeNodes.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then SetUpdateState(False);
end;

procedure TwwTreeNodes.Assign(Source: TPersistent);
var
  TreeNodes: TwwTreeNodes;
  MemStream: TMemoryStream;
begin
  ClearCache;

  { 12/1/98 (RSW) Clear treeview display }
  SendMessage(Owner.Handle, WM_ERASEBkgnd, Owner.Canvas.Handle, 0);

  if Source is TwwTreeNodes then
  begin
    Owner.FStreamVersion:= 1;

    TreeNodes := TwwTreeNodes(Source);
    Clear;
    MemStream := TMemoryStream.Create;
    try
      TreeNodes.WriteData(MemStream);
      MemStream.Position := 0;
      ReadData(MemStream);
    finally
      MemStream.Free;
    end;
  end
  else inherited Assign(Source);

  if Count>0 then Owner.Selected:= Owner.Items[0];
  Owner.invalidate;
  // RSW - 1/13/99 Make sure some node is selected as the treeview common control
  // has problems in repainting in certain cases if no control has the selection

end;

procedure TwwTreeNodes.DefineProperties(Filer: TFiler);
{
  function WriteNodes: Boolean;
  var
    I: Integer;
    Nodes: TwwTreeNodes;
  begin
    Nodes := TwwTreeNodes(Filer.Ancestor);
    if Nodes = nil then
      Result := Count > 0
    else if Nodes.Count <> Count then
      Result := True
    else
    begin
      Result := False;
      for I := 0 to Count - 1 do
      begin
        Result := not Item[I].IsEqual(Nodes[I]);
        if Result then Break;
      end
    end;
  end;
}
begin
  inherited DefineProperties(Filer);
//  Filer.DefineBinaryProperty('Data', ReadData, WriteData, WriteNodes);
  Filer.DefineProperty('StreamVersion',
     ReadStreamVersion, WriteStreamVersion, True);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, True);
end;

procedure TwwTreeNodes.ReadStreamVersion(Reader: TReader);
begin
  Owner.FStreamVersion:= Reader.ReadInteger;
end;

procedure TwwTreeNodes.WriteStreamVersion(Writer: TWriter);
begin
   Owner.FStreamVersion:= 1;
   Writer.WriteInteger(Owner.StreamVersion)
end;



procedure TwwTreeNodes.ReadData(Stream: TStream);
var
  I, Count: Integer;
  NodeInfo: TwwNodeInfo;
begin
  FillChar(NodeInfo, SizeOf(TwwNodeInfo), 0);
  Clear;
  Stream.ReadBuffer(Count, SizeOf(Count));
  for I := 0 to Count - 1 do
    Add(nil, '').ReadData(Stream, @NodeInfo);
  Owner.FStreamVersion:= 1;
end;

procedure TwwTreeNodes.WriteData(Stream: TStream);
var
  I: Integer;
  Node: TwwTreeNode;
  NodeInfo: TwwNodeInfo;
begin
  Owner.FStreamVersion:=1;
  I := 0;
  Node := GetFirstNode;
  while Node <> nil do
  begin
    Inc(I);
    Node := Node.GetNextSibling;
  end;
  Stream.WriteBuffer(I, SizeOf(I));
  Node := GetFirstNode;
  while Node <> nil do
  begin
    Node.WriteData(Stream, @NodeInfo);
    Node := Node.GetNextSibling;
  end;
end;

procedure TwwTreeNodes.ClearCache;
begin
  FNodeCache.CacheNode := nil;
end;

{type
  TTreeStrings = class(TStrings)
  private
    FOwner: TwwTreeNodes;
  protected
    function Get(Index: Integer): string; override;
    function GetBufStart(Buffer: PChar; var Level: Integer): PChar;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AOwner: TwwTreeNodes);
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure LoadTreeFromStream(Stream: TStream);
    procedure SaveTreeToStream(Stream: TStream);
    property Owner: TwwTreeNodes read FOwner;
  end;

constructor TTreeStrings.Create(AOwner: TwwTreeNodes);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TTreeStrings.Get(Index: Integer): string;
const
  TabChar = #9;
var
  Level, I: Integer;
  Node: TwwTreeNode;
begin
  Result := '';
  Node := Owner.GetNodeFromIndex(Index);
  Level := Node.Level;
  for I := 0 to Level - 1 do Result := Result + TabChar;
  Result := Result + Node.Text;
end;

function TTreeStrings.GetBufStart(Buffer: PChar; var Level: Integer): PChar;
begin
  Level := 0;
  while Buffer^ in [' ', #9] do
  begin
    Inc(Buffer);
    Inc(Level);
  end;
  Result := Buffer;
end;

function TTreeStrings.GetObject(Index: Integer): TObject;
begin
  Result := Owner.GetNodeFromIndex(Index).Data;
end;

procedure TTreeStrings.PutObject(Index: Integer; AObject: TObject);
begin
  Owner.GetNodeFromIndex(Index).Data := AObject;
end;

function TTreeStrings.GetCount: Integer;
begin
  Result := Owner.Count;
end;

procedure TTreeStrings.Clear;
begin
  Owner.Clear;
end;

procedure TTreeStrings.Delete(Index: Integer);
begin
  Owner.GetNodeFromIndex(Index).Delete;
end;

procedure TTreeStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Owner.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then Owner.Owner.Refresh;
end;

function TTreeStrings.Add(const S: string): Integer;
var
  Level, OldLevel, I: Integer;
  NewStr: string;
  Node: TwwTreeNode;
begin
  Result := GetCount;
  if (Length(S) = 1) and (S[1] = Chr($1A)) then Exit;
  Node := nil;
  OldLevel := 0;
  NewStr := GetBufStart(PChar(S), Level);
  if Result > 0 then
  begin
    Node := Owner.GetNodeFromIndex(Result - 1);
    OldLevel := Node.Level;
  end;
  if (Level > OldLevel) or (Node = nil) then
  begin
    if Level - OldLevel > 1 then TreeViewError(sInvalidLevel);
  end
  else begin
    for I := OldLevel downto Level do
    begin
      Node := Node.Parent;
      if (Node = nil) and (I - Level > 0) then
        TreeViewError(sInvalidLevel);
    end;
  end;
  Owner.AddChild(Node, NewStr);
end;

procedure TTreeStrings.Insert(Index: Integer; const S: string);
begin
  with Owner do
    Insert(GetNodeFromIndex(Index), S);
end;

procedure TTreeStrings.LoadTreeFromStream(Stream: TStream);
var
  List: TStringList;
  ANode, NextNode: TwwTreeNode;
  ALevel, i: Integer;
  CurrStr: string;
begin
  List := TStringList.Create;
  Owner.BeginUpdate;
  try
    try
      Clear;
      List.LoadFromStream(Stream);
      ANode := nil;
      for i := 0 to List.Count - 1 do
      begin
        CurrStr := GetBufStart(PChar(List[i]), ALevel);
        if ANode = nil then
          ANode := Owner.AddChild(nil, CurrStr)
        else if ANode.Level = ALevel then
          ANode := Owner.AddChild(ANode.Parent, CurrStr)
        else if ANode.Level = (ALevel - 1) then
          ANode := Owner.AddChild(ANode, CurrStr)
        else if ANode.Level > ALevel then
        begin
          NextNode := ANode.Parent;
          while NextNode.Level > ALevel do
            NextNode := NextNode.Parent;
          ANode := Owner.AddChild(NextNode.Parent, CurrStr);
        end
        else TreeViewErrorFmt(sInvalidLevelEx, [ALevel, CurrStr]);
      end;
    finally
      Owner.EndUpdate;
      List.Free;
    end;
  except
    Owner.Owner.Invalidate;  // force repaint on exception
    raise;
  end;
end;

procedure TTreeStrings.SaveTreeToStream(Stream: TStream);
const
  TabChar = #9;
  EndOfLine = #13#10;
var
  i: Integer;
  ANode: TwwTreeNode;
  NodeStr: string;
begin
  if Count > 0 then
  begin
    ANode := Owner[0];
    while ANode <> nil do
    begin
      NodeStr := '';
      for i := 0 to ANode.Level - 1 do NodeStr := NodeStr + TabChar;
      NodeStr := NodeStr + ANode.Text + EndOfLine;
      Stream.Write(Pointer(NodeStr)^, Length(NodeStr));
      ANode := ANode.GetNext;
    end;
  end;
end;
}

{ TwwCustomTreeView }

constructor TwwCustomTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csCaptureMouse] + [csDisplayDragImage, csReflector];
  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  NodeClass := TwwTreeNode;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FTreeNodes := TwwTreeNodes.Create(Self);
  FBorderStyle := bsSingle;
//  FShowButtons := True;
//  FShowRoot := True;
//  FShowLines := True;
//  FHideSelection := True;
  FOptions:= [wwtvoExpandOnDblClk, wwtvoShowButtons, wwtvoShowRoot,
    wwtvoShowLines, wwtvoHideSelection, wwtvoToolTips];
  FSaveIndent := -1;
  FChangeTimer := TTimer.Create(Self);
  FChangeTimer.Enabled := False;
  FChangeTimer.Interval := 0;
  FChangeTimer.OnTimer := OnChangeTimer;
//  FToolTips := False;
  {$Warnings Off}
  FEditInstance := MakeObjectInstance(EditWndProc);
  {$Warnings On}
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FStateChangeLink := TChangeLink.Create;
  FStateChangeLink.OnChange := ImageListChange;

//  FOptions := [tvoExpandOnDblClk];
  FMultiSelectAttributes:= TwwTVMultiSelectAttributes.create(self);
  FMultiSelectList:= TList.create;
  FBorderWidth := GetSystemMetrics(SM_CXBORDER);
  if FFixBugImageList=nil then begin
     FFixBugImageList:= TImageList.create(nil);
     FFixBugImageList.Width:= FixBugImageListSize;
     FFixBugImageList.Height:= FixBugImageListSize;
  end;
  inc(RefCount); { 2/28/00 - Always increment refcount}

{  FPaintBitmap:= TBitmap.create;
  FPaintCanvas:= TwwCanvas(FPaintBitmap.Canvas);
}
  FLineColor:= clBtnShadow;
  FInactiveFocusColor:= clBtnFace;
  FReadOnly:= False;

  Patch:= VarArrayCreate([0, 0], varVariant);
  Patch[0]:= False;
//  Patch[1]:= 0; { Used by TwwTreeNode ReadData }

end;

destructor TwwCustomTreeView.Destroy;
begin
  FPaintBitmap.Free;

  FMultiSelectList.Free;
  FMultiSelectAttributes.Free;
  dec(RefCount);
  if RefCount<=0 then
  begin
     FFixBugImageList.Free;
     FFixBugimageList:=nil;
  end;

//  Items.Free;
  FTreeNodes.Free;
  FTreeNodes:= nil;
  FChangeTimer.Free;
  FSaveItems.Free;
  FDragImage.Free;
  FMemStream.Free;
  {$Warnings Off}
  FreeObjectInstance(FEditInstance);
  {$Warnings On}
  FImageChangeLink.Free;
  FStateChangeLink.Free;
  FCanvas.Free;

  inherited Destroy;
end;

procedure TwwCustomTreeView.CreateParams(var Params: TCreateParams);
const
  TVS_TRACKSELECT         = $0200;
  TVS_NOTOOLTIPS          = $0080;
  TVS_INFOTIP             = $0800;
  TVS_SINGLEEXPAND        = $0400;
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
  LineStyles: array[Boolean] of DWORD = (0, TVS_HASLINES);
  RootStyles: array[Boolean] of DWORD = (0, TVS_LINESATROOT);
  ButtonStyles: array[Boolean] of DWORD = (0, TVS_HASBUTTONS);
  EditStyles: array[Boolean] of DWORD = (TVS_EDITLABELS, 0);
  HideSelections: array[Boolean] of DWORD = (TVS_SHOWSELALWAYS, 0);
  DragStyles: array[TDragMode] of DWORD = (TVS_DISABLEDRAGDROP, 0);
  HotTrackStyles: array[Boolean] of DWORD = (0, TVS_TRACKSELECT);
  ToolTipStyles: array[Boolean] of DWORD = (TVS_NOTOOLTIPS, TVS_NOTOOLTIPS);
  AutoExpandStyles: array[Boolean] of DWORD = (0, TVS_SINGLEEXPAND);
  {$ifdef wwDelphi4Up}
  RTLStyles: array[Boolean] of DWORD = (0, TVS_RTLREADING);
  RowSelectStyles: array[Boolean] of DWORD = (0, TVS_FULLROWSELECT);
  {$endif}
  TVS_NOSCROLL = $2000;
begin
  InitCommonControl(ICC_TREEVIEW_CLASSES);
  inherited CreateParams(Params);
  CreateSubClass(Params, WC_TREEVIEW);
  with Params do
  begin
    Style := Style or LineStyles[wwtvoShowLines in Options] or BorderStyles[FBorderStyle] or
      RootStyles[wwtvoShowRoot in Options] or ButtonStyles[wwtvoShowButtons in Options] or
      EditStyles[not (wwtvoEditText in Options)] or HideSelections[not (wwtvoHideSelection in Options)] or
      DragStyles[DragMode] or
      ToolTipStyles[False] or // FToolTips] or
      HotTrackStyles[wwtvoHotTrack in Options] or
      AutoExpandStyles[FAutoExpand]
      {$ifdef wwDelphi4Up}
       or
      RTLStyles[UseRightToLeftReading]
      {$endif};
    if Ctl3D and NewStyleControls and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
    end;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
  Params.Style := Params.Style or TVS_CHECKBOXES;

end;

function TreeView_SetBkColor(hwnd: HWND; clr: COLORREF): COLORREF;
const
  TVM_SETBKCOLOR              = TV_FIRST + 29;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_SETBKCOLOR, 0, LPARAM(clr)));
end;

function TreeView_SetTextColor(hwnd: HWND; clr: COLORREF): COLORREF;
const
  TVM_SETTEXTCOLOR              = TV_FIRST + 30;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_SETTEXTCOLOR, 0, LPARAM(clr)));
end;

procedure TwwCustomTreeView.CreateWnd;
var
  DC: HDC;
  SaveFont: HFont;
  TextSize: TSize;
begin
  FStateChanging := False;
  inherited CreateWnd;
  TreeView_SetBkColor(Handle, ColorToRGB(Color));
  TreeView_SetTextColor(Handle, ColorToRGB(Font.Color));
  if FMemStream <> nil then
  begin
    Items.ReadData(FMemStream);
    FMemStream.Destroy;
    FMemStream := nil;
    SetTopItem(Items.GetNodeFromIndex(FSaveTopIndex));
    FSaveTopIndex := 0;
    SetSelection(Items.GetNodeFromIndex(FSaveIndex));
    FSaveIndex := 0;
  end;
  if FSaveIndent <> -1 then Indent := FSaveIndent;
  if (Images <> nil) and Images.HandleAllocated then
    SetImageList(Images.Handle, TVSIL_NORMAL);
  if (StateImages <> nil) and StateImages.HandleAllocated then
    SetImageList(StateImages.Handle, TVSIL_STATE);

  { Create StateImageList if not assigned }
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextExtentPoint32(DC, 'A', 1, TextSize);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  FFixBugImageList.Width:= wwMin(TextSize.cy+2, FixBugImageListSize);
  FFixBugImageList.Width:= wwMax(FixBugImageListSize, 16); { 2/1/99}
  FFixBugImageList.Height:= FFixBugImageList.Width;

  if HandleAllocated and (StateImages=Nil) then
     TreeView_SetImageList(Handle, FFixBugImageList.Handle, TVSIL_STATE);

  { 5/5/99 - Workaround for TreeView common control problem where this property is reset }
  if not (wwtvoHideSelection in Options) and HandleAllocated then
     SetComCtlStyle(Self, TVS_SHOWSELALWAYS, True);


end;

procedure TwwCustomTreeView.DestroyWnd;
var
  Node: TwwTreeNode;
  parentIsFrame: boolean;
begin
  FStateChanging := True;
  {$ifdef wwDelphi5Up}
  parentIsFrame:= parent is TCustomFrame;
  {$else}
  parentIsFrame:= false;
  {$endif}
  if (Items.Count > 0) and
    { 1/5/2000 - Fix TFrame duplicate streaming problem }
     not (parentIsFrame and (csLoading in ComponentState)) then
  begin
    FMemStream := TMemoryStream.Create;
    Items.WriteData(FMemStream);
    FMemStream.Position := 0;
    Node := GetTopItem;
    if Node <> nil then FSaveTopIndex := Node.AbsoluteIndex;
    Node := Selected;
    if Node <> nil then FSaveIndex := Node.AbsoluteIndex;
  end;
  FSaveIndent := Indent;
  inherited DestroyWnd;
end;

procedure TwwCustomTreeView.EditWndProc(var Message: TMessage);
var DisplayRect: TRect;
begin
  try
    with Message do
    begin
      case Msg of
        WM_WINDOWPOSCHANGED, WM_SIZE:
          begin
            If (EditNode<>Nil) and (Images<>Nil) and (EditNode.imageindex=-2) then
            begin
              DisplayRect:= EditNode.DisplayRect(True);
              SetWindowPos(FEditHandle, 0, wwmax(DisplayRect.Left, 0),DisplayRect.Top,0,0, //sp.x + DisplayRect.Left, sp.y + DisplayRect.Top, 0, 0,
                SWP_NOZORDER OR SWP_NOSIZE OR SWP_NOACTIVATE);
              ValidateRect(Handle, nil);
//            Message.Result:= 1;
            end
            else if (EditNode<>Nil) and (Msg=WM_SIZE) then begin
               if (Patch[0]=False) then
                  ValidateRect(Handle, nil) // RSW (4/8/99 } Prevent flicker when edit box size changes
               else Patch[0]:= False;
            end
          end;


        WM_KEYDOWN,
        WM_SYSKEYDOWN: if DoKeyDown(TWMKey(Message)) then Exit;
        WM_CHAR: if DoKeyPress(TWMKey(Message)) then Exit;
        WM_KEYUP,
        WM_SYSKEYUP: if DoKeyUp(TWMKey(Message)) then Exit;
        CN_KEYDOWN,
        CN_CHAR, CN_SYSKEYDOWN,
        CN_SYSCHAR:
          begin
            WndProc(Message);
            Exit;
          end;
      end;
      Result := CallWindowProc(FDefEditProc, FEditHandle, Msg, WParam, LParam);
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TwwCustomTreeView.CMColorChanged(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure TwwCustomTreeView.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if FBorderStyle = bsSingle then RecreateWnd;
end;

procedure TwwCustomTreeView.CMFontChanged(var Message: TMessage);
begin
  inherited;
  TreeView_SetTextColor(Handle, ColorToRGB(Font.Color));
end;

procedure TwwCustomTreeView.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    Message.Msg := WM_SYSCOLORCHANGE;
    DefaultHandler(Message);
  end;
end;

function TwwCustomTreeView.AlphaSort: Boolean;
var
  Node: TwwTreeNode;
begin
  if HandleAllocated then
  begin
    Result := CustomSort(nil, 0);
    Node := FTreeNodes.GetFirstNode;
    while Node <> nil do
    begin
      if Node.HasChildren then Node.AlphaSort;
      Node := Node.GetNext;
    end;
  end
  else
    Result := False;
end;

function TwwCustomTreeView.CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
var
  SortCB: TTVSortCB;
//  Node: TwwTreeNode;
begin
  Result := False;
  if HandleAllocated then
  begin
    with SortCB do
    begin
      if not Assigned(SortProc) then lpfnCompare := @DefaultTreeViewSort
      else lpfnCompare := SortProc;
      hParent := TVI_ROOT;
      lParam := Data;
      Result := TreeView_SortChildrenCB(Handle, SortCB, 0);
    end;
{    Node := FTreeNodes.GetFirstNode;
    while Node <> nil do
    begin
      if Node.HasChildren then Node.CustomSort(SortProc, Data);
      Node := Node.GetNext;
    end;}
    Items.ClearCache;
  end;
end;

procedure TwwCustomTreeView.SetAutoExpand(Value: Boolean);
const
  TVS_SINGLEEXPAND        = $0400;
begin
  if FAutoExpand <> Value then
  begin
    FAutoExpand := Value;
    SetComCtlStyle(Self, TVS_SINGLEEXPAND, Value);
  end;
end;

{
procedure TwwCustomTreeView.SetHotTrack(Value: Boolean);
const
  TVS_TRACKSELECT         = $0200;
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    SetComCtlStyle(Self, TVS_TRACKSELECT, Value);
  end;
end;
}

{procedure TwwCustomTreeView.SetRowSelect(Value: Boolean);
const
  TVS_FULLROWSELECT       = $1000;
begin
  if (tvoRowSelect in Options) <> Value then
  begin
    FRowSelect := Value;
    SetComCtlStyle(Self, TVS_FULLROWSELECT, Value);
  end;
end;
}
{procedure TwwCustomTreeView.SetToolTips(Value: Boolean);
const TVS_NOTOOLTIPS          = $0080;
begin
  if FToolTips <> Value then
  begin
    FToolTips := Value;
    SetComCtlStyle(Self, TVS_NOTOOLTIPS, not Value);
  end;
end;
}
procedure TwwCustomTreeView.SetSortType(Value: TwwSortType);
begin
  if SortType <> Value then
  begin
    FSortType := Value;
    if ((SortType in [wwtstData, wwtstBoth]) and Assigned(OnCompare)) or
      (SortType in [wwtstText, wwtstBoth]) then
      AlphaSort;
  end;
end;

procedure TwwCustomTreeView.SetBorderStyle(Value: TBorderStyle);
begin
  if BorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TwwCustomTreeView.SetDragMode(Value: TDragMode);
begin
  if Value <> DragMode then
    SetComCtlStyle(Self, TVS_DISABLEDRAGDROP, Value = dmManual);
  inherited;
end;

{
procedure TwwCustomTreeView.SetButtonStyle(Value: Boolean);
begin
  if ShowButtons <> Value then
  begin
    FShowButtons := Value;
    SetComCtlStyle(Self, TVS_HASBUTTONS, Value);
  end;
end;
}

{
procedure TwwCustomTreeView.SetLineStyle(Value: Boolean);
begin
  if ShowLines <> Value then
  begin
    FShowLines := Value;
    SetComCtlStyle(Self, TVS_HASLINES, Value);
    SetComCtlStyle(Self, TVS_HASBUTTONS, Value);
  end;
end;
}
{
procedure TwwCustomTreeView.SetRootStyle(Value: Boolean);
begin
  if ShowRoot <> Value then
  begin
    FShowRoot := Value;
  end;
end;
}
procedure TwwCustomTreeView.SetReadOnly(Value: Boolean);
begin
  if ReadOnly <> Value then
  begin
    FReadOnly := Value;

    if FReadOnly then
    begin
       if (wwtvoEditText in Options) then SetComCtlStyle(Self, TVS_EDITLABELS, False);
    end
    else begin
       if (wwtvoEditText in Options) then SetComCtlStyle(Self, TVS_EDITLABELS, True);
    end;
  end;


end;

{procedure TwwCustomTreeView.SetHideSelection(Value: Boolean);
begin
  if HideSelection <> Value then
  begin
    FHideSelection := Value;
    SetComCtlStyle(Self, TVS_SHOWSELALWAYS, not Value);
    Invalidate;
  end;
end;
}
function TwwCustomTreeView.GetNodeAt(X, Y: Integer): TwwTreeNode;
var
  HitTest: TTVHitTestInfo;
begin
  with HitTest do
  begin
    pt.X := X;
    pt.Y := Y;
    if TreeView_HitTest(Handle, HitTest) <> nil then
      Result := Items.GetNode(HitTest.hItem)
    else Result := nil;
  end;
end;

function TwwCustomTreeView.GetHitTestInfoAt(X, Y: Integer): TwwHitTests;
var
  HitTest: TTVHitTestInfo;
  DisplayRect: TRect;
  Node: TwwTreeNode;
begin
  Result := [];
  with HitTest do
  begin
    pt.X := X;
    pt.Y := Y;
    TreeView_HitTest(Handle, HitTest);

    if (flags and TVHT_ABOVE) <> 0 then Include(Result, wwhtAbove);
    if (flags and TVHT_BELOW) <> 0 then Include(Result, wwhtBelow);
    if (flags and TVHT_NOWHERE) <> 0 then Include(Result, wwhtNowhere);
    if (flags and TVHT_ONITEM) <> 0 then Include(Result, wwhtOnItem);
    if (flags and TVHT_ONITEMBUTTON) <> 0 then Include(Result, wwhtOnButton);
    if (flags and TVHT_ONITEMICON) <> 0 then Include(Result, wwhtOnIcon);
    if (flags and TVHT_ONITEMINDENT) <> 0 then Include(Result, wwhtOnIndent);
    if (flags and TVHT_ONITEMLABEL) <> 0 then Include(Result, wwhtOnLabel);
    if (flags and TVHT_ONITEMRIGHT) <> 0 then Include(Result, wwhtOnRight);
    if (flags and TVHT_ONITEMSTATEICON) <> 0 then Include(Result, wwhtOnStateIcon);
    if (flags and TVHT_TOLEFT) <> 0 then Include(Result, wwhtToLeft);
    if (flags and TVHT_TORIGHT) <> 0 then Include(Result, wwhtToRight);

    if (wwhtOnItem in Result) then
    begin
       node:= GetNodeAt(X, Y);
       if (Images<>Nil) and (node<>nil) and (node.imageindex=-2) then
       begin
          DisplayRect:= Node.DisplayRect(True);
          if (x>=DisplayRect.Left) and (x<=DisplayRect.Right) then
          begin
             Include(Result, wwhtOnLabel);
             Exclude(Result, wwhtOnIcon);
          end
       end
    end;

  end;
end;

procedure TwwCustomTreeView.SeTwwTreeNodes(Value: TwwTreeNodes);
begin
  Items.Assign(Value);
end;

procedure TwwCustomTreeView.SetIndent(Value: Integer);
begin
  if Value <> Indent then TreeView_SetIndent(Handle, Value);
end;

function TwwCustomTreeView.GetIndent: Integer;
begin
  Result := TreeView_GetIndent(Handle)
end;

procedure TwwCustomTreeView.FullExpand;
var
  Node: TwwTreeNode;
begin
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.Expand(True);
    Node := Node.GetNextSibling;
  end;
  ResetStateImages;
end;

procedure TwwCustomTreeView.FullCollapse;
var
  Node: TwwTreeNode;
begin
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.Collapse(True);
    Node := Node.GetNextSibling;
  end;
end;

procedure TwwCustomTreeView.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then FullExpand;
end;

function TwwCustomTreeView.GetTopItem: TwwTreeNode;
begin
  if HandleAllocated then
    Result := Items.GetNode(TreeView_GetFirstVisible(Handle))
  else Result := nil;
end;

procedure TwwCustomTreeView.SetTopItem(Value: TwwTreeNode);
begin
  if HandleAllocated and (Value <> nil) then
    TreeView_SelectSetFirstVisible(Handle, Value.ItemId);
end;

procedure TwwCustomTreeView.OnChangeTimer(Sender: TObject);
begin
  FChangeTimer.Enabled := False;
  Change(TwwTreeNode(FChangeTimer.Tag));
end;

function TwwCustomTreeView.GetSelection: TwwTreeNode;
begin
  if HandleAllocated then
  begin
     Result := Items.GetNode(TreeView_GetSelection(Handle));
  end
  else Result := nil;
end;

procedure TwwCustomTreeView.SetSelection(Value: TwwTreeNode);
begin
  if Value <> nil then Value.Selected := True
  else TreeView_SelectItem(Handle, nil);
end;

procedure TwwCustomTreeView.SetChangeDelay(Value: Integer);
begin
  FChangeTimer.Interval := Value;
end;

function TwwCustomTreeView.GetChangeDelay: Integer;
begin
  Result := FChangeTimer.Interval;
end;

function TwwCustomTreeView.GetDropTarget: TwwTreeNode;
begin
  if HandleAllocated then
  begin
    Result := Items.GetNode(TreeView_GetDropHilite(Handle));
    if Result = nil then Result := FLastDropTarget;
  end
  else Result := nil;
end;

procedure TwwCustomTreeView.SetDropTarget(Value: TwwTreeNode);
begin
  if HandleAllocated then
    if Value <> nil then Value.DropTarget := True
    else TreeView_SelectDropTarget(Handle, nil);
end;

function TwwCustomTreeView.GetNodeFromItem(const Item: TTVItem): TwwTreeNode;
begin
  with Item do
    if (state and TVIF_PARAM) <> 0 then Result := Pointer(lParam)
    else Result := Items.GetNode(hItem);
end;

function TwwCustomTreeView.IsEditing: Boolean;
var
  ControlHand: HWnd;
begin
  ControlHand := TreeView_GetEditControl(Handle);
  Result := (ControlHand <> 0) and IsWindowVisible(ControlHand);
end;

function fcWinItemStateTokwItemState(WinItemState: UINT): TwwItemStates;
begin
  result := [];
  if WinItemState and CDIS_SELECTED <> 0 then include(result, wwisSelected);
  if WinItemState and CDIS_GRAYED <> 0 then include(result, wwisGrayed);
  if WinItemState and CDIS_DISABLED <> 0 then include(result, wwisDisabled);
  if WinItemState and CDIS_CHECKED <> 0 then include(result, wwisChecked);
  if WinItemState and CDIS_FOCUS <> 0 then include(result, wwisFocused);
  if WinItemState and CDIS_DEFAULT <> 0 then include(result, wwisDefault);
  if WinItemState and CDIS_HOT <> 0 then include(result, wwisHot);
  if WinItemState and CDIS_MARKED <> 0 then include(result, wwisMarked);
  if WinItemState and CDIS_INDETERMINATE <> 0 then include(result, wwisIndeterminate);
end;

procedure TwwCustomTreeView.PaintItem(node: TwwTreeNode);
begin
end;


procedure TwwCustomTreeView.CNNotify(var Message: TWMNotify);
//const
//  TVN_BEGINLABELEDIT = TVN_FIRST-10;
var
  Node: TwwTreeNode;
  MousePos: TPoint;
  R: TRect;
  DefaultDraw: Boolean;
  TmpItem: TTVItem;
  ANode: TwwTreeNode;
  TempText: string; // -ksw (Added for tvoUnderscoreAllowed option)
begin
  with Message do
    case NMHdr^.code of
      NM_CUSTOMDRAW:
        with PNMCustomDraw(NMHdr)^ do
        begin
          Result := CDRF_DODEFAULT;
          if dwDrawStage = CDDS_PREPAINT then
          begin
            FIndent := TreeView_GetIndent(self.Handle);

            if True then // IsCustomDrawn(dtControl, cdPrePaint) then
            begin
              FCanvas.Handle := hdc;
              Canvas.Font := Font;
              Canvas.Brush := Brush;
              R := ClientRect;
              BeginPainting;
              DisplayedItems:= 0;

{              DefaultDraw := CustomDraw(R, cdPrePaint);
              if not DefaultDraw then
              begin
                Result := CDRF_SKIPDEFAULT;
                Exit;
              end;}
            end;
            if True then //IsCustomDrawn(dtControl, cdPostPaint) then
              Result := CDRF_NOTIFYPOSTPAINT;
            if True then //IsCustomDrawn(dtItem, cdPrePaint) then
              Result := Result or CDRF_NOTIFYITEMDRAW else
              Result := Result or CDRF_DODEFAULT;
          end
          else if dwDrawStage = CDDS_ITEMPREPAINT then
          begin
            FillChar(TmpItem, SizeOf(TmpItem), 0);
            TmpItem.hItem := HTREEITEM(dwItemSpec);
            Node := GetNodeFromItem(TmpItem);
            inc(DisplayedItems);
            if Node <> nil then
            begin
//              {$ifdef wwdelphi4up}
//              FCanvas.Handle := hdc;
//              {$else}
//              FCanvas.Handle := dc;
//              {$endif}
              Canvas.Font := Font;
              Canvas.Brush := Brush;
              { Unlike the list view, the tree view doesn't override the text
                foreground and background colors of selected items. }
              if uItemState and CDIS_SELECTED <> 0 then
              begin
                Canvas.Font.Color := clHighlightText;
                Canvas.Brush.Color := clHighlight;
              end;
              Canvas.Font.OnChange := CanvasChanged;
              Canvas.Brush.OnChange := CanvasChanged;
              DefaultDraw:= True;
//              DefaultDraw := CustomDrawItem(Node,
//                TCustomDrawState(Word(uItemState)), cdPrePaint);
              Result := Result or CDRF_SKIPDEFAULT; {ww}

              if DefaultDraw and FCanvasChanged then
              begin
                FCanvasChanged := False;
                Canvas.Font.OnChange := nil;
                Canvas.Brush.OnChange := nil;
                with PNMTVCustomDraw(NMHdr)^ do
                begin
                  clrText := ColorToRGB(Canvas.Font.Color);
                  clrTextBk := ColorToRGB(Canvas.Brush.Color);
                  SelectObject(hdc, Canvas.Font.Handle);
                  Result := Result or CDRF_NEWFONT;
                end;
              end;

              if DefaultDraw then
              begin
                ANode := TwwTreeNode(lItemlParam);
                rc := ANode.DisplayRect(True);
                BeginItemPainting(ANode, rc,
                   fcWinItemStateTokwItemState(uItemState));
                EndItemPainting(TwwTreeNode(lItemlParam),
                   rc, fcWinItemStateTokwItemState(uItemState));
              end;

              PaintItem(Node);
//              FCanvas.Handle := 0;
              if True then //IsCustomDrawn(dtItem, cdPostPaint) then
                Result := Result or CDRF_NOTIFYPOSTPAINT;
            end;
          end

          else if dwDrawStage = CDDS_POSTPAINT then
          begin
//             if DisplayedItems>0 then
//             begin
                EndPainting;
                FCanvas.Handle := 0;
//             end;
          end;

        end;
      TVN_BEGINDRAG:
        begin
          FDragged := True;
          with PNMTreeView(NMHdr)^ do
            FDragNode := GetNodeFromItem(ItemNew);
        end;

      TVN_BEGINLABELEDIT:
        begin
{          Result:= 1;
          Node := GetNodeFromItem(PTVDispInfo(NMHdr)^.Item);
          DisplayRect:= Node.DisplayRect(True);
          if FEditControl=Nil then
          begin
             FEditControl:= TEdit.create(self);
          end;
          FEditControl.parent:= self;
          TEdit(FEditControl).AutoSize:= False;
          FEditControl.Left:= DisplayRect.Left;
          FEditControl.Top:= DisplayRect.Top;
          FEditControl.Height:= DisplayRect.Bottom - DisplayRect.Top;
          FEditControl.Visible:= True;
          TEdit(FEditControl).Text:= Node.Text;
//          TEdit(FEditControl).Ctl3d:= False;
          TEdit(FEditControl).SelectAll;
          TEdit(FEditControl).SetFocus;
          exit;
}
          with PTVDispInfo(NMHdr)^ do
            if Dragging or not CanEdit(GetNodeFromItem(item)) then
              Result := 1;
          if Result = 0 then
          begin
            FEditHandle := TreeView_GetEditControl(Handle);
            FDefEditProc := Pointer(GetWindowLong(FEditHandle, GWL_WNDPROC));
            SetWindowLong(FEditHandle, GWL_WNDPROC, LongInt(FEditInstance));

//            sp:= self.ClientToScreen(Point(0, 0));
            EditNode := GetNodeFromItem(PTVDispInfo(NMHdr)^.Item);
            Patch[0]:= True; { 6/14/99 - Skip Validate in EditWndProc }
//            DisplayRect:= Node.DisplayRect(True);
//
//            GetWindowRect(self.handle, r);
//            SetWindowPos(FEditHandle, 0, 1,1,0,0, //sp.x + DisplayRect.Left, sp.y + DisplayRect.Top, 0, 0,
//              SWP_NOZORDER OR SWP_NOSIZE OR SWP_NOACTIVATE);

          end;
        end;
      TVN_ENDLABELEDIT:
        begin
           Edit(PTVDispInfo(NMHdr)^.item);
        end;

      TVN_ITEMEXPANDING:
        if not FManualNotify then
        begin
          with PNMTreeView(NMHdr)^ do
          begin
            Node := GetNodeFromItem(ItemNew);
            if (action = TVE_EXPAND) and not CanExpand(Node) then
              Result := 1
            else if (action = TVE_COLLAPSE) and
              not CanCollapse(Node) then Result := 1;
          end;
        end;
      TVN_ITEMEXPANDED:
        if not FManualNotify then
        begin
          with PNMTreeView(NMHdr)^ do
          begin
            Node := GetNodeFromItem(itemNew);
            if (action = TVE_EXPAND) then Expand(Node)
            else if (action = TVE_COLLAPSE) then Collapse(Node);
          end;
        end;
      TVN_SELCHANGINGA, TVN_SELCHANGINGW:
        begin
          if SkipChangeMessages then exit; { RSW}
          if not CanChange(GetNodeFromItem(PNMTreeView(NMHdr)^.itemNew)) then
            Result := 1;
        end;
      TVN_SELCHANGEDA, TVN_SELCHANGEDW:
        begin
          if SkipChangeMessages then exit; { RSW}
          with PNMTreeView(NMHdr)^ do
            if FChangeTimer.Interval > 0 then
            with FChangeTimer do
            begin
              Enabled := False;
              Tag := Integer(GetNodeFromItem(itemNew));
              Enabled := True;
            end
            else
              Change(GetNodeFromItem(itemNew));
          end;
      TVN_DELETEITEM:
//          if not FStateChanging then   {5/16/2000 - PYW - Fix Memory leak from code left over from Delphi 3}
          begin
             Node := GetNodeFromItem(PNMTreeView(NMHdr)^.itemOld);
             if Node <> nil then
             begin
               Node.FItemId := nil;
               FChangeTimer.Enabled := False;
               if FStateChanging then Node.Delete
               else Items.Delete(Node);
             end;
          end;
      TVN_SETDISPINFO:
        with PTVDispInfo(NMHdr)^ do
        begin
          Node := GetNodeFromItem(item);
          if (Node <> nil) and ((item.mask and TVIF_TEXT) <> 0) then
            Node.Text := item.pszText;
        end;
      TVN_GETDISPINFO:
        with PTVDispInfo(NMHdr)^ do
        begin
          Node := GetNodeFromItem(item);
          if Node <> nil then
          begin
            TempText := Node.Text;  // -ksw  (Added for tvoUnderscoreAllowed option)
//            if tvoUnderscoreAllowed in FOptions then TempText := fcStripAmpersands(Node.Text);  // -ksw Added
            if (item.mask and TVIF_TEXT) <> 0 then
              StrLCopy(item.pszText, PChar(TempText), item.cchTextMax); // -ksw (Changed to use the TempText var)
            if (item.mask and TVIF_IMAGE) <> 0 then
            begin
              GetImageIndex(Node);
              item.iImage := Node.ImageIndex;
            end;
            if (item.mask and TVIF_SELECTEDIMAGE) <> 0 then
            begin
              GetSelectedIndex(Node);
              item.iSelectedImage := Node.SelectedIndex;
            end;
          end;
        end;
      NM_RCLICK:
        begin
            GetCursorPos(MousePos);
            with PointToSmallPoint(ScreenToClient(MousePos)) do
            begin
              FRClickNode := GetNodeAt(X, Y);
              if RightClickSelects and (FRClickNode<>nil) then Selected:= FRClickNode
              else begin
                 if FRClickNode<>nil then InvalidateNode(FRClickNode);
              end;
              InvalidateNoErase; { 4/21/99 - Workaround for Microsoft Tree bug which causes last
                                    node to not paint correctly  }
              Perform(WM_RBUTTONUP, 0, MakeLong(X, Y));

              {6/9/2000 - PYW - Prevent default button handling for treeview}
              Message.Result := 1;
            end;
        end;
//      TVN_BEGINLABELEDIT:
//        begin
//        end;

{      TVN_GETINFOTIP:
        begin
           if fcUpdatedComCtlVersion then begin
              ToolTipHandle:= SendMessage(Handle, TVM_GETTOOLTIPS, 0, 0);
              with PNMTVGetInfoTip(NMHdr)^ do
              begin
                 Node:= Items.GetNode(hItem);
                 HintTimer:= TTimer.create(self);
                 HintTimer.OnTimer:=HintTimerEvent;
                 HintTimer.Interval:=250;
                 HintTimer.Enabled:= True;
//                 strpcopy(pszText, Node.Text);
              end;
              if (ToolTipHandle <> 0) and (LastHintNode<>Node) then
              begin
                 FreeHintWindow;
                 sp:= self.ClientToScreen(Point(0, 0));
                 DisplayRect:= Node.DisplayRect(True);
                 R.Left:= DisplayRect.Left + sp.x - 1;
                 R.Top:= DisplayRect.Top + sp.y - 2;
                 R.Right:= R.Left + Canvas.TextWidth(Node.Text) + 6;
                 R.Bottom:= R.Top + Canvas.TextHeight(Node.Text) + 2;

                 if DisplayRect.Left+Canvas.TextWidth(Node.Text)>
                    GetEffectiveWidth then
                 begin
                    LastHintNode:= Node;
                    HintWindow:= CreateHintWindow;
                    HintWindow.ActivateHint(R, Node.Text);
                 end
                 else LastHintNode:= nil;
              end

           end;
        end;}
    end;
end;

function TwwCustomTreeView.GetDragImages: {$ifdef wwDelphi4Up}TDragImageList{$else}TCustomImageList{$endif};
begin
  if (FDragImage <> nil) and (FDragImage.Count > 0) then // Added check to make sure FDragImage is not nil -ksw (11/30/98)
    Result := FDragImage else
    Result := nil;
end;

procedure TwwCustomTreeView.WndProc(var Message: TMessage);
begin
{   if (csDesigning in ComponentState) then
   begin
      if (Message.Msg = wm_lbuttondown) or (Message.Msg = wm_vscroll) then
      begin
         ControlState := ControlState + [csLButtonDown];
         Dispatch(Message);
         exit;
      end;
   end;
}
  {$ifdef wwDelphi4Up}
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and
    (DragMode = dmAutomatic) and (DragKind = dkDrag) then
  begin
    if not IsControlMouseMsg(TWMMouse(Message)) then
    begin
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);
    end;
  end
  else inherited WndProc(Message);
  {$else}
  inherited WndProc(Message);
  {$endif}
end;

procedure TwwCustomTreeView.DoStartDrag(var DragObject: TDragObject);
var
  ImageHandle: HImageList;
  DragNode: TwwTreeNode;
  P: TPoint;
  OldDragObject: TDragObject;
begin
  OldDragObject:= DragObject;
  inherited DoStartDrag(DragObject);
  DragNode := FDragNode;
  FLastDropTarget := nil;
  FDragNode := nil;
  if DragNode = nil then
  begin
    GetCursorPos(P);
    with ScreenToClient(P) do DragNode := GetNodeAt(X, Y);
  end;
  if (DragNode <> nil) then
  begin
    ImageHandle := TreeView_CreateDragImage(Handle, DragNode.ItemId);
    if ImageHandle <> 0 then
    begin
      if (DragObject<>OldDragObject) and (DragObject<>nil) then exit; // 7/10/03 - Fix custom drag cursor problem

      // 2/3/2000 - Optimize imagelist usage so that resources are better
      if FDragImage=nil then
      begin
        {$ifdef wwDelphi4Up}
        FDragImage := TDragImageList.CreateSize(32, 32);
        {$else}
        FDragImage := TImageList.CreateSize(32, 32);
        {$endif}
      end;

      with FDragImage do
      begin
        Handle := ImageHandle;
        SetDragImage(0, 2, 2);
      end;

    end
  end;
end;

procedure TwwCustomTreeView.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  FLastDropTarget := nil;
end;

procedure TwwCustomTreeView.CMDrag(var Message: TCMDrag);
begin
  inherited;
  with Message, DragRec^ do
    case DragMessage of
      dmDragMove:
        with ScreenToClient(Pos) do
          DoDragOver(Source, X, Y, Message.Result <> 0);
      dmDragLeave:
        begin
          TDragObject(Source).HideDragImage;
          FLastDropTarget := DropTarget;
          DropTarget := nil;
          TDragObject(Source).ShowDragImage;
        end;
      dmDragDrop: FLastDropTarget := nil;
    end;
end;

procedure TwwCustomTreeView.DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
var
  Node: TwwTreeNode;
begin
  Node := GetNodeAt(X, Y);
  if (Node <> nil) and
    ((Node <> DropTarget) or (Node = FLastDropTarget)) then
  begin
    FLastDropTarget := nil;
    TDragObject(Source).HideDragImage;
    Node.DropTarget := True;
    TDragObject(Source).ShowDragImage;
  end;
end;

procedure TwwCustomTreeView.GetImageIndex(Node: TwwTreeNode);
begin
  if Assigned(FOnGetImageIndex) then FOnGetImageIndex(Self, Node);
end;

procedure TwwCustomTreeView.GetSelectedIndex(Node: TwwTreeNode);
begin
  if Assigned(FOnGetSelectedIndex) then FOnGetSelectedIndex(Self, Node);
end;

function TwwCustomTreeView.CanChange(Node: TwwTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnChanging) then FOnChanging(Self, Node, Result);
end;

procedure TwwCustomTreeView.Change(Node: TwwTreeNode);
begin
  if Assigned(FOnChange) then FOnChange(Self, Node);
end;

procedure TwwCustomTreeView.Delete(Node: TwwTreeNode);
begin
  if Assigned(FOnDeletion) then FOnDeletion(Self, Node);
  if Assigned(FOnItemChange) then FOnItemChange(self, Node, icaDelete, NULL);
end;

procedure TwwCustomTreeView.Expand(Node: TwwTreeNode);
begin
  if Assigned(FOnExpanded) then FOnExpanded(Self, Node);
end;

function TwwCustomTreeView.CanExpand(Node: TwwTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnExpanding) then FOnExpanding(Self, Node, Result);

  { 5/21/99 - Complete editing  }
  if IsEditing and (Selected<>nil) and
     (Selected.HasAsParent(Node) or (Selected=Node)) then
  begin
     Selected.EndEdit(False);
     result:= False;
  end;
  if InLoading then result:= False;

end;

procedure TwwCustomTreeView.Collapse(Node: TwwTreeNode);
begin
  if Assigned(FOnCollapsed) then FOnCollapsed(Self, Node);
end;

function TwwCustomTreeView.CanCollapse(Node: TwwTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnCollapsing) then FOnCollapsing(Self, Node, Result);

  { 5/21/99 - Complete editing  }
  if IsEditing and (Selected<>nil) and
     (Selected.HasAsParent(Node) or (Selected=Node)) then
  begin
     Selected.EndEdit(False);
     result:= False;
  end
end;

function TwwCustomTreeView.CanEdit(Node: TwwTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnEditing) then FOnEditing(Self, Node, Result);
end;

procedure TwwCustomTreeView.Edit(const Item: TTVItem);
var
  S: string;
  Node: TwwTreeNode;
begin
  with Item do
    if pszText <> nil then
    begin
      S := pszText;
      Node := GetNodeFromItem(Item);
      if Assigned(FOnEdited) then FOnEdited(Self, Node, S);
      if Node <> nil then Node.Text := S;
      EditNode := Nil;
    end;
end;

function TwwCustomTreeView.CreateNode: TwwTreeNode;
begin
  Result := NodeClass.Create(Items);
  if Assigned(OnItemChange) then OnItemChange(self, result, icaAdd, NULL);
end;

procedure TwwCustomTreeView.SetImageList(Value: HImageList; Flags: Integer);
begin
  if HandleAllocated then TreeView_SetImageList(Handle, Value, Flags);
end;

procedure TwwCustomTreeView.ImageListChange(Sender: TObject);
var
  ImageHandle: HImageList;
begin
  if HandleAllocated then
  begin
    if TCustomImageList(Sender).HandleAllocated then
      ImageHandle := TCustomImageList(Sender).Handle
    else
      ImageHandle := 0;
    if Sender = Images then
      SetImageList(ImageHandle, TVSIL_NORMAL)
    else if Sender = StateImages then
      SetImageList(ImageHandle, TVSIL_STATE);
  end;
end;

procedure TwwCustomTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = StateImages then StateImages := nil;
  end;
end;

procedure TwwCustomTreeView.ResetStateImages;
var Node: TwwTreeNode;
begin
   if Images<>nil then begin
      Node := Items.GetFirstNode;
      while Node <> nil do
      begin
          if (Node.StateIndex <>(Node.GetStateIndex shr 12) -1) then
            Node.StateIndex:= Node.StateIndex;
          Node := Node.GetNext;
      end
   end
end;

procedure TwwCustomTreeView.SetImages(Value: TCustomImageList);
begin
  if Images <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Images <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Images.FreeNotification(Self);
    SetImageList(Images.Handle, TVSIL_NORMAL);

    { Imagelist changing after nodes loaded causes stateindex to no longer be -1 }
    { Therefore scan all nodes and reset the ones that are incorrect }

    { 2/1/99 - Reset state images due to Microsoft TreeView resetting StateImage list }
    if StateImages <> nil then
    begin
      SetImageList(StateImages.Handle, TVSIL_STATE)
    end;

    ResetStateImages;
//    if not (csLoading in ComponentState) then RecreateWnd; // 2/2/99
  end
  else SetImageList(0, TVSIL_NORMAL);
end;

procedure TwwCustomTreeView.SetStateImages(Value: TCustomImageList);
var PrevStateImages: TCustomImageList;
begin
  PrevStateImages:= StateImages;
  if StateImages <> nil then
    StateImages.UnRegisterChanges(FStateChangeLink);
  FStateImages := Value;
  if StateImages <> nil then
  begin
    StateImages.RegisterChanges(FStateChangeLink);
    StateImages.FreeNotification(Self);
    SetImageList(StateImages.Handle, TVSIL_STATE)
  end;

//  else SetImageList(0, TVSIL_STATE);
  if PrevStateImages<>Value then
  begin
     if (Value=Nil) then
     begin
       TreeView_SetImageList(Handle, FFixBugImageList.Handle, TVSIL_STATE);
       RecreateWnd;
     end
  end

end;

procedure TwwCustomTreeView.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TwwCustomTreeView.LoadFromStream(Stream: TStream);
begin
   Stream.Position := 0;
   Items.ReadData(Stream);
{  with TTreeStrings.Create(Items) do
    try
      LoadTreeFromStream(Stream);
    finally
      Free;
  end;}
end;

procedure TwwCustomTreeView.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
     SaveToStream(Stream);
  finally
     Stream.Free;
  end;
end;

procedure TwwCustomTreeView.SaveToStream(Stream: TStream);
begin
    Items.WriteData(Stream);
{  with TTreeStrings.Create(Items) do
    try
      SaveTreeToStream(Stream);
    finally
      Free;
  end;}
end;

procedure TwwCustomTreeView.WMRButtonDown(var Message: TWMRButtonDown);
begin
  InvalidateNoErase; { 4/21/99 - Workaround for Microsoft Tree bug which causes last
                                 node to not paint correctly  }
  inherited;
end;

procedure TwwCustomTreeView.WMRButtonUp(var Message: TWMRButtonUp);
begin
  inherited;
end;

procedure TwwCustomTreeView.WMLButtonDown(var Message: TWMLButtonDown);
var
  {$ifdef wwDelphi4Up}
  Node: TwwTreeNode;
  {$endif}
  MousePos, SP: TPoint;
  hitTest: TwwHitTests;
begin
   GetCursorPos(MousePos);
   SP:= ScreenToClient(MousePos);
   hitTest:= GetHitTestInfoAt(sp.x, sp.y);
   BeforeMouseDownNode:= Selected;
   ClickedNode:= GetNodeAt(sp.x, sp.y) as TwwTreeNode;

   if (wwhtOnButton in hitTest) {and (ssLeft in Shift) }then
   begin
      if wwtvoExpandButtons3D in Options then
      begin
         MouseNode:= GetNodeAt(sp.x, sp.y) as TwwTreeNode;
         MouseLoop(sp.x, sp.y);
         MouseNode:= nil;
         exit;
      end
   end;

  { 7/3/99 - Only call Invalidate if not in expanding/collapsing}
  if not (wwhtOnButton in hitTest) then
    InvalidateNoErase; { 4/21/99 - Workaround for Microsoft Tree bug which causes last
                                 node to not paint correctly  }
  {$ifdef wwDelphi4Up}
  FDragged := False;
  FDragNode := nil;
  try
    inherited;
    if (DragMode = dmAutomatic) and (DragKind = dkDrag) then
    begin
      SetFocus;
      if not FDragged then
      begin
        GetCursorPos(MousePos);
        with PointToSmallPoint(ScreenToClient(MousePos)) do
          Perform(WM_LBUTTONUP, 0, MakeLong(X, Y));
      end
      else begin
        Node := GetNodeAt(Message.XPos, Message.YPos);
        if Node <> nil then
        begin
          Node.Focused := True;
          Node.Selected := True;
          BeginDrag(False);
        end;
      end;
    end;
  finally
    FDragNode := nil;
  end;
  {$else}
  inherited;
  {$endif}

end;

procedure TwwCustomTreeView.WMNotify(var Message: TWMNotify);
const wwComCtlVersionIE4 = $00040047;
var
  Node: TwwTreeNode;
  MaxTextLen: Integer;
  Pt: TPoint;
begin
  with Message do
    if NMHdr^.code = TTN_NEEDTEXTW then
    begin
      // Work around NT COMCTL32 problem with tool tips >= 80 characters
      GetCursorPos(Pt);
      Pt := ScreenToClient(Pt);
      Node := GetNodeAt(Pt.X, Pt.Y);
      if (Node = nil) or (Node.Text = '') or
        (PToolTipTextW(NMHdr)^.uFlags and TTF_IDISHWND = 0) then Exit;
      if (wwGetComCtlVersion >= wwComCtlVersionIE4) and (Length(Node.Text) < 80) then
      begin
        inherited;
        Exit;
      end;
      FWideText := Node.Text;
      MaxTextLen := SizeOf(PToolTipTextW(NMHdr)^.szText) div SizeOf(WideChar);
      if Length(FWideText) >= MaxTextLen then
        SetLength(FWideText, MaxTextLen - 1);
      PToolTipTextW(NMHdr)^.lpszText := PWideChar(FWideText);
      FillChar(PToolTipTextW(NMHdr)^.szText, MaxTextLen, 0);
      Move(Pointer(FWideText)^, PToolTipTextW(NMHdr)^.szText, Length(FWideText) * SizeOf(WideChar));
      PToolTipTextW(NMHdr)^.hInst := 0;
      SetWindowPos(NMHdr^.hwndFrom, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or
        SWP_NOSIZE or SWP_NOMOVE or SWP_NOOWNERZORDER);
      Result := 1;
    end
    else inherited;
end;

{ CustomDraw support }

procedure TwwCustomTreeView.CanvasChanged;
begin
  FCanvasChanged := True;
end;

{function TwwCustomTreeView.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  result:= True;
end;
}
//function TwwCustomTreeView.CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean;
//begin
//  Result := True;
//  if Assigned(FOnCustomDraw) then FOnCustomDraw(Self, ARect, Result);
//end;

//function TwwCustomTreeView.CustomDrawItem(Node: TwwTreeNode; State: TCustomDrawState;
//  Stage: TCustomDrawStage): Boolean;
//begin
//  Result := True;
//  if Assigned(FOnCustomDrawItem) then FOnCustomDrawItem(Self, Node, State, Result);
//end;

procedure TwwTreeNode.SetCheckboxType(val: TwwTreeViewCheckboxType);
begin
   if (val<>FCheckboxType) {or (StateIndex>1) }then  {4/26/99 - RSW Don't reset state index }
   begin
      FCheckboxType:= val;
      if val<>wwtvctNone then
         StateIndex:= 1
      else
         StateIndex:= -1
   end
end;

function TwwTreeNode.GetMultiSelected: Boolean;
begin
  result := FMultiSelected {or (TreeView.MultiSelectAttributes.AlwaysIncludeSelectedItem and Selected)};
end;

procedure TwwCustomTreeView.DoToggleCheckbox(Node: TwwTreeNode);
begin
   if Assigned(OnToggleCheckbox) then FOnToggleCheckbox(self, Node);
end;

procedure TwwTreeNode.SetChecked(val : boolean);
var curNode: TwwTreeNode;
begin
   if FChecked<>val then
   begin
      FChecked:= val;
      if self.IsRadioGroup then
      begin
         if val=False then exit;

         { Unselect all siblings }
         CurNode:= Treeview.GetFirstSibling(Self);
         while curNode<>Nil do begin
            if CurNode<>self then begin
               curNode.checked:= False;
               Treeview.InvalidateNode(CurNode);
            end;
            curNode:= TwwTreeNode(curNode.GetNextSibling);
         end;
      end
      else if TreeView.MultiSelectCheckboxNeeded(self) then MultiSelected:= val;
      Treeview.InvalidateNode(self);
      TreeView.DoToggleCheckbox(self);
   end;
end;

procedure TwwTreeNode.SetGrayed(val : boolean);
var curNode: TwwTreeNode;
begin
   if FGrayed<>val then
   begin
      FGrayed:= val;
      if self.IsRadioGroup then
      begin
         { Toggle gray for all siblings }
         CurNode:= Treeview.GetFirstSibling(Self);
         while curNode<>Nil do begin
            if CurNode<>self then begin
               curNode.Grayed:= val;
               Treeview.InvalidateNode(CurNode);
            end;
            curNode:= TwwTreeNode(curNode.GetNextSibling);
         end;
      end;
      Treeview.InvalidateNode(self);
   end;
end;

procedure TwwTreeNode.SetMultiSelected(Value: Boolean);
begin
  if MultiSelected <> Value then
  begin
    TreeView.MultiSelectNode(self, Value, true);  // This method will set the FMultiSelect var
  end;
end;

function TwwTreeNode.GetStateIndex: integer;
var
  Item: TTVItem;
begin
  with Item do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    stateMask := TVIS_STATEIMAGEMASK;
    hItem := ItemId;
//    state := IndexToStateImageMask(Value + 1);
  end;
  TreeView_GetItem(Handle, Item);
  result:= Item.state;
end;

Function TwwTreeNode.IsRadioGroup: boolean;
begin
   result:= CheckboxType=wwtvctRadioGroup;
end;

Function TwwTreeNode.GetSortText: string;
begin
   with TreeView do begin
      result:= Text;
   end
end;

constructor TwwTVMultiSelectAttributes.Create(Owner: TComponent);
begin
   TreeView:= Owner as TwwCustomTreeView;
   FMultiSelectCheckbox:= True;
//   FAlwaysIncludeSelectedItem := False;
   FAutoUnselect:= True;
end;

procedure TwwTVMultiSelectAttributes.Assign(Source: TPersistent);
var tsa: TwwTVMultiSelectAttributes;
begin
   If Source is TwwTVMultiSelectAttributes then
   begin
      tsa:= TwwTVMultiSelectAttributes(Source);
      Enabled:= tsa.Enabled;
      MultiSelectCheckbox:= tsa.MultiSelectCheckbox;
      MultiSelectLevel:= tsa.MultiSelectLevel;
   end
   else inherited Assign(Source);
end;

procedure TwwTVMultiSelectAttributes.SetEnabled(val: boolean);
var Node: TwwTreeNode;
begin
   if val<>FEnabled then
   begin
      if FEnabled=True then
      begin
         { Set all Stateimages of 1 to -1 unless checkboxType is checkbox}
         Node := TreeView.Items.GetFirstNode;
         while Node <> nil do
         begin
//             if (Node.StateIndex=1) and (Node.ShowCheckbox<>0) and
             if (Node.StateIndex=1) and (Node.CheckboxType=wwtvctNone) and
               (TreeView.ValidMultiSelectLevel(Node.Level)) then
                 Node.StateIndex:= -1;
             Node := TwwTreeNode(Node.GetNext);
         end;
      end;

      FEnabled:= val;
      TreeView.invalidate;
   end
end;

procedure TwwTVMultiSelectAttributes.SetMultiSelectCheckBox(val: boolean);
begin
   if val<>FMultiSelectCheckbox then
   begin
      FMultiSelectCheckbox:= val;
      if not val then Treeview.ClearStateImageIndexes;
      TreeView.invalidate;
   end
end;

procedure TwwTVMultiSelectAttributes.SetMultiSelectLevel(val: integer);
begin
   if val<>FMultiSelectLevel then
   begin
      FMultiSelectLevel:= val;
      (TreeView as TwwCustomTreeView).UnselectAllNodes(Nil);
      if val>=0 then Treeview.ClearStateImageIndexes;
      TreeView.Invalidate;
   end
end;

function TwwCustomTreeView.ValidMultiSelectLevel(ALevel: Integer): Boolean;
begin
  result := (FMultiSelectAttributes.MultiSelectLevel = ALevel) or
            (FMultiSelectAttributes.MultiSelectLevel = -1);
end;

Procedure TwwCustomTreeView.UnselectAll;
begin
   UnselectAllNodes(nil);
end;

Procedure TwwCustomTreeView.UnselectAllNodes(IgnoreNode: TwwTreeNode);
var curNode: TwwTreeNode;
    i: integer;
begin
   for i:= 0 to FMultiSelectList.count-1 do begin
      curNode:= TwwTreeNode(FMultiSelectList[i]);
      if (curNode<>IgnoreNode) then begin
         curNode.FMultiSelected:= False;
         if FMultiSelectAttributes.MultiSelectCheckbox then
           curNode.checked:= False;
         if IsVisible(curNode, True) then begin
            InvalidateNode(curNode);
         end
      end
   end;
   FMultiSelectList.Clear;
   if IgnoreNode<>nil then FMultiSelectList.Add(IgnoreNode);
end;

procedure TwwCustomTreeView.MultiSelectNode(Node: TwwTreeNode; Select: boolean; redraw: boolean);
begin
   if (not ValidMultiSelectLevel(Node.Level)) {and
      (FMultiSelectAttributes.MultiSelectLevel>=0)} then exit;

   if FMultiSelectAttributes.MultiSelectCheckbox then
      (Node as TwwTreeNode).checked:= Select;

   if (Select <> (Node as TwwTreeNode).FMultiSelected) then
   begin
      if Select then FMultiSelectList.Add(Node)
      else FMultiSelectList.Remove(Node);

      (Node as TwwTreeNode).FMultiSelected:= Select;

      if redraw and IsVisible(Node, True) then begin
         InvalidateNode(Node);
      end
   end
end;

function TwwCustomTreeView.IsVisible(Node: TwwTreeNode; PartialOK: Boolean): Boolean;
var r: TRect;
    i: integer;
begin
  r := ItemRect(Node, True);
  if PartialOK then i := r.Top else i := r.Bottom;
  result := (i < Height - FBorderWidth * 2) and
            (r.Bottom>0)
end;

Procedure TwwCustomTreeView.InvalidateNode(Node: TwwTreeNode);
var r: TRect;
begin
    if Node=nil then exit;
    r := ItemRect(Node, False);
    if (r.Left=r.right) then exit;
    InvalidateRect(Handle, @r, False);
end;

function TwwCustomTreeView.LevelRect(ANode: TwwTreeNode): TRect;
const wwIMAGEMARGIN = 4;
begin
  result := ItemRect(ANode, True);
  result.Right := result.Left+0;
  result.Left := result.Left+0 - FIndent;
  if UseImages(ANode) then
     OffSetRect(result, -(TImageList(Images).Width + 2{ + wwIMAGEMARGIN}), 0);

  { 3/8/99 - Don't allow state images that are a multple of 16, as Microsoft does not currently support this }
  if UseStateImages(ANode) or
     ((ANode.StateIndex>0) and ((ANode.StateIndex mod 16)<>0)) then
  begin
     if StateImages<>Nil then
        OffsetRect(result, -TImageList(StateImages).Width, 0)
     else
        OffsetRect(result, -TImageList(FFixBugImageList).Width, 0);
  end;

  if UseImages(ANode) {and
     not (UseStateImages(ANode) or (ANode.StateIndex>0)) }then begin
     result.Left:= result.Left + 1;
     result.Right:= result.Right + 1;
  end

end;

function TwwCustomTreeView.ItemRect(Node: TwwTreeNode; LabelOnly: Boolean): TRect;
begin
  result := Rect(0,0,0,0);
  if Node = nil then Exit;
  result := Node.DisplayRect(LabelOnly);
end;

Function TwwCustomTreeView.GetFirstSibling(Node: TwwTreeNode): TwwTreeNode;
var parentNode: TwwTreeNode;
begin
   if Node=Nil then
      parentNode:= Node
   else
      parentNode:= Node.parent;

   if parentNode=nil then
       result := Items.GetFirstNode as TwwTreeNode
   else
       result := TwwTreeNode(parentNode.GetFirstChild);
end;

procedure TwwCustomTreeView.DoDrawText(TreeView: TwwCustomTreeView;
         Node: TwwTreeNode; ARect: TRect; AItemState: TwwItemStates;
         var DefaultDrawing: boolean);
begin
   DefaultDrawing:= True;
   if Assigned(FOnDrawText) then FOnDrawText(Self, Node, ARect, AItemState, defaultDrawing); // -ksw (Added Canvas parameter)
end;

procedure TwwCustomTreeView.Compare(Node1, Node2: TwwTreeNode;
   lParam: integer; var Result: integer);
begin
   if Assigned(OnCompare) then
      OnCompare(self, Node1, Node2, lParam, Result)
   else
      Result := lstrcmp(PChar(Node1.Text), PChar(Node2.Text));
end;

function TwwCustomTreeView.GetDisplayText(Node: TwwTreeNode): string;
begin
   result:= node.text;
end;

procedure TwwCustomTreeView.LoadCanvasDefaults(Node: TwwTreeNode; AItemState: TwwItemStates);
begin
    Canvas.Font.Assign(Font);
    Canvas.Brush.Color := Color;

    if (wwisSelected in AItemState) and not (wwtvoHideSelection in Options) then
       Canvas.Brush.Color := clBtnFace;
    if (((wwisSelected in AItemState) and ((DropTarget = nil) or (DropTarget = Node))) or Node.DropTarget)
       and not FMultiSelectAttributes.enabled then
    begin
       if Focused then begin
          Canvas.Brush.Color := clHighlight;
          Canvas.Font.Color := clHighlightText;
       end
       else if not (wwtvoHideSelection in Options) then begin
           if InactiveFocusColor<>Color then
              Canvas.Brush.Color:= InactiveFocusColor
           else
              Canvas.Brush.Color:= clGray;
          Canvas.Font.Color:= Font.Color;
       end
    end
    else if FMultiSelectAttributes.enabled then
    begin
       if (Node as TwwTreeNode).FMultiSelected then
       begin
          Canvas.Brush.Color := clHighlight;
          Canvas.Font.Color := clHighlightText;
       end
       else begin
          Canvas.Brush.Color := Color;
          Canvas.Font.Color := Font.Color;
       end
    end
    else begin
      Canvas.Brush.Color := Color;
      Canvas.Font.Color := Font.Color;
    end;

end;

procedure wwTreeViewError(const Msg: string);
begin
  raise EwwTreeViewError.Create(Msg);
end;

function TwwCustomTreeView.ProcessKeyPress(Key: char; shift: TShiftState): boolean;
begin
   result:= false;
end;

function TwwCustomTreeView.IsRowSelect: boolean;
begin
   result:= wwtvoRowSelect in Options;
//   result:= tvoRowSelect in Options;
end;

procedure TwwCustomTreeView.BeginItemPainting(Node: TwwTreeNode; ARect: TRect; AItemState: TwwItemStates);
begin
end;

procedure TwwCustomTreeView.EndPainting;
var r: TRect;
    state: TwwItemStates;
begin
  if FCanvas = Canvas then exit;

  { workaround for TreeView bug in Microsoft control when there is exactly one
    item displayed }
  if (Items.Count>0) and (DisplayedItems=0) and True then
  begin
     r := Items[0].DisplayRect(True);
     state:= [wwisSelected];
     if focused then
        state:= state + [wwisFocused];
     EndItemPainting(Items[0], r, state);
  end;

  if Items.Count>0 then begin { 1/24/99 -
                                If no records, then clearing done by erasebckground message
                                Don't rely upn paintcanvas as BeginPainting may not be called
                                if Items.Count is 0. }
    r := ClientRect;
    OffsetRect(r, 1, 0);
    FCanvas.CopyMode:= cmSrcCopy;
    FCanvas.CopyRect(
     Rect(0,0,Canvas.ClipRect.Right,Canvas.ClipRect.Bottom),
     Canvas, Canvas.ClipRect);
  end;

end;

procedure TwwCustomTreeView.BeginPainting;
begin
  { Ensure that stateimages does not have exactly 1 image when painting a checkbox}
  { A bug in the Microsoft Tree control causs a gpf when there is exactly 1 state image when
    clicking on a checkbox }
  if (StateImages<>Nil) and (StateImages.Count=1) and
     not (csDesigning in ComponentState) then
  begin
    StateImages.Clear;
    TreeView_SetImageList(Handle, FFixBugImageList.Handle, TVSIL_STATE);
  end;

  if FCanvas = Canvas then exit;

  { Fill with background color }
  FPaintBitmap.Width := Width;
  FPaintBitmap.Height := Height;
  FPaintBitmap.Canvas.Brush.Color := color;
  FPaintBitmap.Canvas.FillRect(Rect(0, 0, FPaintBitmap.Width, FPaintBitmap.Height));
end;

procedure TwwCustomTreeView.CalcNodeAttributes(Node: TwwTreeNode; AItemState: TwwItemStates);
begin
    if Assigned(FOnCalcNodeAttributes) then
      FOnCalcNodeAttributes(Self, Node as TwwTreeNode, AItemState);
end;


procedure TwwCustomTreeView.EndItemPainting(Node: TwwTreeNode; ARect: TRect; AItemState: TwwItemStates);
const HDM_ORDERTOINDEX = HDM_FIRST + 15;
      HDM_GETORDERARRAY = HDM_FIRST + 17;
      DrawTextUnderscoreStyles: array[Boolean] of Integer = (DT_NOPREFIX, 0);
      wwTEXTPADDING = 4;
var r, FocusRect, CalcRect: TRect;
    DefaultDrawing: boolean;
    flags:Longint;

  function wwDrawText(Handle: HDC; AText: string; ARect: TRect; Style: Integer): TRect;
  begin
  // Used by DrawText API Function when "Item" has focus.
    SetBkColor(Handle, ColorToRGB(Brush.Color));
    SetTextColor(Handle, ColorToRGB(Font.Color));

    Windows.DrawTextEx(Handle, PChar(AText), Length(AText), ARect, Style, nil);
    result := ARect;
  end;

begin
  { Imagelist changing after nodes loaded causes stateindex to no longer be -1 }
  if (Node.StateIndex <>(Node.GetStateIndex shr 12) -1) then
  begin
     Node.StateIndex:= Node.StateIndex;
//     exit;  { RSW - Don't paint now, let Microsoft control paint this later}
  end;

  PaintLines(Node);
  if MultiSelectCheckBoxNeeded(Node) then Node.StateIndex:= 1;

  LoadCanvasDefaults(Node, AItemState);
  if (wwisHot in AItemState) or
     ((wwtvoAutoURL in Options) and (Node.StringData<>'')) then
  begin
     if not (wwisSelected in AItemState) or not Focused then { 4/8/99 - No focus still paint clBlue }
        Canvas.Font.Color:= clBlue;
     Canvas.Font.Style:= [fsUnderline];
  end;

  CalcNodeAttributes(Node, AItemState);
  Canvas.Refresh;

  TreeView_GetItemRect(Handle, Node.ItemID, r, False);
  r.Left := ARect.Left;

  if Canvas.Font.Style * [fsBold, fsItalic] <> [] then begin
    flags := 0;
    CalcRect := ARect;
    //5/10/2002 - Use DrawText to calculate font based on current canvas settings from OnCalcNodeAttributes event.
    DrawText(Canvas.Handle, PChar(GetDisplayText(Node)), -1, calcrect, flags or DT_CALCRECT);
//    ARect := Rect(ARect.Left, ARect.Top, ARect.Left +
//                   Canvas.TextWidth(GetDisplayText(Node)) + wwTEXTPADDING, ARect.Bottom);
    ARect := Rect(ARect.Left, ARect.Top, ARect.Left + (CalcRect.Right-CalcRect.Left) + wwTEXTPADDING, ARect.Bottom);
  end;

  Canvas.Pen.Color := Color;

  FocusRect:= ARect;

  if IsRowSelect then
  begin
    FocusRect.Right:= Width-4;
    if UseImages(node) then dec(FocusRect.Left, TImageList(Images).Width);
    if UseStateImages(node) then begin
       if StateImages<>nil then
          dec(FocusRect.Left, TImageList(StateImages).Width)
       else
          dec(FocusRect.Left, FixBugImageListSize)
    end;
    if UseImages(node) or UseStateImages(node) then dec(FocusRect.Left, 4);
    if not MultiSelectAttributes.enabled then
       FocusRect.Bottom := FocusRect.Bottom + 1;
  end;

  if (not IsEditing) or not (wwIsSelected in AItemState) then
  begin
    if (Canvas.Brush.Color <> clNone) and
       ((not MultiSelectAttributes.enabled) or Node.MultiSelected) then
    begin
      if (wwisFocused in AItemState) then
         Canvas.Rectangle(FocusRect.Left, FocusRect.Top, FocusRect.Right, FocusRect.Bottom)
      else begin
         FocusRect.bottom:= FocusRect.Bottom - 1;
         Canvas.FillRect(FocusRect);
         FocusRect.bottom:= FocusRect.Bottom + 1;
      end
    end
  end;

  PaintImage(Node, AItemState);

  InflateRect(ARect, -1, -1);
  ARect.Left:= ARect.Left + 1;
  SetBkMode(Canvas.Handle, TRANSPARENT);

  try
     if (not IsEditing) or not (wwIsSelected in AItemState) then
     begin
        DoDrawText(self, Node, ARect, AItemState, DefaultDrawing);
        if DefaultDrawing then begin
           wwDrawText(Canvas.Handle, Node.Text, ARect, DT_END_ELLIPSIS or DrawTextUnderscoreStyles[False]);
           //Canvas.DrawText(GetDisplayText(Node), ARect, DT_END_ELLIPSIS or DrawTextUnderscoreStyles[False]);
           if (wwisFocused in AItemState) and Focused and
               ((not IsRowSelect) or MultiSelectAttributes.enabled) then
           begin
              Canvas.DrawFocusRect(FocusRect);
           end
        end
     end
  finally
     SetBkMode(Canvas.Handle, OPAQUE);
  end
end;

(*
procedure TwwCustomTreeView.EndItemPainting(Node: TwwTreeNode; ARect: TRect; AItemState: TwwItemStates);
const HDM_ORDERTOINDEX = HDM_FIRST + 15;
      HDM_GETORDERARRAY = HDM_FIRST + 17;
      DrawTextUnderscoreStyles: array[Boolean] of Integer = (DT_NOPREFIX, 0);
      fcTEXTPADDING = 4;
var r: TRect;
    DefaultDrawing: boolean;
begin
  { Imagelist changing after nodes loaded causes stateindex to no longer be -1 }
  if (Node.StateIndex <>(Node.GetStateIndex shr 12) -1) then
  begin
     Node.StateIndex:= Node.StateIndex;
  end;

  PaintLines(Node);
  if MultiSelectCheckBoxNeeded(Node) then Node.StateIndex:= 1;

  LoadCanvasDefaults(Node, AItemState);
  CalcNodeAttributes(Node, AItemState);
  Canvas.Refresh;

  if Canvas.Font.Style * [fsBold, fsItalic] <> [] then
    ARect := Rect(ARect.Left, ARect.Top, ARect.Left +
                  Canvas.TextWidth(GetDisplayText(Node)) + fcTEXTPADDING, ARect.Bottom);

  Canvas.Pen.Color := Color;

  r := ARect;

  if RowSelect then
  begin
    ARect.Left := LevelRect(Node).Left;
    ARect.Right := Width;
  end;
  if Canvas.Brush.Color <> clNone then
  begin
    if (isFocused in AItemState) then
       Canvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom)
    else Canvas.FillRect(ARect);
  end;
  if RowSelect then ARect.Left := r.Left;

  PaintImage(Node, AItemState);
  TreeView_GetItemRect(Handle, Node.ItemID, r, False);
  r.Left := ARect.Left;


  InflateRect(ARect, -1, -1);
  SetBkMode(Canvas.Handle, TRANSPARENT);

  try
     DoDrawText(self, Node, ARect, AItemState, DefaultDrawing);
     if DefaultDrawing then begin
        Canvas.DrawText(GetDisplayText(Node), ARect, DT_END_ELLIPSIS or DrawTextUnderscoreStyles[tvoUnderscoreAllowed in FOptions]);
        if (isFocused in AItemState) and Focused then begin
           InflateRect(ARect, 1, 1);
           Canvas.Brush.Color := clBlack;
           SetTextColor(Canvas.Handle, clWhite);
           Canvas.DrawFocusRect(ARect);
        end
     end
  finally
     SetBkMode(Canvas.Handle, OPAQUE);
  end
end;
*)

procedure TwwCustomTreeView.PaintButton(Node: TwwTreeNode;
   pt: TPoint; Size: integer);
var offset: integer;
    drawRect: TRect;
    OrigColor: TColor;
    StateFlags: Word;
    {$ifdef wwUseThemeManager}
    Details: TThemedElementDetails;
    {$endif}
begin
   OrigColor:= Canvas.Brush.Color;
   if not (wwtvoShowButtons in Options) then Exit;
   offset:= Size;
   Offset:= Offset div 2;

   DrawRect.Left:= pt.x - offset;
   DrawRect.Right:= pt.x + offset+1;
   DrawRect.Top:= pt.y-offset;
   DrawRect.Bottom:= pt.y+offset+1;

   if wwtvoExpandButtons3D in Options then
   begin
      Canvas.Brush.Color := clBtnFace;
      Canvas.FillRect(DrawRect);
      Canvas.Brush.Color := clBtnShadow;

      StateFlags:= DFCS_BUTTONPUSH;
      if Down and (MouseNode=Node) then
         StateFlags := StateFlags or DFCS_PUSHED;

      with DrawRect do
         DrawFrameControl(Canvas.Handle, Rect(Left, Top, Right+1, Bottom+1),
              DFC_BUTTON, StateFlags);
      if ColorToRGB(Color)=clWhite then
      begin
         with DrawRect, Canvas do begin
           Pen.Color := clBtnFace;
           Polyline([Point(Left-1, Bottom), Point(Left-1, Top-1), Point(Right+1, Top-1)]);
         end;
      end;

      if Down and (MouseNode = Node) then
      begin
         pt.x:= pt.x+1;
         pt.y:= pt.y+1;
         DrawRect.Left:= DrawRect.Left + 1;
         DrawRect.Top:= DrawRect.Top + 1;
         DrawRect.Right:= DrawRect.Right + 1;
         DrawRect.Bottom:= DrawRect.Bottom + 1;
      end;

      Canvas.Brush.Color := Color;

      Canvas.Pen.Color := clBlack;
      if not Node.Expanded then
         Canvas.Polyline([Point(pt.x, DrawRect.Top+Offset div 2), Point(pt.x, DrawRect.Bottom-Offset div 2)]);
      Canvas.Polyline([Point(DrawRect.Left+Offset div 2, pt.y), Point(DrawRect.Right-Offset div 2, pt.y)]);

      Canvas.Brush.Color:= OrigColor;
   end
   else begin
      if wwUseThemes(self) then
//      if StyleServices.ThemesEnabled then
      begin
        {$ifdef wwUseThemeManager}
        if Node.expanded then
          Details := StyleServices.GetElementDetails(ttGlyphOpened)
        else
          Details := StyleServices.GetElementDetails(ttGlyphClosed);
        StyleServices.DrawElement(Canvas.Handle, Details, DrawRect);
        {$endif}
      end
      else begin
         Canvas.Brush.Color := clWhite;
         Canvas.FillRect(DrawRect);
         Canvas.Brush.Color := clBtnShadow;
         Canvas.FrameRect(DrawRect);
         Canvas.Brush.Color := Color;

         Canvas.Pen.Color := clBlack;
         if not Node.Expanded then
            Canvas.Polyline([Point(pt.x, DrawRect.Top+Offset div 2), Point(pt.x, DrawRect.Bottom-Offset div 2)]);
         Canvas.Polyline([Point(DrawRect.Left+Offset div 2, pt.y), Point(DrawRect.Right-Offset div 2, pt.y)]);

         Canvas.Brush.Color:= OrigColor;
      end
   end;
end;

Function TwwCustomTreeView.GetCenterPoint(ARect: TRect): TPoint;
var r: TRect;
begin
   r:= ARect;

   if odd(wwRectHeight(r) div 2) then
      result.y:= r.Top + (wwRectHeight(r)+2) div 2
   else
      result.y:= r.Top + (wwRectHeight(r)) div 2;

   if odd(wwRectWidth(r) div 2) then
      result.x:= r.Left + (wwRectWidth(r)) div 2
   else
      result.x:= r.Left + (wwRectWidth(r)) div 2;
end;

procedure TwwCustomTreeView.PaintLines(Node: TwwTreeNode);
var LevelNode: TwwTreeNode;
    r: TRect;
    LineTop, LineBottom: TPoint;
    X,Y: integer;
    LineStartX: integer;
    size: integer;

    Function GetStartX(Node: TwwTreeNode): integer;
    var Offset : integer;
        r: TRect;
    begin
        r := LevelRect(Node);
        Offset:= (((r.Bottom - r.Top) div 2) div 2)+2;
        Offset:= wwMin(Offset, MaxCheckboxSize);
        result:= r.Left + offset + 1; //r.Right + Offset + 1;

{        if Node.Level>0 then begin
           r:= LevelRect(Node.parent);
           Offset:= ((fcRectHeight(r) div 2) div 2)+2;
           Offset:= fcMin(Offset, MaxCheckboxSize);
           result:= r.Right + Offset + 1;
        end
        else begin
           r := LevelRect(Node);
           result:= r.Left + fcRectWidth(r) div 2;
        end}
    end;

begin
  r:= LevelRect(Node);
  if wwtvoShowLines in Options then
  begin
    Canvas.Pen.Color := FLineColor; //clBtnShadow; { for line drawing }
    LevelNode := Node;
    while (LevelNode <> nil) and ((LevelNode.Level = 0) or (LevelNode.Parent <> nil)) do
    begin

      with ItemRect(Node, False) do
      begin
        r := LevelRect(LevelNode);
        r.Top := Top;
        r.Bottom := Bottom;
      end;
      LineStartX:= GetStartX(LevelNode);
      LineTop:= Point(LineStartX, r.Top);
      LineBottom:= Point(LineStartX, r.Bottom);

      if LevelNode.Level = Node.Level then
      begin
       if (Node.GetPrevSibling = nil) and (Node.Parent = nil) then
          inc(LineTop.y, GetCenterPoint(r).y);
        if Node.GetNextSibling = nil then
          dec(LineBottom.y, wwRectHeight(r) div 2 - 1);
      end;
      if (LevelNode.GetNextSibling <> nil) or (LevelNode.Level = Node.Level) then
        DottedLine(LineTop, LineBottom);
      LevelNode := LevelNode.Parent;
    end;
    r := LevelRect(Node);
    if (wwtvoShowRoot in Options) or (Node.Level <> 0) then
    begin
      y:= GetCenterPoint(r).y;
      x:= GetStartX(Node);
      if UseStateImages(Node) or MultiSelectAttributes.enabled then
      begin
         if (CheckboxNeeded(Node as TwwTreeNode)) then
         begin
            r.right:= r.right - 2;
         end
      end;
      DottedLine(Point(x, y), Point(r.Right, y));
    end
  end;
  if Node.HasChildren then begin
     size:= (wwRectHeight(r) div 2);
     size:= wwMax(size, 8);
     PaintButton(Node, Point(GetStartX(Node), GetCenterPoint(r).y), size)
  end
end;

procedure TwwCustomTreeView.PaintImage(Node: TwwTreeNode; State: TwwItemStates);
const ItemChecked: array[Boolean] of Integer = (0, DFCS_CHECKED);
      CheckBoxFlat: array[Boolean] of Integer = (0, DFCS_FLAT);
      DrawSelected: array[Boolean] of Integer = (ILD_NORMAL, ILD_SELECTED);
      Grayed: array[Boolean] of Integer = (0, DFCS_INACTIVE);
var r: TRect;
    x: Integer;
    Index: Integer;
    cp: TPoint;
    offset: integer;
    Style: UINT;
    BlendColor: TColorRef;
    ARect: TRect;
    {$ifdef wwUseThemeManager}
    Details: TThemedElementDetails;
    CheckboxStyle: TThemedButton;
    PaintRect: TRect;
    {$endif}

    {$ifdef wwUseThemeManager}
      function IsHotRadioOrCheckbox: boolean;
      var SP, MousePos: TPoint;
          hitTest: TwwHitTests;
      begin
          GetCursorPos(MousePos);
          SP:= ScreenToClient(MousePos);
          hitTest:= GetHitTestInfoAt(sp.x, sp.y);
          ClickedNode:= GetNodeAt(sp.x, sp.y) as TwwTreeNode;
          result:= (ClickedNode=Node) and (wwhtOnStateIcon in hittest);
      end;

    function GetRadioButtonThemeStyle(Pressed: boolean): TThemedButton;
    begin
         if not Enabled then
         begin
            Result:= tbRadioButtonCheckedDisabled
         end
         else begin
            if Node.checked then
            begin
              if Pressed then
                 Result:= tbRadioButtonCheckedPressed
              else begin
                 if IsHotRadioOrCheckbox then
                    Result:= tbRadioButtonCheckedHot
                 else
                    Result:= tbRadioButtonCheckedNormal
              end
            end
            else begin
              if Pressed  then
                 Result:= tbRadioButtonUncheckedPressed
              else begin
                 if IsHotRadioOrCheckBox then
                   Result:= tbRadioButtonUncheckedHot
                 else
                   Result:= tbRadioButtonUncheckedNormal
              end
            end;
         end;
    end;
    {$endif}

begin
  r := LevelRect(Node);

  if not((Images = nil) or
    ((Node.ImageIndex < 0)) or
     (Node.ImageIndex >= Images.Count)) then
  begin
    x := r.Right;
    if UseStateImages(Node) then
    begin
       if StateImages<>nil then
          inc(x, TImageList(StateImages).Width)
       else
          inc(x, FixBugImageListSize);
    end;

    if (not (wwisSelected in State)) or (Node.SelectedIndex < 0) or (Node.SelectedIndex >= Images.Count) then
      Index := Node.ImageIndex
    else Index := Node.SelectedIndex;

    Style:=
       DrawSelected[((Node.Selected and (DropTarget = nil)) or Node.DropTarget) and (TImageList(Images).BlendColor <> clNone)
          and not IsRowSelect];
    if Node.Cut then
    begin
       Style:= Style or ILD_BLEND50;
       BlendColor:= clWhite;
    end
    else begin
       BlendColor:= ColorToRGB(TImageList(Images).BlendColor);
    end;

    if Node.OverlayIndex>=0 then
      Style:= Style or UINT(IndexToOverlayMask(Node.OverlayIndex+1));

    ImageList_DrawEx(Images.Handle, Index, Canvas.Handle,
      x, r.Top + (r.Bottom - r.Top - TImageList(Images).Height) div 2, 0, 0,
      CLR_NONE, BlendColor, Style);

  end;


  if UseStateImages(Node) then
  begin
    if (not CheckboxNeeded(Node as TwwTreeNode)) then
       StateImages.Draw(Canvas, r.right, r.Top + (r.Bottom-r.Top-TImageList(StateImages).Height) div 2, Node.StateIndex)
//       StateImages.Draw(Canvas, r.Right, r.Top, Node.StateIndex)
    else begin
      cp:= GetCenterPoint(r);
      Offset:= ((wwRectHeight(r) div 2) div 2)+2;
      Offset:= wwMin(Offset, MaxCheckboxSize);
      if Node.CheckboxType=wwtvctRadioGroup then
      begin
         ARect:= Rect(r.right+1, cp.y-offset, r.Right + 2*offset+2, cp.y+offset+1);
         if wwUseThemes(self) then
         begin
           {$ifdef wwUseThemeManager}
           CheckboxStyle:= GetRadioButtonThemeStyle(False);
           Details := StyleServices.GetElementDetails(CheckboxStyle);
           PaintRect := ARect;
           StyleServices.DrawElement(Canvas.Handle, Details, PaintRect);
           //PaintRect := StyleServices.ContentRect(Canvas.Handle, Details, PaintRect);
           StyleServices.GetElementContentRect(Canvas.Handle, Details, PaintRect, PaintRect);
           {$endif}

         end
         else begin
           DrawFrameControl(Canvas.Handle, Rect(r.right+1, cp.y-offset, r.Right + 2*offset+2, cp.y+offset+1),
           DFC_BUTTON,
           Grayed[Node.Grayed] or
           DFCS_BUTTONRADIO or CheckBoxFlat[wwtvoFlatCheckBoxes in Options] or ItemChecked[Node.checked])
         end
      end
      else begin
         ARect:= Rect(r.right+1, cp.y-offset, r.Right + 2*offset+2, cp.y+offset+1);
         if wwUseThemes(self) then
         begin
           {$ifdef wwUseThemeManager}
           if Node.Grayed then
           begin
              if Node.checked then CheckboxStyle:= tbCheckboxCheckedDisabled
              else CheckboxStyle:= tbCheckboxUnCheckedDisabled
           end
           else begin
              if IsHotRadioOrCheckBox then
              begin
                 if Node.checked then CheckboxStyle:= tbCheckboxCheckedHot
                 else CheckboxStyle:= tbCheckboxUnCheckedHot
              end
              else begin
                 if Node.checked then CheckboxStyle:= tbCheckboxCheckedNormal
                 else CheckboxStyle:= tbCheckboxUnCheckedNormal
              end;
           end;
           Details := StyleServices.GetElementDetails(CheckboxStyle);
           PaintRect := ARect;
           StyleServices.DrawElement(Canvas.Handle, Details, PaintRect);
           //PaintRect := StyleServices.ContentRect(Canvas.Handle, Details, PaintRect);
           StyleServices.GetElementContentRect(Canvas.Handle, Details, PaintRect, PaintRect);
           {$endif}
         end
         else begin
           DrawFrameControl(Canvas.Handle, ARect,
              DFC_BUTTON, Grayed[Node.Grayed] or
                 DFCS_BUTTONCHECK or CheckBoxFlat[wwtvoFlatCheckBoxes in Options]
                 or ItemChecked[Node.checked])
         end
      end
    end;
  end;
end;


procedure TwwCustomTreeView.SetOptions(Value: TwwTreeViewOptions);
const TVS_FULLROWSELECT       = $1000;
      TVS_TRACKSELECT         = $0200;
var ChangedOptions: TwwTreeViewOptions;
begin
  if not HandleAllocated then begin
     FOptions := Value;
     exit;
  end;

  if Value <> FOptions then
  begin
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
    if wwtvoRowSelect in ChangedOptions then
       SetComCtlStyle(Self, TVS_FULLROWSELECT, wwtvoRowSelect in Value);
    if wwtvoShowRoot in ChangedOptions then
       SetComCtlStyle(Self, TVS_LINESATROOT, wwtvoShowRoot in Value);
    if wwtvoShowLines in ChangedOptions then
       SetComCtlStyle(Self, TVS_HASLINES, wwtvoShowLines in Value);
    if wwtvoShowButtons in ChangedOptions then
       SetComCtlStyle(Self, TVS_HASBUTTONS, wwtvoShowButtons in Value);
    if wwtvoHideSelection in ChangedOptions then
       SetComCtlStyle(Self, TVS_SHOWSELALWAYS, not (wwtvoHideSelection in Value));
    if wwtvoHotTrack in ChangedOptions then
       SetComCtlStyle(Self, TVS_TRACKSELECT, wwtvoHotTrack in Value);
    if wwtvoEditText in ChangedOptions then
       SetComCtlStyle(Self, TVS_EDITLABELS, wwtvoEditText in Value);

    FOptions := Value;
    Invalidate;
  end;
end;

Function TwwCustomTreeView.MultiSelectCheckboxNeeded(Node: TwwTreeNode): boolean;
begin
   if Node=nil then result:= False
   else with FMultiSelectAttributes do
      result:= Enabled and MultiSelectCheckbox and (ValidMultiSelectLevel(Node.Level))
end;

Function TwwCustomTreeView.CheckboxNeeded(Node: TwwTreeNode): boolean;
begin
   result:= MultiSelectCheckBoxNeeded(Node) or
            (TwwTreeNode(Node).CheckboxType<>wwtvctNone);
end;

function TwwCustomTreeView.UseImages(Node: TwwTreeNode): Boolean;
begin
   result:= (Images<>nil) and (Node.ImageIndex<>-2);
end;

function TwwCustomTreeView.UseStateImages(Node: TwwTreeNode): Boolean;
begin
  { 3/8/99 - Don't allow StateIndex to be multiple of 16,
   as the Microsoft TreeView control ignores these state images }
  result := ((StateImages <> nil) and
   (Node.StateIndex>=1) and ((Node.StateIndex mod 16)<>0)) and
//  result := ((StateImages <> nil) and (Node.StateIndex >= 1) and
    (Node.StateIndex < StateImages.Count);

  if MultiSelectCheckBoxNeeded(Node) then result:= True
  else if ((Node as TwwTreeNode).CheckboxType<>wwtvctNone) and (Node.StateIndex>=1) then
     result:= True;

end;

function TwwCustomTreeView.GetItemHeight: ShortInt;
begin
  result := TreeView_GetItemHeight(Handle);
end;

procedure TwwCustomTreeView.SetItemHeight(Value: ShortInt);
begin
  TreeView_SetItemHeight(Handle, Value);
end;

procedure TwwCustomTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var Node: TwwTreeNode;
begin
   inherited MouseUp(Button, Shift, X, Y);

   Node:= nil; { Make compiler happy}
   if Assigned(FOnMouseUp) or (wwtvoAutoURL in Options) then
      Node:= GetNodeAt(X, Y) as TwwTreeNode;

   if Assigned(FOnMouseUp) then
      FOnMouseUp(self, Node, Button, Shift, X, Y);

   if wwtvoAutoURL in Options then
   begin
      if (Button = mbLeft) and (Node<>nil) and (Node.StringData<>'') and
         (wwhtOnItem in GetHitTestInfoAt(x,y)) then
      begin
         Screen.Cursor:= crHourGlass;
         ShellExecute(Handle, 'OPEN', PChar(Node.StringData), nil, nil, sw_shownormal);
         Screen.Cursor:= crDefault; { 10/30/98 - Restore to default cursor }
      end
   end

end;

procedure TwwCustomTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var Node, CurNode, LastNode: TwwTreeNode;
    hitTest: TwwHitTests;

   Function SameLevelShiftSelect: boolean;
   begin
{       if FMultiSelectAttributes.MultiSelectLevel=-1 then begin
          result:= True;
          exit;
       end;}
       result:=
         (ssShift in Shift) and
         (LastSelectedNode<>Nil) and (LastSelectedNode.parent=Node.parent);
   end;

begin

   inherited MouseDown(Button, Shift, X, Y);

   Node:= GetNodeAt(X, Y) as TwwTreeNode;
   if Assigned(FOnMouseDown) then FOnMouseDown(self, Node, Button, Shift, X, Y);
   if (ssDouble in Shift) and Assigned(FOnDblClick) then FOnDblClick(self, Node, Button, Shift, X, Y);

   if Node=Nil then exit;
   hitTest:= GetHitTestInfoAt(X, Y);

   if (ssDouble in Shift) and (Button = mbLeft) then
   begin
      Exit;
   end;

   { 11/12/99 - If right mouse button, then exit so multi-selected records are not unselected }
   if (not RightClickSelects) and (ssRight in Shift) then exit;

   if Node=BeforeMouseDownNode then { Bring up edit control }
   begin
      if (wwhtOnLabel in hittest) and (wwtvoEditText in Options) then
      begin
         FreeHintWindow;
         LastHintNode:= nil;
         If (Node<>Nil) and (Images<>Nil) and
            (Node.imageindex=-2) then
            SendMessage(Handle, TVM_EDITLABEL, 0, integer(node.ItemID));
      end;
   end;

   if (Node=ClickedNode) and // 1/21/01 - Selection changes so skip toggle checkbox
      (wwhtOnStateIcon in hitTest) and CheckboxNeeded(Node) and (not ReadOnly) then
   begin
      if Node.IsRadioGroup then begin
         Node.Grayed:= False;
         Node.checked:= True;
      end
      else begin
         if (wwtvo3StateCheckbox in Options) and
            Node.checked and (not Node.Grayed) then Node.Grayed:= True
         else begin
            Node.checked:= not Node.checked;
            if (wwtvo3StateCheckbox in Options) or
               not (csDesigning in ComponentState) then
               Node.Grayed:= False;
         end;
      end;
      exit;
   end;

   // 8/18/03 - Per Paul Woll
   // so that multiselections will not be lost when dragging nodes from a multiselected treeview....
   if (FDragNode=nil) and
      FMultiSelectAttributes.Enabled and
   ((IsRowSelect and (X >= LevelRect(Node).Left + FIndent)) or  // -ksw (Added to make behavior more
    (not IsRowSelect and (hitTest * [wwhtOnItem, wwhtOnLabel] <> []))) then    // consistent in non-databound cases)
   begin
      if (not (ssCtrl in Shift)) and MultiSelectAttributes.AutoUnselect then
      begin
         if SameLevelShiftSelect then UnselectAllNodes(LastSelectedNode)
         else if ValidMultiSelectLevel(Node.Level) then UnselectAllNodes(nil);
      end;

      if (ssShift in Shift) then begin
         if SamelevelShiftSelect then begin
            if Node.index>LastSelectedNode.index then begin
               curNode:= LastSelectedNode;
               LastNode:= Node;

               if not MultiSelectAttributes.AutoUnselect and
                 (LastSelectedNode<>nil) then
                  MultiSelectNode(LastSelectedNode, True, True);

               while curNode<>LastNode do begin
                  curNode:= curNode.GetNextSibling as TwwTreeNode;
                  if curNode=Nil then break;
                  MultiSelectNode(curNode, True, True);
               end;
            end
            else begin
               curNode:= Node;
               LastNode:= LastSelectedNode;
               while curNode<>LastNode do begin
                  MultiSelectNode(curNode, True, True);
                  curNode:= curNode.GetNextSibling as TwwTreeNode;
                  if curNode=Nil then break;
               end;
               if not MultiSelectAttributes.AutoUnselect and
                 (curNode=LastNode) and (curNode<>nil) then
                  MultiSelectNode(curNode, True, True);
            end;
            if not node.selected then node.selected:= True;
         end
      end
      else begin
          if Node<>nil then
             with Node as TwwTreeNode do begin
                if MultiSelectAttributes.AutoUnselect or (ssCtrl in Shift) then
                   MultiSelectNode(Node, not FMultiSelected, True);
                if not node.selected then node.selected:= True;
             end;
      end;

   end;

   if MultiSelectAttributes.enabled and  not (ssShift in Shift) then
      LastSelectedNode:= Node;

end;

procedure TwwCustomTreeView.WMDestroy(var Message: TWMDestroy);
begin
  if Items<>Nil then Items.Clear;  { Faster to call special clear code than to just destroy }
  inherited;
end;

procedure TwwCustomTreeView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not (wwtvoExpandOnDblClk in FOptions) then
  begin
     with Message do begin { 6/23/99 - Fires OnDblClick event }
        MouseDown(mbLeft, KeysToShiftState(Keys) + [ssDouble], XPos, YPos);
     end
  end
  else inherited;
end;

function TwwCustomTreeView.GetScrollTime: Integer;
begin
  result := TreeView_GetScrollTime(Handle);
end;

procedure TwwCustomTreeView.SetScrollTime(Value: Integer);
begin
  TreeView_SetScrollTime(Handle, Value);
end;

{ Prevents flicker when changing selected node }
procedure TwwCustomTreeView.WMPaint(var Message: TWMPaint);
var
    DC, MemDC: HDC;
    MemBitmap, OldBitmap: HBITMAP;
    PS: TPaintStruct;
    PaintCliprect: TRect;
    UpdateRect: TRect;
    OldSkipErase: boolean;
begin
  // 1/31/2002-Call inherited if nodes are in beginupdate/endupdate.
  if items.fupdatecount>0 then
  begin
     inherited;
     exit;
  end;

  windows.GetUpdateRect(Handle, UpdateRect, false);
{  if not UseAlternateBuffering then
  begin
     inherited;
     exit;
  end;
}
  PaintClipRect:= FCanvas.ClipRect;
  if PaintClipRect.Right>ClientRect.Right then
     PaintClipRect.Right:= ClientRect.Right;
  if UpdateRect.Bottom>ClientRect.Bottom then
     UpdateRect.Bottom:= (inherited GetClientRect).Bottom;

  if (UpdateRect.Top=0) and (UpdateRect.Bottom=0) and
     (UpdateRect.Left=0) and (UpdateRect.Right=0) then
     UpdateRect:= PaintClipRect;

  OldSkipErase:= SkipErase;
  if Items.Count>0 then SkipErase:= True;
  if (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, inherited GetClientRect.Bottom);
    ReleaseDC(0, DC);

    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Message.DC := MemDC;
      if not (csCustomPaint in ControlState) and (ControlCount = 0) then
        inherited
      else
        PaintHandler(Message);
      Message.DC := 0;
//      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      BitBlt(DC, UpdateRect.Left, UpdateRect.Top, UpdateRect.Right, UpdateRect.Bottom, MemDC, UpdateRect.Left, UpdateRect.top, SRCCOPY);
      EndPaint(Handle, PS);

    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
  SkipErase:= OldSkipErase;
end;
{
procedure TwwCustomTreeView.WMPaint(var Message: TWMPaint);
var OldSkipErase: boolean;
begin
   OldSkipErase:= SkipErase;
   if UsePaintBuffering and (Items.Count>0) then SkipErase:= True;
   inherited;
   SkipErase:= OldSkipErase;
end;
}

function TwwTreeNodes.FindNodeInfo(SearchText: string; VisibleOnly: Boolean;
    StoreDataUsing: TwwStoreData = sdStoreText): TwwTreeNode;
var Node: TwwTreeNode;
    tempText: string;
begin
  result := nil;
  Node := GetFirstNode;
  while Node <> nil do
  begin
    case StoreDataUsing of
       sdStoreText: tempText:= Node.Text;
       sdStoreData1: tempText:= Node.StringData;
       sdStoreData2: tempText:= Node.StringData2;
    end;
    if UpperCase(tempText) = UpperCase(SearchText) then
    begin
      result := Node;
      Exit;
    end;
    if VisibleOnly then Node := Node.GetNextVisible
    else Node := Node.GetNext;
  end;
end;

function TwwTreeNodes.FindNode(SearchText: string; VisibleOnly: Boolean): TwwTreeNode;
var Node: TwwTreeNode;
begin
  result := nil;
  Node := GetFirstNode;
  while Node <> nil do
  begin
    if UpperCase(Node.Text) = UpperCase(SearchText) then
    begin
      result := Node;
      Exit;
    end;
    if VisibleOnly then Node := Node.GetNextVisible
    else Node := Node.GetNext;    
  end;
end;

procedure TwwCustomTreeView.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if SkipErase then begin
     Message.result:= 1;
     exit;
  end
  else inherited;
end;

function TwwCustomTreeView.GetMultiSelectItem(Index: integer): TwwTreeNode;
begin
   result:= TwwTreeNode(FMultiSelectList[Index]);
end;

function TwwCustomTreeView.GetMultiSelectListCount: integer;
begin
  result:= FMultiSelectList.Count;
end;

procedure TwwCustomTreeView.ClearStateImageIndexes;
var CurNode: TwwTreeNode;
begin
   { Clear image index for all siblings of MultiSelectLevel}
   CurNode := FTreeNodes.GetFirstNode;

   while curNode<>Nil do begin
      if (MultiSelectAttributes.MultiSelectCheckbox=False) then begin
         if ((curNode.Level = MultiSelectAttributes.MultiSelectLevel) or
           (MultiSelectAttributes.MultiSelectLevel=-1)) then
         begin
            curNode.checked:= False;
            curNode.StateIndex:= -1;
         end
      end
      else begin
         if ((curNode.Level <> MultiSelectAttributes.MultiSelectLevel) and
           (MultiSelectAttributes.MultiSelectLevel<>-1)) then
         begin
            curNode.checked:= False;
            curNode.StateIndex:= -1;
         end
      end;

      curNode:= TwwTreeNode(curNode.GetNext);
   end;

end;

procedure TwwCustomTreeView.KeyDown(var Key: Word; Shift: TShiftState);
begin
   inherited;
   if (Key=32) and (Selected<>nil) and (EditNode=nil) then begin
      with MultiSelectAttributes do begin
         if Enabled and (not MultiSelectCheckbox) and
            (ValidMultiSelectLevel(Selected.Level)) then
         begin
            if (ssCtrl in Shift) then
               Selected.MultiSelected:= not Selected.MultiSelected;
            exit;
         end
      end;

      if (not ReadOnly) then
      begin
         if Selected.IsRadioGroup then begin
            if not (csDesigning in ComponentState) then Selected.Grayed:= False;
            Selected.checked:= True;
         end
         else begin
            if (wwtvo3StateCheckbox in Options) and
               Selected.checked and (not Selected.Grayed) then Selected.Grayed:= True
            else begin
               Selected.checked:= not Selected.checked;
               if (wwtvo3StateCheckbox in Options) or
                  not (csDesigning in ComponentState) then
                  Selected.Grayed:= False;
            end
         end;
      end;
      Key:= 0;
   end;
end;

procedure TwwCustomTreeview.KeyPress(var Key: Char);
begin
   inherited;
end;

procedure TwwTreeNode.Invalidate;
var r: TRect;
begin
  r := DisplayRect(False);
  InvalidateRect(TreeView.Handle, @r, False);
end;

procedure TwwCustomTreeView.MouseLoop(X, Y: Integer);
var ACursor: TPoint;
    Msg: TMsg;

   Function InButton(ACursorPos: TPoint): boolean;
   var sp: TPoint;
       MouseRect: TRect;
   begin
      sp:= ScreenToClient(ACursorPos);
      MouseRect:= MouseNode.DisplayRect(False);
      Result:= (wwhtOnButton in GetHitTestInfoAt(sp.x, sp.y)) and { 2/2/99 }
           (sp.y>=MouseRect.Top) and (sp.y<=MouseRect.Bottom);
   end;

   procedure MouseLoop_MouseMove(X, Y: Integer; ACursorPos: TPoint);
   begin
     Down:= InButton(ACursorPos);
     if not Down then
     begin
        Down:= InButton(ACursorPos);
        InvalidateNode(MouseNode)
     end
     else
        InvalidateNode(MouseNode)
   end;

   procedure MouseLoop_MouseUp(X, Y: Integer; ACursorPos: TPoint);
   var IsMouseInControl: Boolean;
   begin
     IsMouseInControl:= InButton(ACursorPos);
     Down:= False;
     InvalidateNode(MouseNode);
     if IsMouseInControl then
     begin
        if MouseNode.expanded then begin
           if AutoExpand then Selected:= MouseNode; { 4/13/99 - Otherwise it expands again after auto-collapsing }
           MouseNode.Collapse(False);
        end
        else MouseNode.Expand(False);
     end
   end;

begin
  Down:= True;
  InvalidateNode(MouseNode); { Invalidate button icon }

  SetCapture(Handle);
  try
    while GetCapture = Handle do
    begin
      GetCursorPos(ACursor);
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
          PostQuitMessage(Msg.WParam);
          Break;
        end;
      end;
      case Msg.Message of
        WM_LBUTTONDOWN, WM_LBUTTONDBLCLK: ;
        WM_MOUSEMOVE: MouseLoop_MouseMove(X, Y, ACursor);
        WM_LBUTTONUP: begin
          MouseLoop_MouseUp(X, Y, ACursor);

          TranslateMessage(Msg);   // So OnMouseUp fires
          DispatchMessage(Msg);

          if GetCapture = Handle then ReleaseCapture;
        end;
        else begin
          TranslateMessage(Msg);   // So OnMouseUp fires
          DispatchMessage(Msg);
        end;
      end;
    end;
  finally
    if GetCapture = Handle then ReleaseCapture;
  end;
end;

procedure TwwCustomTreeView.SetLineColor(Value: TColor);
begin
  if FLineColor <> Value then
  begin
    FLineColor:= Value;
    Invalidate;
  end;
end;

procedure TwwCustomTreeView.SetInactiveFocusColor(Value: TColor);
begin
  if FInactiveFocusColor <> Value then
  begin
    FInactiveFocusColor:= Value;
    Invalidate;
  end;
end;

procedure TwwCustomTreeView.CMExit(var Message: TMessage);
var firstNode: TwwTreeNode;
begin
   inherited;

   { If exactly one node then invalidate }
   firstNode:= Items.GetFirstNode;
   if (firstNode<>nil) and (firstNode.GetNextSibling=nil) then InvalidateNode(firstNode);
end;

procedure TwwCustomTreeView.MouseMove(Shift: TShiftState; X, Y: Integer);
var Node: TwwTreeNode;
    HitTest: TwwHitTests;

   Function GetEffectiveWidth: integer;
   begin
      Result:= ClientRect.Right - ClientRect.Left - 4;
   end;

   procedure ProcessToolTips;
   var SP: TPoint;
       R, DisplayRect: TRect;
   begin
      if ((EditNode<>Node) or (EditNode=Nil)) and
         (LastHintNode<>Node) and (Node<>nil) then
      begin
         FreeHintWindow;
         HintTimer.Free;
         HintTimer:= nil;

         sp:= self.ClientToScreen(Point(0, 0));
         DisplayRect:= Node.DisplayRect(True);
         R.Left:= DisplayRect.Left + sp.x - 1;
         R.Top:= DisplayRect.Top + sp.y - 2;
         R.Right:= R.Left + Canvas.TextWidth(Node.Text) + 6;
         R.Bottom:= R.Top + Canvas.TextHeight(Node.Text) + 2;
         if DisplayRect.Left+Canvas.TextWidth(Node.Text)>
            GetEffectiveWidth then
         begin
            HintTimer:= TTimer.create(self);
            HintTimer.OnTimer:=HintTimerEvent;
            HintTimer.Interval:=250;
            HintTimer.Enabled:= True;

            LastHintNode:= Node;
            HintWindow:= CreateHintWindow(Node);
            with HintWindow do begin
               if (Node.StringData<>'') and (wwtvoAutoURL in Options) then
               begin
                  Canvas.Font.Color:= GetSysColor(clBlue);
                  Canvas.Font.Style:=
                  Canvas.Font.Style + [fsUnderline];
               end;
               ActivateHint(R, Node.Text);
            end
         end
         else LastHintNode:= nil;
      end
   end;


begin
   inherited MouseMove(Shift, X, Y);

   if Assigned(FOnMouseUp) or (wwtvoAutoURL in Options) or (wwtvoToolTips in Options) or
      wwUseThemes(self) or Assigned(FOnMouseMove) then // 4/21/05 - Add OnMouseMove assigned condition
      Node:= GetNodeAt(X, Y) as TwwTreeNode;

   if Assigned(FOnMouseMove) then
      FOnMouseMove(self, Node, Shift, X, Y);

   if wwUseThemes(self) then
   begin
     HitTest:= GetHitTestInfoAt(x,y);

     if (Node<>LastMouseMoveNode) or (LastMouseHitTest<>HitTest) then
     begin
        if (Node<>nil) and (Node.checkboxtype<>wwtvctNone) then
           Node.invalidate;
        if (LastMouseMoveNode<>nil) then // 6/30/03
           LastMouseMoveNode.invalidate;
     end;

     LastMouseMoveNode:= Node;
     LastMouseHitTest:= HitTest;
   end;

   if wwtvoAutoURL in Options then
   begin
      if (Node<>Nil) and (Node.StringData<>'') and
          (wwhtOnItem in GetHitTestInfoAt(x,y)) then
         Cursor:= crHandPoint
      else
         Cursor:= crDefault;
   end;

   if wwtvoToolTips in Options then ProcessToolTips;

end;

type
  TwwTreeHintWindow=class(THintWindow)
  protected
     procedure Paint; override;
  public
     Node: TwwTreeNode;
  end;

procedure TwwTreeHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  if (Node.StringData<>'') and (wwtvoAutoURL in Node.TreeView.Options) then
  begin
      Canvas.Font.Color:= clBlue;
      Canvas.Font.Style:=
              Canvas.Font.Style + [fsUnderline];
  end
  else begin
      Canvas.Font.Color := clInfoText;
  end;

  SetBkMode(Canvas.Handle, TRANSPARENT);
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
    DT_WORDBREAK);
end;

Function TwwCustomTreeView.CreateHintWindow(Node: TwwTreeNode): THintWindow;
begin
   HintWindow:= TwwTreeHintWindow.create(self);
   TwwTreeHintWindow(HintWindow).Node:= Node;

   HintWindow.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Brush.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Font:= self.Font;
   HintWindow.Canvas.Font.Color:= GetSysColor(COLOR_INFOTEXT);
   HintWindow.Canvas.Pen.Color:= clBlack;
   result:= HintWindow;
end;

procedure TwwCustomTreeView.FreeHintWindow;
begin
   HintTimerCount:= 0;
   HintWindow.Free;
   HintWindow:= nil;
   if HintTimer<>nil then
      HintTimer.enabled:= False;
end;

procedure TwwCustomTreeView.HintTimerEvent(Sender: TObject);
var
    sp, cp: TPoint;
    OutsideClient: boolean;
begin
   if not (HintWindow<>nil) then exit;

   GetCursorPos(cp);
   sp:= self.ClientToScreen(Point(0, 0));
   if (cp.x<sp.x) or (cp.x>sp.x+ClientRect.Right-ClientRect.Left) or
      (cp.y<sp.y) or (cp.y>sp.y+ClientRect.Bottom-ClientRect.Top) then
   begin
      OutsideClient:= True;
   end
   else OutsideClient:= False;

   { Process Hint Timer clean-up}
   if OutsideClient then
   begin
      FreeHintWindow;
      LastHintNode:= nil;
   end
   else begin
      inc(HintTimerCount);
      if HintTimerCount>16 then
      begin
         FreeHintWindow;
      end
   end

end;

procedure TwwCustomTreeView.CMDesignHitTest(var Message: TCMDesignHitTest);
//var HitTest: TwwHitTests;
begin
{   HitTest:= GetHitTestInfoAt(Message.xPos, Message.yPos);
   if fchtToRight in HitTest then begin
      Message.Result:= 1;
   end
   else }inherited;
end;

procedure TwwCustomTreeView.InvalidateNoErase;
begin
   InvalidateRect(Handle, nil, False);
end;

procedure TwwCustomTreeView.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

function TwwCustomTreeView.GetPaintCanvas: TControlCanvas;
begin
//   if UsePaintBuffering then
//      result:= FPaintCanvas
//   else
     result:= FCanvas;
end;

procedure TwwCustomTreeView.DottedLine(p1, p2: TPoint);
var i: integer;
    x, y: integer;
    tot: integer;
begin
  //Refresh;
  x := p1.x;
  y := p1.y;
  tot := wwMax(Abs(p2.y - p1.y), Abs(p2.x - p1.x));
  for i := 0 to tot do if i mod 2 = 0 then
  begin
    Canvas.Polyline([Point(x,y), Point(x+1,y+1)]);
    inc(x, (p2.x - p1.x) div wwMax(1, (tot div 2)));
    inc(y, (p2.y - p1.y) div wwMax(1, (tot div 2)));
  end;
end;

end.
