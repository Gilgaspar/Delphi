{
//
// Components : System routines
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
// 12/16/98 - Add epoch property for Delphi 4 support of TwwDBEdit.
// 8/15/2001 - Keep scanning for other digits in wwStrToFloat2.
// 5/7/03 - In case of null string in wwStrtoFloat2
}
unit vcl.Wwsystem;

{$N+,P+,S-,G+,R-}

interface

{$i wwIfDef.pas}

uses sysutils, stdctrls;

type
  TwwDateOrder = (doMDY, doDMY, doYMD);
  TwwDateTimeSelection = (wwdsDay, wwdsMonth, wwdsYear, wwdsHour, wwdsMinute, wwdsSecond, wwdsAMPM);

function wwStrToDate(const S: string): boolean;
function wwStrToTime(const S: string): boolean;
function wwStrToDateTime(const S: string): boolean;
function wwStrToTimeVal(const S: string): TDateTime;
function wwStrToDateVal(const S: string): TDateTime;
function wwStrToDateTimeVal(const S: string): TDateTime;
function wwStrToInt(const S: string): boolean;
function wwStrToFloat(const S: string): boolean;
function wwGetDateOrder(const DateFormat: string): TwwDateOrder;
function wwNextDay(Year, Month, Day: Word): integer;
function wwPriorDay(Year, Month, Day: Word): integer;
function wwDoEncodeDate(Year, Month, Day: Word; var Date: TDateTime): Boolean;
function wwDoEncodeTime(Hour, Min, Sec, MSec: Word; var Time: TDateTime): Boolean;
Function wwGetDateTimeCursorPosition(SelStart: integer; Text: string;
    TimeOnly: Boolean): TwwDateTimeSelection;
Function wwGetTimeCursorPosition(SelStart: integer; Text: string): TwwDateTimeSelection;
function wwScanDate(const S: string; var Date: TDateTime): Boolean;
{$ifdef wwdelphi4up}
function wwScanDateEpoch(const S: string; var Date: TDateTime; Epoch: integer): Boolean;
{$endif}
Procedure wwSetDateTimeCursorSelection(dateCursor: TwwDateTimeSelection;
    edit: TCustomEdit; TimeOnly: Boolean);
function wwStrToFloat2(const S: string; var FloatValue: Extended; DisplayFormat: string): boolean;
Function wwLongMonthNames(month: integer): string;
Function wwShortMonthNames(month: integer): string;
Function wwLongDayNames(day: integer): string;
Function wwShortDayNames(day: integer): string;
Function wwShortDateFormat: string;
Function wwLongDateFormat: string;
Function wwLongTimeFormat: string;
Function wwShortTimeFormat: string;
Function wwDateSeparator: Char;
Function wwTimeSeparator: Char;
Function wwTimeAMString: string;
Function wwTimePMString: string;
Function wwCurrencyString: string;
Function wwDecimalSeparator: string;
Function wwThousandSeparator: string;

implementation

uses
   Windows,
   wwstr;

type
  PDayTable = ^TDayTable;
  TDayTable = array[1..12] of Word;

function CurrentYear: Word;
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := SystemTime.wYear;
end;

function LongMul(I, J: Word): Integer;
begin
  Result := I * J;
end;

procedure ScanBlanks(const S: string; var Pos: Integer);
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(S)) and (S[I] = ' ') do Inc(I);
  Pos := I;
end;

function ScanNumber(const S: string; var Pos: Integer;
  var Number: Word): Boolean;
var
  I: Integer;
  N: Word;

  Function MonthStrToInt(s: string; var num: word): boolean;
  var i: integer;
  begin
     result:= False;
     for i:= 1 to 12 do begin
        // 2/12/06 - Use Ansi functions
        if AnsiUppercase(s)=AnsiUppercase(wwShortMonthNames(i)) then
        begin
           num:= i;
           result:= True;
           break;
        end
     end
  end;

begin
  Result := False;
  ScanBlanks(S, Pos);
  I := Pos;
  N := 0;
  while (I <= Length(S)) and (S[i]>='0') and (S[i]<='9') and (N<1000) do
