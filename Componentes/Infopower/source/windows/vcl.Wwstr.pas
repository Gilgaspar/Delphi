unit vcl.Wwstr;
{
//
// Commonly used string manipulation functions
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
// 10/22/98 - StrTrailing was incorrect before which would affect
//            SetControlType and searching for controls
}

interface
{$i wwIfDef.pas}

uses classes, dialogs, wwtypes;

//type
//  strCharSet = Set of char;

procedure strBreakApart(s: string; delimeter: string; parts: TStrings);
Function strGetToken(s: string; delimeter: string; var APos: integer): string;
Procedure strStripPreceding(var s: string; delimeter: string);//strCharSet);
Procedure strStripTrailing(var s: string; delimeter: string);//strCharSet);
//Procedure strStripPreceding(var s: string; delimeter: strCharSet);
//Procedure strStripTrailing(var s: string; delimeter: strCharSet);
Procedure strStripWhiteSpace(var s: string);
Function strRemoveChar(str: string; removeChar: char): string;
Function strReplaceChar(str: string; removeChar, replaceChar: char): string;
Function strReplaceCharWithStr(str: string; removeChar: char;replaceStr: string): string;
Function wwEqualStr(s1, s2: string): boolean;
Function strCount(s: string; delimeter: char): integer;
//Function strWhiteSpace : strCharSet;
Function strWhiteSpace : string;

Function wwExtractFileNameOnly(const FileName: string): string;
//Function wwGetWord(s: string; var APos: integer; Options: TwwGetWordOptions;
//                   DelimSet: strCharSet): string;
Function wwGetWord(s: string; var APos: integer; Options: TwwGetWordOptions;
                   DelimChars: String): string;

Function strTrailing(s: string; delimeter: char): string;
Function strPreceding(s: string; delimeter: char): string;
function strReplace(s, Find, Replace: string): string;
function strCharMatch(const ch: Char; SetChar: string): boolean;
function wwGetToken(s, Delimiter: string; Index: integer): string;
function wwFindToken(s, Delimiter, Token: string): Integer;

implementation

uses
{$IFDEF IPTRIAL}
sysutils, windows, extctrls, forms;
{$ELSE}
sysutils;
{$ENDIF}

  Function strWhiteSpace : string;
  begin
      result:= ' ' + #9;
//     Result := [' ',#9];
  end;

  Function wwExtractFileNameOnly(const FileName: string): string;
  var FileNameAndPath:String;
  begin
    FileNameAndPath := ExtractFileName(FileName);
    result := Copy(FileNameAndPath, 1, Pos('.', FileNameAndPath) - 1);
  end;

function wwSubstring(s: string; Start, Stop: integer): string;
begin
  if Stop = 0 then result := Copy(s, Start, length(s) - Start + 1)
  else result := Copy(s, Start, Stop - Start);
end;

function wwCountTokens(s, Delimiter: string): integer;
var i: integer;
begin
  result := 0;
  if length(s) > 0 then result := 1;
  for i := 1 to Length(s) do
    if Copy(s, i, Length(Delimiter)) = Delimiter then inc(result);
end;

function wwIndexOf(Substr, s: string; Index: integer): integer;
begin
  result := pos(Substr, wwSubstring(s, Index, 0));
  if result <> 0 then result := result + Index - 1;
end;


// Returns the position of Index'th (zero-based) occurance of Substring

function wwNthIndexOf(Substr, s: string; Index: integer): integer;
var Counter: integer;
begin
  Counter := -1;
  result := 0;
  while Counter < Index do
  begin
    inc(Counter);
    result := wwIndexOf(Substr, s, result + 1);
  end;
end;

function wwGetToken(s, Delimiter: string; Index: integer): string;
var Temp: integer;
begin
  if (Index >= wwCountTokens(s, Delimiter)) then result := ''
  else begin
    Temp := wwNthIndexOf(Delimiter, s, Index - 1);
    if Temp <> 0 then inc(Temp, Length(Delimiter))
    else Temp := 1;
    result := wwSubstring(s, Temp, wwNthIndexOf(Delimiter, s, Index));
  end;
