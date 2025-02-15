{*************************************************************************}
{ Rave Reports version 11.0                                               }
{ Copyright (c), 1995-2017, Nevrona Designs, all rights reserved          }
{*************************************************************************}

unit RvDLCommon;
{ Implements constants, types and classes common to all DATA Link driver DLLs }

interface

uses
  SysUtils, Windows, Classes;

const
  dt_String = 0;
  dt_Integer = 1;
  dt_Boolean = 2;
  dt_Float = 3;
  dt_Currency = 4;
  dt_BCD = 5;
  dt_Date = 6;
  dt_Time = 7;
  dt_DateTime = 8;
  dt_Blob = 9;
  dt_Memo = 10;
  dt_Graphic = 11;
  dt_Int64 = 12;

type
  TConnectionHandle = integer;
  TResultSetHandle = integer;

  PDLInformation = ^TDLInformation;
  TDLInformation = packed record
    Resultcode: longint;
    Installed: Boolean;
    VerMajor: word;
    VerMinor: word;
    InternalName: array[0..32] of Char;
    DisplayName: array[0..255] of Char;
  end;

  PDLConnectionConfigure = ^TDLConnectionConfigure;
  TDLConnectionConfigure = packed record
    ResultCode: longint;
    DataSource: PChar;
    Options: PChar;
    UserName: PChar;
    PassWord: PChar;
  end;

  PDLConnectionOpen = ^TDLConnectionOpen;
  TDLConnectionOpen = packed record
    Resultcode: longint;
    DataSource: PChar;
    Options: PChar;
    UserName: PChar;
    Password: PChar;
    ConnectionHandle: TConnectionHandle;
  end;

  PDLConnectionClose = ^TDLConnectionClose;
  TDLConnectionClose = packed record
    ResultCode: longint;
    ConnectionHandle: TConnectionHandle;
  end;

  TDLTableItem = packed record
    Name: PChar;
  end;

  PDLTableList = ^TDLTableList;
  TDLTableList = array[0..9999] of TDLTableItem;

  PDLTables = ^TDLTables;
  TDLTables = packed record
    ResultCode: longint;
    ConnectionHandle: TConnectionHandle;
    TableCount: longint;
    TableList: PDLTableList;
  end;

  TDLFieldItem = packed record
    FieldName: PChar;
    DataType: byte;
    Width: longint;
    FullName: PChar;
    Description: PChar;
  end;

  PDLFieldList = ^TDLFieldList;
  TDLFieldList = array[0..9999] of TDLFieldItem;

  PDLFields = ^TDLFields;
  TDLFields = packed record
    ResultCode: longint;
    ConnectionHandle: TConnectionHandle;
    TableName: PChar;
    FieldCount: longint;
    FieldList: PDLFieldList;
  end;

  PDLResultSetOpen = ^TDLResultSetOpen;
  TDLResultSetOpen = packed record
    ResultCode: longint;
    ConnectionHandle: TConnectionHandle;
    QueryCommand: PChar;
    ResultSetHandle: TResultSetHandle;
    FieldCount: longint;
    FieldList: PDLFieldList;
  end;

  PDLResultSetClose = ^TDLResultSetClose;
  TDLResultSetClose = packed record
    ResultCode: longint;
    ResultSetHandle: TResultSetHandle;
  end;

  PDLResultSetFirst = ^TDLResultSetFirst;
  TDLResultSetFirst = packed record
    ResultCode: longint;
    ResultSetHandle: TResultSetHandle;
  end;

  PDLResultSetNext = ^TDLResultSetNext;
  TDLResultSetNext = packed record
    ResultCode: longint;
    ResultSetHandle: TResultSetHandle;
  end;

  PDLResultSetEOF = ^TDLResultSetEOF;
  TDLResultSetEOF = packed record
    ResultCode: longint;
    ResultSetHandle: TResultSetHandle;
    Eof: Boolean;
  end;

  PDLTransferFieldList = ^TDLTransferFieldList;
  TDLTransferFieldList = array[0..9999] of Boolean;

  PDLResultSetRow = ^TDLResultSetRow;
  TDLResultSetRow = packed record
    ResultCode: longint;
    ResultSetHandle: TResultSetHandle;
    TransferCount: longint;
    TransferList: PDLTransferFieldList;
    RowBuffer: PChar;
    RowBufSize: longint;
  end; { TDLResultSetRow }

  PDLResultSetFilter = ^TDLResultSetFilter;
  TDLResultSetFilter = packed record
    ResultCode: longint;
    ResultSetHandle: TResultSetHandle;
  end;

  PDLResultSetSort = ^TDLResultSetSort;
  TDLResultSetSort = packed record
    ResultCode: longint;
    ResultSetHandle: TResultSetHandle;
  end;

  PDLErrorText = ^TDLErrorText;
  TDLErrorText = packed record
    ConnectionHandle: TConnectionHandle;
    ResultSetHandle: TResultSetHandle;
    ErrorText: PChar;
  end;

  PDLResultSetConfigure = ^TDLResultSetConfigure;
  TDLResultSetConfigure = packed record
    ResultCode: longint;
    ConnectionHandle: TConnectionHandle;
    QueryCommand: PChar;
    QueryStruct: PChar;
  end;

  TDLGetTablesProc = procedure(var Params: TDLTables); stdcall;
  TDLGetFieldsProc = procedure(var Params: TDLFields); stdcall;
  TDLConnectionCloseProc = procedure(var Params: TDLConnectionClose); stdcall;
  TDLConnectionConfigureProc = procedure(var Params: TDLConnectionConfigure); stdcall;
  TDLConnectionOpenProc = procedure(var Params: TDLConnectionOpen); stdcall;
  TDLGetErrorTextProc = procedure(var Params: TDLErrorText); stdcall;
  TDLInformationProc = procedure(var Params: TDLInformation); stdcall;
  TDLResultSetCloseProc = procedure(var Params: TDLResultSetClose); stdcall;
  TDLResultSetEOFProc = procedure(var Params: TDLResultSetEOF); stdcall;
  TDLResultSetFirstProc = procedure(var Params: TDLResultSetFirst); stdcall;
  TDLResultSetGetRowProc = procedure(var Params: TDLResultSetRow); stdcall;
  TDLResultSetNextProc = procedure(var Params: TDLResultSetNext); stdcall;
  TDLResultSetOpenProc = procedure(var Params: TDLResultSetOpen); stdcall;
  TDLResultSetSetFilterProc = procedure(var Params: TDLResultSetFilter); stdcall;
  TDLResultSetSetSortProc = procedure(var Params: TDLResultSetSort); stdcall;
  TDLResultSetConfigureProc = procedure(var Params: TDLResultSetConfigure); stdcall;

  PDLQueryEditor = ^TDLQueryEditor;
  TDLQueryEditor = packed record
    ResultCode: longint;
    ConnectionHandle: TConnectionHandle;
    QueryCommand: PChar;
    QueryStruct: PChar;
    GetTablesProc: TDLGetTablesProc;
    GetFieldsProc: TDLGetFieldsProc;
    ConnectionCloseProc: TDLConnectionCloseProc;
    ConnectionConfigureProc: TDLConnectionConfigureProc;
    ConnectionOpenProc: TDLConnectionOpenProc;
    GetErrorTextProc: TDLGetErrorTextProc;
    InformationProc: TDLInformationProc;
    ResultSetCloseProc: TDLResultSetCloseProc;
    ResultSetEOFProc: TDLResultSetEOFProc;
    ResultSetFirstProc: TDLResultSetFirstProc;
    ResultSetGetRowProc: TDLResultSetGetRowProc;
    ResultSetNextProc: TDLResultSetNextProc;
    ResultSetOpenProc: TDLResultSetOpenProc;
    ResultSetSetFilterProc: TDLResultSetSetFilterProc;
    ResultSetSetSortProc: TDLResultSetSetSortProc;
  end;

