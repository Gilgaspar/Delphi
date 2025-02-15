unit vcl.wwrtfconverter;

interface

{$I wwIfDef.pas}

uses
  Windows, Messages, SysUtils,
{$IFDEF wwDelphi6Up}
  Variants,
{$ENDIF}
  Classes, Graphics, Controls,
  forms, registry,
  Dialogs, StdCtrls, Buttons, ComCtrls, wwriched, activex;

const
  // File Conversion Errors
  wwfceTrue = 1; // true (used by IsFormatCorrect32() only)
  wwfceNoErr = 0; // success
  wwfceOpenInFileErr = -1; // could not open input file
  wwfceReadErr = -2; // error during read
  wwfceWriteErr = -4; // error during write
  wwfceInvalidFile = -5; // invalid data in conversion file
  wwfceNoMemory = -8; // out of memory
  wwfceOpenOutFileErr = -12; // could not open output file
  wwfceUserCancel = -13; // conversion cancelled by user
  wwfceWrongFileType = -14; // wrong file type for this converter
{$WARNINGS off}

type
  TwwFileCodeError = smallint;

  // 3/12/09 - Use AnsiString for unicode
{$IFNDEF Unicode}
  TwwAnsiString = string;
{$ELSE}
  TwwAnsiString = AnsiString;
{$ENDIF}
  TwwConvertCallbackOut = function(cchBuff: longint; nPercent: longint)
    : longint; stdcall;
  TwwConvertCallbackIn = function(rgfOptions: longint; p2: longint): longint;
    stdcall;

  TwwInitConverter32 = function(hwnd: THandle; szModule: LPWSTR): HResult;
    stdcall;
  TwwUninitConverter = procedure(); stdcall;
  TwwIsFormatCorrect32 = function(ghszFile: THandle; ghszClass: THandle)
    : TwwFileCodeError; stdcall;
  TwwForeignToRtf32 = function(hFile: THandle; pStorage: IStorage;
    hBuffer, hClass, hSubset: THandle; OutFunction: TwwConvertCallbackOut)
    : TwwFileCodeError; stdcall;
  TwwRtfToForeign32 = function(hFile: THandle; pStorage: IStorage;
    hBuffer, hClass: THandle; InFunction: TwwConvertCallbackIn)
    : TwwFileCodeError; stdcall;
  TwwRegisterApp = function(lFlags: DWord; lpFuture: Pointer): Pointer; stdcall;
  TwwCchFetchLpszError = function(fce: longint; lpszError: LPWSTR; cb: longint)
    : longint; stdcall;
  TwwGetReadNames = procedure(haszClass: THandle; haszDescrip: THandle;
    haszExt: THandle); stdcall;
  TwwGetWriteNames = procedure(haszClass: THandle; haszDescrip: THandle;
    haszExt: THandle); stdcall;
  TwwRegisterConverter = function(hkeyRoot: THandle): longint; stdcall;

type

  TwwRTFConverter = class
  protected
    FLibrary: HModule; // library DLL instance
    InitConverter32: TwwInitConverter32;
    UninitConverter: TwwUninitConverter;
    IsFormatCorrect32: TwwIsFormatCorrect32;
    ForeignToRtf32: TwwForeignToRtf32;
    RtfToForeign32: TwwRtfToForeign32;
    RegisterApp: TwwRegisterApp;
    CchFetchLpszError: TwwCchFetchLpszError;
    GetReadNames: TwwGetReadNames;
    GetWriteNames: TwwGetWriteNames;
    RegisterConverter: TwwRegisterConverter;

    procedure LoadLibrary(hwnd: hwnd; libpath: string); // TwwAnsiString);
    procedure UnloadLibrary;
  public
    constructor Create(hwnd: hwnd; libpath: string); // TwwAnsiString);
    destructor Destroy; override;
    function IsKnownFormat(FilePath: string): Boolean;
    // function GetFormatClass(filepath: TwwAnsiString): TwwAnsiString;
    function ForeignToRTF(richedit: TwwCustomRichEdit; FilePath: string;
      formatClass: string = ''): TwwFileCodeError;
    function RTFToForeign(richedit: TwwCustomRichEdit; FilePath: string;
      formatClass: string = ''): TwwFileCodeError;
    function GetErrorMessage(ErrorCode: smallint): string;
  end;

  TwwRtfConverterList = class
  private
    RawDescription: TStringList;
  public
    libpath: TStringList;
    Description: TStringList;
    formatClass: TStringList;
    Filters: TStringList;
    FilterList: string; // TwwAnsiString;  			// for use with TOpenDialog
  public
    constructor Create(import: Boolean);
    destructor Destroy; override;

    procedure GetConverterList(regRoot: HKey; regPath: string; appName: string;
      import: Boolean);
  end;

