unit vcl.wwricheditbar;

{
  //
  // Components : TwwRichEditBar
  //
  // Copyright (c) 2007 by Woll2Woll Software
}

interface

{$I wwIfDef.pas}
{$C PRELOAD}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, StdCtrls, ComCtrls, wwriched, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, ToolWin, ExtCtrls, wwtrackicon, printers,
  RichEdit, wwintl, ActnPopup,
  wwcommon, PlatformDefaultStyleActnCtrls,
  system.Types, system.UITypes;

type
  TwwRichEditBarOption = (rebShowLoad, rebShowSaveAs, rebShowPrint,
    rebShowPrintPreview, rebShowPageSetup, rebShowFormatBar, rebShowToolBar,
    rebShowHints, rebShowRuler, rebFlatButtons,
    rebShowSpellCheck, rebShowJustifyButton, rebShowZoomCombo,
    rebGradientToolbars, rebInvertColorsInToolbar);
  TwwRichEditBarOptions = Set of TwwRichEditBarOption;

  TwwRichBarFrame = class(TFrame)
    RichEditBar: TPanel;
    FormatBarBevel: TBevel;
    RulerBevel: TBevel;
    FormatBar: TToolBar;
    FontNameCombo: TwwDBComboBox;
    FontSizeCombo: TwwDBComboBox;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ColorButton: TToolButton;
    ToolButton3: TToolButton;
    LeftButton: TToolButton;
    CenterButton: TToolButton;
    RightButton: TToolButton;
    JustifyButton: TToolButton;
    ToolButton1: TToolButton;
    BulletButton: TToolButton;
    HighlightButton: TToolButton;
    Toolbar: TToolBar;
    NewButton: TToolButton;
    LoadButton: TToolButton;
    SaveAsButton: TToolButton;
    PrintButton: TToolButton;
    Sep2: TToolButton;
    FindButton: TToolButton;
    SpellButton: TToolButton;
    Sep3: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    Sep4: TToolButton;
    UndoButton: TToolButton;
    RedoButton: TToolButton;
    Sep5: TToolButton;
    RichEditButtonIcons: TImageList;
    PrintDialog1: TPrintDialog;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    Black1: TMenuItem;
    Green1: TMenuItem;
    Red1: TMenuItem;
    Blue1: TMenuItem;
    Yellow1: TMenuItem;
    Purple1: TMenuItem;
    Teal1: TMenuItem;
    Gray1: TMenuItem;
    Silver1: TMenuItem;
    Red2: TMenuItem;
    Lime1: TMenuItem;
    Yellow2: TMenuItem;
    Blue2: TMenuItem;
    Fuchsia1: TMenuItem;
    Aqua1: TMenuItem;
    White1: TMenuItem;
    Automatic1: TMenuItem;
    OpenDialog1: TOpenDialog;
    PrintPreviewButton: TToolButton;
    Sep1: TToolButton;
    FormatMenu: TPopupMenu;
    Font1: TMenuItem;
    Paragraph1: TMenuItem;
    abs1: TMenuItem;
    FormatOptionsButton: TToolButton;
    PopupActionBar1: TPopupActionBar;
    Font2: TMenuItem;
    Paragraph2: TMenuItem;
    abs2: TMenuItem;
    InsertObjectButton: TToolButton;
    NumberingButton: TToolButton;
    ZoomCombo: TwwDBComboBox;
    RichEditBevel: TBevel;
    UserButtonSep: TToolButton;
    Sep6: TToolButton;
    procedure FontNameComboCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure FontSizeComboCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure FindButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure ColorButtonClick(Sender: TObject);
    procedure CenterButtonClick(Sender: TObject);
    procedure BulletButtonClick(Sender: TObject);
    procedure BoldButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BoldButtonClick(Sender: TObject);
    procedure LeftButtonClick(Sender: TObject);
    procedure RightButtonClick(Sender: TObject);
    procedure JustifyButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure RedoButtonClick(Sender: TObject);
    procedure UndoButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure SpellButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure SaveAsButtonClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure HighlightButtonClick(Sender: TObject);
    procedure PrintPreviewButtonClick(Sender: TObject);
    procedure RichEditBarEnter(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure Paragraph1Click(Sender: TObject);
    procedure abs1Click(Sender: TObject);
    procedure InsertObjectButtonClick(Sender: TObject);
    procedure NumberingButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NumberingButtonClick(Sender: TObject);
    procedure ZoomComboCloseUp(Sender: TwwDBComboBox; Select: Boolean);
  private
    { Private declarations }
    FCanvas: TCanvas;
    tempDown: Boolean;
    RichEdit1: TwwDBRichEdit;

    procedure InitColorMenu;
    procedure ColorClick(Sender: TObject);
    Procedure SetRichEditFontName(Value: string);
    { Bypass VCL bug as it doesn't set the CharSet }
  public
    wwRulerPanel: TwwRulerPanel;
    procedure ResizeBar; virtual;
    destructor Destroy; override;
    procedure RefreshControls;
    procedure Initialize;
  end;

  TwwRichEditBar = class(TPanel)
  private
    FCanvas: TCanvas;
    RichEdit1: TwwDBRichEdit;
    FOptions: TwwRichEditBarOptions;

    procedure WMMeasureItem(var Message: TWMMeasureItem);
      message WM_MEASUREITEM;
    procedure WMDrawItem(var Message: TWMDrawItem); message WM_DRAWITEM;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    function GetRichEdit: TwwDBRichEdit;
    // procedure SetRichEdit(value: TwwDBRichEdit);
    procedure SetOptions(val: TwwRichEditBarOptions);

    // function GetToolBar: TToolBar;
    procedure CreateComponent(Reader: TReader; ComponentClass: TComponentClass;
      var Component: TComponent);
    procedure RichEditSelectionChange(Sender: TObject);
  protected
    // procedure WriteComponents(Writer: TWriter); override;
{$IFNDEF wwDelphi2008Up}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ENDIF}
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure Loaded; override;
    procedure RichEditBarFrameNeeded;
    procedure ApplyIntl; virtual;

  public
    RichEditBarFrame: TwwRichBarFrame;

    constructor Create(AOwner: TComponent); override;
    procedure CreateWnd; override;
    destructor Destroy; override;
{$IFDEF wwDelphi2008Up}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ENDIF}
    procedure Resize; override;
    procedure UpdateControlPositions;
    procedure InvertIcons;

    // property ToolBar: TToolBar read GetToolBar;

  published
    property RichEdit: TwwDBRichEdit read GetRichEdit;
    // stored false;// write SetRichEdit;
    property Options: TwwRichEditBarOptions read FOptions write SetOptions
      default [rebShowLoad, rebShowSaveAs, rebShowPrint, rebShowPrintPreview,
      rebShowPageSetup, rebShowFormatBar, rebShowToolBar, rebShowHints,
      rebShowRuler, rebFlatButtons, rebShowJustifyButton, rebShowZoomCombo];

  end;