{ TDLBuffer }

type
  TDLBuffer = Class(TObject)
  protected
    FRowBuf: PChar;
    FRowBufSize: longint;
    FRowBufPtr: PChar;
    FFieldIndex: longint;
    FAddPad: longint;
    FFieldCount: longint;
    function GetBufferSize: longint;
    function GetBuffer: pointer;
    procedure AddingNative;
    procedure AddingFormatted;
    procedure AllocateSpace(AddSize: longint);
    procedure WriteStr(Value: string);
    procedure WriteLong(Value: longint);
    procedure WriteInt64(Value: Int64);
    procedure WriteBool(Value: boolean);
    procedure WriteFloat(Value: extended);
    procedure WriteCurr(Value: currency);
    procedure WriteDateTime(Value: TDateTime);
    procedure WriteBuf(var Buffer; Len: longint);

  public
  { Create object used to prepare ResultSet row buffer }
    constructor Create;
  { Free all dynamic structures }
    destructor Destroy; override;
  { Initialize buffer for requested number of fields }
    procedure Init(AFieldCount: integer);
  { Write null value for current field }
    procedure WriteNullData;
  { Write formatted and native string values }
    procedure WriteStrData(FormatData, NativeData: string);
  { Write formatted and native LongInt values }
    procedure WriteLongData(FormatData: string; NativeData: longint);
  { Write formatted and native Int64 values }
    procedure WriteInt64Data(FormatData: string; NativeData: int64);
  { Write formatted and native boolean values }
    procedure WriteBoolData(FormatData: string; NativeData: boolean);
  { Write formatted and native floating point values }
    procedure WriteFloatData(FormatData: string; NativeData: extended);
  { Write formatted and native Currency values }
    procedure WriteCurrData(FormatData: string; NativeData: currency);
  { Write formatted and native BCD values (Actually written as Currency) }
    procedure WriteBCDData(FormatData: string; NativeData: currency);
  { Write formatted and native date/time values }
    procedure WriteDateTimeData(FormatData: string; NativeData: TDateTime);
  { Write native blob value }
    procedure WriteBlobData(var Buffer; Len: longint);
    property AddPad: longint read FAddPad write FAddPad;
    property FieldCount: longint read FFieldCount;
    property BufferSize: longint read GetBufferSize;
    property Buffer: pointer read GetBuffer;
  end; { TDLBuffer }