implementation

uses wwstr;

constructor TwwRTFConverter.Create(hwnd: hwnd; libpath: string);
// TwwAnsiString);
begin
  @InitConverter32 := nil;
  @UninitConverter := nil;
  @IsFormatCorrect32 := nil;
  @ForeignToRtf32 := nil;
  @RtfToForeign32 := nil;
  @RegisterApp := nil;
  @CchFetchLpszError := nil;
  @GetReadNames := nil;
  @GetWriteNames := nil;
  @RegisterConverter := nil;
  LoadLibrary(hwnd, libpath);
end;

destructor TwwRTFConverter.Destroy;
begin
  UnloadLibrary;
end;

procedure TwwRTFConverter.LoadLibrary(hwnd: hwnd; libpath: string);
// TwwAnsiString);
var
  hinst: HModule;
  name: WideString;
begin
  // attempt to load library
  // hinst := Windows.LoadLibraryA(pansichar(libPath));
  hinst := Windows.LoadLibrary(pchar(libpath));

  if (hinst = 0) then
    showmessage('Unable to load library ' + libpath);

  // library loaded ok
  FLibrary := hinst;

  // get entry points for calls
  @InitConverter32 := GetProcAddress(FLibrary, 'InitConverter32');
  @UninitConverter := GetProcAddress(FLibrary, 'UninitConverter');
  @IsFormatCorrect32 := GetProcAddress(FLibrary, 'IsFormatCorrect32');
  @ForeignToRtf32 := GetProcAddress(FLibrary, 'ForeignToRtf32');
  @RtfToForeign32 := GetProcAddress(FLibrary, 'RtfToForeign32');
  @RegisterApp := GetProcAddress(FLibrary, 'RegisterApp');
  @CchFetchLpszError := GetProcAddress(FLibrary, 'CchFetchLpszError');
  @GetReadNames := GetProcAddress(FLibrary, 'GetReadNames');
  @GetWriteNames := GetProcAddress(FLibrary, 'GetWriteNames');
  @RegisterConverter := GetProcAddress(FLibrary, 'FRegisterConverter');

  // verify that required entry points are available
  if (@InitConverter32 = Nil) or (@IsFormatCorrect32 = Nil) or
    (@ForeignToRtf32 = Nil) then
  begin
    UnloadLibrary();
    showmessage('Unable to initialize library (required entry points missing)');
  end;

  // initialize converter - if cannot, unload and return failure
  name := Application.ExeName;
  if InitConverter32(hwnd, PWideChar(name)) = 0 then
  begin
    UnloadLibrary();
    showmessage('Unable to initialize library (initialization failed)');
  end;
end;

procedure TwwRTFConverter.UnloadLibrary;
begin
  // if library loaded and pUninitConverter is exported, uninitialize the library
  if (FLibrary <> 0) and (@UninitConverter <> nil) then
    UninitConverter;

  // if the library is loaded, free it
  if (FLibrary <> 0) then
    FreeLibrary(FLibrary);

  // clear FLibrary and globals
  FLibrary := 0;
  @InitConverter32 := nil;
  @UninitConverter := nil;
  @IsFormatCorrect32 := nil;
  @ForeignToRtf32 := nil;
  @RtfToForeign32 := nil;
  @RegisterApp := nil;
  @CchFetchLpszError := nil;
  @GetReadNames := nil;
  @GetWriteNames := nil;
  @RegisterConverter := nil;

end;

// GlobalAllocString() - utility function to allocate global storage and
// put a string in it
// s - string to put in global storage
//
function GlobalAllocString(s: string): HGlobal;
var
  hgsz: HGlobal;
  p: Pointer;
  sa: AnsiString;