//  while (I <= Length(S)) and (S[I] in ['0'..'9']) and (N < 1000) do
  begin
    N := N * 10 + (Ord(S[I]) - Ord('0'));
    Inc(I);
  end;
  if I > Pos then
  begin
    Pos := I;
    Number := N;
    Result := True;
  end;

  if (not Result) and MonthStrToInt(copy(s, i, 3), N) then
  begin
     Pos:= i+3;
     Number:= N;
     Result:= True;
  end
end;

function ScanString(const S: string; var Pos: Integer;
  const Symbol: string): Boolean;
begin
  Result := False;
  if Symbol <> '' then
  begin
    ScanBlanks(S, Pos);
    if AnsiCompareText(Symbol, Copy(S, Pos, Length(Symbol))) = 0 then
    begin
      Inc(Pos, Length(Symbol));
      Result := True;
    end;
  end;
end;

function ScanChar(const S: string; var Pos: Integer; Ch: Char): Boolean;
begin
  Result := False;
  ScanBlanks(S, Pos);
  if (Pos <= Length(S)) and (S[Pos] = Ch) then
  begin
    Inc(Pos);
    Result := True;
  end;
end;


function wwGetDateOrder(const DateFormat: string): TwwDateOrder;
var
  I: Integer;
begin
  I := 1;
  Result := doMDY;
  while I <= Length(DateFormat) do
  begin
    case Chr(Ord(DateFormat[I]) and $DF) of
      'Y': Result := doYMD;
      'M': Result := doMDY;
      'D': Result := doDMY;
    else
      Inc(I);
      Continue;
    end;
    Exit;
  end;
  Result := doMDY;
end;

function IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function GetDayTable(Year: Word): PDayTable;
const
  DayTable1: TDayTable = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  DayTable2: TDayTable = (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  DayTables: array[Boolean] of PDayTable = (@DayTable1, @DayTable2);
begin
  Result := DayTables[IsLeapYear(Year)];
end;

function wwNextDay(Year, Month, Day: Word): integer;
var DayTable: PDayTable;
begin
   DayTable := GetDayTable(Year);
   if Day>=DayTable^[Month] then Result:= 1 else Result:= Day + 1;
end;

function wwPriorDay(Year, Month, Day: Word): integer;
var DayTable: PDayTable;
begin
   DayTable := GetDayTable(Year);
   if Day=1 then Result:= DayTable^[Month] else Result:= Day-1;
end;

function wwDoEncodeDate(Year, Month, Day: Word; var Date: TDateTime): Boolean;
var
  I: Word;
  DayTable: PDayTable;
begin
  Result := False;
  DayTable := GetDayTable(Year);
  if (Year >= 1) and (Year <= 9999) and (Month >= 1) and (Month <= 12) and
    (Day >= 1) and (Day <= DayTable^[Month]) then
  begin
    for I := 1 to Month - 1 do Inc(Day, DayTable^[I]);
    I := Year - 1;
    Date := LongMul(I, 365) + (Day + I div 4 - I div 100 + I div 400);
    Date:= Date - DateDelta;
    Result := True;
  end;
end;

function ScanDateEpoch(const S: string; var Pos: Integer;
  var Date: TDateTime; Epoch: integer): Boolean;
var
  DateOrder: TwwDateOrder;
  N1, N2, N3, Y, M, D: Word;
begin
  Result := False;
  DateOrder := wwGetDateOrder(wwShortDateFormat);
  if not (ScanNumber(S, Pos, N1) and ScanChar(S, Pos, wwDateSeparator) and
    ScanNumber(S, Pos, N2)) then Exit;
  if ScanChar(S, Pos, wwDateSeparator) then
  begin
    if not ScanNumber(S, Pos, N3) then Exit;
    case DateOrder of
      doMDY: begin Y := N3; M := N1; D := N2; end;
      doDMY: begin Y := N3; M := N2; D := N1; end;
      doYMD: begin Y := N1; M := N2; D := N3; end;
      else begin Y := N1; M := N2; D := N3; end;{ Unnecessary but avoids compiler warning }
    end;

    if (Y<=99) then begin
       y:= (Epoch div 100) * 100 + y;
       if (Y < Epoch) then Inc(Y, 100);

//       if (Y <= 50) then Inc(Y, 2000)
//       else Inc(Y, 1900);
    end;

  end else
  begin
    Y := CurrentYear;
    if DateOrder = doDMY then
    begin
      D := N1; M := N2;
    end else
    begin
      M := N1; D := N2;
    end;
  end;
  ScanBlanks(S, Pos);
  Result := wwDoEncodeDate(Y, M, D, Date);
end;

function ScanDate(const S: string; var Pos: Integer;
  var Date: TDateTime): Boolean;
begin
   result:= ScanDateEpoch(S, Pos, Date, 1950);
end;


function wwScanDate(const S: string; var Date: TDateTime): Boolean;
var
  Pos: Integer;
begin
  Pos := 1;
  result:= ScanDate(S, Pos, Date);
end;

// 12/16/98 - Add epoch property for Delphi 4 support of TwwDBEdit.
{$ifdef wwdelphi4up}
function wwScanDateEpoch(const S: string; var Date: TDateTime; Epoch: integer): Boolean;
var
  Pos: Integer;
begin
  Pos := 1;
  result:= ScanDateEpoch(S, Pos, Date, Epoch);
end;
{$endif}

function wwDoEncodeTime(Hour, Min, Sec, MSec: Word; var Time: TDateTime): Boolean;
begin
  Result := False;
  if (Hour < 24) and (Min < 60) and (Sec < 60) and (MSec < 1000) then
  begin
    Time := (LongMul(Hour * 60 + Min, 60000) + Sec * 1000 + MSec) / MSecsPerDay;
    Result := True;
  end;
end;


function ScanTime(const S: string; var Pos: Integer;
  var Time: TDateTime): Boolean;
var
  BaseHour: Integer;
  Hour, Min, Sec: Word;
begin
  Result := False;
  if not (ScanNumber(S, Pos, Hour) and ScanChar(S, Pos, wwTimeSeparator) and
    ScanNumber(S, Pos, Min)) then Exit;
  Sec := 0;
  if ScanChar(S, Pos, wwTimeSeparator) then
    if not ScanNumber(S, Pos, Sec) then Exit;
  BaseHour := -1;
  if ScanString(S, Pos, wwTimeAMString) or ScanString(S, Pos, 'AM') then
    BaseHour := 0
  else
    if ScanString(S, Pos, wwTimePMString) or ScanString(S, Pos, 'PM') then
      BaseHour := 12;
  if BaseHour >= 0 then
  begin
    if (Hour = 0) or (Hour > 12) then Exit;
    if Hour = 12 then Hour := 0;
    Inc(Hour, BaseHour);
  end;
  ScanBlanks(S, Pos);
  Result := wwDoEncodeTime(Hour, Min, Sec, 0, Time);
end;


function wwStrToDate(const S: string): boolean;
var
  Pos: Integer;
  Date: TDateTime;
begin
  Pos := 1;
  result:= ScanDate(S, Pos, Date) and (Pos > Length(S))
end;

function wwStrToTime(const S: string): boolean;
var
  Pos: Integer;
  Time: TDateTime;
begin
  Pos := 1;
  result:=  ScanTime(S, Pos, Time) and (Pos > Length(S));
end;

function wwStrToDateTime(const S: string): boolean;
var
  Pos: Integer;
  Date, Time: TDateTime;
begin
  Pos := 1;
  Time := 0;
  result:=  ScanDate(S, Pos, Date) and
            ScanTime(S, Pos, Time) and (Pos > Length(S))
end;

function wwStrToDateTimeVal(const S: string): TDateTime;
var
  Pos: Integer;
  Date, Time: TDateTime;
begin
  Pos := 1;
  Time := 0;
  if ScanDate(S, Pos, Date) and
     ScanTime(S, Pos, Time) and (Pos > Length(S)) then
  begin
     Result := (Date + Time);
  end
  else result:= 0;
end;

function wwStrToDateVal(const S: string): TDateTime;
var
  Pos: Integer;
  Date: TDateTime;
begin
  Pos := 1;
  if ScanDate(S, Pos, Date) then
  begin
     Result := Date;
  end
  else result:= 0;
end;

function wwStrToTimeVal(const S: string): TDateTime;
var
  Pos: Integer;
  Time: TDateTime;
begin
  Pos := 1;
  if ScanTime(S, Pos, Time) and (Pos > Length(S)) then
     Result:= Time
  else Result:= 0;
end;

function wwStrToInt(const S: string): boolean;
var i: integer;
begin
   result:= True;
   for i:= 1 to length(s) do begin
      if not strCharMatch(s[i], '0123456789') then begin
      //if not (s[i] in ['0'..'9']) then begin
         if (i=1) and (s[i]='-') and (length(s)>1) then continue;
         result:= False;
         exit;
      end
   end
end;

function wwStrToFloat(const S: string): boolean;
//var Buffer: array[0..63] of char;
var
    Temp: Double;
begin
   result:= True;
   if length(s)=0 then exit;
   result:= TryStrToFloat(S, Temp);
//   result:= TextToFloat(StrPLCopy(Buffer, S, Sizeof(Buffer)-1), Temp, fvExtended);
end;
{
function wwStrToFloat(const S: string): boolean;
var Buffer: array[0..63] of char;
    Temp: Extended;
begin
   result:= True;
   if length(s)=0 then exit;
   result:= TextToFloat(StrPLCopy(Buffer, S, Sizeof(Buffer)-1), Temp, fvExtended);
end;
 }
Function wwGetDateTimeCursorPosition(SelStart: integer; Text: string;
    TimeOnly: Boolean): TwwDateTimeSelection;
var curPos, curitem: integer;
    dateOrder: TwwDateOrder;
    Date: TDateTime;
    SecondPos: integer;
begin
   curPos:= 1;
   result:= wwdsDay; { makes compiler happy }
   if (TimeOnly or (ScanDate(Text, CurPos, Date) and
      ((CurPos <= SelStart) or  { SelStart is past date }
      ((curPos=selStart+1) and (Text[selStart]=' '))))) then
   begin
      curItem:= 0;
      SecondPos:= 100;
      repeat
          if (strGetToken(Text, wwTimeSeparator, curpos)='') then break;
          if (curpos=-1) or (curPos-1>selStart) then break;
          if (curItem=1) then SecondPos:= curPos-1;
          curPos:= curPos + 1;
          inc(curItem);
      until False;

      case curItem of
         0: result:= wwdsHour;
         1: result:= wwdsMinute;
         else result:= wwdsSecond;
      end;

      if (curItem=2) then
         if (selStart>SecondPos+2) then
            result:= wwdsAMPM;
      exit;
   end;

   curPos:= 1;
   curItem:= 0;
   repeat
       if (strGetToken(Text, wwDateSeparator, curpos)='') then break;
       if (curpos=-1) or (curPos-1>selStart) then break;
       inc(curItem);
   until False;

   DateOrder:= wwGetDateOrder(wwShortDateFormat);
   case curItem of
      0: case DateOrder of
             dodmy: result:= wwdsDay;
             doymd: result:= wwdsYear;
             domdy: result:= wwdsMonth;
         end;
     1: case DateOrder of
             dodmy, doymd: result:= wwdsMonth;
             domdy: result:= wwdsDay;
        end;
     2: case DateOrder of
             dodmy, domdy: result:= wwdsYear;
             doymd: result:= wwdsDay;
        end;
   end;
end;

Function wwGetTimeCursorPosition(SelStart: integer;
    Text: string): TwwDateTimeSelection;
var curPos, curitem: integer;
    SecondPos: integer;
begin
   curPos:= 1;
   result:= wwdsHour; { makes compiler happy }
   if (CurPos <= SelStart) then
   begin
      curItem:= 0;
      SecondPos:= 100;
      repeat
          if (strGetToken(Text, wwTimeSeparator, curpos)='') then break;
          if (curpos=-1) or (curPos-1>selStart) then break;
          if (curItem=1) then SecondPos:= curPos-1;
          curPos:= curPos + 1;
          inc(curItem);
      until False;

      case curItem of
         0: result:= wwdsHour;
         1: result:= wwdsMinute;
         else result:= wwdsSecond;
      end;

      if (curItem=2) then
         if (selStart>SecondPos+2) then
            result:= wwdsAMPM;
      exit;
   end;
end;

Procedure wwSetDateTimeCursorSelection(
   dateCursor: TwwDateTimeSelection; edit: TCustomEdit;
     TimeOnly: Boolean);
var dateOrder: TwwDateOrder;
    i, curpos, prevpos, matchNo: integer;
    matchText: string;
    Date: TDateTime;
    spacePos: integer;
begin
   if DateCursor in [wwdsDay, wwdsYear, wwdsMonth] then
   begin
      matchNo:= 0;  {4/23/97 - Added to remove compiler warning}
      DateOrder:= wwGetDateOrder(wwShortDateFormat);
      case DateCursor of
        wwdsDay:
          case DateOrder of
            dodmy: matchNo:= 0;
            doymd: matchNo:= 2;
            domdy: matchNo:= 1;
          end;
        wwdsYear:
          case DateOrder of
            dodmy: matchNo:= 2;
            doymd: matchNo:= 0;
            domdy: matchNo:= 2;
          end;
        wwdsMonth:
          case DateOrder of
            dodmy: matchNo:= 1;
            doymd: matchNo:= 1;
            domdy: matchNo:= 0;
          end;
        else matchNo:= 0;
      end;

      curPos:= 1;
      prevPos := 1;
      for i:= 0 to MatchNo do
      begin
         prevPos:= curPos;
         matchText:= strGetToken(Edit.Text, wwDateSeparator, curpos);

         spacePos:= pos(' ', matchText);
         if spacePos>0 then
            matchText:= copy(matchText, 1, spacePos-1);
      end;

      Edit.selStart:= prevPos-1;
      Edit.selLength:= length(MatchText);

   end
   else begin
      CurPos:= 1;
      prevpos:= 1;
      if (timeonly or ScanDate(Edit.Text, CurPos, Date)) then
      begin
         case DateCursor of
           wwdsHour: matchNo:= 0;
           wwdsMinute : matchNo:= 1;
           wwdsSecond : matchNo:= 2;
           wwdsAMPM: matchNo:= 2;
           else matchNo := 0;
         end;

         for i:= 0 to MatchNo do
         begin
            prevPos:= curPos;
            matchText:= strGetToken(Edit.Text, wwTimeSeparator, curpos);

            { Don't include AM/PM }
            if DateCursor=wwdsSecond then begin
               spacePos:= pos(' ', matchText);
               if spacePos>0 then
                  matchText:= copy(matchText, 1, spacePos-1);
            end
            else if DateCursor=wwdsAMPM then begin
               spacePos:= pos(' ', matchText);
               if spacePos>0 then
                  matchText:= copy(matchText, spacePos+1, 255);
               prevPos:= prevPos + spacePos;
            end

         end
      end;

      Edit.selStart:= prevPos-1;
      Edit.selLength:= length(MatchText);
   end

end;
{
// 8/29/06 - Support E in editFormat so that it is not stripped if it is an exponential E
function wwStrToFloat2(const S: string; var FloatValue: Extended; DisplayFormat: string): boolean;
//var Buffer: array[0..63] of char;
//    Temp: Extended;
var  i, startpos: integer;
    FloatString, TempText: string;
    Negative: boolean;
    ValidSet, ValidSet2: StrCharSet;
    lastCharIsExponentialE: boolean;

    function ExponentialE(pos: integer): boolean;
    begin
       result:= false;
       if uppercase(s[pos])='E' then
       begin
          if (pos<length(s)) then
          begin
            if (s[pos+1] in [' ', '-', '+', '0'..'9']) then result:= true
          end
       end
    end;

begin
   result:= True;
   FloatString:= '';
   FloatValue:= 0; // 5/7/03 - In case of null string
   if length(s)=0 then exit;

   //StripLeading non digits
   for i:= 1 to length(s) do
      if s[i] in ['-', '0'..'9', DecimalSeparator, '('] then break;

   startpos:= i;
   Negative:= (s[i]='-');

   //StripLeading non digits again if found negative.
   if Negative then
   begin
     for i:= startpos to length(s) do
        if s[i] in ['0'..'9', DecimalSeparator, '('] then break;
      startpos:= i;
   end;

   lastCharIsExponentialE:= false;

   //Remove commas and decimal point
   for i:= startpos to length(s) do begin
      ValidSet2:= ['0'..'9', DecimalSeparator];
      if (lastCharIsExponentialE) then
         ValidSet2:= ValidSet2 + ['+', '-'];

      if (i>startpos) then
      begin
         ValidSet:= ['0'..'9', '(', ')', DecimalSeparator, ThousandSeparator];
         if (lastCharIsExponentialE) then ValidSet:= ValidSet + ['+', '-'];

         if length(CurrencyString)>0 then ValidSet:= ValidSet + [CurrencyString[1]];

         lastCharIsExponentialE:= ExponentialE(i);
         if not (s[i] in ValidSet) then
         begin
            if not ExponentialE(i) then continue;  // 8/15/2001 - Keep scanning for other digits.
            ValidSet2:= ValidSet2 + ['E', 'e'];
         end
      end;

      if s[i]='(' then FloatString:= FloatString + '-';
      if (s[i] in ValidSet2) then
         FloatString:= FloatString + s[i];
   end;
  if Negative then FloatString:= '-' + FloatString;
  result:= TextToFloat(pchar(FloatString), FloatValue, fvExtended);
  if result and (FloatValue>0) and (DisplayFormat<>'') then begin
     TempText:=  FormatFloat(DisplayFormat, FloatValue);
     if (TempText<>s) then
     begin
        TempText:=  FormatFloat(DisplayFormat, -FloatValue);
        if TempText=s then FloatValue:=-FloatValue;
     end
  end;

end;
}
// 8/29/06 - Support E in editFormat so that it is not stripped if it is an exponential E
function wwStrToFloat2(const S: string; var FloatValue: Extended; DisplayFormat: string): boolean;
//var Buffer: array[0..63] of char;
//    Temp: Extended;
var  i, startpos: integer;
    FloatString, TempText: string;
    Negative: boolean;
    FloatValueD: Double;
    lastCharIsExponentialE: boolean;
    validSet2: string;

  function IsValidChar(ch: Char): boolean;
  var ValidSet: string;
  begin
     result:= True;
//     ValidSet:= ['0'..'9', '(', ')'];
     ValidSet:= '0123456789()';

     if (lastCharIsExponentialE) then ValidSet:= ValidSet + '+-';

     if pos(ch,ValidSet)>0 then exit;

     if length(wwCurrencyString)>0 then
       if ch =wwCurrencyString[1] then exit;

     if (s[i] = wwDecimalSeparator) then exit;
     if (s[i] = wwThousandSeparator) then exit;
     result:= False;
  end;

    function ExponentialE(apos: integer): boolean;
    var ValidSet: string;
    begin
       result:= false;
       if uppercase(s[apos])='E' then
       begin
          if (apos<length(s)) then
          begin
            if (s[apos+1] =' ') then result:= true;
            ValidSet:= '0123456789-+';
            if (pos(s[apos+1],ValidSet)>0) then result:= true;
          end
       end
    end;

begin
   result:= True;
   FloatString:= '';
   FloatValue:= 0; // 5/7/03 - In case of null string
   if length(s)=0 then exit;

   //StripLeading non digits
   for i:= 1 to length(s) do
   begin
      if strCharMatch(s[i], '-0123456789(') then break;
//      if s[i] in ['-', '0'..'9', '('] then break;
      if (s[i] = wwDecimalSeparator) then break;
   end;

   startpos:= i;
   Negative:= (s[i]='-');

   //StripLeading non digits again if found negative.
   if Negative then
   begin
     for i:= startpos to length(s) do
     begin
        if strCharMatch(s[i], '0123456789(') then break;
//        if s[i] in ['0'..'9', '('] then break;
        if s[i] = wwDecimalSeparator then break;
     end;
     startpos:= i;
   end;

   lastCharIsExponentialE:= false;

   //Remove commas and decimal point
   for i:= startpos to length(s) do begin
      ValidSet2:= '0123456789';
      if (lastCharIsExponentialE) then
         ValidSet2:= ValidSet2 + '+-';

      if (i>startpos) then
      begin
         if not IsValidChar(s[i]) then
         begin
            lastCharIsExponentialE:= ExponentialE(i);
            if not ExponentialE(i) then continue   // 8/15/2001 - Keep scanning for other digits.
            else ValidSet2:= ValidSet2 + 'Ee';
         end
      end;
      lastCharIsExponentialE:= ExponentialE(i);

      if s[i]='(' then FloatString:= FloatString + '-';
      if strCharMatch(s[i], ValidSet2) or
         (s[i] = wwDecimalSeparator) then
         FloatString:= FloatString + s[i];
   end;
   if Negative then FloatString:= '-' + FloatString;
//  result:= TextToFloat(pchar(FloatString), FloatValue, fvExtended);
   FloatValueD:= FloatValue;

   result:= tryStrToFloat(FloatString, FloatValueD);
   if result then
   begin
      FloatValue:= FloatValueD;

      if (FloatValueD>0) and (DisplayFormat<>'') then begin
        TempText:=  FormatFloat(DisplayFormat, FloatValue);
        if (TempText<>s) then
        begin
           TempText:=  FormatFloat(DisplayFormat, -FloatValue);
           if TempText=s then FloatValue:=-FloatValue;
         end
      end
   end;

end;


Function wwLongMonthNames(month: integer): string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.LongMonthNames[month]
   {$else}
   result:= FormatSettings.LongMonthNames[month];
   {$endif}
end;

Function wwShortMonthNames(month: integer): string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.ShortMonthNames[month]
   {$else}
   result:= FormatSettings.ShortMonthNames[month];
   {$endif}
end;

Function wwLongDayNames(day: integer): string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.LongDayNames[day];
   {$else}
   result:= FormatSettings.LongDayNames[day];
   {$endif}
end;
Function wwShortDayNames(day: integer): string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.ShortDayNames[day];
   {$else}
   result:= FormatSettings.ShortDayNames[day];
   {$endif}
end;
Function wwShortDateFormat: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.ShortDateFormat;
   {$else}
   result:= FormatSettings.ShortDateFormat;
   {$endif}
end;
Function wwLongDateFormat: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.LongDateFormat;
   {$else}
   result:= FormatSettings.LongDateFormat;
   {$endif}
end;
Function wwLongTimeFormat: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.LongTimeFormat;
   {$else}
   result:= FormatSettings.LongTimeFormat;
   {$endif}
end;
Function wwShortTimeFormat: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.ShortTimeFormat;
   {$else}
   result:= FormatSettings.ShortTimeFormat;
   {$endif}
end;
Function wwDateSeparator: Char;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.DateSeparator;
   {$else}
   result:= FormatSettings.DateSeparator;
   {$endif}
end;
Function wwTimeSeparator: Char;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.TimeSeparator;
   {$else}
   result:= FormatSettings.TimeSeparator;
   {$endif}
end;
Function wwTimeAMString: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.TimeAMString;
   {$else}
   result:= FormatSettings.TimeAMString;
   {$endif}
end;
Function wwTimePMString: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.TimePMString;
   {$else}
   result:= FormatSettings.TimePMString;
   {$endif}
end;
Function wwCurrencyString: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.CurrencyString;
   {$else}
   result:= FormatSettings.CurrencyString;
   {$endif}
end;
Function wwDecimalSeparator: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.DecimalSeparator;
   {$else}
   result:= FormatSettings.DecimalSeparator;
   {$endif}
end;
Function wwThousandSeparator: string;
begin
   {$ifdef wwDelphi2011Up}
   result:= FormatSettings.ThousandSeparator;
   {$else}
   result:= FormatSettings.ThousandSeparator;
   {$endif}
end;

end.
