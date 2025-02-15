unit vcl.Wwcommon;
{$T-}  { Disable Typed@ Operator}
{
//
// Components : Common routines
//
// Copyright (c) 1995, 1996, 1997, 1998 by Woll2Woll Software
//
//  7/24/97 - Linked field filter did not work when using multiple lookuptables
//
//  8/14/97 - Optimized logic to speed painting of grid
//            in wwDataSet_GetControl method
//
// 10/16/97 - Skip descending test if using IndexFieldNames
//
// 11/14/97 - Have wwSetLookupField work for virtual datasets
//
// 2/24/98 - Subtrack length(key) when padding NarrowSearchUpperChar
//
// 3/02/98 - Don't specify extension when opening picture-mask table
//
// 3/31/98 - Determine if this is a single line edit control based on passed in rectangle
//
// 9/13/98 - Changed handle to HDC in wwIsSingleLineEdit
// 9/16/98 - WordBool is 2 bytes
// 11/7/98 - Add support for filtering on lookupfields in clientdatasets
//           from the filterdialog.
// 11/21/99 - Support BCD for creating tparam
// 2/8/2000 - SetSQLProp now passes propertyname
// 6/11/2001 - Added vertical alignment support for single line edit - PYW.
// 2/14/2002 - Added wwCopyToClipboard function. -PYW
// 4/10/2002 - Save and Restore Text Color. -PYW
// 6/23/03 - Check for null lookup value
// 7/18/03 - Multi-field search skips - Fixed bug
}
interface

uses classes, db, sysutils, dialogs, wwstr, {dbTables, }forms, controls,
     windows, graphics, buttons, wwtypes, wwlocate,
     stdctrls, comctrls, themes, regularexpressions, imglist, commctrl,
     system.Types, system.UITypes,
     wwbitmap,

{$i wwIfDef.pas}

registry, dateutils;

const
   WW_DB_COMBO = 'Combo';
   WW_DB_LOOKUP_COMBO = 'LookupCombo';  { Backward compatibility with Infopower 1.2}
   WW_DB_EDIT = 'CustomEdit';
   WW_DB_RICHEDIT = 'RichEdit';


type
  wwSmallString = string;
  TwwPointSet = (psGlyph, psText, psOffset);
  TwwPointSets = set of TwwPointSet;

  Function wwIsDelphiApp: boolean;
Function wwGridEssentials: boolean;
Procedure DisplayProfessionalVersionOnlyMessage(Component: TComponent; msg: string);
Procedure DisplayProfessionalMessage(Component: TComponent; msg: string);

Function wwGetControlList(Controller: TComponent): TList;
procedure wwUpdateController(
   var FController: TComponent;
   Value: TComponent;
   Control: TComponent);

function wwGetEventShift(Shift: TShiftState): Integer;
procedure wwClearControls(Component: TComponent);
function wwHaveVisibleChild(ac: TWinControl): boolean;  // i.e. Combo dropped down
function wwIsDesigning(control: TControl): boolean;
Function wwGetPictureControl(Control: TComponent; DataSet: TDataSet = nil): TComponent;
Function wwGetPictureMasks(DataSet: TComponent): TStrings;
Procedure wwRegexByField(DataSet: TComponent; FieldName: string;
    var Mask: string; var CaseSensitive: boolean; var ErrorMsg: string);
Function wwGetRegexMasks(DataSet: TComponent): TStrings;
function wwGetComCtlVersion: Integer;
procedure wwSetRegexMasks(dataSet: TComponent; AFieldName: string;
    AMask: string;
    CaseSensitive: boolean;
    ErrorMsg: string);
Function wwGetStrings(Component: TComponent; PropertyName: string): TStrings;
Function wwGetControlType(dataSet: TComponent): TStrings;
Function wwGetValidateWithMask(dataSet: TDataSet): boolean;
Function wwGetControlTypeControl(Control: TComponent; DataSet: TDataSet = nil): TComponent;
Function wwGetControlInfoInDataSet(component: TComponent): boolean;
Function wwGetPictureMaskFromDataSet(Component: TComponent): boolean;
Function wwGetLookupFields(dataSet: TDataSet): TStrings;
Function wwGetLookupLinks(dataSet: TDataSet): TStrings;
Function wwGetDatabaseName(dataSet: TDataSet): String;
Function wwGetConnectionString(dataSet: TDataSet): String;
Function wwGetConnection(dataSet: TDataSet): TComponent;
Function wwHaveDatabase(dataSet: TDataSet): boolean;
//Function wwIsSQLBased(dataSet: TDataSet): boolean;

Function wwGetTableName(dataSet: TDataSet): String;
Function wwDataSetIsValidField(dataset : TComponent; fieldName : string): boolean;
Procedure wwDataSetUpdateFieldProperties(dataSet: TDataSet; selected: TStrings);
Procedure wwDataSetUpdateSelected(dataSet: TDataSet; selected: TStrings);
Function wwDataSet(dataSet : TDataSet): boolean;
Procedure wwDebug(s: string);
//Function wwSetLookupField(dataSet: TDataSet; linkedField: TField): boolean;
procedure wwDataSetDoOnCalcFields(dataSet: TDataSet;
          FLookupFields, FLookupLinks: TStrings;
          lookupTables: TList);
procedure wwDataSetRemoveObsolete(dataSet: TComponent;
          FLookupFields, FLookupLinks, FControlType: TStrings);
Function wwTableFindNearest(dataSet: TDataSet; key: string; FieldNo: integer): boolean;
procedure wwTableChangeIndex(dataSet: TDataSet; a_indexItem: TIndexDef);
Function wwDataSetGetLinks(dataSet: TDataSet; lookupFieldName: string): string;
Function wwDataSetGetDisplayField(dataSet: TDataSet; lookupFieldName: string): string;
Function wwDataSetSyncLookupTable(dataSet: TDataSet; AlookupTable: TDataSet;
                  lookupFieldName: string; var fromField: string): boolean;
//Function wwDataSetRemoveObsoleteControls(parentForm: TCustomForm; dataSet: TComponent): boolean;

procedure wwDataSet_SetControl(dataSet: TComponent;
          AFieldName: string; AComponentType: string; AParameters: string);
function wwFieldIsValidValue(fld: TField; key: string): boolean;
Function wwIsValidValue(FldType: TFieldType; key: string):boolean;
Procedure wwIsValidValue2(FldType: TFieldType; key: string);
Function wwFieldIsValidLocateValue(fld: TField; key: string):boolean;
//Function wwGetAlias(aliasName: string): string; {Moved to bdecommon}
//Function wwSaveAnswerTable(ADataSet: TDBDataSet; AHandle: HDbiCur; tableName: string): boolean;
Function wwInPaintCopyState(ControlState: TControlState): boolean;
Function wwDataSetLookupDisplayField(
   curField: TField; var LookupValue: string; var DisplayField: TField): boolean;
procedure wwPlayKeystroke(Handle: HWND; VKChar: word; VKShift: Word);
procedure wwDataSet_GetControl(dataSet: TComponent; AFieldName: string;
                      var AControlType: string; var AParameters: string);
//function wwGetQueryText(tempQBE: TStrings; Sql: boolean): PAnsiChar;
Function wwMemAvail(memSize: integer): boolean;
Procedure wwPictureByField(DataSet: TComponent; FieldName: string; FromTable: boolean;
    var Mask: string; var AutoFill, UsePictureMask: boolean);
procedure wwSetPictureMask(dataSet: TComponent; AFieldName: string;
    AMask: string;
    AutoFill: boolean;
    UsePictureMask: boolean;
    SetMask: boolean;
    SetAutoFill: boolean;
    SetUsePictureMask: boolean);
Function wwGetFieldNameFromTitle(DataSet: TDataSet; fieldTitle: string): string;
Function wwGetListIndex(list: TStrings; itemName: string): integer;
Function wwGetOwnerForm(component: TComponent):TCustomForm;
Function wwGetOwnerFrameOrForm(component: TComponent):TComponent;
procedure wwClearAltChar;
Function isWWEditControl(pname: string): boolean;
procedure wwDataModuleChanged(temp: TComponent);
Function wwDoLookupTable(ALookupTable : TDataset;  DataSet: TDataset; links: TStrings) : boolean;
Procedure wwDrawGlyph(
    Bitmap: TBitmap;
    Canvas: TCanvas; R: TRect;
    State: TButtonState;
    Enabled: Boolean;
    Transparent: boolean;
    FlatButtonTransparent: boolean;
    ControlState: TControlState);
function TrialExpired: boolean;

Procedure wwDrawEllipsis(Canvas: TCanvas; R: TRect;
    State: TButtonState;
    Enabled: Boolean;
    Transparent: boolean;
    FlatButtonTransparent: boolean;
    ControlState: TControlState);
Procedure wwDrawDropDownArrow(Canvas: TCanvas; R: TRect;
    State: TButtonState;
    Enabled: Boolean;
    ControlState: TControlState);
Function wwHasIndex(ADataSet: TDataSet): boolean;
Function wwIsTableQuery(ADataSet: TDataSet): boolean;
Function wwPdxPictureMask(ADataSet: TDataSet; AFieldName: string): string;
procedure wwFixMouseDown;
procedure wwValidatePictureFields(ADataSet: TDataSet;
     FOnInvalidValue: TwwInvalidValueEvent);
function wwDataSetFindRecord(
   DataSet: TDataSet;
   KeyValue: string;
   LookupField: string;
   MatchType: TwwLocateMatchType;
   caseSensitive: boolean): boolean;
//Procedure wwOpenPictureDB(wwtable: TTable);
Function wwValidFilterableFieldType(ADataType: TFieldType): boolean;
procedure wwALinkHelp(Handle: HWND; ALink: string);
procedure wwHelp(Handle: HWND; HelpTopic: PChar);
Function wwIsValidChar(key: word): boolean;
Function wwGetOnInvalidValue(DataSet: TDataSet): TwwInvalidValueEvent;
Function wwGetCalcCellColorsEvent(Grid: TWinControl): TMethod;
Function wwGetOnPerformCustomSearch(Component: TComponent): TwwPerformSearchEvent;

procedure wwDataSet_SetLookupLink(dataSet: TDataSet;
   FldName, DatabaseName, TableName, DisplayFld, IndexFieldNames, Links: string;
   useExtension: Char);
Function wwFindSelected(selected: TStrings;
   FieldName: string; var index: integer): boolean;
Function wwAdjustPixels(PixelSize,PixelsPerInch : integer): integer;
Function wwProcessEscapeFilterEvent(dataset: TDataset): boolean;
Procedure wwSetOnFilterEnabled(dataset: TDataset; val: boolean);
Function wwGetOnFilterOptions(dataset: TDataset): TwwOnFilterOptions;
Function wwmin(x,y: integer): integer;  {4/10/97}
Function wwlimit(val, x,y: integer): integer;  {4/10/97}
Function wwmax(x,y: integer): integer;  {4/10/97}
Function wwDataSet_GetFilterLookupField(dataSet: TDataSet; curfield: TField; AMethod: TMethod): TField;
//Procedure wwConvertFieldToParam(OtherField:TField;var AFilterParam:TParam;AFilterFieldBuffer: PAnsiChar);
Function wwisNonBDEField(thisField: TField): boolean;
Function wwisNonPhysicalField(thisField: TField): boolean;
Function wwSetControlDataSource(ctrl: TControl; ds: TDataSource): boolean;
Function wwSetControlDataSet(ctrl: TComponent; DataSet: TDataSet; PropertyName: string): boolean;
Function wwSetControlDataField(ctrl: TControl; df: string): boolean;
Function wwGetControlDataField(ctrl: TControl): string;
Function wwGetControlDataSource(ctrl: TComponent): TDataSource;
Function wwGetControlMasterSource(ctrl: TComponent): TDataSource;
Function wwSetDatabaseName(ctrl: TDataset; df: string): boolean;
Function wwSetIndexFieldNames(ctrl: TDataset; df: string): boolean;
Function wwSetTableName(ctrl: TDataset; df: string): boolean;
Function wwSetSessionName(ctrl: TDataset; df: string): boolean;
Function wwSetString(ctrl: TComponent; PropertyName : string; s: string): boolean;
Function wwSetConnectionString(ctrl: TDataset; df: string): boolean;
Function wwSetConnection(ctrl: TDataset; Connection: TComponent): boolean;
Function wwGetSessionName(dataSet: TDataSet): String;
//function wwDataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TBookmark): CmpBkmkRslt;
function wwDataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TBookmark): integer;
function wwIsClass(ClassType: TClass; const Name: string): Boolean; overload;
function wwIsClass(component: TComponent; const Name: string): boolean; overload;
function wwGetWorkingRect:TRect;
Function wwApplyPictureMask(Control: TCustomEdit; PictureMask: string; AutoFill: boolean; var Key: Char): boolean;
Function wwValidPictureValue(Control: TCustomEdit; PictureMask: string): boolean;
Function wwGetSQLWord(s: string; var APos: integer): string;
Function wwSetSQLProp(ctrl: TDataset; sql: TStrings; PropName: string): boolean;
Function wwSetParamsProp(ctrl: TDataset; Params: TParams): boolean;
Function wwGetParamsProp(ctrl: TDataset): TParams;
Function wwGetAlwaysTransparent(ctrl:  TControl): boolean;
Function wwSetBoolean(ctrl: TComponent; PropertyName: string; val: boolean): boolean;
Function wwSetRequestLive(ctrl: TDataset; val: boolean): boolean;
Function wwGetParamCheck(ctrl: TDataset): boolean;
Function wwGetBorder(ctrl: TControl): boolean;
Function wwSetBorder(ctrl: TControl; val: boolean): boolean;

Function wwGetWantReturns(ctrl: TControl): boolean;
Function wwSetReadOnly(ctrl: TComponent; val: boolean): boolean;
Function wwGetReadOnly(ctrl: TComponent): boolean;

Function wwSetParamCheck(ctrl: TDataset; val: boolean): boolean;
Function wwGetIBDatabase(dataSet: TDataSet): TComponent;
Function wwSetIBDatabase(Dataset: TDataSet; db: TComponent): boolean;

{ 9/13/98 - Changed handle to HDC }
Function wwIsSingleLineEdit(AHandle:HDC; Rect: TRect; Flags:Integer): boolean;
{Procedure wwCopyDatasetProp(dataset1, dataset2: TDataset);}

Function wwGetControlPictureMask(ctrl: TCustomEdit): String;
Procedure wwSetControlPictureMask(ctrl: TCustomEdit; PictureMask: string);
Function wwGetControlAutoFill(ctrl: TCustomEdit): boolean;
Procedure wwSetControlAutoFill(ctrl: TCustomEdit; AutoFill: boolean);

function RichEditTextToPlainText(
      Owner: TWinControl;
      MemoString: string;
      var RichEditControl: TCustomRichEdit;
      var MemoryStream: TStringStream): string; overload;

procedure RichEditTextToPlainText(
      Owner: TWinControl;
      MemoBuffer: PChar;
      var numRead: Cardinal;
      var RichEditControl: TCustomRichEdit;
      var MemoryStream: TStringStream); overload;

function wwIsRichEditField(Field: TField; ExamineData: boolean): boolean;

//procedure wwGetInterface(AObject: TObject; IID: TGUID; out Obj);
procedure wwDrawFocusRect(ACanvas: TCanvas; ARect: TRect);
{$ifdef wwDelphi4Up}
function UpdatedVCL4Version: boolean;
{$endif}
function wwIsCustomEditCell(
        Component: TComponent;
        ownerForm: TComponent;
        curField: TField;
        var customEdit: TWinControl) : boolean;
function IsInGridPaint(dtp:TWinControl):boolean;
function IsInGrid(dtp:TWinControl):boolean;

function IsInwwGridPaint(control: TWinControl):boolean;
function IsInwwObjectView(control: TWinControl):boolean;
function IsInwwObjectViewPaint(control: TWinControl):boolean;
procedure wwDottedLine(Canvas: TCanvas; p1, p2: TPoint);
procedure wwSetTableIndex(DataSet: TDataSet; FieldName: string);
function wwGetThemedTextColor(var ThemeTextColor: TColor): boolean;
procedure wwDrawThemedText(
   ACanvas: TCanvas; s: String; R: TRect; Flags: Cardinal; Theme: TThemedEdit=teEditTextNormal);
procedure wwDrawThemedTitleText(
   ACanvas: TCanvas; s: String; R: TRect; Flags: Cardinal);

Procedure wwWriteTextLinesT(ACanvas: TCanvas;
    const ARect: TRect; DX, DY: Integer; S: PChar; Alignment: TAlignment;
    WriteOptions: TwwWriteTextOptions);
function wwRectWidth(Rect: TRect): Integer;
function wwRectHeight(Rect: TRect): Integer;
procedure wwDisableParentClipping(Parent: TWinControl);
function wwSetDatabaseCursorType(DataSet: TDataSet; val: integer): boolean;
function wwGetDatabaseCursorType(DataSet: TDataSet): integer;
function wwGetCommandType(DataSet: TDataSet): integer;
function wwSetDatabaseMaxRecords(DataSet: TDataSet; val: integer): boolean;
//procedure wwAdjustHeight(Control: TWinControl);
procedure wwcopyToClipBoard(const str: string; const htmlStr: string = '');
function wwGetOrdProp(Component: TPersistent; PropName: string): Integer;
Function wwGetEditCalculated(ctrl: TControl): boolean;
function wwUseThemes(Control: TControl): boolean;
Function wwGetDataSet(DataSet: TComponent): TDataSet;
Function wwGetDataSource(DataSet: TComponent): TDataSource;

//Function wwGetIndexDefs(Component: TComponent): TIndexDefs;

//Function wwGetIndexField(Component: TComponent; index): TField;
function wwGetVariable(Component: TComponent; VariableName: string): Variant; overload;
function wwGetVariableWithParams(Component: TComponent; VariableName: string;
   Params: variant): Variant;
function wwGetVariableWithParams2(Component: TComponent; VariableName: string;
            const StartValues, EndValues: array of const): Variant;
function wwGetVariableObject(Component: TComponent; VariableName: string; Param: variant): TObject;
procedure wwSetVariable(Component: TComponent; VariableName: string; Value: Variant);
procedure wwSetVariableObject(Component: TComponent; VariableName: string; Value: TObject);


function IsVistaComCtrlVersion: boolean;
function IsVista: boolean;

function RegexMatch(pattern: string; icasePattern: boolean; input: string): boolean;
function RegexSyntaxValid(pattern: string): boolean;

procedure wwFillEditThemeBackground(
   IsDroppedDown: boolean; MouseInControl: boolean; ARect: TRect; FCanvas: TCanvas);

procedure wwFillEditThemeBackgroundDefault(
   ARect: TRect; FCanvas: TCanvas);

function wwTableFindRecord(
   LookupTable: TDataset;
   KeyValue: string;
   LookupField: string;
   MatchType: TwwLocateMatchType;
   caseSensitive: boolean): boolean;
procedure wwSetToIndexContainingField(LookupTable: TDataSet; fieldName: string);


// from ipstudio.net library
function wwGetIndexDefs(Dataset: TDataSet; var IndexDefs: TIndexDefs): boolean;
function wwGetIndexName(DataSet: TDataSet): string;
Function wwGetIndexFieldName(table: TDataSet): string;
function wwGetIndexFieldNames(DataSet: TDataSet): String;
function wwDataSetActiveIndexDef(Dataset: TDataSet; var ActiveIndexDef: TIndexDef): boolean;
function wwDataSetIsValidIndexField(Dataset: TDataSet; FieldName: string; CaseSensitive: boolean; var IndexName: string): boolean; overload;
function wwDataSetIsValidIndexField(Dataset: TDataSet; FieldName: string; CaseSensitive: boolean): boolean; overload;
function wwDataSetIsCaseSensitiveIndex(Dataset: TDataSet): boolean;
function wwGetIndexFieldCount(dataset: TDataSet): integer;
Function wwGetSearchIndex(DataSet: TDataSet; SearchField: string): integer;
Function wwGetIndexFields(DataSet: TDataSet; Index: Integer): TField;
Procedure wwSetIndexName(DataSet: TDataSet; val: string);
function wwGetIndexForFields(dataset: TDataSet; const Fields: string;
  CaseInsensitive: Boolean; ascending: boolean=true): TIndexDef;

Function wwGetLookupTables(dataSet: TDataSet): TList;
function wwDataSetIsDescendingIndex(Dataset: TDataSet): boolean;
procedure wwDataSetSort(DataSet: TDataSet; FieldName: string; descending: boolean; createIndexes: boolean);
function wwIsCustomStyle(control: TControl): boolean;
procedure wwPaintActiveGridCellBackgroundColor(Control: TControl; Canvas: TCanvas); overload;
procedure wwPaintActiveGridCellBackgroundColor(Control: TControl; Canvas: TCanvas; PaintRect: TRect); overload;
procedure wwPaintFixedGridCellBackgroundColor(Control: TControl; Canvas: TCanvas; PaintRect: TRect);
procedure wwPaintGridCellBackgroundColor(Control: TControl; Canvas: TCanvas; PaintRect: TRect);
function wwSize(cx, cy: Integer): TSize;
procedure wwAdjustFlag(Condition: Boolean; var Flag: UINT; FlagVal: UINT);
function wwStripAmpersands(Value: string): string;
function wwMultiLineTextSize(Canvas: TCanvas; Text: string; LineSpacing: Integer;
  MaxWidth: Integer; DrawFlags: Integer): TSize;

function wwThisThat(const Clause: Boolean; TrueVal, FalseVal: Integer): Integer;
function wwCountTokens(s, Delimiter: string): integer;
function wwLineHeight(Canvas: TCanvas; Flags: Integer; MaxWidth: Integer; Line: string): Integer;
procedure wwColorToByteValues(AColor: TColor; var Reserved, Blue, Green, Red: Byte);
procedure wwCalcButtonLayout(TopLeft: TPoint; TextRect, GlyphRect: PRect;
  TextSize, GlyphSize: TSize; Layout: TButtonLayout;
  Spacing: Integer);
procedure wwCreateDisabledBitmap(SrcBm, DstBm: TBitmap);
procedure wwImageListDraw(ImageList: TCustomImageList; Index: Integer; Canvas: TCanvas;
  X, Y: Integer; Style: Cardinal; Enabled: Boolean);
procedure wwImageListDrawFixBug(ImageList: TCustomImageList; Index: Integer; Canvas: TCanvas;
  X, Y: Integer; Style: Cardinal; Enabled: Boolean);
function wwModifyColor(Color: TColor; Amount: Integer; Percent: Boolean): TColor;
function wwGetCursorPos: TPoint;
function wwGetDitherBrush: HBRUSH;
procedure wwParentInvalidate(Control: TControl; Erase: Boolean);
procedure wwInvalidateOverlappedWindows(ParentHwnd: HWND; FirstChild: HWND);
procedure wwInvalidateChildren(Control: HWND);
function wwRegionFromBitmap(ABitmap: TwwBitmap; TransColor: TColor): HRgn;
function wwIsClientCursor(DataSet: TDataSet): boolean;