implementation

{ TDLBuffer }

{ Create object used to prepare ResultSet row buffer  }

constructor TDLBuffer.Create;
begin
  inherited Create;
  FAddPad := 4096;
  FRowBufSize := FAddPad;
  GetMem(FRowBuf,FRowBufSize);
end;

{ Free all dynamic structures }

destructor TDLBuffer.Destroy;
begin
  if FRowBufSize > 0 then begin
    FreeMem(FRowBuf,FRowBufSize);
  end; { if }
  inherited Destroy;
end;

{ Initialize buffer for requested number of fields }

procedure TDLBuffer.Init(AFieldCount: longint);
var
  Index : longint;
begin
  FFieldCount := AFieldCount;
  FRowBufPtr := FRowBuf;
  for Index := 1 to FieldCount do begin
    WriteLong(0); { Offset for native data }
    WriteLong(0); { Offset for formatted data }
  end; { for }
  FFieldIndex := 0;
end;

{ Return the current size of the buffer }

function TDLBuffer.GetBufferSize: longint;
begin
  Result := integer(FRowBufPtr) - integer(FRowBuf);
end;

{ Return pointer to the buffer }

function TDLBuffer.GetBuffer: pointer;
begin
  Result := FRowBuf;

end;

{ Setup so the next "Write" statement will write a native value }

procedure TDLBuffer.AddingNative;
begin
  longint(pointer(integer(FRowBuf) + (FFieldIndex* 8))^) := integer(FRowBufPtr) - integer(FRowBuf);
end;

{ Setup so the next "Write" statement will write a formatted value }

procedure TDLBuffer.AddingFormatted;
begin
  longint(pointer(integer(FRowBuf) + (FFieldIndex * 8) + 4)^) := integer(FRowBufPtr) - integer(FRowBuf);
end;

{ Reallocate the buffer to hold requested additional space }

procedure TDLBuffer.AllocateSpace(AddSize: longint);
var
  NewRowBuf: PChar;
  NewSize: integer;
begin
{ if buffer needs to be reallocated to satisfy request }
  if (integer(FRowBufPtr) - integer(FRowBuf) + AddSize) > FRowBufSize then begin
    NewSize := (integer(FRowBufPtr) - integer(FRowBuf)) + AddSize + FAddPad;
    GetMem(NewRowBuf,NewSize);

  { Copy from old buffer to new }
    Move(FRowBuf^,NewRowBuf^,integer(FRowBufPtr) - integer(FRowBuf));

  { Assign new buffer and deallocate old one }
    FRowBufPtr := PChar(integer(NewRowBuf) + (integer(FRowBufPtr) - integer(FRowBuf)));
    FreeMem(FRowBuf,FRowBufSize);
    FRowBuf := NewRowBuf;
    FRowBufSize := NewSize;
  end; { if }
end;