begin
  result := 0;
  sa := s;

  // allocate a block of storage large enough for string
  hgsz := GlobalAlloc(GMEM_MOVEABLE, Length(sa) + 1);
  if (hgsz = 0) then
    exit;

  // lock the storage and copy the string into it and then unlock the storage
  p := GlobalLock(hgsz);
  if (p = nil) then
  begin
    GlobalFree(hgsz);
    exit;
  end;

  Move(PAnsiChar(sa)^, p^, Length(sa) + 1); // 3/14/09 - Unicode issues fixed
  // lstrcpy(p, pchar(s));

  GlobalUnlock(hgsz);
  result := hgsz;
end;

const
  BUFFSIZE = $4000; // 16k buffer

var
  ghBuff: HGlobal;
  mstream: TMemoryStream;

function RtfOut(cchBuff: longint; nPercent: longint): longint; stdcall;
var
  retval: longint;
  p: pchar;
begin
  retval := 0;
  p := pchar(GlobalLock(ghBuff));
  if (p = nil) then
    retval := wwfceNoMemory
  else
  begin
    try
      mstream.Write(p^, cchBuff);
    except
      GlobalUnlock(ghBuff);
    end;
  end;
  result := retval;
end;

function RtfIn(rgfOptions: longint; p2: longint): longint; stdcall;
// function RtfIn(rgfOptions: longint; dummy: longint): longint; stdcall;
var
  bytes: longint;
  p: pchar;
begin
  // bytes:= 0;  // assume no more to write
  p := pchar(GlobalLock(ghBuff));

  if (p = nil) then
    result := wwfceNoMemory
  else
  begin
    try
      bytes := mstream.Read(p^, BUFFSIZE);
    except
      bytes := wwfceWriteErr;
      GlobalUnlock(ghBuff);
    end;
    result := bytes;
  end;
end;

function TwwRTFConverter.ForeignToRTF(richedit: TwwCustomRichEdit;
  FilePath: string; formatClass: string = ''): TwwFileCodeError;
var
  ghszFile, ghszClass, ghszSubset: HGlobal;
  fce: TwwFileCodeError;
begin
  // create a temporary stream to hold incoming RTF
  mstream := TMemoryStream.Create;

  // create global handles for ghszFile, ghszClass, & ghszSubset and
  // allocate a working buffer
  ghszFile := GlobalAllocString(FilePath);
  ghszClass := GlobalAllocString(formatClass);
  ghszSubset := GlobalAllocString('');
  ghBuff := GlobalAlloc(GHND, BUFFSIZE);
  if (ghszFile = 0) or (ghszClass = 0) or (ghszSubset = 0) or (ghBuff = 0) then
  begin
    if (ghszFile <> 0) then
      GlobalFree(ghszFile);
    if (ghszClass <> 0) then
      GlobalFree(ghszClass);
    if (ghszSubset <> 0) then
      GlobalFree(ghszSubset);
    if (ghBuff <> 0) then
      GlobalFree(ghBuff);
    ghBuff := 0;
    result := wwfceNoMemory;
    exit;
  end;

  // import RTF
  fce := ForeignToRtf32(ghszFile, nil, ghBuff, ghszClass, ghszSubset, RtfOut);

  // free storage
  GlobalFree(ghszFile);
  GlobalFree(ghszClass);
  GlobalFree(ghszSubset);
  GlobalFree(ghBuff);
  ghBuff := 0;

  // copy the stream into the rich edit control
  mstream.Position := 0;
  richedit.Lines.LoadFromStream(mstream);

  mstream.free;
  mstream := nil;
  result := fce;
end;

function TwwRTFConverter.RTFToForeign(richedit: TwwCustomRichEdit;
  FilePath: string; formatClass: string = ''): TwwFileCodeError;
var
  ghszFile, ghszClass: HGlobal;
  fce: TwwFileCodeError;