var IPUseOldGetIndexDefs: boolean = false;
{
function wwInternalOperationObject(
   Ctrl: TComponent;
   AOperation: string;
   AObject: TObject): Variant; overload; //; var AResult: Variant);
function wwInternalOperation(
   Ctrl: TComponent;
   AOperation: string;
   AValue: Variant): Variant; overload;
function wwInternalOperation(
   Ctrl: TComponent;
   AOperation: string;
   AValue1: Variant;
   AValue2: Variant): Variant; overload;

}
implementation

uses wwsystem, Messages, wwpict, wwintl, typinfo,
{$ifdef wwDelphi6Up}
fmtbcd, variants,
{$endif}
{$ifdef ThemeManager}
thememgr, themesrv, uxtheme,
{$endif}
     wwriched, rtti,
     wwdbedit;


var inLookupCalcLink : boolean;   {Internal Use Only}
   wwComCtlVersion: Integer;

{ 5/12/97 - Use generic way to retrieve propery }
Function wwGetOnInvalidValue(DataSet: TDataSet): TwwInvalidValueEvent;
var PropInfo: PPropInfo;
    method: TMethod;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'OnInvalidValue');
   if PropInfo<>Nil then begin
      method:= GetMethodProp(DataSet, PropInfo);
      if method.code<>Nil then
         result:= TwwInvalidValueEvent(method);
   end
end;

Function wwGetOnPerformCustomSearch(Component: TComponent): TwwPerformSearchEvent;
var PropInfo: PPropInfo;
    method: TMethod;
begin
   result:= nil;
   PropInfo:= Typinfo.GetPropInfo(Component.ClassInfo,'OnPerformCustomSearch');
   if PropInfo<>Nil then begin
      method:= GetMethodProp(Component, PropInfo);
      if method.code<>Nil then
         result:= TwwPerformSearchEvent(method);
   end
end;

{ 5/12/97 - Use generic way to retrieve propery }
Function wwGetCalcCellColorsEvent(Grid: TWinControl): TMethod;
var PropInfo: PPropInfo;
    method: TMethod;
begin
   method.code:= nil;
   method.Data:= nil;
   PropInfo:= Typinfo.GetPropInfo(Grid.ClassInfo,'OnCalcCellColors');
   if PropInfo<>Nil then begin
      method:= GetMethodProp(Grid, PropInfo);
      result:= method;
   end
end;

Function wwGetPictureControl(Control: TComponent; DataSet: TDataSet = nil): TComponent;
var ds: TDataSource;
begin
   if dataset=nil then
   begin
     ds:= wwGetControlDataSource(Control);
     if ds<>nil then dataset:= ds.dataset
     else dataset:= nil;
   end;

   if wwGetPictureMaskFromDataSet(Control) and (wwGetPictureMasks(Dataset)<>nil) then
      Result:= Dataset
   else Result:= Control;
end;

Function wwGetControlTypeControl(Control: TComponent; DataSet: TDataSet = nil): TComponent;
var ds: TDataSource;
begin
   if dataset=nil then
   begin
     ds:= wwGetControlDataSource(Control);
     if ds<>nil then dataset:= ds.dataset
     else dataset:= nil;
   end;

   if wwGetControlInfoInDataSet(Control) and (wwGetControlType(Dataset)<>nil) then
      Result:= Dataset
   else Result:= Control;
end;

Function wwGetStrings(Component: TComponent; PropertyName: string): TStrings;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   if Component=nil then exit;

   PropInfo:= Typinfo.GetPropInfo(Component.ClassInfo, PropertyName);
   if PropInfo<>Nil then
      result:= TStrings(GetOrdProp(Component, PropInfo));
end;

Function wwGetPictureMasks(DataSet: TComponent): TStrings;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   if DataSet=nil then exit;

   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'PictureMasks');
   if PropInfo<>Nil then
      result:= TStrings(GetOrdProp(DataSet, PropInfo));
end;

Function wwGetRegexMasks(DataSet: TComponent): TStrings;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   if DataSet=nil then exit;

   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'RegexMasks');
   if PropInfo<>Nil then
      result:= TStrings(GetOrdProp(DataSet, PropInfo));
end;

Function wwGetControlType(DataSet: TComponent): TStrings;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   if DataSet=nil then exit;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'ControlType'); { Delphi 5}
   if PropInfo<>Nil then
      result:= TStrings(GetOrdProp(DataSet, PropInfo));
end;

function wwGetCommandType(DataSet: TDataSet): integer;
var PropInfo: PPropInfo;
begin
   Result:= 0;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'CommandType');
   if (PropInfo<>Nil) then begin
      result:= GetOrdProp(DataSet, PropInfo);
   end
end;

function wwGetDatabaseCursorType(DataSet: TDataSet): integer;
var PropInfo: PPropInfo;
begin
   Result:= 0;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'CursorLocation');
   if (PropInfo<>Nil) then begin
      result:= GetOrdProp(DataSet, PropInfo);
   end
end;

Function wwSetDatabaseCursorType(DataSet: TDataSet; val: integer): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'CursorLocation');
   if (PropInfo<>Nil) then begin
      SetOrdProp(DataSet, PropInfo, ord(val));
      result:= True;
   end
end;

Function wwSetDatabaseMaxRecords(DataSet: TDataSet; val: integer): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropINfo(DataSet.ClassInfo,'MaxRecords');
   if (PropInfo<>Nil) then begin
      SetOrdProp(DataSet, PropInfo, ord(val));
      result:= True;
   end
end;

Function wwGetValidateWithMask(dataSet: TDataSet): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'ValidateWithMask');
   if PropInfo<>Nil then
      result:= Boolean(GetOrdProp(DataSet, PropInfo));
end;

Function wwGetControlInfoInDataSet(component: TComponent): boolean;
var PropInfo: PPropInfo;
begin
   Result:= True;
   PropInfo:= Typinfo.GetPropInfo(component.ClassInfo,'ControlInfoInDataSet');
   if PropInfo<>Nil then
      result:= Boolean(GetOrdProp(component, PropInfo));
end;

Function wwGetPictureMaskFromDataSet(component: TComponent): boolean;
var PropInfo: PPropInfo;
begin
   Result:= True;
   PropInfo:= Typinfo.GetPropInfo(component.ClassInfo,'PictureMaskFromDataSet');
   if PropInfo<>Nil then
      result:= Boolean(GetOrdProp(component, PropInfo));
end;

Function wwGetLookupFields(dataSet: TDataSet): TStrings;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'LookupFields');
   if PropInfo<>Nil then
      result:= TStrings(GetOrdProp(DataSet, PropInfo));
end;

Function wwGetLookupLinks(dataSet: TDataSet): TStrings;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'LookupLinks');
   if PropInfo<>Nil then
      result:= TStrings(GetOrdProp(DataSet, PropInfo));
end;

Function IsTruewwDataSet(dataset: TDataset): boolean;
begin
  if wwIsClass(dataset, 'TwwTable') then result:= true
  else if wwIsClass(dataset, 'TwwQuery') then result:= true
  else if wwIsClass(dataset, 'TwwQBE') then result:= true
  else if wwIsClass(dataset, 'TwwStoreProc') then result:= true
  else result:=false;
end;

Function wwGetLookupTables(dataSet: TDataSet): TList;
{var PropInfo: PPropInfo;}
begin
   if IsTruewwDataSet(dataset) then
     result:= TList(wwGetVariableObject(dataset, 'LookupTables', null))
//   if dataSet is TwwTable then result:= TwwTable(dataSet).LookupTables
//   else if dataSet is TwwQuery then result:= TwwQuery(dataSet).LookupTables
//   else if dataSet is TwwQBE then result:= TwwQBE(dataSet).LookupTables
//   else if dataSet is TwwStoredProc then result:= TwwStoredProc(dataSet).LookupTables
   else result:= nil
end;

Function wwGetFilterFieldValue(method: TMethod;AFieldName:string): TParam;
begin
   result:= TwwFilterFieldMethod(Method)(AFieldName);
end;

Function wwDataSetGetLinks(dataSet: TDataSet; lookupFieldName: string): string;
var parts: TStrings;
    i: integer;
    FLookupFields, FLookupLinks: TStrings;
begin
   result:= '';
   if wwGetLookupLinks(dataSet)=Nil then exit;

   parts:= TStringList.create;
   FLookupFields:= wwGetLookupFields(dataSet);
   FLookupLinks:= wwGetLookupLinks(dataSet);

   try
      for i:= 0 to FLookupfields.count-1 do begin
         strBreakApart(FLookupFields.Strings[i], ';', parts);
         if (parts[0]= lookupfieldName) then begin
            result:= FlookupLinks.strings[i];
            break;
         end
      end;
      parts.free;
   except
      parts.free;
   end
end;

Function wwDataSetGetDisplayField(dataSet: TDataSet; lookupFieldName: string): string;
var parts: TStrings;
    i: integer;
    FLookupFields: TStrings;
begin
   result:= '';
   if wwGetLookupFields(dataSet)=Nil then exit;

   parts:= TStringList.create;
   FLookupFields:= wwGetLookupFields(dataSet);

   try
      for i:= 0 to FLookupfields.count-1 do begin
         strBreakApart(FLookupFields.Strings[i], ';', parts);
         if (parts[0]= lookupfieldName) then begin
            result:= parts[3];
            break;
         end
      end;
   finally
      parts.free;
   end
end;

Function wwGetDatabaseName(dataSet: TDataSet): String;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'DatabaseName');
   if PropInfo<>Nil then
      result:= GetStrProp(DataSet, PropInfo);
end;

Function wwGetConnection(dataSet: TDataSet): TComponent;
var PropInfo: PPropInfo;
begin
   Result:= nil;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'Connection');
   if PropInfo<>Nil then begin
      result:= TComponent(GetOrdProp(dataset, PropInfo));
   end
end;

Function wwHaveDatabase(dataSet: TDataSet): boolean;
var PropInfo: PPropInfo;
begin
   Result:= false;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'Database');
   if PropInfo<>Nil then begin
      result:= true;
   end
end;

{
Function wwIsSQLBased(dataSet: TDataSet): boolean;
var PropInfo: PPropInfo;
    component: TComponent;
begin
   Result:= false;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'Database');
   if PropInfo<>Nil then begin
      component:= TComponent(GetOrdProp(dataset, PropInfo));

   end
end;
}

Function wwGetConnectionString(dataSet: TDataSet): String;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'ConnectionString');
   if PropInfo<>Nil then
      result:= GetStrProp(DataSet, PropInfo);
end;

Function wwGetIBDatabase(dataSet: TDataSet): TComponent;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(dataset.ClassInfo,'DataBase');
   if PropInfo<>Nil then begin
      result:= TComponent(GetOrdProp(dataset, PropInfo));
   end
end;

Function wwSetIBDatabase(Dataset: TDataSet; db: TComponent): boolean;
var PropInfo: PPropInfo;
begin
   result:= False;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'Database');
   if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
   begin
       SetOrdProp(Dataset,PropInfo,LongInt(db));
       result:= True;
   end;
end;

Function wwGetAlwaysTransparent(ctrl:  TControl): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo, 'AlwaysTransparent');
   if PropInfo<>Nil then
   begin
      result:= Boolean(GetOrdProp(ctrl, PropInfo));
      exit;
   end;

   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo, 'Transparent');
   if PropInfo<>Nil then begin
      result:= Boolean(GetOrdProp(ctrl, PropInfo));
      exit;
   end
end;

Function wwGetTableName(dataSet: TDataSet): String;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'TableName');
   if PropInfo<>Nil then
      result:= GetStrProp(DataSet, PropInfo);
//   if dataSet is TwwTable then result:= TwwTable(dataSet).tableName
//   else result:= '?';
end;

Function wwDataSetIsValidField(dataset : TComponent; fieldName : string): boolean;
var i: integer;
begin
   result:= False;
   if not (dataset is TDataset) then exit;
   if dataSet=Nil then exit;

   with TDataSet(dataset) do begin
      for i:= 0 to fieldCount-1 do begin
         if (uppercase(fieldName) = uppercase(fields[i].fieldName)) then begin
            result:= true;
            break;
         end;
      end
   end
end;


procedure wwDataSetUpdateFieldProperties(dataSet: TDataSet; selected: TStrings);
var i: integer;
    parts: TStrings;
