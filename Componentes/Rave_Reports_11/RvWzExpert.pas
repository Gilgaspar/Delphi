{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RvWzExpert;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, RvClass, RvProj, RvTool, RvToolEvents,
  RvDefine, RvToolUtil, CheckLst, IniFiles, ComCtrls;

const
  RaveReportExpertVersion: integer = 60001; { 6.0001 }
  RaveTestListMax = 9;

type
  TMessageType = (mtHint,mtWarning,mtError);

  TFormReportExpert = class(TForm)
    butnDoneContinue: TButton;
    PageControl1: TPageControl;
    TabSheetReport: TTabSheet;
    TabSheetSettings: TTabSheet;
    GlobalList: TCheckListBox;
    Label3: TLabel;
    Label4: TLabel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    butnAbort: TButton;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Splitter1: TSplitter;
    IgnoredItems: TCheckListBox;
    ReportItems: TCheckListBox;
    Label6: TLabel;
    ckboxExpertEnabled: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ckboxExpertEnabledClick(Sender: TObject);
    procedure ReportItemsClickCheck(Sender: TObject);
    procedure GlobalListClickCheck(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ReportItemsDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TReportExpertTest = class;

  TReportExpertTestInfo = class
  protected
    FReportExpertTest: TReportExpertTest;
    FTestSpace: string;
    FRaveComponent: TRaveComponent;
    FIgnored: boolean;
    FTestData: TStringList;

    function GetDescription: string;
    function GetID: string;
    function GetMessageType: TMessageType;
    procedure SetIgnored(const Value: boolean); virtual;
    function GetDisplayText: string; virtual;
    function GetIgnored: boolean; virtual;
    function GetReportName: string; virtual;
    function GetPageName: string; virtual;
    function GetComponentName: string; virtual;
    procedure SetComponent(Key: string);

    property ReportExpertTest: TReportExpertTest read FReportExpertTest write FReportExpertTest;
    property TestData: TStringList read FTestData write FTestData;

  public
    constructor Create(ExpertTest: TReportExpertTest); virtual;
    destructor Destroy; override;

    property ReportName: string read GetReportName;
    property PageName: string read GetPageName;
    property ComponentName: string read GetComponentName;
    property DisplayText: string read GetDisplayText;
    property Description: string read GetDescription;
    property RaveComponent: TRaveComponent read FRaveComponent write FRaveComponent;
    property ID: string read GetID;
    property Ignored: boolean read GetIgnored write SetIgnored;
    property MessageType: TMessageType read GetMessageType;
  end; { TReportExpertTestInfo }

  TReportExpertTestInfoGlobal = class(TReportExpertTestInfo)
  protected
    function GetIgnored: boolean; override;
    procedure SetIgnored(const Value: boolean); override;
  end; { TReportExpertTestInfoGlobal }

  TReportExpertProjectEditor = class(TRaveMasterProjectEditor,IRaveToolMenuEventHandler)
  protected
    FActiveReport: TRaveReport;
    FReportTests: TList;
    FIniFile: TIniFile;
    FFileName: TFileName;
    //
    procedure Add(TestInfo: TReportExpertTestInfo; CheckListBox: TCheckListBox);
    procedure FillCompList(List: TList; CompClass: TRaveComponentClass);

    function ReplaceExtension(AName: string; AExtension: string): string;

    property IniFile: TIniFile read FIniFile write FIniFile;
    property FileName: TFileName read FFileName write FFileName;
    property ReportTests: TList read FReportTests write FReportTests;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure AddToMenu(AddMenuItem: TAddMenuItemProc);
    procedure RunFromMenu(ID: integer);
    function BeforeReportPrint: boolean; override;
    procedure AfterProjectOpen; override;
    procedure AfterProjectSave; override;
    function BeforeProjectClose: boolean; override;
    procedure AfterNewProject; override;
    function AnalyzeReport(Report: TRaveReport; FromMenu: boolean): boolean;
  end; { TReportExpertProjectEditor }

  TReportExpertTest = class
  private
    FTestInfo: TReportExpertTestInfo;
    FGlobalTestInfo: TReportExpertTestInfoGlobal;
    FReportExpert: TReportExpertProjectEditor;
    FCompLists: array[0..RaveTestListMax] of TList;
    FCompIndexes: array[0..RaveTestListMax] of integer;
    FMessageType: TMessageType;
    FIgnoredList: TStringList;
    FGlobalIgnored: boolean;
    FSection: string;
    FKey: string;
    procedure FillCompList(List: TList; CompClass: TRaveComponentClass);
    function GetKey: string;
    function GetSection: string;
    function GetGlobalIgnored: boolean;
  protected
    function FindComp(Index: integer; CompClass: TRaveComponentClass): boolean;
    function GetComp(Index: integer): TRaveComponent;
    procedure ClearCompList(Index: integer);
    procedure Add(TestInfo: TReportExpertTestInfo; CheckListBox: TCheckListBox);
    function GetID: string; virtual; abstract;
    function GetDescription: string; virtual; abstract;
    procedure GetIgnored(IniFile: TIniFile); virtual;
    procedure SaveIgnored(IniFile: TIniFile); virtual;
    function CreateComponent(ARaveComponent: TRaveComponent): TReportExpertTestInfo; virtual;

    property ID: string read GetID;
    property Description: string read GetDescription;
    property MessageType: TMessageType read FMessageType write FMessageType;
    property IgnoredList: TStringList read FIgnoredList write FIgnoredList;
    property Section: string read GetSection write FSection;
    property Key: string read GetKey write FKey;
    property TestInfo: TReportExpertTestInfo read FTestInfo write FTestInfo;
    property GlobalTestInfo: TReportExpertTestInfoGlobal read FGlobalTestInfo write FGlobalTestInfo;
    property ReportExpert: TReportExpertProjectEditor read FReportExpert;
    property GlobalIgnored: boolean read GetGlobalIgnored write FGlobalIgnored;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Test; virtual;
  end; { TReportExpertTest }

  TReportExpertTestClass = class of TReportExpertTest;

var
  FormReportExpert: TFormReportExpert;

  procedure RaveRegister;
  procedure RegisterTest(TestClass: TReportExpertTestClass);

implementation

uses
  RvDirectDataView, RvDriverDataview;

{$R *.DFM}

var
  ReportExpertEnabled: boolean;
  ReportExpertTests: TList = nil;

procedure RaveRegister;
begin { RaveRegister }
  RegisterRaveProjectEditor(TReportExpertProjectEditor);
end;  { RaveRegister }

procedure RegisterTest(TestClass: TReportExpertTestClass);
begin { RegisterTest }
  if not Assigned(ReportExpertTests) then begin
    ReportExpertTests := TList.Create;
  end; { if }
  ReportExpertTests.Add(TestClass)
end;  { RegisterTest }

{ TFormReportExpert }

procedure TFormReportExpert.FormCreate(Sender: TObject);
begin
  FormTrans(self);
  PrepareToolWin(self);
  ckboxExpertEnabled.Checked := ReportExpertEnabled;
end;

procedure TFormReportExpert.FormDestroy(Sender: TObject);
begin
  SaveToolWin(self);
end;

procedure TFormReportExpert.FormShow(Sender: TObject);
begin
  RestoreToolWin(self);
  GlobalList.Enabled := ReportExpertEnabled;
end;

{ TReportExpertProjectEditor }

constructor TReportExpertProjectEditor.Create;
begin { Create }
  inherited Create;
// Read in settings info
  with RaveSettings.LockSection('ReportExpert') do try
    ReportExpertEnabled := ReadBool('Enabled',true);
  finally
    UnlockSection;
  end; { with }
end;  { Create }

destructor TReportExpertProjectEditor.Destroy;
begin { Destroy }
  inherited Destroy;
end;  { Destroy }

procedure TReportExpertProjectEditor.AddToMenu(AddMenuItem: TAddMenuItemProc);
begin { AddToMenu }
  AddMenuItem(self,'Report Expert',1,0);
end;  { AddToMenu }

procedure TReportExpertProjectEditor.RunFromMenu(ID: integer);
begin { RunFromMenu }
  AnalyzeReport(ProjectManager.ActiveReport, true);
end;  { RunFromMenu }

function TReportExpertProjectEditor.BeforeReportPrint: boolean;
begin
  if ReportExpertEnabled then begin
    Result := AnalyzeReport(ProjectManager.ActiveReport, false);
  end else begin
    Result := true;
  end; { else }
end;

function TReportExpertProjectEditor.AnalyzeReport(Report: TRaveReport; FromMenu: boolean): boolean;
var
  I1: integer;
  Test: TReportExpertTest;
begin
  Result := true;
  FActiveReport := Report;

// Build project item / data object list
  TRaveProjectManager(Report.Project).SetIncluded(Report);

// Create ReportExpert
  FormReportExpert := TFormReportExpert.Create(Application);
  try
    FormReportExpert.ReportItems.Clear;

  // Iterate through all registered tests
    if Assigned(ReportTests) then begin
      for I1 := 0 to ReportTests.Count - 1 do begin
        Test := ReportTests[I1];
        Test.FReportExpert := self;
        Test.Test;
      end; { for }
    end; { if }

    if FromMenu then begin
      FormReportExpert.butnAbort.Visible := false;
      FormReportExpert.PageControl1.ActivePage := FormReportExpert.TabSheetSettings;
      FormReportExpert.PageControl2.ActivePage := FormReportExpert.TabSheet3;
      FormReportExpert.ShowModal;
    end else begin
    // Show the expert interface if there were items !!! Don't call if everything was ignored items !!!
      if FormReportExpert.ReportItems.Items.Count > 0 then begin
        FormReportExpert.PageControl1.ActivePage := FormReportExpert.TabSheetReport;
        FormReportExpert.PageControl2.ActivePage := FormReportExpert.TabSheet3;
        FormReportExpert.butnDoneContinue.Caption := 'Continue';
        Result := FormReportExpert.ShowModal = mrOK;
      end; { if }
    end; { else }
  finally
    FreeAndNil(FormReportExpert);
  end; { with }
end;

procedure TReportExpertProjectEditor.FillCompList(List: TList; CompClass: TRaveComponentClass);

  procedure ProcessProjectItem(Item: TRaveProjectItem);
  var
    I1: integer;
    Comp: TRaveComponent;
  begin { ProcessProjectItem }
    if Item.Included then begin
      for I1 := 0 to Item.ComponentCount - 1 do begin
        Comp := TRaveComponent(Item.Components[I1]);
        if Comp is CompClass then begin // Handle descendents !!!
          List.Add(Comp);
        end; { if }
        if Comp is TRaveProjectItem then begin
          ProcessProjectItem(TRaveProjectItem(Comp));
        end; { if }
      end; { for }
    end; { if }
  end;  { ProcessProjectItem }

begin { FillCompList }
  ProcessProjectItem(FActiveReport.Project);
end;  { FillCompList }

procedure TReportExpertProjectEditor.Add(TestInfo: TReportExpertTestInfo; CheckListBox: TCheckListBox);
begin
  with CheckListBox do begin
    Items.AddObject(TestInfo.DisplayText, TestInfo);
    Checked[Count - 1] := TestInfo.Ignored;
  end; { with }
end;

procedure TReportExpertProjectEditor.AfterProjectOpen;
var
  I1: integer;
  Test: TReportExpertTest;
begin
  if not Assigned(FReportTests) then begin
    FReportTests := TList.Create;
  end;
  if Assigned(ReportExpertTests) then begin
    try
      FileName := ReplaceExtension(RvProj.ProjectManager.FileName,'rrx');
      FIniFile := TIniFile.Create(FileName);
      for I1 := 0 to ReportExpertTests.Count - 1 do begin
        Test := TReportExpertTestClass(ReportExpertTests[I1]).Create;
        Test.FReportExpert := self;
        Test.GetIgnored(IniFile);
        ReportTests.Add(Test);
      end; { for }
    finally
      FreeAndNil(FIniFile);
    end;
  end; { if }
end;

procedure TReportExpertProjectEditor.AfterProjectSave;
var
  I1: integer;
  Test: TReportExpertTest;
begin
  if Assigned(ReportExpertTests) then begin
    FileName := ReplaceExtension(RvProj.ProjectManager.FileName,'rrx');
    if FileExists(FileName) then begin
      DeleteFile(FileName);
    end;
    IniFile := TIniFile.Create(FileName);
    try
      for I1 := 0 to ReportTests.Count - 1 do begin
        Test := ReportTests[I1];
        Test.SaveIgnored(IniFile);
      end; { for }
    finally
      FreeAndNil(FIniFile);
    end;
  end; { if }
end;

procedure TReportExpertProjectEditor.AfterNewProject;
begin
  AfterProjectOpen;
end;

function TReportExpertProjectEditor.BeforeProjectClose: boolean;
begin
  Result := true;
end;

function TReportExpertProjectEditor.ReplaceExtension(AName,
  AExtension: string): string;
var
  DotPos: integer;
begin
  DotPos := Pos('.', AName);
  if DotPos > 0 then begin
    Result := Copy(AName, 1, DotPos);
    Result := Result + AExtension;
  end else begin
    Result := AName + '.' + AExtension;
  end; { else }
end;


{ TReportExpertTest }

procedure TReportExpertTest.Add(TestInfo: TReportExpertTestInfo; CheckListBox: TCheckListBox);
begin
  FReportExpert.Add(TestInfo, CheckListBox);
end;

procedure TReportExpertTest.ClearCompList(Index: integer);
begin
  FreeAndNil(FCompLists[Index]);
  FCompIndexes[Index] := 0;
end;

constructor TReportExpertTest.Create;
begin
  FillChar(FCompLists,SizeOf(FCompLists),0);
  FillChar(FCompIndexes,SizeOf(FCompIndexes),0);
  FIgnoredList := TStringList.Create;
end;

destructor TReportExpertTest.Destroy;
var
  I1: integer;
begin
  for I1 := 0 to FIgnoredList.Count - 1 do begin
    FIgnoredList.Objects[I1].Free;
  end; { for }
  FreeAndNil(FIgnoredList);
  for I1 := 0 to RaveTestListMax do begin
    if Assigned(FCompLists[I1]) then begin
      FreeAndNil(FCompLists[I1]);
    end; { if }
  end; { for }
  inherited;
end;

procedure TReportExpertTest.FillCompList(List: TList; CompClass: TRaveComponentClass);
begin
  FReportExpert.FillCompList(List,CompClass);
end;

function TReportExpertTest.FindComp(Index: integer; CompClass: TRaveComponentClass): boolean;
begin
  if Assigned(FCompLists[Index]) then begin // Advance index
    Inc(FCompIndexes[Index]);
  end else begin // Create and initialize list
    FCompLists[Index] := TList.Create;
    FillCompList(FCompLists[Index],CompClass);
    FCompIndexes[Index] := 0;
  end; { else }

// Check for validity of index in list
  Result := (FCompIndexes[Index] < FCompLists[Index].Count);
  if not Result then begin
    ClearCompList(Index);
  end; { if }
end;

function TReportExpertTest.GetComp(Index: integer): TRaveComponent;
begin
  if Assigned(FCompLists[Index]) and (FCompIndexes[Index] < FCompLists[Index].Count) then begin
    Result := TRaveComponent(FCompLists[Index].Items[FCompIndexes[Index]]);
  end else begin
    Result := nil;
  end; { else }
end;

procedure TReportExpertTest.GetIgnored(IniFile: TIniFile);
var
  Sections: TStringList;
  I1: integer;
begin
  if IniFile.ValueExists('Global', ID) then begin
    GlobalIgnored := true;
  end; { if }

  // read test components
  if IniFile.SectionExists(Section) then begin
    Sections := TStringList.Create;
    try
      IniFile.ReadSection(Section, Sections);
      for I1 := 0 to Sections.Count - 1 do begin
        TestInfo := TReportExpertTestInfo.Create(self);
        TestInfo.TestData.DelimitedText := IniFile.ReadString(Section, Sections[I1], '');
        TestInfo.SetComponent(Sections[I1]);
        TestInfo.Ignored := true;
        IgnoredList.AddObject(Sections[I1], TestInfo);
      end;
    finally
      FreeAndNil(Sections);
    end;
  end; { if }
end;

function TReportExpertTest.GetKey: string;
begin
  if Assigned(TestInfo) then begin
    with TestInfo do begin
      if TestInfo is TReportExpertTestInfoGlobal then begin
        Result := ID;
      end else if ReportName <> '' then begin
        Result := ReportName + '.' + PageName + '.' + ComponentName;
      end else if RaveComponent.Parent is TRavePage then begin
        Result := 'GlobalPage.' + PageName + '.' + ComponentName;
      end else if RaveComponent is TRaveDataView then begin
        Result := 'RaveDataView.' + ComponentName;
      end else if RaveComponent is TRaveDriverDataView then begin
        Result := 'DriverDataView.' + ComponentName;
      end else begin
        Result := ComponentName;
      end;
    end; { with }
  end else begin
    Result := '';
  end;
end;

function TReportExpertTest.GetSection: string;
begin
  Result := ID;
  if Assigned(TestInfo) then begin
    if TestInfo is TReportExpertTestInfoGlobal then begin
      Result := 'Global';
    end; { if }
  end; { if }
end;

function TReportExpertTest.GetGlobalIgnored: boolean;
begin
  Result := FGlobalIgnored;
end;

procedure TFormReportExpert.ckboxExpertEnabledClick(Sender: TObject);
begin
  ReportExpertEnabled := ckboxExpertEnabled.Checked;
  GlobalList.Enabled := ReportExpertEnabled;

// Write out new state
  with RaveSettings.LockSection('ReportExpert') do try
    WriteBool('Enabled',ReportExpertEnabled);
  finally
    UnlockSection;
  end; { with }
end;

procedure TFormReportExpert.ReportItemsClickCheck(Sender: TObject);
var
  TI: TReportExpertTestInfo;
begin
  with Sender as TCheckListBox do begin
    if (ItemIndex < 0) or (ItemIndex > Count - 1) then begin
      Exit;
    end; { if }
    TI := TReportExpertTestInfo(Items.Objects[ItemIndex]);
    TI.Ignored := Checked[ItemIndex];
    Items.Delete(ItemIndex);
  end; { with }
  if TI.Ignored then begin
    IgnoredItems.AddItem(TI.DisplayText, TI);
    IgnoredItems.Checked[IgnoredItems.Items.Count - 1] := true;
  end else begin
    ReportItems.AddItem(TI.DisplayText, TI);
  end;
  RvProj.ProjectManager.DataChanged := true;
  FormResize(FormReportExpert);
end;

procedure TReportExpertTest.SaveIgnored(IniFile: TIniFile);
var
  I1: integer;
begin
  // Save GlobalIgnored
  if GlobalIgnored then begin
    IniFile.WriteString('Global', ID, GlobalTestInfo.TestData.DelimitedText);
  end; { if }
  // Save Ignored Tests
  if Assigned(IgnoredList) then begin
    for I1 := 0 to IgnoredList.Count - 1 do begin
      TestInfo := TReportExpertTestInfo(IgnoredList.Objects[I1]);
      IniFile.WriteString(Section, Key, TestInfo.TestData.DelimitedText);
    end; { for }
  end; { if }
end;

procedure TReportExpertTest.Test;
begin
  GlobalTestInfo := TReportExpertTestInfoGlobal.Create(self);
  with FormReportExpert.GlobalList do begin
    AddItem(GlobalTestInfo.DisplayText, GlobalTestInfo);
    Checked[Count - 1] := GlobalIgnored;
  end; { with }
end;

function TReportExpertTest.CreateComponent(ARaveComponent: TRaveComponent): TReportExpertTestInfo;
var
  I1: integer;
begin
  Result := nil;
  if Assigned(IgnoredList) then begin
    for I1 := 0 to IgnoredList.Count - 1 do begin
      Result := TReportExpertTestInfo(IgnoredList.Objects[i1]);
      if Result.RaveComponent = ARaveComponent then begin
        break;
      end else begin
        Result := nil;
      end; { else }
    end; { for }
  end;
  if not Assigned(Result) then begin
    Result := TReportExpertTestInfo.Create(self);
    Result.RaveComponent := ARaveComponent;
  end;
end;

{ TReportExpertTestInfo }

constructor TReportExpertTestInfo.Create(ExpertTest: TReportExpertTest);
begin
  FReportExpertTest := ExpertTest;
  FTestSpace := 'Nevrona.Standard';
  FTestData := TStringList.Create;
end;

function TReportExpertTestInfo.GetDisplayText: string;
begin
  case MessageType of
    mtHint: Result := '[Hint] ';
    mtWarning: Result := '[Warning] ';
    else Result := '[Error] ';
  end;
  if ReportName <> '' then begin
    Result := Result + ReportName + '.' + PageName + '.' +
              ComponentName + ': ' + Description;
  end else if Assigned(RaveComponent) and (RaveComponent.Parent is TRavePage) then begin
    Result := Result + 'GlobalPage.' + PageName + '.' +
               ComponentName + ': ' + Description;
  end else begin
    Result := Result + ComponentName + ': ' + Description;
  end;
  Result := Result + ' - ' + DateTimeToStr(Now);
end;

function TReportExpertTestInfo.GetIgnored: boolean;
begin
  Result := FIgnored;
end;

function TReportExpertTestInfo.GetComponentName: string;
begin
  if Assigned(RaveComponent) then begin
    Result := RaveComponent.Name;
  end else begin
    Result := '';
  end; { else }
end;

function TReportExpertTestInfo.GetPageName: string;
begin
  if Assigned(RaveComponent) and Assigned(RaveComponent.Page) then begin
    Result := RaveComponent.Page.Name;
  end else begin
    Result := '';
  end; { else }
end;

function TReportExpertTestInfo.GetReportName: string;
begin
  if Assigned(RaveComponent) and Assigned(RaveComponent.Report) then begin
    Result := RaveComponent.Report.Name;
  end else begin
    Result := '';
  end; { else }
end;

procedure TReportExpertTestInfo.SetIgnored(const Value: boolean);
var
  Section: string;
  Key: string;
  Found: boolean;
  Index: integer;
begin
  Section := ID;
  if ReportName <> '' then begin
    Key := ReportName + '.' + PageName;
  end else if RaveComponent.Parent is TRavePage then begin
    Key := 'GlobalPage';
  end else if RaveComponent is TRaveDriverDataview then begin
    Key := 'DriverDataview';
  end;
  Key := Key + '.' + ComponentName;
  Index := ReportExpertTest.IgnoredList.IndexOf(Key);
  Found := Index >= 0;
  if Value then begin
    if not Found then begin
      FIgnored := true;
      ReportExpertTest.IgnoredList.AddObject(Key,self);
    end; { if }
  end else begin
    FIgnored := false;
    if Found then begin
      ReportExpertTest.IgnoredList.Delete(index);
    end; { if }
  end;
end;

function TReportExpertTestInfo.GetDescription: string;
begin
  Result := ReportExpertTest.Description;
end;

function TReportExpertTestInfo.GetID: string;
begin
  Result := ReportExpertTest.ID;
end;

function TReportExpertTestInfo.GetMessageType: TMessageType;
begin
  Result := ReportExpertTest.MessageType;
end;

destructor TReportExpertTestInfo.Destroy;
begin
  inherited;
  FreeAndNil(FTestData);
end;

procedure TReportExpertTestInfo.SetComponent(Key: string);
var
  S1: string;
begin
  repeat
    S1 := Copy(Key, 1, Pos('.',Key) -1);
    Key := Copy(Key, Pos('.', Key) + 1, Length(Key));
    if S1 = '' then begin
      RaveComponent := RvProj.ProjectManager.FindRaveComponent(Key, RaveComponent);
    end else begin
      RaveComponent := RvProj.ProjectManager.FindRaveComponent(S1, RaveComponent);
    end; { else }
  until S1 = '';
end;

{ TReportExpertTestInfoGlobal }

function TReportExpertTestInfoGlobal.GetIgnored: boolean;
begin
  Result := ReportExpertTest.GlobalIgnored;
end;

procedure TReportExpertTestInfoGlobal.SetIgnored(const Value: boolean);
begin
  ReportExpertTest.GlobalIgnored := Value;
end;

procedure TFormReportExpert.GlobalListClickCheck(Sender: TObject);
var
  TI: TReportExpertTestInfoGlobal;
begin
  with Sender as TCheckListBox do begin
    TI := TReportExpertTestInfoGlobal(Items.Objects[ItemIndex]);
    TI.Ignored := Checked[ItemIndex];
  end; { with }
  RvProj.ProjectManager.DataChanged := true;
end;

procedure TFormReportExpert.FormResize(Sender: TObject);
var
  MaxLen: integer;
  I1, I2, Len: integer;
  CheckListBox: TCheckListBox;
begin
  for I1 := 0 to 3 do begin
    case I1 of
      0: CheckListBox := ReportItems;
      1: CheckListBox := IgnoredItems;
      else begin
        CheckListBox := GlobalList;
      end; { else }
    end; { case }
    canvas.font := CheckListBox.font;
    maxlen := 0;
    for I2 := 0 To CheckListBox.Items.Count - 1 do begin
      Len:= Canvas.TextWidth( CheckListBox.items[I2] );
      if Len > MaxLen then
        MaxLen := Len;
    end;
    Canvas.Font := Font;
    MaxLen := MaxLen + 18; // add checkbox width
    CheckListBox.Perform( LB_SETHORIZONTALEXTENT, MaxLen, 0 );
  end; { for }
end;

procedure TFormReportExpert.ReportItemsDblClick(Sender: TObject);
var
  RaveComponent: TRaveComponent;
begin
  with Sender as TCheckListBox do begin
    RaveComponent := TReportExpertTestInfo(Items.Objects[ItemIndex]).RaveComponent;
  end; { with }
  if Assigned(RaveComponent.Report) and
   (ProjectManager.ActiveReport <> RaveComponent.Report) then begin
    ProjectManager.ActivateReport(TRaveReport(RaveComponent.Report));
  end;
  PageDesignerEventHandler.ShowPage(RaveComponent);
  CurrentDesigner.ClearSelection;
  CurrentDesigner.SelectControl(RaveComponent);
//!!!  if RIDEPropertyPanel.PropertyPanel.Selections > 0 then begin
//    FindNode(PropertyPanel.Selection[0]).MakeVisible;
//  end; { if }
end;

initialization
  RegisterProc({Trans-}'RVCL',RaveRegister);
end.
