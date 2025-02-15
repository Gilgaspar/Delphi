unit ServerModeDemoData;

interface

{$I cxVer.inc}

uses
{$IFDEF DELPHI16}
  System.UITypes, System.Contnrs,
{$ENDIF}
  SysUtils, Classes, Controls, Dialogs, DB, SqlExpr, FMTBcd, dxServerModeData, ServerModeDemoConnection,
{$IFDEF DELPHI11}
  DBXCommon,
{$ENDIF}
{$IFNDEF DELPHI8}
  DBXpress,
{$ELSE}
  DBXMSSQL,
{$ENDIF}
  dxServerModeDBXDataSource;

type
  TServerModeDemoDataDM = class(TDataModule)
    SQLConnection: TSQLConnection;
    SQLQuery: TSQLQuery;
    ServerModeDataSource: TdxServerModeDBXDataSource;
    procedure ServerModeDataSourceFatalError(Sender: TdxServerModeCustomDataSource; const AMessage: string);
    procedure ServerModeDataSourceInconsistentCache(Sender: TdxServerModeCustomDataSource; const AMessage: string;
      var ARecoverCache: Boolean);
  private
    function GetInsertSQL: string;
  public
    procedure AddRecords(ACount: Integer; AProgress: TdxProgressEvent);
    procedure Connect(const AHostName, ADatabaseName, AUserName, APassword: string;
      OSAuthentication: Boolean);
    procedure CreateDatabase;
    function TableExists: Boolean;
    procedure CreateTable;
    procedure ExecSQL(const ASQL: string);
    function GetDescription: string;
    function GetRecordsCount: Integer;
  end;

function GetCaption: string;
function GetDatabaseName: string;
function GetTableName: string;
function GetDescription: string;

var
  ServerModeDemoDataDM: TServerModeDemoDataDM;

implementation

uses
  DateUtils;

{$R *.dfm}

function GetCaption: string;
begin
  Result := 'ExpressQuantumGrid dbExpress Server Mode Demo';
end;

function GetDatabaseName: string;
begin
  Result := 'ServerModeGridDemo';
end;

function GetTableName: string;
begin
  Result := 'ServerModeGridTableDemo';
end;

function GetDescription: string;
begin
  Result := 'This demo shows a grid control''s capabilities when bound to a large ' +
  'amount of data in Server Mode via a dbExpress connection.';
end;

{ TServerModeDemoDataDM }

procedure TServerModeDemoDataDM.AddRecords(ACount: Integer; AProgress: TdxProgressEvent);
var
  I, J, ASubCount: Integer;
  ASQL: string;
{$IFDEF DELPHI11}
  ATransaction: TDBXTransaction;
{$ELSE}
  ATransDesc: TTransactionDesc;
{$ENDIF}
begin
  ASubCount := 10;
{$IFDEF DELPHI11}
  ATransaction := SQLConnection.BeginTransaction;
{$ELSE}
  SQLConnection.StartTransaction(ATransDesc);
{$ENDIF}
  try
    for I := 0 to (ACount div ASubCount) - 1 do
    begin
      if I mod 100 = 0 then
        AProgress(Self, 100 / (ACount div ASubCount) * I);
      ASQL := '';
      for J := 1 to ASubCount do
        ASQL := ASQL + GetInsertSQL;
      SQLConnection.ExecuteDirect(ASQL);
    end;
  {$IFDEF DELPHI11}
    SQLConnection.CommitFreeAndNil(ATransaction);
  {$ELSE}
    SQLConnection.Commit(ATransDesc);
  {$ENDIF}
  except
  {$IFDEF DELPHI11}
    SQLConnection.RollbackFreeAndNil(ATransaction);
  {$ELSE}
    SQLConnection.Rollback(ATransDesc);
  {$ENDIF}
  end;
end;

procedure TServerModeDemoDataDM.Connect(const AHostName, ADatabaseName, AUserName, APassword: string;
  OSAuthentication: Boolean);
