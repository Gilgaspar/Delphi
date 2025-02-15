{
  //
  // Components : TwwRichEditForm
  //
  // Copyright (c) 1998-2001 by Woll2Woll Software
  //
  // 9/15/98 - Only show InsertObject if not readonly
  // 12/23/98 - Include Redo hint for Delphi 4
  // 2/24/99 - No messagedlg if readonly - In case of resize which would set modified flag
  // 2/15/00 - Remove loop for printing
  // 6/8/00 - Save as plain text when user selects text type
  // 9/5/2001- If no font size in dropdown still set text to current size. Just like wordpad.
  // 10/02/2001 - More accurate way of determining if background color is highlighted.
}

unit vcl.Wwrich;

interface

{$I wwIfDef.pas}
{$R-}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, DBCtrls, ExtCtrls, Db, StdCtrls,
  ComCtrls, Grids, DBGrids, wwdbedit, Wwdotdot, Wwdbcomb, Buttons, richedit,
  Menus, wwrchdlg, wwriched, wwintl, wwrichtb, printers, commdlg, winspool,
  wwTrackIcon, ImgList, wwricheditbar,
  system.Types, system.UITypes, System.ImageList;
type

  TwwRichEditForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Print1: TMenuItem;
    PageSetup1: TMenuItem;
    SaveExit1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    EditSep1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Clear1: TMenuItem;
    SelectAll1: TMenuItem;
    EditSep2: TMenuItem;
    Find1: TMenuItem;
    FindNext1: TMenuItem;
    Replace1: TMenuItem;
    View1: TMenuItem;
    Toolbar1: TMenuItem;
    FormatBar1: TMenuItem;
    StatusBar: TStatusBar;
    OptionsSep: TMenuItem;
    Options1: TMenuItem;
    Insert1: TMenuItem;
    DateandTime1: TMenuItem;
    Format1: TMenuItem;
    Font1: TMenuItem;
    BulletStyle1: TMenuItem;
    Paragraph1: TMenuItem;
    Tabs1: TMenuItem;
    Help1: TMenuItem;
    StatusBar1: TMenuItem;
    PrintDialog1: TPrintDialog;
    FileSep2: TMenuItem;
    FileSep1: TMenuItem;
    Load1: TMenuItem;
    SaveAs1: TMenuItem;
    OpenDialog1: TOpenDialog;
    ToolBarBevel: TBevel;
    SaveDialog1: TSaveDialog;
    Ruler1: TMenuItem;
    InsertObject1: TMenuItem;
    Redo1: TMenuItem;
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
    Tools1: TMenuItem;
    Spelling1: TMenuItem;
    ImageListOld: TImageList;
    PrintPreview1: TMenuItem;
    ImageList1: TImageList;
    procedure BoldButtonClick(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure RightButtonClick(Sender: TObject);
    procedure CenterButtonClick(Sender: TObject);
    procedure LeftButtonClick(Sender: TObject);
    procedure BulletButtonClick(Sender: TObject);
    procedure RichEdit1SelectionChange(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Find1Click(Sender: TObject);
    procedure FindNext1Click(Sender: TObject);
    procedure Replace1Click(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure FontNameComboCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure FontSizeComboCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure BulletStyle1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Paragraph1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure FormatBar1Click(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SaveExit1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Tabs1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PageSetup1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure Toolbar1Click(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure SaveAsButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure UndoButtonClick(Sender: TObject);
    procedure FontNameComboDropDown(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Ruler1Click(Sender: TObject);
    procedure InsertObject1Click(Sender: TObject);
    procedure RedoButtonClick(Sender: TObject);
    procedure Redo1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Spelling1Click(Sender: TObject);
    procedure SpellButtonClick(Sender: TObject);
    procedure HighlightButtonClick(Sender: TObject);
    procedure BoldButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JustifyButtonClick(Sender: TObject);
    procedure PrintPreviewButtonClick(Sender: TObject);
    procedure NumberingButtonClick(Sender: TObject);
  private
    tempDown: Boolean;
    OrigOnHint: TNotifyEvent;
    FCanvas: TCanvas;
    //OldParent1, OldParent2: TWinControl;
    SkipClose: Boolean;
    Procedure RefreshControls;
    //Procedure SetRichEditFontName(Value: string);
    { Bypass VCL bug as it doesn't set the CharSet }
    Procedure UpdateStatusBar;
    procedure UpdateFormatToolBar(ShowToolBar, ShowFormatBar: Boolean);
    Procedure FormChangeHint(Sender: TObject);
    Procedure ApplyIntl;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure HorzScrollRichEdit(Sender: TObject);
    function GetToolBar: TToolBar;
    function GetFormatBar: TToolBar;
    procedure HandleDropDownKeysForCombo(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    OrigRichEdit: TwwCustomRichEdit;
    RichEdit1: TwwDBRichEdit;
    RichEditBar1: TwwRichEditBar;
    RulerPanel: TwwRulerPanel;
    property ToolBar: TToolBar read GetToolBar;
    property FormatBar: TToolBar read GetFormatBar;
  end;

const
  wwCentimetersPerInch = 2.537;

  // const wwCentimetersPerInch = 2.54;
var
  wwRichEditForm: TwwRichEditForm;

implementation

{$R *.DFM}

uses wwcommon;

const
  ColorBoxWidth = 40;

type
  TwwPageSetupDialog = class(TCommonDialog)
  public
    RichEdit1: TwwCustomRichEdit;
{$IFDEF wwDelphi3Up}
    function Execute: Boolean; override;
{$ELSE}
    function Execute: Boolean;
{$ENDIF}
  end;

procedure TwwRichEditForm.BoldButtonClick(Sender: TObject);
begin
  RichEdit1.SetStyleAttribute(fsBold, not tempDown);
  { if (TempDown) then
    richedit1.SelAttributes.Style:=
    richedit1.SelAttributes.Style -[fsBold]
    else
    richedit1.SelAttributes.Style:=
    richedit1.SelAttributes.Style +[fsBold]; }
  RefreshControls;
end;

procedure TwwRichEditForm.UnderlineButtonClick(Sender: TObject);
begin
  RichEdit1.SetStyleAttribute(fsUnderline, not tempDown);
  { if (TempDown) then
    richedit1.SelAttributes.Style:=
    richedit1.SelAttributes.Style -[fsUnderline]
    else
    richedit1.SelAttributes.Style:=
    richedit1.SelAttributes.Style +[fsUnderline]; }
  RefreshControls;
end;

procedure TwwRichEditForm.ItalicButtonClick(Sender: TObject);
begin
  RichEdit1.SetStyleAttribute(fsItalic, not tempDown);
  { if (TempDown) then
    richedit1.SelAttributes.Style:=
    richedit1.SelAttributes.Style -[fsItalic]
    else
    richedit1.SelAttributes.Style:=
    richedit1.SelAttributes.Style +[fsItalic]; }
  RefreshControls;
end;

procedure TwwRichEditForm.RightButtonClick(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taRightJustify;
  RefreshControls;
end;

procedure TwwRichEditForm.CenterButtonClick(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taCenter;
  RefreshControls;
end;

procedure TwwRichEditForm.LeftButtonClick(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taLeftJustify;
  RefreshControls;
end;

procedure TwwRichEditForm.BulletButtonClick(Sender: TObject);
begin
  RichEdit1.SetBullet(not tempDown);
  RefreshControls;
end;

procedure TwwRichEditForm.RichEdit1SelectionChange(Sender: TObject);
begin
  if RichEdit1.visible then
    RefreshControls;
end;

Procedure TwwRichEditForm.RefreshControls;
var
  haveSelection, haveText: Boolean;
begin
  RichEditBar1.RichEditBarFrame.RefreshControls;

  Paste1.enabled := RichEdit1.CanPaste and (not RichEdit1.readonly);
  Undo1.enabled := RichEdit1.CanUndo;
  Redo1.enabled := RichEdit1.CanRedo;

  haveSelection := RichEdit1.CanCut;
  // haveText:= RichEdit1.text<>''; { This line was very slow for larger buffers }
  haveText := (RichEdit1.Lines.Count > 1) or (RichEdit1.Lines.Count = 1) and
    (RichEdit1.Lines[0] <> '');
  Cut1.enabled := haveSelection and (not RichEdit1.readonly);
  if Cut1.enabled then
    Cut1.ImageIndex := 7
  else
    Cut1.ImageIndex := 15;
  Copy1.enabled := haveSelection;
  if Copy1.enabled then
    Copy1.ImageIndex := 8
  else
    Copy1.ImageIndex := 16;

  Clear1.enabled := haveSelection and (not RichEdit1.readonly);
  SelectAll1.enabled := haveText;
  Find1.enabled := haveText;
  FindNext1.enabled := RichEdit1.CanFindNext;
  Replace1.enabled := haveText and (not RichEdit1.readonly);

  // if RulerPanel<>nil then
  // TwwRulerPanel(RulerPanel).UpdateDragIcons;

end;

procedure TwwRichEditForm.Undo1Click(Sender: TObject);
begin
  SendMessage(RichEdit1.Handle, EM_UNDO, 0, 0);
  RefreshControls;
  { SendMessage(RichEdit1.Handle, EM_SETOPTIONS,
    ECOOP_XOR, ECO_AUTOWORDSELECTION); }
end;

procedure TwwRichEditForm.Cut1Click(Sender: TObject);
begin
  RichEdit1.CutToClipboard;
end;

procedure TwwRichEditForm.Copy1Click(Sender: TObject);
begin
  RichEdit1.CopyToClipboard;
end;

procedure TwwRichEditForm.Paste1Click(Sender: TObject);
begin
  RichEdit1.PasteFromClipboard;
end;

procedure TwwRichEditForm.SelectAll1Click(Sender: TObject);
begin
  RichEdit1.SelectAll;
end;

procedure TwwRichEditForm.Clear1Click(Sender: TObject);
begin
  RichEdit1.ClearSelection;
end;

procedure TwwRichEditForm.Find1Click(Sender: TObject);
begin
  RichEdit1.ExecuteFindDialog;
end;

procedure TwwRichEditForm.FindNext1Click(Sender: TObject);
begin
  RichEdit1.FindNextMatch;
end;

procedure TwwRichEditForm.Replace1Click(Sender: TObject);
begin
  RichEdit1.ExecuteReplaceDialog;
end;

procedure TwwRichEditForm.Font1Click(Sender: TObject);
begin
  RichEdit1.ExecuteFontDialog;
  RefreshControls;
end;
{
Procedure TwwRichEditForm.SetRichEditFontName(Value: string);
var
  Format: TCharFormat;
begin
  if RichEdit1.selAttributes.Name = Value then
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
}
procedure TwwRichEditForm.FontNameComboCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  {
    if not Select then exit;
    SetRichEditFontName(FontNameCombo.Text);
    RichEdit1.SetFocus;
    RefreshControls;
  }
end;

procedure TwwRichEditForm.FontSizeComboCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  {
    if not Select then exit;
    if FontSizeCombo.text='' then exit;
    RichEdit1.SelAttributes.Size:= StrToInt(FontSizeCombo.Text);
    RichEdit1.SetFocus;
    RefreshControls;
  }
end;

procedure TwwRichEditForm.BulletStyle1Click(Sender: TObject);
begin
  {
    TempDown:=  richEdit1.Numbering = renBullet; //(richedit1.Paragraph.Numbering = nsBullet);
    BulletButton.OnClick(Sender);
  }
end;

procedure TwwRichEditForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if RichEdit1.readonly then
  begin
    if ord(Key) = vk_escape then
      Close;
  end
  else if ord(Key) = vk_escape then
  begin
    if reoCloseOnEscape in RichEdit1.EditorOptions then
    begin
      if SkipClose then
        SkipClose := false
      else
        Close;
    end
    else
      Undo1Click(Sender)
  end
  else
  begin
    if GetKeyState(VK_CONTROL) >= 0 then
      exit;

    if ord(Key) = (ord('B') + 1 - ord('A')) then
    begin
      tempDown := fsBold in RichEdit1.selAttributes.Style;
      RichEditBar1.RichEditBarFrame.BoldButton.OnClick
        (RichEditBar1.RichEditBarFrame.BoldButton);
      // BoldButton.onClick(BoldButton);
      Key := #0;
    end
    else if ord(Key) = (ord('U') + 1 - ord('A')) then
    begin
      tempDown := fsUnderline in RichEdit1.selAttributes.Style;
      RichEditBar1.RichEditBarFrame.UnderlineButton.OnClick
        (RichEditBar1.RichEditBarFrame.UnderlineButton);
      // UnderlineButton.onClick(UnderlineButton);
      Key := #0;
    end
    else if ord(Key) = (ord('I') + 1 - ord('A')) then
    begin
      tempDown := fsItalic in RichEdit1.selAttributes.Style;
      RichEditBar1.RichEditBarFrame.ItalicButton.OnClick
        (RichEditBar1.RichEditBarFrame.ItalicButton);
      // ItalicButton.onClick(ItalicButton);
      Key := #0;
    end
  end
end;

procedure TwwRichEditForm.UpdateStatusBar;
var
  KeyState: TKeyboardState;
begin
  GetKeyboardState(KeyState);
  with wwInternational.richedit do
  begin
    if KeyState[VK_NumLock] <> 0 then
      StatusBar.Panels[2].text := NUMLockCaption
    else
      StatusBar.Panels[2].text := '';
    if KeyState[VK_Capital] <> 0 then
      StatusBar.Panels[1].text := CAPLockCaption
    else
      StatusBar.Panels[1].text := '';
  end;
end;

procedure TwwRichEditForm.HandleDropDownKeysForCombo(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 27) then
  begin
    if (Sender as TwwDBComboBox).DroppedDown then
      SkipClose := True
  end;
end;

procedure TwwRichEditForm.FormShow(Sender: TObject);
var
  //i: Integer;
  OrigRichEditModified: Boolean;
  //ZoomPercent: Integer;
  //ZoomComboSelectedIndex: Integer;
  OrigZoomFactor: Extended;
  BarOptions: TwwRichEditBarOptions;
  tempButton: TToolButton;

  function UpdateUserImage(Glyph: TBitmap): Integer;
  var
    bitmapScaled: TBitmap;
    bitmapRect: TRect;
    bitmapTransparentColor: TColor;
  begin
    bitmapScaled := TBitmap.Create;
    try
      bitmapScaled.Width := RichEditBar1.RichEditBarFrame.
        RichEditButtonIcons.Width;
      bitmapScaled.Height := RichEditBar1.RichEditBarFrame.
        RichEditButtonIcons.Height;
      bitmapRect := Classes.Rect(0, 0, bitmapScaled.Width, bitmapScaled.Height);

      bitmapScaled.Canvas.Brush.Color := clWhite;

      bitmapScaled.Canvas.StretchDraw(bitmapRect,
        Glyph);
      bitmapTransparentColor := Glyph.Canvas.
        Pixels[0, 0];
      result := RichEditBar1.RichEditBarFrame.RichEditButtonIcons.AddMasked
        (bitmapScaled, bitmapTransparentColor);
    finally
      bitmapScaled.Free;

    end;

  end;

begin
  RichEditBar1.Parent := self;
  RichEditBar1.BorderStyle := bsNone;
  RichEditBar1.BevelOuter := bvnone;
  RulerPanel := RichEditBar1.RichEditBarFrame.wwRulerPanel;
  // RulerPanel:= wwRulerPanel;
  RulerPanel.richedit := RichEdit1;

  // InitColorMenu;

  OrigOnHint := Application.OnHint;
  Application.OnHint := FormChangeHint;

  { Save previuos modified flag, as CopyRichEditTo incorrect sets this to True }
  OrigRichEditModified := OrigRichEdit.modified;
  OrigZoomFactor := RichEdit1.ZoomFactor;
  OrigRichEdit.CopyRichEditTo(RichEdit1);
  RichEditBar1.richedit.SelStart := OrigRichEdit.SelStart;
  // 11/13/10 - Remember last selstart for original richedit

  // we need to restore zoomfactor as it gets reset when we call CopyRichEditTo
  if OrigZoomFactor <> 1 then
  begin
    RichEdit1.ZoomFactor := OrigRichEdit.ZoomFactor;
  end;
  OrigRichEdit.modified := OrigRichEditModified;

  Screen.Cursor := crDefault;

  RichEdit1.GutterWidth := 8;
  {
    for i:= 0 to Screen.Fonts.Count-1 do begin
    if (RichEdit1.EffectiveEditWidth=rewWindowSize) or
    (Printer.Fonts.indexOf(Screen.Fonts[i])>=0) then
    FontNameCombo.Items.Add(Screen.Fonts[i]);
    end;
  }

  UpdateStatusBar;
  RefreshControls;

  // RichEdit1.SetFocus;
  RichEdit1.modified := false;

  with RichEdit1 do
  begin
    if ReadOnly then
    begin
      EditorOptions := EditorOptions - [reoShowLoad, reoShowSaveAs,
        reoShowSaveExit, reoShowStatusBar, reoShowFormatBar, reoShowToolBar,
        reoShowRuler, reoShowSpellCheck];
    end;

    if (not wwIsClass(RichEdit1.classtype, 'TwwDBRichEditMSWord')) and
      (not Assigned(RichEdit1.OnSpellCheck)) then
      // 12/3/07 - Enable if OnSpellCheck assigned
      EditorOptions := EditorOptions - [reoShowSpellCheck];

    if not(reoShowLoad in EditorOptions) then
    begin
      Load1.visible := false;
    end;
    if not(reoShowSaveAs in EditorOptions) then
    begin
      SaveAs1.visible := false;
    end;
    if not(reoShowPrint in EditorOptions) then
    begin
      Print1.visible := false;
    end;
    if not(reoShowPrintPreview in EditorOptions) then
    begin
      PrintPreview1.visible := false;
    end;
    if not(reoShowSpellCheck in EditorOptions) or RichEdit1.readonly then
    begin
      Tools1.visible := false;
      Spelling1.visible := false;
    end;
    RichEditBar1.RichEditBarFrame.FormatOptionsButton.visible := false;

    { 9/15/98 - Only show if not readonly }
    if (not(reoShowInsertObject in EditorOptions)) or
      (reoDisableOLE in OLEOptions) or (RichEdit1.readonly) then
    begin
      InsertObject1.visible := false;
      Insert1.visible := false;
    end;
    RichEditBar1.RichEditBarFrame.Sep6.visible :=
      RichEditBar1.RichEditBarFrame.InsertObjectButton.visible;

    if ([reoShowPrint, reoShowPageSetup, reoShowPrintPreview] *
      EditorOptions = []) then
      FileSep2.visible := false;

    if not(reoShowPageSetup in EditorOptions) then
      PageSetup1.visible := false;

    if not(reoShowSaveExit in EditorOptions) then
    begin
      SaveExit1.visible := false;
    end;

    if ([reoShowLoad, reoShowSaveExit] * EditorOptions = []) then
      FileSep1.visible := false;

    StatusBar.visible := reoShowStatusBar in EditorOptions;
    BarOptions := [];
    if reoShowToolBar in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowToolBar];
    end;
    if reoShowFormatBar in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowFormatBar];
    end;
    if reoShowRuler in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowRuler];
    end;
    if reoShowLoad in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowLoad];
    end;
    if reoShowSaveAs in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowSaveAs];
    end;
    if reoShowPrint in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowPrint];
    end;
    if reoShowPrintPreview in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowPrintPreview];
    end;
    if reoShowPageSetup in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowPageSetup];
    end;
    if reoFlatButtons in EditorOptions then
    begin
      BarOptions := BarOptions + [rebFlatButtons];
    end;
    if reoShowHints in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowHints];
    end;
    if reoShowSpellCheck in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowSpellCheck];
    end;
    if reoShowZoomCombo in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowZoomCombo];
    end;
    if reoShowJustifyButton in EditorOptions then
    begin
      BarOptions := BarOptions + [rebShowJustifyButton];
    end;
    RichEditBar1.Options := BarOptions;

    // RichEditBar1.Options:= RichEditBar1.Options - [rebShowRuler, rebShowFormatBar, rebShowToolBar];
    // RichEditBar1.Options:= RichEditBar1.Options + BarOptions;

    // RulerPanel.visible:= reoShowRuler in EditorOptions;

    if ReadOnly then
    begin
      Format1.visible := false;
      View1.visible := false;
    end;

    Toolbar1.checked := RichEditBar1.RichEditBarFrame.ToolBar.visible;
    FormatBar1.checked := RichEditBar1.RichEditBarFrame.FormatBar.visible;
    StatusBar1.checked := StatusBar.visible;
    Ruler1.checked := RulerPanel.visible;

    if OrigRichEdit.UserSpeedButton1 <> Nil then
      with OrigRichEdit.UserSpeedButton1 do
      begin
        tempButton := TToolButton.Create(ToolBar);
        tempButton.OnClick := OrigRichEdit.UserSpeedButton1.OnClick;
        tempButton.Hint:= OrigRichEdit.UserSpeedButton1.Hint;  // 8/31/12 - Copy hint for user button
        tempButton.ShowHint:= OrigRichEdit.UserSpeedButton1.ShowHint;

        if not OrigRichEdit.UserSpeedButton1.Glyph.Empty then
        begin
          tempButton.ImageIndex := UpdateUserImage(OrigRichEdit.UserSpeedButton1.Glyph);
        end;
        RichEditBar1.RichEditBarFrame.UserButtonSep.visible := True;
        tempButton.Left := RichEditBar1.RichEditBarFrame.UserButtonSep.
          Left + 100;
        tempButton.Parent := ToolBar;
        Flat := (reoFlatButtons in OrigRichEdit.EditorOptions);
      end;
    if OrigRichEdit.UserSpeedButton2 <> Nil then
      with OrigRichEdit.UserSpeedButton2 do
      begin
        tempButton := TToolButton.Create(ToolBar);
        tempButton.OnClick := OrigRichEdit.UserSpeedButton2.OnClick;
        tempButton.Hint:= OrigRichEdit.UserSpeedButton2.Hint; // 8/31/12 - Copy hint for user button
        tempButton.ShowHint:= OrigRichEdit.UserSpeedButton2.ShowHint;
        if not OrigRichEdit.UserSpeedButton2.Glyph.Empty then
          tempButton.ImageIndex := UpdateUserImage(OrigRichEdit.UserSpeedButton2.Glyph);
        RichEditBar1.RichEditBarFrame.UserButtonSep.visible := True;
        tempButton.Left := RichEditBar1.RichEditBarFrame.UserButtonSep.
          Left + 100;
        tempButton.Parent := ToolBar;
        Flat := (reoFlatButtons in OrigRichEdit.EditorOptions);
      end;
  end;

  Width := wwAdjustPixels(Width, PixelsPerInch);
  Height := wwAdjustPixels(Height, PixelsPerInch);
  with StatusBar do
  begin
    Panels[1].Width := wwAdjustPixels(Panels[1].Width, PixelsPerInch);
    Panels[2].Width := wwAdjustPixels(Panels[2].Width, PixelsPerInch);
    Panels[3].Width := wwAdjustPixels(Panels[3].Width, PixelsPerInch);
  end;

  ApplyIntl;
  { if Assigned(OrigRichEdit.OnMenuLoadClick) then Load1.OnClick:= OrigRichEdit.OnMenuLoadClick;
    if Assigned(OrigRichEdit.OnMenuPrintClick) then Print1.OnClick:= OrigRichEdit.OnMenuPrintClick;
    if Assigned(OrigRichEdit.OnMenuSaveAsClick) then  SaveAs1.OnClick:= OrigRichEdit.OnMenuSaveAsClick;
    if Assigned(OrigRichEdit.OnMenuSaveAndExitClick) then SaveExit1.OnClick:= OrigRichEdit.OnMenuSaveAndExitClick;
  }
  if Assigned(wwInternational.OnInitInfoPowerDialog) then
     wwInternational.OnInitInfoPowerDialog(OrigRichEdit, self);
  RichEdit1.DoInitDialog(self);
  RichEdit1.OnHorzScroll := HorzScrollRichEdit;

  FormResize(self);

  if reoShowMainMenuIcons in RichEdit1.EditorOptions then
    MainMenu1.Images := ImageList1;
  RichEdit1.SetFocus;

  RichEditBar1.RichEditBarFrame.FontNameCombo.OnHandleDropDownKeys :=
    HandleDropDownKeysForCombo;
  RichEditBar1.RichEditBarFrame.FontSizeCombo.OnHandleDropDownKeys :=
    HandleDropDownKeysForCombo;
  RichEditBar1.RichEditBarFrame.ZoomCombo.OnHandleDropDownKeys :=
    HandleDropDownKeysForCombo;

    if wwIsCustomStyle(nil) and (rebInvertColorsInToolbar in BarOptions) then
      RichEditBar1.InvertIcons;