implementation

{$R *.dfm}

uses wwrich;

const
  ColorBoxWidth = 40;

function TwwRichEditBar.GetRichEdit: TwwDBRichEdit;
begin
  result := RichEdit1;
end;

procedure TwwRichEditBar.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  inherited;
  {
    if RichEdit <> nil then
    begin
    Proc(RichEdit);
    end;
  }
end;

procedure TwwRichEditBar.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
end;

procedure TwwRichEditBar.InvertIcons;
const
  tbl: Array [0..35] of boolean = (
     true, true, true, false, true, true, true, true, true, false, // 0-9
     false, true, false, true, false, false, true, false, false, false, //10-19
     false, false, true, true, false, true, false, false, true, true, //20-29
     false, true, true, false, false, false);

var
  image: TBitmap;
  i: Integer;

  procedure InvertBitmap(Bitmap: TBitmap; NewColor, OldColor: TColor);
  var
    R: TRect;
    b: TBitmap;
  begin
    b := TBitmap.Create;
    try
      b.assign(Bitmap);
      R := Rect(0, 0, Bitmap.Width, Bitmap.Height);

      Bitmap.Canvas.CopyMode := cmDstInvert;
      Bitmap.Canvas.CopyRect(R, b.Canvas, R);

      b.assign(Bitmap);
      Bitmap.Canvas.CopyMode := cmSrcCopy;
      Bitmap.Canvas.Brush.Color := clFuchsia;
      Bitmap.Canvas.BrushCopy(R, b, R, clBlack);
      // Bitmap.Canvas.Brush.Color := clBlack;
      // Bitmap.Canvas.BrushCopy(R, b, R, clWhite);
    finally
      b.Free;
    end
  end;

begin
  image := TBitmap.Create;
  for i := 0 to RichEditBarFrame.RichEditButtonIcons.Count - 1 do
  begin
    image.Free;
    image := TBitmap.Create;
    if not tbl[i] then continue;
    RichEditBarFrame.RichEditButtonIcons.GetBitmap(i, image);
    InvertBitmap(image, clWhite, clBlack);
    RichEditBarFrame.RichEditButtonIcons.Delete(i);
    RichEditBarFrame.RichEditButtonIcons.InsertMasked(i, image, clFuchsia);
  end;
  image.Free;

end;

procedure TwwRichEditBar.Loaded;

begin
  inherited Loaded;
  if csDesigning in ComponentState then
    exit;

  RichEditBarFrameNeeded;
  // RichEditBarFrame.ResizeBar;
  UpdateControlPositions;
  RichEdit1.Visible := true;
  RichEditBarFrame.RefreshControls;

  if RichEdit1.EffectiveEditWidth = rewPrinterSize then
  // editwidth streamed in after createwnd
  begin
    RichEditBarFrame.wwRulerPanel.UpdateSize(RichEdit1);
    RichEditBarFrame.wwRulerPanel.UpdateDragIcons;
    RichEditBarFrame.wwRulerPanel.UpdateRulerProp
      (RichEditBarFrame.wwRulerPanel.RightDragButton);
  end;

  // The following code is necessary so that the style scrollbars are
  // used. Without this code we don't see the style scrollbars
  if wwIsCustomStyle(self) then
    self.RichEdit1.Perform(CM_RECREATEWND, 0, 0);

  if wwIsCustomstyle(self) then
  begin
     if (rebInvertColorsInToolbar in Options) then
       InvertIcons;
  end;
end;

