unit QRAbsDatas;
//********************************************************************
//
// TQRAbstractTable : TDataset with no underlying database
//
// (c) QBS 2003/4/5/6/10/11/12
//
//  3/05/2006 Upgraded with GetRecordEvent to fix extra record bug.
//  26/01/2010 improved Prior  implementation
//  17/01/2012 fixed MoveBy, now calling inherited
//********************************************************************
interface
uses windows, classes, controls, stdctrls, sysutils, db;

const
     MAX_STRING = 64000;
type
    TQRAbsTable = class;
    TQRDataAbsSetEvent = procedure( const DataStr : string; Field : TField;
                                    buffer : pointer ) of object;

   TQRAbsRecordEvent = procedure( Sender:TQRAbsTable ; var Moredata : boolean ) of object;

   TQRAbsTable = class(TDataset)
   private
     FOnSetFieldValue : TQRDataAbsSetEvent;
     FOnGetRecord : TQRAbsRecordEvent;
     FRecBufSize: Word;
     FRecordSize : word;
     FDefFieldLen : integer;
     FRecordCount : longint;
     FCurRecord : longint;
     FEOF : Boolean;
     FBOF : Boolean;
     FMoredata : boolean;
     //FActive : boolean;
     FDoneFielddefs : boolean;
     FFieldnames : TStringlist;
     // prior stuff
     FLastGetOp : TGetMode;
     FCurrentGetOp : TGetMode;
     //FSavedBuffer : PByte;
     //FSwapBuffer : PByte;
   protected
     procedure ClearData;
     // abstracts from TDataset
     function AllocRecordBuffer: PByte; override;
     procedure FreeRecordBuffer(var Buffer: PByte); override;
     procedure GetBookmarkData(Buffer: PByte; Data: Pointer); override;
     function GetBookmarkFlag(Buffer: PByte): TBookmarkFlag; override;
     function GetRecord(Buffer: PByte; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
     function GetRecordSize: Word; override;
     procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
     procedure InternalClose; override;
     procedure InternalDelete; override;
     procedure InternalFirst; override;
     procedure InternalGotoBookmark(Bookmark: Pointer); override;
     procedure InternalHandleException; override;
     procedure InternalInitFieldDefs; override;
     procedure InternalInitRecord(Buffer: PByte); override;
     procedure InternalLast; override;
     procedure InternalOpen; override;
     procedure InternalPost; override;
     procedure InternalSetToRecord(Buffer: PByte); override;
     function IsCursorOpen: Boolean; override;
     procedure SetBookmarkFlag(Buffer: PByte; Value: TBookmarkFlag); override;
     procedure SetBookmarkData(Buffer: PByte; Data: Pointer); override;
     procedure SetFieldData(Field: TField; Buffer: Pointer); overload; override;
     procedure SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean); overload; override;
     procedure ActivateBuffers; override;
     procedure CreateFields; override;
     function GetRecordCount: Longint; override;
     function GetRecNo: Longint; override;
   public
     constructor Create(AOwner: TComponent);override;
     destructor Destroy;override;
     function GetFieldData(Field: TField; Buffer: Pointer): Boolean; overload; override;
     function GetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean): Boolean; overload; override;
     // added by DCA on 17/05/2013
     {$IFDEF VER240} // XE3
     function GetFieldData(Field: TField; Buffer: TValueBuffer): Boolean; overload{; virtual };override;
     function GetFieldData(Field: TField; Buffer: TValueBuffer; NativeFormat: Boolean): Boolean; overload; override;
     {$ENDIF}
     function MoveBy(Distance: Integer): Integer;override;
     procedure Next;
     //function FieldbyName( fname : string ): TField;
   published
     property Active;
     property OnGetRecord : TQRAbsRecordEvent read FOnGetRecord write FOnGetRecord;
     property OnSetFieldValue : TQRDataAbsSetEvent read FOnSetFieldValue write FOnSetFieldValue;
     property RecordCount : longint read FRecordCount;
     property CurrentRecord : longint read FCurRecord;
     property DefFieldLen : integer read FDefFieldLen write FDefFieldLen default 50;
     property EOF : boolean read FEOF;
     property BOF : boolean read FBOF;
     property FieldDefs;
     property BeforeOpen;
     property AfterOpen;
     property BeforeClose;
     property AfterClose;
     property BeforeScroll;
     property AfterScroll;
   end;

   Function StripXChars( ss : string ) : string;
   
implementation

constructor TQRAbsTable.Create(AOwner: TComponent);
begin
      inherited create( aOwner );
      FFieldnames := TStringlist.create;
      FRecordSize := 5000;
      FLastGetOp := gmNext;
end;

destructor TQRAbsTable.Destroy;
begin
     FFieldnames.free;
     inherited;
end;

function TQRAbsTable.GetRecno: Longint;
begin
    result := FCurRecord;
end;


procedure TQRAbsTable.InternalOpen;
begin
    if Active then exit;
    FFieldnames.Clear;
    FEOF := false;
    FBOF := true;
    FRecordcount := 0;
    InternalInitFieldDefs;
    Createfields;
    FCurRecord := 0;
    ActivateBuffers;
end;

function TQRAbsTable.Moveby( distance : integer ):integer;
begin
    // required in post unicode versions
    inherited Moveby(distance);

    inc( FCurRecord, distance );
    if FCurRecord < 0 then
    begin
         FCurRecord := 0;
         FBOF := true;
         FEOF := false;
    end;
    result := 0;
end;

procedure TQRAbsTable.InternalClose;
begin
    //ClearData;
    DestroyFields;
end;