{ Write string value to end of buffer }

procedure TDLBuffer.WriteStr(Value: string);
var
  Len: integer;
{$IFDEF UNICODE}
var
  Data: TBytes;
  Encoding: TEncoding;
  S1: AnsiString;
{$ENDIF}
begin
{$IFDEF UNICODE}
  if StringCodePage(Value) = DefaultUnicodeCodePage then begin
    Encoding := TEncoding.Unicode;
  end else begin
    Encoding := TEncoding.GetEncoding(StringCodePage(Value));
  end;
  WriteLong(2); // Unicode string follows
  Data := Encoding.GetBytes(Value);
  Len := Length(Data);
  WriteLong(Len);
  if Len > 0 then begin
    Move(Data[0],FRowBufPtr^,Len);
    FRowBufPtr := PChar(integer(FRowBufPtr) + Len);
  end; { if }

// Convert unicode string to ANSI equivalent for non-unicode
  S1 := AnsiString(Value);
  WriteLong(1); // MBCS string follows
  Len := Length(S1);
  WriteLong(Len);
  if Len > 0 then begin
    Move(S1[1],FRowBufPtr^,Len);
    FRowBufPtr := PChar(integer(FRowBufPtr) + Len);
  end;

{$ELSE}
  WriteLong(1); // MBCS string follows
  Len := Length(Value);
  WriteLong(Len);
  if Len > 0 then begin
    Move(Value[1],FRowBufPtr^,Len);
    FRowBufPtr := PChar(integer(FRowBufPtr) + Len);
  end; { if }
{$ENDIF}
  WriteLong(0); // end of string formats
end;

{ Write LongInt value to end of buffer }

procedure TDLBuffer.WriteLong(Value: longint);
begin
  longint(pointer(FRowBufPtr)^) := Value;
  FRowBufPtr := PChar(integer(FRowBufPtr) + SizeOf(longint));
end;

{ Write Int64 value to end of buffer }

procedure TDLBuffer.WriteInt64(Value: Int64);
begin
  Int64(pointer(FRowBufPtr)^) := Value;
  FRowBufPtr := PChar(integer(FRowBufPtr) + SizeOf(Value));
end;

{ Write boolean value to end of buffer }

procedure TDLBuffer.WriteBool(Value: boolean);
begin
  boolean(pointer(FRowBufPtr)^) := Value;
  FRowBufPtr := PChar(integer(FRowBufPtr) + SizeOf(boolean));
end;

{ Write floating point value to end of buffer }

procedure TDLBuffer.WriteFloat(Value: extended);
begin
  extended(pointer(FRowBufPtr)^) := Value;
  FRowBufPtr := PChar(integer(FRowBufPtr) + SizeOf(extended));
end;

{ Write currency value to end of buffer }

procedure TDLBuffer.WriteCurr(Value: currency);
begin
  currency(pointer(FRowBufPtr)^) := Value;
  FRowBufPtr := PChar(integer(FRowBufPtr) + SizeOf(currency));
end;

{ Write date/time value to end of buffer }

procedure TDLBuffer.WriteDateTime(Value: TDateTime);
begin
  TDateTime(pointer(FRowBufPtr)^) := Value;
  FRowBufPtr := PChar(integer(FRowBufPtr) + SizeOf(TDateTime));
end;

{ Write untyped bytes to end of buffer }

procedure TDLBuffer.WriteBuf(var Buffer; Len: integer);
begin
  Move(Buffer, FRowBufPtr^, Len);
  FRowBufPtr := PChar(integer(FRowBufPtr) + Len);
end;

{ Mark current field index with null data flag }

procedure TDLBuffer.WriteNullData;
begin
  longint(pointer(integer(FRowBuf) + (FFieldIndex * 8))^) := -1;
  Inc(FFieldIndex);
end;

{ Write formatted and native string values }

procedure TDLBuffer.WriteStrData(FormatData: string; NativeData: string);
begin
  if (NativeData <> FormatData) and (FormatData <> '') then begin
    AllocateSpace((Length(FormatData) + Length(NativeData)){$IFDEF UNICODE} * 2{$ENDIF} + 24);
    AddingFormatted;
    WriteStr(FormatData);
  end else begin
    AllocateSpace(Length(NativeData){$IFDEF UNICODE} * 2{$ENDIF} + 12);
  end; { else }
  AddingNative;
  WriteStr(NativeData);
  Inc(FFieldIndex);