begin
   parts := TStringList.create;

   dataSet.disableControls; {5/27/95}

   for i:= 0 to dataSet.fieldCount-1 do begin
      dataSet.fields[i].visible:= False;
   end;
   if selected<>Nil then begin
      for i:= 0 to selected.count-1 do begin
         strBreakApart(selected[i], #9, parts);
         if wwDataSetIsValidfield(dataSet, parts[0]) then begin
            dataSet.fieldByName(parts[0]).displayWidth:= strtoint(parts[1]);
            dataSet.fieldByName(parts[0]).displayLabel:= parts[2];
            dataSet.fieldByName(parts[0]).index:= i;
            dataSet.fieldByName(parts[0]).visible:= True;
         end;
      end;
   end;

   dataSet.enableControls; {5/27/95}

   parts.Free;
end;

Function wwDataSet(dataSet : TDataSet): boolean;
begin
   if dataset=nil then result:= false
   else begin
     result:= True;
   end;

end;

Procedure wwDebug(s: string);
begin
   MessageDlg(s, mtinformation, [mbok], 0);
end;

{ Win95 for Bitmap support }
procedure GetLookupFields(curField: Tfield;
   var databasename, tableName, displayFieldName: string;
   var joins: string);
var found: boolean;
    i: integer;
    parts: TStrings;
    gridTable: TDataSet;
begin
      found:= false;
      gridTable:= curField.dataset;
      if gridTable=nil then exit;

      parts:= TStringList.create;

      with wwGetLookupFields(gridTable) do begin
         for i:= 0 to count-1 do begin
            strBreakApart(strings[i], ';', parts);
            if parts[0]=curField.fieldName then begin
               if parts.count<5 then continue;

               found:=True;
               databaseName:= parts[1];
               tableName:= parts[2];
               displayFieldName:= parts[3];

               joins:= wwGetLookupLinks(gridTable).Strings[i];
               break;
            end
         end
      end;

      if not found then begin
         databaseName:= wwGetDatabaseName(gridTable);
         tableName:= '';
         displayFieldName:= '';
         joins:= '';
      end;

      parts.free;

end;

Function wwFindKey(dataset: TDataset;
  const KeyValues: array of Const): Boolean;
begin
   result:= wwGetVariableWithParams2(dataset, 'wwFindKey', KeyValues, [])
end;

{ Win95 for Bitmap support }
Function wwDataSetLookupDisplayField(
   curField: TField; var LookupValue: string; var DisplayField: TField): boolean;
var
    j, APos: integer;
    lookupTable: TDataset;
    databasename, tableName, displayFieldName, joins: string;
    lookupTables: TList;
begin
    displayField:= curField;
    result:= False;
    if (curField=Nil) or (curField.dataSet=nil) then exit;
    if (wwGetLookupTables(curField.dataset)=nil) then exit;

    GetLookupFields(curField, databasename, tableName, displayFieldName, joins);
    LookupTables:= wwGetLookupTables(curField.dataset);

    for j:= 0 to LookupTables.count-1 do begin
       lookupTable:= TDataset(lookupTables.items[j]);
       if (wwGetDatabaseName(lookupTable)=databaseName) and
          (wwGetTableName(lookupTable)=tableName) then
//
//       if (lookupTable.databaseName=databaseName) and
//          (lookupTable.tableName=tableName) then
       begin
          if (lowercase(joins)=lowercase(wwGetVariable(lookupTable, 'CalcLookupLinks'))) then
          begin
             DisplayField:= lookupTable.FieldByname(DisplayFieldName);
             APos:= 1;
             LookupValue:= curField.dataset.FieldByName(strGetToken(joins, ';', APos)).asString;
             result:= wwFindKey(lookupTable, [lookupValue]);
             exit;
          end
       end
    end;

end;

function wwTableFindRecord(
   LookupTable: TDataset;
   KeyValue: string;
   LookupField: string;
   MatchType: TwwLocateMatchType;
   caseSensitive: boolean): boolean;
type
   TFindRecordFunction =
     function (
        KeyValue: string;
        LookupField: string;
        MatchType: TwwLocateMatchType;
        CaseSensitive: boolean): boolean of object;
var
    MethodFindRecord: TMethod;
begin
   TMethod(MethodFindRecord).Data := LookupTable; // object reference
   TMethod(MethodFindRecord).Code := LookupTable.MethodAddress('wwFindRecord');
   result:= TFindRecordFunction(MethodFindRecord)(KeyValue, LookupField, MatchType, caseSensitive)
end;


Function wwDoLookupTable(ALookupTable : TDataset;  DataSet: TDataset; links: TStrings) : boolean;
var res: boolean;
    lookupTable: TDataset;
begin
   res:= False;
   lookupTable:= AlookupTable;
   with DataSet do begin
      if wwGetVariable(LookupTable, 'IndexFieldCount')=0 then begin
         result:= wwTableFindRecord(LookupTable, FieldByName(links[0]).asString, links[1],
                            mtExactMatch, False);
         exit;
      end;

      case (links.count) of
         2:  res:= wwFindKey(LookupTable,
                [FieldByName(links[0]).asString]);

         4:  res:= wwFindKey(lookupTable,
                      [FieldByName(links[0]).asString,
                       FieldByName(links[2]).asString] );

         6:  res:= wwFindKey(lookupTable,
                      [FieldByName(links[0]).asString,
                       FieldByName(links[2]).asString,
                       FieldByName(links[4]).asString] );

         8:  res:= wwFindKey(lookupTable,
                      [FieldByName(links[0]).asString,
                       FieldByName(links[2]).asString,
                       FieldByName(links[4]).asString,
                       FieldByName(links[6]).asString] );

        10:  res:= wwFindKey(lookupTable,
                      [FieldByName(links[0]).asString,
                       FieldByName(links[2]).asString,
                       FieldByName(links[4]).asString,
                       FieldByName(links[6]).asstring,
                       FieldByName(links[8]).asString] );

        12:  res:= wwFindKey(lookupTable,
                      [FieldByName(links[0]).asString,
                       FieldByName(links[2]).asString,
                       FieldByName(links[4]).asString,
                       FieldByName(links[6]).asstring,
                       FieldByName(links[8]).asstring,
                       FieldByName(links[10]).asString] );
         else;
      end;
   end;

   result:= res;
end;

Function wwisNonBDEField(thisField: TField): boolean;
begin
   result:=  thisfield.calculated or thisfield.lookup;
   {$ifdef wwDelphi3Up}
   if (not result) and (thisField.dataset<>nil) then
      result:= not wwIsClass(thisField.dataset.classType, 'TBDEDataSet'); {9/20/97 - 3rd party engine}
   {$endif}
end;

Function wwisNonPhysicalField(thisField: TField): boolean;
begin
   result:=  thisfield.calculated or thisfield.lookup;
end;

(*
Procedure wwConvertFieldToParam(OtherField:TField;var AFilterParam:TParam;AFilterFieldBuffer: PAnsiChar);
var
   tempInt: integer;
   tempdouble: double;
   tempSmallInt: smallint;
   tempTimeStamp: TTimeStamp;
   tempWordBool: WordBool;
begin
   if OtherField=nil then // 11/7/98 - If nil (i.e. ClientDataSet), then return blank
   begin
      strPLCopy(AFilterFieldBuffer, '', 32767);
      AFilterParam.SetData(AFilterFieldBuffer);
      exit;
   end;

   case OtherField.DataType of
      ftString, ftMemo: // 11/3/97 - Treat ftMemo as ftString
        begin
          {$Warnings off}
          strPLCopy(AFilterFieldBuffer, OtherField.asString, 32767);
          AFilterParam.SetData(AFilterFieldBuffer);
          {$Warnings on}
        end;
      ftSmallint,ftWord:
        begin
          tempSmallInt:= OtherField.asInteger;
          move(tempSmallInt, AFilterFieldBuffer^, 2);
          AFilterParam.SetData(AFilterFieldBuffer);
        end;
      ftInteger, ftAutoInc:
        begin
          tempInt:= OtherField.asInteger;
          move(tempInt, AFilterFieldBuffer^, 4);
          AFilterParam.SetData(AFilterFieldBuffer);
        end;

      {$ifdef wwDelphi2011Up}
      TFieldType.ftSingle,
      {$endif}
      ftFloat,ftCurrency:
        begin
          tempDouble:= OtherField.asFloat;
          move(tempDouble, AFilterFieldBuffer^, 8);
          AFilterParam.SetData(AFilterFieldBuffer);
        end;
      ftBoolean:
        begin
          tempWordBool:= OtherField.asBoolean;
          move(tempWordBool, AFilterFieldBuffer^, 2); // 9/16/98 - WordBool is 2 bytes
          AFilterParam.SetData(AFilterFieldBuffer);
        end;
      ftTime:
        begin
           tempTimeStamp:= DateTimeToTimeStamp(OtherField.asDateTime);
           move(tempTimeStamp.time, AFilterFieldBuffer^, 4);
           AFilterParam.SetData(AFilterFieldBuffer);
        end;
      ftDate:
        begin
           tempTimeStamp:= DateTimeToTimeStamp(OtherField.asDateTime);
           move(tempTimeStamp.date, AFilterFieldBuffer^, 4);
           AFilterParam.SetData(AFilterFieldBuffer);
        end;

      ftTimeStamp,
      ftDateTime:
        begin
           tempDouble:= TimeStampToMSecs(DateTimeToTimeStamp(OtherField.asDateTime));
           move(tempDouble, AFilterFieldBuffer^, sizeof(double));
           AFilterParam.SetData(AFilterFieldBuffer);
        end;
     ftFMTBCD:
        begin
           CurrToBCD((OtherField as TFMTBCDField).asFloat,
                     pBcd(AFilterFieldBuffer)^, 32, 4);
           AFilterParam.SetData(AFilterFieldBuffer);
        end;
     ftBCD: // 11/21/99 - Support BCD
        begin
           CurrToBCD((OtherField as TBCDField).asFloat,
                     pBcd(AFilterFieldBuffer)^, 32, 4);
           AFilterParam.SetData(AFilterFieldBuffer);
        end;
   end;
end;
*)

Function ignoreExtension(parts: TStrings): boolean;
begin
   if parts.count>5 then begin
      result:= (parts[parts.count-1]='N');
   end
   else result:= False;
end;

Function getTablePrefix(tableName: string): string;
var APos: integer;
begin
   APos:= 1;
   result:= strGetToken(tableName, '.', APos);
end;

Function isSameTable(lookupTable: TDataset; parts: TStrings): boolean;
begin
   if ignoreExtension(parts) then
   begin
      result:=
           (wwGetDatabaseName(lookupTable)=parts[1]) and
           (wwGetTableName(lookupTable)=GetTablePrefix(parts[2]))
//         (lookupTable.databaseName=parts[1]) and
//         (lookupTable.tableName=GetTablePrefix(parts[2]));
   end
   else begin
      result:=
           (wwGetDatabaseName(lookupTable)=parts[1]) and
           (wwGetTableName(lookupTable)=parts[2])
   end
end;

    Function SyncLookupTable(DataSet:TDataset;Alookuptable: TDataSet;links:TStrings;
       Method: TMethod): boolean;
    var res:boolean;
        lookupTable:TDataset;
    begin
       res := False;
       if not (wwIsClass(Alookuptable, 'TwwTable')) then begin
         { Only 1 field lookups for non TwwTables }
         if Method.data=nil then { 11/7/98 - ClientDataSet lookups pass method.data=nil}
         begin
            // 7/4/02 - If isnull then use .Value, as .AsString can lead
            // to run-time exception
            if dataset.fieldbyname(links[0]).isNull then
            begin
              result:= ALookupTable.Locate(links[1],
                     DataSet.FieldByName(links[0]).Value, [])
            end
            else
              result:= ALookupTable.Locate(links[1],
                     DataSet.FieldByName(links[0]).asString, [])
         end
         else begin
            // 6/23/03 - Check for null lookup value
            if dataset.fieldbyname(links[0]).isNull then
            begin
              result:= ALookupTable.Locate(links[1],
                    wwGetFilterFieldValue(method, links[0]).Value, []);
            end
            else
              result:= ALookupTable.Locate(links[1],
                    wwGetFilterFieldValue(method, links[0]).asString, []);
         end;
         exit;
       end;

       lookupTable := Alookuptable;
       case (links.count) of
         2: begin
            res := wwFindKey(lookupTable,
              [(wwGetFilterFieldValue(method, links[0])).asString]);
            end;
         4: begin
            res := wwFindKey(lookupTable,
                  [wwGetFilterFieldValue(Method,links[0]).asString,
                   wwGetFilterFieldValue(Method,links[2]).asString]);
            end;
         6: begin
            res := wwFindKey(lookupTable,
                      [wwGetFilterFieldValue(method,links[0]).asString,
                       wwGetFilterFieldValue(method,links[2]).asString,
                       wwGetFilterFieldValue(method,links[4]).asString] );
            end;
         8: begin
            res := wwFindKey(lookupTable,
                      [wwGetFilterFieldValue(method,links[0]).asString,
                       wwGetFilterFieldValue(method,links[2]).asString,
                       wwGetFilterFieldValue(method,links[4]).asString,
                       wwGetFilterFieldValue(method,links[6]).asString] );
            end;
        10: begin
            res := wwFindKey(lookupTable,
                      [wwGetFilterFieldValue(method,links[0]).asString,
                       wwGetFilterFieldValue(method,links[2]).asString,
                       wwGetFilterFieldValue(method,links[4]).asString,
                       wwGetFilterFieldValue(method,links[6]).asString,
                       wwGetFilterFieldValue(method,links[8]).asString] );
            end;
        12: begin
            res := wwFindKey(lookupTable,
                      [wwGetFilterFieldValue(method,links[0]).asString,
                       wwGetFilterFieldValue(method,links[2]).asString,
                       wwGetFilterFieldValue(method,links[4]).asString,
                       wwGetFilterFieldValue(method,links[6]).asString,
                       wwGetFilterFieldValue(method,links[8]).asString,
                       wwGetFilterFieldValue(method,links[10]).asString] );
            end;
         else;
      end;
      result := res;
    end;

Function wwDataSet_GetFilterLookupField(dataSet: TDataSet; curfield: TField; AMethod: TMethod): TField;
var OtherField : TField;
    links: TStrings;
    foundvalue: bool;
    foundtable: bool;
    lookuplinks:string;
    mylookuplinks:Tstrings;
    lookuptable:TDataset;
    lookupfields:Tstrings;
    lookuptables:TList;

    parts: TStrings;
    i,j:integer;

    fromLinks, toLinks, fromlink, tolink: string;
    fpos, tpos: integer;

begin
   otherfield := nil;

   if (not curfield.calculated) then begin   {Check LookupField value}
      links:= TStringlist.create;

      fromLinks:= curField.KeyFields;
      toLinks:= curField.LookupKeyFields;
      fpos:= 1; tpos:= 1;

      while True do begin
         fromLink:= strGetToken(fromlinks, ';', fpos);
         toLink:= strGetToken(tolinks, ';', tpos);

         if (fromLink='') or (toLink='') then break;

         links.add(fromLink );
         links.add(toLink);

      end;

      foundvalue := SyncLookupTable(Dataset,curfield.lookupdataset,links, AMethod);

      if foundvalue then
         otherfield := curfield.lookupdataset.fieldbyname(curfield.lookupresultfield);
   end
   else begin   {Check Linked field value}

     if (inLookupCalcLink) or (wwGetLookupTables(curField.dataset)=nil) then begin
        result := nil;
        exit;
     end;

     links:= TStringlist.create;
     lookuplinks := wwDataSetGetLinks(Dataset,curfield.fieldname);
     strBreakApart(lookuplinks, ';', links);

     lookuptable := nil;
     foundTable := false;

     lookupfields := wwGetLookupFields(Dataset);
     lookuptables := wwGetLookupTables(Dataset);
     mylookuplinks := wwGetLookupLinks(Dataset);
     parts:= TStringList.create;

     for i:= 0 to lookupfields.count-1 do begin
        strbreakApart(lookupfields.Strings[i], ';', parts);
        if wwEqualStr(parts[0],curField.FieldName) then begin {7/24/97 - Check field }
           for j:= 0 to lookuptables.count-1 do begin
              lookupTable:= TDataset(lookuptables.items[j]);
              if isSameTable(lookuptable, parts) then
              begin
                 foundtable:= (lowercase(mylookuplinks.strings[i])=
                               lowercase(wwGetVariable(lookupTable, 'CalcLookupLinks')));
                 if foundtable then break;
              end
           end;
           if foundtable then break;
        end
     end;

     if foundtable then begin

        inLookupCalcLink := true;
        foundvalue := SyncLookupTable(Dataset,lookuptable,links, AMethod);
        inLookupCalcLink := false;

        if foundvalue then
           otherfield := lookuptable.fieldbyname(wwDataSetGetDisplayField(Dataset,curfield.fieldname));
     end;

     parts.free;

   end;

   links.free;

   result := otherfield;

end;


procedure wwDataSetDoOnCalcFields(dataSet: TDataSet;
          FLookupFields, FLookupLinks: TStrings;
          lookupTables: TList);
var links, parts: TStrings;
    i,j: integer;
    fieldName: wwSmallString;
    indexFields: string;
    foundTable: Boolean;
    lookupTable: TDataset;
    res: boolean;

    Function getTablePrefix(tableName: string): string;
    var APos: integer;
    begin
       APos:= 1;
       result:= strGetToken(tableName, '.', APos);
    end;

    Function ignoreExtension(parts: TStrings): boolean;
    begin
       if parts.count>5 then begin
          result:= (parts[parts.count-1]='N');
       end
       else result:= False;
    end;
{
    Function isSameTable(lookupTable: TDataset; parts: TStrings): boolean;
    begin
       if ignoreExtension(parts) then
       begin
          result:=
             (lookupTable.databaseName=parts[1]) and
             (lookupTable.tableName=GetTablePrefix(parts[2]));
       end
       else begin
          result:=
             (lookupTable.databaseName=parts[1]) and
             (lookupTable.tableName=parts[2]);
       end
    end;
 }
begin
    parts:= TStringList.create;
    links:= TStringList.create;
    lookupTable:= nil; { Make compiler happy}

    { upToDate keeps track if lookuptable needs to do a findKey }
    for i:= 0 to LookupTables.count-1 do begin
        lookupTable:= TDataset(lookupTables.items[i]);
        wwSetVariable(lookupTable, 'UpToDate', false);
//        lookuptable.upToDate:= False;
    end;

    for i:= 0 to FLookupfields.count-1 do begin
       strbreakApart(FLookupFields.Strings[i], ';', parts);

       { Find corresponding table }
       foundTable:= false;
       for j:= 0 to LookupTables.count-1 do begin
          lookupTable:= TDataset(lookupTables.items[j]);
          if isSameTable(lookupTable, parts) then
          begin
             foundTable:= (lowercase(FLookupLinks.strings[i])=
                           lowercase(wwGetVariable(lookupTable, 'CalcLookupLinks')));
             if foundTable then break;
          end
       end;

       { Table not found so create it }
       if not foundTable then begin
          lookupTable:= TDataSet(TComponentClass(FindClass('TwwTable')).create(dataset));
          //lookupTable:= TwwTable.create(dataSet);
          try { In case unable to open table }
             wwSetDatabaseName(lookupTable, parts[1]);
             //lookupTable.databaseName:= parts[1];
             if ignoreExtension(parts) then
                wwSetTableName(lookupTable, getTablePrefix(parts[2]))
                //lookupTable.tableName:= getTablePrefix(parts[2])
             else
                wwSetTableName(lookupTable, parts[2]);
//                lookupTable.tableName:= parts[2];

             if parts.count>5 then begin
                indexFields:= parts[5];
                for j:= 6 to parts.count-2 do indexFields:= indexFields + ';' + parts[j];
                wwSetVariable(lookupTable, 'indexName', wwGetVariableWithParams(lookupTable, 'FieldsToIndex', indexFields));
                //lookupTable.indexName:= lookupTable.FieldsToIndex(indexFields);
             end
             else
                wwSetVariable(lookupTable, 'indexName', parts[4]);
//                lookupTable.indexName:= parts[4];  { Set index name}

             wwSetReadOnly(lookupTable, true); // Don't require write access }
             lookupTable.active:= True;
          except
             continue;  { Skip this lookup since table not found }
          end;
          lookupTables.add(lookupTable);
          wwSetVariable(lookupTable, 'upToDate',  False);
          wwSetVariable(lookupTable, 'CalcLookupLinks', FLookupLinks.strings[i]);
          //lookupTable.CalcLookupLinks:= FLookupLinks.strings[i];
       end
       else if not lookupTable.active then
          lookupTable.active:= True;  { Force table to be active }

       fieldName:= parts[3];
       strBreakApart(FLookupLinks[i], ';', links);

       { Master Link field is gone, hide dependent field }
       for j:= 0 to ((links.count-1) div 2) do begin
           if not wwDataSetIsValidfield(dataSet, links[j*2]) then begin
              dataset.fieldByName(parts[0]).visible:= False;
              parts.free;
              links.free;
              exit;
           end
       end;

       res:= False;

       with DataSet do begin
          if not wwGetVariable(LookupTable, 'UpToDate') then begin
             wwSetVariable(LookupTable, 'inLookupLink', True);
             res:= wwDoLookupTable(lookupTable, DataSet, links);
             wwSetVariable(LookupTable, 'inLookupLink', False);
             wwSetVariable(LookupTable, 'uptodateRes', res);

//             LookupTable.upToDateRes:= res;
          end;

          if (res or (wwGetVariable(LookupTable, 'upToDate') and
                      wwGetVariable(LookupTable, 'upToDateRes'))) then
          begin
             { Support linked memo field display}
             if LookupTable.FieldByName(fieldName) is TBlobField then
                fieldbyName(parts[0]).text:= lookupTable.fieldByName(fieldName).asString
             else
                fieldbyName(parts[0]).text:= lookupTable.fieldByName(fieldName).text
          end
          else fieldbyName(parts[0]).text:= '';
       end;
       wwSetVariable(LookupTable, 'UpToDate', true);
//       LookupTable.upToDate:= True;

    end;
    parts.free;
    links.free;

 end;


    Function wwDataSetSyncLookupTable(dataSet: TDataSet; AlookupTable: TDataSet;
                  lookupFieldName: string; var fromField: string): boolean;
    var links, parts: TStrings;
        i,j, curpos: integer;
        lookupFields, controlType, lookupLinks: TStrings;
        lookupTable: TDataset;
        tempTblName1, tempTblName2: wwSmallString;
        indexFields: string;
    begin
       parts:= TStringList.create;
       links:= TStringList.create;

       lookupFields:= wwGetLookupFields(dataSet);
       controlType:= wwGetControlType(dataset);
       lookupLinks:= wwGetLookupLinks(dataset);
       lookupTable:= ALookupTable as TDataset;

       { Remove lookup fields that are no longer there }
       wwDataSetRemoveObsolete(dataSet, lookupfields, controlType, lookupLinks);
       result:= False;

       for i:= 0 to LookupFields.count-1 do begin
          strBreakApart(LookupFields.Strings[i], ';', parts);

          if (uppercase(parts[0])= uppercase(lookupfieldName)) then begin

             curpos:= 1;
             tempTblName1:= uppercase(strGetToken(wwGetTableName(lookupTable), '.', curpos));
             curpos:= 1;
             tempTblName2:= uppercase(strGetToken(parts[2], '.', curpos));
             if (tempTblName1=tempTblName2) then
             begin
                if parts.count>5 then begin
                   indexFields:= parts[5];
                   for j:= 6 to parts.count-2 do indexFields:= indexFields + ';' + parts[j];
                   wwSetVariable(lookupTable, 'IgnoreMasterLink', true);  { Just change index }
                   wwSetToIndexContainingField(lookupTable, indexFields);  {2/10/97}
                   wwSetVariable(lookupTable, 'IgnoreMasterLink', false);
{                   lookupTable.indexName:= lookupTable.FieldsToIndex(indexFields);}
                end
                else begin
                   if wwGetVariable(lookupTable, 'indexName')<>parts[4] then
                      wwSetVariable(lookupTable, 'indexName', parts[4]);
                end;
             end;

             strBreakApart(LookupLinks[i], ';', links);

             { Source Link field is gone, hide dependent field }
             for j:= 0 to ((links.count-1) div 2) do begin
                if not wwDataSetIsValidField(dataSet, links[j*2]) then begin
                   dataSet.fieldByName(parts[0]).visible:= False;
                   parts.free;
                   links.free;
                   exit;
                end
             end;

             with DataSet do
               result:= wwDoLookupTable(lookupTable, Dataset, links);

             fromField:= links[0];
             break;
          end
       end;
       parts.free;
       links.free;
    end;

(*
Function wwDataSetRemoveObsoleteControls(parentForm: TCustomForm; dataSet: TComponent): boolean;
var i: integer;
    parts: TStrings;
    ControlType: TStrings;
begin
   result:= True;
   exit;
   if parentForm=nil then exit;
   if not (csDesigning in parentForm.ComponentState) then exit; { only remove in design mode}

   parts:= TStringList.create;
   ControlType:= wwGetControlType(dataSet);
   i:= 0;
   if ControlType<>nil then while (i<=ControlType.count-1) do begin{ Delphi 5}
      strbreakApart(ControlType.Strings[i], ';', parts);
      if (parts.count<2) then begin
         i:= i + 1;
         continue;
      end;
      if isWWEditControl(parts[1]) then
      begin
         if pos('.', parts[2])>0 then begin
            if (length(StrTrailing(parts[2],'.'))>0) and
               (Dataset.owner.FindComponent(strTrailing(parts[2],'.'))=Nil) then
            begin
               ControlType.delete(i);
            end
            else inc(i)
         end
         else begin
            if (parentForm.FindComponent(parts[2])=Nil) then
            begin
               ControlType.delete(i);
            end
            else inc(i);
         end;
      end
      else i:= i+1;
   end;

   parts.free;

end;
*)
procedure wwDataSet_GetControl(dataSet: TComponent; AFieldName: string;
                      var AControlType: string; var AParameters: string);
var i: integer;
    ControlType: TStrings;
    APos: integer;
begin
   { 8/14/97 - Optimized logic to speed painting of grid }
   AControlType:= '';
   AParameters:= '';
   controlType:= wwGetControlType(dataset);
   if ControlType=nil then exit; { Delphi 5}
   for i:= 0 to ControlType.count-1 do begin
      APos:= 1;
      if strGetToken(controlType[i], ';', APos)<>AFieldName then continue;
      AControlType:= strGetToken(controlType[i], ';', APos);
      AParameters:= copy(controlType[i], APos, 255);
   end
end;

procedure wwDataSetRemoveObsolete(dataSet: TComponent; //DataSet;
          FLookupFields, FLookupLinks, FControlType: TStrings);
var i: integer;
    parts: Tstrings;
begin
   parts:= TStringList.create;
   i:= 0;
   if FLookupFields<>Nil then while (i<=FLookupfields.count-1) do begin
      strbreakApart(FLookupFields.Strings[i], ';', parts);
      if (not wwDataSetisValidField(dataSet, parts[0])) then begin
         FLookupFields.delete(i);
         FLookupLinks.delete(i);
      end
      else i:= i+1;
   end;

   i:= 0;
   if (FControlType<>nil) then { Delphi5}
     while (i<=FControlType.count-1) do begin
        strbreakApart(FControlType.Strings[i], ';', parts);
        if (not wwDataSetIsValidField(dataSet, parts[0])) then
        begin
           FControlType.delete(i);
        end
        else i:= i+1;
     end;

   parts.free;
end;

procedure wwDataSet_SetControl(dataSet: TComponent;
          AFieldName: string; AComponentType: string; AParameters: string);
var i: integer;
    parts: Tstrings;
    Found: boolean;
    ControlType: TStrings;
begin
   i:= 0;
   Found:= False;
   ControlType:= wwGetControlType(dataSet);
   parts:= TStringList.create;

   if ControlType<>nil then while (i<=ControlType.count-1) do begin { Delphi 5}
      strbreakApart(ControlType.Strings[i], ';', parts);
      if (lowercase(parts[0])=lowercase(AFieldName)) then begin
         if (lowercase(AComponentType)='field') or (lowercase(AComponentType)='') then
         begin
            ControlType.delete(i);  {Delete control}
            Found:= True;
            break;
         end
         else begin
            ControlType.Strings[i]:= parts[0] + ';' + AComponentType + ';' +
                 AParameters;
            Found:= True; {Update Control}
            break;
         end
      end;
      i:= i + 1;
   end;

   if (not found) and (ControlType<>nil) then begin { Delphi 5}
      ControlType.add(AFieldName + ';' + AComponentType + ';' + AParameters);
   end;

   parts.free;
end;

function wwFieldIsValidValue(fld: TField; key: string): boolean;
begin
   result:= wwIsValidValue(fld.dataType, key);
end;

Function wwFieldIsValidLocateValue(fld: TField; key: string):boolean;
begin
   result:= False;
   if Fld=Nil then exit;
   
   result:= wwFieldIsValidValue(fld, key);

   if (key='') and
   (fld.datatype in [ftCurrency, ftFloat, ftBCD, ftInteger, ftSmallInt, ftWord,

      {$ifdef wwDelphi2011Up}
      TFieldType.ftSingle,
      {$endif}

      {$ifdef wwDelphi6Up}
      ftTimeStamp, ftFMTBCD,
      {$endif}
                    ftAutoInc, ftTime, ftDate, ftDateTime]) then result:= False;
end;

Function wwIsValidValue(FldType: TFieldType; key: string):boolean;
begin
   result:= False;
   case FldType of
     {$ifdef wwDelphi6Up}
     ftFMTBCD,
     {$endif}

     {$ifdef wwDelphi2011Up}
     TFieldType.ftSingle,
     {$endif}

     ftCurrency, ftFloat, ftBCD : if not wwStrToFloat(key) then exit;
     ftinteger, ftSmallInt, ftWord : if not wwStrToInt(key) then exit;

     ftAutoInc : if not wwStrToInt(key) then exit;

     ftTime: if not wwStrToTime(key) then exit;  {3/6/97}
     ftDate : if not wwStrToDate(key) then exit;
     {$ifdef wwDelphi6Up}
     ftTimeStamp,
     {$endif}
     ftDateTime:
        if not wwStrToDateTime(key) then begin
           if not wwStrToDate(key) then exit;
        end;
     else;
   end;
   result:= True;
end;

Procedure wwIsValidValue2(FldType: TFieldType; key: string);
begin
   strStripTrailing(key, ' ');
   if (key='') then exit;

   case FldType of
     {$ifdef wwDelphi2011Up}
     TFieldType.ftSingle,
     {$endif}

     ftFMTBCD,
     ftCurrency, ftFloat, ftBCD : StrToFloat(key);
     ftinteger, ftSmallInt, ftWord : StrToInt(key);
     ftAutoInc : StrToInt(key);
     ftTime: StrToTime(key);
     ftDate : StrToDate(key);
     ftTimeStamp,
     ftDateTime:
        if not wwStrToDateTime(key) then begin
           StrToDate(key);
        end
     else;
   end;
end;

//type TCheatTable = class(TTable);

Function wwTableFindNearest(dataSet: TDataSet; key: string; FieldNo: integer): boolean;
var table: TDataSet; //Table;
    useNarrowSearch, syncSQLByRange: boolean;
    useTextSearch: boolean;
    UpperRangeString: string;
    i: integer;
    SkipLocate: boolean;
    LocateOptions: TLocateOptions;
    LocateValues: Variant;
    LocateFields: string;
    IndexDefs: TIndexDefs;
//    IndexField: TField;
    Params: variant;

   Function IsValueType(AFieldType: TFieldType): boolean;
   begin
      result:=
          (AFieldType in [ ftSmallInt, ftInteger, ftWord, ftFloat, ftCurrency]);
       if AFieldType=ftAutoInc then result:= True;
      {$ifdef wwDelphi2011Up}
       if AFieldType=TFieldType.ftSingle then result:= True;
      {$endif}
   end;

  Function GetIndexFieldName: string;
  begin
     result:= wwGetVariable(table, 'IndexFieldName');
  end;

   function IsCaseInsensitiveIndex: boolean;
   begin
//      result:= wwDataSetIsValidIndexField(Table, wwGetIndexFieldName(table), False);
      result:= not wwDataSetIsCaseSensitiveIndex(Table);

   end;

begin
   result:= False;
   if not wwIsClass(dataset, 'TTable') then exit;
   if wwIsClass(dataset, 'TwwTable') then begin
      useNarrowSearch:= wwGetVariable(dataset, 'NarrowSearch');//(dataset as TwwTable).NarrowSearch;
      syncSQLByRange:= wwGetVariable(dataset, 'SyncSQLByRange'); //(dataset as TwwTable).SyncSQLByRange;
   end
   else begin
      useNarrowSearch:= False;
      syncSQLByRange:= False;
   end;
   table:= dataSet as TDataSet; //TTable;

   if wwGetIndexFieldCount(table)=0 then begin
      MessageDlg('Table ' + dataset.name + ': Table index not found', mtWarning, [mbok], 0);
      exit;
   end;

   useTextSearch:= False;

   case wwGetIndexFields(table, FieldNo).dataType of
         {$ifdef wwDelphi6Up}
          ftFMTBCD,
         {$endif}
         {$ifdef wwDelphi2011Up}
          TFieldType.ftSingle,
         {$endif}
         ftCurrency, ftFloat, ftBCD : if not wwStrToFloat(key) then exit;

         ftinteger, ftSmallInt, ftWord : if not wwStrToInt(key) then exit;
         ftAutoInc : if not wwStrToInt(key) then exit;
         ftDate : if not wwStrToDate(key) then exit;
         ftTime: if not wwStrToTime(key) then exit;

         {$ifdef wwDelphi6Up}
         ftTimeStamp,
         {$endif}
         ftDateTime:
            if not wwStrToDateTime(key) then begin
               if not wwStrToDate(key) then exit;
            end;
            else useTextSearch:= True;
   end;

   with table do try

      if UseNarrowSearch then begin  { Search by narrowing down }
         Screen.cursor:= crHourGlass;
         DisableControls;
         if useTextSearch then begin
            if key='' then
               wwSetVariable(table, 'FastCancelRange', null)
//              (table as TwwTable).FastCancelRange  { 12/4/96 - Faster cancel range }
            else begin
              { MSSQL does not work with char(255) }
              UpperRangeString:= key;
//              for i:= 0 to indexfields[0].size-1 do
              for i:= 0 to wwGetIndexfields(table, 0).size-1-length(key) do { 2/24/98 - Subtrack length(key) }
                 UpperRangeString:= UpperRangeString +
                    char(Word(wwGetVariable(table, 'NarrowSearchUpperChar')));
//                 char((table as TwwTable).NarrowSearchUpperChar);

              { 10/16/97 - Skip descending test if using IndexFieldNames }
              wwGetIndexDefs(table, IndexDefs);
              if ((wwGetIndexName(table)<>'') or (wwGetIndexFieldNames(table)='')) and
                 (ixDescending in IndexDefs.Items[IndexDefs.indexof(wwGetIndexName(table))].Options) then
                  wwGetVariableWithParams2(table, 'SetRange', // 4/9/11 - Change datasource.dataset to table - causes access violation before
                        [UpperRangeString], [key])
                  //table.SetRange([UpperRangeString], [key])
              else
                  wwGetVariableWithParams2(table, 'SetRange',  // 4/9/11 - Change datasource.dataset to table - causes access violation before
                        [key], [UpperRangeString]);

                  //table.setRange([key],[UpperRangeString])
            end;
         end
         else begin
            if wwIsClass(table, 'TwwTable') then
              wwGetVariableWithParams2(table, 'wwSetRangeStart',  // 4/9/11 - Change datasource.dataset to table - causes access violation before
                               [key], [])
//            if table is TwwTable then
//               (table as TwwTable).wwSetRangeStart([key]);
         end;
         EnableControls;
         Screen.cursor:= crDefault;
      end
      { 11/6/96 - Don't use setRange if detail table }
      else if SyncSQLByRange and
           wwGetVariable(table, 'IsSQLBased') and (wwGetControlMasterSource(table)=nil) then
      begin
         Screen.cursor:= crHourGlass;
         DisableControls;

         if wwIsClass(table, 'TwwTable') then begin
            if key='' then begin
               wwSetVariable(table, 'FastCancelRange', null);
            end
            else begin
{              (table as TwwTable).wwSetRangeStart([key]);}
              case FieldNo of
                0: wwGetVariableWithParams2(table, 'wwSetRangeStart', [key], []);
                1: wwGetVariableWithParams2(table, 'wwSetRangeStart',
                   [wwGetIndexFields(table, 0).asString, key], []);
                2: wwGetVariableWithParams2(table, 'wwSetRangeStart',
                   [wwGetIndexFields(table, 0).asString, wwGetIndexFields(table, 1).asString, key], []);
                3: wwGetVariableWithParams2(table, 'wwSetRangeStart',
                   [wwGetIndexFields(table, 0).asString, wwGetIndexFields(table, 1).asString, wwGetIndexFields(table, 2).asString, key], []);
              end

            end
         end;

         EnableControls;
         Screen.cursor:= crDefault;

      end
      else if wwInternational.UseLocateMethodForSearch or wwIsClass(dataset, 'TTable') then
      begin
            if IsCaseInsensitiveIndex then LocateOptions:= [loPartialKey,  loCaseInsensitive]
            else LocateOptions:= [loPartialKey];

            if (Key='') then Dataset.first { 6/9/97}
            else if FieldNo=0 then
                DataSet.Locate(wwGetIndexFields(dataset, 0).FieldName, Key, LocateOptions)
//                DataSet.Locate(indexFields[0].FieldName, Key, LocateOptions)
            else begin
               LocateValues:= VarArrayCreate([0, FieldNo], varVariant);
               LocateFields:= '';
               SkipLocate:= False; { 2/22/99}
               for i:= 0 to FieldNo do begin
                  LocateValues[i]:= wwGetIndexFields(dataset, i).asString;

                  // 7/18/03 - Multi-field search skips in this case - it should not
                  if (i<FieldNo) and (wwGetIndexFields(dataset, i).isNull) then
                     SkipLocate:= True; { 2/22/99 }
                  if LocateFields<>'' then LocateFields:= LocateFields + ';';
                  LocateFields:= LocateFields + wwGetIndexFields(dataset,i).FieldName;
               end;
               LocateValues[FieldNo]:= Key;

               if not SkipLocate then  { 2/22/99 }
                  DataSet.Locate(LocateFields, LocateValues, LocateOptions);
            end
      end
      else begin
            Params:= VarArrayCreate([0, 1], varVariant);
            Params[0]:= fieldNo;
            Params[1]:= key;
            result:= wwGetVariableWithParams(dataset, 'FindNearest', Params);

            {
            case FieldNo of
                0: FindNearest([key]);
                1: FindNearest([indexFields[0].asString, key]);
                2: FindNearest([indexFields[0].asString, indexFields[1].asString, key]);
                3: FindNearest([indexFields[0].asString, indexFields[1].asString,
                           indexFields[2].asString, key]);
            end
            }
      end;

     {4/6/97}
      if (wwGetIndexFields(table, FieldNo).DataType in [ftFloat, ftCurrency]) then
      begin
         if (key = '') then
            result := (wwGetIndexFields(table, fieldNo).AsString = '')
         else result:=  StrToFloat(key)=TFloatField(wwGetIndexFields(table, fieldNo)).asFloat
      end
      else if isValueType(wwGetIndexFields(table, FieldNo).DataType) then
         result:=  key=wwGetIndexFields(table, fieldNo).asString
      else result:= pos(lowercase(key),
                   lowercase(wwGetIndexFields(table, fieldNo).asString))=1;
   finally
   end;
end;

procedure wwTableChangeIndex(dataSet: TDataSet; a_indexItem: TIndexDef);
var newIndexValues, parts: TStrings;
    j: integer;
    table: TDataSet;
    syncSQLByRange: boolean;
begin
   if not wwIsClass(dataset, 'TTable') then exit;
   table:= dataSet as TDataSet;

   if wwIsClass(table, 'TwwTable') then begin
      syncSQLByRange:= wwGetVariable(table, 'SyncSQLByRange'); //(dataset as TwwTable).SyncSQLByRange;
   end
   else begin
      syncSQLByRange:= False; // used to be treu
   end;

   if wwGetVariable(table, 'IsSQLBased') and (SyncSqlByRange) then begin
      if wwGetVariable(table, 'IndexName') = a_indexItem.Name then exit; { index already correct}

      Screen.cursor:= crHourGlass;

      parts:= Nil;
      newIndexValues:= Nil;
      with table do try
         parts:= TStringList.Create;
         newIndexValues:= TStringList.create;

         strBreakApart(a_IndexItem.fields, ';', parts);

         for j:= 0 to parts.count-1 do
            newIndexValues.add(fieldByName(Parts[j]).asString); { 6/20/98 - Changed from .text to .asString }

         disableControls;

         active:= False;
         wwSetVariable(table, 'indexName',  a_indexItem.Name);
//         IndexName:=  a_indexItem.Name;
         active:= True;

         { Synchronize to previous position}
         wwSetVariable(table, 'SetRangeStart', null);
         for j:= 0 to wwGetIndexFieldCount(table)-1 do
            TField(wwGetVariableObject(table, 'indexFields', j)).asString:= newIndexValues[j];
         wwSetVariable(table, 'ApplyRange', null);

         {
         setRangeStart;
         for j:= 0 to indexFieldCount-1 do
            IndexFields[j].asString:= newIndexValues[j];
         ApplyRange;
         }

         enableControls;

      finally
         Screen.cursor:= crDefault;
         newIndexValues.free;
         parts.free;
      end

   end
   else begin
      wwSetIndexName(table, a_indexItem.Name);
//      table.IndexName:=  a_IndexItem.Name;
   end;
end;



Function wwInPaintCopyState(ControlState: TControlState): boolean;
begin
   result:= (csPaintCopy in ControlState);
end;

procedure wwPlayKeystroke(Handle: HWND; VKChar: word; VKShift: Word);
var
  KeyState: TKeyboardState;
  NewKeyState: TKeyboardState;
{  i: integer;}
begin
   GetKeyboardState(KeyState);
{   for I := Low(NewKeyState) to High(NewKeyState) do
     NewKeyState[I] := 0;
}
   NewKeyState:= KeyState;
   NewKeyState [VKShift] := $81;
   NewKeyState [VKChar] := $81;
   SetKeyboardState(NewKeyState);
   PostMessage(Handle, WM_KEYDOWN, VKChar, 1);
   PostMessage(Handle, WM_KEYUP, VKChar, 1);
   SetKeyboardState(KeyState);
end;

procedure wwClearAltChar;
var KeyState: TKeyboardState;
begin
   GetKeyboardState(KeyState);
   KeyState [VK_Menu] := 0;
   SetKeyboardState(KeyState);
end;
{
Function wwGetUniqueFileName(Extension: string; var Filename: string): boolean;
var
    f: Double;
    startSeed, Seed: longint;
    Path: string;
    tempFileNameC: array[0..255] of char;
    SearchCount: integer;
begin
   GetTempFileName('C', '_WW', 1, tempFileNameC);
   path:= ExtractFilePath(strPas(tempFileNameC));
   f:= (Now - SysUtils.Date)*MSecsPerDay;
   seed:= Trunc(f) mod 10000;
   startSeed:= seed;
   repeat
      FileName:= Path + '_WW' + inttostr(seed) + '.' + Extension;
      seed:= (seed+1) mod 10000;
      if seed = startSeed then begin
         FileName:= '';
         result:= False;
         exit;
      end;
      inc(searchCount);
   until (not FileExists(FileName));
   result:= True;
end;
}
(*
   function wwGetQueryText(tempQBE: TStrings; Sql: boolean): PAnsiChar;
   var
     I: Integer;
     StrEnd: PAnsiChar;
     BufLen: word;
     incr: integer;
   begin
     BufLen := 1;
     if SQL then incr:= 1 else incr:= 2;
     for I := 0 to tempQBE.Count - 1 do
       Inc(BufLen, Length(tempQBE.Strings[I]) + incr);
     {$ifdef Unicode}
     Result := PAnsiChar(StrAlloc(BufLen));
     {$else}
     Result := StrAlloc(BufLen);
     {$endif}

     try
       StrEnd := Result;
       for I := 0 to tempQBE.Count - 1 do
       begin
         StrEnd := StrECopy(StrEnd, PAnsiChar(tempQBE.Strings[I])); { Support >255 lines in 32 bit}
         if i<tempQBE.Count-1 then
         begin
            if SQL then StrEnd := StrECopy(StrEnd, ' ')
            else StrEnd := StrECopy(StrEnd, #13#10);
         end
       end;
     except
       StrDispose(Result);
       raise;
     end;
   end;
 *)
Function wwMemAvail(memSize: integer): boolean;
begin
   result:= False;
end;

Procedure wwPictureByField(DataSet: TComponent; FieldName: string; FromTable: boolean;
    var Mask: string; var AutoFill, UsePictureMask: boolean);
var APos, i: integer;
    FPictureMasks: TStrings;
    TempMask: string;
begin
   Mask:= '';
   AutoFill:= True;
   UsePictureMask:= True;

   FPictureMasks:= wwGetPictureMasks(DataSet);
   if FPictureMasks=Nil then exit;

   for i:= 0 to FPictureMasks.count-1 do
   begin
      APos:= 1;
      if lowercase(FieldName)=lowercase(strGetToken(FPictureMasks[i], #9, APos)) then
      begin
         Mask:= strGetToken(FPictureMasks[i], #9, APos);
         Autofill:= strGetToken(FPictureMasks[i], #9, APos)='T';
         UsePictureMask:= strGetToken(FPictureMasks[i], #9, APos)='T';
         break;
      end
   end;

   { Use table mask and ignore component mask }
   if wwIsClass(DataSet, 'TwwTable') and fromTable then begin
      TempMask:= wwGetVariableWithParams(DataSet, 'GetDBPicture', FieldName);
//      TempMask:= TwwTable(Dataset).GetDBPicture(FieldName);
      if (TempMask<>'') and (Mask<>'') then begin
         wwSetPictureMask(dataSet, FieldName,
            '', AutoFill, UsePictureMask, True, True, False);
         Mask:= TempMask;
         exit;
      end
      else if TempMask<>'' then Mask:= TempMask;
   end;
end;

Procedure wwRegexByField(DataSet: TComponent; FieldName: string;
    var Mask: string; var CaseSensitive: boolean; var ErrorMsg: string);
var APos, i: integer;
    FPictureMasks: TStrings;
begin
   Mask:= '';
   CaseSensitive:= True;
   ErrorMsg:= '';

   FPictureMasks:= wwGetRegexMasks(DataSet);
   if FPictureMasks=Nil then exit;

   for i:= 0 to FPictureMasks.count-1 do
   begin
      APos:= 1;
      if lowercase(FieldName)=lowercase(strGetToken(FPictureMasks[i], #9, APos)) then
      begin
         Mask:= strGetToken(FPictureMasks[i], #9, APos);
         CaseSensitive:= strGetToken(FPictureMasks[i], #9, APos)='T';
         ErrorMsg:= strGetToken(FPictureMasks[i], #9, APos);
         break;
      end
   end;

end;

procedure wwDataModuleChanged(temp: TComponent);
begin
   while (temp<>Nil) and (temp.Owner<>Nil) and not (temp is TCustomForm) do temp:= temp.Owner;
   if (temp<>Nil) and (temp is TCustomForm) and ((temp as TCustomForm).Designer<>Nil) then
      (temp as TCustomForm).Designer.modified;
end;

procedure wwSetPictureMask(dataSet: TComponent; AFieldName: string;
    AMask: string;
    AutoFill: boolean;
    UsePictureMask: boolean;
    SetMask: boolean;
    SetAutoFill: boolean;
    SetUsePictureMask: boolean);
var i: integer;
    Found: boolean;
    FPictureMasks: TStrings;
    APos: integer;
    Temp: string;

    Function BoolToString(val: boolean): string;
    begin
       if val then result:= 'T' else result:= 'F';
    end;

begin
   Found:= False;
   FPictureMasks:= wwGetPictureMasks(DataSet);
   if FPictureMasks=Nil then exit;

   { DBMask takes precedence }
   if wwIsClass(DataSet, 'TwwTable') then
   begin
     Temp:= wwPdxPictureMask(TDataSet(DataSet), AFieldName);
     if Temp<>'' then AMask:= Temp;
   end;

   i:= 0;
   while (i<=FPictureMasks.count-1) do begin
      APos:= 1;
      if lowercase(AFieldName)=lowercase(strGetToken(FPictureMasks[i], #9, APos)) then
      begin
         Temp:= strGetToken(FPictureMasks[i], #9, APos);
         if not SetMask then AMask:= Temp;
         Temp:= strGetToken(FPictureMasks[i], #9, APos);
         if not SetAutoFill then AutoFill:= Temp='T';
         Temp:= strGetToken(FPictureMasks[i], #9, APos);
         if not SetUsePictureMask then usePictureMask:= Temp='T';

         if AMask='' then FPictureMasks.delete(i)
         else begin
            FPictureMasks.Strings[i]:= AFieldName + #9 +
                  AMask + #9 + BoolToString(AutoFill) +
                  #9 + BoolToString(UsePictureMask);
         end;
         Found:= True;
         break;
      end
      else i:= i + 1;
   end;

   if (not found) and (AMask<>'') then
      FPictureMasks.add(AFieldName + #9 + AMask + #9 +
               BoolToString(AutoFill) +
               #9 + BoolToString(UsePictureMask));

end;

procedure wwSetRegexMasks(dataSet: TComponent; AFieldName: string;
    AMask: string;
    CaseSensitive: boolean;
    ErrorMsg: string);
var i: integer;
    Found: boolean;
    FPictureMasks: TStrings;
    APos: integer;

    Function BoolToString(val: boolean): string;
    begin
       if val then result:= 'T' else result:= 'F';
    end;

begin
   Found:= False;
   FPictureMasks:= wwGetRegexMasks(DataSet);
   if FPictureMasks=Nil then exit;

   i:= 0;
   while (i<=FPictureMasks.count-1) do begin
      APos:= 1;
      if lowercase(AFieldName)=lowercase(strGetToken(FPictureMasks[i], #9, APos)) then
      begin
         if AMask='' then FPictureMasks.delete(i)
         else begin
            FPictureMasks.Strings[i]:= AFieldName + #9 +
                  AMask + #9 + BoolToString(CaseSensitive) +
                  #9 + ErrorMsg;
         end;
         Found:= True;
         break;
      end
      else i:= i + 1;
   end;

   if (not found) and (AMask<>'') then
      FPictureMasks.add(AFieldName + #9 + AMask + #9 +
               BoolToString(CaseSensitive) +
               #9 + ErrorMsg);

end;

Function wwGetFieldNameFromTitle(DataSet: TDataSet; fieldTitle: string): string;
var i: integer;
begin
   result:= '';
   with DataSet do begin
      for i:= 0 to fieldCount-1 do begin { 10/26/99 - RSW - Case insensitive comparison }
         if wwEqualStr(strReplaceChar(fields[i].displayLabel,'~',' '),
                       strReplaceChar(fieldTitle,'~',' ')) then
         begin
            result:= fields[i].FieldName;
            exit;
         end
      end
   end;
end;

Function wwGetListIndex(list: TStrings; itemName: string): integer;
var i: integer;
begin
   result:= -1;
   for i:= 0 to list.count-1 do begin
      if wwEqualStr(list[i], itemName) then begin
         result:= i;
         break;
      end
   end;
end;

Function wwGetOwnerForm(component: TComponent):TCustomForm;
var temp: TComponent;
begin
   temp:= component;
   while (temp<>Nil) and (temp.Owner<>Nil) and not (temp is TCustomForm) do temp:= temp.Owner;
   if temp is TCustomForm then { 9/27/99 - Fix bug where casting non tform to tform }
      result:= TCustomForm(temp)
   else result:= nil;
end;

Function wwGetOwnerFrameOrForm(component: TComponent):TComponent;
var temp: TComponent;
begin
   temp:= component;
   while (temp<>Nil) and (temp.Owner<>Nil) and
         {$ifdef wwDelphi5Up}
         not (temp is TCustomFrame) and
         {$endif}
         not (temp is TCustomForm) do
      temp:= temp.owner;
   {$ifdef wwDelphi5Up}
   if temp is TCustomFrame then
      result:= TCustomFrame(temp)
   else
   {$endif}
      if temp is TCustomForm then
        result:= TCustomForm(temp)
   else result:= nil;
end;

Function isWWEditControl(pname: string): boolean;
begin
   result:= wwEqualStr(pname, WW_DB_EDIT) or wwEqualStr(pname, WW_DB_LOOKUP_COMBO) or
            wwEqualStr(pname, WW_DB_COMBO)  or wwEqualStr(pname, WW_DB_RICHEDIT) ;
end;

Procedure wwDrawGlyph(
    Bitmap: TBitmap;
    Canvas: TCanvas; R: TRect;
    State: TButtonState;
    Enabled: Boolean;
    Transparent: boolean;
    FlatButtonTransparent: boolean;
    ControlState: TControlState);
var Flags: Integer;
    DC: HDC;
//    w: integer;
//    LeftIndent, TopIndent: integer;
begin
   Flags:= 0;
   if (State=bsDown) and not (wwInPaintCopyState(ControlState)) then
     Flags := BF_FLAT;
   if not FlatButtonTransparent then Flags:= Flags or BF_MIDDLE;
   DC:= Canvas.Handle;
   if not Transparent then
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or Flags);
   Canvas.CopyRect(R, Bitmap.Canvas, R);
end;


Procedure wwDrawEllipsis(Canvas: TCanvas; R: TRect;
    State: TButtonState;
    Enabled: Boolean;
    Transparent: boolean;
    FlatButtonTransparent: boolean;
    ControlState: TControlState);
var Flags: Integer;
    DC: HDC;
    w: integer;
    LeftIndent, TopIndent: integer;
begin
   Flags:= 0;
   if (State=bsDown) and not (wwInPaintCopyState(ControlState)) then
     Flags := BF_FLAT;
   if not FlatButtonTransparent then Flags:= Flags or BF_MIDDLE;
   DC:= Canvas.Handle;
   if not Transparent then
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or Flags);

   LeftIndent:= ((R.Right - R.Left) shr 1) - 1 + Ord(State=bsDown);
   TopIndent:= ((R.Bottom+1-R.Top) shr 1) - 1 + Ord(State=bsDown);
   W := (R.Right+1 - R.Left) shr 3;
   if W = 0 then W := 1;
   PatBlt(DC, R.Left + LeftIndent, R.Top + TopIndent, W, W, BLACKNESS);
   PatBlt(DC, R.Left + LeftIndent - (W * 2), R.Top + TopIndent, W, W, BLACKNESS);
   PatBlt(DC, R.Left + LeftIndent + (W * 2), R.Top + TopIndent, W, W, BLACKNESS);
end;

Procedure wwDrawDropDownArrow(Canvas: TCanvas; R: TRect;
    State: TButtonState;
    Enabled: Boolean;
    ControlState: TControlState);
var Flags: Integer;
begin
  if not Enabled then
    Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE
  else if (State=bsUp) or wwInPaintCopyState(ControlState) then
    Flags := DFCS_SCROLLCOMBOBOX
  else
    Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED;
//  Flags:= Flags or dfcs_flat;

  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
end;


Function wwHasIndex(ADataSet: TDataSet): boolean;
begin
   result:= wwIsClass(ADataSet, 'TwwTable') and
      (wwGetVariable(ADataSet, 'IndexFieldCount')>0); //(TwwTable(ADataSet).indexFieldCount>0);
end;

Function wwIsTableQuery(ADataSet: TDataSet): boolean;
begin
   result:= wwIsClass(ADataset, 'TwwTable') and
      wwGetVariable(ADataSet, 'IsQueryTable')
//   (TwwTable(ADataset).Query.Count>0)
end;

Function wwPdxPictureMask(ADataSet: TDataSet; AFieldName: string): string;
begin
   result:= '';
   if wwIsClass(ADataSet, 'TwwTable') then
   begin
     if ADataSet.FindField(AFieldName)=nil then exit;
     result:= wwGetVariableWithParams(ADataSet, 'GetDBPicture', AFieldName);
//     result:= TwwTable(ADataSet).GetDBPicture(AFieldName)
   end
end;

 { Calling a dialog in mouseDown event prevents mouseUp code from being executed}
 { The following code corrects this Windows anomaly.                            }
  procedure wwFixMouseDown;
  var i: integer;
      parentForm: TCustomForm;
      tempControl: TControl;
  begin
        parentForm:= Screen.ActiveForm;
        if parentForm=nil then exit;
        if (csLButtonDown in ParentForm.ControlState) then
        begin
           PostMessage(ParentForm.handle, WM_LBUTTONUP, 0, 0);
           exit;
        end;

        for i:= 0 to ParentForm.ControlCount-1 do begin
           tempControl:= ParentForm.Controls[i];
           if (csLButtonDown in tempControl.ControlState) and
              (tempControl is TWinControl) then begin
              PostMessage(TWinControl(tempControl).handle, WM_LBUTTONUP, 0, 0);
              break;
           end
        end
  end;

procedure wwValidatePictureFields(ADataSet: TDataSet;
     FOnInvalidValue: TwwInvalidValueEvent);
var
  I: Integer;
  tempPicture: string;
  tempAutoFill, tempUsePictureMask: boolean;

  function isValidPicture(PictureMask, s: string): boolean;
  var pict: TwwPictureValidator;
      res: TwwPicResult;
  begin
     if (s='') then
        result:= True
     else begin
        pict:= TwwPictureValidator.create(PictureMask, False);;
        res:= Pict.picture(s, False);
        result := res = prComplete;
        pict.Free;
     end;
  end;

begin
   { Component level validation }
   with ADataSet do begin
      for i:= 0 to FieldCount-1 do
      begin
         wwPictureByField(ADataSet, Fields[i].FieldName, True,
                    tempPicture, tempAutoFill, tempUsePictureMask);
         if tempPicture<>'' then begin
            if not isValidPicture(tempPicture, Fields[i].asString) then
{            if not isValidPicture(tempPicture, Fields[i].DisplayText) then}
            begin
               with Fields[i] do begin
                  if not ReadOnly then begin
                     FocusControl;
                     if Assigned(FOnInvalidValue) then
                        FOnInvalidValue(ADataSet, Fields[i]);
                     DatabaseError(wwInternational.UserMessages.PictureValidateError + DisplayName);
                  end
               end
            end
         end
      end
   end
end;

function wwDataSetFindRecord(
   DataSet: TDataSet;
   KeyValue: string;
   LookupField: string;
   MatchType: TwwLocateMatchType;
   caseSensitive: boolean): boolean;
var tempStr: string;

    { If already on this record then skip findkey }
    Function isAlreadyFound: boolean;
    begin
      if CaseSensitive then result:= tempStr=KeyValue
      else result:= lowercase(tempstr)=lowercase(KeyValue);
    end;

begin
   result:= True;
   tempStr:= DataSet.FieldByName(LookupField).asString;
   if isAlreadyFound then exit;
   result:=  wwFindMatch(True, DataSet, LookupField,
                       KeyValue, matchType, CaseSensitive);
end;



Function wwValidFilterableFieldType(ADataType: TFieldType): boolean;
begin
   result:= not ((ADataType = ftBlob) or (ADataType=ftGraphic) or
                  (ADataType = ftVarBytes) or (ADataType=ftBytes));
end;

procedure wwALinkHelp(Handle: HWND; ALink: string);
begin
end;


procedure wwHelp(Handle: HWND; HelpTopic: PChar);
begin
end;


Function wwIsValidChar(key: word): boolean;
begin
   result:= (key = VK_BACK) or (key=VK_SPACE) or (key=VK_DELETE) or
            ((key >= ord('0')) and (key<=VK_DIVIDE)) or
            (key>VK_SCROLL);
end;

procedure wwDataSet_SetLookupLink(dataSet: TDataSet;
   FldName, DatabaseName, TableName, DisplayFld, IndexFieldNames, Links: string;
   useExtension: Char);
var
   FLookupLinks, FLookupFields: TStrings;
   parts: Tstrings;
   i: integer;
begin
   parts:= TStringList.create;
   FLookupFields:= wwGetLookupFields(dataSet);
   FLookupLinks:= wwGetLookuplinks(dataSet);

   i:=0;
   while (i<=FLookupfields.count-1) do begin
      strbreakApart(FLookupFields.Strings[i], ';', parts);
      if lowercase(parts[0])=lowercase(FldName) then begin
         FLookupFields.delete(i);
         FLookupLinks.delete(i);
      end
      else i:= i+1;
   end;

   if not
     ((DatabaseName='') or (TableName='') or (DisplayFld='') or (IndexFieldNames='')) then
   begin
      FLookupFields.add(FldName + ';' + DatabaseName + ';' + TableName + ';' +
         DisplayFld + ';;' + IndexFieldNames + ';' + useExtension);

      FLookupLinks.add(Links);
   end;

   parts.Free;
end;

Procedure wwDataSetUpdateSelected(dataSet: TDataSet; selected: TStrings);
var i: integer;
begin
   selected.clear;
   with dataSet do begin
      for i:= 0 to fieldCount-1 do begin
         if (fields[i].visible) then
            Selected.add(fields[i].fieldName + #9 +
              inttostr(fields[i].displayWidth) + #9 +
              fields[i].displayLabel);
      end;
   end
end;

Function wwFindSelected(selected: TStrings;
   FieldName: string; var index: integer): boolean;
var i: integer;
    parts: TStringList;
begin
   parts := TStringList.create;
   result:= False;

   try
      if selected<>Nil then begin
         for i:= 0 to selected.count-1 do begin
            strBreakApart(selected[i], #9, parts);
            if uppercase(parts[0])=uppercase(FieldName) then begin
               index:= i;
               result:= True;
               exit;
            end;
         end
      end
   finally
      parts.Free;
   end;
end;

Function wwAdjustPixels(PixelSize,PixelsPerInch : integer): integer;
var temp: longint;
begin
   temp:= LongInt(PixelSize) * LongInt(PixelsPerInch);
   result := temp div 96;
end;

Procedure wwSetOnFilterEnabled(dataset: TDataset; val: boolean);
var PropInfo: PPropInfo;
    tempOptions: TwwOnFilterOptions;
    SetValue: Longint;
begin
   tempOptions:= wwGetOnFilterOptions(dataset);
   if val then tempOptions:= tempOptions + [ofoEnabled]
   else tempOptions:= tempOptions - [ofoEnabled];

   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'OnFilterOptions');
   if PropInfo<>Nil then begin
      SetValue:= LongInt(PChar(@tempOptions)^);
      SetOrdProp(dataset, PropInfo, SetValue);
   end;

{   if dataSet is TwwTable then TwwTable(dataSet).OnFilterOptions:= tempOptions{
{   else if dataSet is TwwQuery then TwwQuery(dataSet).OnFilterOptions:= tempOptions;
   else if dataSet is TwwQBE then TwwQBE(dataSet).OnFilterOptions:= tempOptions;
   else if dataSet is TwwStoredProc then TwwStoredProc(dataSet).OnFilterOptions:= tempOptions;
}
end;

Function wwGetOnFilterOptions(dataset: TDataset): TwwOnFilterOptions;
var PropInfo: PPropInfo;
    f: TwwOnFilterOptions;
begin
   Result:= [];

   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'OnFilterOptions');
   if PropInfo<>Nil then begin
      PChar(@F)^:= Char(GetOrdProp(dataset, PropInfo));
      result:= f;
   end
   else begin
      if DataSet.Filtered then Result:= [ofoEnabled];
   end;

{   if wwIsClass(dataset.classType, 'TwwClientDataSet') then
   begin
      if DataSet.Filtered then Result:= [ofoEnabled];
   end else begin
      PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'OnFilterOptions');
      if PropInfo<>Nil then PChar(@F)^:= Char(GetOrdProp(dataset, PropInfo));
      result:= f;
   end
}   
end;

Function wwProcessEscapeFilterEvent(dataset: TDataset): boolean;
var msg: TMsg;
begin
   result:= false;
   if PeekMessage(msg, 0, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE) then
   begin
      if (Msg.Message=WM_KEYDOWN) and (Msg.wparam=VK_ESCAPE) then
      begin
         wwSetOnFilterEnabled(dataset, False);
         result:= true;
      end
   end;
end;

{4/10/97 - Define wwmin, wwmax}
Function wwmax(x,y: integer): integer;
begin
  if x>y then result:= x else result:= y;
end;

Function wwmin(x,y: integer): integer;
begin
  if x<y then result:= x else result:= y;
end;


{Function wwGetControlDataSource(ctrl: TWinControl): TDataSource;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   if Ctrl.InheritsFrom(TCustomEdit) then
   begin
      PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'DataSource');
      if PropInfo<>Nil then begin
         result:= TDataSource(GetOrdProp(ctrl, PropInfo));
      end
   end;
end;
}

function wwDataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TBookmark): integer;//CmpBkmkRslt;
begin
   {$ifdef wwDelphi3Up}
   result:= (DataSet as TDataSet).CompareBookmarks(bookmark1, bookmark2);
   {$else}
   with (DataSet as TDBDataSet) do begin
     if Handle <> nil then
        Check(DbiCompareBookmarks(Handle, Bookmark1, Bookmark2, Result));
   end;
   {$endif}
end;

{ Return true if class is derived from 'Name' }
{ This code is more code efficient than InheritsFrom or 'Is'
  as it does not require that the compiler link in the class }
function wwIsClass(ClassType: TClass; const Name: string): Boolean;
begin
  Result := True;
  while ClassType <> nil do
  begin
{    if ClassType.ClassNameIs(Name) then Exit;}
    if wwEqualStr(ClassType.ClassName, Name) then Exit;
    ClassType := ClassType.ClassParent;
  end;
  Result := False;
end;

function wwIsClass(component: TComponent; const Name: string): boolean;
begin
    if component = nil then
    begin
       result:=false;
       exit;
    end;
    result:= wwIsClass(component.classType, Name);
end;

function wwGetWorkingRect:TRect;
begin
   SystemParametersInfo(SPI_GETWORKAREA,0,Pointer(@Result),0);
end;

Function wwApplyPictureMask(Control: TCustomEdit; PictureMask: string; AutoFill: boolean; var Key: Char): boolean;
var s: string;
    pict: TwwPictureValidator;
    res: TwwPicResult;
    padlength, OldSelStart, Oldlen, OldSelLen: integer;

   Function NewText: string;
   var curStr : string;
   begin
      with Control do begin
         curStr:= Text;
         result:= copy(curStr, 1, selStart+1-1) +
                  char(Key) + copy(curStr, selStart + 1 + length(SelText), 32767);
      end
   end;

   function IsValidKey(Key: Char): boolean;
   begin
      result:= (key>=#32) and (key<=#254) or
               (key>#255) and (Key<=High(Char));
   end;


begin
    result:= false;
    if not IsValidKey(Key) then exit; //(Key in [#32..#254]) then exit;
    if Control.selStart<(length(Control.Text)-Control.selLength) then exit;

    pict:= TwwPictureValidator.create(PictureMask, AutoFill);
    s:= NewText;
    res:= Pict.picture(s, AutoFill);
    result:= True;

    oldSelStart:= Control.SelStart;
    oldLen:= length(Control.Text);
    oldSelLen:= Control.SelLength;

    case res of
       prError:
          with Control do begin
             if (selStart + length(selText) >= length(Text)) then
             begin
                MessageBeep(0);
             end
          end;

       prIncomplete: begin
            with Control do begin
               padLength := length(s) - length(text);
               text:= s;
               if (oldSelLen=oldLen) then selStart:= length(s)
               else if (oldSelLen>0) then selStart:= OldSelStart + 1
               else selStart:= OldSelStart + padLength;
               result:= True;
            end;
         end;

       prComplete: begin
           with Control do begin
               text:= s;
               if (oldSelLen=oldLen) then selStart:= length(s)
               else if (length(s)>oldlen) then
                  selStart:= oldSelStart + (length(s)-oldlen)
               else selStart:= oldSelStart + 1;
               selLength:= 0;
               result:= True;
           end
        end;

    end;

    Pict.Free;
    key:= #0;
end;

Function wwValidPictureValue(Control: TCustomEdit; PictureMask: string): boolean;
var pict: TwwPictureValidator;
    s: string;
begin
   s:= Control.text;
   if s='' then result:= True
   else if PictureMask='' then result:= True
   else begin
      pict:= TwwPictureValidator.create(PictureMask, False);
      result:= Pict.picture(s, False)=prComplete;
      pict.Free;
   end;
end;


Function wwSetControlDataSet(ctrl: TComponent; DataSet: TDataSet; PropertyName: string): boolean;
var PropInfo: PPropInfo;
begin
   result:= False;
   if Ctrl.InheritsFrom(TWinControl) then
   begin
      PropInfo:= Typinfo.GetPropINfo(ctrl.ClassInfo, PropertyName);
      if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
      begin
         SetOrdProp(Ctrl,PropInfo,LongInt(DataSet));
         result:= True;
      end
   end;
end;

Function wwSetControlDataSource(ctrl: TControl; ds: TDataSource): boolean;
var PropInfo: PPropInfo;
begin
   result:= False;
   if Ctrl.InheritsFrom(TWinControl) then
   begin
      PropInfo:= Typinfo.GetPropINfo(ctrl.ClassInfo,'DataSource');
      if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
      begin
         SetOrdProp(Ctrl,PropInfo,LongInt(ds));
         result:= True;
      end
   end;
end;

Function wwSetControlDataField(ctrl: TControl; df: string): boolean;
//var PropInfo: PPropInfo;
begin
   Result:= False;
   if Ctrl.InheritsFrom(TWinControl) then { 6/12/98 - Changed to TWinControl }
   begin
      result:= wwSetString(ctrl, 'DataField', df);
   end;
end;

Function wwGetControlDataField(ctrl: TControl): string;
var PropInfo: PPropInfo;
begin
   Result:= '';
   if Ctrl.InheritsFrom(TWinControl) then
   begin
      PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'DataField');
      if PropInfo<>Nil then
         result:= GetStrProp(ctrl, PropInfo);
   end;
end;

Function wwGetControlDataSource(ctrl: TComponent): TDataSource;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'DataSource');
   if PropInfo<>Nil then begin
      result:= TDataSource(GetOrdProp(ctrl, PropInfo));
   end
end;

Function wwGetControlMasterSource(ctrl: TComponent): TDataSource;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'MasterSource');
   if PropInfo<>Nil then begin
      result:= TDataSource(GetOrdProp(ctrl, PropInfo));
   end
end;


Function wwSetBoolean(ctrl: TComponent; PropertyName: string; val: boolean): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo, PropertyName);
   if (PropInfo<>Nil) then begin
      SetOrdProp(Ctrl, PropInfo, ord(val));
      result:= True;
   end
end;

Function wwSetRequestLive(ctrl: TDataset; val: boolean): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'RequestLive');
   if (PropInfo<>Nil) then begin
      SetOrdProp(Ctrl, PropInfo, ord(val));
      result:= True;
   end
end;

Function wwSetReadOnly(ctrl: TComponent; val: boolean): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'ReadOnly');
   if (PropInfo<>Nil) then begin
      SetOrdProp(Ctrl, PropInfo, ord(val));
      result:= True;
   end
end;

Function wwGetReadOnly(ctrl: TComponent): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'ReadOnly');
   if PropInfo<>Nil then result:= Boolean(GetOrdProp(Ctrl, PropInfo));
end;


Function wwSetBorder(ctrl: TControl; val: boolean): boolean;
var PropInfo: PPropInfo;
    intval: integer;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo, 'BorderStyle');
   if (PropInfo<>Nil) then begin
      if val then intval:= ord(bsSingle)
      else intval:= ord(bsNone);
      SetOrdProp(Ctrl, PropInfo, intval);
      result:= True;
   end
end;

Function wwGetBorder(ctrl: TControl): boolean;
var PropInfo: PPropInfo;
    intval: integer;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo, 'BorderStyle');
   if (PropInfo<>Nil) then begin
      intval:= GetOrdProp(Ctrl, PropInfo);
      result:= intval<>0;
   end
end;

Function wwSetParamCheck(ctrl: TDataset; val: boolean): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'ParamCheck');
   if (PropInfo<>Nil) then begin
      SetOrdProp(Ctrl, PropInfo, ord(val));
      result:= True;
   end
end;

Function wwGetWantReturns(ctrl: TControl): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'WantReturns');
   if PropInfo<>Nil then result:= Boolean(GetOrdProp(Ctrl, PropInfo));
end;

Function wwGetParamCheck(ctrl: TDataset): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'ParamCheck');
   if PropInfo<>Nil then result:= Boolean(GetOrdProp(Ctrl, PropInfo));
end;

Function wwSetConnection(ctrl: TDataset; Connection: TComponent): boolean;
var PropInfo: PPropInfo;
begin
   result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'Connection');
   if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
   begin
      SetOrdProp(Ctrl,PropInfo,LongInt(Connection));
      result:= True;
   end;
end;

Function wwSetConnectionString(ctrl: TDataset; df: string): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropINfo(ctrl.ClassInfo,'ConnectionString');
   if (PropInfo<>nil) {and (PropInfo^.Proptype^.Kind = tklString) }then begin
      SetStrProp(Ctrl,PropInfo,df);
      result:= True;
   end
end;

Function wwSetDatabaseName(ctrl: TDataset; df: string): boolean;
begin
   result:= wwSetString(ctrl, 'DatabaseName', df);
end;

Function wwSetIndexFieldNames(ctrl: TDataset; df: string): boolean;
var parts: TStrings;
    i: integer;
begin
   parts:=nil;
   if (wwIsClass(ctrl.classType, 'TADOTable') or wwIsClass(ctrl.classType, 'TADODataSet')) then
   begin
      strRemoveChar(df, '[');
      strRemoveChar(df, ']');
      parts:= TStringList.Create;
      strBreakApart(df, ';', parts);
      for i:= 0 to parts.Count-1 do
      begin
         if Pos(' ', parts[i])>=1 then
            parts[i]:= '[' + parts[i] + ']';
      end;
      for i:= 0 to parts.Count-1 do
      begin
         df:= parts[i];
         if i<parts.Count-1 then
            df:= df + ';';
      end;
   end;
   parts.Free;
   result:= wwSetString(ctrl, 'IndexFieldNames', df);
end;

Function wwSetTableName(ctrl: TDataset; df: string): boolean;
begin
   result:= wwSetString(ctrl, 'TableName', df);
end;

Function wwSetString(ctrl: TComponent; PropertyName : string; s: string): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropINfo(ctrl.ClassInfo, PropertyName);
   if (PropInfo<>nil) and
      {$ifdef Unicode}
      (PropInfo^.Proptype^.Kind in [tkuString, tkwString, tklString]) then
      {$else}
      (PropInfo^.Proptype^.Kind in [tklString, tkwString]) then
      {$endif}
   begin
      SetStrProp(Ctrl,PropInfo, s);
      result:= True;
   end
end;

Function wwSetSessionName(ctrl: TDataset; df: string): boolean;
begin
   result:= wwSetString(ctrl, 'SessionName', df);
end;

Function wwGetSessionName(dataSet: TDataSet): String;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'SessionName');
   if PropInfo<>Nil then
      result:= GetStrProp(DataSet, PropInfo);
end;

Function wwGetControlPictureMask(ctrl: TCustomEdit): String;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(Ctrl.ClassInfo, 'PictureMask');
   if PropInfo<>Nil then result:= GetStrProp(Ctrl, PropInfo);
end;

Procedure wwSetControlPictureMask(ctrl: TCustomEdit; PictureMask: string);
begin
   wwSetString(ctrl, 'PictureMask', PictureMask);
end;

Function wwGetControlAutoFill(ctrl: TCustomEdit): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(Ctrl.ClassInfo, 'PictureMaskAutoFill');
   if PropInfo<>Nil then result:= Boolean(GetOrdProp(Ctrl, PropInfo));
end;

Procedure wwSetControlAutoFill(ctrl: TCustomEdit; AutoFill: boolean);
var PropInfo: PPropInfo;
begin
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'PictureMaskAutoFill');
   if PropInfo<>Nil then
   begin
      SetOrdProp(Ctrl, PropInfo, Ord(AutoFill));
   end;
end;


Function wwGetSQLWord(s: string; var APos: integer): string;
var i: integer;

   Function max(x,y: integer): integer;
   begin
     if x>y then result:= x
     else result:= y;
   end;

     Function IsSymbolKey(key: char): boolean;
     begin
        result:= ((key>='A') and (key<='Z')) or
                 ((key>='0') and (key<='9')) or
                 (key = '.') or (key='_') or (key='$');

     end;


begin
   result:= '';
   if APos<=0 then exit;
   if APos>length(s) then exit;

   i:= APos;
   while (i<=length(s)) and ((s[i]=' ') or (s[i]=#9)) do inc(i); { skip leading whitespace}
   APos:= i; { Skip leading blanks/tabs }
   if i>length(s) then exit { 10/6/98 - Avoid range check error}
   else if s[i]='"' then begin
      inc(i);
      while (i<=length(s)) and (s[i]<>'"') do inc(i);
      if s[i]='"' then begin
         result:= copy(s, APos, i+1-APos);
         APos:= i+1;
      end
   end
   else if s[i]='''' then begin
      inc(i);
      while (i<=length(s)) and (s[i]<>'''') do inc(i);
      if s[i]='''' then begin
         result:= copy(s, APos, i+1-APos);
         APos:= i+1;
      end
   end
   else begin     {1/18/97 - Added $ to list of valid characters for current word}
      while (i<=length(s)) and IsSymbolKey(s[i]) do inc(i); //(s[i] in ['A'..'Z','0'..'9','.','_','$']) do inc(i);
      result:= copy(s, APos, max(i-APos, 1));

      if length(result)>1 then APos:= i
      else APos:= i+1;
   end;
end;

Function wwGetDataSet(DataSet: TComponent): TDataSet;
var PropInfo: PPropInfo;
begin
   Result:= nil;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'DataSet');
   if PropInfo<>Nil then begin
      result:= TDataSet(GetOrdProp(dataset, PropInfo));
   end
end;

Function wwGetDataSource(DataSet: TComponent): TDataSource;
var PropInfo: PPropInfo;
begin
   Result:= nil;
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'DataSource');
   if PropInfo<>Nil then begin
      result:= TDataSource(GetOrdProp(dataset, PropInfo));
   end
end;
{
Function wwGetIndexDefs(Component: TComponent): TIndexDefs;
var
    IndexDefs: TIndexDefs;
    PropInfo: PPropInfo;
begin
   IndexDefs:= nil;
   PropInfo:= Typinfo.GetPropInfo(Component.ClassInfo,'IndexDefs');
   if PropInfo<>Nil then IndexDefs:= TIndexDefs(GetOrdProp(Component, PropInfo));
   result:= IndexDefs;
end;
}
function wwGetIndexDefs(Dataset: TDataSet; var IndexDefs: TIndexDefs): boolean;
var PropInfo: PPropInfo;
 c            : TRttiContext;
 Prop         : string;
 pm           : TRttiProperty;
 Obj          : TObject;
begin
  if IPUseOldGetIndexDefs then
  begin
    result:= false;
    IndexDefs:= nil;
    if DataSet=nil then exit;
    PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'IndexDefs');
    if PropInfo<>Nil then
    begin
      Result:= True;
      IndexDefs:= TIndexDefs(GetObjectProp(DataSet, PropInfo));
    end;
  end
  else begin
    Prop:= 'IndexDefs'; //ObjPath;
    c := TRttiContext.Create;
    result:= false;
    try
      for pm in c.GetType(DataSet.ClassInfo).GetProperties do
      if CompareText(Prop,pm.Name)=0 then
      begin
        obj:= pm.GetValue(DataSet).asobject;
        if obj is TIndexDefs then
        begin
          result:= true;
          IndexDefs:= obj as TIndexDefs
        end
        else
          IndexDefs:= nil;
        break;
      end;
    finally
      c.Free;
    end;
  end;
end;


{
Function wwGetIndexDefs(Component: TComponent): TIndexDefs;
var
    IndexDefs: TIndexDefs;
    PropInfo: PPropInfo;
begin
   IndexDefs:= nil;
   PropInfo:= Typinfo.GetPropInfo(Component.ClassInfo,'IndexDefs');
   if PropInfo<>Nil then IndexDefs:= TIndexDefs(GetOrdProp(Component, PropInfo));
   result:= IndexDefs;
end;
}

function wwGetVariable(Component: TComponent; VariableName: string): Variant;
type
    TMethodFunction = function(VariableName: string): variant of object;
var
    MethodFunction: TMethod;
begin
   if component=nil then result:= null
   else begin
     TMethod(MethodFunction).Data := Component; // object reference
     TMethod(MethodFunction).Code := Component.MethodAddress('GetVariable');
     if MethodFunction.Code=nil then result:=null
     else result:= TMethodFunction(MethodFunction)(VariableName);
   end;
end;

function wwGetVariableWithParams(Component: TComponent; VariableName: string; Params: variant): Variant;
type
    TMethodFunction = function(VariableName: string; Params: variant): variant of object;
var
    MethodFunction: TMethod;
begin
   if component=nil then begin
      result:= null;
      exit;
   end;

   TMethod(MethodFunction).Data := Component; // object reference
   TMethod(MethodFunction).Code := Component.MethodAddress('GetVariableWithParams');
   if MethodFunction.Code=nil then result:=null
   else result:= TMethodFunction(MethodFunction)(VariableName, Params);
end;

function wwGetVariableWithParams2(Component: TComponent; VariableName: string;
            const StartValues, EndValues: array of const): Variant;
type
    TMethodFunction = function(VariableName: string;
            const StartValues, EndValues: array of const): Variant of object;
var
    MethodFunction: TMethod;
begin
   if component=nil then begin
      result:= null;
      exit;
   end;

   TMethod(MethodFunction).Data := Component; // object reference
   TMethod(MethodFunction).Code := Component.MethodAddress('GetVariableWithParams2');
   if MethodFunction.Code=nil then result:=null
   else result:= TMethodFunction(MethodFunction)(VariableName, StartValues, EndValues);
end;

function wwGetVariableObject(Component: TComponent; VariableName: string; Param: variant): TObject;
type
    TMethodFunction = function(VariableName: string; Param: variant): Tobject of object;
var
    MethodFunction: TMethod;
begin
   if component=nil then begin
      result:= nil;
      exit;
   end;
   TMethod(MethodFunction).Data := Component; // object reference
   TMethod(MethodFunction).Code := Component.MethodAddress('GetVariableObject');
   if MethodFunction.Code=nil then result:=nil
   else result:= TMethodFunction(MethodFunction)(VariableName, Param);
end;


procedure wwSetVariable(Component: TComponent; VariableName: string; Value: Variant);
type
    TMethodProc = Procedure(VariableName: string; Value: Variant) of object;
var
    MethodFunction: TMethod;
begin
   if component=nil then exit;
   TMethod(MethodFunction).Data := Component; // object reference
   TMethod(MethodFunction).Code := Component.MethodAddress('SetVariable');
   if MethodFunction.Code=nil then exit;
   TMethodProc(MethodFunction)(VariableName, Value);
end;

procedure wwSetVariableObject(Component: TComponent; VariableName: string; Value: TObject);
type
    TMethodProc = Procedure(VariableName: string; Value: TObject) of object;
var
    MethodFunction: TMethod;
begin
   if component=nil then exit;
   TMethod(MethodFunction).Data := Component; // object reference
   TMethod(MethodFunction).Code := Component.MethodAddress('SetVariableObject');
   if MethodFunction.Code=nil then exit;
   TMethodProc(MethodFunction)(VariableName, Value);
end;


Function wwSetSQLProp(ctrl: TDataset; sql: TStrings; PropName: string): boolean;
var PropInfo: PPropInfo;
    tempList: TStringList;
    tempsql: string;
    i: integer;
begin
   result:= False;
   tempList:= TStringlist.create;
   tempList.assign(sql);

   if wwIsClass(ctrl.classType, 'TSimpleDataSet') then
      Ctrl:= wwGetDataSet(ctrl);

   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo, PropName);
   if (PropInfo <> nil) then
   begin
      if (PropInfo^.Proptype^.Kind = tkClass) then
      begin
         SetOrdProp(Ctrl,PropInfo,LongInt(tempList));
         result:= True;
      end
      {$ifdef Unicode}
      else if (PropInfo^.Proptype^.Kind in [tkString, tklstring, tkwstring, tkustring]) then
      {$else}
      else if (PropInfo^.Proptype^.Kind in [tkString, tklstring, tkwstring]) then
      {$endif}
      begin
         tempsql:= '';
         for i:= 0 to sql.count-1 do begin
            if i>0 then tempsql:= tempsql + #13#10;
            tempsql:= tempsql + sql[i]
         end;
         SetStrProp(Ctrl, PropInfo, tempsql);
      end
   end;
   tempList.Free;
end;


Function wwSetParamsProp(ctrl: TDataset; Params: TParams): boolean;
var PropInfo: PPropInfo;
begin
   result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'Params');
   if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
   begin
      wwGetParamsProp(ctrl).Assign(Params);
      result:= True;
   end;
end;

Function wwGetParamsProp(ctrl: TDataset): TParams;
var PropInfo: PPropInfo;
begin
   result:= nil;
   PropInfo:= Typinfo.GetPropINfo(ctrl.ClassInfo,'Params');
   if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
      result:= TParams(GetOrdProp(Ctrl,PropInfo));
end;

{3/31/98 - Determine if this is a single line edit control based on passed in rectangle}
{ 9/13/98 - Changed handle to HDC }
Function wwIsSingleLineEdit(AHandle:HDC; Rect: TRect; Flags:Integer): boolean;
var OrigEditHeight,SingleLineEditHeight:Integer;
    S:String;
begin
  Flags := Flags or DT_CALCRECT;

  OrigEditHeight := Rect.Bottom-Rect.Top;

  S:=' ';
  SingleLineEditHeight := DrawText(AHandle,PChar(S),strlen(PChar(S)),Rect,Flags)+
    3 + GetSystemMetrics(SM_CYBORDER) * 2;

  result := OrigEditHeight <= SingleLineEditHeight;
end;

function wwIsRichEditField(Field: TField; ExamineData: boolean): boolean;
var i: integer;
    controlType: TStrings;
  BlobStream: TStream;
  Buffer: packed array[1..5] of ansichar; // 6/3/09
begin
   result:= False;
   if (Field = nil) then exit;
   if not (Field is TBlobField) then exit;

   controlType:= wwGetControlType(Field.Dataset);
   if ControlType<>nil then for i:= 0 to ControlType.count-1 do begin { Delphi 5}
      if pos(Field.FieldName + ';RichEdit', ControlType[i])=1 then
      begin
         result:= True;
         exit;
      end
   end;

   if not ExamineData then exit;

   // 6/3/09 - Support unicode wide strings
   {$ifdef wwDelphi2006Up}
   if (Field is TBlobField) and ((Field as TBlobField).BlobType = ftWideMemo) then
      result:= copy(Field.AsString,1,5) = '{\rtf'
   else {$endif} begin
      BlobStream := Field.DataSet.CreateBlobStream(Field, bmRead);
      try
        Buffer:= '     ';
        BlobStream.Read(Buffer, 5);
        result:= Buffer = '{\rtf'
      finally
        BlobStream.Free;
      end;
   end;
end;


function RichEditTextToPlainText(
      Owner: TWinControl;
      MemoString: string;
      var RichEditControl: TCustomRichEdit;
      var MemoryStream: TStringStream): string;
var tempRichEdit: TCustomRichEdit;
begin
    if MemoryStream=Nil then
       memoryStream:= TStringStream.Create
    else begin
       memoryStream.position:= 0;
       memoryStream.size:= 0;
    end;
    memoryStream.WriteString(MemoString);

    if RichEditControl=Nil then begin
       tempRichEdit:= TRichEdit.create(Owner);
       tempRichEdit.visible:= False;
       tempRichEdit.parent:= Owner;
    end
    else TempRichEdit:= RichEditControl;

    with TRichEdit(TempRichEdit) do begin
       (tempRichEdit as TRichEdit).plainText:= false;
       memoryStream.position:= 0;
       Lines.LoadFromStream(memoryStream);
    end;
    result:= tempRichEdit.Text;

end;

procedure RichEditTextToPlainText(
      Owner: TWinControl;
      MemoBuffer: PChar;
      var numRead: Cardinal;
      var RichEditControl: TCustomRichEdit;
      var MemoryStream: TStringStream);
var tempRichEdit: TCustomRichEdit;
begin
    if MemoryStream=Nil then
       memoryStream:= TStringStream.Create
    else begin
       memoryStream.position:= 0;
       memoryStream.size:= 0;
    end;
    memoryStream.WriteString(StrPas(MemoBuffer));

    if RichEditControl=Nil then begin
       tempRichEdit:= TRichEdit.create(Owner);
       tempRichEdit.visible:= False;
       tempRichEdit.parent:= Owner;
    end
    else TempRichEdit:= RichEditControl;

    with TRichEdit(TempRichEdit) do begin
       (tempRichEdit as TRichEdit).plainText:= false;
       memoryStream.position:= 0;
       Lines.LoadFromStream(memoryStream);
    end;

    strcopy(MemoBuffer, PChar(tempRichEdit.text));
end;
{
procedure wwGetInterface(AObject: TObject; IID: TGUID; out Obj);
var
  InterfaceEntry: PInterfaceEntry;
begin
  InterfaceEntry := AObject.GetInterfaceEntry(IID);
  if InterfaceEntry <> nil then
    Pointer(Obj) := Pointer(Integer(AObject) + InterfaceEntry^.IOffset)
  else
    Pointer(Obj) := nil;
end;
}
procedure wwDrawFocusRect(ACanvas: TCanvas; ARect: TRect);
var OldBrushStyle: TBrushStyle;
    OldPenColor: TColor;
    temp: integer;
    OldTextColor:TColor;
begin
  OldBrushStyle := ACanvas.Brush.Style;  // Added so DrawFocusRect wouldn't have funny colors in it.  Initializes the background. -ksw (7/8/98)
  OldPenColor := ACanvas.Pen.Color;
  OldTextColor := GetTextColor(ACanvas.Handle); //4/10/2002 - Save and Restore Text Color.
  ACanvas.Brush.Style := bsClear;
  ACanvas.Pen.Color := clHighlight;
  ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
  SetTextColor(ACanvas.Handle, ColorToRGB(clHighlight));
  ACanvas.Brush.Style := OldBrushStyle;
  ACanvas.Pen.Color := OldPenColor;
  if ACanvas.CanvasOrientation = coRighttoleft then
  begin
    Temp:= ARect.left;
    ARect.left:= ARect.Right;
    ARect.Right:=Temp;
  end;
  Windows.DrawFocusRect(ACanvas.Handle, ARect);
  SetTextColor(ACanvas.Handle, ColorToRGB(OldTextColor));
end;

// Bypasses compatibility mode flags so returns true if truly vista
function IsTrueVista: boolean;
    function ExportsAPI(module: HMODULE; const apiName: string): boolean;
    begin
      Result := GetProcAddress(module, PChar(apiName)) <> nil;
    end; { ExportsAPI }
var
  hKernel32: HMODULE;
begin
   result:=false;
   hKernel32 := GetModuleHandle('kernel32');
   {$Warnings Off}
   Win32Check(hKernel32 <> 0);
   {$Warnings On}
   if ExportsAPI(hKernel32, 'GetLocaleInfoEx') then
      Result := true; //wvWinVista
end;

function IsVista: boolean;
begin
  result:= (Win32MajorVersion>=6) or
        (Win32MajorVersion>=5) and IsTrueVista
end;

function wwGetComCtlVersion: Integer;
const wwComCtlDllName = 'comctl32.dll';
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  if wwComCtlVersion = 0 then
  begin
    FileName := wwComCtlDllName;
    InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
    if InfoSize <> 0 then
    begin
      GetMem(VerBuf, InfoSize);
      try
        if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
          if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
            wwComCtlVersion := FI.dwFileVersionMS;
      finally
        FreeMem(VerBuf);
      end;
    end;
  end;
  Result := wwComCtlVersion;
end;


function IsVistaComCtrlVersion: boolean;
var dummy: DWORD;
    verInfoSize, verValueSize: DWORD;
    verInfo: Pointer;
    verValue: PVSFixedFileInfo;
    V1,V2: WORD;
begin
   if not IsVista then
   begin
     result:=false;
     exit;
   end;
   verInfoSize:= GetFileVersionInfoSize('comctl32.dll', Dummy);
   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo('comctl32.dll', 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
   with VerValue^ do begin
      V1:= dwFileVersionMS shr 16;
      V2:= dwFileVersionMS and $FFFF;
   end;
   result:= (v1>=5) and (v2>=82) or (v1>=6);
   FreeMem(VerInfo, VerInfoSize);
end;

{ 8/25/98 - Return true if vcldb40 is Delphi 4 Patch 2 or later }
{$ifdef wwDelphi4Up}
function UpdatedVCL4Version: boolean;
var dummy: DWORD;
    verInfoSize, verValueSize: DWORD;
    verInfo: Pointer;
    verValue: PVSFixedFileInfo;
    V3,V4: WORD;
begin
   verInfoSize:= GetFileVersionInfoSize('vcldb40.bpl', Dummy);
   if VerInfoSize = 0 then
   begin
      Dummy:= GetLastError;
      result:= True;
      exit;
   end;

   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo('vcldb40.bpl', 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
   with VerValue^ do begin
      V3:= dwFileVersionLS shr 16;
      V4:= dwFileVersionLS and $FFFF
   end;
   result:= (v3>=5) and (v4>=104);
   FreeMem(VerInfo, VerInfoSize);

end;
{$endif}

function wwIsCustomEditCell(
        Component: TComponent;
        ownerForm: TComponent;
        curField: TField;
        var customEdit: TWinControl) : boolean;
var i: integer;
    parts : TStrings;
    controlType: TStrings;
begin
   result:= False;
   if ownerForm=nil then exit;
   if curField=nil then exit;

   parts:= TStringList.create;

   controlType:= nil; { 6/22/99 - ADO datasets store in component, not dataset }
   if wwGetControlInfoInDataSet(Component) then
      controlType:= wwGetControlType(curfield.dataset);
   if controlType=nil then
      controlType:= wwGetControlType(Component);

   for i:= 0 to controlType.count-1 do begin
      strBreakapart(controlType[i], ';', parts);
      if parts.count<2 then continue;
      if not wwEqualStr(parts[0], curField.FieldName) then continue;
      if isWWEditControl(parts[1]) or (parts[1]='RichEdit') then begin
         component:= OwnerForm.FindComponent(parts[2]);
         if (component<>Nil) and (component is TWinControl) then
         begin
            customEdit:= TWinControl(component);
            if customEdit=Nil then break;
            result:= True;
         end;
         break;
      end
   end;

   parts.free;
end;

function IsInGrid(dtp:TWinControl):boolean;
begin
  result := False;
  if dtp.Parent = nil then exit;
  if wwisClass(dtp.Parent.classType, 'TCustomGrid') then
     result := True;
end;

function IsInGridPaint(dtp:TWinControl):boolean;
begin
  result := False;
  if dtp.Parent = nil then exit;
  if wwisClass(dtp.Parent.classType, 'TCustomGrid') then
     if csPaintCopy in dtp.ControlState then
        result := True;
end;

function IsInwwObjectViewPaint(control: TWinControl):boolean;
begin
  result := False;
  if control.Parent = nil then exit;
  if wwisClass(control.Parent.classType, 'TwwDataInspector') then
     if csPaintCopy in control.ControlState then
        result := True;
end;

function IsInwwGridPaint(control: TWinControl):boolean;
begin
  result := False;
  if control.Parent = nil then exit;
  if wwisClass(control.Parent.classType, 'TwwCustomDBGrid') then
     if csPaintCopy in control.ControlState then
        result := True;
end;

function IsInwwObjectView(control: TWinControl):boolean;
begin
  result := False;
  if control.Parent = nil then exit;
  if wwisClass(control.Parent.classType, 'TwwDataInspector') then
     result := True;
end;

procedure wwDottedLine(Canvas: TCanvas; p1, p2: TPoint);
var i: integer;
    x, y: integer;
    tot: integer;
begin
  Canvas.Refresh;
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

procedure wwSetTableIndex(
   DataSet: TDataSet; FieldName: string);
var indexDef: TIndexDef;
    indexDefs: TIndexDefs;
begin
   if wwGetIndexDefs(Dataset, IndexDefs) then
   begin
      IndexDefs.Update;
      indexDef:=
         IndexDefs.GetIndexForFields(FieldName, False);
      if indexDef=nil then
         indexDef:=
            IndexDefs.GetIndexForFields(FieldName, True);
      if indexdef<>nil then wwSetIndexName(dataset, indexDef.Name)
      else begin // 9/19/12
         if wwIsClientCursor(DataSet) then
            wwDataSetSort(DataSet, FieldName, false, false);
      end;
   end;
end;

function wwGetIndexForFields(dataset: TDataSet; const Fields: string;
  CaseInsensitive: Boolean; ascending: boolean=true): TIndexDef;
var
  Exact: Boolean;
  I, L: Integer;
  foundIndex: boolean;
  indexDefs: TIndexDefs;
begin
  wwGetIndexDefs(dataset, indexDefs);
  if indexdefs=nil then begin
    result:=nil;
    exit;
  end;

  with IndexDefs do begin
 // Update;  // This loses the design time indexdefs
  L := Length(Fields);
  Exact := True;
  while True do
  begin
    for I := 0 to Count - 1 do
    begin
      Result := Items[I];
      if ascending then
         foundIndex:= (Result.Options * [ixDescending, ixExpression] = [])
      else
         foundIndex:= (Result.Options * [ixDescending, ixExpression] = [ixDescending]);
      if foundIndex and
      //if (Result.Options * [ixDescending, ixExpression] = []) and
        (not CaseInsensitive or (ixCaseInsensitive in Result.Options)) then
        if Exact then
          if AnsiCompareText(Fields, Result.Fields) = 0 then Exit
          else { not exact match }
        else
          if (AnsiCompareText(Fields, Copy(Result.Fields, 1, L)) = 0) and
            ((Length(Result.Fields) = L) or
            (Result.Fields[L + 1] = ';')) then Exit;
    end;
    if not Exact then Break;
    Exact := False;
  end;
  Result := nil;
  end;
end;

function wwGetThemedTextColor(var ThemeTextColor: TColor): boolean;
var Details: TThemedElementDetails;
begin
   result:= false;
   if StyleServices.Enabled then
   begin
     Details := StyleServices.GetElementDetails(teEditTextNormal);
     if StyleServices.GetElementColor(Details, ecTextColor, ThemeTextColor) then
       result := true;
   end;
end;

procedure wwDrawThemedText(
   ACanvas: TCanvas; s: String; R: TRect; Flags: Cardinal; Theme: TThemedEdit = teEditTextNormal);
var Details: TThemedElementDetails;
    Flags2: TTextFormatFlags;
begin
   if StyleServices.Enabled then
   begin
     Details := StyleServices.GetElementDetails(theme);
     Flags2:= Flags;
//     Flags2:= Flags2 + TTextFormats.tfNoClip;
     StyleServices.DrawText(ACanvas.Handle, Details, S, R, Flags2);
   end
   else
     DrawText(ACanvas.Handle, S, length(S), R, Flags);
end;


procedure wwDrawThemedTitleText(
   ACanvas: TCanvas; s: String; R: TRect; Flags: Cardinal);
var Details: TThemedElementDetails;
    Flags2: TTextFormatFlags;
begin
   if StyleServices.Enabled then
   begin
     Flags2:= Flags;
     Details := StyleServices.GetElementDetails(tgFixedCellNormal);
     StyleServices.DrawText(ACanvas.Handle, Details, S, R, Flags2); //, ACanvas.Font.Color);
   end
   else
     DrawText(ACanvas.Handle, S, length(S), R, Flags);
end;


Procedure wwWriteTextLinesT(ACanvas: TCanvas;
    const ARect: TRect; DX, DY: Integer; S: PChar; Alignment: TAlignment;
    WriteOptions: TwwWriteTextOptions);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX );
var
  B, R: TRect;
  Flags: integer;
  ADrawCanvas: TCanvas;
  NonWideStr: String;
begin
    ADrawCanvas:= ACanvas;

    with ARect do { Use offscreen bitmap to eliminate flicker and }
    begin                     { brush origin tics in painting / scrolling.    }
      if Alignment=taRightJustify then
         R := Rect(DX, DY, Right - Left -2, Bottom - Top - 1) { 7/10/98 - Make width 1 less }
      else if Alignment=taLeftJustify then
         R := Rect(DX, DY, Right - Left, Bottom - Top - 1)
      else  {3/31/98 - If CenterJustify then allow DrawText to properly center text}
      begin
         if DX>3 then
            R := Rect(2, DY, Right - Left, Bottom - Top - 1)
         else
            R := Rect(0, DY, Right - Left, Bottom - Top - 1)
      end;
      R.Left:= R.Left + ARect.Left;
      R.Right:= R.Right + ARect.Left;
      R.Top:= R.Top + ARect.Top;
      R.Bottom:= R.Bottom + ARect.Top;
      B := Rect(0, 0, Right - Left, Bottom - Top);
    end;
    with ADrawCanvas do
    begin
      Font := ACanvas.Font;
      Font.Color := ACanvas.Font.Color;
      Brush := ACanvas.Brush;
      Brush.Style := bsSolid;

      if not (wtoTransparent in WriteOptions) then
      begin
         FillRect(ARect);
      end;

      SetBkMode(Handle, TRANSPARENT);
      Flags:= AlignFlags[Alignment];

      if wtoAmpersandToUnderline in WriteOptions then
         Flags:= Flags and (not  DT_NOPREFIX);

      if wtoWordWrap in WriteOptions then
         Flags := Flags or DT_WORDBREAK;

      {6/11/2001 - Added vertical alignment support for single line edit.}
      if wtoCenterVert in WriteOptions then Flags := Flags or DT_VCENTER or DT_SINGLELINE;

      {3/31/98 - Check to see if this is a single line edit control to
       determine if we should or should not have word breaks}
      if wwIsSingleLineEdit(Handle,R,Flags) or (wtoEllipsis in WriteOptions) then
          Flags := Flags and not DT_WORDBREAK;

      if wtoEllipsis in WriteOptions then
         Flags:= Flags or DT_END_ELLIPSIS;  { If text does not fit then put ellipsis at end }

      if (not wwIsCustomStyle(nil)) or (wtoDisableThemes in WriteOptions) then
      begin
        NonWideStr := s;
        DrawText(Handle, PChar(NonWideStr), Length(NonWideStr), R, Flags);
      end
      else
      begin
        if (wtoIsTitle in WriteOptions) then
          wwDrawThemedTitleText(ADrawCanvas, s, R, Flags)
        else begin
          if wtoDisabledText in WriteOptions then
             wwDrawThemedText(ADrawCanvas, s, R, Flags, teEditTextDisabled)
          else
             wwDrawThemedText(ADrawCanvas, s, R, Flags);

        end;
      end;
    end;
end;

function wwRectWidth(Rect: TRect): Integer;
begin
  result := Rect.Right - Rect.Left;
end;

function wwRectHeight(Rect: TRect): Integer;
begin
  result := Rect.Bottom - Rect.Top;
end;
{
procedure wwAdjustHeight(Control: TWinControl);
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, TEdit(Control).Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  if NewStyleControls then
  begin
    if TEdit(Control).Ctl3D then I := 8 else I := 6;
    I := GetSystemMetrics(SM_CYBORDER) * I;
    if TEdit(Control).BorderStyle=bsNone  then i:= 6;
  end else
  begin
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight then I := Metrics.tmHeight;
    I := I div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;
  Control.Height := Metrics.tmHeight + I;
end;

}

{ Parent clipping is required in order to ensure that the background is painted in all cases }
{ For instance, flat transparent buttons do not paint in certain cases if clipchildren is true }
procedure wwDisableParentClipping(Parent: TWinControl);
begin
   SetWindowLong(Parent.Handle, GWL_STYLE,
    GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
end;

function wwIsDesigning(control: TControl): boolean;
var form: TCustomForm;
begin
   form:= GetParentForm(control);
   if form<>nil then
      result:= (csDesigning in form.ComponentState)
   else
      result:=  (csDesigning in control.ComponentState)
end;

  function wwHaveVisibleChild(ac: TWinControl): boolean;  // i.e. Combo dropped down
  var i: integer;
  begin
    result:= False;
    if ac=nil then exit;

    with ac do begin
       for i:= 0 to ControlCount-1 do
       begin
          if Controls[i] is TWinControl then begin
             if not IsWindowVisible(TWinControl(Controls[i]).Handle) then continue;
             // Make sure control is outside edit rect so we don't count button
             if not PtInRect(ac.ClientRect, Point(Controls[i].Left, Controls[i].Top)) then
             begin
                result:=True;
                exit;
             end
          end
       end
    end
  end;

function wwGetEventShift(Shift: TShiftState): Integer;
const
  ShiftMap: array[0..7] of Byte = (0, 1, 4, 5, 2, 3, 6, 7);
begin
  {$ifdef wwDelphi2010Up}
  Result := ShiftMap[Word(Shift) and 7];
  {$else}
//  Result := ShiftMap[Byte(Shift) and 7];
  Result := ShiftMap[Word(Shift) and 7];
  {$endif}
end;

Function wwlimit(val, x,y: integer): integer;
begin
   if val<x then result:=x
   else if val>y then result:= y
   else result:= val;
end;

  procedure wwClearControls(Component: TComponent);
  var i: integer;
      parts: TStringlist;
      customEdit: TComponent;
      OwnerForm: TComponent; //CustomForm;
      controlType: TStrings;
      tempControl: Tcomponent;
  begin
     tempControl:= wwGetControlTypeControl(Component);
     if tempControl<>nil then
         controlType:= wwGetControlType(tempControl)
     else exit;

     parts:= TStringlist.create;
     for i:= 0 to controlType.count-1 do begin
        strBreakapart(controlType[i], ';', parts);
        if parts.count<2 then continue;
        if isWWEditControl(parts[1]) or (parts[1]='RichEdit') then begin
           OwnerForm:= wwGetOwnerFrameOrForm(Component); //5/8/03
           customEdit:= OwnerForm.FindComponent(parts[2]);
           if (customEdit<>Nil) and (CustomEdit is TWinControl) then
           begin
               wwSetControlDataSource(TWinControl(customEdit), nil);
               wwSetControlDataField(TWinControl(customEdit), '');
           end;
        end
     end;
     parts.free;
     controlType.clear;
  end;

  //  First parameter is the text to copy to clipboard.
  //  Second parameter is optional HTML code that can be placed on clipboard.
  procedure wwcopyToClipBoard(const str: string; const htmlStr: string = '');
  var
     gMem: HGLOBAL;
     lp: pchar;
     strings: array[0..1] of string;
     formats: array[0..1] of UINT;
     i: integer;
  begin
     gMem := 0;
     try
     //most descriptive first as per api docs
        strings[0] := format('<!--StartFragment-->%s<!--EndFragment-->', [htmlStr]);
        strings[1] := str;
        formats[0] := RegisterClipboardFormat('HTML Format');
        formats[1] := CF_TEXT;
        try
            for i := 0 to 1 do begin//high(strings) do begin
              if strings[i] = '' then continue;
              //an extra "1" for the null terminator
              gMem := globalalloc(GMEM_DDESHARE + GMEM_MOVEABLE, length(strings[i])+1);
              if gmem = 0 then exit;
              lp := globallock(gMem);
              if lp = nil then exit;
              copymemory(lp, pchar(strings[i]), length(strings[i])+1);
              globalunlock(gMem);
              if gmem = 0 then exit;
              setClipboarddata(formats[i], gMEm);
              if gmem = 0 then exit;
              if gMem <> 0 then
                 globalfree(gmem);
              gmem := 0;
           end;
        finally
           if gMem <> 0 then
              globalfree(gmem);
        end;
     finally
     end;
  end;

function wwGetOrdProp(Component: TPersistent; PropName: string): Integer;
var PropInfo: PPropInfo;
begin
  result := 0;
  PropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if PropInfo <> nil then result := GetOrdProp(Component, PropInfo);
end;

Function wwGetEditCalculated(ctrl: TControl): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'EditCalculated');
   if PropInfo<>Nil then result:= Boolean(GetOrdProp(Ctrl, PropInfo));
end;

Function wwGetDisableThemes(ctrl: TControl): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'DisableThemes');
   if PropInfo<>Nil then result:= Boolean(GetOrdProp(Ctrl, PropInfo));
end;

function wwUseThemes(Control: TControl): boolean;
{$ifdef wwUseThemeManager}
var DisableThemes: boolean;
    PropInfo: PPropInfo;
{$endif}
begin
   {$ifdef wwUseThemeManager}
   result:= StyleServices.Enabled;
   if Control=nil then exit;

   DisableThemes:= False;

   PropInfo:= Typinfo.GetPropInfo(control.ClassInfo,'DisableThemes');
   if PropInfo<>Nil then DisableThemes:= Boolean(GetOrdProp(Control, PropInfo))
   else begin
      if Control.parent=nil then exit;

      PropInfo:= Typinfo.GetPropInfo(Control.parent.ClassInfo,'DisableThemes');
      if PropInfo<>Nil then DisableThemes:= Boolean(GetOrdProp(Control.Parent, PropInfo)) // 7/21/05 - Control.Parent
      else begin // 10/20/04 - Buttons should use parent.parent
         if Control.Parent.Parent=nil then exit;
         PropInfo:= Typinfo.GetPropInfo(Control.parent.parent.ClassInfo,'DisableThemes');
         if PropInfo<>Nil then DisableThemes:= Boolean(GetOrdProp(Control.Parent.Parent, PropInfo));
      end;
   end;
   if DisableThemes then result:= False;
   {$else}
   result:=false;
   {$endif}
end;

Function wwGetControlList(Controller: TComponent): TList;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   if Controller=nil then exit;
   PropInfo:= Typinfo.GetPropInfo(Controller.ClassInfo,'ControlList');
   if PropInfo<>Nil then Result:= TList(GetOrdProp(Controller, PropInfo));
end;

procedure wwUpdateController(
   var FController: TComponent;
   Value: TComponent;
   Control: TComponent);
var OrigController: TComponent;
begin
   OrigController:= FController;

   if Value <> nil then begin
     Value.FreeNotification(Control); // Notify us when controller destroyed
   end;

   if FController<>Value then
   begin
      FController:= Value;
      if FController<>nil then
      begin
//         FFrame.Assign(FController.Frame);
         wwGetControlList(FController).Add(Control);
//         if Control.HandleAllocated then Control.SendMessage(Handle, cm_recreatewnd, 0, 0);
      end
      else begin
         wwGetControlList(OrigController).Remove(Control);
         FController:= nil;
      end
   end
end;

function RegexMatch(pattern: string; icasePattern: boolean; input: string): boolean;
var
    regex: TRegEx;
    regexOptions: TRegExOptions;
begin
    if input='' then begin
      result:= true;
      exit;
    end;

    if icasePattern then
       regexOptions:= [TRegExOption.roIgnoreCase]
    else
       regexOptions:= [];

    regex:= TRegEx.Create(pattern, regexOptions);
    result:= regex.IsMatch(input);
end;

function RegexSyntaxValid(pattern: string): boolean;
var
   regex: TRegEx;
begin
    try
       regex:= TRegEx.Create(pattern);
       result:= true;
    except
       result:=false;
    end;
end;

procedure wwFillEditThemeBackground(
   IsDroppedDown: boolean; MouseInControl: boolean; ARect: TRect; FCanvas: TCanvas);
var Details: TThemedElementDetails;
begin
   if IsDroppedDown then
      Details := StyleServices.GetElementDetails(tbPushButtonPressed)
   else if not MouseInControl then
      Details := StyleServices.GetElementDetails(tbPushButtonNormal)
   else
      Details := StyleServices.GetElementDetails(tbPushButtonHot);
   InflateRect(ARect, 3, 3);
   StyleServices.DrawElement(FCanvas.handle, Details, ARect);
   InflateRect(ARect, -3, -3);
end;

procedure wwFillEditThemeBackgroundDefault(
   ARect: TRect; FCanvas: TCanvas);
var Details: TThemedElementDetails;
begin
   Details := StyleServices.GetElementDetails(tcBackground);
   InflateRect(ARect, 3, 3);
   StyleServices.DrawElement(FCanvas.handle, Details, ARect);
   InflateRect(ARect, -3, -3);
end;

procedure wwSetToIndexContainingField(LookupTable: TDataSet; fieldName: string);
type
   TSetToIndexContainingFieldFunc =
     function (
        fieldName: string): boolean of object;
var
   method: TMethod;
begin
   if wwIsClass(lookupTable, 'TwwTable') then begin
      method.Data := LookupTable; // object reference
      method.Code := LookupTable.MethodAddress('setToIndexContainingField');
      TSetToIndexContainingFieldFunc(method)(fieldName);
   end;
end;

// From ipstudio.net library
function wwGetIndexName(DataSet: TDataSet): string;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'IndexName');
   if PropInfo<>Nil then Result:= GetStrProp(DataSet, PropInfo);
end;

function wwGetIndexFieldName(table: TDataSet): string;
var indexFlds: string;
    curpos: integer;
    ActiveIndexDef: TIndexDef;
begin
    curpos:= 1;
    indexFlds:= wwGetIndexFieldNames(table);
    if indexFlds='' then
    begin
       if wwDataSetActiveIndexDef(table, ActiveIndexDef) then
       begin
          result:= ActiveIndexDef.Fields;
          result:= strGetToken(result, ';', curpos);  // Just return 1st field
       end
       else result:= ''
    end
    else result:= strGetToken(indexFlds, ';', curpos);
end;


function wwGetIndexFieldNames(DataSet: TDataSet): String;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'IndexFieldNames');
   if PropInfo<>Nil then Result:= GetStrProp(DataSet, PropInfo);

   // Maybe should always do this
   //if (wwIsClass(dataset.classType, 'TADOTable') or wwIsClass(dataset.classType, 'TADODataSet')) then
   begin
      // Strip brackets
      StrRemoveChar(result, ']');
      StrRemoveChar(result, '[');
   end;
end;

function wwDataSetIsCaseSensitiveIndex(Dataset: TDataSet): boolean;
var IndexDefs: TIndexDefs;
    i: integer;
    IndexFieldNames: string;
    IndexName: string;
    caseSensitive: boolean;
begin
  result:= False;
  CaseSensitive:= true;

  if wwGetIndexDefs(DataSet, IndexDefs) then
  begin
     IndexFieldNames:= wwGetIndexFieldNames(DataSet);
     IndexName:= wwGetIndexName(DataSet);

     for i:= 0 to IndexDefs.count-1 do begin
        if IndexFieldNames='' then
        begin
          if (Uppercase(IndexDefs.Items[i].Name)=UpperCase(IndexName)) then
          begin
            if CaseSensitive xor (ixCaseInsensitive in IndexDefs.Items[i].Options) then
            begin
               result:= True;
               break;
            end
          end
        end
        else begin
          //if (Uppercase(IndexDefs.Items[i].Name)=UpperCase(IndexName)) then
          if pos(UpperCase(IndexFieldNames), Uppercase(IndexDefs.Items[i].Fields))=1 then // 8/22/09
          begin
            if CaseSensitive xor (ixCaseInsensitive in IndexDefs.Items[i].Options) then
            begin
               result:= True;
               break;
            end
          end
        end
     end

  end

end;

function wwDataSetIsValidIndexField(Dataset: TDataSet; FieldName: string; CaseSensitive: boolean): boolean; overload;
var IndexName: string;
begin
  result:= wwDataSetIsValidIndexField(Dataset, FieldName, CaseSensitive, IndexName);
end;

function wwDataSetIsValidIndexField(Dataset: TDataSet; FieldName: string; CaseSensitive: boolean; var IndexName: string): boolean; overload;
var IndexDefs: TIndexDefs;
    i: integer;
    IndexFieldNames: string;
begin
  result:= False;

  if wwGetIndexDefs(DataSet, IndexDefs) then
  begin
     IndexFieldNames:= wwGetIndexFieldNames(DataSet);
     IndexName:= wwGetIndexName(DataSet);

     for i:= 0 to IndexDefs.count-1 do begin
        if IndexFieldNames='' then
        begin
          if (Uppercase(IndexDefs.Items[i].Name)=UpperCase(IndexName)) then
          begin
            if CaseSensitive xor (ixCaseInsensitive in IndexDefs.Items[i].Options) then
            begin
               result:= True;
               break;
            end
          end
        end
        else begin
          //if (Uppercase(IndexDefs.Items[i].Name)=UpperCase(IndexName)) then
          if pos(UpperCase(IndexFieldNames), Uppercase(IndexDefs.Items[i].Fields))=1 then // 8/22/09
          begin
            if CaseSensitive xor (ixCaseInsensitive in IndexDefs.Items[i].Options) then
            begin
               result:= True;
               break;
            end
          end
        end
     end

  end
end;

function wwDataSetActiveIndexDef(Dataset: TDataSet; var ActiveIndexDef: TIndexDef): boolean;
var IndexDefs: TIndexDefs;
//    IndexDef: TIndexDef;
    i: integer;
    IndexFieldNames, IndexName: string;
    //ignoreDescending: boolean;
begin
  result:= False;
  if DataSet=nil then exit;
  //ignoreDescending:= wwGetIndexFieldNames(DataSet)<>'';

  if wwGetIndexDefs(DataSet, IndexDefs) then
  begin
     IndexFieldNames:= wwGetIndexFieldNames(DataSet);
     IndexName:= wwGetIndexName(DataSet);

     for i:= 0 to IndexDefs.count-1 do begin
        if IndexFieldNames='' then
        begin
          if (Uppercase(IndexDefs.Items[i].Name)=UpperCase(IndexName)) then
          begin
             ActiveIndexDef:= IndexDefs[i];
             result:= True;
             break;
          end
        end
        else begin
          //if (Uppercase(IndexDefs.Items[i].Name)=UpperCase(IndexName)) then
          if pos(UpperCase(IndexFieldNames), Uppercase(IndexDefs.Items[i].Fields))=1 then // 8/22/09
          begin
             if ixDescending in IndexDefs.Items[i].Options then continue; // 8/31/09 - If IndexFieldNames assigned, can't be descending
             ActiveIndexDef:= IndexDefs[i];
             result:= True;
             break;
          end
        end
     end

  end
end;


function wwGetIndexFieldCount(dataset: TDataSet): integer;
var ActiveIndex: TIndexDef;
    tokens: TStrings;
begin
   result:=0;

   if wwDataSetActiveIndexDef(DataSet, ActiveIndex) then
   begin
      if ActiveIndex.Fields='' then exit;

      tokens:= TStringlist.create;
      try
        strBreakApart(ActiveIndex.Fields, ';', tokens);
        result:= tokens.count;
      finally
        tokens.Free;
      end;
   end;
end;

Function wwGetSearchIndex(DataSet: TDataSet; SearchField: string): integer;
var i, SearchIndex: integer;
    ActiveIndex: TIndexDef;
    tokens: TStringList;
begin
   if not wwHasIndex(DataSet) then
   begin
      result:= -1;
      exit;
   end;
   SearchIndex:= 0;
   if SearchField<>'' then begin
      searchIndex:= -1; {1/22/97}
      if wwDataSetActiveIndexDef(DataSet, ActiveIndex) then
      begin
         tokens:= TStringlist.create;
         try
           strBreakApart(ActiveIndex.Fields, ';', tokens);
           for i:= 0 to tokens.count-1 do
             if (lowercase(SearchField)=lowercase(tokens[i])) then
             begin
                SearchIndex:= i;
                break;
             end
         finally
           tokens.Free;
         end;
      end
   end;
   result:= SearchIndex;
end;

Function wwGetIndexFields(DataSet: TDataSet; Index: Integer): TField;
var ActiveIndex: TIndexDef;
    tokens: TStringList;
begin
   if wwDataSetActiveIndexDef(DataSet, ActiveIndex) then
   begin
      tokens:= TStringlist.create;
      try
        strBreakApart(ActiveIndex.Fields, ';', tokens);
        result:= DataSet.FindField(tokens[Index]);
      finally
        tokens.Free;
      end
   end
   else result:= nil;
end;

Procedure wwSetIndexName(DataSet: TDataSet; val: string);
var PropInfo: PPropInfo;
begin
    PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'IndexName');
    if PropInfo<>Nil then
       SetStrProp(dataset,PropInfo, val);
end;

function wwDataSetIsDescendingIndex(Dataset: TDataSet): boolean;
var IndexDefs: TIndexDefs;
    i: integer;
    IndexFieldNames: string;
    IndexName: string;
    //caseSensitive: boolean;
begin
  result:= false;
  //CaseSensitive:= true;

  if wwGetIndexDefs(DataSet, IndexDefs) then
  begin
     IndexFieldNames:= wwGetIndexFieldNames(DataSet);
     IndexName:= wwGetIndexName(DataSet);

     for i:= 0 to IndexDefs.count-1 do begin
        if IndexFieldNames='' then
        begin
          if (Uppercase(IndexDefs.Items[i].Name)=UpperCase(IndexName)) then
          begin
            if (ixDescending in IndexDefs.Items[i].Options) then
            begin
               result:= True;
               break;
            end
          end
        end
        else begin
           continue; // 8/31/09 - If IndexFieldNames assigned, can't be descending
        end
     end

  end

end;


procedure wwDataSetSort(DataSet: TDataSet; FieldName: string; descending: boolean; createIndexes: boolean);
var
  indexDef: TIndexDef;
  indexDefs: TIndexDefs;
  curField: TField;
  masterfields: string;
  PropInfo: PPropInfo;
begin
  if dataset=nil then exit;
  curField:= DataSet.FindField(fieldName);
  if curField=nil then exit;


  if curfield is TBlobField then
    exit;
  if curfield = nil then
    exit;

  // 9/15/11 - add mastersource field to index fields in case we are a dependent clientdataset with masterfields assigned
  MasterFields := '';
  PropInfo:= Typinfo.GetPropInfo(Dataset.ClassInfo,'MasterFields');
  if (PropInfo<>nil) then
  begin
     MasterFields := GetStrProp(Dataset, PropInfo);
     if (MasterFields <> '') then
        fieldName := MasterFields + ';' + fieldName;
  end;

  if descending then begin
  indexDef := wwGetIndexForFields(dataset, fieldName, true, false);
  if indexDef = nil then
    indexDef := wwGetIndexForFields(dataset, fieldName, false, false);
  if indexDef <> nil then
    wwSetIndexName(dataset, indexDef.Name)
  else
  begin
    if createIndexes then
    begin
      if wwGetIndexDefs(dataset, indexDefs) then
      begin
        indexDefs.Update;
        indexDefs.Add('w2w' + fieldName, fieldName, [ixDescending,
          ixCaseInsensitive]);
        wwSetIndexName(dataset, 'w2w' + fieldName);
      end;
    end;

  end;
  end
  else begin // ascending
 if (wwGetIndexFieldNames(dataset) <> fieldName) then
  begin

    indexDef := wwGetIndexForFields(dataset, fieldName, true, true);
    if indexDef = nil then
      indexDef := wwGetIndexForFields(dataset, fieldName, false, true);
    if indexDef <> nil then
      wwSetIndexName(dataset, indexDef.Name)
    else
      wwSetIndexFieldNames(dataset, fieldName);
  end;
  end;


end;

function wwIsCustomStyle(control: TControl): boolean;
begin
  if control=nil then
     wwIsCustomStyle := TStyleManager.IsCustomStyleActive
  else
     wwIsCustomStyle := TStyleManager.IsCustomStyleActive and wwUseThemes(control);
end;

procedure wwPaintActiveGridCellBackgroundColor(Control: TControl; Canvas: TCanvas);
begin
  wwPaintActiveGridCellBackgroundColor(Control, Canvas, Control.ClientRect);
end;

procedure wwPaintActiveGridCellBackgroundColor(Control: TControl; Canvas: TCanvas; PaintRect: TRect);
var
  LColor: TColor;
  r: TRect;
begin
  if Canvas=nil then exit;

  r:= PaintRect;
  Canvas.Brush.Style := TBrushStyle.bsSolid;
  Canvas.Brush.Color := StyleServices.GetStyleColor(scGrid);
  Canvas.FillRect(r);

  StyleServices.DrawElement(Canvas.Handle,
    StyleServices.GetElementDetails(tgCellSelected), r, r);
  if not StyleServices.GetElementColor
    (StyleServices.GetElementDetails(tgCellSelected), ecTextColor, LColor) or
    (LColor = clNone) then
    LColor := clHighlightText;

  Canvas.Font.Color := LColor;
  Canvas.Brush.Style := bsClear;
end;



procedure wwPaintGridCellBackgroundColor(Control: TControl; Canvas: TCanvas; PaintRect: TRect);
var
  LDetails: TThemedElementDetails;
  AColor, LColor: TColor;
begin
  LDetails := StyleServices.GetElementDetails(tgCellNormal);
  AColor:= Canvas.Brush.Color;
  if StyleServices.GetElementColor(LDetails, ecFillColor, LColor) and (LColor <> clNone) then
  begin
    AColor := LColor;
  end;
  Canvas.Brush.Color := AColor;
  Canvas.FillRect(PaintRect);
end;

procedure wwPaintFixedGridCellBackgroundColor(Control: TControl; Canvas: TCanvas; PaintRect: TRect);
var
  LColor: TColor;
  r: TRect;
begin
  r:= PaintRect;
  Canvas.Brush.Style := TBrushStyle.bsSolid;
  Canvas.Brush.Color := StyleServices.GetStyleColor(scGrid);
  Canvas.FillRect(r);

  StyleServices.DrawElement(Canvas.Handle,
    StyleServices.GetElementDetails(tgFixedCellNormal), r, r);
  if not StyleServices.GetElementColor
    (StyleServices.GetElementDetails(tgFixedCellNormal), ecTextColor, LColor) or
    (LColor = clNone) then
    LColor := clHighlightText;

  Canvas.Font.Color := LColor;
  Canvas.Brush.Style := bsClear;
end;

function wwSize(cx, cy: Integer): TSize;
begin
  result.cx := cx;
  result.cy := cy;
end;

procedure wwAdjustFlag(Condition: Boolean; var Flag: UINT; FlagVal: UINT);
begin
  if Condition then Flag := Flag or FlagVal
  else Flag := Flag and not FlagVal;
end;

function wwStripAmpersands(Value: string): string;
begin
  result := strReplace(Value, '&&', #0);
  result := strReplace(result, '&', '');
  result := strReplace(result, #0, '&');
end;

function wwCountTokens(s, Delimiter: string): integer;
var i: integer;
begin
  result := 0;
  if length(s) > 0 then result := 1;
  for i := 1 to Length(s) do
    if Copy(s, i, Length(Delimiter)) = Delimiter then inc(result);
end;

function wwMultiLineTextSize(Canvas: TCanvas; Text: string; LineSpacing: Integer;
  MaxWidth: Integer; DrawFlags: Integer): TSize;
var i: Integer;
    s: string;
    TokenCount: Integer;
    r: TRect;
begin
  TokenCount := wwCountTokens(Text, #13#10);
  result := wwSize(0, 0);

  for i := 0 to TokenCount - 1 do
  begin
    s := wwGetToken(Text, #13#10, i);
    if MaxWidth = 0 then
    begin
      inc(result.cy, Canvas.TextHeight(s));
      if Canvas.TextWidth(s) > result.cx then result.cx := Canvas.TextWidth(s);
    end else begin
      r := Rect(0, 0, MaxWidth, 0);
      DrawTextEx(Canvas.Handle, PChar(s), Length(s), r, DrawFlags or DT_CALCRECT, nil);
      inc(result.cy, wwRectHeight(r));
      if wwRectWidth(r) > result.cx then result.cx := wwRectWidth(r);
    end;
    if i < TokenCount - 1 then inc(result.cy, LineSpacing);
  end;
end;

function wwThisThat(const Clause: Boolean; TrueVal, FalseVal: Integer): Integer;
begin
  if Clause then result := TrueVal else Result := FalseVal;
end;


function wwLineHeight(Canvas: TCanvas; Flags: Integer; MaxWidth: Integer; Line: string): Integer;
var r: TRect;
begin
  r := Rect(0, 0, MaxWidth, 0);
  DrawTextEx(Canvas.Handle, PChar(Line), Length(Line), r, Flags or DT_CALCRECT, nil);
  result := wwRectHeight(r);
end;

{Gets the Byte Values for a color independent of order of Color}
procedure wwColorToByteValues(AColor: TColor; var Reserved, Blue, Green, Red: Byte);
var WinColor: COLORREF;
begin
  WinColor := ColorToRGB(AColor);
  Reserved := ($FF000000 and WinColor) Shr 24;
  Blue := ($00FF0000 and WinColor) Shr 16;
  Green := ($0000FF00 and WinColor) Shr 8;
  Red := ($000000FF and WinColor);
end;


procedure wwCalcButtonLayout(TopLeft: TPoint; TextRect, GlyphRect: PRect;
  TextSize, GlyphSize: TSize; Layout: TButtonLayout;
  Spacing: Integer);

  function GetPoint(OffsetX: TwwPointSets; OffsetY: TwwPointSets;
    OffsetSize: TSize): TPoint;
  begin
    result := Point(
      TopLeft.x - (GlyphSize.cx * ord(psGlyph in OffsetX) +
        TextSize.cx * ord(psText in OffsetX) +
        Spacing * ord([psGlyph, psText] * OffsetX = [psGlyph, psText])) div 2 +
        ord(psOffset in OffsetX) * (OffsetSize.cx + Spacing),
      TopLeft.y - ((GlyphSize.cy + 1) * ord(psGlyph in OffsetY) +
        TextSize.cy * ord(psText in OffsetY) +
        Spacing * ord([psGlyph, psText] * OffsetY = [psGlyph, psText])) div 2 +
        ord(psOffset in OffsetY) * (OffsetSize.cy + Spacing)
    );
  end;
  procedure SetPoints(OffsetTX: TwwPointSets; OffsetTY: TwwPointSets;
    OffsetGX: TwwPointSets; OffsetGY: TwwPointSets);
  begin
    if TextRect <> nil then with GetPoint(OffsetTX, OffsetTY, GlyphSize) do
      TextRect^ := Rect(x, y, x + TextSize.cx, y + TextSize.cy);
    if GlyphRect <> nil then with GetPoint(OffsetGX, OffsetGY, TextSize) do
      GlyphRect^ := Rect(x, y, x + GlyphSize.cx, y + GlyphSize.cy);
  end;
begin
  if (GlyphSize.cy=0) or (GlyphSize.cx=0) then Spacing := (Spacing-6) div 2; { 4/14/99 - RSW - Center text if no image } {??? why "6"? -ksw}

  case Layout of
    blGlyphLeft: SetPoints([psGlyph, psText, psOffset], [psText], [psGlyph, psText], [psGlyph]);
    blGlyphTop: SetPoints([psText], [psGlyph, psText, psOffset], [psGlyph], [psGlyph, psText]);
    blGlyphRight: SetPoints([psGlyph, psText], [psText], [psGlyph, psText, psOffset], [psGlyph]);
    blGlyphBottom: SetPoints([psText], [psGlyph, psText], [psGlyph], [psGlyph, psText, psOffset]);
  end;
end;

procedure wwCreateDisabledBitmap(SrcBm, DstBm: TBitmap);
const ROP_DSPDxax = $00E20746;
var AMonoBitmap: TBitmap;
    ARect: TRect;
    AWidth, AHeight: Integer;
begin
  AMonoBitmap := TBitmap.Create;
  with AMonoBitmap do
  begin
    Monochrome := True;
    Width := SrcBm.Width;
    Height := SrcBm.Height;
  end;
  AWidth := SrcBm.Width;
  AHeight := SrcBm.Height;
  ARect := Rect(0, 0, AWidth, AHeight);

  if DstBm.Width <> SrcBm.Width then DstBm.Width := SrcBm.Width;
  if DstBm.Height <> SrcBm.Height then DstBm.Height := SrcBm.Height;

  try
    with AMonoBitmap do
    begin
      Assign(SrcBm);
      HandleType := bmDDB;
      Canvas.Brush.Color := clBlack;
      Width := SrcBm.Width;
      if Monochrome then
      begin
        Canvas.Font.Color := clWhite;
        Monochrome := False;
        Canvas.Brush.Color := clWhite;
      end;
      Monochrome := True;
    end;
    with DstBm.Canvas do
    begin
      Brush.Color := clBtnFace;
      FillRect(ARect);
      Brush.Color := clBtnHighlight;
      SetTextColor(Handle, clBlack);
      SetBkColor(Handle, clWhite);
      BitBlt(Handle, 1, 1, AWidth, AHeight, AMonoBitmap.Canvas.Handle, 0, 0, ROP_DSPDxax);
      Brush.Color := clBtnShadow;
      SetTextColor(Handle, clBlack);
      SetBkColor(Handle, clWhite);
      BitBlt(Handle, 0, 0, AWidth, AHeight, AMonoBitmap.Canvas.Handle, 0, 0, ROP_DSPDxax);
    end;
  finally
    AMonoBitmap.Free;
  end;
end;

procedure wwImageListDraw(ImageList: TCustomImageList; Index: Integer; Canvas: TCanvas;
  X, Y: Integer; Style: Cardinal; Enabled: Boolean);
const
  ROP_DSPDxax = $00E20746;
var
  R: TRect;
  DestDC, SrcDC: HDC;
  function GetRGBColor(Value: TColor): DWORD;
  begin
    Result := ColorToRGB(Value);
    case Result of
      clNone: Result := CLR_NONE;
      clDefault: Result := CLR_DEFAULT;
    end;
  end;
var AMonoBitmap: TBitmap;
begin
  with ImageList do
  begin
    if HandleAllocated then
    begin
      if Enabled then
         ImageList_DrawEx(Handle, Index, Canvas.Handle, X, Y, 0, 0,
            GetRGBColor(TImageList(ImageList).BkColor), GetRGBColor(TImageList(ImageList).BlendColor), Style)
      else
      begin
        AMonoBitmap := TBitmap.Create;
        with AMonoBitmap do
        begin
          Monochrome := True;
          Width := TImageList(ImageList).Width;
          Height := TImageList(ImageList).Height;
        end;

        { Store masked version of image temporarily in FBitmap }
        ImageList_DrawEx(Handle, Index, AMonoBitmap.Canvas.Handle, 0,0,0,0, 0,0,
          ILD_MASK);
        R := Rect(X, Y, X+TImageList(ImageList).Width, Y+TImageList(ImageList).Height);
        SrcDC := AMonoBitmap.Canvas.Handle;
        { Convert Black to clBtnHighlight }
        Canvas.Brush.Color := clBtnHighlight;
        DestDC := Canvas.Handle;
        Windows.SetTextColor(DestDC, clWhite);
        Windows.SetBkColor(DestDC, clBlack);
        BitBlt(DestDC, X+1, Y+1, TImageList(ImageList).Width, TImageList(ImageList).Height, SrcDC, 0, 0, ROP_DSPDxax);
        { Convert Black to clBtnShadow }
        Canvas.Brush.Color := clBtnShadow;
        DestDC := Canvas.Handle;
        Windows.SetTextColor(DestDC, clWhite);
        Windows.SetBkColor(DestDC, clBlack);
        BitBlt(DestDC, X, Y, TImageList(ImageList).Width, TImageList(ImageList).Height, SrcDC, 0, 0, ROP_DSPDxax);
        AMonoBitmap.Free;
      end;
    end;
  end;
end;

procedure wwImageListDrawFixBug(ImageList: TCustomImageList; Index: Integer; Canvas: TCanvas;
  X, Y: Integer; Style: Cardinal; Enabled: Boolean);
const
  ROP_DSPDxax = $00E20746;
var
  R: TRect;
  DestDC, SrcDC: HDC;
  function GetRGBColor(Value: TColor): DWORD;
  begin
    Result := ColorToRGB(Value);
    case Result of
      clNone: Result := CLR_NONE;
      clDefault: Result := CLR_DEFAULT;
    end;
  end;
var AMonoBitmap: TBitmap;
begin
  with ImageList do
  begin
    if HandleAllocated then
    begin
      if Enabled then
        if odd(x) then
          ImageList_DrawEx(Handle, Index, Canvas.Handle, X-1, Y, 0, 0, //ImageList.Width, ImageList.Height,
          GetRGBColor(TImageList(ImageList).BkColor), GetRGBColor(TImageList(ImageList).BlendColor), Style)
        else
          ImageList_DrawEx(Handle, Index, Canvas.Handle, X, Y, 0, 0,
          GetRGBColor(TImageList(ImageList).BkColor), GetRGBColor(TImageList(ImageList).BlendColor), Style)
      else
      begin
        AMonoBitmap := TBitmap.Create;
        with AMonoBitmap do
        begin
          Monochrome := True;
          Width := TImageList(ImageList).Width;
          Height := TImageList(ImageList).Height;
        end;

        { Store masked version of image temporarily in FBitmap }
        ImageList_DrawEx(Handle, Index, AMonoBitmap.Canvas.Handle, 0,0,0,0, 0,0,
          ILD_MASK);
        R := Rect(X, Y, X+TImageList(ImageList).Width, Y+TImageList(ImageList).Height);
        SrcDC := AMonoBitmap.Canvas.Handle;
        { Convert Black to clBtnHighlight }
        Canvas.Brush.Color := clBtnHighlight;
        DestDC := Canvas.Handle;
        Windows.SetTextColor(DestDC, clWhite);
        Windows.SetBkColor(DestDC, clBlack);
        BitBlt(DestDC, X+1, Y+1, TImageList(ImageList).Width, TImageList(ImageList).Height, SrcDC, 0, 0, ROP_DSPDxax);
        { Convert Black to clBtnShadow }
        Canvas.Brush.Color := clBtnShadow;
        DestDC := Canvas.Handle;
        Windows.SetTextColor(DestDC, clWhite);
        Windows.SetBkColor(DestDC, clBlack);
        BitBlt(DestDC, X, Y, TImageList(ImageList).Width, TImageList(ImageList).Height, SrcDC, 0, 0, ROP_DSPDxax);
        AMonoBitmap.Free;
      end;
    end;
  end;
end;

function wwModifyColor(Color: TColor; Amount: Integer; Percent: Boolean): TColor;
var Colors: TRGBQuad;
  function HighestOthers(Value: PByte): Byte;
  begin
    with Colors do
    begin
      result := 0;
      if Value = @rgbBlue then result := wwMax(rgbRed, rgbGreen)
      else if Value = @rgbRed then result := wwMax(rgbBlue, rgbGreen)
      else if Value = @rgbGreen then result := wwMax(rgbRed, rgbBlue);
    end;
  end;
  function Check(Value: Integer): Byte;
  begin
    result := Value;
    if Value < 0 then result := 0;
    if Value > 255 then result := 255;
  end;
  procedure DoChange(Value: PByte);
  begin
    if (Value^ = 0) and (HighestOthers(Value) = 255) and (Amount > 0) then
    begin
      if Percent then Value^ := Check(255 * Amount div 100)
      else Value^ := Check(Amount);
    end else begin
      if Percent then
      begin
        if Amount > 0 then Value^ := Check(Value^ + (255 - Value^) * Amount div 100)
        else Value^ := Check(Value^ + Value^ * Amount div 100);
      end else Value^ := Check(Value^ + Amount);
    end;
  end;
begin
  with Colors do
  begin
    wwColorToByteValues(Color, rgbReserved, rgbBlue, rgbGreen, rgbRed);
    DoChange(@rgbRed);
    DoChange(@rgbBlue);
    DoChange(@rgbGreen);
    result := RGB(rgbRed, rgbGreen, rgbBlue);
  end;
end;

function wwGetCursorPos: TPoint;
begin
  GetCursorPos(result);
end;

function wwGetDitherBrush: HBRUSH;
var hatchPattern: array[0..7] of WORD;
    i: Integer;
    hatchBitmap: HBITMAP;
begin
  for i := 0 to 7 do if i mod 2 = 0 then hatchPattern[i] := $AAAA else hatchPattern[i] := $5555;
  hatchBitmap := CreateBitmap(8, 8, 1, 1, @hatchPattern);
  result := CreatePatternBrush(hatchBitmap);
  DeleteObject(hatchBitmap);
end;

procedure wwParentInvalidate(Control: TControl; Erase: Boolean);
var r: TRect;
begin
  r := Control.BoundsRect;
  if Control.Parent <> nil then
    InvalidateRect(Control.Parent.Handle, @r, Erase);
end;

function EnumChildProc(hwnd: HWND; lParam: LPARAM): Boolean; stdcall;
begin
  wwInvalidateChildren(hwnd);
  result := True;
end;

procedure wwInvalidateChildren(Control: HWND);
begin
  InvalidateRect(Control, nil, False);
  EnumChildWindows(Control, @EnumChildProc, 0);
end;


function wwRectEmpty(r: TRect): Boolean;
begin
  result := EqualRect(r, Rect(0, 0, 0, 0));
end;

function wwIntersectRect(R1, R2: TRect): TRect;
begin
  IntersectRect(result, r1, r2);
end;

function wwGetWindowRect(Wnd: HWND): TRect;
begin
  GetWindowRect(Wnd, result);
end;

function InvalidateOverlappedProc(Child: HWND; ARect: PRect): Boolean; stdcall;
begin
  if not wwRectEmpty(wwIntersectRect(ARect^, wwGetWindowRect(Child))) then
    wwInvalidateChildren(Child);
  result := True;
end;

procedure wwInvalidateOverlappedWindows(ParentHwnd: HWND; FirstChild: HWND);
var ControlRect: TRect;
begin
  GetWindowRect(FirstChild, ControlRect);
  EnumChildWindows(ParentHWND, @InvalidateOverlappedProc, Integer(@ControlRect));
end;

function wwRegionFromBitmap(ABitmap: TwwBitmap; TransColor: TColor): HRgn;
type PCOLORREF = ^COLORREF;
var
  Rgn1, Rgn2: HRgn;
  Col, StartCol, Row: integer;
begin
  result := 0;
  if (ABitmap <> nil) and (ABitmap.Width = 0) or (ABitmap.Height = 0) then Exit;
  Rgn1 := 0;

  if TransColor = -1 then TransColor := wwGetStdColor(ABitmap.Pixels[0, 0]);

  with ABitmap do
  begin
    for Row := 0 to Height - 1 do
    begin
      Col := 0;
      while Col < Width do
      begin
        while (Col < Width) and (wwGetStdColor(Pixels[Row, Col]) = TransColor) do
          inc(Col);
        if Col >= Width then Continue;

        StartCol := Col;
        while (Col < Width) and (wwGetStdColor(Pixels[Row, Col]) <> TransColor) do inc(Col);
        if Col >= Width then Col := Width;

        if Rgn1 = 0 then Rgn1 := CreateRectRgn(StartCol, Row, Col, Row + 1)
        else begin
          Rgn2 := CreateRectRgn(StartCol, Row, Col, Row + 1);
          if (Rgn2 <> 0) then CombineRgn(Rgn1,Rgn1,Rgn2,RGN_OR);
            Deleteobject(Rgn2);
        end;
      end;
    end;
  end;
  result := Rgn1;
end;

function wwIsClientCursor(DataSet: TDataSet): boolean;
begin
  result := false;
  if wwIsClass(DataSet.ClassType, 'TClientDataSet') then
    result := true
  else
  begin
    if dataset = nil then
      exit;

    if ((wwGetDatabaseCursorType(dataset) = 1) and
        (wwIsClass(dataset.ClassType, 'TADOTable') or wwIsClass
          (dataset.ClassType, 'TADODataSet'))) then
      result := true
  end;
end;

Function wwGridEssentials: boolean;
begin
  //{$ifdef IPGRIDONLY}
  //result:=true;
  //{$else}
  result:=false;
  //{$endif}
end;

Function wwGridEssentialsDesign: boolean;
begin
  {$ifdef IPGRIDONLY}
  result:=true;
  {$else}
  result:=false;
  {$endif}
end;

var MutexHandle: THandle;

Function wwIsDelphiApp: boolean;
begin
   result:= pos('BDS', uppercase(Application.ExeName))>0;
end;

Function wwIsDelphiIDE: boolean;
begin
   if pos('BDS', uppercase(Application.ExeName))>0 then
      result:= true
   else begin
      MutexHandle:= OpenMutex(MUTEX_ALL_ACCESS, false, 'IPS538C91CD4785DD9');
      if MutexHandle=0 then
      begin
         result:= false;
      end
      else begin
         { Design time so continue }
         CloseHandle(MutexHandle);
         result:=true;
      end;
   end;
end;

var inDisplayProfessionalVersionMsg: boolean;

Procedure DisplayProfessionalMessage(Component: TComponent; msg: string);
var GenericMsg: string;
begin
      GenericMsg:= 'You are using functionality only available in the InfoPower Professional version. ' +
                   'You can still run your application from the IDE, but you will not be able to run your application outside the IDE when ' +
                   'using features exclusive to the professional version.' + #13 + #13 +
                   'The following components are supported by InfoPower Grid Essentials: ' + #13 +
                   'TwwDBGrid, and the following edit controls embedded in the grid: ' + #13 +
                   'TwwDBEdit, TwwDBComboBox, TwwDBComboDlg, TwwDBLookupCombo, TwwDBDateTimePicker, TwwDBSpinEdit, ' + #13 + #13 +
                   'The following components are not supported in InfoPower''s Grid Essentials version and will only run from within the Delphi IDE:' + #13 +
                   '  TwwImageCombo, TwwDBRichEdit, TwwRichEditBar, TwwKeyCombo, TwwIncrementalSearch, TwwMonthCalendar, TwwDBLookupComboDlg' +
                   'TwwDataInspector, TwwRecordViewPanel, TwwController, TwwRecordViewDialog, ' +
                   'TwwFilterDialog, TwwLocateDialog, TwwMemoDialog, TwwSearchDialog, TwwLookupDialog, ' +
                   'TwwDBNavigator, TwwCheckBox, TwwExpandButton, TwwRadioGroup, ' +
                   'TwwDataSource, TwwClientDataSet, TwwTable, TwwQuery, TwwQBE, TwwStoredProc' + #13 + #13 +
                   'In addition, the Essentials grid does not support the following functionality: ' + #13 +
                   '  OnAfterDrawCell, OnBeforeDrawCell, OnCalcCellColors, OnCalcTitleAttributes, OnFieldChanged, OnDrawFooterCell, GroupFieldName, ' + #13 +
                   '  Ditto Capabilities, Regular Expression Masks, Picture Masks, Hierarchical titles, Cell-Level Hints, End-user saving and restoring of field settings, ' + #13 +
                   '  Exporting of data, FixedCols, Expandable Data.';
      wwInternational.EssentialsWarningDisplayed:=true;
      showMessage(msg + #13 + #13 + GenericMsg);
end;

Procedure DisplayProfessionalVersionOnlyMessage(Component: TComponent; msg: string);
begin
   if InDisplayProfessionalVersionMsg then begin
      showmessage('recursive ' + msg);
      exit;
   end;

   try
      InDisplayProfessionalVersionMsg:= true;

      if (Component<>nil) and (csDesigning in Component.ComponentState) then
      begin
      end
      else begin
         if not wwInternational.EssentialsWarningDisplayed then
         begin
            DisplayProfessionalMessage(component, msg);
         end;

        //   'The InfoPower Grid Essentials version does not support InfoPower edit controls outside the context of the grid!');
        if TrialExpired then
           Application.Terminate;

        if not wwIsDelphiIDE then
           Application.Terminate;
      end;

   finally
      InDisplayProfessionalVersionMsg:= false;
   end;
end;

function TrialExpired: boolean;
begin
   result:=false;
end;

{$ifdef IPTRIAL}

initialization
   if pos('BDS', uppercase(Application.ExeName))>0 then exit;

   MutexHandle:= OpenMutex(MUTEX_ALL_ACCESS, false, 'IP2538C91CD4785AA9');
   if MutexHandle=0 then
   begin
      { Abort program }
      MessageDlg('Programs built with the trial version of InfoPower cannot be ' +
           'run outside the Delphi environment!', mtWarning, [mbok], 0);
      Application.Terminate;
   end
   else begin
      { Design time so continue }
      CloseHandle(MutexHandle);
   end;
finalization
{$else}
initialization
finalization
{$endif}

end.