procedure TwwRichEditBar.ReadState(Reader: TReader);
begin
  Classes.RegisterClass(TwwDBRichEdit);
  // necessary or TwwDBRichEdit class not recognized
  Reader.OnCreateComponent := CreateComponent;
  inherited;
  Reader.OnCreateComponent := Nil;
end;

procedure TwwRichEditBar.CreateComponent(Reader: TReader;
  ComponentClass: TComponentClass; var Component: TComponent);
begin
  // Do not create new instances of the subcomponents
  // but use the ones created by the constructor.
  if (ComponentClass = TwwDBRichEdit) then
  begin
    Component := RichEdit1;
  end;
end;

constructor TwwRichEditBar.Create(AOwner: TComponent);
begin
  RichEditBarFrame := nil;
  inherited Create(AOwner);
  FCanvas := TCanvas.Create;

  RichEdit1 := TwwDBRichEdit.Create(self);
  // RichEdit1.HideScrollBars:=false;
  RichEdit1.HideScrollBars := true;
  RichEdit1.GutterWidth := 6;
  RichEdit1.HideSelection := false;
  RichEdit1.ScrollBars := ssVertical;
  RichEdit1.SetSubComponent(true);
  // RichEdit1.SetSubComponent(false);
  RichEdit1.Name := 'RichEdit';
  RichEdit1.ParentFont := false;

  FOptions := [rebShowLoad, rebShowSaveAs, rebShowPrint, rebShowPrintPreview,
    rebShowPageSetup, rebShowFormatBar, rebShowToolBar, rebShowHints,
    rebShowRuler, rebFlatButtons, rebShowJustifyButton, rebShowZoomCombo];

  if csDesigning in ComponentState then
    ControlStyle := ControlStyle - [csAcceptsControls];
  // Don't allow controls to be dropped in at design time

end;

destructor TwwRichEditBar.Destroy;
begin
  if RichEditBarFrame <> nil then
  begin
    RichEditBarFrame.Free;
    RichEditBarFrame := nil;
  end;

  inherited Destroy;
  FCanvas.Free;

end;

destructor TwwRichBarFrame.Destroy;
begin
  inherited Destroy;

  FCanvas.Free;
  // RichEdit.Free;
end;

procedure TwwRichEditBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) then
  begin
    // if (RichEdit=AComponent) then
    // SetRichEdit(nil);
  end;
end;

procedure TwwRichBarFrame.ResizeBar;
begin
  if not RichEdit1.HandleAllocated then
    exit;

  TwwRulerPanel(wwRulerPanel).RightDragButton.MaxValue :=
    TwwRulerPanel(wwRulerPanel).RulerRect.Right -
    (TwwRulerPanel(wwRulerPanel).RightDragButton.Width div 2);
  {
    RichEdit1.top := wwRulerPanel.top + wwRulerPanel.Height + 2;
    RichEdit1.Height := RichEditBar.Height - RichEdit1.top;
    RichEdit1.Left := 0;
    RichEdit1.Width := RichEditBar.Width;
    wwRulerPanel.UpdateSize(RichEdit1);
    TwwRulerPanel(wwRulerPanel).UpdateDragIcons;

    // 6/20/08 - Adjust sizes
    FormatBar.Width := FormatBar.Parent.Width;
    Toolbar.Width := Toolbar.Parent.Width;
  }
  // ! Refer to options here
end;

procedure TwwRichEditBar.ApplyIntl;
begin
  with wwInternational.RichEdit, RichEditBarFrame do
  begin

    if (reoShowHints in RichEdit1.EditorOptions) then
    begin
      FontNameCombo.ShowHint := true;
      FontSizeCombo.ShowHint := true;
      NewButton.ShowHint := true;
      LoadButton.ShowHint := true;
      SaveAsButton.ShowHint := true;
      PrintButton.ShowHint := true;
      PrintPreviewButton.ShowHint := true;
      FindButton.ShowHint := true;
      CutButton.ShowHint := true;
      CopyButton.ShowHint := true;
      UndoButton.ShowHint := true;
      RedoButton.ShowHint := true;
      PasteButton.ShowHint := true;
      BoldButton.ShowHint := true;
      NumberingButton.ShowHint := true;
      UnderlineButton.ShowHint := true;
      ColorButton.ShowHint := true;
      ItalicButton.ShowHint := true;
      LeftButton.ShowHint := true;
      CenterButton.ShowHint := true;
      RightButton.ShowHint := true;
      JustifyButton.ShowHint := true;
      BulletButton.ShowHint := true;
      HighlightButton.ShowHint := true;
      SpellButton.ShowHint := true;
      InsertObjectButton.ShowHint := true;
      FormatOptionsButton.ShowHint := true;

      { Change Hints }
      FontNameCombo.Hint := FontNameComboHint;
      FontSizeCombo.Hint := FontSizeComboHint;

      { Buttons }
      NewButton.Hint := NewButtonHint;
      LoadButton.Hint := LoadButtonHint;
      SaveAsButton.Hint := SaveAsButtonHint;
      PrintButton.Hint := PrintButtonHint;
      PrintPreviewButton.Hint := PrintPreviewButtonHint;
      FindButton.Hint := FindButtonHint;
      CutButton.Hint := CutButtonHint;
      CopyButton.Hint := CopyButtonHint;
      UndoButton.Hint := UndoButtonHint;
      SpellButton.Hint := SpellCheckHint;
      FormatOptionsButton.Hint := FormatCaptionHint;

      RedoButton.Hint := RedoButtonHint;
      if RedoButton.Hint = '' then
        RedoButton.Hint := '重做 | 还原上一步操作';

      ZoomCombo.Hint := ZoomComboHint;
      if ZoomCombo.Hint = '' then
        ZoomCombo.Hint := '放大 | 放大文本';

      PasteButton.Hint := PasteButtonHint;
      BoldButton.Hint := BoldButtonHint;
      ColorButton.Hint := ColorButtonHint;
      InsertObjectButton.Hint := InsertObjectHint;

      UnderlineButton.Hint := UnderlineButtonHint;
      ItalicButton.Hint := ItalicButtonHint;
      LeftButton.Hint := LeftButtonHint;
      CenterButton.Hint := CenterButtonHint;
      JustifyButton.Hint := JustifyButtonHint;
      RightButton.Hint := RightButtonHint;
      BulletButton.Hint := BulletButtonHint;
      NumberingButton.Hint := NumberingButtonHint;
      if NumberingButton.Hint = '' then
        NumberingButton.Hint := '数字编号 | 给选中的文本添加数字编号';

      HighlightButton.Hint := HighlightButtonHint;

      { View Menu Items }
      Toolbar.Hint := ToolbarHint;
      FormatBar.Hint := FormatBarHint;
    end;

  end;