begin
  SQLConnection.Connected := False;
  SQLConnection.LoginPrompt := False;
  SQLConnection.DriverName := 'MSSQL';
  SQLConnection.GetDriverFunc := 'getSQLDriverMSSQL';
  SQLConnection.Params.Values['HostName'] :=  AHostName;
  SQLConnection.Params.Values['DataBase'] := ADatabaseName;
  SQLConnection.Params.Values['User_Name'] := AUserName;
  SQLConnection.Params.Values['Password'] := APassword;
  if OSAuthentication then
    SQLConnection.Params.Values['OS Authentication'] := 'True'
  else
    SQLConnection.Params.Values['OS Authentication'] := 'False';
  {$IFDEF DELPHI8}
    SQLConnection.LibraryName := 'dbxmss.dll';
    SQLConnection.VendorLib := 'sqlncli10.dll';
    if SQLConnection.Params.Values['MetaDataPackageLoader'] = '' then
      SQLConnection.Params.Values['MetaDataPackageLoader'] := 'TDBXMsSqlMetaDataCommandFactory';
  {$ELSE}
    SQLConnection.LibraryName := 'dbexpmss.dll';
    SQLConnection.VendorLib := 'oledb';
  {$ENDIF}
  try
    SQLConnection.Connected := True;
  except
    on E : Exception do
      if E.ClassType = EAccessViolation then
        raise Exception.CreateFmt('Cannot connect to a database ''%s''', [ADatabaseName])
      else
        raise;
  end;
end;

procedure TServerModeDemoDataDM.CreateDatabase;
begin
  ExecSQL(Format('IF DB_ID(N''%s'') IS NULL' + sLineBreak +
    'CREATE DATABASE "%0:s";',
    [GetDatabaseName]));
end;

function TServerModeDemoDataDM.TableExists: Boolean;
var
  ASQL: string;
begin
  ASQL := Format('IF DB_ID(N''%s'') IS NOT NULL AND OBJECT_ID(N''%0:s.dbo.%1:s'') IS NOT NULL' + sLineBreak +
    '  SELECT 1;' + sLineBreak +
    'ELSE' + sLineBreak +
    '  SELECT -1;', [GetDatabaseName, GetTableName]);
  SQLQuery.Active := False;
  SQLQuery.SQL.Text := ASQL;
  SQLQuery.Open;
  Result := not SQLQuery.Eof and (SQLQuery.Fields[0].AsInteger = 1);
end;

procedure TServerModeDemoDataDM.CreateTable;
var
  ASQL: string;
