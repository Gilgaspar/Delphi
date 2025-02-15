unit vcl.Wwfltdum;
{
//
// Components : TwwDummyForm
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
// 9/5/97 - Missing not when checking for null field on Datetime and Time Fields
// 11/06/97 - Added handling for international support by adding Ansi functions.
// 1/9/98 - Support BCD in range test
// 1/9/98 - Convert to datatypes for true comparison
// 2/24/98 - Support ending range pad character
// 3/25/98 - Support auto-padding of upper range character
// 3/25/98 - Support case insensitive ranges
// 3/9/99 - Exit if Null string entered to prevent exception. -PYW-
// 5/20/99 - RSW - No time entered so add 1 to date and use >=
// 1/17/2000 - Don't try to load form resource as this is just a dummy form
// 6/07/00 - PYW - Check for timeseparator when filtering on datetimes.  This will allow
//                 an enduser to filter on a datetime field with a zero time value.
// 7/10/02 - Support fmtBCD data type
}
interface

{$i wwIfDef.pas}

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, dialogs, StdCtrls, db,
  wwtypes,
  comctrls
{$ifdef wwDelphi5Up}
//,adodb
{$endif}
  ;

type


  TwwDummyForm = class(TCustomForm)
  private
     FFilterParam: TParam;
     FFilterFieldBuffer: PAnsiChar;
  public
     DlgComponent: TComponent;
     MatchAny: boolean;
     DataSet: TDataSet;
     MemoryStream: TStringStream;
     TempRichEdit: TCustomRichEdit;
     Procedure OnFilterEvent(table: TDataSet; var Accept: boolean);
     Function GetFilterField(AFieldName: string): TParam;
     Function IsNullValue(Token,Value,NullStr: string): boolean;
     Function CheckFilterField(Index:integer): boolean;
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
  end;

var
  wwDummyForm: TwwDummyForm;

implementation

uses wwfltdlg, wwstr, wwcommon, dbconsts, wwsystem;