end;

procedure TwwRichEditBar.UpdateControlPositions;
var
  CurrentTop: Integer;
  ShowInsertObject: Boolean;
begin
  RichEditBarFrameNeeded;
  RichEditBarFrame.ResizeBar;
  CurrentTop := 0;

  with RichEditBarFrame do
  begin
    LoadButton.Visible := rebShowLoad in Options;
    SaveAsButton.Visible := rebShowSaveAs in Options;
    PrintButton.Visible := rebShowPrint in Options;
    PrintPreviewButton.Visible := rebShowPrintPreview in Options;
    Sep2.Visible := PrintButton.Visible or PrintPreviewButton.Visible;

    JustifyButton.Visible := rebShowJustifyButton in Options;
    SpellButton.Visible := rebShowSpellCheck in Options;
    ApplyIntl;

    ShowInsertObject := (rpoPopupInsertObject in RichEdit1.PopupOptions) and
      not(reoDisableOLE in RichEdit1.OLEOPtions);
    InsertObjectButton.Visible := ShowInsertObject;
    ZoomCombo.Visible := (rebShowZoomCombo in Options) and
      wwInternational.Compatibilty.RichEditEnableZoom;

    if (rebShowToolBar in Options) then
    begin
      if csDesigning in ComponentState then
      begin
        Toolbar.ControlStyle := Toolbar.ControlStyle - [csNoDesignVisible];
      end;
      Toolbar.Width := Toolbar.Parent.Width;
      Toolbar.Visible := true;

      CurrentTop := Toolbar.top + Toolbar.Height + 2;
      if (rebShowFormatBar in Options) then
      begin
        FormatBarBevel.Visible := true;
        FormatBarBevel.top := CurrentTop - 2;
      end;

    end
    else
    begin
      if csDesigning in ComponentState then
      begin
        Toolbar.ControlStyle := Toolbar.ControlStyle + [csNoDesignVisible];
      end;
      Toolbar.Visible := false;
      FormatBarBevel.Visible := false;
    end;

    if (rebShowFormatBar in Options) then
    begin
      FormatBar.top := CurrentTop + 1;
      FormatBar.Width := FormatBar.Parent.Width;
      FormatBar.Visible := true;
      CurrentTop := FormatBar.top + FormatBar.Height + 2;
      if (rebShowRuler in Options) then
      begin
        RulerBevel.Visible := true;
        RulerBevel.top := CurrentTop;
      end;
    end
    else
    begin
      FormatBar.Visible := false;
      RulerBevel.Visible := false;
    end;

    if (rebShowRuler in Options) then
    begin
      wwRulerPanel.Visible := true;
      wwRulerPanel.top := CurrentTop + 1;
      CurrentTop := wwRulerPanel.top + wwRulerPanel.Height + 2;
    end
    else
    begin
      wwRulerPanel.Visible := false;
      RulerBevel.Visible := false;
    end;

    Toolbar.Flat := (rebFlatButtons in Options);
    FormatBar.Flat := (rebFlatButtons in Options);
    if (rebGradientToolbars in Options) then
    begin
      FormatBar.DrawingStyle := TTBDrawingStyle.dsGradient;
      Toolbar.DrawingStyle := TTBDrawingStyle.dsGradient;
    end;
    RichEdit.top := CurrentTop;
    RichEdit.Height := RichEditBar.Height - RichEdit.top;
    RichEdit.Width := RichEditBar.Width;

    wwRulerPanel.UpdateSize(RichEdit1);
    TwwRulerPanel(wwRulerPanel).UpdateDragIcons;

  end;

end;

procedure TwwRichEditBar.RichEditSelectionChange(Sender: TObject);
begin
  if RichEdit1.Visible then
    self.RichEditBarFrame.RefreshControls;
end;

procedure TwwRichBarFrame.RichEditBarEnter(Sender: TObject);
begin
  // richedit1.setfocus;
end;