begin
  ASQL := 'IF OBJECT_ID(N''' + GetDatabaseName + '.dbo.' + GetTableName + ''') IS NULL' + sLineBreak +
    'CREATE TABLE "dbo"."' + GetTableName + '"(' +
    ' "OID" int IDENTITY(1,1) NOT NULL,' +
    ' "Subject" nvarchar(100) NULL,' +
    ' "From" nvarchar(100) NULL,' +
    ' "Sent" datetime NULL,' +
    ' "Size" bigint NULL,' +
    ' "HasAttachment" bit NULL,' +
    ' "Priority" int NULL,' +
    ' CONSTRAINT "PK_' + GetTableName + '" PRIMARY KEY CLUSTERED' +
    '(' +
    ' "OID" ASC' +
    ')WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON "PRIMARY"' +
    ') ON "PRIMARY";';
  ExecSQL(ASQL);
  ExecSQL('CREATE NONCLUSTERED INDEX iSubject_ServerModeGridTableDemo ON "ServerModeGridTableDemo" ("Subject");');
  ExecSQL('CREATE NONCLUSTERED INDEX iFrom_ServerModeGridTableDemo ON "ServerModeGridTableDemo" ("From");');
  ExecSQL('CREATE NONCLUSTERED INDEX iSent_ServerModeGridTableDemo ON "ServerModeGridTableDemo" ("Sent");');
  ExecSQL('CREATE NONCLUSTERED INDEX iSize_ServerModeGridTableDemo ON "ServerModeGridTableDemo" ("Size");');
  ExecSQL('CREATE NONCLUSTERED INDEX iHasAttachment_ServerModeGridTableDemo ON "ServerModeGridTableDemo" ("HasAttachment");');
  ExecSQL('CREATE NONCLUSTERED INDEX iPriority_ServerModeGridTableDemo ON "ServerModeGridTableDemo" ("Priority");');
end;

procedure TServerModeDemoDataDM.ExecSQL(const ASQL: string);
begin
  SQLQuery.Active := False;
  SQLQuery.SQL.Text := ASQL;
  SQLQuery.ExecSQL;
end;

function TServerModeDemoDataDM.GetDescription: string;
begin
  Result := 'This demo shows a grid control''s capabilities when bound to a large ' +
    'amount of data in Server Mode via a dbExpress connection.';
end;

function TServerModeDemoDataDM.GetInsertSQL: string;

  function GetDateTime: string;
  var
    ADate: TDateTime;
  begin
    ADate := IncSecond(Now, -Random(315360000));
    Result := FormatDateTime('yyyymmdd hh:mm:ss', ADate);
  end;

const
  Users: array[0..16] of string = (
    'Peter Dolan',
    'Ryan Fischer',
    'Richard Fisher',
    'Tom Hamlett',
    'Mark Hamilton',
    'Steve Lee',
    'Jimmy Lewis',
    'Jeffrey W McClain',
    'Andrew Miller',
    'Dave Murrel',
    'Bert Parkins',
    'Mike Roller',
    'Ray Shipman',
    'Paul Bailey',
    'Brad Barnes',
    'Carl Lucas',
    'Jerry Campbell'
  );
  Subjects: array[0..20] of string = (
    'Integrating Developer Express MasterView control into an Accounting System.',
    'Web Edition: Data Entry Page. There is an issue with date validation.',
    'Payables Due Calculator is ready for testing.',
    'Web Edition: Search Page is ready for testing.',
    'Main Menu: Duplicate Items. Somebody has to review all menu items in the system.',
    'Receivables Calculator. Where can I find the complete specs?',
    'Ledger: Inconsistency. Please fix it.',
    'Receivables Printing module is ready for testing.',
    'Screen Redraw. Somebody has to look at it.',
    'Email System. What library are we going to use?',
    'Cannot add new vendor. This module doesn''''t work!',
    'History. Will we track sales history in our system?',
    'Main Menu: Add a File menu. File menu item is missing.',
    'Currency Mask. The current currency mask in completely unusable.',
    'Drag & Drop operations are not available in the scheduler module.',
    'Data Import. What database types will we support?',
    'Reports. The list of incomplete reports.',
    'Data Archiving. We still don''''t have this features in our application.',
    'Email Attachments. Is it possible to add multiple attachments? I haven''''t found a way to do this.',
    'Check Register. We are using different paths for different modules.',
    'Data Export. Our customers asked us for export to Microsoft Excel');

begin
  Result := 'INSERT INTO "' + GetTableName + '" ("Subject", "From", "Sent", "Size", "HasAttachment", "Priority")' +
    'VALUES (''' + Subjects[Random(21)] + ''',''' + Users[Random(17)] + ''',''' + GetDateTime + ''',' +
      IntToStr(Random(100000)) + ',' + IntToStr(Random(2)) + ',' + IntToStr(Random(3)) + ');'
end;

function TServerModeDemoDataDM.GetRecordsCount: Integer;
var
  ASQL: string;
begin
  ASQL := Format('IF DB_ID(N''%s'') IS NOT NULL AND OBJECT_ID(N''%0:s.dbo.%1:s'') IS NOT NULL' + sLineBreak +
    '  SELECT COUNT(*) FROM %0:s.dbo.%1:s;' + sLineBreak +
    'ELSE' + sLineBreak +
    '  SELECT 0;', [GetDatabaseName, GetTableName]);
  SQLQuery.Active := False;
  SQLQuery.SQL.Text := ASQL;
  SQLQuery.Open;
  if not SQLQuery.Eof then
    Result := SQLQuery.Fields[0].AsInteger
  else
    Result := 0;
end;

procedure TServerModeDemoDataDM.ServerModeDataSourceFatalError(Sender: TdxServerModeCustomDataSource;
  const AMessage: string);
var
  S: string;
begin
  S := 'The following error occurred when obtaining data: "%s".' + sLineBreak +
    'Do you want to reload the data?';
  if MessageDlg(Format(S, [AMessage]), mtError, [mbYes, mbNo], 0) = mrYes then
    Sender.Open;
end;

procedure TServerModeDemoDataDM.ServerModeDataSourceInconsistentCache(Sender: TdxServerModeCustomDataSource;
  const AMessage: string; var ARecoverCache: Boolean);
begin
  ARecoverCache := MessageDlg('The cache state is inconsistent. Do you want to recover it?', mtError, [mbYes, mbNo], 0) = mrYes;
  if not ARecoverCache then
    Sender.Close;
end;

end.