begin
  // quick out if not implemented
  if (@RtfToForeign32 = nil) then
  begin
    result := wwfceWrongFileType;
    exit;
  end;

  // create a temporary stream to hold incoming RTF
  try
    mstream := TMemoryStream.Create;
  except
    result := wwfceNoMemory;
    exit;
  end;

  // fill the stream from the Rich Edit control
  try
    richedit.Lines.SaveToStream(mstream);
  except
    mstream.free;
    mstream := nil;
    result := wwfceNoMemory;
    exit;
  end;

  // reposition stream to start
  mstream.Position := 0;

  ghszFile := GlobalAllocString(FilePath);
  ghszClass := GlobalAllocString(formatClass);
  ghBuff := GlobalAlloc(GHND, BUFFSIZE);

  if (ghszFile = 0) or (ghszClass = 0) or (ghBuff = 0) then
  begin
    if (ghszFile <> 0) then
      GlobalFree(ghszFile);
    if (ghszClass <> 0) then
      GlobalFree(ghszClass);
    if (ghBuff <> 0) then
      GlobalFree(ghBuff);
    ghBuff := 0;
    result := wwfceNoMemory;
    exit;
  end;

  // export RTF
  fce := RtfToForeign32(ghszFile, nil, ghBuff, ghszClass, RtfIn);

  // free storage
  GlobalFree(ghszFile);
  GlobalFree(ghszClass);
  GlobalFree(ghBuff);
  ghBuff := 0;

  mstream.free;
  mstream := nil;
  result := fce;
end;

function TwwRTFConverter.IsKnownFormat(FilePath: string): Boolean;
// function TwwRTFConverter.GetFormatClass(filepath: TwwAnsiString): TwwAnsiString;
var
  hgszFile, hgszClass: HGlobal;
  stat: longint;
  // p: PChar;
begin
  // allocate global storage for filepath and format class
  result := False;
  hgszFile := GlobalAllocString(FilePath);
  hgszClass := GlobalAllocString('');

  if (hgszFile <> 0) and (hgszClass <> 0) then
  begin
    // test the file
    stat := IsFormatCorrect32(hgszFile, hgszClass);

    // Check if file matches format
    if (stat <> wwfceTrue) then
    // if (stat <> wwfceNoErr) then
    begin
      GlobalFree(hgszFile);
      GlobalFree(hgszClass);
      result := False;
      exit;
    end
    else
      result := True;

    // copy the class name into local storage and free global storage
    // p := PChar(GlobalLock(hgszClass));
    // GlobalUnlock(hgszClass);

    // return format class name
    // result:= TwwAnsiString(p);
  end;

  if hgszFile <> 0 then
    GlobalFree(hgszFile);
  if hgszClass <> 0 then
    GlobalFree(hgszClass);
end;

constructor TwwRtfConverterList.Create(import: Boolean);
var
  i: integer;