procedure TwwRichBarFrame.RightButtonClick(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taRightJustify;
  RefreshControls;
end;

procedure TwwRichBarFrame.RedoButtonClick(Sender: TObject);
begin
  SendMessage(RichEdit1.Handle, EM_REDO, 0, 0);
  RefreshControls;

end;

Procedure TwwRichBarFrame.RefreshControls;
var
  haveSelection: Boolean;
begin
  if RichEdit1 = nil then
    exit;
  if not RichEdit1.HandleAllocated then
    exit;

  RichEdit1.HandleNeeded;
  BoldButton.down := fsBold in RichEdit1.SelAttributes.Style;
  UnderlineButton.down := fsUnderline in RichEdit1.SelAttributes.Style;
  ItalicButton.down := fsItalic in RichEdit1.SelAttributes.Style;
  FontNameCombo.itemIndex := FontNameCombo.items.indexOf
    (RichEdit1.SelAttributes.Name);
  if FontNameCombo.itemIndex < 0 then
  begin
    FontNameCombo.text := RichEdit1.SelAttributes.Name;
    FontNameCombo.font.Color := clRed;
  end
  else
    FontNameCombo.font.Color := clWindowText;
  FontSizeCombo.itemIndex := FontSizeCombo.items.indexOf
    (inttostr(RichEdit1.SelAttributes.Size));

  // 9/5/2001- If no font size in dropdown still set text to current size. Just like wordpad.
  if FontSizeCombo.itemIndex = -1 then
    FontSizeCombo.text := inttostr(RichEdit1.SelAttributes.Size);

  BulletButton.down := RichEdit1.Numbering = renBullet;
  // Paragraph.Numbering = nsBullet;
  NumberingButton.down := RichEdit1.Numbering > renBullet;

  // 10/02/2001 - More accurate way of determining if background color is highlighted.
  HighlightButton.down := (ColorToRGB(RichEdit1.GetTextBackgroundColor)
    = ColorToRGB(RichEdit1.HighlightColor));

  // BulletStyle1.checked:= BulletButton.down;
  if ord(RichEdit1.Paragraph.Alignment) = PFA_FULLJUSTIFY - 1 then
    JustifyButton.down := true
  else
  begin
    case RichEdit1.Paragraph.Alignment of
      taLeftJustify:
        LeftButton.down := true;
      taCenter:
        CenterButton.down := true;
      taRightJustify:
        RightButton.down := true;
    end;
  end;

  PasteButton.enabled := RichEdit1.CanPaste and (not RichEdit1.readonly);
  if PasteButton.enabled then
    PasteButton.ImageIndex := 21
  else
    PasteButton.ImageIndex := 34;

  UndoButton.enabled := RichEdit1.CanUndo;
  RedoButton.enabled := RichEdit1.CanRedo;

  haveSelection := RichEdit1.CanCut;
  // haveText:= RichEdit1.text<>''; { This line was very slow for larger buffers }
  { haveText:= (RichEdit1.Lines.Count>1) or
    (RichEdit1.Lines.Count=1) and (RichEdit1.Lines[0]<>'');
  }
  CutButton.enabled := haveSelection and (not RichEdit1.readonly);


  if CutButton.enabled then
  begin
    if wwIsCustomStyle(nil) then
      CutButton.ImageIndex := 32
    else
      CutButton.ImageIndex := 20
  end
  else
    CutButton.ImageIndex := 32;

  CopyButton.enabled := haveSelection;
  if CopyButton.enabled then
    CopyButton.ImageIndex := 19
  else
    CopyButton.ImageIndex := 33;

  TwwRulerPanel(wwRulerPanel).UpdateDragIcons;

end;

procedure TwwRichBarFrame.ColorClick(Sender: TObject);
begin
  RichEdit1.SelAttributes.Color := (Sender as TMenuItem).Tag;
end;

procedure TwwRichBarFrame.InitColorMenu;
var
  i: Integer;
  procedure SetOwnerDraw(Item: TMenuItem);
  type
    TwwMenuItemInfo = packed record
      cbSize: UINT;
      fMask: UINT;
      fType: UINT; { used if MIIM_TYPE }
      fState: UINT; { used if MIIM_STATE }
      wID: UINT; { used if MIIM_ID }
      hSubMenu: HMENU; { used if MIIM_SUBMENU }
      hbmpChecked: HBITMAP; { used if MIIM_CHECKMARKS }
      hbmpUnchecked: HBITMAP; { used if MIIM_CHECKMARKS }
      dwItemData: DWORD; { used if MIIM_DATA }
      dwTypeData: PAnsiChar; { used if MIIM_TYPE }
      cch: UINT; { used if MIIM_TYPE }
    end;
  var
    mii: TMenuItemInfo;
  begin
    FillChar(mii, SizeOf(TMenuItemInfo), 0);
    mii.cbSize := SizeOf(TwwMenuItemInfo);
    mii.fMask := MIIM_TYPE or MIIM_DATA;
    mii.fType := MFT_OWNERDRAW;
    mii.dwItemData := Integer(Item);
    SetMenuItemInfo(Item.Parent.Handle, Item.MenuIndex, true, mii);
  end;

begin
  for i := 0 to PopupMenu1.items.Count - 1 do
  begin
    SetOwnerDraw(PopupMenu1.items[i]);
    PopupMenu1.items[i].OnClick := ColorClick;
  end;
  Automatic1.Tag := RichEdit1.font.Color; { Use richedit's font color }
end;

procedure TwwRichBarFrame.abs1Click(Sender: TObject);
begin
  RichEdit1.ExecuteTabDialog;
end;

procedure TwwRichBarFrame.BoldButtonClick(Sender: TObject);
begin
  RichEdit1.SetStyleAttribute(fsBold, not tempDown);
  RefreshControls;
end;

procedure TwwRichBarFrame.BoldButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  tempDown := (Sender as TToolButton).down;
end;

procedure TwwRichBarFrame.BulletButtonClick(Sender: TObject);
begin
  RichEdit1.SetBullet(not tempDown);
  RefreshControls;
end;

procedure TwwRichBarFrame.CenterButtonClick(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taCenter;
  RefreshControls;
end;

procedure TwwRichBarFrame.ColorButtonClick(Sender: TObject);
var
  p: TPoint;
begin
  p := FormatBar.ClientToScreen(Point(ColorButton.Left,
    ColorButton.top + ColorButton.Height));

  TrackPopupMenu(PopupMenu1.Handle, TPM_LEFTALIGN, p.X - 1, p.Y, 0,
    RichEditBar.Parent.Handle, nil);
  // p.x-1, p.y, 0, handle, nil);
end;

procedure TwwRichBarFrame.CopyButtonClick(Sender: TObject);
begin
  RichEdit1.CopyToClipboard;
end;

procedure TwwRichBarFrame.CutButtonClick(Sender: TObject);
begin
  RichEdit1.CutToClipboard;
end;

procedure TwwRichBarFrame.FindButtonClick(Sender: TObject);
begin
  RichEdit1.ExecuteFindDialog;
end;

procedure TwwRichBarFrame.Font1Click(Sender: TObject);
begin
  RichEdit1.ExecuteFontDialog;
end;

procedure TwwRichBarFrame.FontNameComboCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  if not Select then
    exit;
  SetRichEditFontName(FontNameCombo.text);
  RichEdit1.SetFocus;
  RefreshControls;
end;

procedure TwwRichBarFrame.FontSizeComboCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  if not Select then
    exit;
  if FontSizeCombo.text = '' then
    exit;
  RichEdit1.SelAttributes.Size := StrToInt(FontSizeCombo.text);
  RichEdit1.SetFocus;
  RefreshControls;
end;

procedure TwwRichBarFrame.HighlightButtonClick(Sender: TObject);
begin
  with (Sender as TToolButton) do
  begin
    if not down then
      RichEdit1.SetTextBackgroundColor(-1)
    else
      RichEdit1.SetTextBackgroundColor(RichEdit1.HighlightColor);
  end;
  RefreshControls;

end;

procedure TwwRichBarFrame.Initialize;
var // dragButton: TwwTrackIcon;
  i: Integer;
  PixelsPerInch: Integer;
  zoomPercent, selectedIndex: Integer;
begin

  wwRulerPanel := TwwRulerPanel.Create(self);

  with wwRulerPanel do
  begin
    RichEdit := RichEdit1;
    ParentColor := true;
    Parent := RichEditBar;
    top := FormatBar.top + FormatBar.Height + 10;
    PixelsPerInch := Screen.PixelsPerInch;
    if PixelsPerInch > 96 then
      Height := 27
    else
      Height := 25;

    BevelOuter := bvNone;
    // wwRulerPanel.RulerRect:= Rect(6, 4, wwRulerPanel.Width-6, wwRulerPanel.Height-4); //RulerHeight);
  end;

  wwRulerPanel.UpdateSize(RichEdit1);
  {
    if RichEdit1.EffectiveEditWidth = rewPrinterSize then
    wwRulerPanel.UpdateSize(RichEdit1)
    else
    wwRulerPanel.Width := Width;

    wwRulerPanel.RulerRect := Rect(3 + RichEdit1.GutterWidth, 4,
    wwRulerPanel.Width - 6, wwRulerPanel.Height - 4); // RulerHeight);
  }
  wwRulerPanel.CreateDragButtons;
  wwRulerPanel.Align := alNone;

  for i := 0 to Screen.Fonts.Count - 1 do
  begin
    if (RichEdit1.EffectiveEditWidth = rewWindowSize) or
      (Printer.Fonts.indexOf(Screen.Fonts[i]) >= 0) then
      FontNameCombo.items.Add(Screen.Fonts[i]);
  end;

  // Zoom support
  zoomPercent := Trunc(RichEdit1.ZoomFactor * 100);
  selectedIndex := ZoomCombo.items.indexOf(inttostr(zoomPercent) + '%');
  if (selectedIndex >= 0) then
    ZoomCombo.itemIndex := selectedIndex
  else
    ZoomCombo.text := inttostr(zoomPercent) + '%';

  RefreshControls;

  InitColorMenu;
  FCanvas := TCanvas.Create;
end;

procedure TwwRichBarFrame.InsertObjectButtonClick(Sender: TObject);
begin
  RichEdit1.InsertObjectDialog;
end;

procedure TwwRichBarFrame.ItalicButtonClick(Sender: TObject);
begin
  RichEdit1.SetStyleAttribute(fsItalic, not tempDown);
  RefreshControls;
end;

procedure TwwRichBarFrame.JustifyButtonClick(Sender: TObject);
begin
  RichEdit1.SetParaFormat([rpoAlignment],
    wwInternational.RichEdit.ParagraphDialog.AlignJustify, false, 0, 0, 0, 0,
    nil, 0, 0, 0, 0);
  RefreshControls;
end;

procedure TwwRichBarFrame.LeftButtonClick(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taLeftJustify;
  RefreshControls;

end;

procedure TwwRichBarFrame.LoadButtonClick(Sender: TObject);
var
  parentform: TCustomForm;
begin
  parentform := GetParentForm(RichEdit1);

  if parentform is TwwRichEditForm then
  begin
    TwwRichEditForm(parentform).Load1Click(Sender);
  end
  else if OpenDialog1.Execute then
  begin
    RichEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
    RichEdit1.SetFocus;
  end;

end;

procedure TwwRichBarFrame.NewButtonClick(Sender: TObject);
begin
  if MessageDlg(wwInternational.UserMessages.RichEditClearWarning,
    mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then
    exit;
  RichEdit1.clear;
  RichEdit1.modified := true;
end;

procedure TwwRichBarFrame.NumberingButtonClick(Sender: TObject);
begin
  if RichEdit1.Numbering <= renBullet then
    RichEdit1.Numbering := renArabic
  else
    RichEdit1.Numbering := renNone;
  RefreshControls;
end;

procedure TwwRichBarFrame.NumberingButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  tempDown := (Sender as TToolButton).down;
end;

procedure TwwRichBarFrame.Paragraph1Click(Sender: TObject);
begin
  RichEdit1.ExecuteParagraphDialog;
end;

procedure TwwRichBarFrame.PasteButtonClick(Sender: TObject);
begin
  RichEdit1.PasteFromClipboard;
end;

procedure TwwRichBarFrame.PrintButtonClick(Sender: TObject);
var
  parentform: TCustomForm;
begin
  parentform := GetParentForm(RichEdit1);

  if parentform is TwwRichEditForm then
  begin
    TwwRichEditForm(parentform).Print1Click(Sender);
  end
  else
  begin
    PrintDialog1.collate := true;
    if PrintDialog1.Execute then
    begin
      RichEdit1.Print(RichEdit1.PrintJobName);
    end
  end;

end;

procedure TwwRichBarFrame.SaveAsButtonClick(Sender: TObject);
var
  parentform: TCustomForm;
begin
  parentform := GetParentForm(RichEdit1);

  if parentform is TwwRichEditForm then
  begin
    TwwRichEditForm(parentform).SaveAs1Click(Sender);
  end
  else if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
      if MessageDlg(Format('OK to overwrite %s', [SaveDialog1.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then
        exit;
    if SaveDialog1.filterindex = 2 then { 6/8/00 - Save as plain text }
    begin
      RichEdit1.plaintext := true;
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName);
      RichEdit1.plaintext := false;
    end
    else
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName);
  end;

end;

Procedure TwwRichBarFrame.SetRichEditFontName(Value: string);
var
  Format: TCharFormat;
begin
  if RichEdit1.SelAttributes.Name = Value then
    exit;
  FillChar(Format, SizeOf(TCharFormat), 0);
  Format.cbSize := SizeOf(TCharFormat);
  with Format do
  begin
    dwMask := CFM_FACE OR CFM_CHARSET;
    StrPLCopy(szFaceName, Value, SizeOf(szFaceName));
    bCharSet := RichEdit1.GetCharSetOfFontName(Value);
  end;
  SendMessage(RichEdit1.Handle, EM_SETCHARFORMAT, SCF_SELECTION,
    LPARAM(@Format));
end;

procedure TwwRichBarFrame.SpellButtonClick(Sender: TObject);
begin
  RichEdit1.MSWordSpellChecker;
end;

procedure TwwRichBarFrame.PrintPreviewButtonClick(Sender: TObject);
begin
  RichEdit1.PrintPreview;
end;

procedure TwwRichBarFrame.UnderlineButtonClick(Sender: TObject);
begin
  RichEdit1.SetStyleAttribute(fsUnderline, not tempDown);
  RefreshControls;

end;

procedure TwwRichBarFrame.UndoButtonClick(Sender: TObject);
begin
  SendMessage(RichEdit1.Handle, EM_UNDO, 0, 0);
  RefreshControls;

end;

procedure TwwRichBarFrame.ZoomComboCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
var
  zoom: double;
begin
  if (ZoomCombo.itemIndex = 0) then
    zoom := 5
  else if (ZoomCombo.itemIndex = 1) then
    zoom := 2
  else if (ZoomCombo.itemIndex = 2) then
    zoom := 1.5
  else if (ZoomCombo.itemIndex = 3) then
    zoom := 1
  else if (ZoomCombo.itemIndex = 4) then
    zoom := 0.75
  else if (ZoomCombo.itemIndex = 5) then
    zoom := 0.5
  else if (ZoomCombo.itemIndex = 6) then
    zoom := 0.25
  else
    zoom := 1;
  RichEdit1.ZoomFactor := zoom;

  if wwRulerPanel <> nil then
    TwwRulerPanel(wwRulerPanel).UpdateSize(RichEdit1);
  RefreshControls;
  wwRulerPanel.Invalidate;
end;

function DrawText(Canvas: TCanvas; AText: string; ARect: TRect;
  Style: Integer): TRect;
const
  DT_DISABLED = $80000;
begin
  with Canvas do
  begin
    // Used by DrawText API Function when "Item" has focus.
    SetBkColor(Handle, ColorToRGB(Brush.Color));
    SetTextColor(Handle, ColorToRGB(font.Color));

    Refresh;
    if (Style and DT_DISABLED <> 0) and (Style and DT_CALCRECT = 0) then
    begin
      font.Color := clBtnHighlight;
      OffSetRect(ARect, 1, 1);
      Windows.DrawText(Handle, PChar(AText), Length(AText), ARect, Style);
      SetBkMode(Handle, TRANSPARENT);
      OffSetRect(ARect, -1, -1);
      font.Color := clBtnShadow;
    end;
    Windows.DrawTextEx(Handle, PChar(AText), Length(AText), ARect, Style, nil);
    result := ARect;
  end;
end;

procedure TwwRichEditBar.WMCommand(var Message: TWMCommand);
var
  Item: TMenuItem;
begin
  inherited;
  if (Message.NotifyCode = 0) and (RichEditBarFrame.PopupMenu1 <> nil) then
  begin
    Item := RichEditBarFrame.PopupMenu1.FindItem(Message.itemID, fkCommand);
    if Item <> nil then
      Item.Click;
  end
end;

procedure TwwRichEditBar.WMMeasureItem(var Message: TWMMeasureItem);
var
  Item: TMenuItem;
  function GetMenuFont: HFONT;
  var
    NonClientMetrics: TNonClientMetrics;
  begin
    NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0)
    then
      result := CreateFontIndirect(NonClientMetrics.lfMenuFont)
    else
      result := GetStockObject(SYSTEM_FONT);
  end;

const
  VertPadding = 2;
  HorzPadding = 5;
begin
  inherited;
  if Message.MeasureItemStruct^.CtlType <> ODT_MENU then
    exit;
  with Message.MeasureItemStruct^ do
  begin
    Item := TMenuItem(itemData);
    FCanvas.Handle := GetDC(0);
    FCanvas.font.Handle := GetMenuFont;
    itemHeight := FCanvas.TextHeight(Item.Caption) + VertPadding;
    itemWidth := FCanvas.TextWidth(Item.Caption) + HorzPadding + ColorBoxWidth;
    FCanvas.font.Handle := 0;
    ReleaseDC(0, FCanvas.Handle);
    FCanvas.Handle := 0;
  end;
end;

procedure TwwRichEditBar.WMDrawItem(var Message: TWMDrawItem);
const
  VertMargin = 2;
  HorzMargin = 3;
var
  Item: TMenuItem;
  ColorRect: TRect;
begin
  inherited;
  if Message.DrawItemStruct^.CtlType <> ODT_MENU then
    exit;
  with Message.DrawItemStruct^ do
  begin
    FCanvas.Handle := hDC;
    Item := TMenuItem(itemData);
    if ODS_SELECTED and itemState <> 0 then
    begin
      FCanvas.Brush.Color := clHighlight;
      FCanvas.Pen.Color := clHighlightText;
      FCanvas.Pen.Color := clBlack;
      FCanvas.font.Color := clHighlightText;
    end
    else
    begin
      FCanvas.Brush.Color := clBtnFace;
      FCanvas.Pen.Color := clWindowText;
      FCanvas.font.Color := clWindowText
    end;
    FCanvas.FillRect(rcItem);

    ColorRect := Rect(rcItem.Left + HorzMargin, rcItem.top + VertMargin,
      rcItem.Left + HorzMargin + ColorBoxWidth, rcItem.Bottom - VertMargin);
    DrawText(FCanvas, Item.Caption, Rect(ColorRect.Right + 1 * HorzMargin,
      rcItem.top, rcItem.Right, rcItem.Bottom), DT_VCENTER or DT_SINGLELINE);

    FCanvas.Brush.Color := Item.Tag;
    FCanvas.Rectangle(ColorRect.Left, ColorRect.top, ColorRect.Right,
      ColorRect.Bottom);

    FCanvas.Handle := 0;
  end;
end;

Procedure TwwRichEditBar.RichEditBarFrameNeeded;
begin
  if RichEditBarFrame = nil then
  begin
    RichEditBarFrame := TwwRichBarFrame.Create(self);
    RichEdit1.Parent := RichEditBarFrame.RichEditBar;
    RichEditBarFrame.RichEdit1 := self.RichEdit1;
    RichEditBarFrame.Initialize;
    RichEditBarFrame.RichEditBar.Parent := self;
    RichEditBarFrame.RichEditBar.Align := alClient;
    RichEdit1.OnSelectionChange := RichEditSelectionChange;
  end;

end;

procedure TwwRichEditBar.CreateWnd;
begin
  inherited CreateWnd;
  RichEditBarFrameNeeded;
  UpdateControlPositions;
end;

procedure TwwRichEditBar.Resize;
begin
  inherited Resize;

  if (RichEditBarFrame <> nil) then
  begin
    UpdateControlPositions
    // RichEditBarFrame.ResizeBar;
  end
end;

procedure TwwRichEditBar.SetOptions(val: TwwRichEditBarOptions);
begin
  FOptions := val;
  if (RichEditBarFrame <> nil) then
    UpdateControlPositions;

end;

end.