constructor TwwDummyForm.Create(AOwner: TComponent);
begin
   { 1/17/2000 - Don't try to load form resource as this is just a dummy form }
   GlobalNameSpace.BeginWrite;
   try
     CreateNew(AOwner);
   finally
     GlobalNameSpace.EndWrite;
   end;

//   inherited Create(AOwner);
//   GetMem(FFilterFieldBuffer, 256);
   GetMem(FFilterFieldBuffer, 32767); // 3/9/12 - Accomodate larger tfield types
   FFilterParam:= TParam.create(nil, ptUnknown);
end;

destructor TwwDummyForm.Destroy;
begin
   FreeMem(FFilterFieldBuffer, 32767);
//   FreeMem(FFilterFieldBuffer, 256);
   FFilterParam.Free;
   if MemoryStream<>Nil then MemoryStream.Free;
   if TempRichEdit<>Nil then TempRichEdit.Free;
   inherited Destroy;
end;


Function TwwDummyForm.IsNullValue(Token,Value,NullStr: string): boolean;
begin
{If the current Token is the NullCharacter and the Value is Null then return true.}
   result := ((Value = '') and (AnsiCompareText(Token,NullStr)=0));
end;

// 8/25/12 - See if we can call tfield.assignfieldvalue instead of converting everything ourselves
Function TwwDummyForm.GetFilterField(AFieldName: string): TParam;
type
    TMethodFunction = function(AFieldName: string): TParam of object;

var curField, otherField: TField;
    method: TMethod;
begin
   method.data:= Dataset;
   method.code:= dataset.MethodAddress('wwFilterField');
   if method.code<>nil then
   begin
      result:= TMethodFunction(method)(AFieldName)
   end

//   if DataSet is TwwQuery then result:= (DataSet as TwwQuery).wwFilterField(AFieldName)
//   else if DataSet is TwwQBE then result:= (DataSet as TwwQBE).wwFilterField(AFieldName)
//   else if DataSet is TwwStoredProc then result:= (DataSet as TwwStoredProc).wwFilterField(AFieldName)
//   else if DataSet is TwwTable then result:= (DataSet as TwwTable).wwFilterField(AFieldName)
   else begin
      curField:= dataset.findField(AFieldName);
      if curField=Nil then begin
        {$ifdef wwDelphi3Up}
         DatabaseErrorFmt(SFieldNotFound, [AFieldName, AFieldName]);
        {$else}
         DBErrorFmt(SFieldNotFound, [AFieldName]);
        {$endif}
      end

     { Calculated fields supported natively by OnFilterRecord event for these dataset types }
      else if wwIsClass(DataSet.ClassType, 'TCustomADODataSet') or
           wwIsClass(DataSet.ClassType, 'TIBCustomDataSet') then
      begin
          //FFilterParam.DataType:= curField.DataType;
          //wwConvertFieldToParam(curField,FFilterParam,FFilterFieldBuffer);
          FFilterParam.AssignFieldValue(curField, curField.Value);

      end

      else begin
         if curfield.lookup then { Support lookupfields on clientdatasets or virtual datasets }
         begin
            method.data:= nil;
            method.code:= nil;
            otherField:= wwDataSet_GetFilterLookupField(dataSet, curfield, method);
            FFilterParam.AssignFieldValue(otherField, otherField.Value);

            //FFilterParam.DataType:= curField.DataType;
            //wwConvertFieldToParam(otherField,FFilterParam,FFilterFieldBuffer);
         end
         else begin
            FFilterParam.AssignFieldValue(curField, curField.Value);
{            if curfield.datatype = ftTimeStamp then  // 10/25/02 - Treat as datetime for callback filter
               FFilterParam.DataType:= ftDateTime
            else
               FFilterParam.DataType:= curField.DataType;
            wwConvertFieldToParam(curField,FFilterParam,FFilterFieldBuffer);
}
         end
      end;
      result:= FFilterParam;
   end
end;

Function TwwDummyForm.CheckFilterField(Index:Integer):boolean;
var
    FilterValue, FilterFieldName, RecordFieldValue: string;
    CheckMemoStr: string;
    //matchPtr: PChar;
    matchPtr: PChar;
    numread: cardinal;
    MemoBuffer: PChar;
    MemoString: string;

    FilterValuePtr: packed array[0..255] of char;

    FilterField: TField;
    tempDataType: TFieldType;
    CurPos: Integer;
    OrFlg, AndFlg: Boolean;
    SearchDelimiter: string;
    Token: string;
    tempDatetime: TParam;

    FieldOps: TwwFieldOperators;
    tempComponent: TwwFilterDialog;
    FldInfo: TwwFieldInfo;
    TempMinValue, TempMaxValue: string;
    TempDate: TDateTime;

//    DataSize: integer;

  { 1/9/98 - Compare value type fields as values instead of strings }
  function TokenEqual(t1,t2:String; DataType:TFieldType):Boolean;
  begin
     Result := False;

     if t1=t2 then begin
        result:= true;
        exit;
     end;

     if DataType=ftString then exit;

     { avoid exceptions for null values }
     if (trim(t1)='') and (trim(t2)<>'') then Exit;
     if (trim(t2)='') and (trim(t1)<>'') then Exit;

     //3/9/99 - PYW- Exit if Null string entered to prevent exception.
     if (AnsiCompareText(t1,FieldOps.NullChar)=0) then exit;

     case DataType of
       ftDate: Result := StrToDate(t1)=StrToDate(t2);
       {$ifdef wwDelphi6Up}
       ftTimeStamp,
       {$endif}
       ftDateTime: Result := StrToDateTime(t1)=StrToDateTime(t2);
       ftTime: Result := StrToTime(t1)=StrToTime(t2);
       ftSmallInt, ftInteger, ftWord: Result := StrToInt(t1)=StrToInt(t2);
       {$ifdef wwDelphi6Up}
       ftFMTBcd,
       {$endif}

       {$ifdef wwDelphi2011Up}
       ftSingle,
       {$endif}

       ftFloat, ftCurrency, ftBCD: Result := StrToFloat(t1)=StrToFloat(t2);
     else
       Result := False;
     end;
  end;

begin

   TempComponent:= (DlgComponent as TwwFilterDialog);

   FldInfo:= TwwFieldInfo(tempComponent.FieldInfo[Index]);
   if (FldInfo.FieldName='') or (DataSet.FindField(FldInfo.FieldName)=nil) then  { Compute field name from displaylabel if unspecified }
      FldInfo.FieldName:= wwGetFieldNameFromTitle(DataSet, FldInfo.DisplayLabel);

   FieldOps := TempComponent.FieldOperators;
   FilterFieldName:= FldInfo.FieldName;
   FilterField:= DataSet.FindField(FilterFieldName);

   FilterValue:= FldInfo.Filtervalue;

   Result:=True;

   if (FldInfo.MatchType <> fdMatchRange) then begin

      {Find if And or Or Token is in the FilterValue}
      SearchDelimiter := wwGetFilterOperator(FilterValue,FieldOps,OrFlg,AndFlg);

      {If OrFlg then initialize to false and find first case that is true}
      if (OrFlg) then Result:= False;

   end;

   if (FilterField<>Nil) and (FilterField is TBlobField ) then begin //(FilterField.dataType = ftMemo) then begin
      MemoBuffer:= tempComponent.MemoBuffer;

      if wwIsClass(dataset, 'TBDEDataSet') then begin
         MemoString:= GetFilterField(FilterFieldName).asString;
      end
      else begin
         MemoString:= DataSet.FindField(FilterFieldName).asString
      end;
      strcopy(MemoBuffer, PChar(MemoString));
      numRead:= strlen(MemoBuffer);

      if wwIsRichEditField(FilterField, False) then
      //if wwIsRichEditField(FilterField, true) then // Can't examine data with BDE, but can with TClientDataSet. Perhaps should allow this special case
      begin
         RichEditTextToPlainText(self, MemoBuffer, numRead, tempRichEdit, MemoryStream);
      end;

      if not FldInfo.caseSensitive then begin
            AnsiStrUpper(memoBuffer);
            FilterValue:=AnsiUppercase(FilterValue);
      end;
      strpcopy(FiltervaluePtr, Filtervalue);

      CurPos := 1;
      repeat
         if (FldInfo.MatchType <> fdMatchRange) then begin
            token:= wwGetFilterToken(FilterValue,SearchDelimiter,CurPos);
            strpcopy(FiltervaluePtr, token);
         end;

         if strlen(MemoBuffer) = 0 then
            CheckMemoStr := ''             {Null Memo Field}
         else
            CheckMemoStr := 'not null';    {Non Null Memo Field}

         case FldInfo.MatchType of

         fdMatchStart:
           begin

             matchptr:=strPos(MemoBuffer, FilterValuePtr);
             if (OrFlg) then begin
                if (isnullvalue(token,CheckMemoStr,FieldOps.NullChar)) then begin
                   Result := True;
                   break;
                end
                else if (MemoBuffer=matchPtr) then begin
                   Result:=True;
                   break;
                end;
             end
             else begin
                if not isnullvalue(token,CheckMemoStr,FieldOps.NullChar) then
                   if (MemoBuffer<>matchPtr) then begin
                      Result:= False;
                      exit;
                   end
             end;
           end;

         fdMatchAny:
           begin
             matchptr:=strPos(MemoBuffer,FilterValuePtr);
             if (OrFlg) then begin
                if (isnullvalue(token,CheckMemoStr,FieldOps.NullChar)) then
                begin
                   Result := True;
                   break;
                end
                else if (matchPtr <> Nil) then begin
                   Result:=True;
                   break;
                end;
             end
             else begin
                if not isnullvalue(token,CheckMemoStr,FieldOps.NullChar) then
                   if (matchPtr=Nil) then begin
                      Result:= False;
                      exit;
                   end;
                end;
           end;

         fdMatchExact:
           begin
              if (OrFlg) then begin
                 if (isnullvalue(token,CheckMemoStr,FieldOps.NullChar)) then
                    begin
                      Result := True;
                      break;
                    end
                 else if (strlen(FiltervaluePtr)=numread) then begin
                    matchPtr:= strPos(MemoBuffer,FilterValuePtr);
                    if (matchPtr<>Nil) then begin
                       Result:= True;
                       break;
                    end;
                 end;
              end
              else begin
                 if not isnullvalue(token,CheckMemoStr,FieldOps.NullChar) then
                    if strlen(FiltervaluePtr)<>numread then begin
                       Result:= False;
                       exit;
                    end
                    else begin
                       matchPtr:= strPos(MemoBuffer, FilterValuePtr);
                       if matchPtr=Nil then begin
                          Result:= False;
                          exit;
                       end;
                 end;
              end;
           end;

         fdMatchRange:

         end;      {case}

      until (CurPos=-1) or (FldInfo.MatchType=fdMatchRange);

   end
   else begin (* Not Memo Field *)
      RecordFieldValue := '';
      case Filterfield.dataType of
         ftDate:   begin
                   tempDatetime := GetFilterField(FilterFieldName);
                   if not tempDatetime.isnull then
                      RecordFieldValue:= DateToStr(tempDatetime.asDate);
                   end;
         {$ifdef wwDelphi6Up}
         ftTimeStamp,
         {$endif}
         ftDateTime:begin  {9/5/97 - Missing not when checking for null field}
                    tempDatetime := GetFilterField(FilterFieldName);
                    if not tempDatetime.isnull then
                       RecordFieldValue:= DateTimeToStr(tempDatetime.asDateTime);
                    end;
         ftTime:    begin  {9/5/97 - Missing not when checking for null field}
                    tempDatetime := GetFilterField(FilterFieldName);
                    if not tempDatetime.isnull then
                       RecordFieldValue:= TimeToStr(tempDatetime.asTime);
                    end;
         ftWideString:
                    begin
                        { Bypass problem in ADODataSet where it executes callback filter event even though
                          adodataset is at eof or beginning of file }
                       {$ifdef wwDelphi5Up}
//                        if not wwIsClass(FilterField.DataSet.ClassType, 'TCustomADODataSet') or
//                           (not TCustomADODataSet(FilterField.DataSet).RecordSet.bof and
//                            not TCustomADODataSet(FilterField.DataSet).RecordSet.eof) then
                        begin
                           RecordFieldValue:= FilterField.AsString;
                        end
                        {$endif}
                    end;

         else RecordFieldValue:= GetFilterField(FilterFieldName).asString;
      end;

      if not FldInfo.caseSensitive then begin {11/06/97 - Changed to Ansi}
         RecordFieldValue:= AnsiUpperCase(RecordFieldValue);
         FilterValue:= AnsiUppercase(FilterValue);
      end;

      CurPos:= 1;
      repeat

         if (FldInfo.MatchType <> fdMatchRange) then begin
            token:= wwGetFilterToken(FilterValue,SearchDelimiter,CurPos);
            strpcopy(FilterValuePtr,token);
         end;

         case FldInfo.MatchType of
           fdMatchEnd:
              begin
                 if (OrFlg) then begin
                    if (isnullvalue(token,recordfieldvalue,FieldOps.NullChar)) then
                    begin
                       Result := True;
                       break;
                    end
                    else if (length(RecordFieldValue)>=length(token)) and
                        (token <> Copy(RecordFieldValue, length(RecordFieldValue)-length(token)+1, length(token))) then
                    begin
                       Result:= True;
                       exit;
                    end;
                 end
                 else begin
                    if not isnullvalue(token,recordfieldvalue,FieldOps.NullChar) then
                       if (length(RecordFieldValue)<length(token)) or
                          (token <> Copy(RecordFieldValue, length(RecordFieldValue)-length(token)+1, length(token))) then
                       begin
                          Result:= False;
                          exit;
                       end;
                 end
              end;

            fdMatchStart:
              begin
                 if (OrFlg) then begin
                    if (isnullvalue(token,recordfieldvalue,FieldOps.NullChar)) then
                    begin
                       Result := True;
                       break;
                    end
                    else if (pos(token, RecordFieldValue)=1) then begin
                       Result:= True;
                       break;
                    end;
                 end
                 else begin
                    if not isnullvalue(token,recordfieldvalue,FieldOps.NullChar) then
                       if (pos(token, RecordFieldValue)<>1) then begin
                          Result:= False;
                          exit;
                       end
                 end
              end;

            fdMatchAny:
              begin
                 if (OrFlg) then begin
                    if (isnullvalue(token,recordfieldvalue,FieldOps.NullChar)) then
                    begin
                       Result := True;
                       break;
                    end
                    else if (pos(token, RecordFieldValue)<>0) then begin
                       Result:=True;
                       break;
                    end;
                 end
                 else begin
                    if not isnullvalue(token,recordfieldvalue,FieldOps.NullChar) then
                       if (pos(token, RecordFieldValue)=0) then begin
                          Result:= False;
                          exit;
                       end
                 end
              end;

            fdMatchExact:
              begin
                 if (OrFlg) then begin
                    if (isnullvalue(token,recordfieldvalue,FieldOps.NullChar)) then begin
                       Result := True;
                       break;
                    end
                    {1/9/98 - Convert to datatypes for true comparison }
                    else if TokenEqual(token, RecordFieldValue, FilterField.DataType) then
                    begin
                       Result:= True;
                       break;
                    end
                 end
                 else begin    {And Flag or nothing}
                    if not isnullvalue(token,recordfieldvalue,FieldOps.NullChar) then
                       {1/9/98 - Convert to datatypes for true comparison }
                       if not TokenEqual(token, RecordFieldValue, FilterField.DataType) then
                       begin
                          Result:= False;
                          exit;
                       end
                 end
              end;

            fdMatchRange:
              begin
                 tempDataType:= FilterField.dataType;
                 if tempDataType = ftAutoInc then tempDataType:= ftInteger;

                 case tempDataType of
                    ftDate:
                          if (FldInfo.MinValue<>'') and
                             (GetFilterField(FilterFieldName).asDate<StrToDate(FldInfo.MinValue)) then
                          begin
                             Result:= False;
                             exit;
                          end
                          else if (FldInfo.MaxValue<>'') and
                                  (GetFilterfield(FilterFieldName).asDate>StrToDate(FldInfo.MaxValue)) then
                          begin
                             Result:= False;
                             exit;
                          end;

                    {$ifdef wwDelphi6Up}
                    ftTimeStamp,
                    {$endif}
                    ftDateTime:
                          if (FldInfo.MinValue<>'') and
                             (GetFilterField(FilterFieldName).asDateTime<StrToDateTime(FldInfo.MinValue)) then
                          begin
                             Result:= False;
                             exit;
                          end
                          else if (FldInfo.MaxValue<>'') then begin
                             TempDate:= StrToDateTime(FldInfo.MaxValue);
                             // 6/07/00 - PYW - Check for timeseparator when filtering on datetimes.  This will allow
                             //                 an enduser to filter on a datetime field with a zero time value.
                             if ((wwDateSeparator <> wwTimeSeparator) and (Pos(wwTimeSeparator,FldInfo.MaxValue) = 0)) or
                                ((wwDateSeparator = wwTimeSeparator) and (TempDate-Trunc(TempDate)=0)) then
                             { 5/20/99 - RSW - No time entered so add 1 to date and use >= }
                             begin
                                TempDate:= TempDate + 1;
                                if (GetFilterField(FilterFieldName).asDateTime>=TempDate) then
                                begin
                                   Result:= False;
                                   exit;
                                end
                             end
                             else begin
                                if (GetFilterfield(FilterFieldName).asDateTime>TempDate) then
                                begin
                                   Result:= False;
                                   exit;
                                end
                             end
                          end;

                    ftTime:
                          if (FldInfo.MinValue<>'') and
                             (GetFilterField(FilterFieldName).asTime<StrToTime(FldInfo.MinValue)) then
                          begin
                             Result:= False;
                             exit;
                          end
                          else if (FldInfo.MaxValue<>'') and
                                  (GetFilterfield(FilterFieldName).asTime>StrTotime(FldInfo.MaxValue)) then
                          begin
                             Result:= False;
                             exit;
                          end;

                    ftSmallInt, ftInteger, ftWord:
                          if (FldInfo.MinValue<>'') and
                             (GetFilterField(FilterFieldName).asInteger<StrToInt(FldInfo.MinValue)) then
                          begin
                             Result:= False;
                             exit;
                          end
                          else if (FldInfo.MaxValue<>'') and
                                  (GetFilterfield(FilterFieldName).asInteger>StrToInt(FldInfo.MaxValue)) then
                          begin
                             Result:= False;
                             exit;
                          end;

                    {$ifdef wwDelphi6Up}
                    ftFMTBcd,
                    {$endif}

                    {$ifdef wwDelphi2011Up}
                    ftSingle,
                    {$endif}

                    ftFloat, ftCurrency, ftBCD { 1/9/98 - Support BCD} :
                          if (FldInfo.MinValue<>'') and
                             (GetFilterField(FilterFieldName).asFloat+TwwFilterDialog(DlgComponent).Rounding.Epsilon<StrToFloat(FldInfo.MinValue)) then
                          begin
                             Result:= False;
                             exit;
                          end
                          else if (FldInfo.MaxValue<>'') and
                                  (GetFilterfield(FilterFieldName).asFloat-TwwFilterDialog(DlgComponent).Rounding.Epsilon>StrToFloat(FldInfo.MaxValue)) then
                          begin
                             Result:= False;
                             exit;
                          end;

                    ftString, ftWideString:  begin // Add ftWideString
                          if not FldInfo.caseSensitive then begin
                             TempMinValue:= AnsiUpperCase(FldInfo.MinValue);
                             TempMaxValue:= AnsiUpperCase(FldInfo.MaxValue);
                          end
                          else begin
                             TempMinValue:= FldInfo.MinValue;
                             TempMaxValue:= FldInfo.MaxValue;
                          end;

                          if (FldInfo.MinValue<>'') and
                             (RecordFieldValue<TempMinValue) then
                          begin
                             Result:= False;
                             exit;
                          end
                          else begin
                             TempMaxValue:= wwPadUpperRange(FilterField.size,
                                TempMaxValue, TempComponent.UpperRangePadChar);
                             if (FldInfo.MaxValue<>'') and
                                (RecordFieldValue>TempMaxValue) then
                             begin
                                Result:= False;
                                exit;
                             end
                          end
                       end;
                 end; {end case for tempDataType}
             end; {End MatchRange}
         end; {End case;}
      until (CurPos= -1) or (FldInfo.MatchType=fdMatchRange);
   end;

end;

type
  TwwCheatFilterDialog = class(TwwFilterDialog);

{ Don't use try finally block because performance dramatically slows down }
Procedure TwwDummyForm.OnFilterEvent(table: TDataSet; var Accept: boolean);
var i: integer;
    tempComponent: TwwFilterDialog;
    FldInfo:TwwFieldInfo;
    DefaultFiltering: boolean;
begin
   tempComponent:= (DlgComponent as TwwFilterDialog);
   DataSet:= table;

   Accept:= True;
   { Give developer a chance to skip filtering in case of ADO bad record }
   DefaultFiltering:= True;
   TwwCheatFilterDialog(tempComponent).DoAcceptFilterRecord(table, Accept, DefaultFiltering);
   if (not Accept) or (not DefaultFiltering) then exit;

   for i:= 0 to tempComponent.FieldInfo.count-1 do begin
      FldInfo:= TwwFieldInfo(tempComponent.FieldInfo[i]);
      if FldInfo.FieldName='' then  { Compute field name from displaylabel if unspecified }
        FldInfo.FieldName:= wwGetFieldNameFromTitle(DataSet, FldInfo.DisplayLabel);

      Accept := CheckFilterField(i);

      if ((FldInfo.NonMatching) and (FldInfo.MatchType <> fdMatchRange)) then
         Accept := not Accept;      {3/10/97 - Added NonMatching support for values}

      if not Accept then break;
   end; {end for}
end;

//{$R *.DFM}

end.