end;

procedure TwwRichEditForm.HorzScrollRichEdit(Sender: TObject);
var
  scrollOffset: Integer;
  si: TScrollInfo;
begin
  FillChar(si, SizeOf(TScrollInfo), 0);
  si.cbSize := SizeOf(si);
  si.fMask := SIF_ALL;
  GetScrollInfo(RichEdit1.Handle, SB_HORZ, si);
  scrollOffset := si.NPos;
  RulerPanel.Left := -scrollOffset;
end;

procedure TwwRichEditForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = ord('Z')) then
    Undo1Click(Sender);
  UpdateStatusBar;
end;

procedure TwwRichEditForm.Paragraph1Click(Sender: TObject);
begin
  if RichEdit1.ExecuteParagraphDialog then
    TwwRulerPanel(RulerPanel).UpdateDragIcons;
end;

procedure TwwRichEditForm.Edit1Click(Sender: TObject);
begin
  RefreshControls;
end;

procedure TwwRichEditForm.Print1Click(Sender: TObject);
var // i: integer;
  DoDefault: Boolean;
begin
  DoDefault := True;
  if Assigned(OrigRichEdit.OnMenuPrintClick) then
    OrigRichEdit.OnMenuPrintClick(self, RichEdit1, DoDefault);
  if not DoDefault then
    exit;

  { Note: In order for an uncollated printout to take place, the target printer }
  { must support the setting of # of Copies via the Win API, and many do not. }
  { Thus, the  Collate option is set to TRUE and NOTHING is done if the user }
  { changes it to FALSE (it still produces a collated printout)... }
  PrintDialog1.collate := True;
  if PrintDialog1.Execute then
  begin
    // for i:= 1 to printdialog1.copies do { 2/15/2000}
    RichEdit1.Print(OrigRichEdit.PrintJobName);
  end
end;

function TwwRichEditForm.GetToolBar: TToolBar;
begin
  result := RichEditBar1.RichEditBarFrame.ToolBar;
end;

function TwwRichEditForm.GetFormatBar: TToolBar;
begin
  result := RichEditBar1.RichEditBarFrame.FormatBar;
end;

procedure TwwRichEditForm.UpdateFormatToolBar(ShowToolBar,
  ShowFormatBar: Boolean);
begin
  if ShowToolBar then
  begin
    if ShowFormatBar then
    begin
      RichEditBar1.Options := RichEditBar1.Options +
        [rebShowFormatBar, rebShowToolBar];
    end
    else
    begin
      RichEditBar1.Options := RichEditBar1.Options + [rebShowToolBar] -
        [rebShowFormatBar];
    end
  end
  else
  begin
    if ShowFormatBar then
    begin
      RichEditBar1.Options := RichEditBar1.Options + [rebShowFormatBar] -
        [rebShowToolBar];
    end
    else
    begin
      RichEditBar1.Options := RichEditBar1.Options - [rebShowToolBar] -
        [rebShowFormatBar];
    end
  end;
end;

procedure TwwRichEditForm.Toolbar1Click(Sender: TObject);
begin
  UpdateFormatToolBar(not ToolBar.visible, FormatBar.visible);
  Toolbar1.checked := ToolBar.visible;
  FormResize(self);
end;

procedure TwwRichEditForm.FormatBar1Click(Sender: TObject);
begin
  UpdateFormatToolBar(ToolBar.visible, not FormatBar.visible);
  FormatBar1.checked := FormatBar.visible;
  FormResize(self);
end;

procedure TwwRichEditForm.StatusBar1Click(Sender: TObject);
begin
  StatusBar.visible := not StatusBar.visible;
  StatusBar1.checked := StatusBar.visible;
  FormResize(self);
end;

procedure TwwRichEditForm.Exit1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TwwRichEditForm.SaveExit1Click(Sender: TObject);
var
  DoDefault: Boolean;
begin
  DoDefault := True;
  if Assigned(OrigRichEdit.OnMenuSaveAndExitClick) then
    OrigRichEdit.OnMenuSaveAndExitClick(self, RichEdit1, DoDefault);
  if not DoDefault then
    exit;

  ModalResult := mrOK;
end;

procedure TwwRichEditForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  answer: Integer;
begin
  if ModalResult = mrOK then
    exit;

  if (reoNoConfirmation in OrigRichEdit.EditorOptions) then
    ModalResult := mrOK
  else if RichEdit1.modified and (not RichEdit1.readonly)
  then { 2/24/99 - No message if readonly }
  begin
    answer := MessageDlg(wwInternational.UserMessages.RichEditExitWarning,
      mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if (answer = mrYes) then
    begin
      ModalResult := mrOK;
    end
    else if (answer = mrNo) then
    begin
      ModalResult := mrCancel;
    end
    else
      CanClose := false;
  end
  else
    ModalResult := mrCancel;

end;

procedure TwwRichEditForm.Tabs1Click(Sender: TObject);
begin
  RichEdit1.executeTabDialog;
end;

procedure TwwRichEditForm.FormResize(Sender: TObject);
var
  RichEditHeight: Integer;
  frameOffset: Word; // integer;
begin
  if not RichEditBar1.HandleAllocated then
    exit;

  RichEdit1.SkipPaint := True;

  // Vista support
  frameOffset := GetSystemMetrics(sm_cxframe) * 2;

  try
    try
      StatusBar.Panels[0].Width := Width - wwAdjustPixels(90, PixelsPerInch) -
        frameOffset;

      // RichEditTop:= 0;
      //RulerPanelTop := 0;

      if StatusBar.visible then
        RichEditHeight := ClientHeight - StatusBar.Height // - RichEditTop
      else
        RichEditHeight := ClientHeight; // - RichEditTop;

      // Vista support
      SetWindowPos(RichEditBar1.Handle, 0, 0, 0, Width - frameOffset,
        RichEditHeight, SWP_NOACTIVATE);

      if StatusBar.visible then
      begin
        StatusBar.Top := RichEditBar1.Top + RichEditHeight;
        StatusBar.Width := RichEdit1.Width;
      end;

    finally
      RichEdit1.setEditRect; { Call after sizing richedit }

      { Allows vertical scrollbars to appear when unmaximizing form }
      {
        if richedit1.EffectiveEditWidth = rewPrinterSize then
        begin
        richedit1.width:= richedit1.width + 1;
        richedit1.width:= richedit1.width - 1;
        end;
      }
      RichEdit1.SkipPaint := false;
      RichEdit1.invalidate;
    end
  except
    RichEdit1.SkipPaint := false;
    ShowMessage('Error in resize');
  end;

end;

procedure GetPrinter(var DeviceMode, DeviceNames: THandle);
var
  Device, Driver, Port: array [0 .. 1023] of Char;
  DevNames: PDevNames;
  Offset: PChar;
begin
  Printer.GetPrinter(Device, Driver, Port, DeviceMode);
  if DeviceMode <> 0 then
  begin
    DeviceNames := GlobalAlloc(GHND, SizeOf(TDevNames) +
      (StrLen(Device) + StrLen(Driver) + StrLen(Port) + 3) * SizeOf(Char));
    DevNames := PDevNames(GlobalLock(DeviceNames));
    try
      Offset := PChar(PByte(DevNames) + SizeOf(TDevNames));
      with DevNames^ do
      begin
        wDriverOffset := Offset - PChar(DevNames);
        Offset := StrECopy(Offset, Driver) + 1;
        wDeviceOffset := Offset - PChar(DevNames);
        Offset := StrECopy(Offset, Device) + 1;
        wOutputOffset := Offset - PChar(DevNames);;
        StrCopy(Offset, Port);
      end;
    finally
      GlobalUnlock(DeviceNames);
    end;
  end;
end;

function CopyData(Handle: THandle): THandle;
var
  Src, Dest: PChar;
  Size: Integer;
begin
  if Handle <> 0 then
  begin
    Size := GlobalSize(Handle);
    result := GlobalAlloc(GHND, Size);
    if result <> 0 then
      try
        Src := GlobalLock(Handle);
        Dest := GlobalLock(result);
        if (Src <> nil) and (Dest <> nil) then
          Move(Src^, Dest^, Size);
      finally
        GlobalUnlock(Handle);
        GlobalUnlock(result);
      end
  end
  else
    result := 0;
end;

procedure SetPrinter(DeviceMode, DeviceNames: THandle);
var
  DevNames: PDevNames;
begin
  DevNames := PDevNames(GlobalLock(DeviceNames));
  try
    with DevNames^ do
    begin
      Printer.SetPrinter(PChar(DevNames) + wDeviceOffset,
        PChar(DevNames) + wDriverOffset, PChar(DevNames) + wOutputOffset,
        DeviceMode);
    end;
  finally
    GlobalUnlock(DeviceNames);
    GlobalFree(DeviceNames);
  end;
end;

{ Center PageSetup Dialog }
{$ifdef wwDelphi2012Up}
function PageSetupHook(Wnd: HWnd; Msg: UINT; WParam: WParam; LPARAM: LPARAM)
  : UINT_PTR; stdcall;
{$else}
function PageSetupHook(Wnd: HWnd; Msg: UINT; WParam: WParam; LPARAM: LPARAM)
  : UINT; stdcall;
{$endif}
  procedure CenterWindow(Wnd: HWnd);
  var
    Rect: TRect;
  begin
    GetWindowRect(Wnd, Rect);
    SetWindowPos(Wnd, 0, (GetSystemMetrics(SM_CXSCREEN) - Rect.Right +
      Rect.Left) div 2, (GetSystemMetrics(SM_CYSCREEN) - Rect.Bottom + Rect.Top)
      div 3, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
  end;

begin
  result := 0;
  // 6/13/01 - Remove obsolete functions
  case Msg of
    WM_INITDIALOG:
      begin
        // Subclass3DDlg(Wnd, CTL3D_ALL);
        // SetAutoSubClass(True);
        CenterWindow(Wnd);
      end;
    // WM_DESTROY:
    // SetAutoSubClass(False);
  end;
end;

{ TCommonDialog }
Function TwwPageSetupDialog.Execute: Boolean;
var
  setup: TPageSetupDlg;
  hOrigDeviceMode: THandle;
  hDeviceMode: THandle;
  DeviceMode: PDeviceMode;
  tempOrientation: TPrinterOrientation;
  tempPrintPageSize: Integer;
begin
  FillChar(setup, SizeOf(TPageSetupDlg), 0);
  with setup do
  begin
    lStructSize := SizeOf(TPageSetupDlg);
    hWndOwner := Application.Handle;
{$IFDEF wwDelphi3Up}
    hInstance := SysInit.hInstance;
{$ELSE}
    hInstance := System.hInstance;
{$ENDIF}
    GetPrinter(hOrigDeviceMode, hDevNames);
    hDeviceMode := CopyData(hOrigDeviceMode);
    hDevMode := hDeviceMode;
    { 4/18/98 - This important line previously omitted! }
//    lpfnPageSetupHook := PageSetupHook;

    flags := PSD_MARGINS or PSD_ENABLEPAGESETUPHOOK;
    if RichEdit1.EffectiveEditwidth = rewWindowSize then
      flags := flags or PSD_DISABLEPAPER;

    with RichEdit1 do
    begin
      if MeasurementUnits = muInches then
        flags := flags or PSD_INTHOUSANDTHSOFINCHES
      else
        flags := flags or PSD_INHUNDREDTHSOFMILLIMETERS;
      rtMargin.Left := Trunc(PrintMargins.Left * 1000);
      rtMargin.Top := Trunc(PrintMargins.Top * 1000);
      rtMargin.Right := Trunc(PrintMargins.Right * 1000);
      rtMargin.Bottom := Trunc(PrintMargins.Bottom * 1000);
      if RichEdit1.EffectiveEditwidth = rewPrinterSize then
      begin
        DeviceMode := GlobalLock(hDeviceMode);
        DeviceMode.dmPaperSize := PrintPageSize;
        GlobalUnlock(hDeviceMode);
      end
    end;
    result := TaskModalDialog(@PageSetupDlg, setup);
    if result then
      with RichEdit1 do
      begin
        PrintMargins.Left := rtMargin.Left / 1000;
        PrintMargins.Right := rtMargin.Right / 1000;
        PrintMargins.Top := rtMargin.Top / 1000;
        PrintMargins.Bottom := rtMargin.Bottom / 1000;

        // DeviceMode := GlobalLock(hDeviceMode);  { Set printer attributes }
        DeviceMode := GlobalLock(hDevMode); { Set printer attributes }
        tempPrintPageSize := DeviceMode.dmPaperSize;
        if DeviceMode.dmOrientation = DMORIENT_LANDSCAPE then
          tempOrientation := poLandscape
        else
          tempOrientation := poPortrait;
        // GlobalUnlock(hDeviceMode);
        GlobalUnlock(hDevMode);

        // SetPrinter(hDeviceMode, hDevNames);  { Choose printer }
        SetPrinter(hDevMode, hDevNames); { Choose printer }
        Printer.orientation := tempOrientation;
        PrintPageSize := tempPrintPageSize;
        UpdatePrinter;
      end
    else
    begin
      if hDeviceMode <> 0 then
        GlobalFree(hDeviceMode);
      if hDevNames <> 0 then
        GlobalFree(hDevNames);
    end;

  end;
end;

procedure TwwRichEditForm.PageSetup1Click(Sender: TObject);
begin
  with TwwPageSetupDialog.Create(self) do
  begin
    RichEdit1 := self.RichEdit1;
    if Execute then
    begin
      if RichEdit1.EffectiveEditwidth = rewPrinterSize then
      begin
        TwwRulerPanel(RulerPanel).UpdateSize(RichEdit1);
        TwwRulerPanel(RulerPanel).UpdateDragIcons;
        RulerPanel.UpdateRulerProp(RulerPanel.RightDragButton);
      end
      else
        self.RichEdit1.setEditRect;
    end;
    Free;
  end
end;

procedure TwwRichEditForm.Load1Click(Sender: TObject);
var
  DoDefault: Boolean;
begin
  DoDefault := True;
  if Assigned(OrigRichEdit.OnMenuLoadClick) then
    OrigRichEdit.OnMenuLoadClick(self, RichEdit1, DoDefault);
  if not DoDefault then
    exit;

  if OpenDialog1.Execute then
  begin
    RichEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
    RichEdit1.SetFocus;
  end;
end;

procedure TwwRichEditForm.SaveAs1Click(Sender: TObject);
var
  DoDefault: Boolean;
begin
  DoDefault := True;
  if Assigned(OrigRichEdit.OnMenuSaveAsClick) then
    OrigRichEdit.OnMenuSaveAsClick(self, RichEdit1, DoDefault);
  if not DoDefault then
    exit;

  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
      if MessageDlg(Format('OK to overwrite %s', [SaveDialog1.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then
        exit;
    if SaveDialog1.filterindex = 2 then { 6/8/00 - Save as plain text }
    begin
      RichEdit1.plaintext := True;
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName);
      RichEdit1.plaintext := false;
    end
    else
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TwwRichEditForm.NewButtonClick(Sender: TObject);
begin
  if MessageDlg(wwInternational.UserMessages.RichEditClearWarning,
    mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then
    exit;

  RichEdit1.clear;
  RichEdit1.modified := True;
end;

procedure TwwRichEditForm.NumberingButtonClick(Sender: TObject);
begin
  if RichEdit1.Numbering <= renBullet then
    RichEdit1.Numbering := renArabic
  else
    RichEdit1.Numbering := renNone;
  RefreshControls;
end;

procedure TwwRichEditForm.SaveAsButtonClick(Sender: TObject);
begin
  SaveAs1Click(Sender);
end;

procedure TwwRichEditForm.PrintButtonClick(Sender: TObject);
begin
  Print1Click(Sender);
end;

procedure TwwRichEditForm.PrintPreviewButtonClick(Sender: TObject);
begin
  RichEdit1.PrintPreview;
end;

procedure TwwRichEditForm.FindButtonClick(Sender: TObject);
begin
  Find1Click(Sender);
end;

procedure TwwRichEditForm.CutButtonClick(Sender: TObject);
begin
  Cut1Click(Sender);
end;

procedure TwwRichEditForm.CopyButtonClick(Sender: TObject);
begin
  Copy1Click(Sender);
end;

procedure TwwRichEditForm.PasteButtonClick(Sender: TObject);
begin
  Paste1Click(Sender);
end;

procedure TwwRichEditForm.UndoButtonClick(Sender: TObject);
begin
  Undo1Click(Sender);
end;

procedure TwwRichEditForm.FontNameComboDropDown(Sender: TObject);
begin
  // FontNameCombo.font.color:=clBlack;
end;

procedure TwwRichEditForm.FormChangeHint(Sender: TObject);
begin
  StatusBar.Panels[0].text := Application.Hint;
end;

procedure TwwRichEditForm.ApplyIntl;
begin
  with wwInternational.richedit do
  begin

    if (reoShowHints in RichEdit1.EditorOptions) then
    begin

      { File Menu Items }
      with RichEditBar1.RichEditBarFrame do
      begin
        Load1.Hint := LoadButton.Hint;
        SaveAs1.Hint := SaveAsButton.Hint;
        SaveExit1.Hint := SaveExitHint;
        Print1.Hint := PrintButton.Hint;
        PrintPreview1.Hint := PrintPreviewButton.Hint;
        PageSetup1.Hint := PageSetupHint;
        Exit1.Hint := ExitHint;

        { Edit Menu Items }
        Undo1.Hint := UndoButton.Hint;
        Cut1.Hint := CutButton.Hint;
        Copy1.Hint := CopyButton.Hint;
        Paste1.Hint := PasteButton.Hint;

        Find1.Hint := FindButton.Hint;

        Clear1.Hint := ClearHint;
        SelectAll1.Hint := SelectAllHint;
        FindNext1.Hint := FindNextHint;
        Replace1.Hint := ReplaceHint;
        InsertObject1.Hint := InsertObjectHint;
        Spelling1.Hint := SpellCheckHint;

        { View Menu Items }
        Toolbar1.Hint := ToolbarHint;
        FormatBar1.Hint := FormatBarHint;
        StatusBar1.Hint := ViewStatusBarHint;
        Options1.Hint := OptionsHint;

        { Format Menu Items }
        Font1.Hint := FontHint;
        self.Font1.Hint:= FontHint;
        // BulletStyle1.Hint:= BulletButton.Hint;
        Paragraph1.Hint := ParagraphHint;
        self.Paragraph1.Hint:= ParagraphHint;
        Tabs1.Hint := TabsHint;
        abs1.Hint:= TabsHint;
      end;
    end
    else
      Application.OnHint := nil;

    { Change Menu Item Labels }

    File1.Caption := MenuLabels.FileCaption;
    Load1.Caption := MenuLabels.LoadCaption;
    SaveAs1.Caption := MenuLabels.SaveAsCaption;
    SaveExit1.Caption := MenuLabels.SaveExitCaption;
    Print1.Caption := MenuLabels.PrintCaption;
    PrintPreview1.Caption := MenuLabels.PrintPreviewCaption;
    PageSetup1.Caption := MenuLabels.PageSetupCaption;
    Exit1.Caption := MenuLabels.ExitCaption;

    Edit1.Caption := MenuLabels.EditCaption;
    Undo1.Caption := MenuLabels.UndoCaption;
    Cut1.Caption := MenuLabels.CutCaption;
    Copy1.Caption := MenuLabels.CopyCaption;
    Paste1.Caption := MenuLabels.PasteCaption;
    Clear1.Caption := MenuLabels.ClearCaption;
    SelectAll1.Caption := MenuLabels.SelectallCaption;
    Find1.Caption := MenuLabels.FindCaption;
    FindNext1.Caption := MenuLabels.FindNextCaption;
    Replace1.Caption := MenuLabels.ReplaceCaption;
    InsertObject1.Caption := MenuLabels.InsertObjectCaption;
{$IFDEF wwdelphi4up}
    Insert1.Caption := MenuLabels.InsertCaption;
    if Insert1.Caption = '' then
      Insert1.Caption := '&Insert';
    Ruler1.Caption := MenuLabels.RulerCaption;
    if Ruler1.Caption = '' then
      Ruler1.Caption := '&Ruler';
    Redo1.Caption := MenuLabels.RedoCaption;
    if Redo1.Caption = '' then
      Redo1.Caption := '&Redo';
{$ENDIF}
    View1.Caption := MenuLabels.ViewCaption;
    Tools1.Caption := MenuLabels.ToolCaption;
    Spelling1.Caption := MenuLabels.SpellCheckCaption;
    Toolbar1.Caption := MenuLabels.ToolbarCaption;
    FormatBar1.Caption := MenuLabels.FormatBarCaption;
    StatusBar1.Caption := MenuLabels.ViewStatusBarCaption;
    Options1.Caption := MenuLabels.OptionsCaption;

    Format1.Caption := MenuLabels.FormatCaption;
    Font1.Caption := MenuLabels.FontCaption;
    BulletStyle1.Caption := MenuLabels.BulletStyleCaption;
    Paragraph1.Caption := MenuLabels.ParagraphCaption;
    Tabs1.Caption := MenuLabels.TabsCaption;

    Help1.Caption := MenuLabels.HelpCaption;
  end;
end;

procedure TwwRichEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.OnHint := OrigOnHint;
end;

procedure TwwRichEditForm.Ruler1Click(Sender: TObject);
begin
  // RulerPanel.visible:= not RulerPanel.visible;
  if RulerPanel.visible then
    RichEditBar1.Options := RichEditBar1.Options - [rebShowRuler]
  else
    RichEditBar1.Options := RichEditBar1.Options + [rebShowRuler];
  Ruler1.checked := RulerPanel.visible;
  FormResize(self);
end;

procedure TwwRichEditForm.InsertObject1Click(Sender: TObject);
begin
  RichEdit1.InsertObjectDialog;
end;

procedure TwwRichEditForm.RedoButtonClick(Sender: TObject);
begin
  Redo1Click(Sender);
end;

procedure TwwRichEditForm.Redo1Click(Sender: TObject);
begin
  SendMessage(RichEdit1.Handle, EM_REDO, 0, 0);
  RefreshControls;
end;

{ Implement Color drop-down list }
procedure TwwRichEditForm.WMCommand(var Message: TWMCommand);
var
  item: TMenuItem;
begin
  inherited;
  if (Message.NotifyCode = 0) and (PopupMenu1 <> nil) then
  begin
    item := PopupMenu1.FindItem(Message.itemID, fkCommand);
    if item <> nil then
      item.Click;
  end
end;

procedure TwwRichEditForm.FormCreate(Sender: TObject);
begin
  FCanvas := TCanvas.Create;
end;

procedure TwwRichEditForm.FormDestroy(Sender: TObject);
begin
  FCanvas.Free;
end;

procedure TwwRichEditForm.Spelling1Click(Sender: TObject);
begin
  RichEdit1.MSWordSpellChecker;
end;

procedure TwwRichEditForm.SpellButtonClick(Sender: TObject);
begin
  Spelling1Click(Sender)
end;

procedure TwwRichEditForm.HighlightButtonClick(Sender: TObject);
begin
  with (Sender as TSpeedButton) do
  begin
    if not Down then
      RichEdit1.SetTextBackgroundColor(-1)
    else
      RichEdit1.SetTextBackgroundColor(RichEdit1.HighlightColor);
  end;
  RefreshControls;

end;

procedure TwwRichEditForm.BoldButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  tempDown := (Sender as TSpeedButton).Down;
end;

procedure TwwRichEditForm.JustifyButtonClick(Sender: TObject);
begin
  RichEdit1.SetParaFormat([rpoAlignment],
    wwInternational.richedit.ParagraphDialog.AlignJustify, false, 0, 0, 0, 0,
    nil, 0, 0, 0, 0);
  RefreshControls;
end;

end.
