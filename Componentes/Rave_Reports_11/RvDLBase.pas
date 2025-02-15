{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RvDLBase;

interface

uses
  Windows,
  Forms, SysUtils, Classes, RvDLCommon;

{ Global Table and Field lists used in Rave Designer }

{ Use string list to create global list of table names }
  procedure CreateGlobalTableList(TableNames: TStrings);
{ Deallocate global list of table item records }
  procedure FreeGlobalTableList;
{ Allocate empty global list of table item records }
  procedure AllocGlobalTableList(Count: longint);
{ Assign values to the requested global table item }
  procedure SetGlobalTableItem(Index: longint; TableName: string);
{ Make dynamic copy of error text in global variable }
  procedure SetGlobalErrorText(ErrorText: string);

type
  TDLBaseConnection = class;
  TDLBaseResultSet = class;

  TDLConnectionManager = class
  protected
    FConnectionList: TStringList;
    FID: integer;

    function NextID: integer;
  public
    constructor Create;

    property ConnectionList: TStringList read FConnectionList write FConnectionList;
    function Add(Connection: TDLBaseConnection): integer;
    procedure Delete(ID: integer);
    function Get(ID: integer): TDLBaseConnection;
  end;

  TDLResultSetManager = class
  protected
    FResultSetList: TStringList;
    FID: integer;

    function NextID: integer;
  public
    constructor Create;

    property ResultSetList: TStringList read FResultSetList write FResultSetList;
    function Add(ResultSet: TDLBaseResultSet): integer;
    procedure Delete(ID: integer);
    function Get(ID: integer): TDLBaseResultSet;
  end;

  TDLFieldListManager = class
  protected
    FFieldCount: longint;
    FFieldList: PDLFieldList;
  public
    destructor Destroy; override;
    procedure AllocFieldList(Count: longint);
    procedure SetFieldItem(Index: longint; FieldName: string; DataType: byte; Width: longint;
     FullName: string; Description: string);

    property FieldCount: longint read FFieldCount;
    property FieldList: PDLFieldList read FFieldList;
  end; { TDLFieldList }

  TDLConfigForm = class(TForm)
  protected
    procedure TestConnection(TableList: TStrings);
  public
    procedure SetData(DataSource, UserName, Password: string; OptionList: TStringList); virtual; abstract;
    procedure GetData(var DataSource, UserName, Password: string; OptionList: TStringList); virtual; abstract;
  end;
  TDLConfigFormClass = class of TDLConfigForm;

  TDLBaseDriver = class(TObject)
  protected
  { following fields used in connection configuration API call }
    FDataSource: string;
    FUserName: string;
    FPassword: string;
    FOptionList: TStringList;
    FOptionText: string; // Used for storage of FOptionList.CommaText for DLL calls
    FFields: TDLFieldListManager;
  public
    constructor Create; virtual;
    destructor Destroy; override;

  { Descendant classes must replace all of the following methods }
    procedure ConnectionClose(var Params: TDLConnectionClose); virtual;
    procedure ConnectionConfigure(var Params: TDLConnectionConfigure); virtual;
    procedure ConnectionOpen(var Params: TDLConnectionOpen); virtual;
    procedure GetErrorText(var Params: TDLErrorText); virtual;
    procedure GetFields(var Params: TDLFields); virtual;
    procedure GetTables(var Params: TDLTables); virtual;
    procedure Information(var Params: TDLInformation); virtual; abstract;
    procedure ResultSetClose(var Params: TDLResultSetClose); virtual;
    procedure ResultSetConfigure(var Params: TDLResultSetConfigure); virtual;
    procedure ResultSetEOF(var Params: TDLResultSetEOF); virtual;
    procedure ResultSetFirst(var Params: TDLResultSetFirst); virtual;
    procedure ResultSetGetRow(var Params: TDLResultSetRow); virtual; abstract;
    procedure ResultSetNext(var Params: TDLResultSetNext); virtual;
    procedure ResultSetOpen(var Params: TDLResultSetOpen); virtual;
    procedure ResultSetSetFilter(var Params: TDLResultSetFilter); virtual;
    procedure ResultSetSetSort(var Params: TDLResultSetSort); virtual;

  { Overridden by descendants to create an appropriate connection object }
    function CreateConnection: TDLBaseConnection; virtual; abstract;
  { Overridden by descendants to create an appropriate result set object }
    function CreateResultSet(AConnection: TDLBaseConnection): TDLBaseResultSet; virtual; abstract;

    property DataSource: string read FDataSource;
    property UserName: string read FUserName;
    property Password: string read FPassword;
    property OptionList: TStringList read FOptionList;
    property Fields: TDLFieldListManager read FFields;
  end; { TDLBaseDriver }

  TDLBaseDriverClass = class of TDLBaseDriver;

  TDLBaseConnection = class(TObject)
  protected
    FDriver: TDLBaseDriver;
    FErrorText: string;
  public
    constructor Create; virtual;

    procedure Connect(DataSource, UserName, Password: string; OptionList: TStringList); virtual; abstract;
    procedure Disconnect; virtual; abstract;
    procedure GetTableNames(List: TStrings); virtual; abstract;
    procedure GetFields(TableName: string); virtual;

    property Driver: TDLBaseDriver read FDriver;
    property ErrorText: string read FErrorText write FErrorText;
  end; { TDLBaseConnection }

  TDLBaseResultSet = class(TObject)
  protected
    FConnection: TDLBaseConnection;
    FErrorText: string;
    FBuffer: TDLBuffer;
    FFields: TDLFieldListManager;
  public
    constructor Create(AConnection: TDLBaseConnection); virtual;
    destructor Destroy; override;
    procedure Open(QueryStr: string); virtual; abstract;
    procedure GetFields(AFields: TDLFieldListManager); virtual; abstract;
    procedure Close; virtual; abstract;
    procedure First; virtual; abstract;
    procedure Next; virtual; abstract;
    function Eof: boolean; virtual; abstract;
    //
    property Connection: TDLBaseConnection read FConnection;
    property ErrorText: string read FErrorText write FErrorText;
    property Fields: TDLFieldListManager read FFields;
  end; { TDLBaseResultSet }

{ Register class with list of Data Driver classes }
  procedure RegisterDriverClass(ADriverClass: TDLBaseDriverClass);

{ Data Link API Routines to Export }

{ Close connection to Database backend }
  procedure DataConnectionClose(var Params: TDLConnectionClose); stdcall;
{ Configure paramaters for connection to backend database }
  procedure DataConnectionConfigure(var Params: TDLConnectionConfigure); stdcall;
{ Open connection to Database backend }
  procedure DataConnectionOpen(var Params: TDLConnectionOpen); stdcall;
{ Return pointer to last error text }
  procedure DataGetErrorText(var Params: TDLErrorText); stdcall;
{ Return list of field definitions for requested table }
  procedure DataGetFields(var Params: TDLFields); stdcall;
{ Return count/list of tables for requested database }
  procedure DataGetTables(var Params: TDLTables); stdcall;
{ Return information about Data Driver }
  procedure DataInformation(var Params: TDLInformation); stdcall;
{ Close the result set }
  procedure DataResultSetClose(var Params: TDLResultSetClose); stdcall;
{ Return true if at end of result set }
  procedure DataResultSetEOF(var Params: TDLResultSetEOF); stdcall;
{ Move to the first record in the result set }
  procedure DataResultSetFirst(var Params: TDLResultSetFirst); stdcall;
{ Return data for current row in result set }
  procedure DataResultSetGetRow(var Params: TDLResultSetRow); stdcall;
{ Move to the next record in the result set }
  procedure DataResultSetNext(var Params: TDLResultSetNext); stdcall;
{ Open result set }
  procedure DataResultSetOpen(var Params: TDLResultSetOpen); stdcall;
{ Set Filter on Result Set }
  procedure DataResultSetSetFilter(var Params: TDLResultSetFilter); stdcall;
{ Set Sort on Result Set }
  procedure DataResultSetSetSort(var Params: TDLResultSetSort); stdcall;
{ Configure result set }
  procedure DataResultSetConfigure(var Params: TDLResultSetConfigure); stdcall;

var
  ConnectionConfigureForm: TDLConfigFormClass;
  SQLEditorName: string = 'SQLEditor.dll';
  GDriverClassList: TList = nil;
  GConnectionManager: TDLConnectionManager = nil;
  GResultSetManager: TDLResultSetManager = nil;

implementation

uses
  Dialogs, Controls;

var
  GTableCount: longint = 0;
  GTableList: PDLTableList = nil;
  GErrorText: PChar = nil;

var
  ConfigureQueryProc: function(AParams: PDLQueryEditor): boolean;
  QueryEditorLib: HMODULE = 0;


{ this variable is used by the Data Link API procedures }
var
  GDriver: TDLBaseDriver = nil;

{ Use string list to create global list of table names }

procedure CreateGlobalTableList(TableNames: TStrings);
var
  Index: integer;
begin
  AllocGlobalTableList(TableNames.Count);
  for Index := 0 to TableNames.Count - 1 do begin
    SetGlobalTableItem(Index,TableNames[Index]);
  end; { for }
end;

{ Deallocate global list of table names }

procedure FreeGlobalTableList;
var
  Index: integer;
begin
{ loop thru deallocating table names }
  for Index := 0 to GTableCount-1 do begin
    StrDispose(GTableList[Index].Name);
  end; { for }
  FreeMem(GTableList, GTableCount * SizeOf(TDLTableItem));
  GTableList := nil;
  GTableCount := 0;
end;

procedure FreeGlobalConnectionManager;
var
  Index: integer;
begin
{ loop thru deallocating connections }
  if assigned(GConnectionManager.ConnectionList) then begin
    for Index := 0 to GConnectionManager.ConnectionList.Count-1 do begin
      TDLBaseConnection(GConnectionManager.ConnectionList.Objects[Index]).Free;
    end; { for }
  end; { if }
  GConnectionManager.Free;
  GConnectionManager := nil;
end;

procedure FreeGlobalResultSetManager;
var
  Index: integer;
begin
{ loop thru deallocating connections }
  if assigned(GResultSetManager.ResultSetList) then begin
    for Index := 0 to GResultSetManager.ResultSetList.Count-1 do begin
      TDLBaseResultSet(GResultSetManager.ResultSetList.Objects[Index]).Free;
    end; { for }
  end; { if }
  GResultSetManager.Free;
  GResultSetManager := nil;
end;

{ Allocate empty global list of table item records }

procedure AllocGlobalTableList(Count: longint);
begin
{ free any existing list of tables }
  FreeGlobalTableList;

{ assign table limit and allocate array of table records }
  GTableCount := Count;
  GetMem(GTableList, GTableCount * SizeOf(TDLTableItem));
end;

{ Assign values to requested global table item record }

procedure SetGlobalTableItem(Index: longint; TableName: string);
begin
{ if DLL written property index should always be within bounds 0 - GTableCount-1 }
  if Index < GTableCount then begin
    GTableList[Index].Name := StrNew(pchar(@TableName[1]));
  end; { if }
end;

{ Make dynamic copy of error text in global variable }

procedure SetGlobalErrorText(ErrorText: string);
begin
  StrDispose(GErrorText);
  if ErrorText <> '' then begin
    GErrorText := StrNew(pchar(@ErrorText[1]));
  end; { if }
end;

{ TDLFieldListManager }

procedure TDLFieldListManager.AllocFieldList(Count: Integer);
var
  Index: integer;
  DLFieldItem: TDLFieldItem;
begin
  if Assigned(FieldList) then begin
    for Index := 0 to FieldCount - 1 do begin
      DLFieldItem := FieldList[Index];
      with DLFieldItem do begin
        StrDispose(FieldName);
        StrDispose(FullName);
        StrDispose(Description);
      end; { with }
    end; { for }
    FreeMem(FieldList,FieldCount * SizeOf(TDLFieldItem));
    FFieldList := nil;
  end; { if }
  FFieldCount := Count;
  if FieldCount > 0 then begin
    GetMem(FFieldList,FieldCount * SizeOf(TDLFieldItem));
  end; { if }
end;

destructor TDLFieldListManager.Destroy;
begin
  AllocFieldList(0);
  inherited;
end;

procedure TDLFieldListManager.SetFieldItem(Index: Integer; FieldName: string; DataType: byte; Width: Integer;
 FullName, Description: string);
begin
{ fill the field definition record with zeros }
  FillChar(FieldList^[Index], SizeOf(FieldList^[Index]), 0);

{ initialize field name, data type and width }
  FieldList[Index].FieldName := StrNew(pchar(@FieldName[1]));
  FieldList[Index].Datatype := Datatype;
  FieldList[Index].Width := Width;

{ if field name and full name are different then copy full name }
  if CompareText(FieldName,FullName) <> 0 then begin
    FFieldList[Index].FullName := StrNew(pchar(@FieldName[1]));
  end; { if }

{ copy field description }
  FieldList[Index].Description := StrNew(pchar(@Description[1]));
end;

{ TDLConfigForm }

procedure TDLConfigForm.TestConnection(TableList: TStrings);
var
  Connection: TDLBaseConnection;
  OptionList: TStringList;
  DataSource, UserName, Password: string;
begin
  OptionList := TStringList.Create;
  TableList.Clear;
  try
    Connection := GDriver.CreateConnection;
    Screen.Cursor := crSQLWait;
    try
      GetData(DataSource,UserName,Password,OptionList);
      Connection.Connect(DataSource,UserName,Password,OptionList);
      Connection.GetTableNames(TableList);
      Connection.Disconnect;
    finally
      Screen.Cursor := crDefault;
      OptionList.Free;
      Connection.Free;
    end; { tryf }
    ShowMessage('Connection successful!');
  except
    on E: Exception do begin
      ShowMessage('Connection error: ' + E.ClassName + ' - ' + E.Message);
    end;
  end; { tryx }
end;

{ TDLBaseDriver }

{ Close connection to database backend }

procedure TDLBaseDriver.ConnectionClose(var Params: TDLConnectionClose);
begin
{ Close connection to DataSet based database back end }
  try
  { disconnect from the database backend and then free all memory }
    TDLBaseConnection(GConnectionManager.Get(Params.ConnectionHandle)).Disconnect;
    GConnectionManager.Delete(Params.ConnectionHandle);
//    TDLBaseConnection(GConnectionManager.Get(Params.ConnectionHandle)).Free;

  { set connection handle to nil and return zero result code }
    Params.ConnectionHandle := -1;
    Params.ResultCode := 0;
  except
    on E: Exception do begin
      Params.Resultcode := -1;
      SetGlobalErrorText(E.Message); {TODO: this is not thread safe }
    end;
  end; { tryx }
end;

{ Configure connection parameters to backend database }

procedure TDLBaseDriver.ConnectionConfigure(var Params: TDLConnectionConfigure);
begin
  try
  { copy configuration parameters into string variables }
    FDataSource := StrPas(Params.DataSource);
    OptionList.CommaText := StrPas(Params.Options);
    FUserName := StrPas(Params.UserName);
    FPassword := StrPas(Params.Password);

  { if changes made, result code = 1 and assign parameters }

    if Assigned(ConnectionConfigureForm) then begin
      with ConnectionConfigureForm.Create(Application) do try
        SetData(DataSource,UserName,Password,OptionList);
        if ShowModal = mrOK then begin
          GetData(FDataSource,FUserName,FPassword,OptionList);

          Params.ResultCode := 1;
          Params.DataSource := @FDataSource[1];
          FOptionText := OptionList.CommaText;
          Params.Options := @FOptionText[1];
          Params.UserName := @FUserName[1];
          Params.Password := @FPassword[1];
        end else begin
          Params.ResultCode := 0;
        end; { if }
      finally
        Free;
      end; { with }
    end else begin
      Params.ResultCode := -1;
      SetGlobalErrorText('No configuration available.');
    end; { else }
  except
    on E: Exception do begin
    { signal error and set global error text }
      Params.Resultcode := -1;
      SetGlobalErrorText(E.Message);
    end;
  end; { tryx }
end;

{ Open connection to database backend }

procedure TDLBaseDriver.ConnectionOpen(var Params: TDLConnectionOpen);
var
  Connection: TDLBaseConnection;
begin
  Connection := nil;
  try
  { use virtual method to create appropriate connection to backend database }
    Connection := CreateConnection as TDLBaseConnection;

  { always return handle to connection object }
    Params.ConnectionHandle := GConnectionManager.Add(Connection);

  { attempt to connect to the database backend }
    OptionList.CommaText := Params.Options;
    Connection.Connect(Params.DataSource,Params.UserName,Params.Password,OptionList);

  { if no error then return zero result code }
    Params.ResultCode := 0;
  except
    on E: Exception do begin
    { return error code and set error text in connection handle }
      Params.Resultcode := -1;
      Connection.ErrorText := E.Message;
    end;
  end; { tryx }
end;

{ Return driver, connection or result set error text }

constructor TDLBaseDriver.Create;
begin
  inherited;
  FOptionList := TStringList.Create;
  FFields := TDLFieldListManager.Create;
end;

destructor TDLBaseDriver.Destroy;
begin
  FFields.Free;
  FOptionList.Free;
  inherited;
end;

procedure TDLBaseDriver.GetErrorText(var Params: TDLErrorText);
begin
  with Params do try
  { if connection handle given then return error text inside it }
    if ConnectionHandle >= 0 then begin
      ErrorText := @TDLBaseconnection(GConnectionManager.Get(ConnectionHandle)).ErrorText[1];
  { if result set handle given then return error text inside it }
    end else if ResultSetHandle >= 0 then begin
      ErrorText := @TDLBaseResultSet(GResultSetManager.Get(ResultSethandle)).ErrorText[1];
    end else begin
    { return global error text }
      ErrorText := GErrorText;
    end; { else }
  except
  { if any error getting error text then set global error and return it }
    on E:Exception do begin
      SetGlobalErrorText(E.Message);
      ErrorText := GErrorText;
    end;
  end; { with }
end;

{ Return list of tables for requested database }

procedure TDLBaseDriver.GetFields(var Params: TDLFields);
begin
  try
    TDLBaseConnection(GConnectionManager.Get(Params.ConnectionHandle)).GetFields(Params.TableName);
    Params.FieldCount := Fields.FieldCount;
    Params.FieldList := Fields.FieldList;
  except
    on E: Exception do begin
      Params.ResultCode := -1;
      TDLBaseConnection(GConnectionManager.Get(Params.ConnectionHandle)).ErrorText := E.Message;
    end;
  end; { tryx }
end;

procedure TDLBaseDriver.GetTables(var Params: TDLTables);
var
  Connection: TDLBaseConnection;
  TableNames: TStrings;
begin
  Connection := nil;
  try
  { create list for table names }
    TableNames := TStringList.Create;
    try
    { copy connection handle into convenient object variable }
      Connection := GConnectionManager.Get(Params.ConnectionHandle);

    { attempt to get list of table names }
      Connection.GetTableNames(TableNames);

    { copy table information into global variables }
      CreateGlobalTableList(TableNames);

    { return pointer and count to global table item list }
      Params.TableCount := GTableCount;
      Params.TableList := GTableList;
    finally
    { free the table name list }
      TableNames.Free;
    end; { tryf }
  except
  { if any error then return error code and set error text }
    on E: Exception do begin
      Params.ResultCode := -1;
      Connection.ErrorText := E.Message;
    end;
  end; { tryx }
end;

{ Close the requested result set }

procedure TDLBaseDriver.ResultSetClose(var Params: TDLResultSetClose);
var
  ResultSet: TDLBaseResultSet;
begin
  try
  { copy ResultSet handle into convenient object variable }
    ResultSet := GResultSetManager.Get(Params.ResultSetHandle);

  { attempt to close and free the result set }
    ResultSet.Close;
    GResultSetManager.Delete(Params.ResultSetHandle);
  except
  { return error code and set error text inside connection object }
    on E: Exception do begin
      Params.ResultCode := -1;
      SetGlobalErrorText(E.Message);
    end;
  end; { tryx }
end;

{ Configure the command text used to create result set }

procedure TDLBaseDriver.ResultSetConfigure(var Params: TDLResultSetConfigure);
var
  QueryParams: TDLQueryEditor;
  S1: string;
begin
  try
    if not Assigned(ConfigureQueryProc) and (QueryEditorLib = 0) then begin
      S1 := ExtractFilePath(ParamStr(0)) + 'DataLinks\' + SQLEditorName;
      QueryEditorLib := LoadLibrary(@S1[1]);
      ConfigureQueryProc := GetProcAddress(QueryEditorLib,'ConfigureQuery');
    end; { if }

    FillChar(QueryParams,SizeOf(QueryParams),0);
    QueryParams.ConnectionHandle := Params.ConnectionHandle;
    QueryParams.QueryCommand := Params.QueryCommand;
    QueryParams.QueryStruct := Params.QueryStruct;
    QueryParams.GetTablesProc := DataGetTables;
    QueryParams.GetFieldsProc := DataGetFields;
    QueryParams.ConnectionCloseProc := DataConnectionClose;
    QueryParams.ConnectionConfigureProc := DataConnectionConfigure;
    QueryParams.ConnectionOpenProc := DataConnectionOpen;
    QueryParams.GetErrorTextProc := DataGetErrorText;
    QueryParams.InformationProc := DataInformation;
    QueryParams.ResultSetCloseProc := DataResultSetClose;
    QueryParams.ResultSetEOFProc := DataResultSetEOF;
    QueryParams.ResultSetFirstProc := DataResultSetFirst;
    QueryParams.ResultSetGetRowProc := DataResultSetGetRow;
    QueryParams.ResultSetNextProc := DataResultSetNext;
    QueryParams.ResultSetOpenProc := DataResultSetOpen;
    QueryParams.ResultSetSetFilterProc := DataResultSetSetFilter;
    QueryParams.ResultSetSetSortProc := DataResultSetSetSort;

    if Assigned(ConfigureQueryProc) and ConfigureQueryProc(@QueryParams) then begin
      Params.QueryCommand := QueryParams.QueryCommand;
      Params.QueryStruct := QueryParams.QueryStruct;
      Params.ResultCode := 1;
    end else begin
      Params.ResultCode := 0;
    end;
  except
    on E: Exception do begin
      Params.ResultCode := -1;
      SetGlobalErrorText(E.Message);
    end;
  end;
end;

{ Return true if at end of result set }

procedure TDLBaseDriver.ResultSetEOF(var Params: TDLResultSetEOF);
begin
  try
    Params.Eof := TDLBaseResultSet(GResultSetManager.Get(Params.ResultSetHandle)).Eof;
  except
    on E: Exception do begin
      Params.Resultcode := -1;
      TDLBaseResultSet(GResultSetManager.Get(Params.ResultSetHandle)).ErrorText := E.Message;
    end;
  end; { tryx }
end;

{ Move to first row in result set }

procedure TDLBaseDriver.ResultSetFirst(var Params: TDLResultSetFirst);
begin
  try
    TDLBaseResultSet(GResultSetManager.Get(Params.ResultSetHandle)).First;
  except
    on E: Exception do begin
      Params.Resultcode := -1;
      TDLBaseResultSet(GResultSetManager.Get(Params.ResultSetHandle)).ErrorText := E.Message;
    end;
  end; { tryx }
end;

{ Move to next row in reuslt set }

procedure TDLBaseDriver.ResultSetNext(var Params: TDLResultSetNext);
begin
  try
    TDLBaseResultSet(GResultSetManager.Get(Params.ResultSetHandle)).Next;
  except
    on E: Exception do begin
      Params.Resultcode := -1;
      TDLBaseResultSet(GResultSetManager.Get(Params.ResultSetHandle)).ErrorText := E.Message;
    end;
  end; { tryx }
end;

procedure TDLBaseDriver.ResultSetOpen(var Params: TDLResultSetOpen);
var
  ResultSet: TDLBaseResultSet;
begin
  ResultSet := nil;
  try
    ResultSet := CreateResultSet(GConnectionManager.Get(Params.ConnectionHandle));
    Params.ResultSetHandle := GResultSetManager.Add(ResultSet);
    ResultSet.Open(Params.QueryCommand);
    ResultSet.GetFields(ResultSet.Fields);
    Params.FieldList := ResultSet.Fields.FieldList;
    Params.FieldCount := ResultSet.Fields.FieldCount;
  except
    on E: Exception do begin
      Params.Resultcode := -1;
      ResultSet.ErrorText := E.Message;
    end;
  end; { tryx }
end;

procedure TDLBaseDriver.ResultSetSetFilter(var Params: TDLResultSetFilter);
begin
end;

procedure TDLBaseDriver.ResultSetSetSort(var Params: TDLResultSetSort);
begin
end;

{ TDLBaseConnection }

constructor TDLBaseConnection.Create;
begin
  inherited;
  FDriver := GDriver;
end;

procedure TDLBaseConnection.GetFields(TableName: string);
begin
  with Driver.CreateResultSet(self) do try
  // Create an empty result set to get field info only
    Open('select * from ' + TableName + ' where 0=1');
    GetFields(Driver.Fields); // Global Driver FieldList
    Close;
  finally
    Free;
  end; { with }
end;

{ TDLBaseResultSet }

constructor TDLBaseResultSet.Create(AConnection: TDLBaseConnection);
begin
  inherited Create;
  FBuffer := TDLBuffer.Create;
  FConnection := AConnection;
  FFields := TDLFieldListManager.Create;
end;

destructor TDLBaseResultSet.Destroy;
begin
  FFields.Free;
  FBuffer.Free;
  inherited Destroy;
end;

{ Register class with list of Data Driver classes }

procedure RegisterDriverClass(ADriverClass: TDLBaseDriverClass);
var
  Index: integer;
begin
{ if first call then create list for holding classes }
  if not assigned(GDriverClassList) then begin
    GDriverClassList := TList.Create;
  end; { if }

{ exit if the class has already been registered }
  for Index := 0 to GDriverClassList.Count-1 do begin
    if TDLBaseDriverClass(GDriverClassList[Index]) = ADriverClass then begin
      Exit;
    end; { if }
  end; { for }

{ add the driver class to the list }
  GDriverClassList.Add(ADriverClass);

{ the GDriver variable is used by the procedures exported in DLLs }
  GDriver.Free;
  GDriver := ADriverClass.Create;
end;

{ Data Link API Calls }

{ Close connection to Database backend }

procedure DataConnectionClose(var Params: TDLConnectionClose); stdcall;
begin
  GDriver.ConnectionClose(Params);
end;

{ Configure connection parameters to database backend }

procedure DataConnectionConfigure(var Params: TDLConnectionConfigure); stdcall;
begin
  GDriver.ConnectionConfigure(Params);
end;

{ Open connection to Database backend }

procedure DataConnectionOpen(var Params: TDLConnectionOpen); stdcall;
begin
  GDriver.ConnectionOpen(Params);
end;

{ Return pointer to last error text }

procedure DataGetErrorText(var Params: TDLErrorText); stdcall;
begin
  GDriver.GetErrorText(Params);
end;

{ Return list of field definitions for requested table }

procedure DataGetFields(var Params: TDLFields); stdcall;
begin
  GDriver.GetFields(Params);
end;

{ Return count/list of tables for requested database }

procedure DataGetTables(var Params: TDLTables); stdcall;
begin
  GDriver.GetTables(Params);
end;

{ Return information about Data Driver }

procedure DataInformation(var Params: TDLInformation); stdcall;
begin
  if Assigned(GDriver) then begin
  { if a Data Driver was registered }
    GDriver.Information(Params);
  end else begin
  { if no driver assigned then RegisterDataDriver was not called }
    Params.Resultcode := -1;
    SetGlobalErrorText('No Data Driver class registered.');
  end; { else }
end;

{ Close the result set }

procedure DataResultSetClose(var Params: TDLResultSetClose); stdcall;
begin
  GDriver.ResultSetClose(Params);
end;

{ Return true if at end of result set }

procedure DataResultSetEOF(var Params: TDLResultSetEOF); stdcall;
begin
  GDriver.ResultSetEOF(Params);
end;

{ Move to the first record in the result set }

procedure DataResultSetFirst(var Params: TDLResultSetFirst); stdcall;
begin
  GDriver.ResultSetfirst(Params);
end;

{ Return data for current row in result set }

procedure DataResultSetGetRow(var Params: TDLResultSetRow); stdcall;
begin
  GDriver.ResultSetGetRow(Params);
end;

{ Move to the next record in the result set }

procedure DataResultSetNext(var Params: TDLResultSetNext); stdcall;
begin
  GDriver.ResultSetNext(Params);
end;

{ Open result set }

procedure DataResultSetOpen(var Params: TDLResultSetOpen); stdcall;
begin
  GDriver.ResultSetOpen(Params);
end;

{ Set filter on Result Set }

procedure DataResultSetSetFilter(var Params: TDLResultSetFilter); stdcall;
begin
  GDriver.ResultSetSetFilter(Params);
end;

{ Set Sort on Result Set }

procedure DataResultSetSetSort(var Params: TDLResultSetSort); stdcall;
begin
  GDriver.ResultSetSetSort(Params);
end;

{ Get Result Set }

procedure DataResultSetConfigure(var Params: TDLResultSetConfigure); stdcall;
begin
  GDriver.ResultSetConfigure(Params);
end;

{ TDLConnectionManager }

function TDLConnectionManager.Add(Connection: TDLBaseConnection): integer;
begin
  if not Assigned(FConnectionList) then begin
    FConnectionList := TStringList.Create;
    FConnectionList.Duplicates := dupError;
  end; { if }
  Result := NextID;
  FConnectionList.AddObject(IntToStr(Result), Connection);
end;

constructor TDLConnectionManager.Create;
begin
  inherited;
  FID := 0;
end;

procedure TDLConnectionManager.Delete(ID: integer);
begin
  if ConnectionList.IndexOf(IntToStr(ID)) >= 0 then begin
    ConnectionList.Objects[ConnectionList.IndexOf(IntToStr(ID))].Free;
    ConnectionList.Delete(ConnectionList.IndexOf(IntToStr(ID)));
    FID := FID - ID;
  end; { if }
end;

function TDLConnectionManager.Get(ID: integer): TDLBaseConnection;
begin
  Result := TDLBaseConnection(FConnectionList.Objects[FConnectionList.IndexOf(IntToStr(ID))]);
end;

function TDLConnectionManager.NextID: integer;
var
  TestBit: integer;
begin
  TestBit := 1;
  while ((FID and TestBit) = TestBit) and (TestBit < MaxInt) do begin
    TestBit := TestBit shl 1;
  end; { while }
  FID := FID + TestBit;
  Result := TestBit;
end;

{ TDLResultSetManager }

function TDLResultSetManager.Add(ResultSet: TDLBaseResultSet): integer;
begin
  if not Assigned(FResultSetList) then begin
    FResultSetList := TStringList.Create;
    FResultSetList.Duplicates := dupError;
  end; { if }
  Result := NextID;
  FResultSetList.AddObject(IntToStr(Result), ResultSet);
end;

constructor TDLResultSetManager.Create;
begin
  inherited;
  FID := 0;
end;

procedure TDLResultSetManager.Delete(ID: integer);
begin
  if ResultSetList.IndexOf(IntToStr(ID)) >= 0 then begin
    ResultSetList.Objects[ResultSetList.IndexOf(IntToStr(ID))].Free;
    ResultSetList.Delete(ResultSetList.IndexOf(IntToStr(ID)));
    FID := FID - ID;
  end; { if }
end;

function TDLResultSetManager.Get(ID: integer): TDLBaseResultSet;
begin
  Result := TDLBaseResultSet(FResultSetList.Objects[FResultSetList.IndexOf(IntToStr(ID))]);
end;

function TDLResultSetManager.NextID: integer;
var
  TestBit: integer;
begin
  TestBit := 1;
  while ((FID and TestBit) = TestBit) and (TestBit < MaxInt) do begin
    TestBit := TestBit shl 1;
  end; { while }
  FID := FID + TestBit;
  Result := TestBit;
end;

initialization
  GResultSetManager := TDlResultSetManager.Create;
  GConnectionManager := TDlConnectionManager.Create;
finalization
{ free all memory used in global variables }
  if Assigned(GDriver) then begin
    GDriver.Free;
    GDriver := nil;
  end; { if }
  FreeGlobalTableList;
  SetGlobalErrorText('');
  GDriverClassList.Free;
  GDriverClassList := nil;
  FreeGlobalResultSetManager;
  FreeGlobalConnectionManager;
end.