end;


  Function strGetToken(s: string; delimeter: string; var APos: integer): string;
  var tempStr: string;
      endStringPos: integer;
  begin
     result:= '';
     if APos<=0 then exit;
     if APos>length(s) then begin
        APos:= -1;
        exit;
     end;

     tempStr:= copy(s, APos, length(s)+1-APos);
       {Converts to Uppercase for check if delimeter more than one character}
     if (length(delimeter)=1) then
     {$ifndef wwDelphi3Up}
        endStringPos:= pos(delimeter, tempStr)
     {$ELSE}
        endStringPos:= AnsiPos(delimeter, tempStr)
     {$ENDIF}
     else begin
        delimeter := ' ' + delimeter + ' ';
        {$ifndef wwDelphi3Up}
        endStringPos:= pos(UpperCase(delimeter),UpperCase(tempStr));
        {$ELSE}
        endStringPos:= AnsiPos(UpperCase(delimeter),UpperCase(tempStr));
        {$ENDIF}
     end;

     if endStringPos<=0 then begin
        result:= tempStr;
        APos:= -1;
     end
     else begin
        result:= copy(tempStr, 1, endStringPos-1);
        APos:= APos + endStringPos + length(delimeter) - 1;
     end
  end;

  procedure strBreakApart(s: string; delimeter : string; parts : TStrings);
  var curpos: integer;
      curStr: string;
  begin
     parts.clear;
     curStr:= s;
     repeat
        {$ifndef wwDelphi3Up}
        curPos:= pos(delimeter, curStr);
        {$ELSE}
        curPos:= AnsiPos(delimeter, curStr);
        {$ENDIF}
        if (curPos>0) then begin
           parts.add(copy(curStr, 1, curPos-1));
           curStr:= copy(curStr, curPos+1, length(curStr)-(curPos));
        end
        else parts.add(curStr);

     until curPos=0;

  end;

  Procedure strStripWhiteSpace(var s: string);
  var tempstr: string;
  begin
     tempstr := s;
     strStripPreceding(tempstr,strWhiteSpace);
     strStripTrailing(tempstr,strWhiteSpace);
     s := tempstr;
  end;

  Procedure strStripPreceding(var s: string; delimeter: string);
  var i,len: integer;
  begin
    i:= 1;
    len:= length(s);
    while (i<=length(s)) and (pos(s[i], delimeter)>0) do i:= i + 1;
//    while (i<=length(s)) and (s[i] in delimeter) do i:= i+1;
    if ((len<>0) and (i<=len)) then
       s:= copy(s,i,len-i+1)
    else if (len<>0) then s:='';
  end;

  Procedure strStripTrailing(var s: string; delimeter: string);
  var len: integer;
  begin
     len:= length(s);
//     while (len>0) and (s[len] in delimeter) do len:= len-1;
     while (len>0) and (pos(s[len], delimeter)>0) do len:= len-1;

     setLength(s, len);

  end;

{
  Procedure strStripPreceding(var s: string; delimeter: strCharSet);
  var i,len: integer;
  begin
    i:= 1;
    len:= length(s);
    while (i<=length(s)) and (s[i] in delimeter) do i:= i+1;
    if ((len<>0) and (i<=len)) then
       s:= copy(s,i,len-i+1)
    else if (len<>0) then s:='';
  end;

  Procedure strStripTrailing(var s: string; delimeter: strCharSet);
  var len: integer;
  begin
     len:= length(s);
     while (len>0) and (s[len] in delimeter) do len:= len-1;

     setLength(s, len);
  end;
  }

Function strRemoveChar(str: string; removeChar: char): string;
var i,j: integer;
    s: string;
begin
   j:= 0;
   setLength(s, length(str));

   for i:= 1 to length(str) do begin
      if (str[i] <> removeChar) then
      begin
         j:= j + 1;
         s[j]:= str[i]
      end
   end;

   setLength(s, j);

   result:= s;
end;

Function strReplaceChar(str: string; removeChar, replaceChar: char): string;
var
   tempstr: string;
   APos, endStringPos: integer;
begin
   APos:= 1;
   repeat
      tempStr:= copy(str, APos, length(str)+1-APos);

      {$ifndef wwDelphi3Up}
      endStringPos:= Pos(removeChar, tempStr)+(APos-1);
      {$ELSE}
      endStringPos:= AnsiPos(removeChar, tempStr)+(APos-1);
      {$ENDIF}

      if EndStringPos>=APos then
      begin
         Delete(Str, EndStringPos, 1);
         Insert(ReplaceChar, Str, EndStringPos);
         APos:= EndStringPos + 1;
      end
      else break;
   until False;
   result:= str;