procedure TQRAbsTable.ClearData;
begin
    FFieldnames.Clear;
    Fielddefs.Clear;
    FDoneFielddefs := false;
end;

procedure TQRAbsTable.CreateFields;
begin
    inherited;
end;

function TQRAbsTable.AllocRecordBuffer: PByte;
begin
       Result := AllocMem(FRecBufSize);
end;

procedure TQRAbsTable.FreeRecordBuffer(var Buffer: PByte);
begin
    FreeMem( buffer );
end;

procedure TQRAbsTable.GetBookmarkData(Buffer: PByte; Data: Pointer);
begin
end;

function TQRAbsTable.GetBookmarkFlag(Buffer: PByte): TBookmarkFlag;
begin
     result := bfBOF;
end;

procedure TQRAbsTable.Next;
begin
     inc(FCurRecord);
end;

function TQRAbsTable.GetRecord(Buffer: PByte; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
begin
     result := grOK;
     FCurrentGetOp := getMode;
      if (FLastGetOp = gmPrior) and (FCurrentGetOp = gmNext)then
      begin
          // restore last record - don't call get data
          //copyMemory( buffer, FSwapBuffer, FRecBufSize);
          FLastGetOp := gmNext;
          exit;
      end;
     if getmode = gmPrior then
     begin
          dec(FCurRecord);
          if fcurrecord < 0 then
          begin
              fcurrecord := 0;
              result := grBOF;
          end;
          // back to previous data
          //copyMemory( FSwapBuffer, buffer, FRecBufSize);
          //copyMemory( buffer, FSavedBuffer, FRecBufSize);
          FLastGetOp := gmPrior;
     end
     else if getmode = gmNext then
     begin
        FMoredata := false;
        if assigned( FOnGetRecord) then
             FOnGetRecord( Self, FMoreData);
        // Here we test if the last Event has returned MoreData
        if Not FMoreData then
        begin
           // No more data needed => grEOF
           result := grEOF;
           exit;
        end;
        inc(FCurRecord);
        FLastGetOp := gmNext;
     end;
end;

function TQRAbsTable.GetRecordSize: Word;
begin
       Result := FRecordSize;
end;

procedure TQRAbsTable.InternalAddRecord(Buffer: Pointer; Append: Boolean);
begin
     // read only
end;

procedure TQRAbsTable.InternalDelete;
begin
   // read only
end;

procedure TQRAbsTable.InternalFirst;
begin
    FCurRecord := 0;
    // Two lines added here :
    FBOF := true;
    FEOF := false;
end;

procedure TQRAbsTable.InternalGotoBookmark(Bookmark: Pointer);
begin

end;

procedure TQRAbsTable.InternalHandleException;
begin

end;

procedure TQRAbsTable.InternalInitFieldDefs;
begin
   //inherited InternalInitFieldDefs;
   FDoneFielddefs := true;
end;

procedure TQRAbsTable.InternalInitRecord(Buffer: PByte);
begin
end;

procedure TQRAbsTable.InternalLast;
begin
    //FCurRecord := FRecordcount;
end;

procedure TQRAbsTable.InternalPost;
begin

end;

procedure TQRAbsTable.InternalSetToRecord(Buffer: PByte);
begin

end;

function TQRAbsTable.IsCursorOpen: Boolean;
begin
    result := FDoneFielddefs;
end;

procedure TQRAbsTable.SetBookmarkFlag(Buffer: PByte; Value: TBookmarkFlag);
begin

end;

procedure TQRAbsTable.SetBookmarkData(Buffer: PByte; Data: Pointer);
begin

end;

procedure TQRAbsTable.SetFieldData(Field: TField; Buffer: Pointer);
begin
end;

procedure TQRAbsTable.SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean);
begin
end;

function TQRAbsTable.GetFieldData(Field: TField; Buffer: Pointer;
  NativeFormat: Boolean): Boolean;
begin
  Result:=GetFieldData(Field,Buffer);
end;

function TQRAbsTable.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
    strval : string;
begin
  try
      result := true;
      if FCurrentGetOp = gmPrior then
          exit;
      if (FLastGetOp = gmPrior) and (FCurrentGetOp = gmNext) then
          exit;
      if assigned(FOnSetFieldValue) then
      begin
            FOnSetFieldValue( strval, field, buffer );
            // copy the buffer to the saved buffer
            //copyMemory(pchar(FSavedBuffer), PChar(buffer), FRecBufSize );
            exit;
      end
      else
          strpcopy(pchar(Buffer), 'Unset' );
    except
      result := false;
      FEOF := true;
    end;
end;

// added by DCA on 17/05/2013
{$IFDEF VER240} // XE3
function TQRAbsTable.GetFieldData(Field: TField; Buffer: TValueBuffer;
  NativeFormat: Boolean): Boolean;
begin
  Result := GetFieldData(Field, Pointer(Buffer), NativeFormat);
end;

function TQRAbsTable.GetFieldData(Field: TField; Buffer: TValueBuffer): Boolean;
begin
  Result := GetFieldData(Field, Pointer(Buffer));
end;
{$ENDIF}
// end of adding

function TQRAbsTable.GetRecordCount: Longint;
begin
  Result := FRecordCount;
end;

procedure TQRAbsTable.ActivateBuffers;
begin
   inherited;
end;

//**************************** Utils **************************
function LastChar( ss : string ) : char;
begin
     result := ss[ length(ss) ];
end;

Function StripXChars( ss : string ) : string;
begin
    if charInSet(lastchar( ss ), [ '+', '*', '?' ]) then
        result := copy( ss, 1, length(ss)-1)
    else
        result := ss;
end;

end.