begin
  libpath := TStringList.Create;
  Description := TStringList.Create;
  Description.Sorted := True;
  Description.Duplicates := dupAccept;
  RawDescription := TStringList.Create;
  formatClass := TStringList.Create;
  Filters := TStringList.Create;

  // get converter list for each known location
  // 6/23/03 - Fix bug by removing trailing \ in path
  GetConverterList(HKEY_LOCAL_MACHINE,
    '\Software\Microsoft\Shared Tools\Text Converters\', '', import);
  // GetConverterList(HKEY_CURRENT_USER,
  // '\Software\Microsoft\Office\8.0\Word\Text Converters\', 'Word 97',
  // import);
  // and build a filter list suitable for using with TOpenDialog::Filter
  for i := 0 to Description.Count - 1 do
  begin
    if (i > 0) then
      FilterList := FilterList + '|';
    FilterList := FilterList + Description.Strings[i] + ' (' + Filters.Strings
      [i] + ')|' + Filters.Strings[i];
  end;
end;

destructor TwwRtfConverterList.Destroy;
begin
  libpath.free;
  Description.free;
  RawDescription.free;
  formatClass.free;
  Filters.free;
end;

procedure TwwRtfConverterList.GetConverterList(regRoot: HKey; regPath: string;
  appName: string; import: Boolean);
var
  subkeys: TStringList;
  sRegPath, sName, sExt, sPath: TwwAnsiString;
  reg: TRegistry;
  currKey, name, ext, path: TwwAnsiString;
  tempExt, s: String;
  skipit: Boolean;
  i, j: integer;
  rawName: TwwAnsiString;
  ndx: integer;
  APos: integer;
  foundhtml: boolean;
begin
  subkeys := TStringList.Create;

  // Registry key path and data value names
  sRegPath := regPath;
  sName := 'Name';
  sExt := 'Extensions';
  sPath := 'Path';

  // modify Registry key path for import or export
  if (import) then
    sRegPath := sRegPath + 'Import'
  else
    sRegPath := sRegPath + 'Export';

  // allocate a Registry object
  reg := TRegistry.Create;

  try
    // open Registry key and get subkeys
    reg.RootKey := regRoot;
    // reg.OpenKey(sRegPath, false);
    reg.OpenKeyReadOnly(sRegPath); // 9/26/05 - Support PowerUser, by not requiring write priviledge to registry
    reg.GetKeyNames(subkeys);
    reg.CloseKey();

    // for each subkey
    for i := 0 to subkeys.Count - 1 do
    begin
      // append it to the import/export key
      currKey := sRegPath + TwwAnsiString('\') + subkeys.Strings[i];

      // open that key and retrieve "Name," "Path", & "Extensions" values
      try
        // reg.OpenKey(currKey, false);
        reg.OpenKeyReadOnly(currKey);
        name := reg.ReadString(sName);
        path := reg.ReadString(sPath);
        tempExt := reg.ReadString(sExt);

        // extensions are returned as a space-delimited,
        // parse extensions and format as filters
        APos := 1;
        ext := '';
        repeat
          s := strGetToken(tempExt, ' ', APos);
          if Length(s) = 0 then
            break;
          if Length(ext) > 0 then
          begin
            ext := ext + ';';
            ext := ext + TwwAnsiString('*.') + s;
          end
          else
            ext := TwwAnsiString('*.') + s until False;
          finally
          end;

          // close the subkey
          reg.CloseKey;

          // duplicates are possible -- look through the descriptions
          // and, if a match is found, compare the library paths, extensions,
          // and format classes... if all are the same as the existing entry,
          // then skip this one.
          skipit := False;

          for j := 0 to RawDescription.Count - 1 do
          begin
            (* if (!FRawDescription->Strings[j].AnsiCompareIC(name) &&
              !LibraryPath->Strings[j].AnsiCompareIC(path) &&
              !FormatClass->Strings[j].AnsiCompareIC(subKeys->Strings[i]) &&
              !Filters->Strings[j].AnsiCompareIC(ext))
              skipIt = true;
            *)
          end;

          // and add the values to the string lists
          if not skipit and (Length(name) > 0) and { (length(ext)>0) and }
          (Length(path) > 0) then
          begin
            rawName := name;
            if Length(appName) > 0 then
              name := name + TwwAnsiString(' - ') + appName;
            ndx := Description.Add(name);
            RawDescription.Insert(ndx, rawName);
            libpath.Insert(ndx, path);
            formatClass.Insert(ndx, subkeys.Strings[i]);
            Filters.Insert(ndx, ext);
          end
        end;

        // 2/9/10 - Support html even if its not in text filter list
        foundhtml := False;
        for i := 0 to formatClass.Count - 1 do
          if lowercase(formatClass[i]) = 'html' then
            foundhtml := True;
        if not foundhtml then
        begin
          ndx := Description.Add('HTML Document');
          formatClass.Insert(ndx, 'html');
          RawDescription.Insert(ndx, 'HTML Document');
          // exportrcl.rawDescription:= 'HTML Document';
          libpath.Insert(ndx, 'c:\windows\system32\html.iec');
          Filters.Insert(ndx, '*html;*.htm;*.htx');
        end;

      finally
      end;

      // free local storage
      reg.free;
      subkeys.free;

    end;

    function TwwRTFConverter.GetErrorMessage(ErrorCode: smallint): string;
    var
      buf: array [0 .. 255] of ansichar; // 3/14/09 - Neccessary to be ansichar for unicode
    begin
      result := '';
      if @CchFetchLpszError <> nil then
      begin
        if CchFetchLpszError(ErrorCode, @buf, sizeof(buf)) <> 0 then
          result := TwwAnsiString(buf);
      end
      else
      begin
        case ErrorCode of
          wwfceOpenInFileErr:
            result := 'Could not open input file';
          wwfceReadErr:
            result := 'Error during read';
          wwfceWriteErr:
            result := 'Error during write';
          wwfceInvalidFile:
            result := 'Invalid data in conversion file';
          wwfceNoMemory:
            result := 'Out of memory';
          wwfceOpenOutFileErr:
            result := 'Could not open output file';
          wwfceUserCancel:
            result := 'Conversion cancelled by user';
          wwfceWrongFileType:
            result := 'Wrong file type for this converter';
        else
          result := 'Error importing or exporting';
        end
      end;
    end;
{$WARNINGS on}

end.