end;

{ Write formatted and native LongInt values }

procedure TDLBuffer.WriteLongData(FormatData: string; NativeData: integer);
begin
  if (IntToStr(NativeData) <> FormatData) and (FormatData <> '') then begin
    AllocateSpace(Length(FormatData){$IFDEF UNICODE} * 2{$ENDIF} + 4 + SizeOf(NativeData));
    AddingFormatted;
    WriteStr(FormatData);
  end else begin
    AllocateSpace(SizeOf(NativeData));
  end; { else }
  AddingNative;
  WriteLong(NativeData);
  Inc(FFieldIndex);
end;

{ Write formatted and native LongInt values }

procedure TDLBuffer.WriteInt64Data(FormatData: string; NativeData: int64);
begin
  if (IntToStr(NativeData) <> FormatData) and (FormatData <> '') then begin
    AllocateSpace(Length(FormatData){$IFDEF UNICODE} * 2{$ENDIF} + 4 + SizeOf(NativeData));
    AddingFormatted;
    WriteStr(FormatData);
  end else begin
    AllocateSpace(SizeOf(NativeData));
  end; { else }
  AddingNative;
  WriteInt64(NativeData);
  Inc(FFieldIndex);
end;

{ Write formatted and native boolean values }

procedure TDLBuffer.WriteBoolData(FormatData: string; NativeData: boolean);
begin
  if FormatData <> '' then begin
    AllocateSpace(Length(FormatData){$IFDEF UNICODE} * 2{$ENDIF} + 4 + SizeOf(NativeData));
    AddingFormatted;
    WriteStr(FormatData);
  end else begin
    AllocateSpace(SizeOf(NativeData));
  end; { else }
  AddingNative;
  WriteBool(NativeData);
  Inc(FFieldIndex);
end;

{ Write formatted and native floating point values }

procedure TDLBuffer.WriteFloatData(FormatData: string; NativeData: extended);
begin
  if FormatData <> '' then begin
    AllocateSpace(Length(FormatData){$IFDEF UNICODE} * 2{$ENDIF} + 4 + SizeOf(NativeData));
    AddingFormatted;
    WriteStr(FormatData);
  end else begin
    AllocateSpace(SizeOf(NativeData));
  end; { else }
  AddingNative;
  WriteFloat(NativeData);
  Inc(FFieldIndex);
end;

{ Write formatted and native currency values }

procedure TDLBuffer.WriteCurrData(FormatData: string; NativeData: currency);
begin
  if FormatData <> '' then begin
    AllocateSpace(Length(FormatData){$IFDEF UNICODE} * 2{$ENDIF} + 4 + SizeOf(NativeData));
    AddingFormatted;
    WriteStr(FormatData);
  end else begin
    AllocateSpace(SizeOf(NativeData));
  end; { else }
  AddingNative;
  WriteCurr(NativeData);
  Inc(FFieldIndex);
end;

{ Write formatted and native bCD values }

procedure TDLBuffer.WriteBCDData(FormatData: string; NativeData: currency);
begin
  if FormatData <> '' then begin
    AllocateSpace(Length(FormatData){$IFDEF UNICODE} * 2{$ENDIF} + 4 + SizeOf(NativeData));
    AddingFormatted;
    WriteStr(FormatData);
  end else begin
    AllocateSpace(SizeOf(NativeData));
  end; { else }
  AddingNative;
  WriteCurr(NativeData);
  Inc(FFieldIndex);
end;

{ Write formatted and native date/time values }

procedure TDLBuffer.WriteDateTimeData(FormatData: string; NativeData: TDateTime);
begin
  if FormatData <> '' then begin
    AllocateSpace(Length(FormatData){$IFDEF UNICODE} * 2{$ENDIF} + 4 + SizeOf(NativeData));
    AddingFormatted;
    WriteStr(FormatData);
  end else begin
    AllocateSpace(SizeOf(NativeData));
  end; { else }
  AddingNative;
  WriteDateTime(NativeData);
  Inc(FFieldIndex);
end;

{ Write blob value }

procedure TDLBuffer.WriteBlobData(var Buffer; Len: longint);
begin
  AllocateSpace(Len + 4);
  AddingNative;
  WriteLong(Len);
  if Len > 0 then begin
    WriteBuf(Buffer,Len);
  end; { if }
  Inc(FFieldIndex);
end;

end.
