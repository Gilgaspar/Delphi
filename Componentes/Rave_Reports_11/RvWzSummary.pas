{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RvWzSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RvTool, RvToolEvents, RvToolUtil, RvProj, RpDefine, RpBase,
  RpSystem, RvClass, StdCtrls, ExtCtrls, ActnMan, ActnColorMaps, ComCtrls,
  TypInfo, RpMemo;

type
  TColorName = record
    Name: string;
    Color: TColor;
  end; { TColorName }

const
{TransOff}
  Colors = 74;
  SimpleColors = 47;
  ColorName: array[1..Colors] of TColorName = (
   (Name:'Black'; Color:TColor($000000)),
   (Name:'Maroon'; Color:TColor($000080)),
   (Name:'Green'; Color:TColor($008000)),
   (Name:'Olive'; Color:TColor($008080)),
   (Name:'Navy'; Color:TColor($800000)),
   (Name:'Purple'; Color:TColor($800080)),
   (Name:'Teal'; Color:TColor($808000)),
   (Name:'Gray'; Color:TColor($808080)),
   (Name:'Silver'; Color:TColor($C0C0C0)),
   (Name:'Red'; Color:TColor($0000FF)),
   (Name:'Lime'; Color:TColor($00FF00)),
   (Name:'Yellow'; Color:TColor($00FFFF)),
   (Name:'Blue'; Color:TColor($FF0000)),
   (Name:'Fuchsia'; Color:TColor($FF00FF)),
   (Name:'Aqua'; Color:TColor($FFFF00)),
   (Name:'White'; Color:TColor($FFFFFF)),
   (Name:'Pink'; Color: TColor($8080FF)),
   (Name:'RedClay'; Color: TColor($404080)),
   (Name:'NightRed'; Color: TColor($000040)),
   (Name:'Lemon'; Color: TColor($80FFFF)),
   (Name:'Peach'; Color: TColor($4080FF)),
   (Name:'Orange'; Color: TColor($0080FF)),
   (Name:'Brown'; Color: TColor($004080)),
   (Name:'MistGreen'; Color: TColor($80FF80)),
   (Name:'YellowGreen'; Color: TColor($00FF80)),
   (Name:'NightGreen'; Color: TColor($004000)),
   (Name:'Gold'; Color: TColor($408080)),
   (Name:'SeaGreen'; Color: TColor($80FF00)),
   (Name:'GreenApple'; Color: TColor($40FF00)),
   (Name:'BlueGreen'; Color: TColor($408000)),
   (Name:'ForestGreen'; Color: TColor($404000)),
   (Name:'SkyBlue'; Color: TColor($FFFF80)),
   (Name:'DeepBlue'; Color: TColor($804000)),
   (Name:'TealGray'; Color: TColor($808040)),
   (Name:'GreenBlue'; Color: TColor($FF8000)),
   (Name:'TealBlue'; Color: TColor($C08000)),
   (Name:'Lavender'; Color: TColor($FF8080)),
   (Name:'RoyalBlue'; Color: TColor($A00000)),
   (Name:'NightBlue'; Color: TColor($400000)),
   (Name:'BubbleGum'; Color: TColor($C080FF)),
   (Name:'Periwinkle'; Color: TColor($C08080)),
   (Name:'Plum'; Color: TColor($400080)),
   (Name:'BlackCherry'; Color: TColor($400040)),
   (Name:'PinkCarnation'; Color: TColor($FF80FF)),
   (Name:'VioletRed'; Color: TColor($8000FF)),
   (Name:'LightPurple'; Color: TColor($FF0080)),
   (Name:'DarkPurple'; Color: TColor($800040)),
   (Name:'clNone'; Color:TColor($1FFFFFFF)),
   (Name:'clDefault'; Color:TColor($20000000)),
   (Name:'clScrollBar'; Color:TColor(COLOR_SCROLLBAR or $80000000)),
   (Name:'clBackground'; Color:TColor(COLOR_BACKGROUND or $80000000)),
   (Name:'clActiveCaption'; Color:TColor(COLOR_ACTIVECAPTION or $80000000)),
   (Name:'clInactiveCaption'; Color:TColor(COLOR_INACTIVECAPTION or $80000000)),
   (Name:'clMenu'; Color:TColor(COLOR_MENU or $80000000)),
   (Name:'clWindow'; Color:TColor(COLOR_WINDOW or $80000000)),
   (Name:'clWindowFrame'; Color:TColor(COLOR_WINDOWFRAME or $80000000)),
   (Name:'clMenuText'; Color:TColor(COLOR_MENUTEXT or $80000000)),
   (Name:'clWindowText'; Color:TColor(COLOR_WINDOWTEXT or $80000000)),
   (Name:'clCaptionText'; Color:TColor(COLOR_CAPTIONTEXT or $80000000)),
   (Name:'clActiveBorder'; Color:TColor(COLOR_ACTIVEBORDER or $80000000)),
   (Name:'clInactiveBorder'; Color:TColor(COLOR_INACTIVEBORDER or $80000000)),
   (Name:'clAppWorkSpace'; Color:TColor(COLOR_APPWORKSPACE or $80000000)),
   (Name:'clHighlight'; Color:TColor(COLOR_HIGHLIGHT or $80000000)),
   (Name:'clHighlightText'; Color:TColor(COLOR_HIGHLIGHTTEXT or $80000000)),
   (Name:'clBtnFace'; Color:TColor(COLOR_BTNFACE or $80000000)),
   (Name:'clBtnShadow'; Color:TColor(COLOR_BTNSHADOW or $80000000)),
   (Name:'clGrayText'; Color:TColor(COLOR_GRAYTEXT or $80000000)),
   (Name:'clBtnText'; Color:TColor(COLOR_BTNTEXT or $80000000)),
   (Name:'clInactiveCaptionText'; Color:TColor(COLOR_INACTIVECAPTIONTEXT or $80000000)),
   (Name:'clBtnHighlight'; Color:TColor(COLOR_BTNHIGHLIGHT or $80000000)),
   (Name:'cl3DDkShadow'; Color:TColor(COLOR_3DDKSHADOW or $80000000)),
   (Name:'cl3DLight'; Color:TColor(COLOR_3DLIGHT or $80000000)),
   (Name:'clInfoText'; Color:TColor(COLOR_INFOTEXT or $80000000)),
   (Name:'clInfoBk'; Color:TColor(COLOR_INFOBK or $80000000)));
{TransOn}

type
  TSummaryForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ckboxPrintClassNames: TCheckBox;
    rgrpReportType: TRadioGroup;
    rgrpPropertyOptions: TRadioGroup;
    PanelButtons: TPanel;
    PageControl1: TPageControl;
    TabSheetMain: TTabSheet;
    TabSheetColors: TTabSheet;
    ColorBoxComponentName: TColorBox;
    Label5: TLabel;
    ColorBoxPropertyName: TColorBox;
    Label6: TLabel;
    ckBoxComponentNameBold: TCheckBox;
    ckBoxPropertyNameBold: TCheckBox;
    RvSystem1: TRvSystem;
    Label7: TLabel;
    ckboxComponentTypeBold: TCheckBox;
    ColorBoxComponentType: TColorBox;
    TabSheetMargins: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditMarginBottom: TEdit;
    EditMarginLeft: TEdit;
    EditMarginRight: TEdit;
    EditMarginTop: TEdit;
    rgrpEventOptions: TRadioGroup;
    Label8: TLabel;
    ckboxEventCodeBold: TCheckBox;
    ColorBoxEventCode: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RvSystem1Print(Sender: TObject);
    procedure RvSystem1PrintHeader(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
  protected
    { protected declarations }
    FActiveReport: TRaveReport;
    FMemoBuf: TMemoBuf;
    FPrintOfs: double;
    PropList: PPropList;
    PropInfo: PPropInfo;
    EditorClass: TRavePropertyEditorClass;
    NewEditor: TRavePropertyEditor;
    DefaultTest: TRaveComponent;

    procedure PrintComponent(RaveComp: TRaveComponent; BaseReport: TBaseReport);
    procedure PrintProperties(RaveComp: TRaveComponent; BaseReport: TBaseReport);
    procedure PrintProperty(RaveComp: TRaveComponent; BaseReport: TBaseReport);
    procedure PrintEvent(RaveComp: TRaveComponent; RaveEvent: TRaveEvent; BaseReport: TBaseReport);
    procedure GetPrintOptions;
    procedure SavePrintOptions;

    function GetColorValue(Value: string): TColor;

    property ActiveReport: TRaveReport read FActiveReport write FActiveReport;
    property MemoBuf: TMemoBuf read FMemoBuf write FMemoBuf;
  public
    { Public declarations }
    property PrintOfs: double read FPrintOfs write FPrintOfs;
  end;

var
  SummaryForm: TSummaryForm;

  procedure RaveRegister;

implementation
uses
  IniFiles{, RIDERegister};

{$R *.dfm}

type
  TRaveSummaryEditor = class(TRaveProjectEditor,IRaveToolMenuEventHandler)
  protected
    procedure ApplySettings;
    procedure ExecuteReport;

  public
   procedure AddToMenu(AddMenuItem: TAddMenuItemProc);
   procedure RunFromMenu(ID: integer);
   function PrintDefinition(Report: TRaveReport): boolean;
  end; { TRaveSummaryEditor }

procedure RaveRegister;

begin { RaveRegister }
{TransOff}
  RegisterRaveProjectEditor(TRaveSummaryEditor);
{TransOn}
end;  { RaveRegister }

procedure TSummaryForm.FormCreate(Sender: TObject);
begin
  FMemoBuf := TMemoBuf.Create;
  FormTrans(self);
  PrepareToolWin(self);
end;

procedure TSummaryForm.FormDestroy(Sender: TObject);
begin
  SaveToolWin(self);
  FreeAndNil(FMemoBuf);
  SavePrintOptions;
end;

procedure TSummaryForm.FormShow(Sender: TObject);
begin
  RestoreToolWin(self);
  GetPrintOptions;
end;

{ TRaveWizardProjectEditor }

procedure TRaveSummaryEditor.AddToMenu(
  AddMenuItem: TAddMenuItemProc);
begin
  AddMenuItem(self,'Report Summary',1,0);
end;

procedure TRaveSummaryEditor.ApplySettings;
begin
  with SummaryForm, RvSystem1.SystemPrinter do begin
    MarginLeft := StrToFloat(EditMarginLeft.Text);
    MarginRight := StrToFloat(EditMarginRight.Text);
    MarginTop := StrToFloat(EditMarginTop.Text);
    MarginBottom := StrToFloat(EditMarginBottom.Text);
  end;
end;

procedure TRaveSummaryEditor.ExecuteReport;
begin
  ApplySettings;
  SummaryForm.RvSystem1.Execute;
end;

function TRaveSummaryEditor.PrintDefinition(Report: TRaveReport): boolean;
begin
  Result := true;

// Build project item / data object list
  TRaveProjectManager(Report.Project).SetIncluded(Report);

// Create Print Definitions
  SummaryForm := TSummaryForm.Create(Application);
  try
    SummaryForm.ActiveReport := Report;
    if SummaryForm.ShowModal = mrOK then begin
      ExecuteReport;
    end;
  finally
    FreeAndNil(SummaryForm);
  end; { with }
end;

procedure TRaveSummaryEditor.RunFromMenu(ID: integer);
begin
  PrintDefinition(ProjectManager.ActiveReport);
end;

function TSummaryForm.GetColorValue(Value: string): TColor;
var
  I1: integer;

begin { GetColorValue }
  if Value[1] = '$' then begin
    Result := TColor(Value);
    Exit;
  end; { if }
  for I1 := 1 to Colors do begin
    if Value = ColorName[I1].Name then begin
      Result := ColorName[I1].Color;
      Exit;
    end; { if }
  end; { for }
  Result := clBlack;
end;  { GetColorValue }

procedure TSummaryForm.GetPrintOptions;
begin
  { Printing Settings }
  with RaveSettings.LockSection('ReportSummary') do try
    PageControl1.ActivePage := TabSheetMain;
    { Main Settings }
    rgrpReportType.ItemIndex := ReadInteger('ReportType',1);
    rgrpPropertyOptions.ItemIndex := ReadInteger('PropertyOptions', 2);
    ckboxPrintClassNames.Checked := ReadBool('PrintClassNames', true);
    rgrpEventOptions.ItemIndex := ReadInteger('EventOptions', 0);

    { Margin Settings }
    EditMarginLeft.Text := ReadString('MarginLeft', '1.0');
    EditMarginRight.Text := ReadString('MarginRight', '1.0');
    EditMarginTop.Text := ReadString('MarginTop', '1.0');
    EditMarginBottom.Text := ReadString('MarginBottom', '1.0');

    PageControl1.ActivePage := TabSheetColors;
    { Colors }
    ColorBoxComponentName.Selected := TColor(ReadInteger('ComponentNameColor',clBlack));
    ckBoxComponentNameBold.Checked := ReadBool('ComponentNameBold', false);
    ColorBoxComponentType.Selected := TColor(ReadInteger('ComponentTypeColor',clBlack));
    ckboxComponentTypeBold.Checked := ReadBool('ComponentTypeBold', false);
    ColorBoxPropertyName.Selected := TColor(ReadInteger('PropertyNameColor',clBlack));
    ckBoxPropertyNameBold.Checked := ReadBool('PropertyNameBold', false);
    ColorBoxEventCode.Selected := TColor(ReadInteger('EventCodeColor',clBlack));
    ckBoxEventCodeBold.Checked := ReadBool('EventCodeBold', false);

  finally
    UnlockSection;
    PageControl1.ActivePage := TabSheetMain;
  end; { with }
end;

procedure TSummaryForm.PrintComponent(RaveComp: TRaveComponent;
  BaseReport: TBaseReport);
var
  I1: integer;
begin
  with BaseReport do begin
    XPos := MarginLeft + PrintOfs;
    Bold := SummaryForm.ckBoxComponentNameBold.Checked;
    FontColor := SummaryForm.ColorBoxComponentName.Selected;
    if SummaryForm.rgrpEventOptions.ItemIndex <> 2 then begin
      Print(RaveComp.Name);
    end;
    Bold := false;
    FontColor := clBlack;
    if SummaryForm.ckboxPrintClassNames.Checked then begin
      FontColor := ColorBoxComponentType.Selected;
      Bold := ckboxComponentTypeBold.Checked;
      if SummaryForm.rgrpEventOptions.ItemIndex <> 2 then begin
        Print(' (' + RaveComp.ClassName + ')');
      end;
      FontColor := clBlack;
      Bold := false;
    end; { if }
    if SummaryForm.rgrpEventOptions.ItemIndex <> 2 then begin
      NewLine;
    end;
    PrintOfs := PrintOfs + 0.2;
    PrintProperties(RaveComp, BaseReport);
    PrintOfs := PrintOfs - 0.2;
    if RaveComp.ChildCount > 0 then begin
      PrintOfs := PrintOfs + 0.2;
    end; { if }
    for I1 := 0 to RaveComp.ChildCount - 1 do begin
      PrintComponent(RaveComp.Child[I1], BaseReport);
    end;
    if YPos > PageHeight - MarginBottom then begin
      NewPage;
    end;
    if RaveComp.ChildCount > 0 then begin
      PrintOfs := PrintOfs - 0.2;
    end; { if }
  end; { with }
end;

procedure TSummaryForm.PrintProperties(RaveComp: TRaveComponent; BaseReport: TBaseReport);
var
  Count: integer;
  I2: integer;
  O1: TObject;
begin
  with BaseReport do begin
    { Get list of property names and their editors }
      Count := GetPropList(RaveComp.ClassInfo,tkProperties,nil);
      GetMem(PropList,Count * SizeOf(pointer));
      try
        GetPropList(RaveComp.ClassInfo,tkProperties,PropList);
        for I2 := 0 to Count - 1 do begin
          PropInfo := PropList^[I2];

        { Don't display extra properties if mirrored }
          if (RaveComp is TRaveControl) and
           Assigned(TRaveControl(RaveComp).Mirror) and
           (Pos('|' + UpperCase(string(PropInfo.Name)) + '|',
           {Trans-}'|DEVLOCKED|LEFT|LOCKED|MIRROR|NAME|TOP|') = 0) then Continue;

        { Don't display if property is not visible }
          if not PropertyVisible(RaveComp.ClassType, string(PropInfo.Name)) then Continue;

        { Skip Name property since this has already been printed }
          if PropInfo.Name = 'Name' then Continue;

        { Display event code }
          if (PropInfo.PropType^.Kind = tkClass) and GetTypeData(
           PropInfo.PropType^).ClassType.InheritsFrom(TRaveEvent) then begin
            O1 := TObject(GetOrdProp(RaveComp,PropInfo));
            if Assigned(O1) then begin
              PrintEvent(RaveComp, TRaveEvent(O1), BaseReport);
            end;
            Continue;
          end;

          if SummaryForm.rgrpEventOptions.ItemIndex > 1 then Continue;

          EditorClass := FindPropertyEditorClass(PropInfo.PropType^, RaveComp.ClassType, string(PropInfo.Name));
          NewEditor := EditorClass.Create;
          NewEditor.AddInst(RaveComp,PropInfo);

          DefaultTest := TRaveComponent(RaveComp.ClassType.NewInstance);
          DefaultTest.Create(RaveComp.Owner);

          with SummaryForm, rgrpPropertyOptions do begin
            if ItemIndex = 0 then begin { Print All Properties }
              PrintProperty(RaveComp, BaseReport);
            end else if ItemIndex = 1 then begin { Print Changed Properties }
              if not NewEditor.SameValue(DefaultTest, NewEditor.Value) then begin
                PrintProperty(RaveComp, BaseReport);
              end; { if }
            end else begin { Print Changed Exculding Size/Position Properties }
              if not NewEditor.SameValue(DefaultTest, NewEditor.Value) then begin
                if (PropInfo.Name <> 'Left') and (PropInfo.Name <> 'Top') and
                   (PropInfo.Name <> 'Bottom') and (PropInfo.Name <> 'Right') and
                   (PropInfo.Name <> 'Size') and (PropInfo.Name <> 'Height') and
                   (PropInfo.Name <> 'Width') then begin
                  PrintProperty(RaveComp, BaseReport);
                end; { if }
              end; { if }
            end;
          end; { with }
        end; { for }
      finally
        FreeMem(PropList,Count * SizeOf(pointer));
      end; { tryf }
  end; { with }
end;

procedure TSummaryForm.PrintProperty(RaveComp: TRaveComponent; BaseReport: TBaseReport);
var
  Finished: boolean;
begin
  with BaseReport do begin
    if YPos > PageHeight - MarginBottom then begin
      NewPage;
    end;

    XPos := MarginLeft + PrintOfs;
    Bold := SummaryForm.ckBoxPropertyNameBold.Checked;
    FontColor := SummaryForm.ColorBoxPropertyName.Selected;
    Print(string(PropInfo.Name) + ': ');
    Bold := false;
    FontColor := clBlack;
    if (PropInfo.Name = 'FillColor') or (PropInfo.Name = 'Color') then begin
      SetBrush(GetColorValue(NewEditor.Value), bsSolid, nil);
      rectangle(XPos, YPos - FontHeight, XPos + 0.15, YPos - FontHeight + 0.15);
      XPos := XPos + 0.3;
    end; { if }
    MemoBuf.PrintStart := XPos;
    MemoBuf.PrintEnd := PageWidth - MarginRight;
    MemoBuf.Text := NewEditor.Value;
    Finished := false;
    repeat
      if MemoLines(MemoBuf) > LinesLeft then begin { Print what can fit }
        PrintMemo(MemoBuf, LinesLeft, false);
        NewPage;
      end else begin { Print Remaining lines }
        PrintMemo(MemoBuf,0,false);
        Finished := true;
      end; { else }
    until Finished;

  end; { with }
end;

procedure TSummaryForm.RvSystem1Print(Sender: TObject);
begin
  PrintOfs := 0.0;
  with Sender as TBaseReport do begin
    SetFont('Courier New', 12);
    Home;
    Bold := true;
    PrintCenter('Report Summary', PageWidth / 2);
    Bold := false;
    NewLine;
    NewLine;

    if SummaryForm.rgrpReportType.ItemIndex = 0 then begin
      PrintComponent(ActiveReport.Project, Sender as TBaseReport);
    end else begin
      PrintComponent(ActiveReport, Sender as TBaseReport);
    end;
  end;
end;

procedure TSummaryForm.RvSystem1PrintHeader(Sender: TObject);
var
  SaveBold: boolean;
  SaveFontColor: TColor;
begin
  with Sender as TBaseReport do begin
    SaveBold := Bold;
    SaveFontColor := FontColor;
    SetFont('Courier New', 10);
    YPos := MarginTop / 2;
    PrintRight(IntToStr(CurrentPage) + '/' + Macro(midTotalPages),PageWidth - (MarginRight / 2));
    if CurrentPage > 1 then begin
      Home;
      PrintCenter('Report Summary continued...', PageWidth / 2);
      SetFont('Courier New', 12);
      NewLine;
      NewLine;
    end;
    FontColor := SaveFontColor;
    Bold := SaveBold;
  end; { with }
end;

procedure TSummaryForm.SavePrintOptions;
begin
{TransOff}
  try
    RaveSettings.CacheSaves := true;

    with RaveSettings.LockSection('ReportSummary') do try
    { Environment Settings }
      WriteInteger('ReportType',rgrpReportType.ItemIndex);
      WriteInteger('PropertyOptions', rgrpPropertyOptions.ItemIndex);
      WriteString('MarginLeft', EditMarginLeft.Text);
      WriteString('MarginRight', EditMarginRight.Text);
      WriteString('MarginTop', EditMarginTop.Text);
      WriteString('MarginBottom', EditMarginBottom.Text);

      WriteInteger('ComponentNameColor', Ord(ColorBoxComponentName.Selected));
      WriteBool('ComponentNameBold',ckBoxComponentNameBold.Checked);
      WriteInteger('ComponentTypeColor', Ord(ColorBoxComponentType.Selected));
      WriteBool('ComponentTypeBold',ckBoxComponentTypeBold.Checked);
      WriteInteger('PropertyNameColor', Ord(ColorBoxPropertyName.Selected));
      WriteBool('PropertyNameBold',ckBoxPropertyNameBold.Checked);
      WriteInteger('EventCodeColor', Ord(ColorBoxEventCode.Selected));
      WriteBool('EventCodeBold',ckBoxEventCodeBold.Checked);

      WriteInteger('EventOptions', rgrpEventOptions.ItemIndex);
    finally
      UnlockSection;
    end; { with }

  finally
    RaveSettings.CacheSaves := false;
    RaveSettings.Save;
  end; { with }
{TransOn}
end;

procedure TSummaryForm.EditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9','.',^H]) then begin
    Key := #0;
  end;
  with Sender as TEdit do begin
    if (Key = '.') and (Pos('.',Text) > 0) then begin
      Key := #0;
    end;
  end; { with }
end;

procedure TSummaryForm.PrintEvent(RaveComp: TRaveComponent;
  RaveEvent: TRaveEvent; BaseReport: TBaseReport);
var
  MemoText: string;
  MemoBuf: TMemoBuf;
  Finished: boolean;
  SaveBold: boolean;
  SaveColor: TColor;
  S1: string;
  RaveParent: TRaveComponent;
begin
  if SummaryForm.rgrpEventOptions.ItemIndex <= 0 then exit;
  with BaseReport do begin
    SaveBold := Bold;
    SaveColor := FontColor;
    MemoBuf := TMemoBuf.Create;
    try
      if SummaryForm.rgrpEventOptions.ItemIndex = 2 then begin
        S1 := RaveComp.Name;
        RaveParent := RaveComp.Parent;
        while Assigned(RaveParent) and Assigned(RaveParent.Parent) do begin
          S1 := RaveParent.Name + '.' + S1;
          RaveParent := RaveParent.Parent;
        end;
      end; { if }

      MemoBuf.Text := S1;
      MemoBuf.PrintStart := MarginLeft;
      MemoBuf.PrintEnd := PageWidth - MarginRight;
      Bold := SummaryForm.ckBoxComponentNameBold.Checked;
      FontColor := SummaryForm.ColorBoxComponentName.Selected;
      Finished := false;
      repeat
        if MemoLines(MemoBuf) > LinesLeft then begin { Print what can fit }
          PrintMemo(MemoBuf, LinesLeft, false);
          NewPage;
        end else begin { Print remaining lines }
          PrintMemo(MemoBuf, 0, false);
          Finished := true;
        end; { else }
      until Finished;


    MemoText := RaveEvent.Declaration;
    MemoText := MemoText + #13#10 + RaveEvent.Header;
    MemoText := MemoText + #13#10 + 'begin';
    MemoText := MemoText + #13#10 + RaveEvent.Body;
    MemoText := MemoText + #13#10 + RaveEvent.Footer;
    Bold := SummaryForm.ckBoxEventCodeBold.Checked;
    FontColor := SummaryForm.ColorBoxEventCode.Selected;

      MemoBuf.Text := MemoText;
      MemoBuf.PrintStart := MarginLeft;
      MemoBuf.PrintEnd := PageWidth - MarginRight;
      Finished := false;
      repeat
        if MemoLines(MemoBuf) > LinesLeft then begin { Print what can fit }
          PrintMemo(MemoBuf, LinesLeft, false);
          NewPage;
        end else begin { Print remaining lines }
          PrintMemo(MemoBuf, 0, false);
          Finished := true;
        end; { else }
      until Finished;
    finally
      FreeAndNil(MemoBuf);
    end;
    FontColor := SaveColor;
    Bold := SaveBold;
    NewLine;
  end; { with }
end;

initialization
  RegisterProc({Trans-}'RVCL',RaveRegister);
end.