end;

Function strReplaceCharWithStr(str: string; removeChar: char;replaceStr: string): string;
var tempstr: string;
    APos, endStringPos: integer;
begin
   APos:= 1;
   repeat
      tempStr:= copy(str, APos, length(str)+1-APos);
      {$ifndef wwDelphi3Up}
      endStringPos:= Pos(removeChar, tempStr)+(APos-1);
      {$ELSE}
      endStringPos:= AnsiPos(removeChar, tempStr)+(APos-1);
      {$ENDIF}

      if EndStringPos>=APos then
      begin
         Delete(Str, EndStringPos, 1);
         Insert(ReplaceStr, Str, EndStringPos);
         APos:= EndStringPos + length(replaceStr);
      end
      else break;
   until False;
   result:= str;
end;

// 2/12/06 - Use AnsiUppercase Instead
Function wwEqualStr(s1, s2: string): boolean;
begin
   result:= AnsiUppercase(s1)=AnsiUppercase(s2);
end;

Function strCount(s: string; delimeter: char): integer;
var i, count: integer;
begin
   count:= 0;
   for i:= 1 to length(s) do
      if s[i]=delimeter then inc(count);
   result:= count;
end;

{
Function wwGetWord(s: string; var APos: integer;
                   Options: TwwGetWordOptions; DelimSet: strCharSet): string;
var i: integer;

   Function max(x,y: integer): integer;
   begin
     if x>y then result:= x
     else result:= y;
   end;

   Procedure StripQuotes;
   begin
      if not (wwgwStripQuotes in Options) then exit;
      if (Result[1]='"') or (Result[1]='''') then
         if (Result[length(Result)] = '"') or
            (Result[length(Result)] = '''') then
            Result:= copy(Result, 2, length(Result)-2)
         else
            Result:= copy(Result, 2, length(Result)-1);
   end;

begin
   result:= '';
   if APos<=0 then exit;
   if APos>length(s) then exit;

   i:= APos;
   if (wwgwSkipLeadingBlanks in Options) then
   begin
      while (i<=length(s)) and ((s[i]=' ') or (s[i]=#9)) do inc(i);
      APos:= i;
   end;

   if (wwgwQuotesAsWords in Options) then
   begin
      if s[i]='"' then begin
         inc(i);
         while (i<=length(s)) and (s[i]<>'"') do inc(i);
         if s[i]='"' then begin
            result:= copy(s, APos, i+1-APos);
            APos:= i+1;
         end
         else if (i>length(s)) then begin
            result:= copy(s, APos, length(s));
            APos:= length(s)+1;
         end;
         StripQuotes;
         exit;
      end
   end;

   if wwgwSpacesInWords in Options then
   begin
      while (i<=length(s)) and (s[i] in [#32..#255]) do begin
         if (s[i] in DelimSet) then break
         else inc(i);
      end
   end
   else begin
      while (i<=length(s)) and (s[i] in [#33..#255]) do begin
         if (s[i] in DelimSet) then break
         else inc(i);
      end
   end;

   result:= copy(s, APos, max(i-APos, 1));

   if length(result)>1 then APos:= i
   else APos:= i+1;

end;
}

Function wwGetWord(s: string; var APos: integer;
                   Options: TwwGetWordOptions; DelimChars: String): string;
var i: integer;

   Function max(x,y: integer): integer;
   begin
     if x>y then result:= x
     else result:= y;
   end;

   Procedure StripQuotes;
   begin
      if not (wwgwStripQuotes in Options) then exit;
      if (Result[1]='"') or (Result[1]='''') then
         if (Result[length(Result)] = '"') or
            (Result[length(Result)] = '''') then
            Result:= copy(Result, 2, length(Result)-2)
         else
            Result:= copy(Result, 2, length(Result)-1);
   end;

   Function IsDelim(s: Char): boolean;
   var i: integer;
   begin
      result:= False;
      for i:= 1 to length(DelimChars) do begin
         if s=DelimChars[i] then begin
            result:= True;
            break;
         end
      end
   end;

    Function IsValidChar(Key: Char): boolean;
    begin
       result:= (key>=#32) and (key<=High(Char))
    end;

    Function IsValidCharNoSpaces(Key: Char): boolean;
    begin
       result:= (key>=#33) and (key<=High(Char))
    end;




begin
   result:= '';
   if APos<=0 then exit;
   if APos>length(s) then exit;

   i:= APos;
   if (wwgwSkipLeadingBlanks in Options) then
   begin
      while (i<=length(s)) and ((s[i]=' ') or (s[i]=#9)) do inc(i);
      APos:= i;
   end;

   if (wwgwQuotesAsWords in Options) then
   begin
      if s[i]='"' then begin
         inc(i);
         while (i<=length(s)) and (s[i]<>'"') do inc(i);
         if s[i]='"' then begin
            result:= copy(s, APos, i+1-APos);
            APos:= i+1;
         end
         else if (i>length(s)) then begin
            result:= copy(s, APos, length(s));
            APos:= length(s)+1;
         end;
         StripQuotes;
         exit;
      end
   end;

   if wwgwSpacesInWords in Options then
   begin
      while (i<=length(s)) and IsValidChar(s[i]) do begin
         if IsDelim(s[i]) then break
//         if (s[i] in DelimSet) then break
         else inc(i);
      end
   end
   else begin
      while (i<=length(s)) and IsValidCharNoSpaces(s[i]) do begin
         if IsDelim(s[i]) then break
//         if (s[i] in DelimSet) then break
         else inc(i);
      end
   end;

   result:= copy(s, APos, max(i-APos, 1));

   if length(result)>1 then APos:= i
   else APos:= i+1;

end;

Function strTrailing(s: string; delimeter: char): string;
var apos: integer;
begin
   apos:= pos(delimeter, s); { 10/22/98 - Backwards before}
   if apos>=1 then
      result:= copy(s, apos+1, length(s)-apos)
   else result:= '';
end;

Function strPreceding(s: string; delimeter: char): string;
var apos: integer;
begin
   apos:= pos(delimeter, s); { 10/22/98 - Backwards before}
   if apos>=1 then
      result:= copy(s, 1, apos-1)
   else result:= '';
end;

function Substring(s: string; Start, Stop: integer): string;
begin
  if Stop = 0 then result := Copy(s, Start, length(s) - Start + 1)
  else result := Copy(s, Start, Stop - Start);
end;

function IndexOf(Substr, s: string; Index: integer): integer;
begin
  result := pos(Substr, Substring(s, Index, 0));
  if result <> 0 then result := result + Index - 1;
end;

function strReplace(s, Find, Replace: string): string;
var i: integer;
begin
  i := 1;
  result := '';
  while i <> 0 do
  begin
    result := result + Substring(s, i, IndexOf(Find, s, i));
    if IndexOf(Find, s, i) = 0 then break;
    result := result + Replace;
    i := IndexOf(Find, s, i);
    if i <> 0 then inc(i, Length(Find));
  end;

end;

function strCharMatch(const ch: Char; SetChar: string): boolean;
begin
   result:= pos(ch, SetChar)>0;
end;

function wwFindToken(s, Delimiter, Token: string): Integer;
var i: Integer;
begin
  result := -1;
  for i := 0 to wwCountTokens(s, Delimiter) - 1 do
    if wwGetToken(s, Delimiter, i) = Token then
    begin
      result := i;
      Break;
    end;
end;


{$IFDEF IPTRIAL}

type
  TwwTempTimer = class
    class procedure TempOnTimer(Sender: TObject);
  end;

class procedure TwwTempTimer.TempOnTimer(Sender: TObject);
begin
   Application.Terminate;
end;

var tempTimer: TTimer;
    MutexHandle: THandle;
initialization
   if pos('BDS', uppercase(Application.ExeName))>0 then exit;
   MutexHandle:= OpenMutex(MUTEX_ALL_ACCESS, false, 'IP2538C91CD4785AA9'+'W2W');
   if MutexHandle=0 then
   begin
      { Abort program in 10 minutes}
      tempTimer:= TTimer.create(Application);
      tempTimer.OnTimer:= TwwTempTimer.TempOnTimer;
      tempTimer.interval:= 300000; { 5 minutes }
   end
   else begin
      { Design time so continue }
      CloseHandle(MutexHandle);
   end
{$ENDIF}

end.

