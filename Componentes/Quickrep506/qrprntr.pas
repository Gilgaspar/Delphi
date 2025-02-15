{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRPRNTR.PAS - LOW LEVEL PRINT AND PREVIEW CLASSES       ::
  ::                                                         ::
  :: Copyright (c) 2008 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: http://www.quickreport.co.uk                            ::
  ::  2/12/2004 many additions for QR4                       ::
  :: VER 5                                                   ::
  :: method AcceptTextControl added to TQRExportFilter
  :: method 'LoadFromStream' for TPagelist
  :: made TQRPrinter.parentreport a read/write property
  :: 26/04/2010 fix synch bug in SetAvailablePages etc
  :: 12/05/2010 add new TTextEncoding 'AnsiiEncoding'
  :: 07/06/2010 add TExportInfoRec structure for exporting
  :: 14.06.2010 Version 5.05
  :: 07/07/2010 TQRPrinter parentreport = nil bug
  :: 12/10/10 added TQRPageList.SaveToStream
  :: 20/10/2010 changed printersetup code %%%
  :: 12/03/2011 CreateMetafilecanvas - SetGraphicsMode( FCanvas.handle, GM_ADVANCED).
  :: 13/03/2011 DefaultPrinterPaperSize added checks to avoid exception
  :: 12/09/2014 Win64 fixed types in message structs TCM_QRPageAvailable etc
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}
{$define notLLionPDF}
{$define notNEWQRP}
unit QRPrntr;

{$R-}
{$T-}
{$B-}

interface

uses
  Windows, winspool, Sysutils, Messages, Classes, Controls, StdCtrls, ExtCtrls,
  ComCtrls, Buttons, Printers, Graphics, Forms, DB, QR5Const, Dialogs,
  {$ifdef LLionPDF} PDF,{$endif}qrabout;

type

  TExportType = ( exptText, exptNumeric, exptFormula );

  TXLNumFormat = (nfGeneral, nfInteger, nfDec2, nfIntRound, nfCurrencyNS, nfCurrency, nfCurrency2, nfCurrencyDec, nfCurrencyDec2, nfPercent, nfPercentDec2,
                   nfFraction, nfFraction2, nfDate1, nfDate2,nfDate3, nfDate4,nfTime1,nfTime2,nfTime3,nfTime4, nfDateTime);
  TExportInfoRec = record
               Xpos, Ypos : extended;
               Font : TFont;
               BGColor : TColor;
               Alignment : TAlignment;
               Text : string;
               Column : integer;
               ExportAs : TExportType;
               ControlName : string;
               XLNumFormat : TXLNumFormat;
             end;

   TTextEncoding = ( AnsiEncoding,
                     ASCIIEncoding,
                     BigEndianUnicodeEncoding,
                     DefaultEncoding,
                     UnicodeEncoding,
                     UTF7Encoding,
                     UTF8Encoding);

  TQRPaperSize = (Default,
                  Letter,
                  LetterSmall,
                  Tabloid,
                  Ledger,
                  Legal,
                  Statement,
                  Executive,
                  A3,
                  A4,
                  A4Small,
                  A5,
                  B4,
                  B5,
                  Folio,
                  Quarto,
                  qr10X14,
                  qr11X17,
                  Note,
                  Env9,// change to 150x100mm
                  Env10,
                  Env11,
                  Env12,
                  Env14,
                  CSheet,
                  DSheet,
                  ESheet,
                  EnvDL,
                  EnvC5,
                  EnvC3,
                  EnvC4,
                  EnvC6,
                  EnvC65,
                  EnvB4,
                  EnvB5,
                  EnvB6,
                  EnvItaly,
                  EnvMonarch,
                  EnvPersonal,
                  FanfoldUSStd,
                  FanfoldGerStd,
                  FanfoldGerLegal,
                  B4ISO,
                  PostcardJap,
                  qr9X11,
                  qr10X11,
                  qr15X11,
                  EnvInvite,
                  Reserved1,
                  Reserved2,
                  LetterExtra,
                  LegalExtra,
                  TabloidExtra,
                  A4Extra,
                  LetterTrans,
                  A4Trans,
                  LetterExtraTrans,
                  SuperASuperAA4,
                  SuperBSuperBA3,
                  LetterPlus,
                  A4Plus,
                  A5Trans,
                  B5Trans,
                  A3Extra,
                  A5Extra,
                  B5Extra,
                  A2,
                  A3Trans,
                  A3ExtraTrans,
                  Custom);
  TQRBin = (First,
            Upper,
            Lower,
            Middle,
            Manual,
            Envelope,
            EnvManual,
            Auto,
            Tractor,
            SmallFormat,
            LargeFormat,
            LargeCapacity,
            Cassette,
            Last);

const
   cQRName = 'QuickReport 5.06.0'; { This string should not be resourced }
   cQRVersion = 50;
   cQRPDefaultExt = 'QRP';      { Default extension for QRP files }
   cQRDefaultExt = 'QR';        { Default extension for QR files }
   { Actual paper sizes for all the known paper types }
   cQRPaperSizeMetrics : array[Letter..A3ExtraTrans, 0..1] of extended =
      ((215.9, 279.4), { Letter }
       (215.9, 279.4), { Letter small }
       (279.4, 431.8), { Tabloid }
       (431.8, 279.4), { Ledger }
       (215.9, 355.6), { Legal }
       (139.7, 215.9), { Statement }
       (190.5, 254.0), { Executive }
       (297.0, 420.0), { A3 }
       (210.0, 297.0), { A4 }
       (210.0, 297.0), { A4 small }
       (148.0, 210.0), { A5 }
       (250.0, 354.0), { B4 }
       (182.0, 257.0), { B5 }
       (215.9, 330.2), { Folio }
       (215.0, 275.0), { Quarto }
       (254.0, 355.6), { 10X14 }
       (279.4, 431.8), { 11X17 }
       (215.9, 279.4), { Note }
       (98.43, 225.4), { Envelope #9 }
       //(150.0, 100.0), { Envelope #9 now Custom label }
       (104.8, 241.3), { Envelope #10 }
       (114.3, 263.5), { Envelope #11 }
       (120.7, 279.4), { Envelope #12 }
       (127.0, 292.1), { Envelope #14 }
       (431.8, 558.8), { C sheet }
       (558.8, 863.6), { D sheet }
       (863.6, 1117.6), { E sheet }
       (110.0, 220.0), { Envelope DL }
       (162.0, 229.0), { Envelope C5 }
       (324.0, 458.0), { Envelope C3 }
       (229.0, 324.0), { Envelope C4 }
       (114.0, 162.0), { Envelope C6 }
       (114.0, 229.0), { Envelope C65 }
       (250.0, 353.0), { Envelope B4 }
       (176.0, 250.0), { Envelope B5 }
       (176.0, 125.0), { Envelope B6 }
       (110.0, 230.0), { Envelope 110 x 230 }
       (98.43, 190.5), { Envelope Monarch }
       (92.01, 165.1), { 6 3/4 Envelope }
       (377.8, 279.4), { US Std Fanfold }
       (215.9, 304.8), { German Std Fanfold }
       (215.9, 330.2), { German Legal Fanfold }
       (250.0, 353.0), { B4 (ISO) }
       (100.0, 148.0), { Japanese Postcard }
       (228.6, 279.4), { 9 x 11 in }
       (254.0, 279.4), { 10 x 11 in }
       (381.0, 279.4), { 15 x 11 in }
       (220.0, 220.0), { Envelope Invite }
       (100.0, 100.0), { RESERVED--DO NOT USE }
       (100.0, 100.0), { RESERVED--DO NOT USE }
       (241.3, 304.8), { Letter Extra }
       (241.3, 381.0), { Legal Extra }
       (296.9, 457.2), { Tabloid Extra }
       (236.0, 322.0), { A4 Extra }
       (279.4, 215.9), { Letter Transverse }
       (297.0, 210.0), { A4 Transverse }
       (304.8, 241.3), { Letter Extra Transverse }
       (227.0, 356.0), { SuperASuperAA4 }
       (305.0, 487.0), { SuperBSuperBA3 }
       (215.9, 322.3), { Letter Plus }
       (210.0, 330.0), { A4 Plus }
       (210.0, 148.0), { A5 Transverse }
       (257.0, 182.0), { B5 (JIS) Transverse }
       (322.0, 445.0), { A3 Extra }
       (174.0, 235.0), { A5 Extra }
       (201.0, 276.0), { B5 (ISO) Extra }
       (420.0, 594.0), { A2 }
       (420.0, 297.0), { A3 Transverse }
       (445.0, 322.0)  { A3 Extra Transverse } );

   { Table for translating TQRPaperSize to values which can be used with the
     printer driver }
   cQRPaperTranslate : array[Default..Custom] of integer =
       (0,
       dmpaper_Letter,
       dmpaper_LetterSmall,
       dmpaper_Tabloid,
       dmpaper_Ledger,
       dmpaper_Legal,
       dmpaper_Statement,
       dmpaper_Executive,
       dmpaper_A3,
       dmpaper_A4,
       dmpaper_A4Small,
       dmpaper_A5,
       dmpaper_B4,
       dmpaper_B5,
       dmpaper_Folio,
       dmpaper_Quarto,
       dmpaper_10X14,
       dmpaper_11X17,
       dmpaper_Note,
       dmpaper_Env_9,
       dmpaper_Env_10,
       dmpaper_Env_11,
       dmpaper_Env_12,
       dmpaper_Env_14,
       dmpaper_CSheet,
       dmpaper_DSheet,
       dmpaper_ESheet,
       dmpaper_Env_DL,
       dmpaper_Env_C5,
       dmpaper_Env_C3,
       dmpaper_Env_C4,
       dmpaper_Env_C6,
       dmpaper_Env_C65,
       dmpaper_Env_B4,
       dmpaper_Env_B5,
       dmpaper_Env_B6,
       dmpaper_Env_Italy,                                                             
       dmpaper_Env_Monarch,
       dmpaper_Env_Personal,
       dmpaper_Fanfold_US,
       dmpaper_Fanfold_Std_German,
       dmpaper_Fanfold_Lgl_German,
       dmpaper_ISO_B4,
       dmpaper_Japanese_Postcard,
       dmpaper_9X11,
       dmpaper_10X11,
       dmpaper_15X11,
       dmpaper_Env_Invite,
       dmpaper_Reserved_48,
       dmpaper_Reserved_49,
       dmpaper_Letter_Extra,
       dmpaper_Legal_Extra,
       dmpaper_Tabloid_Extra,
       dmpaper_A4_Extra,
       dmpaper_Letter_Transverse,
       dmpaper_A4_Transverse,
       dmpaper_Letter_Extra_Transverse,
       dmpaper_A_Plus,
       dmpaper_B_Plus,
       dmpaper_Letter_Plus,
       dmpaper_A4_Plus,
       dmpaper_A5_Transverse,
       dmpaper_B5_Transverse,
       dmpaper_A3_Extra,
       dmpaper_A5_Extra,
       dmpaper_B5_Extra,
       dmpaper_A2,
       dmpaper_A3_Transverse,
       dmpaper_A3_Extra_Transverse,
       $100);
                  
{   cQRBinTranslate : array[First..Last] of integer =
      (1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 0, 0, 15, 15) ; }

   cQRBinTranslate : array[First..Last] of integer =
     (1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 14);

type
  TQRBandType = (rbTitle,
                 rbPageHeader,
                 rbDetail,
                 rbPageFooter,
                 rbSummary,
                 rbGroupHeader,
                 rbGroupFooter,
                 rbSubDetail,
                 rbColumnHeader,
                 rbOverlay,
                 rbWild,
                 rbChild);
  // QR5
  TPrevSaveType = ( stQRP, stPDF, stXL, stHTML, stRTF, stCSV, stASCII, stXML, stXLSX );
const
  // QR5
  QRSaveExtensions : array[ stQRP..stXLSX] of string = ( '.QRP','.PDF','.XLS','.HTML','.RTF','.CSV','.TXT','.XML','.XLSX');
  { Misc constants }
  cQRPageShadowWidth = 2;
  cQRPageFrameWidth = 1;
  cQRPageShadowColor = clBlack;
  cQRCornerSize = 3;

  { TQRCompress related declarations }

const
  { TQRCompress constants }
  MaxChar = 256;
  EofChar = 256;
  PredMax = 255;
  TwiceMax = 512;
  ROOT = 0;
  BitMask : array[0..7] of Byte = (1, 2, 4, 8, 16, 32, 64, 128);

  CM_QRPROGRESSUPDATE = WM_USER + 0;
  CM_QRPAGEAVAILABLE = WM_USER + 1;
  CM_QRPRINT = WM_USER + 2;
  CM_QRPRINTSETUP = WM_USER + 3;
  CM_QRPREVIEWCLOSE = WM_USER + 4;
type
  TQRPrinter = class;

  EQRError = class(Exception);

  CodeType = 0..MaxChar;
  UpIndex = 0..PredMax;
  DownIndex = 0..TwiceMax;
  TreeDownArray = array[UpIndex] of DownIndex;
  TreeUpArray = array[DownIndex] of UpIndex;

  TCM_QRPRogressUpdate = record
    Msg : UINT;
    Position : LPARAM;
    QRPrinter : WPARAM;
  end;

  TCM_QRPageAvailable = record
    Msg : UINT;
    PageCount : LPARAM;
    QRPrinter : WPARAM;
  end;

  TCM_QRPreviewClose = record
    Msg : UINT;
    Dummy : LPARAM;
    QRPrinter : WPARAM;
  end;

  TCM_QRPrint = TMessage;

  { TQRExportFilterLibrary }
  TQRExportFilterClass = class of TQRExportFilter;

  TQRExportFilterLibraryEntry = class
  private
    FExportFilterClass : TQRExportFilterClass;
    FName : string;
    FExtension : string;
  public
    property ExportFilterClass : TQRExportFilterClass read FExportFilterClass write FExportFilterClass;
    property FilterName : string read FName write FName;
    property Extension : string read FExtension write FExtension;
  end;

  TQRTextEncoding = class(TEncoding)
    public
     function GetMaxByteCount(CharCount: Integer): Integer; override;
     function GetMaxCharCount(ByteCount: Integer): Integer; override;
     function GetPreamble: TBytes;override;

  end;

  TQRExportFilterLibrary = class
  private
    FFilterList : TList;
  protected
    function GetSaveDialogFilter : string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddFilter(AFilter : TQRExportFilterClass);
    procedure RemoveFilter(AFilter : TQRExportFilterClass);
    function GetFilterByExtension( fext : string) : TQRExportFilterLibraryEntry;
    property Filters : TList read FFilterList;
    property SaveDialogFilterString : string read GetSaveDialogFilter;
  end;

  { TQRStream }
  TQRStream = class(TStream)
  private
    FLock: TRTLCriticalSection;
    MemoryStream : TMemoryStream;
    FFilename : string;
    FileStream : TFileStream;
    FInMemory : boolean;
    FMemoryLimit : longint;
  public
    constructor Create(pMemoryLimit : Longint);
    constructor CreateFromFile(Filename : string);overload;
    destructor Destroy; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    procedure LockStream;
    procedure UnlockStream;
    procedure SaveToStream(AStream : TStream);
    property InMemory : boolean read FInMemory;
  end;

  { TQRCompress }
  TQRCompress = class
  private
    BitPos : Byte;
    CompressFlag : Boolean;
    InByte : CodeType;
    Left, Right : TreeDownArray;
    OutByte : CodeType;
    Stream : TStream;
    Up : TreeUpArray;
    function GetByte : Byte;
    procedure InitializeSplay;
    procedure Splay(Plain : CodeType);
  public
    constructor Create(aStream : TStream; CompressData : boolean);
    destructor Destroy; override;
    procedure Expand(var Expanded : byte);
    procedure Compress(Plain : CodeType);
  end;

  { TQRPageList }
  TQRPageList = class
  private
    FLock: TRTLCriticalSection;
    aCompressor : TQRCompress;
    FCompression : boolean;
    FPageCount : integer;
    FStream : TQRStream;
{$ifdef NEWQRP}
    FQRPrinter : TQRPrinter;
 {$endif}
    procedure SeekToFirst;
    procedure SeekToLast;
    procedure SeekToPage(PageNumber : integer);
    procedure ReadFileHeader;
    procedure WriteFileHeader;
  public
    constructor Create;
    destructor Destroy; override;
    function GetPage(PageNumber : integer) : TMetafile;
    procedure GetPageEx(PageNumber : integer; var AMetafile : TMetafile; var AHyperlinks : TList);
    procedure AddPage(aMetafile : TMetafile);
    procedure AddPageEx(aMetafile : TMetafile; AHyperlinks : TList);
    procedure AddOutline(Level : integer; Caption : string; Target : TRect; PageNumber : integer);
    procedure Clear;
    procedure Finish;
    procedure LoadFromFile(Filename : string);
    procedure LoadFromStream( inStream : TMemorystream);
    procedure LockList;
    procedure SaveToFile(Filename : string);
    procedure SaveToStream( inStream : TMemorystream);
    procedure UnlockList;
    property Compression : boolean read FCompression write FCompression;
    property PageCount : integer read FPageCount;
    property Stream : TQRStream read FStream write FStream;
  end;

  { TQRPreviewInterface }
  TQRPreviewInterface = class(TComponent)
  public
    function Show(AQRPrinter : TQRPrinter) : TWinControl; virtual;
    function ShowModal(AQRPrinter : TQRPrinter) : TWinControl; virtual;
  end;

  TQRPreviewInterfaceClass = class of TQRPreviewInterface;

  TQRStandardPreviewInterface = class(TQRPreviewInterface)
  public
    function Show(AQRPrinter : TQRPrinter) : TWinControl; override;
    function ShowModal(AQRPrinter : TQRPrinter): TWinControl; override;
  end;

  { TQRPreviewImage }
  TQRZoomState = (qrZoomToFit,qrZoomToWidth,qrZoomOther, qrZoom100);

  THyperlink = class
  public
    Area : TRect;
    Link : string;
    constructor Create (AArea : TRect; ALink : string);
  end;

  TQRHyperlinkEventType = (heCursorMoveOver, heCursorMoveAway, heGoto, heGotoNewWindow);

  TQRPreviewHyperlinkEvent = procedure (Sender : TObject; EventType : TQRHyperlinkEventType; Link : string; var Handled : boolean) of object;

  TQRPreviewImage = class(TGraphicControl)
  private
    FHyperlinks : TList;
    FQRPrinter : TQRPrinter;
    FPageNumber : integer;
    FMetafile : TMetafile;
    FOutline : TTreeNodes;
    FOnHyperlink : TQRPreviewHyperlinkEvent;
    FZoom : integer;
    FIsLink : boolean;
    FLastLink : string;
    function Hyperlink(X, Y : integer) : string;
    procedure PaintPage;
    procedure SetPageNumber(Value : integer);
  protected
    procedure FreeHyperlinks;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetIsLink(Value : boolean);
    property IsLink : boolean read FIsLink write SetIsLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    function ImageOK : boolean;
    function HyperlinksOK : boolean;
    property PageNumber : integer read FPageNumber write SetPageNumber;
    property QRPrinter : TQRPrinter read FQRPrinter write FQRPrinter;
    property Metafile : TMetafile read FMetafile;
    property Hyperlinks : TList read FHyperlinks;
    property Outline : TTreeNodes read FOutline;
    property Zoom : integer read FZoom write FZoom;
    property OnHyperlink : TQRPreviewHyperlinkEvent read FOnHyperlink write FOnHyperlink;
  end;

  { TQRPreview }
  TQRProgressUpdateEvent = procedure (Sender : TObject; Progress : integer) of object;

  TQRPageAvailableEvent = procedure (Sender : TObject; PageNum : integer) of object;

  TQRPreview = Class(TScrollBox)
  private
    FOnPageAvailableEvent : TQRPageAvailableEvent;
    FOnProgressUpdateEvent : TQRProgressUpdateEvent;
    FPreviewImage : TQRPreviewImage;
    FPageNumber : integer;
    FQRPrinter : TQRPrinter;
    FZoom : integer;
    FZoomState : TQRZoomState;
    FOutlineControl : TTreeview;
    procedure SetPageNumber(Value : integer);
    procedure SetZoom(value : integer);
    procedure Fixvalues(Sender : TObject);
    procedure SetQRPrinter(Value : TQRPrinter);
  protected
    function GetOnHyperlink : TQRPreviewHyperlinkEvent;
    procedure SetOnHyperlink(Value : TQRPreviewHyperlinkEvent);
    procedure SetOutline(Value : TTreeview);
    procedure CMPageAvailable(var Message : TCM_QRPageAvailable); Message CM_QRPAGEAVAILABLE;
    procedure CMProgressUpdate(var Message : TCM_QRProgressUpdate); Message CM_QRPROGRESSUPDATE;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    procedure UpdateImage;
    procedure UpdateZoom;
    procedure ZoomToWidth;
    procedure ZoomToFit;
    property PreviewImage : TQRPreviewImage read FPreviewImage;
    property QRPrinter : TQRPrinter read FQRPrinter write SetQRPrinter;
    property ZoomState : TQRZoomState read FZoomState write FZoomState;
  published
    property OnPageAvailable : TQRPageAvailableEvent read FOnPageAvailableEvent
                                                     write FOnPageAvailableEvent;
    property OnProgressUpdate : TQRProgressUpdateEvent read FOnProgressUpdateEvent write FOnProgressUpdateEvent;
    property OnHyperlink : TQRPreviewHyperlinkEvent read GetOnHyperlink write SetOnHyperlink;
    property Outline : TTreeview read FOutlineControl write SetOutline;
    property PageNumber : integer read FPageNumber write setPageNumber;
    property Zoom : integer read FZoom write SetZoom;
  end;

  { TQRExportFilter }
  TQRExportFilter = class
  private
    FOriginalQRPrinter : TQRPrinter;
    FActive : boolean;
    FFilename : string;
    FOwner : TComponent;
  protected
    function GetDescription : string; virtual;
    function GetExtension : string; virtual;
    function GetFilterName : string; virtual;
    function GetVendorName : string; virtual;
    function GetStreaming : boolean; virtual;
  public
     finalDoc : TStringlist;
    constructor Create(Filename : string);virtual;
    destructor Destroy;override;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); virtual;
    procedure EndPage; virtual;
    procedure Finish; virtual;
    procedure NewPage; virtual;
    procedure AcceptGraphic( Xoff, Yoff : extended; GControl : TControl); virtual;
    procedure AcceptTextControl( Xoff, Yoff : extended; GControl : TControl); virtual;
    procedure AcceptBand( aBand : TControl; Xoff, Yoff, Expanded : extended); virtual;
    procedure TextOut(X,Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string); virtual;
    procedure TextOutRec( ExportInfo : TExportInfoRec); virtual;
    property Active : boolean read FActive write FActive;
    property Description : string read GetDescription;
    property FileExtension : string read GetExtension;
    property Filename : string read FFilename;
    property Name : string read GetFilterName;
    property Owner : TComponent read FOwner write FOwner;
    property Streaming : boolean read GetStreaming;
    property Vendor : string read GetVendorName;
    property OriginalQRPrinter : TQRPrinter read FOriginalQRPrinter write FOriginalQRPrinter;
  end;


  { TPrinterSettings }
  TPaperSizesSupported = array[Letter..Custom] of boolean;
  TQRPrinterSettingsEvent = procedure(Sender : TObject; var Cancel : Boolean; DevMode : pointer) of object;

  TPrinterSettings = class
  private
    { Device stuff }
    FIndex : Integer; 
    FDevice : PWideChar;
    FDriver : PWideChar;
    FPort : PWideChar;
    DeviceMode : THandle;
    DevMode : PDeviceMode;
    //devSize : integer;
    PDevMode : PDeviceMode;
    //PDevMode : ^TDevMode;
    { Storage variables }
    FCopies : integer;
    FDuplex : boolean;
    FPrintMetafile : boolean;
    FUseStandardPrinter : boolean;
    FOnGetPrinterSettings : TQRPrinterSettingsEvent;
    FOnApplyPrinterSettings : TQRPrinterSettingsEvent;
    FUseExtendedDuplex : boolean;
    FExtendedDuplex : integer;
    FUseCustomBinCode : boolean;
    FCustomBinCode : integer;
    // QR 4
    FPrintQuality : integer;
    FCollate : integer;
    FColorOption : integer;
    FmemoryLimit : longint;
    FUseCustomPaperCode : boolean;
    FCustomPaperCode : integer;  FMaxExtentX : integer;
    FMaxExtentY : integer;
    FMinExtentX : integer;
    FMinExtentY : integer;
    FOrientation : TPrinterOrientation;
    FOutputBin : TQRBin;
    FPaperSize : TQRPaperSize;
    FPaperSizes : TPaperSizesSupported;
    FPaperWidth : integer;
    FPaperLength : integer;
    FPixelsPerX : integer;
    FPixelsPerY : integer;
    FTopOffset : integer;
    FLeftOffset : integer;
    FPrinter : TPrinter;
    FTitle : string;
    function GetCopies : integer;
    function GetDriver : string;
    function GetDuplex : boolean;
    function GetMaxExtentX : integer;
    function GetMaxExtentY : integer;
    function GetMinExtentX : integer;
    function GetMinExtentY : integer;
    function GetOrientation : TPrinterOrientation;
    function GetOutputBin : TQRBin;
    function GetPaperSize : TQRPaperSize;
    function GetPaperSizeSupported(PaperSize : TQRPaperSize) : boolean;
    function GetPaperWidth : integer;
    function GetPaperLength : integer;
    function GetPixelsPerX : integer;
    function GetPixelsPerY : integer;
    function GetPort : string;
    function GetPrinter : TPrinter;
    function GetTitle : string;
    function GetTopOffset : integer;
    function GetLeftOffset : integer;
    function Supported(Setting : integer) : boolean;
    procedure SetField(aField : integer);
    procedure GetPrinterSettings;
    procedure SetCopies(Value : integer);
    procedure SetDuplex(Value : boolean);
    procedure SetOrientation(Value : TPrinterOrientation);
    procedure SetOutputBin(Value : TQRBin);
    procedure SetPaperSize(Value : TQRPaperSize);
    procedure SetPaperLength(Value : integer);
    procedure SetPaperWidth(Value : integer);
    procedure SetPrinter(Value : TPrinter);
    procedure SetTitle(Value : string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ApplySettings;
    { read only properties }
    property Device : string read GetDriver;
    property Driver : string read GetDriver;
    property LeftOffset : integer read GetLeftOffset;
    property MaxExtentX : integer read GetMaxExtentX;
    property MaxExtentY : integer read GetMaxExtentY;
    property MinExtentX : integer read GetMinExtentX;
    property MinExtentY : integer read GetMinExtentY;
    property PaperSizeSupported[PaperSize : TQRPaperSize] : boolean read GetPaperSizeSupported;
    property PixelsPerX : integer read GetPixelsPerX;
    property PixelsPerY : integer read GetPixelsPerY;
    property Port : string read GetPort;
    property TopOffset : integer read GetTopOffset;
    { Read/write properties }
    property OnGetPrinterSettings : TQRPrinterSettingsEvent read FOnGetPrinterSettings write FOnGetPrinterSettings;
    property OnApplyPrinterSettings : TQRPrinterSettingsEvent read FOnApplyPrinterSettings write FOnApplyPrinterSettings;
    property Copies : integer read GetCopies write SetCopies;
    property Duplex : boolean read GetDuplex write SetDuplex;
    property Orientation : TPrinterOrientation read GetOrientation write SetOrientation;
    property PrintMetafile : boolean read FPrintMetafile write FPrintMetafile;
    property UseStandardprinter : boolean read FUseStandardprinter write FUseStandardprinter;
    property UseExtendedDuplex : boolean read FUseExtendedDuplex write FUseExtendedDuplex;
    property UseCustomBinCode : boolean read FUseCustomBinCode write FUseCustomBinCode;
    property UseCustomPaperCode : boolean read FUseCustomPaperCode write FUseCustomPaperCode;
    property CustomBinCode : integer read FCustomBinCode write FCustomBinCode;
    property ExtendedDuplex : integer read FExtendedDuplex write FExtendedDuplex;
    property CustomPaperCode : integer read FCustomPaperCode write FCustomPaperCode;
    property OutputBin : TQRBin read GetOutputBin write SetOutputBin;
    property PaperLength : integer read GetPaperLength write SetPaperLength;
    property PaperSize : TQRPaperSize read GetPaperSize write SetPaperSize;
    property PaperWidth : integer read GetPaperWidth write SetPaperWidth;
    property MemoryLimit : longint read FMemoryLimit write FMemoryLimit;
    property PrintQuality : integer read FPrintQuality write FPrintQuality;
    property Collate : integer read FCollate write FCollate;
    property ColorOption : integer read FColorOption write FColorOption;
    property Printer : TPrinter read GetPrinter write SetPrinter;
    property Title : string read GetTitle write SetTitle;
  end;

  { TQRPrinterSettings }
  TQRPrinterSettings = class(TPersistent)
  private
    FCopies : integer;
    FDuplex : boolean;
    FOrientation : TPrinterOrientation;
    FOutputBin : TQRBin;
    FPaperSize : TQRPaperSize;
    FPrinterIndex : integer;
    FTitle : string;
    FFirstPage : integer;
    FLastPage : integer;
    // QR36
    FPrintMetafile : boolean;
    FUseStandardPrinter : boolean;
    //FOnGetPrinterSettings : TQRPrinterSettingsEvent;
    //FOnApplyPrinterSettings : TQRPrinterSettingsEvent;
    FUseExtendedDuplex : boolean;
    FExtendedDuplex : integer;
    // QR4
    FMemoryLimit : longint;
    FPrintQuality : integer;
    FCollate : integer;
    FColorOption : integer;
    FUseCustomBinCode : boolean;
    FCustomBinCode : integer;
    FUseCustomPaperCode : boolean;
    FCustomPaperCode : integer;
    //FMaxExtentX : integer;
  public
    constructor Create;
    procedure ApplySettings(APrinter : TQRPrinter);
    property Copies : integer read FCopies write FCopies;
    property Duplex : boolean read FDuplex write FDuplex;
    property FirstPage : integer read FFirstPage write FFirstPage;
    property LastPage : integer read FLastPage write FLastPage;
    property Orientation : TPrinterOrientation read FOrientation write FOrientation;
    property OutputBin : TQRBin read FOutputBin write FOutputBin;
    property PaperSize : TQRPaperSize read FPaperSize write FPaperSize;
    property PrinterIndex : integer read FPrinterIndex write FPrinterIndex;
    property Title : string read FTitle write FTitle;
    // QR3.6
    property PrintMetafile : boolean read FPrintMetafile write FPrintMetafile;
    property UseStandardprinter : boolean read FUseStandardprinter write FUseStandardprinter;
    property UseExtendedDuplex : boolean read FUseExtendedDuplex write FUseExtendedDuplex;
    property UseCustomBinCode : boolean read FUseCustomBinCode write FUseCustomBinCode;
    property UseCustomPaperCode : boolean read FUseCustomPaperCode write FUseCustomPaperCode;
    property CustomBinCode : integer read FCustomBinCode write FCustomBinCode;
    property ExtendedDuplex : integer read FExtendedDuplex write FExtendedDuplex;
    property CustomPaperCode : integer read FCustomPaperCode write FCustomPaperCode;
    // QR4
    property MemoryLimit : longint read FMemoryLimit write FMemoryLimit default 250000;
    property PrintQuality : integer read FPrintQuality write FPrintQuality default 600;
    property Collate : integer read FCollate write FCollate;
    property ColorOption : integer read FColorOption write FColorOption;

  end;

  { TQRPrinter related declarations }

  TQRPrinterDestination = (qrdMetafile, qrdPrinter {$ifdef LLionPDF}, qrdPDFFile{$endif});

  TQRPrinterStatus = (mpReady, mpBusy, mpFinished);

  TQRGenerateToPrinterEvent = procedure of object;
  TQRPrintSetupEvent = procedure of object;
  TQRExportToFilterEvent = procedure (aFilter : TQRExportFilter) of object;
  TQRPreviewEvent = procedure of object;
  TQRAfterPrintEvent = procedure (Sender : TObject) of object;
  TQRAfterPreviewEvent = procedure (Sender : TObject) of object;

  { TQRPrinter }
  TQRPrinter = class(TPersistent)
  private
    aPrinter : TPrinter;
    FParentReport : Tobject;
    aStream : TQRStream;
    FAfterPrintEvent : TQRAfterPrintEvent;
    FAfterPreviewEvent : TQRAfterPreviewEvent;
    FAvailablePages : integer;
    FCancelled : boolean;
    FCanvas : TCanvas;
    FCloseControl : TWinControl;
    FDestination : TQRPrinterDestination;
    FFirstPage : integer;
    FLastpage : integer;
    FLeftWaste : integer;
    //FHyperlinks : TList;
    FClient : TWinControl;
    FMaster : TWinControl;
    FMetafile : TMetafile;
    FOnExportToFilterEvent : TQRExportToFilterEvent;
    FOnPreviewEvent : TNotifyEvent;
    FOnPrintSetupEvent : TQRPrintSetupEvent;
    FPage : TMetafile;
    FPageCount : integer;
    FPageNumber : integer;
    FPrinterOK : boolean;
    FProgress : integer;
    FMasterProgressStart : integer;
    FMasterProgressEnd : integer;
    FTitle : string;
    FTopWaste : integer;
    FShowingPreview : boolean;
    FStatus : TQRPrinterStatus;
    FXFactor : extended;
    FYFactor : extended;
    FPageList : TQRPageList;
    FPreviewControl : TWinControl;
    FReportLoaded : boolean;
    function CurrentPageOK : boolean;
    function GetLeftWaste : integer;
    function GetBin : TQRBin;
    function GetCanvas : TCanvas;
    function GetCompression : boolean;
    function GetCopies : integer;
    function GetDuplex : boolean;
    function GetOrientation : TPrinterOrientation;
    function GetPaperLength : integer;
    function GetPaperSize : TQRPaperSize;
    function GetPaperWidth : integer;
    function GetPrinterIndex : integer;
    function GetPrinters : TStrings;
    function GetTopWaste : integer;
    function GetOnGetPrinterSettings : TQRPrinterSettingsEvent;
    function GetOnApplyPrinterSettings : TQRPrinterSettingsEvent;
    function GetUseStandardPrinter : boolean;
    function GetPrintMetafile : boolean;
    function GetUseCustomBinCode : boolean;

    function GetPrinterHandle : THandle;
    function GetPrintQuality : integer;
    function GetCollate : integer;
    function GetColorOption : integer;
    procedure SetPrintQuality( value : integer);
    procedure SetCollate( value : integer);
    procedure SetColorOption( value : integer);

    function GetUseExtendedDuplex : boolean;
    function GetUseCustomPaperCode : boolean;
    function GetCustomBinCode : integer;
    function GetExtendedDuplex : integer;
    function GetCustomPaperCode : integer;
    procedure SetOnGetPrinterSettings(Value : TQRPrinterSettingsEvent);
    procedure SetOnApplyPrinterSettings(Value : TQRPrinterSettingsEvent);
    procedure SetUseStandardPrinter(Value : boolean);
    procedure CreateMetafileCanvas;
    procedure CreatePrinterCanvas;
    procedure EndMetafileCanvas;
    procedure EndPrinterCanvas;
    procedure SetUseExtendedDuplex( value : boolean);
    procedure SetUseCustomBinCode( value : boolean);
    procedure SetUseCustomPaperCode( value : boolean);
    procedure SetExtendedDuplex( value : integer);
    procedure SetCustomBinCode( value : integer);
    procedure SetCustomPaperCode( value : integer);
    procedure SetAvailablePages(Value : integer);
    procedure SetBin(Value : TQRBin);
    procedure SetCompression(Value : boolean);
    procedure SetCopies(Value : integer);
    procedure SetDestination(Value : TQRPrinterDestination);
    procedure SetDuplex(Value : boolean);
    procedure SetOrientation(Value : TPrinterOrientation);
    procedure SetPaperLength(Value : integer);
    procedure SetPageNumber(Value : integer);
    procedure SetPaperSize(Value : TQRPaperSize);
    procedure SetPaperWidth(Value : integer);
    procedure SetPrinterIndex(Value : integer);
    procedure SetProgress(Value : integer);
    procedure SetShowingPreview(Value : boolean);
    procedure SetPrintMetafile(Value : boolean);
{$ifdef LLIONPDF}
    procedure CreatePDFCanvas;
{$endif}    
  public
    aPrinterSettings : TPrinterSettings;
    DPLeftMargin, DPTopmargin : extended;
{$ifdef LLIonPDF}
    PDFDoc : TPDFDocument;
{$endif}
    procedure PrintMetafileDirect( filename : string; frompage, topage : integer);
    procedure ExportMetafile( filename : string; frompage, topage : integer);
    constructor Create( parentrep : TObject);
    destructor Destroy; override;
    function GetPage(Value : integer) : TMetafile;
    procedure GetPageEx(Value : integer; var AMetafile : TMetafile;
                              var AHyperlinks : TList);
    function XPos(Value : extended) : integer;
    function XSize(Value : extended) : integer;
    function YPos(Value : extended) : integer;
    function YSize(Value : extended) : integer;
    function PaperLengthValue : integer;
    function PaperWidthValue : integer;
    procedure AbortDoc;
    procedure BeginDoc;
    procedure Cancel;
    procedure Cleanup;
    procedure ClosePreview(Control : TWinControl);
    procedure EndDoc;
    procedure ExportToFilter(aFilter : TQRExportFilter);
    procedure FreeHyperlinks;
    procedure AddHyperlink(ARect : TRect; AHyperlink : string);
    procedure AddOutline(Level : integer; Caption : string; Target : TRect);
    procedure Load(Filename : string);
    procedure LoadFromStream( inStream : TMemoryStream);
    procedure NewPage;
    procedure Preview;
    procedure PreviewModal;
    procedure Print;
    procedure PrintSetup;
    procedure Save(Filename : string);
    property ParentReport : TObject read FParentReport write FParentReport;
    property ReportLoaded : boolean read FReportLoaded write FReportLoaded;
    property AfterPreview : TQRAfterPreviewEvent read FAfterPreviewEvent write FAfterPreviewEvent;
    property AfterPrint : TQRAfterPrintEvent read FAfterPrintEvent write FAfterPrintEvent;
    property AvailablePages : integer read FAvailablePages write SetAvailablePages;
    property OutputBin : TQRBin read GetBin write SetBin;
    property PreviewControl : TWinControl read FPreviewControl write FPreviewControl;
    property Cancelled : boolean read FCancelled write FCancelled;
    property Canvas : TCanvas read GetCanvas;
    property Client : TWinControl read FClient write FClient;
    property Compression : boolean read GetCompression write SetCompression;
    property Copies : integer read GetCopies write SetCopies;
    property Destination : TQRPrinterDestination read FDestination write SetDestination;
    property Duplex : boolean read GetDuplex write SetDuplex;
    property FirstPage : integer read FFirstPage write FFirstPage;
    property LastPage : integer read FLastPage write FLastPage;
    property LeftWaste : integer read GetLeftWaste;
    property Master : TWinControl read FMaster write FMaster;
    property Orientation : TPrinterOrientation read GetOrientation write SetOrientation;
    property OnExportToFilter : TQRExportToFilterEvent read FOnExportToFilterEvent
                                                       write FOnExportToFilterEvent;
    property OnPreview : TNotifyEvent read FOnPreviewEvent write FOnPreviewEvent;
    property OnPrintSetup : TQRPrintSetupEvent read FOnPrintSetupEvent write FOnPrintSetupEvent;
    property OnGetPrinterSettings : TQRPrinterSettingsEvent read GetOnGetPrinterSettings write SetOnGetPrinterSettings;
    property OnApplyPrinterSettings : TQRPrinterSettingsEvent read GetOnApplyPrinterSettings write SetOnApplyPrinterSettings;
    property PageList : TQRPageList read FPageList write FPageList;
    property PaperLength : Integer read GetPaperLength write SetPaperLength;
    property UseStandardPrinter : boolean read GetUseStandardPrinter write SetUseStandardPrinter;
    property UseExtendedDuplex : boolean read GetUseExtendedDuplex write SetUseExtendedDuplex;
    property UseCustomBinCode : boolean read GetUseCustomBinCode write SetUseCustomBinCode;
    property UseCustomPaperCode : boolean read GetUseCustomPaperCode write SetUseCustomPaperCode;
    property CustomBinCode : integer read GetCustomBinCode write SetCustomBinCode;
    property ExtendedDuplex : integer read GetExtendedDuplex write SetExtendedDuplex;
    property CustomPaperCode : integer read GetCustomPaperCode write SetCustomPaperCode;
    property Page : TMetafile read FPage;
    property PageCount : integer read FPageCount write FPageCount;
    property PageNumber : Integer read FPageNumber write SetPageNumber;
    property PaperWidth : Integer read GetPaperWidth write SetPaperWidth;
    property PaperSize : TQRPaperSize read GetPaperSize write SetPaperSize;
    property PrinterIndex : integer read GetPrinterIndex write SetPrinterIndex;
    property PrintMetafile : boolean read GetPrintMetafile write SetPrintMetafile;
    property PrinterOK : boolean read FPrinterOK;
    property Printers : TStrings read GetPrinters;
    property Progress : integer read FProgress write SetProgress;
    property MasterProgressStart : integer read FMasterProgressStart write FMasterProgressStart;
    property MasterProgressEnd : integer read FMasterProgressEnd write FMasterProgressEnd;
    property ShowingPreview : boolean read FShowingPreview write SetShowingPreview;
    property Status : TQRPrinterStatus read FStatus;
    property Title : string read FTitle write FTitle;
    property TopWaste : integer read GetTopWaste;
    property XFactor : extended read FXFactor write FXFactor;
    property YFactor : extended read FYFactor write FYFactor;
    property PrintQuality : integer read GetPrintQuality write SetPrintQuality;
    property PrinterHandle : THandle read GetPrinterHandle;
    property Collate : integer read GetCollate write SetCollate;
    property ColorOption : integer read GetColorOption write SetColorOption;
  end;

//ERP 2

  TQRHyperlinkSourceMethod = procedure (Sender : TObject; Parameters : string) of object;

  procedure RegisterHyperlinkSource(ASignature : string; SourceMethod : TQRHyperlinkSourceMethod);
  procedure UnregisterHyperlinkSource(ASignature : string);
  procedure PerformHyperlink(Sender : TObject; Link : string);
  procedure PaintPageToCanvas(APage : TMetafile; ACanvas : TCanvas; ARect : TRect; PaintFrameAnyway : boolean);

  function AnsiPos(Substr: string; S: string): integer;
  function GetFonts : TStrings;

  function TempFilename : string;
  function QRPaperName(Size : TQRPaperSize) : string;

  procedure RegisterPreviewClass(APreviewInterface : TQRPreviewInterfaceClass);

  function QRPrinter : TQRPrinter;
  function QRHyperlinkSources : TList;
  function DefaultPrinterPaperSize: TQRPaperSize;

var
  QRExportFilterLibrary : TQRExportFilterLibrary;
  CompositePrinterIndex : integer;

implementation

uses
  QRPrev, ShellAPI, quickrpt, qrprgres, qrpdffilt, qrctrls, qrxbrowser;

var
  FQRPrinter : TQRPrinter;
  GlobalPreviewInterface : TQRPreviewInterfaceClass;
  FQRHyperlinkSources : TList;

const
  cQRPFormatVersion = 3;

type
  TQRFileHeader = record
    FormatVersion : word;                   { File format version }
    QRVersion : word;                       { QR version }
    PageSize : TQRPaperSize;
    PageCount : integer;
    CreateDateTime : TDateTime;
    Portrait : boolean;                     { field added in header version 2 }
    Compression : byte;                     { 0 - no compression, 1 - splay }
{$ifdef NEWQRP}
    VersFlag : integer;
    PaperSize : integer;
    Columns : integer;
    BottomMargin : double;
    ColumnSpace : double;
    LeftMargin : double;
    Length : double;
    RightMargin : double;
    TopMargin : double;
    Width : double;
{$else}
    EmptySpace : array[0..100] of byte;
{$endif}
  end;

  TQRHyperlinkSourceRecord = record
    Signature : string;
    SourceMethod : TQRHyperlinkSourceMethod;
  end;

  PQRHyperlinkSourceRecord = ^TQRHyperlinkSourceRecord;

type
  bar = array of char;
var
  MFSearchStr : string;
  MFFound : boolean;
  MFMatchCase : boolean;

function MetaEnum(DC : THandle; HandleTable : pointer; MetaRec : Pointer; Count : word; dummy : pointer) : shortint stdcall;
var
  aStr : string;
  Ofs : integer;
  Len : integer;
  I : integer;
begin
  with tagENHMETARECORD(MetaRec^) do
  begin
    case iType of
      EMR_EXTTEXTOUTW,
      EMR_EXTTEXTOUTA : begin
                          aStr := '';
                          Ofs := (tagEMREXTTEXTOUTA(Metarec^).EMRText.offString);
                          Len := (tagEMREXTTEXTOUTA(Metarec^).EMRText.nChars);
                          SetLength(aStr, Len);
                          for I := 0 to len - 1 do
                            aStr[I+1] := char(bar(MetaRec^)[ofs + (I*2)]);
                        end;
    end;
  end;
  if not MFMatchCase then aStr := AnsiUppercase(AStr);
  if Pos(MFSearchStr, aStr) > 0 then
  begin
    Result := 0;
    MFFound := true;
  end else
    Result := 1;
end;

function StrInMetafile(AString : string; AMetafile : TMetafile; MatchCase : boolean) : boolean;
begin
  if MatchCase then
    MFSearchStr := AString
  else
    MFSearchStr := AnsiUppercase(AString);
  MFFound := false;
  MFMatchCase := MatchCase;
  EnumEnhMetafile(0, AMetafile.handle, @MetaEnum, nil, rect(0,0,0,0));
  Result := MFFound;
end;

function DefaultPrinterPaperSize: TQRPaperSize;
var
   ADevice, ADriver, APort : array[0..1000] of WideChar;
   hDm :  THandle;
   Pdm : ^DEVMODE;
   aSize : integer;
   I : TQRPaperSize;
begin
  Result := Default;

  if printer = nil then exit;
  if printer.Printers.Count=0 then exit;
  try
   Printer.GetPrinter(ADevice, ADriver, APort, hDm);
   Pdm := GlobalLock (hDm);
   Try
    if (Pdm^.dmFields and DWORD(dm_papersize)) = DWORD(dm_papersize) then
    begin
      aSize := Pdm^.dmPaperSize;
      for I := Default to Custom do
      begin
        if aSize=cQRPaperTranslate[I] then
        begin
          Result := I;
          Break;
        end;
      end ;
    end;
   finally
      GlobalUnlock(hDm);
   End;
  except
     // do nothing
  end;

end;

procedure RegisterHyperlinkSource(ASignature : string; SourceMethod : TQRHyperlinkSourceMethod);
var
  ASource : PQRHyperlinkSourceRecord;
begin
  New(ASource);
  try
    ASource^.Signature := ASignature;
    ASource^.SourceMethod := SourceMethod;
  finally
    QRHyperlinkSources.Add(ASource);
  end;
end;

procedure UnregisterHyperlinkSource(ASignature : string);
var
  I : integer;
  ASource : PQRHyperlinkSourceRecord;
begin
  for I := 0 to QRHyperlinkSources.Count - 1 do
  begin
    ASource := PQRHyperlinkSourceRecord(QRHyperlinkSources[I]);
    if ASource^.Signature = ASignature then
    begin
//      Release(ASource); //Must fix!
      QRHyperlinkSources.Delete(I);
      Exit;
    end;
  end;
end;

procedure PerformHyperlink(Sender : TObject; Link : string);

  procedure DoExternal(ALink : string);
  begin
    ShellExecute(TQRPrinter(Sender).PreviewControl.Handle, 'open', PChar(ALink), nil, nil, SW_SHOW);
  end;

  function DoInternal(ALink : string) : boolean;
  var
    I : integer;
  begin
    Result := false;
    for I := 0 to QRHyperlinkSources.Count - 1 do
    begin
      with PQRHyperlinkSourceRecord(QRHyperlinkSources[I])^ do
      begin
        if Signature = copy(ALink, 1, Length(Signature)) then
        begin
          SourceMethod(Sender, copy(ALink, Length(Signature) + 1, Length(Link)));
          Result := true;
          exit;
        end;
      end;
    end;
  end;

begin
  if Uppercase(copy(Link, 1, 4)) = 'EXT:' then
    DoExternal(copy(Link, 5, Length(Link) - 4))
  else
    if Uppercase(copy(Link, 1,4)) = 'INT:' then
      DoInternal(copy(Link, 5, Length(Link) - 4))
    else
    begin
      if not DoInternal(Link) then
        DoExternal(Link);
    end;
end;

{$ifdef EvalVersion}
function DelphiRunning : boolean;
var
  H1, H2, H3, H4 : Hwnd;
const
  A1 : array[0..12] of char = 'TApplication'#0;
  A2 : array[0..15] of char = 'TAlignPalette'#0;
  A3 : array[0..18] of char = 'TPropertyInspector'#0;
  A4 : array[0..11] of char = 'TAppBuilder'#0;
  T1 : array[0..6] of char = 'Delphi'#0;
begin
  H2 := FindWindow(A2, nil);
  H3 := FindWindow(A3, nil);
  H4 := FindWindow(A4, nil);
  Result := (H2 <> 0) and
            (H3 <> 0) and (H4 <> 0);
end;
{$endif}
// QR5042 : using byte buffer to avoid chars
function QRPHeaderSize(const Stream : TStream ) : integer;
var
  OldPosition : Integer;
  //Buf : array[0..3] of Char;
  Buf : array[0..2] of byte;
  FoundSize : boolean;
  k, fp : integer;
begin
  // Assert parameters
  Assert(Assigned(Stream));

  // Check for the EMF header.  In versions previous to Delphi 5, the
  // string EMF will be found at $AD.
  OldPosition := Stream.Position;
  try
    Stream.Position := $ad;
    Stream.ReadBuffer(Buf, 3);
    // looking for 'EMF'
    FoundSize := (Buf[0] = $45) and (Buf[1] = $4D) and (Buf[2] = $46);
    result := 124;
    if not foundSize then
    begin
      Stream.Position := $A9;
      Stream.ReadBuffer(Buf, 3);
      FoundSize := (Buf[0] = $45) and (Buf[1] = $4D) and (Buf[2] = $46);
      result := 120;
    end;

    if not foundSize then
    begin
      Stream.Position := $91;
      Stream.ReadBuffer(Buf, 3);
      FoundSize := (Buf[0] = $45) and (Buf[1] = $4D) and (Buf[2] = $46);
      result := 96;
    end;
    // this is the current format
    if not FoundSize then
    begin
      result := 128;
      Stream.Position := $B1;
      Stream.ReadBuffer( Buf, 3 );
      FoundSize := (Buf[0] = $45) and (Buf[1] = $4D) and (Buf[2] = $46);
    end;
    if not FoundSize then
    begin
      // handle the strange format
      fp := -1;
      for k := 0 to Stream.Size-4 do
      begin
          Stream.Position := k;
          Stream.ReadBuffer(Buf, 3);
          FoundSize := (Buf[0] = $45) and (Buf[1] = $4D) and (Buf[2] = $46);
          if FoundSize then
          begin
              fp := k;
              break;
          end;
          if k > 1000 then break;
      end;
      if fp>-1 then
      begin
         result := fp-49;
      end
      else
         result := 128;
      end;
  finally
    Stream.Position := OldPosition;
  end;
end;

function GetFileHeaderSize( const Stream: TStream ): Integer;
begin
  // Assert parameters
  Assert( Assigned( Stream ) );
  // Determine size of header
  result := QRPHeaderSize(Stream);
end; // function GetFileHeaderSize

procedure FixupFileHeader( const Stream: TStream; var aFileHeader: TQRFileHeader );
type
  TQRD4FileHeader = packed record           // Packed to have full control over alignment
    FormatVersion : word;                   { File format version }
    QRVersion : word;                       { QR version }
    PageSize : TQRPaperSize;
    Reserved1 : array[ 0..2 ] of Byte;      // Fixup to match delphi 4 record alignment
    PageCount : integer;
    CreateDateTime : TDateTime;
    Portrait : boolean;                     { field added in header version 2 }
    Compression : byte;                     { 0 - no compression, 1 - splay }
    EmptySpace : array[0..100] of byte;
  end;
var
  D4FileHeader  : TQRD4FileHeader;
  FileSize: integer;
begin
  // Assert parameters
  Assert( Assigned( Stream ) );
  FileSize := GetFileHeaderSize(Stream);

  // Now do the fixup, if necessary
  if FileSize = 124 then begin
    Move( aFileHeader, D4FileHeader, 124 ); // Move record into old format record

    // Now copy values field by field
    aFileHeader.FormatVersion := D4FileHeader.FormatVersion;
    aFileHeader.QRVersion := D4FileHeader.QRVersion;
    aFileHeader.PageSize := D4FileHeader.PageSize;
    aFileHeader.PageCount := D4FileHeader.PageCount;
    aFileHeader.CreateDateTime := D4FileHeader.CreateDateTime;
    aFileHeader.Portrait := D4FileHeader.Portrait;
    aFileHeader.Compression := D4FileHeader.Compression;
{$ifndef NEWQRP}
    Move( D4FileHeader.EmptySpace, aFileHeader.EmptySpace, 101 );
{$endif}
  end;
end; // procedure FixupFileHeader


function AnsiPos(Substr: string; S: string): integer;
begin
  result := Pos(Substr,S);
end;

function QRPaperName(Size : TQRPaperSize) : string;
const
  Names : array[Default..Custom] of string = (
   SqrPaperSize0, SqrPaperSize1, SqrPaperSize2, SqrPaperSize3,
   SqrPaperSize4, SqrPaperSize5, SqrPaperSize6, SqrPaperSize7,
   SqrPaperSize8, SqrPaperSize9, SqrPaperSize10, SqrPaperSize11,
   SqrPaperSize12, SqrPaperSize13, SqrPaperSize14, SqrPaperSize15,
   SqrPaperSize16, SqrPaperSize17, SqrPaperSize18, SqrPaperSize19,
   SqrPaperSize20, SqrPaperSize21, SqrPaperSize22, SqrPaperSize23,
   SqrPaperSize24, SqrPaperSize25, SqrPaperSize26, SqrPaperSize27,
   SqrPaperSize28, SqrPaperSize29, SqrPaperSize30, SqrPaperSize31,
   SqrPaperSize32, SqrPaperSize33, SqrPaperSize34, SqrPaperSize35,
   SqrPaperSize36, SqrPaperSize37, SqrPaperSize38, SqrPaperSize39,
   SqrPaperSize40, SqrPaperSize41, SqrPaperSize42, SqrPaperSize43,
   SqrPaperSize44, SqrPaperSize45, SqrPaperSize46, SqrPaperSize47,
   SqrPaperSize48, SqrPaperSize49, SqrPaperSize50, SqrPaperSize51,
   SqrPaperSize52, SqrPaperSize53, SqrPaperSize54, SqrPaperSize55,
   SqrPaperSize56, SqrPaperSize57, SqrPaperSize58, SqrPaperSize59,
   SqrPaperSize60, SqrPaperSize61, SqrPaperSize62, SqrPaperSize63,
   SqrPaperSize64, SqrPaperSize65, SqrPaperSize66, SqrPaperSize67,
   SqrPaperSize68, SqrPaperSize69);

begin
  Result := Names[Size];
end;

function TempFilename : string;
var
  AName,
  ADir : array[0..MAX_PATH] of widechar;
begin
  GetTempPath(MAX_PATH, adir);
  GetTempFilename(aDir, PWideChar('QRP'), 0, aName);
  result := StrPas(aName);
end;

{ TQRStream }
constructor TQRStream.Create(pMemoryLimit : longint);
begin
  inherited Create;
  FInMemory := true;
  MemoryStream := TMemoryStream.Create;
  FMemoryLimit := pMemoryLimit;
  InitializeCriticalSection(FLock);
end;

{TQREncoding }
function TQRTextEncoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := 0;
end;

function TQRTextEncoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount;
end;

function TQRTextEncoding.GetPreamble: TBytes;
begin
  SetLength(Result, 0);
end;

{TQRStream}
{$define FASTLOAD}
{$ifdef FASTLOAD}
// by Enrico K�hlmann. Load up memory stream to allow file to be closed.
constructor TQRStream.CreateFromFile(Filename : string);
begin
  inherited Create;
   FInMemory := true;
   FileStream := TFileStream.Create(Filename, fmOpenRead + fmShareDenyNone);
   FMemoryLimit := filestream.Size + 1000;
   filestream.Position := 0;
   memorystream := TMemorystream.Create;
   memorystream.LoadFromStream(filestream);
   filestream.Free;
   memorystream.Position := 0;
   InitializeCriticalSection(FLock);
end;
{$else}
constructor TQRStream.CreateFromFile(Filename : string);
begin
  inherited Create;
  FInMemory := false;
  FileStream := TFileStream.Create(Filename, fmOpenRead + fmShareDenyNone);
  FMemoryLimit := 0;
  InitializeCriticalSection(FLock);
end;
{$endif}

destructor TQRStream.Destroy;
begin
  LockStream;
  try
    if InMemory then
      MemoryStream.Free
    else
    begin
      //DeleteFile(FileStream.FileName);
      FileStream.Free;
      DeleteFile(FFilename);
    end;
  finally
    if FileExists( FFilename) then
        DeleteFile(FFilename);
    UnlockStream;
    DeleteCriticalSection(FLock);
  end;
  inherited Destroy;
end;

procedure TQRStream.LockStream;
begin
  EnterCriticalSection(FLock);
end;

procedure TQRStream.UnlockStream;
begin
  LeaveCriticalSection(FLock);
end;

function TQRStream.Write(const Buffer; Count: Longint): Longint;
begin
  LockStream;
  if InMemory then
  begin
    result := MemoryStream.Write(Buffer,Count);
    if MemoryStream.Size > FMemoryLimit then {...this could be optimized somewhat }
    begin
      FFilename := TempFilename;
      if Assigned(FileStream) then FreeAndNil(FileStream);
      FileStream := TFileStream.Create(FFilename, fmCreate or fmOpenReadWrite);
      MemoryStream.SaveToStream(FileStream);
      MemoryStream.Free;
      FInMemory := false;
    end
  end else
    result := FileStream.Write(Buffer,Count);
  UnlockStream;
end;

function TQRStream.Read(var Buffer; Count: Longint): Longint;
begin
  LockStream;
  if InMemory then
    result := MemoryStream.Read(Buffer,Count)
  else
    result := FileStream.Read(Buffer,Count);
  UnlockStream;
end;

function TQRStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  LockStream;
  if InMemory then
    result := MemoryStream.Seek(Offset,Origin)
  else
    result := FileStream.Seek(Offset,Origin);
  UnlockStream;
end;

procedure TQRStream.SaveToStream(AStream : TStream);
var
  Buffer : array[0..10240] of byte;
  BytesRead : longint;
begin
  LockStream;
  Position := 0;
  repeat
    BytesRead := Read(Buffer,10240);
    AStream.Write(Buffer,BytesRead);
  until BytesRead=0;
  UnlockStream;
end;

{ TQRCompress }

constructor TQRCompress.Create(aStream : TStream; CompressData : boolean);
begin
  Stream := aStream;
  InitializeSplay;
  if CompressData then
    BitPos := 0
  else
    BitPos := 7;
  OutByte := 0;
  CompressFlag := CompressData;
end;

destructor TQRCompress.Destroy;
begin
  if CompressFlag and (BitPos<>0) then
    Stream.Write(OutByte,1);
  inherited Destroy;
end;

procedure TQRCompress.InitializeSplay;
var
  I : DownIndex;
  J : UpIndex;
  K : DownIndex;
begin
  for I := 1 to TwiceMax do
    Up[I] := (I-1) shr 1;
  for J := 0 to PredMax do
  begin
    K := (J+1) shl 1;
    Left[J] := K-1;
    Right[J] := K;
  end;
end;

procedure TQRCompress.Splay(Plain : CodeType);
var
  A, B : DownIndex;
  C, D : UpIndex;
begin
  A := Plain+MaxChar;
  repeat
    C := Up[A];
    if C <> ROOT then
    begin
      D := Up[C];
      B := Left[D];
      if C = B then
      begin
        B := Right[D];
        Right[D] := A;
      end else
        Left[D] := A;
      if A = Left[C] then
        Left[C] := B
      else
        Right[C] := B;
      Up[A] := D;
      Up[B] := C;
      A := D;
    end else
      A := C;
  until A = ROOT;
end;

procedure TQRCompress.Compress(Plain : CodeType);
{ Compress a single byte }
var
  A : DownIndex;
  U : UpIndex;
  Sp : 0..MaxChar;
  Stack : array[UpIndex] of Boolean;
begin
  A := Plain+MaxChar;
  Sp := 0;
  repeat
    U := Up[A];
    Stack[Sp] := (Right[U] = A);
    inc(Sp);
    A := U;
  until A = ROOT;
  repeat
    dec(Sp);
    if Stack[Sp] then
      OutByte := OutByte or BitMask[BitPos];
    if BitPos = 7 then
    begin
      Stream.Write(OutByte, 1); { writebyte }
      BitPos := 0;
      OutByte := 0;
    end else
      inc(BitPos);
  until Sp = 0;
  Splay(Plain);
end;

function TQRCompress.GetByte : Byte;
begin
  Stream.Read(Result, 1);
end;

procedure TQRCompress.Expand(var Expanded : byte);
{ Expand a single byte }
var
  A : DownIndex;
begin
  A := ROOT;
  repeat
    if BitPos = 7 then
    begin
      InByte := GetByte;
      BitPos := 0;
    end else
      inc(BitPos);
    if InByte and BitMask[BitPos] = 0 then
      A := Left[A]
    else
      A := Right[A];
  until A > PredMax;
  dec(A, MaxChar);
  Splay(A);
  Expanded := A;
end;


{ TQRPageList }

constructor TQRPageList.Create;
begin
  inherited Create;
  FPageCount := 0;
  FCompression := false;
  FStream := nil;
  InitializeCriticalSection(FLock);
end;

destructor TQRPageList.Destroy;
begin
  DeleteCriticalSection(FLock);
  if assigned(FStream) then
    FreeAndNil(FStream);
  inherited Destroy;
end;

procedure TQRPageList.Clear;
begin
  FPageCount := 0;
end;

procedure TQRPageList.LockList;
begin
  EnterCriticalSection(FLock);
end;

procedure TQRPageList.UnlockList;
begin
  LeaveCriticalSection(FLock);
end;

procedure TQRPageList.Finish;
begin
  WriteFileHeader;
end;

procedure TQRPageList.LoadFromFile;
begin
  if assigned(FStream) then
    Stream.Free;
  Stream := TQRStream.CreateFromFile(Filename);
  ReadFileHeader;
  GetPage(PageCount).Free;
end;

procedure TQRPageList.LoadFromStream( inStream : TMemorystream);
begin
  if assigned(FStream) then
    Stream.Free;
  Stream := TQRStream.Create( instream.Size);
  Stream.MemoryStream.LoadFromStream(instream);
  ReadFileHeader;
end;

procedure TQRPageList.SaveToStream( inStream : TMemorystream);
begin
   Stream.SaveToStream(inStream);
end;

procedure TQRPageList.SaveToFile(Filename : string);
var
  AStream : TFileStream;
begin
  AStream := TFileStream.Create(Filename,fmCreate or fmOpenReadWrite);
  Stream.SaveToStream(AStream);
  AStream.Free;
end;

procedure TQRPageList.SeekToFirst;
begin
  Stream.Position := GetFileHeaderSize( Stream );
end;

procedure TQRPageList.SeekToLast;
var
  PrevPosition : longint;
begin
  Stream.Seek(-SizeOf(PrevPosition), soFromEnd);
  Stream.Read(PrevPosition,SizeOf(PrevPosition));
  Stream.Position := PrevPosition;
end;

procedure TQRPageList.SeekToPage(PageNumber : integer);
var
  ThisPageNum : longint;
  NextPosition : longint;
  PrevPosition : longint;
begin
  if PageNumber = 1 then
    SeekToFirst
  else
{    if PageNumber = PageCount then
      SeekToLast
    else}
    begin
      if Stream.Position = Stream.Size then
        SeekToLast;
      Stream.Read(ThisPageNum, SizeOf(ThisPageNum));
      Stream.Seek(-SizeOf(ThisPageNum), soFromCurrent);
      if ThisPageNum<PageNumber then
      begin
        repeat
          Stream.Read(ThisPageNum, SizeOf(ThisPageNum));
          if ThisPageNum<>PageNumber then
          begin
            Stream.Read(NextPosition, SizeOf(NextPosition));
            Stream.Position := NextPosition;
          end;
        until ThisPageNum=PageNumber;
        Stream.Seek(-SizeOf(ThisPageNum), soFromCurrent);
      end else
        if ThisPageNum>PageNumber then
        begin
          repeat
            Stream.Read(ThisPageNum,SizeOf(ThisPageNum));
            if ThisPageNum<>PageNumber then
            begin
              Stream.Position := Stream.Position - SizeOf(PrevPosition) - SizeOf(ThisPageNum);
              Stream.Read(PrevPosition,SizeOf(PrevPosition));
              Stream.Position := PrevPosition;
            end;
          until ThisPageNum=PageNumber;
          Stream.Seek(-SizeOf(ThisPageNum), soFromCurrent);
        end;
    end;
end;

function TQRPageList.GetPage(PageNumber : integer) : TMetafile;
var
  Dummy : longint;
  TempStream : TMemoryStream;
  aByte : byte;
  BytesToGet : longint;
  I : longint;
begin
  if PageNumber > PageCount then
    result := nil
  else
  try
    LockList;
    SeekToPage(PageNumber);
    Stream.Read(Dummy,SizeOf(Dummy));
    Stream.Read(Dummy,SizeOf(Dummy));
    BytesToGet := BytesToGet-Stream.Position;
    result := TMetafile.Create;
    if Compression then
    begin
      Stream.Read(BytesToGet,SizeOf(BytesToGet));
      TempStream := TMemoryStream.Create;
      aCompressor := TQRCompress.Create(Stream, false);
      for I := 1 to BytesToGet do
      begin
        aCompressor.Expand(aByte);
        TempStream.Write(aByte,1);
      end;
      aCompressor.Free;
      TempStream.Position := 0;
      result.LoadFromStream(TempStream);
      TempStream.Free;
    end else
      result.LoadFromStream(Stream);
    Stream.Read(Dummy, SizeOf(Dummy));
  finally
    UnlockList;
  end;
end;

procedure TQRPageList.GetPageEx(PageNumber : integer; var AMetafile : TMetafile; var AHyperlinks : TList);
var
  Dummy : longint;
  TempStream : TMemoryStream;
  aByte : byte;
  BytesToGet : longint;
  I : longint;
  LinksToGet : longint;
  ARect : TRect;
  AString : string;
begin
  if PageNumber > PageCount then
  begin
    AMetafile := nil;
    AHyperlinks := nil;
  end else
  try
    LockList;
    SeekToPage(PageNumber);
    Stream.Read(Dummy,SizeOf(Dummy));
    Stream.Read(Dummy,SizeOf(Dummy));
    BytesToGet := BytesToGet-Stream.Position;
    AMetafile := TMetafile.Create;
    if Compression then
    begin
      Stream.Read(BytesToGet,SizeOf(BytesToGet));
      TempStream := TMemoryStream.Create;
      aCompressor := TQRCompress.Create(Stream, false);
      for I := 1 to BytesToGet do
      begin
        aCompressor.Expand(aByte);
        TempStream.Write(aByte,1);
      end;
      aCompressor.Free;
      TempStream.Position := 0;
      AMetafile.LoadFromStream(TempStream);
      TempStream.Free;
    end else
    begin
      AMetafile.LoadFromStream(Stream);
      Stream.Read(LinksToGet, Sizeof(LinksToGet));
      if LinksToGet > 0 then
      begin
        AHyperlinks := TList.Create;
        for I := 0 to LinksToGet - 1 do
        begin
          Stream.Read(ARect, SizeOf(ARect));
          Stream.Read(dummy, sizeOf(Dummy));
          SetLength(AString, Dummy);
          Stream.Read(AString[1], Dummy);
          AHyperlinks.Add(THyperlink.Create(ARect, AString));
        end
      end else
        AHyperlinks := nil;
    end;
    Stream.Read(Dummy, SizeOf(Dummy));
  finally
    UnlockList;
  end;
end;

procedure TQRPageList.ReadFileHeader;
var
  aFileHeader : TQRFileHeader;
  hsize : integer;
  savepos : int64;
  hbuff : array[0..3] of byte;
begin
  Stream.Position := 0;
  hsize := GetFileHeaderSize(Stream);
  Stream.Read(aFileHeader, GetFileHeaderSize(Stream));
  FixupFileHeader(Stream, aFileHeader);
  if (hsize = 128) or (hsize=124) then // fixes load from some earlier QR versions
     FPageCount := aFileHeader.PageCount
  else if hsize = 120 then  // actually in bytes 5-8 of the header
  begin
     savepos := stream.Position;
     stream.Position := 5;
     stream.Read( hbuff, 4);
      // assuming bigendian
     Fpagecount := hbuff[0] + (16*hbuff[1]) + (256*hbuff[2]) + (65536*hbuff[3]);
     stream.Position := savepos;
  end;
  Compression := aFileHeader.Compression = 1  //JB fix
end;

procedure TQRPageList.WriteFileHeader;
var
  aFileHeader : TQRFileHeader;
{$ifndef NEWQRP}
  i : integer;
{$endif}
begin
  Stream.Position := 0;
{$ifdef NEWQRP}
   AFileHeader.VersFlag := 4060;
   AFileHeader.PaperSize := integer(TQuickrep(FQRPrinter.ParentReport).Page.papersize);
   AFileHeader.LeftMargin := TQuickrep(FQRPrinter.ParentReport).Page.LeftMargin;
   AFileHeader.BottomMargin := TQuickrep(FQRPrinter.ParentReport).Page.BottomMargin;
   AFileHeader.TopMargin := TQuickrep(FQRPrinter.ParentReport).Page.TopMargin;
   AFileHeader.Length := TQuickrep(FQRPrinter.ParentReport).Page.Length;
   AFileHeader.Width := TQuickrep(FQRPrinter.ParentReport).Page.width;
   AFileHeader.Columns := TQuickrep(FQRPrinter.ParentReport).Page.Columns;
   AFileHeader.ColumnSpace := TQuickrep(FQRPrinter.ParentReport).Page.ColumnSpace;
{$else}
  for i := 0 to 99 do AFileheader.EmptySpace[i] := ord( 'H');
{$endif}
  aFileHeader.FormatVersion := cQRPFormatVersion;
  aFileHeader.QRVersion := cQRVersion;
  aFileHeader.PageCount := PageCount;
  aFileHeader.CreateDateTime := Now;
  if Compression then
    aFileHeader.Compression := 1
  else
    aFileHeader.Compression := 0;
  Stream.Write(aFileHeader, SizeOf(aFileHeader));
end;

procedure TQRPageList.AddPage(aMetafile : TMetafile);
var
  I,
  SavePos1,
  SavePos2,
  SavePos3 : longint;
  TempStream : TMemoryStream;
  aByte : byte;

  procedure SavePreInfo;
  var
    aPageCount : longint;
  begin
    aPageCount := FPageCount;
    Stream.Position := Stream.Size;
    SavePos1 := Stream.Position;                    { Store start position }
    Stream.Write(aPageCount, SizeOf(aPageCount));   { Write page number }
    SavePos2 := Stream.Position;                    { Store metafile size pos }
    Stream.Write(SavePos2, SizeOf(SavePos2));       { Reserve space for size }
  end;

  procedure SavePostInfo;
  begin
    Stream.Write(SavePos1, Sizeof(SavePos1));       { Store previous start }
    SavePos3 := Stream.Position;                    { Store post of next }
    Stream.Position := SavePos2;                    { Go back to reserved pos }
    Stream.Write(SavePos3, Sizeof(SavePos3));       { Save pos of next};
    Stream.Position := SavePos3;                    { Go to end of stream }
  end;

begin
  try
    LockList;
    inc(FPageCount);
    if PageCount = 1 then
      WriteFileHeader;
    if Compression then
    begin
      TempStream := TMemoryStream.Create;
      AMetafile.SaveToStream(TempStream);
      SavePreInfo;
      aCompressor := TQRCompress.Create(Stream,true);
      TempStream.Position := 0;
      I := TempStream.Size;
      Stream.Write(I,SizeOf(I));
      for I := 0 to TempStream.Size - 1 do
      begin
        TempStream.Read(aByte,1);
        aCompressor.Compress(aByte);
      end;
      aCompressor.Free;
      TempStream.Free;
      SavePostInfo;
    end else
    begin
      SavePreInfo;
      AMetaFile.SaveToStream(Stream);               { Save the metafile }
      SavePostInfo;
    end;
  finally
    UnlockList;
  end;
end;

procedure TQRPageList.AddPageEx(aMetafile : TMetafile; AHyperlinks : TList);
var
  I,
  SavePos1,
  SavePos2,
  SavePos3 : longint;
  TempStream : TMemoryStream;
  aByte : byte;
  aLongint : Longint;

  procedure SavePreInfo;
  var
    aPageCount : longint;
  begin
    aPageCount := FPageCount;
    Stream.Position := Stream.Size;
    SavePos1 := Stream.Position;                    { Store start position }
    Stream.Write(aPageCount, SizeOf(aPageCount));   { Write page number }
    SavePos2 := Stream.Position;                    { Store metafile size pos }
    Stream.Write(SavePos2, SizeOf(SavePos2));       { Reserve space for size }
  end;

  procedure SavePostInfo;
  begin
    Stream.Write(SavePos1, Sizeof(SavePos1));       { Store previous start }
    SavePos3 := Stream.Position;                    { Store post of next }
    Stream.Position := SavePos2;                    { Go back to reserved pos }
    Stream.Write(SavePos3, Sizeof(SavePos3));       { Save pos of next};
    Stream.Position := SavePos3;                    { Go to end of stream }
  end;

begin
  try
    LockList;
    inc(FPageCount);
    if PageCount = 1 then
      WriteFileHeader;
    if Compression then
    begin
      TempStream := TMemoryStream.Create;
      AMetafile.SaveToStream(TempStream);
      SavePreInfo;
      aCompressor := TQRCompress.Create(Stream,true);
      TempStream.Position := 0;
      I := TempStream.Size;
      Stream.Write(I,SizeOf(I));
      for I := 0 to TempStream.Size - 1 do
      begin
        TempStream.Read(aByte,1);
        aCompressor.Compress(aByte);
      end;
      aCompressor.Free;
      TempStream.Free;
      SavePostInfo;
    end else
    begin
      SavePreInfo;
      AMetaFile.SaveToStream(Stream);               { Save the metafile }
      if AHyperlinks <> nil then
      begin
        aLongint := AHyperlinks.Count;
        Stream.Write(ALongint,SizeOf(Longint));
        for I := 0 to AHyperlinks.Count - 1 do
        begin
          with THyperlink(AHyperlinks[I]) do
          begin
            Stream.Write(Area, Sizeof(TRect));
            aLongint := Length(Link);
            Stream.Write(ALongint, Sizeof(ALongint));
            Stream.Write(Link[1],Length(link));
          end
        end;
      end else
      begin
        aLongint := 0;
        Stream.Write(ALongint,SizeOf(Longint));
      end;
      SavePostInfo;
    end;
  finally
    UnlockList;
  end;
end;

procedure TQRPageList.AddOutline(Level : integer; Caption : string; Target : TRect; PageNumber : integer);
begin
end;

function QREnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
                       FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

function GetFonts : TStrings;
begin
  if Printer.Printers.Count = 0 then
    Result := Screen.Fonts
  else
    Result := Printer.Fonts;
end;

{ TQRPreviewInterface }

function TQRPreviewInterface.Show(AQRPrinter : TQRPrinter) : TWinControl;
begin
  Result := nil;
end;

function TQRPreviewInterface.ShowModal(AQRPrinter : TQRPrinter) : TWinControl;
begin
  Result := nil;
end;

function TQRStandardPreviewInterface.Show(AQRPrinter : TQRPrinter) : TWinControl;
begin
  Result := TQRStandardPreview.CreatePreview(Application, AQRPrinter);
  TQRStandardPreview(Result).Show;
end;

function TQRStandardPreviewInterface.ShowModal(AQRPrinter : TQRPrinter) : TWinControl;
begin
  Result := TQRStandardPreview.CreatePreview(Application, AQRPrinter);
  TQRStandardPreview(Result).ShowModal;
end;

{ TQRPreviewImage }

constructor THyperlink.Create(AArea: TRect; ALink: string);
begin
  inherited Create;
  Area := AArea;
  Link := ALink;
end;

constructor TQRPreviewImage.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Height := 50;
  Width := 100;
  Zoom := 100;
  QRPrinter := nil;
  FMetafile := nil;
  FHyperlinks := nil;
  FPageNumber := 1;
  FOnHyperlink := nil;
  FIsLink := false;
  FLastLink := '';
end;

destructor TQRPreviewImage.Destroy;
begin
  if ImageOK then
    FreeAndNil(FMetafile);
  inherited Destroy;
end;

function TQRPreviewImage.ImageOK : boolean;
begin
  Result := FMetafile <> nil;
end;

function TQRPreviewImage.HyperlinksOK : boolean;
begin
  Result := FHyperlinks <> nil;
end;

procedure TQRPreviewImage.FreeHyperlinks;
var
  I : integer;
begin
  if HyperlinksOK then
  begin
    for I := 0 to FHyperlinks.Count - 1 do
      THyperlink(FHyperlinks[I]).Free;
    FHyperlinks.Free;
    FHyperlinks := nil;
  end;
end;

function TQRPreviewImage.Hyperlink(X, Y: integer): string;
var
  I : integer;
begin
  X := round(X/Zoom*100);
  Y := round(Y/Zoom*100);
  if FHyperlinks <> nil then
  begin
    I := 0;
    while I < FHyperlinks.Count do
      with THyperlink(FHyperlinks[I]).Area do
      begin
        if (X>=Left) and (X<=Right) and (Y>=Top) and (Y<=Bottom) then
        begin
          Result := THyperlink(FHyperlinks[I]).Link;
          FLastLink := Result;
          Exit;
        end else
          inc(I);
      end;
  end;
  Result := '';
end;

procedure TQRPreviewImage.SetIsLink(Value : boolean);
var
  Handled : boolean;
begin
  if Value <> FIsLink then
  begin
    FIsLink := Value;
    Handled := false;
    if assigned(FOnHyperlink) then
      if FIsLink then
        FOnHyperlink(QRPrinter, heCursorMoveOver, FLastLink, Handled)
      else
        FOnHyperlink(QRPrinter, heCursorMoveAway, '', Handled);
  end;
end;

procedure TQRPreviewImage.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Handled : boolean;
begin
  inherited;
  Handled := false;
  if IsLink and assigned(FOnHyperlink) then
  begin
    FOnHyperlink(QRPrinter, heGoto, FLastlink, Handled);
    if not Handled then PerformHyperlink(QRPrinter, FLastlink);
  end;
end;

procedure TQRPreviewImage.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Hyperlink(X, Y) <> '' then
  begin
    Cursor := crHandpoint;
    IsLink := true;
  end else
  begin
    Cursor:= crDefault;
    IsLink := false;
  end;
end;

procedure TQRPreviewImage.Paint;
begin
  PaintPage;
end;

procedure PaintPageToCanvas(APage : TMetafile; ACanvas : TCanvas; ARect : TRect; PaintFrameAnyway : boolean);
var
  ImageOK : boolean;
  Height,
  Width : integer;
begin
  ImageOK := APage <> nil;
  Height := ARect.Bottom - ARect.Top;
  Width := ARect.Right - ARect.Left;
  if ImageOK or PaintFrameAnyway then
    with ACanvas do
    begin
      Brush.Color := clWhite;
      Pen.Color := clWhite;
      Rectangle(ARect.Left + 1, ARect.Top + 1, ARect.Left + Width - cQRPageFrameWidth - cQRPageShadowWidth, ARect.Top + Height - cQRPageFrameWidth - cQRPageShadowWidth);
    end;
  if ImageOK then
  begin
    ACanvas.StretchDraw(ARect, APage);
    // MODIFICATION 12/05/05 DLM playmetafile tryout
    //PlayEnhMetafile( ACanvas.handle, APage.Handle, ARect);
  end;
  if ImageOK or PaintFrameAnyway then
    with ACanvas do
    begin
      Pen.Color := cQRPageShadowColor;
      Pen.Width := cQRPageFrameWidth;
      with ARect do
      begin
        MoveTo(Left, Top);
        LineTo(Left, Top + Height - cQRPageFrameWidth - cQRPageShadowWidth);
        LineTo(Left + Width - cQRPageFrameWidth - cQRPageShadowWidth, Top + Height - cQRPageFrameWidth - cQRPageShadowWidth);
        LineTo(Left + Width - cQRPageFrameWidth - cQRPageShadowWidth, Top);
        LineTo(Left, Top);
        Brush.Color := cQRPageShadowColor;
        Rectangle(Left + Width - cQRPageShadowWidth, Top + cQRPageShadowWidth, Right, Bottom);
        Rectangle(Left + cQRPageShadowWidth, Top + Height - cqrPageShadowWidth, Right, Bottom);
      end;
    end;
end;

procedure TQRPReviewImage.PaintPage;
begin
  PaintPageToCanvas(FMetaFile, Canvas, Rect(0,0, Width, Height), csDesigning in ComponentState);
end;

procedure TQRPreviewImage.SetPageNumber(Value: integer);
begin
  FPageNumber := Value;
  if assigned(FMetafile) then
    FMetafile.Free;
  FMetafile := nil;
  if assigned(FQRPrinter) then
  begin
    FMetafile := QRPrinter.GetPage(Value);
  end;
  PaintPage;
end;

{ TQRPreview }

constructor TQRPreview.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FPreviewImage := TQRPreviewImage.Create(self);
  FPreviewImage.Parent := self;
  with FPreviewImage do
  begin
    Top := 0;
    Left := 0;
  end;
  HorzScrollbar.Tracking := true;
  VertScrollBar.Tracking := true;
  FZoom := 100;
  FQRPrinter := nil;
  ZoomState := qrZoomOther{qrDefaultZoom};
  OnResize := FixValues;
  self.OnEnter := FixValues;
  Height := 250;
  Width := 250;
  FPageNumber := 1;
  FOnPageAvailableEvent := nil;
  FOnProgressUpdateEvent := nil;
  FOutlineControl := nil;
end;

destructor TQRPreview.Destroy;
begin
  if QRPrinter <> nil then QRPrinter := nil;
  inherited Destroy;
end;

procedure TQRPreview.SetQRPrinter(Value : TQRPrinter);
begin
  if assigned(FQRPrinter) and (FQRPrinter.Client = self) then
  begin
    FQRPrinter.ShowingPreview := false;
    FQRPrinter.Client := nil;
  end;
  FQRPrinter := Value;
  FPreviewImage.QRPrinter := Value;
  if FQRPrinter <> nil then
  begin
    FQRPrinter.Client := self;
    FQRPrinter.ShowingPreview := true;
  end;
  PageNumber := 1;
  PreviewImage.PageNumber := 1;
  Invalidate;
  FPreviewImage.OnClick := OnClick;
  FPreviewImage.OnDblClick := OnDblClick;
  FPreviewImage.OnDragDrop := OnDragDrop;
  FPreviewImage.OnDragOver := OnDragOver;
  FPreviewImage.OnEndDrag := OnEndDrag;
  FPreviewImage.OnMouseDown := OnMouseDown;
  FPreviewImage.OnMouseMove := OnMouseMove;
  FPreviewImage.OnMouseUp := OnMouseUp;
end;

procedure TQRPreview.CMPageAvailable(var Message : TCM_QRPageAvailable);
begin
  if Message.PageCount = PageNumber then
    UpdateImage;
  if assigned(FOnPageAvailableEvent) then
  try
    FOnPageAvailableEvent(Self, Message.PageCount);
  finally
  end;
end;

procedure TQRPreview.CMProgressUpdate(var Message : TCM_QRProgressUpdate);
begin
  if assigned(FOnProgressUpdateEvent) then
  try
    FOnProgressUpdateEvent(Self, Message.Position);
  finally
  end;
end;

procedure TQRPreview.SetPageNumber(value : integer);
begin
  if ((Value <> FPageNumber) or (not PreviewImage.ImageOK)) and (Value > 0)
    and assigned(FQRPrinter) and (Value <= QRPrinter.PageCount) then
  begin
    FPreviewImage.PageNumber := Value;
    FPageNumber := Value;
    VertScrollBar.Position := 0;
    HorzScrollBar.Position := 0;
  end;
end;

procedure TQRPreview.UpdateImage;
begin
  if assigned(FPreviewImage) and not FPreviewImage.ImageOK and
    (FPreviewImage.PageNumber <= QRPrinter.AvailablePages) then
  begin
    if tquickrep(QRPrinter.FParentReport).PrevInitialZoom = qrZoomToWidth then
                           ZoomToWidth;
    FPreviewImage.PageNumber := FPreviewImage.PageNumber;
  end;
end;

procedure TQRPreview.UpdateZoom;
begin
  //if assigned(FQRPrinter) then
  if FQRPrinter<>nil then
  begin
    with FPreviewImage do
    begin
      Width := round(QRPrinter.XSize(QRPrinter.PaperWidthValue / 100 * self.FZoom)) +
               cQRPageShadowWidth + cQRPageFrameWidth * 2;
      Height := round(QRPrinter.YSize(QRPrinter.PaperLengthValue / 100 * self.FZoom)) +
                cQRPageShadowWidth + cQRPageFrameWidth * 2;
    end
  end else
  begin
    with FPreviewImage do
    begin
      Width := round(cQRPaperSizeMetrics[Letter, 0] / 100 * self.FZoom) +
               cQRPageShadowWidth + cQRPageFrameWidth * 2;
      Height := round(cQRPaperSizeMetrics[Letter, 1] / 100 * self.FZoom) +
                cQRPageShadowWidth + cQRPageFrameWidth * 2;
    end;
  end;
  if FPreviewImage.Width < self.Width then
    FPreviewImage.Left := (width - FPreviewImage.width) div 2
  else
    FPreviewImage.Left := 0;
  if FPreviewImage.Height < Height then
    FPreviewImage.Top := ((Height - FPreviewImage.Height) div 2)
  else
    FPreviewImage.Top := 0;
  HorzScrollBar.Position := 0;
  VertScrollBar.Position := 0;
  FPreviewImage.Zoom := FZoom;
end;

procedure TQRPreview.FixValues(Sender : TObject);
begin
  if ZoomState = qrZoomToFit then
    ZoomToFit
  else
    if ZoomState = qrZoomToWidth then
      ZoomToWidth;
  UpdateZoom;
end;

procedure TQRPreview.SetZoom(Value:integer);
begin
  if (Value >= 2) and (Value <= 2000) then
  begin
    ZoomState := qrZoomOther;
    FZoom := Value;
    UpdateZoom;
  end;
end;

procedure TQRPreview.ZoomToFit;
var
  Zoom1,
  Zoom2 : Integer;
begin
  if assigned(FQRPrinter) then
  begin
    Zoom1 := round(Width / QRPrinter.XSize(QRPrinter.PaperWidthValue) * 95);
    Zoom2 := round(Height / QRPrinter.YSize(QRPrinter.PaperLengthValue) * 95);
  end else
  begin
    Zoom1 := round((Width / cQRPaperSizeMetrics[Letter, 0]) * 95);
    Zoom2 := round((Height / cQRPaperSizeMetrics[Letter, 1]) * 95);
  end;
  if Zoom1 < Zoom2 then
    Zoom := Zoom1
  else
    Zoom := Zoom2;
  UpdateZoom;
  ZoomState := qrZoomToFit;
end;

procedure TQRPreview.ZoomToWidth;
begin
  if assigned(FQRPrinter) then
    Zoom := round((Width / QRPrinter.XSize(QRPrinter.PaperWidthValue)) * 90)
  else
    Zoom := round((Width / cQRPaperSizeMetrics[Letter, 0]) * 95);
  UpdateZoom;
  ZoomState := qrZoomToWidth;
end;

function TQRPreview.GetOnHyperlink : TQRPreviewHyperlinkEvent;
begin
  result := FPreviewImage.OnHyperlink;
end;

procedure TQRPreview.SetOnHyperlink(Value : TQRPreviewHyperlinkEvent);
begin
  FPreviewImage.OnHyperlink := Value;
end;

procedure TQRPreview.SetOutline(Value : TTreeview);
begin
end;

{ TQRExportFilter }
constructor TQRExportFilter.Create(Filename : string);
begin
  inherited Create;
  FFilename := Filename;
  FOwner := nil;
  Active := false;
  finalDoc := TStringlist.create;
end;

destructor TQRExportFilter.Destroy;
begin
  FreeAndNil(finaldoc);
  inherited Destroy;
end;

function TQRExportFilter.GetDescription : string;
begin
  result := SqrAbstractFilterDescription;
end;

function TQRExportFilter.GetExtension : string;
begin
  result := '';
end;

function TQRExportFilter.GetFilterName : string;
begin
  result := SqrAbstractFilterName;
end;

function TQRExportFilter.GetVendorName : string;
begin
  result := SqrQuSoft;
end;

function TQRExportFilter.GetStreaming : boolean;
begin
  Result := false;
end;

procedure TQRExportFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
begin
  Active := true;
end;

procedure TQRExportFilter.EndPage;
begin
end;

procedure TQRExportFilter.Finish;
begin
  Active := false;
end;

procedure TQRExportFilter.NewPage;
begin
end;

procedure TQRExportFilter.AcceptGraphic( Xoff, Yoff : extended; GControl : TControl);
begin
end;

procedure TQRExportFilter.AcceptTextControl( Xoff, Yoff : extended; GControl : TControl);
begin
end;

procedure TQRExportFilter.AcceptBand( aBand : TControl; Xoff, Yoff, Expanded : extended);
begin
end;

procedure TQRExportFilter.TextOut(X,Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string);
begin
end;

procedure TQRExportFilter.TextOutRec( ExportInfo : TExportInfoRec);
begin
end;

{ TQRExportFilterLibrary }

constructor TQRExportFilterLibrary.Create;
begin
  inherited Create;
  FFilterList := TList.Create;
end;

destructor TQRExportFilterLibrary.destroy;
var
  I : integer;
begin
  for I := 0 to FFilterList.Count - 1 do
    TQRExportFilterLibraryEntry(FFilterList[I]).Free;
  FFilterList.Free;
  inherited Destroy;
end;

procedure TQRExportFilterLibrary.AddFilter(AFilter : TQRExportFilterClass);
var
  aTmpFilter : TQRExportFilter;
  aLibraryEntry : TQRExportFilterLibraryEntry;
  k : integer;
  exists : boolean;
begin
  aTmpFilter := AFilter.Create('');
  aLibraryEntry := TQRExportFilterLibraryEntry.Create;
  aLibraryEntry.ExportFilterClass := AFilter;
  aLibraryEntry.FilterName := aTmpFilter.Name;
  aLibraryEntry.Extension := aTmpFilter.FileExtension;
  aTmpFilter.Free;
  // is there one of these already ?
  exists := false;
  for k := 0 to FFilterlist.Count-1 do
  begin
      if TQRExportFilterLibraryEntry(FFilterlist[k]).ExportFilterClass.ClassNameIs(AFilter.ClassName) then
                                   exists := true;
  end;
  if not exists then FFilterList.Add(aLibraryEntry)
  else
      aLibraryEntry.Free;
end;

procedure TQRExportFilterLibrary.RemoveFilter(AFilter : TQRExportFilterClass);
var
  aTmpFilter : TQRExportFilter;
  I : integer;
  aLibraryEntry : TQRExportFilterLibraryEntry;
begin
  if FFilterlist = nil then exit;
  try
    aTmpFilter := AFilter.Create('');
    for I := 0 to FFilterList.Count - 1 do
      if TQRExportFilterLibraryEntry(FFilterList[I]).FilterName = aTmpFilter.Name then
      begin
        aLibraryEntry := TQRExportFilterLibraryEntry(FFilterList[I]);
        FFilterList.Delete(I);
        aTmpFilter.Free;
        aLibraryEntry.Free;
        Exit;
      end;
    except
        // nothing
    end;
end;

function TQRExportFilterLibrary.GetFilterByExtension( fext : string) : TQRExportFilterLibraryEntry;
var
  I : integer;
begin
  result := nil;
  for I := 0 to Filters.Count - 1 do
    with TQRExportFilterLibraryEntry(Filters[I]) do
        if CompareText(Extension, fext)=0 then
        begin
            result := TQRExportFilterLibraryEntry(Filters[I]);
            exit;
        end;
end;

function TQRExportFilterLibrary.GetSaveDialogFilter : string;
var
  I : integer;
begin
  result := SqrQRFile + '(*.' +cQRPDefaultExt + ')|*.' + cqrpDefaultExt;
  for I := 0 to Filters.Count - 1 do
    with TQRExportFilterLibraryEntry(Filters[I]) do
        result := result + '|' + FilterName + ' (*.' + Extension + ')|*.' + Extension;
end;

// RP 2
{ TPrinterSettings }

constructor TPrinterSettings.Create;
begin
  inherited Create;
  GetMem(FDevice, 1024);
  GetMem(FDriver, 1024);
  GetMem(FPort, 1024);
  FPaperSize := A4;
  FPrinter := nil;
  FUseStandardPrinter := false;
  FOnApplyPrinterSettings := nil;
  FOnGetPrinterSettings := nil;
  FMemoryLimit := 250000;
  FIndex := -1; 
end;

destructor TPrinterSettings.Destroy;
begin
  FreeMem(FDevice, 1024);
  FreeMem(FDriver, 1024);
  FreeMem(FPort, 1024);
  //if devmode <> nil then  freemem(devmode,devsize);
  inherited Destroy;
end;

function TPrinterSettings.GetCopies : integer;
begin
  Result := FCopies;
end;

function TPrinterSettings.GetDriver : string;
begin
  Result := StrPas(FDriver);
end;

function TPrinterSettings.GetDuplex : boolean;
begin
  Result := FDuplex;
end;

function TPrinterSettings.GetMaxExtentX : integer;
begin
  Result := FMaxExtentX;
end;

function TPrinterSettings.GetMaxExtentY : integer;
begin
  Result := FMaxExtentY;
end;

function TPrinterSettings.GetMinExtentX : integer;
begin
  Result := FMinExtentX;
end;

function TPrinterSettings.GetMinExtentY : integer;
begin
  Result := FMinExtentY;
end;

function TPrinterSettings.GetOrientation : TPrinterOrientation;
begin
  Result := FOrientation;
end;

function TPrinterSettings.GetOutputBin : TQRBin;
begin
  Result := FOutputBin;
end;

function TPrinterSettings.GetPaperSize : TQRPaperSize;
begin
  Result := FPaperSize;
end;

function TPrinterSettings.GetPaperSizeSupported(PaperSize : TQRPaperSize) : boolean;
begin
  result := FPaperSizes[PaperSize];
end;

function TPrinterSettings.GetPaperWidth : integer;
begin
  if (PaperSize <> Custom) and (PaperSize <> Default) then
    Result := round(cQRPaperSizeMetrics[PaperSize, 0] * 10)
  else
    Result := FPaperWidth;
end;

function TPrinterSettings.GetPaperLength : integer;
begin
  if (PaperSize <> Custom) and (PaperSize <> Default) then
    Result := round(cQRPaperSizeMetrics[PaperSize, 1] * 10)
  else
    Result := FPaperLength;
end;

function TPrinterSettings.GetPixelsPerX : integer;
begin
  Result := FPixelsPerX;
end;

function TPrinterSettings.GetPixelsPerY : integer;
begin
  Result := FPixelsPerY;
end;

function TPrinterSettings.GetPort : string;
begin
  Result := StrPas(FPort);
end;

function TPrinterSettings.GetTopOffset : integer;
begin
  Result := FTopOffset;
end;

function TPrinterSettings.GetLeftOffset : integer;
begin
  Result := FLeftOffset;
end;

function TPrinterSettings.GetPrinter : TPrinter;
begin
  Result := FPrinter;
end;

function TPrinterSettings.GetTitle : string;
begin
  Result := FTitle;
end;

function TPrinterSettings.Supported(Setting : integer) : boolean;
begin
  if assigned(FPrinter) and (DevMode <> nil )then
    Supported := (DevMode^.dmFields and DWORD(Setting)) = DWORD(Setting)
  else
    Supported := false;
end;

procedure TPrinterSettings.SetField(aField : integer);
begin
  DevMode^.dmFields := DevMode^.dmFields or DWORD(aField);
end;

procedure TPrinterSettings.GetPrinterSettings;
var
  Cancel : boolean;

  procedure GPrinter;
  begin
    Application.ProcessMessages;
    FPrinter.GetPrinter(FDevice, FDriver, FPort, DeviceMode);
    if DeviceMode=0 then
         Printer.GetPrinter(FDevice, FDriver, FPort, DeviceMode);
    PDevMode := GlobalLock( DeviceMode );
{.$define EXTRA_DEVMODE}
 {$ifdef EXTRA_DEVMODE}
    devSize := PDevMode.dmSize + PDevMode.dmDriverExtra ;
    GetMem( DevMode, devSize );
    Move( PDevMode^, DevMode^, devSize );
 {$else}
    devmode := GlobalLock(DeviceMode);
 {$endif}
  end;

  procedure GCopies; { Number of copies }
  begin
    if Supported(dm_copies) then
      FCopies := DevMode^.dmCopies
    else
      FCopies := 1;
  end;
  // if the DevMode^.dmDefaultSource doesn't correspond to a cQRBinTranslate[I]
  // then what ?? If custom value is in use it won't matter.
  procedure GBin; { Paper bin }
  var
    aBin : integer;
    I : TQRBin;
  begin
    FOutputBin := First; // default
    if Supported(dm_defaultsource) then
    begin
      aBin := DevMode^.dmDefaultSource;
      for I := First to Last do
        if cQRBinTranslate[I] = aBin then
        begin
          FOutputBin := I;
          exit;
        end;
    end;
  end;
  
  procedure GDuplex; { Duplex }
  begin
    if not Supported(dm_duplex) then  exit;
    FDuplex := (DevMode^.dmDuplex <> dmdup_simplex);
    FExtendedDuplex := DevMode^.dmDuplex;
end;

  procedure GPixelsPer; { Horizontal and Vertical pixels per inch }
  begin
    FPixelsPerX := GetDeviceCaps(FPrinter.Handle, LOGPIXELSX);
    FPixelsPerY := GetDeviceCaps(FPrinter.Handle, LOGPIXELSY);
  end;

  procedure GOffset; { Top left printing offset (waste) }
  var
    PrintOffset: TPoint;
  begin
    PrintOffset.X := GetDeviceCaps(FPrinter.Handle, PHYSICALOFFSETX);
    PrintOffset.Y := GetDeviceCaps(FPrinter.Handle, PHYSICALOFFSETY);
    FLeftOffset := round(PrintOffset.X/PixelsPerX*254);
    FTopOffset := round(PrintOffset.Y/PixelsPerY*254);
  end;

  procedure GPaperSize;
  var
    aSize : integer;
    I : TQRPaperSize;
  begin
    FPaperSize := Default;
    if Supported(dm_papersize) then
    begin
      aSize := DevMode^.dmPaperSize;
      for I := Default to Custom do
      begin
        if aSize=cQRPaperTranslate[I] then
        begin
          FPaperSize := I;
          exit;
        end
      end
    end
  end;

  procedure GPaperDim;
  var
    PSize : TPoint;
  begin
    PSize.X := GetDeviceCaps(FPrinter.Handle, PHYSICALWIDTH);
    PSize.Y := GetDeviceCaps(FPrinter.Handle, PHYSICALHEIGHT);
    FPaperWidth := round(PSize.X / PixelsPerX * 254);
    FPaperLength := round(PSize.Y / PixelsPerY * 254);
  end;

  procedure GPaperSizes;
  var
    DCResult : array of word;
    I : integer;
    J : TQRPaperSize;
    Count : integer;
  begin
    Count := DeviceCapabilities(FDevice, FPort, DC_PAPERS, nil, DevMode);
    if Count = -1 then
    begin
        FPaperSizes[Custom] := true;
        exit;
    end;
    SetLength(DCResult, Count);
    Fillchar(Pointer(DCResult)^, Count * Sizeof(word), #0);
    Fillchar(FPaperSizes,Sizeof(FPaperSizes),#0);
    Count := DeviceCapabilities(FDevice, FPort, DC_PAPERS, PWideChar(DCResult), DevMode);
    for I := 0 to Count - 1 do
    begin
      for J := Letter to Custom do
      begin
        if cQRPaperTranslate[J] = DCResult[I] then
        begin
          FPaperSizes[J] := true;
          break;
        end
      end
    end;
    FPaperSizes[Custom] := true;
  end;

begin
 try
  if FPrinter<>nil then
  begin
    try
       GPrinter;
    except
       DevMode := nil;
    end;
    // network printer bug. If the printer is not online
    if DevMode = nil then exit;
    //  NO settings may have changed  %%%
    //if FPrinter.PrinterIndex = FIndex then Exit;
    Cancel := false;
    if assigned(OnGetPrinterSettings) then
      OnGetPrintersettings( self, Cancel, devmode);
    if Cancel then
    begin
      GlobalUnlock(DeviceMode);
      exit; // user has Cancelled in event
    end;
    GPixelsPer;
    GCopies;
    GBin;
    GDuplex;
    GOffset;
    GPaperSize;
    GPaperDim;
    GPaperSizes;
    // QR4
    PrintQuality := DevMode^.dmPrintQuality;
    Collate := DevMode^.dmCollate;
    ColorOption := DevMode^.dmColor;
    GlobalUnlock(DeviceMode);
    // QR 5 save printer index
    FIndex := FPrinter.PrinterIndex; 
 end;
 except
    FPrinter := nil;
 end;
end;

procedure TPrinterSettings.ApplySettings;
var
    Cancel : boolean;
begin
  //FPrinter.GetPrinter(FDevice, FDriver, FPort, DeviceMode);
  //DevMode := GlobalLock(DeviceMode);
  begin
    SetField(dm_paperlength);
    DevMode^.dmPaperLength := PaperLength;
    SetField(dm_paperwidth);
    DevMode^.dmPaperWidth := PaperWidth;
  end;
  if Supported(dm_PaperSize) and (PaperSize <> Default) then
  begin
      SetField(dm_papersize);
      if not UseCustomPaperCode then
        DevMode^.dmPaperSize := cQRPaperTranslate[PaperSize]
      else
      begin
        DevMode^.dmPaperSize := FCustomPaperCode;
        // set papersize ??
      end;
  end;

  SetField(dm_copies);
  DevMode^.dmCopies := FCopies;

  if Supported(dm_Duplex) then
  begin
    SetField(dm_duplex);
    if ExtendedDuplex <> 0 then
           DevMode^.dmDuplex := ExtendedDuplex
    else
    begin
       if FDuplex then
             DevMode^.dmDuplex := dmdup_horizontal
       else
             DevMode^.dmDuplex := dmdup_simplex;
    end;
  end;

  SetField(dm_defaultsource);
  if  UseCustomBinCode then
     DevMode^.dmDefaultSource := FCustomBinCode
  else
     DevMode^.dmDefaultSource := cQRBinTranslate[OutputBin];
  
  SetField(dm_orientation);
  if Orientation=poPortrait then
    DevMode^.dmOrientation := dmorient_portrait
  else
    DevMode^.dmOrientation := dmorient_landscape;

  // QR4
   if Supported(dm_Collate) then
         DevMode^.dmCollate := Collate;
  
  if Supported(dm_PrintQuality) then
         DevMode^.dmPrintQuality := PrintQuality;
    if Supported(dm_Color) then
         DevMode^.dmColor := ColorOption; 

  // fire ParentReport event
  Cancel := false;
  if assigned(OnApplyPrinterSettings) then
    OnApplyPrintersettings(self, Cancel, devmode);
  if not Cancel then // user has Cancelled in event
     FPrinter.SetPrinter(FDevice, FDriver, FPort, DeviceMode);
end;

procedure TPrinterSettings.SetCopies(Value : integer);
begin
  if Supported(dm_copies) then
    FCopies := Value;
end;

procedure TPrinterSettings.SetOrientation(Value : TPrinterOrientation);
begin
  if Supported(dm_orientation) then
    FOrientation := Value;
end;
procedure TPrinterSettings.SetDuplex(Value : boolean);
begin
  if Supported(dm_duplex) then
    FDuplex := Value;
end;
procedure TPrinterSettings.SetOutputBin(Value : TQRBin);
begin
  if Supported(dm_defaultsource) then
    FOutputBin := Value;
end;

procedure TPrinterSettings.SetPaperSize(Value : TQRPaperSize);
begin
  if PaperSizeSupported[Value] then
    FPaperSize := Value
  else
    if (Value = Default) then
      FPaperSize := Default;
end;

procedure TPrinterSettings.SetPaperLength(Value : integer);
begin
    FPaperLength := Value;
end;

procedure TPrinterSettings.SetPaperWidth(Value : integer);
begin
    FPaperWidth := Value;
end;

procedure TPrinterSettings.SetPrinter(Value : TPrinter);
begin

  FPrinter := Value;
  if (Value <> nil) and (FPrinter.Printers.Count > 0) then
    GetPrinterSettings;
end;

procedure TPrinterSettings.SetTitle(Value : string);
begin
  FTitle := Value;
end;

{ TQRPrinterSettings }
constructor TQRPrinterSettings.Create;
begin
  PaperSize := Letter;
  Copies := 1;
  Duplex := false;
  Title := '';
  FFirstPage := 0;
  FLastPage := 0;
  FPrinterIndex := -1;
  FOutputBin := Auto;
  FmemoryLimit := 1000000;
end;

procedure TQRPrinterSettings.ApplySettings(APrinter : TQRPrinter);
begin
  if aPrinter.PrinterIndex <> PrinterIndex then
                aPrinter.PrinterIndex := PrinterIndex;
  aPrinter.PaperSize := PaperSize;
  aPrinter.Copies := Copies;
  aPrinter.Duplex := Duplex;
  aPrinter.Orientation := Orientation;
  aPrinter.OutputBin := OutputBin;
  aPrinter.Title := Title;
end;

{ TQRPrinter }
// called by change in printerindex.
procedure ResetDriver(aPrinter : TPrinter);
var
  Device, Name, Port: array[0..MAX_PATH] of Char;
  DevMode: THandle;
begin
  aPrinter.GetPrinter( Device, Name, Port , DevMode );
  aPrinter.SetPrinter( Device, Name, Port , 0 );    // %%%
end;

constructor TQRPrinter.Create(parentrep : TObject);
begin
  FPrinterOK := Printer.Printers.Count > 0;
  aPrinterSettings := TPrinterSettings.Create;
  if parentrep is TCustomQuickRep then
  begin
       FParentReport := parentrep;
       aPrinterSettings.UseStandardPrinter := TCustomQuickRep(parentrep).PrinterSettings.UseStandardPrinter;
       UseStandardPrinter := TCustomQuickRep(parentrep).PrinterSettings.UseStandardPrinter;
       aPrinterSettings.MemoryLimit := TCustomQuickRep(parentrep).PrinterSettings.MemoryLimit;
  end
  else if parentrep is TQRCompositeReport then
  begin
       FParentReport := parentrep;
       aPrinterSettings.UseStandardPrinter := TQRCompositeReport(parentrep).PrinterSettings.UseStandardPrinter;
       UseStandardPrinter := TQRCompositeReport(parentrep).PrinterSettings.UseStandardPrinter;
       aPrinterSettings.MemoryLimit := TQRCompositeReport(parentrep).PrinterSettings.MemoryLimit;
  end
  else
     aPrinterSettings.UseStandardPrinter := false;

  if UseStandardPrinter then
    aPrinter := printer
  else
  begin // XP printer bug in Tiburon Fix
    aPrinter := TPrinter.Create;   // %%%
    //aPrinter := printer; // not %%%
    aPrinter.PrinterIndex := self.PrinterIndex; // not %%%
  end;
    // if a network printer is created, it might take a second or two ...
   while (aPrinter = nil) do 
    Application.ProcessMessages;
  if PrinterOK then
  begin
    // this assignment calls GetPrinterSettings
    aPrinterSettings.Printer := aPrinter;
    Application.ProcessMessages;
    if Printer.PrinterIndex > aPrinter.Printers.Count then
      aPrinter.PrinterIndex := Printer.PrinterIndex;
  end;
  FTopWaste := aPrinterSettings.TopOffset;
  FLeftWaste := aPrinterSettings.LeftOffset;
  FDestination := qrdMetafile;
  FStatus := mpReady;
  FPageNumber := 0;
  PageList := TQRPageList.Create;
{$ifdef NEWQRP}
  Pagelist.FQRPrinter := self;
{$endif}
{  FOnProgressChangeEvent := nil;}
  FAvailablePages := 0;
  FXFactor := 0.37795;
  FYFactor := 0.37795;
  FClient := nil;
  FMaster := nil;
  FAfterPreviewEvent := nil;
  FAfterPrintEvent := nil;
  FCloseControl := nil;
  //FHyperlinks := nil;
  FShowingPreview := false;
  ReportLoaded := false;
end;

destructor TQRPrinter.Destroy;
begin
  if Status <> mpReady then
    Cleanup;
  if FCloseControl <> nil then
    FCloseControl.Free;
  if not UseStandardPrinter and PrinterOK then   // %%%
    aPrinter.Free;
  FreeAndNil(aPrinterSettings);
  PageList.Free;
  if FPage <> nil then
    FreeAndNil(FPage);
  if Client <> nil then
    if Client is TQRPreview then
      TQRPreview(Client).QRPrinter:= nil;
  inherited Destroy;
end;

procedure TQRPrinter.Cleanup;
begin
  if Status = mpBusy then
    Cancel;
  if assigned(aStream) then
  begin
    FreeAndNil(aStream);
    PageList.Stream := nil;
  end;
  PageList.Clear;
  FStatus := mpReady;
end;

procedure TQRPrinter.ClosePreview(Control : TWinControl);
begin
  ShowingPreview := false; // fixed 10/12/07
  if Master <> nil then
    SendMessage(Master.Handle, CM_QRPREVIEWCLOSE, 0, LPARAM(Self));
end;

function TQRPrinter.XPos(Value : extended) : integer;
begin
  result := round((Value - FLeftWaste) * XFactor);
end;

function TQRPrinter.XSize(Value : extended) : integer;
begin
  result := round(Value * XFactor);
end;

function TQRPrinter.YPos(Value : extended) : integer;
begin
  result := round((Value - FTopWaste) * YFactor);
end;

function TQRPrinter.YSize(Value : extended) : integer;
begin
  result := round(Value * YFactor);
end;

function TQRPrinter.GetCompression : boolean;
begin
  Result := PageList.Compression;
end;

procedure TQRPrinter.SetCompression(Value : boolean);
begin
  PageList.Compression := Value;
end;

{ TQRPrinter methods related to printer driver settings }

function TQRPrinter.GetBin : TQRBin;
begin
  Result := aPrinterSettings.OutputBin;
end;

function TQRPrinter.GetCopies;
begin
  Result := aPrinterSettings.Copies;
end;

function TQRPrinter.GetDuplex : boolean;
begin
  Result := aPrinterSettings.Duplex;
end;

function TQRPrinter.GetLeftWaste : integer;
{ Return left unprintable area in 0.1 mm }
begin
  if Destination=qrdPrinter then
    Result := aPrinterSettings.LeftOffset
  else
    Result := 0;
end;

function TQRPrinter.GetOrientation : TPrinterOrientation;
begin
  Result := aPrinterSettings.Orientation;
end;

function TQRPrinter.GetPaperLength : integer;
{ Return physical paper length in 0.1 mm }
begin
  Result := aPrinterSettings.PaperLength;
end;

function TQRPrinter.PaperLengthValue : integer;
begin
  if Orientation = poPortrait then
  begin
    if (PaperSize <> Custom) and (PaperSize <> Default) then
      result := round(cqrPaperSizeMetrics[PaperSize, 1] * 10)
    else
      result := PaperLength;
  end else
  begin
    if (PaperSize <> Custom) and (PaperSize <> Default) then
      result := round(cqrPaperSizeMetrics[PaperSize, 0] * 10)
    else
      result := PaperWidth;
  end;
end;

function TQRPrinter.PaperWidthValue : integer;
begin
  if Orientation = poPortrait then
  begin
    if (PaperSize <> Custom) and (PaperSize <> Default) then
      result := round(cqrPaperSizeMetrics[PaperSize, 0] * 10)
    else
      result := PaperWidth;
  end else
  begin
    if (PaperSize <> Custom) and (PaperSize <> Default) then
      result := round(cqrPaperSizeMetrics[PaperSize, 1] * 10)
    else
      result := PaperLength;
  end;
end;

function TQRPrinter.GetPaperWidth : integer;
{ Return physical paper width in 0.1 mm }
begin
  Result := aPrinterSettings.PaperWidth;
end;

function TQRPrinter.GetPaperSize : TQRPaperSize;
{ Return currently selected paper size }
begin
  Result := aPrinterSettings.PaperSize;
end;

function TQRPrinter.GetPrinterIndex : integer;
{ Return currently selected printer }
begin
  Result := aPrinter.PrinterIndex;
end;

function TQRPrinter.GetPrinters : TStrings;
{ Return list of printers }
begin
  Result := aPrinter.Printers;
end;

function TQRPrinter.GetTopWaste : integer;
{ Return unprintable area on top in 0.1 mm }
begin
  if Destination=qrdPrinter then
    Result := aPrinterSettings.TopOffset
  else
    Result := 0;
end;

procedure TQRPrinter.SetPrintMetafile(Value : boolean);
begin
  aPrinterSettings.PrintMetaFile := Value;
end;

procedure TQRPrinter.SetUseExtendedDuplex(Value : boolean);
begin
  aPrinterSettings.FUseExtendedDuplex := Value;
end;

procedure TQRPrinter.SetUseCustomBinCode(Value : boolean);
begin
  aPrinterSettings.UseCustomBinCode := Value;
end;

procedure TQRPrinter.SetUseCustomPaperCode(Value : boolean);
begin
  aPrinterSettings.UseCustomPaperCode := Value;
end;

function TQRPrinter.GetUseStandardPrinter : boolean;
begin
  Result := aPrinterSettings.UseStandardPrinter;
end;

function TQRPrinter.GetPrintMetaFile : boolean;
begin
  Result :=  aPrinterSettings.PrintMetaFile;
end;

function TQRPrinter.GetUseCustomBinCode : boolean;
begin
  Result :=  aPrinterSettings.UseCustomBinCode;
end;

function TQRPrinter.GetUseExtendedDuplex : boolean;
begin
  Result :=  aPrinterSettings.UseExtendedDuplex;
end;

function TQRPrinter.GetUseCustomPaperCode : boolean;
begin
  Result :=  aPrinterSettings.UseCustomPaperCode;
end;

procedure TQRPrinter.SetExtendedDuplex(Value : integer);
begin
  aPrinterSettings.ExtendedDuplex := Value;
end;

procedure TQRPrinter.SetCustomBinCode(Value : integer);
begin
  aPrinterSettings.CustomBinCode := Value;
end;

procedure TQRPrinter.SetCustomPaperCode(Value : integer);
begin
  aPrinterSettings.CustomPaperCode := Value;
end;

function TQRPrinter.GetCustomBinCode : integer;
begin
   Result := aPrinterSettings.CustomBinCode;
end;

function TQRPrinter.GetExtendedDuplex : integer;
begin
  Result := aPrinterSettings.ExtendedDuplex;
end;
// QR4
function TQRPrinter.GetPrinterHandle : THandle;
begin
  Result := aPrinter.Handle;
end;

function TQRPrinter.GetPrintQuality : integer;
begin
  Result := aPrinterSettings.PrintQuality;
end;

function TQRPrinter.GetCollate : integer;
begin
  Result := aPrinterSettings.Collate;
end;

function TQRPrinter.GetColorOption : integer;
begin
  Result := aPrinterSettings.ColorOption;
end;

function TQRPrinter.GetCustomPaperCode : integer;
begin
  Result := aPrinterSettings.CustomPaperCode;
end;

procedure TQRPrinter.SetBin(Value : TQRBin);
begin
  aPrinterSettings.Outputbin := Value;
end;

procedure TQRPrinter.SetCopies(Value : integer);
begin
  aPrinterSettings.Copies := Value;
end;

// QR4
procedure TQRPrinter.SetPrintQuality(Value : integer);
begin
  aPrinterSettings.PrintQuality := Value;
end;

procedure TQRPrinter.SetCollate(Value : integer);
begin
  aPrinterSettings.Collate := Value;
end;

procedure TQRPrinter.SetColorOption(Value : integer);
begin
  aPrinterSettings.ColorOption := Value;
end;


procedure TQRPrinter.SetDestination(Value : TQRPrinterDestination);
begin
  FDestination := Value;
end;

procedure TQRPrinter.SetDuplex(Value : Boolean);
begin
  aPrinterSettings.Duplex := Value;
end;

procedure TQRPrinter.SetOrientation(Value : TPrinterOrientation);
begin
  aPrinterSettings.Orientation := Value;
end;

procedure TQRPrinter.SetPaperWidth(Value : integer);
{ Sets the paper width in 0.01 mm }
begin
  aPrinterSettings.PaperWidth := Value;
end;

function TQRPrinter.GetPage(Value : integer) : TMetafile;
begin
  if (Status in [mpBusy, mpFinished]) and
     (Value > 0) and (Value <= FPageCount) then
    Result := PageList.GetPage(Value)
  else
    Result := nil;
end;

function TQRPrinter.GetOnApplyPrinterSettings: TQRPrinterSettingsEvent;
begin
  Result := aPrinterSettings.OnApplyPrinterSettings;
end;

function TQRPrinter.GetOnGetPrinterSettings: TQRPrinterSettingsEvent;
begin
  Result := aPrinterSettings.OnGetPrinterSettings;
end;

procedure TQRPrinter.SetOnApplyPrinterSettings(
  Value: TQRPrinterSettingsEvent);
begin
  aPrinterSettings.OnApplyPrinterSettings := Value;
end;

procedure TQRPrinter.SetOnGetPrinterSettings(
  Value: TQRPrinterSettingsEvent);
begin
  aPrinterSettings.OnGetPrinterSettings := Value;
end;

procedure TQRPrinter.SetUseStandardPrinter(Value: boolean);
begin
  aPrinterSettings.UseStandardPrinter := Value;
end;

procedure TQRPrinter.GetPageEx(Value : integer; var AMetafile : TMetafile;
                              var AHyperlinks : TList);
begin
  PageList.GetPageEx(Value, AMetafile, AHyperlinks);
end;

procedure TQRPrinter.SetPageNumber(Value : integer);
begin
  if (PageNumber > 0) and (PageNumber <= FPageCount) then
  begin
{$ifdef QR3}
    if FPage <> nil then
      FPage.Free;
    FPage := GetPage(Value);
{$endif}
    FPageNumber := Value;
  end;
end;

procedure TQRPrinter.SetPaperLength(Value : integer);
{ Sets the paper length in 0.1 mm }
begin
  aPrinterSettings.PaperLength := Value;
end;

procedure TQRPrinter.SetPaperSize(Value : TQRPaperSize);
begin
  aPrinterSettings.PaperSize := Value;
end;

procedure TQRPrinter.SetPrinterIndex(Value : integer);
begin
  aPrinter.Refresh;
  if PrinterOK and not UseStandardPrinter then
  begin
    aPrinter.PrinterIndex := Value;
    ResetDriver(aPrinter);
    aPrinterSettings.GetPrinterSettings;
  end;
end;

{ TQRPrinter methods related to printing }

function TQRPrinter.GetCanvas;
begin
  result := FCanvas;
end;

procedure TQRPrinter.CreateMetafileCanvas;
begin
  FMetafile := TMetafile.Create;
//{$define HIRES}
{$ifdef HIRES}
  // try a high res canvas
  XFactor := GetDeviceCaps(aPrinter.Handle, LogPixelsX) / 254;
  YFactor := GetDeviceCaps(aPrinter.Handle, LogPixelsY) / 254;
  FMetafile.Width := XSize(PaperWidthValue);
  FMetafile.Height := YSize(PaperLengthValue);
  FCanvas := TMetafileCanvas.Create(FMetafile, aprinter.Handle);
  FCanvas.Font.PixelsPerInch := GetDeviceCaps(aprinter.Handle, LOGPIXELSY);
  {$else}
   {
   FMetafile.Width := XSize(PaperWidthValue);// add
  FMetafile.Height := YSize(PaperLengthValue);// add
  FCanvas := TMetafileCanvas.Create(FMetafile, 0);// add
  FCanvas.Free;// add
  if FMetafile.Width > XSize(PaperWidthValue) then// add
    FMetafile.Inch := (96 * FMetafile.Width) div XSize(PaperWidthValue);// add
  // end fix
  }

  FMetafile.Width := XSize(PaperWidthValue);
  FMetafile.Height := YSize(PaperLengthValue);
  FCanvas := TMetafileCanvas.Create(FMetafile, 0);
  YFactor := Screen.PixelsPerInch / 254;
  XFactor := YFactor;
  FCanvas.Font.PixelsPerInch := GetDeviceCaps(GetDC(0), LOGPIXELSY);
  SetGraphicsMode( FCanvas.handle, GM_ADVANCED);   // disable this line
{$endif}
end;

{$ifdef LLIONPDF}
procedure TQRPrinter.CreatePDFCanvas;
begin
  if PDFDoc = nil then
  begin
    PDFDoc := TPDFDocument.Create( nil);
    PDFDoc.FileName := 'Test QR LLion.pdf';
    aPrinter.Title := Title;
    FCanvas := PDFDoc.Canvas;
  end else
  begin
    FCanvas := PDFDoc.Canvas;
    Canvas.Refresh;
  end;
  YFactor := Screen.PixelsPerInch / 254;
  XFactor := YFactor;
end;
{$endif}

function TQRPrinter.CurrentPageOK : boolean;
begin
  Result := true;
  if (FirstPage > 0) and (PageCount < FirstPage) then
    Result := false;
  if (LastPage > 0) and (PageCount > LastPage) then
    Result := false;
end;

procedure TQRPrinter.CreatePrinterCanvas;
begin
  if not aPrinter.Printing then
  begin
    aPrinter.Title := Title;
    aPrinter.BeginDoc;
    FCanvas := aPrinter.Canvas;
  end
  else
  begin
    StartPage(aPrinter.Handle);
    FCanvas := aPrinter.Canvas;
    Canvas.Refresh;
  end;
  XFactor := GetDeviceCaps(aPrinter.Handle, LogPixelsX) / 254;
  YFactor := GetDeviceCaps(aPrinter.Handle, LogPixelsY) / 254;
  if YFactor < 0.1 then YFactor := 1.0;
end;

procedure TQRPrinter.FreeHyperlinks;
begin
end;

procedure TQRPrinter.EndMetafileCanvas;
begin
  Canvas.Free;
end;

procedure TQRPrinter.EndPrinterCanvas;
begin
  if aPrinter.Printing and (PageCount <> LastPage) then
    aPrinter.NewPage;
end;

procedure TQRPrinter.NewPage;
begin
  if Status <> mpBusy then
    raise EQRError.Create(SqrIllegalNewPage);
  if PageNumber > 0 then
  begin
    case Destination of
      qrdMetafile: begin
                    EndMetafileCanvas;
                    PageList.AddPage(FMetafile);
                    FMetafile.Free;
                    FreeHyperlinks;
                  end;
      qrdPrinter: begin
                    if CurrentPageOK then
                      EndPrinterCanvas
                    else
                    begin
                      EndMetafileCanvas;
                      FMetaFile.Free;
                      FreeHyperlinks;
                    end;
                  end;
{$ifdef LLIONPDF}
     qrdPDFFile : PDFDoc.NewPage;
{$endif}
    end;
    AvailablePages := AvailablePages + 1;
  end;
  inc(FPageCount);
  inc(FPageNumber);
  case Destination of
    qrdMetafile : CreateMetafileCanvas;
    qrdPrinter : if CurrentPageOK then
                   CreatePrinterCanvas
                 else
                   CreateMetafileCanvas;
{$ifdef LLIONPDF}
    qrdPDFFile : CreatePDFCanvas;
{$endif}
  end;
end;

procedure TQRPrinter.Cancel;
begin
  Cancelled := true;
end;

procedure TQRPrinter.BeginDoc;
begin
  FMetafile := nil;
  FAvailablePages := 0;
  FMasterProgressStart := 0;
  FMasterProgressEnd := 0;
  FCancelled := false;
  if Destination = qrdPrinter then
    aPrinterSettings.ApplySettings;
  FTopWaste := TopWaste;
  FLeftWaste := LeftWaste;
  if Status <> mpReady then
    raise EQRError.Create(SqrQRPrinterNotReady)
  else
  begin
    FPageNumber := 0;
    FPageCount := 0;
    FStatus := mpBusy;
    case Destination of
      qrdMetafile : begin
                      aStream := TQRStream.Create(aPrintersettings.MemoryLimit);
                      PageList.Stream := aStream;
                      YFactor := Screen.PixelsPerInch / 254;
                      XFactor := YFactor;
                    end;
      qrdPrinter : begin
                      XFactor := GetDeviceCaps(aPrinter.Handle, LogPixelsX) / 254;
                      YFactor := GetDeviceCaps(aPrinter.Handle, LogPixelsY) / 254;
                      if YFactor < 0.1 then YFactor := 0.37795;
                      if XFactor < 0.1 then XFactor := 0.37795;
                   end;
{$ifdef LLIONPDF}
      qrdPDFFile : PDFDoc.BeginDoc;
{$endif}      
    end;
  end;
end;

procedure TQRPrinter.SetAvailablePages(Value : integer);
begin
  FAvailablePages := Value;
  if (Client <> nil) and Client.HandleAllocated then
    PostMessage(Client.Handle, CM_QRPAGEAVAILABLE, LPARAM(Value), 0);
end;

procedure TQRPrinter.SetProgress(Value : integer);
begin
  FProgress := Value;
  if (Client <> nil) and Client.HandleAllocated then
    PostMessage(Client.Handle, CM_QRPROGRESSUPDATE, LPARAM(Value), 0)
end;

procedure TQRPrinter.SetShowingPreview(Value : boolean);
begin
  if ShowingPreview and not Value then
  try
    if Status = mpBusy then Cancel;
    if assigned(FAfterPreviewEvent) then
      FAfterPreviewEvent(Self);
  finally
    FShowingPreview := Value;
  end else
    FShowingPreview := Value;
end;

// ERP 2

procedure TQRPrinter.EndDoc;
begin
  if FStatus = mpBusy then
  begin
    case Destination of
      qrdPrinter : if aPrinter.Printing then aPrinter.EndDoc;
      qrdMetafile : begin
                      if FPageCount > 0 then
                      begin
                        EndMetafileCanvas;
                        PageList.AddPage(FMetafile);
                        FMetafile.Free;
                        FreeHyperlinks;
                      end;
                    end;
{$ifdef LLIONPDF}
      qrdPDFFile : begin
                      PDFDoc.EndDoc;
                      if PDFDocIsOwned then
                         FreeAndNil(PDFDoc);
                   end;
{$endif}
    end;
    FStatus := mpFinished;
    AvailablePages := AvailablePages + 1;
    Application.ProcessMessages;
    if Destination = qrdMetafile then
      PageList.Finish
    else
      if assigned(FAfterPrintEvent) then
      try
        FAfterPrintEvent(Self);
      finally
      end;
  end;
end;

procedure TQRPrinter.AbortDoc;
begin
  case Destination of
    qrdPrinter : aPrinter.Abort;
    qrdMetafile : begin
                    if FMetafile <> nil then
                    begin
                      EndMetafileCanvas;
                      // ISAPI no need if we are exporting
                      if not TQuickrep(self.FParentReport).Exporting then
                            PageList.AddPage(FMetafile);
                      FMetafile.Free;
                      FreeHyperlinks;
                    end;
                  end;
  end;
  FStatus := mpFinished;
end;

procedure TQRPrinter.Load(Filename : string);
{$define GTPDF}
var
  I : TQRPaperSize;
  H, V: integer;
  {$ifndef GTPDF}
  sizefound : boolean;
  {$else}
  tmpi, dv, mindv : integer;
  {$endif}
  pm : TMetafile;
begin
  if Status <> mpReady then
    CleanUp;
  PageList.LoadFromFile(Filename);
  FPageCount := PageList.PageCount;
  FXFactor := Screen.PixelsPerInch / 254;
  FYFactor :=FXFactor;
//  v := 0;
//  h := 0;
  if FPageCount > 0 then
  begin
    pm := PageList.GetPage(1);
    with pm do
    try
      //h := pm.mmwidth div 100;
      //v := pm.mmHeight div 100;
      h := trunc(pm.width / FXFactor/10);
      v := trunc(pm.Height / FXFactor/10);
    finally
      free;
    end;
{$ifdef GTPDF}
    if v >= h then
        Orientation := poPortrait
    else
    begin
        Orientation := poLandscape;
        tmpi := v;
        v := h;
        h := tmpi;
    end;
    mindv := 32000;
    for I := Letter to ESheet do
    begin
      dv := abs(trunc(cQRPaperSizeMetrics[I][0])-h) + abs(trunc(cQRPaperSizeMetrics[I][1])-v);
      if dv < mindv then
      begin
        mindv := dv;
        papersize := I;
        //sizefound := true;
      end;
    end;
{$else}
    sizefound := false;
    for I := Letter to ESheet do
    begin
      if (round(int(cQRPaperSizeMetrics[I][0] / 4)) = h) and
         (round(int(cQRPaperSizeMetrics[I][1] / 4)) = v) then
      begin
        PaperSize := I;
        Orientation := poPortrait;
        sizefound := true;
        // add paperlength and width
      end;
      if (round(int(cQRPaperSizeMetrics[I][0] / 4)) = v) and
         (round(int(cQRPaperSizeMetrics[I][1] / 4)) = h) then
      begin
        PaperSize := I;
        Orientation := poLandscape;
        sizefound := true;
      end;
    end;
    if not sizefound then
    begin
      if v >= h then
        Orientation := poPortrait
     else
        Orientation := poLandscape;
    end;
{$endif}
  end;

  aStream := PageList.Stream;
  FStatus := mpFinished;
//  FOnGenerateToPrinterEvent := nil;
  FOnPrintSetupEvent := nil;
  FOnExportToFilterEvent := nil;
  ReportLoaded := true;
  PrintMetafileFromPreview := true;
end;

procedure TQRPrinter.LoadFromStream( inStream : TMemoryStream);
var
  I : TQRPaperSize;
  H, V : integer;
  sizefound : boolean;
begin
  if Status <> mpReady then
    CleanUp;
  PageList.LoadFromStream(instream);
  FPageCount := PageList.PageCount;
  FXFactor := Screen.PixelsPerInch / 254;
  FYFactor :=FXFactor;
  sizefound := false;
  if FPageCount > 0 then
  begin
    with PageList.GetPage(1) do
    try
      h := round(int(Width / XFactor / 40));
      v := round(int(Height / XFactor / 40));
    finally
      free;
    end;
    for I := Letter to ESheet do
    begin
      if (round(int(cQRPaperSizeMetrics[I][0] / 4)) = h) and
         (round(int(cQRPaperSizeMetrics[I][1] / 4)) = v) then
      begin
        PaperSize := I;
        Orientation := poPortrait;
        sizefound := true;
      end;
      if (round(int(cQRPaperSizeMetrics[I][0] / 4)) = v) and
         (round(int(cQRPaperSizeMetrics[I][1] / 4)) = h) then
      begin
        PaperSize := I;
        Orientation := poLandscape;
        sizefound := true;
      end;
    end;
    if not sizefound then
    begin
      if v >= h then
        Orientation := poPortrait
     else
        Orientation := poLandscape;
    end;
  end;
  aStream := PageList.Stream;
  FStatus := mpFinished;
//  FOnGenerateToPrinterEvent := nil;
  FOnPrintSetupEvent := nil;
  FOnExportToFilterEvent := nil;
  ReportLoaded := true;
  PrintMetafileFromPreview := true;
end;

procedure TQRPrinter.Save(Filename : string);
begin
  if Status = mpFinished then
    PageList.SaveToFile(Filename);
end;

procedure TQRPrinter.PrintMetafileDirect( filename : string; frompage, topage : integer);
var
     pagefile : TMetafile;
     i : integer;
     qrpr : TQRPrinter;
     pwidth, pheight, Lxfactor, Lyfactor : extended;
begin
      if status <> mpFinished then exit;
      printer.begindoc;
      LXFactor := GetDeviceCaps(Printer.Handle, LogPixelsX) / 254;
      LYFactor := GetDeviceCaps(Printer.Handle, LogPixelsY) / 254;
      if XFactor < 0.1 then XFactor := 0.37795;
      if YFactor < 0.1 then YFactor := 0.37795;
      if self.PaperSize = Custom then
      begin
        pwidth := self.PaperWidth*LXFactor; // width in pix
        pheight := self.PaperLength*LYFactor; // height in pix
      end
      else
      begin
        pheight := printer.PageHeight;
        pwidth := printer.PageWidth;
      end;
      qrpr := self;
      for i := frompage to topage do
      begin
          pagefile := qrpr.pagelist.GetPage(i);
          printer.Canvas.StretchDraw( rect( round(DPLeftMargin*LXFactor), round(DPTopmargin*LYFactor),
                                       round(pwidth), round(pheight)), pagefile );
          if i <> topage then printer.NewPage;
      end;
      printer.enddoc;
end;

procedure TQRPrinter.ExportMetafile( filename : string; frompage, topage : integer);
var
     pagefile : TMetafile;
     i : integer;
     pwidth, pheight, Lxfactor, Lyfactor : extended;
     PDFFilt : TQRPDFDocumentFilter;
     ImageCon : TQRImage;
begin
      if status <> mpFinished then exit;
      LXFactor := GetDeviceCaps(Printer.Handle, LogPixelsX) / 254;
      LYFactor := GetDeviceCaps(Printer.Handle, LogPixelsY) / 254;
      if YFactor < 0.1 then YFactor := 0.37795;
      if XFactor < 0.1 then XFactor := 0.37795;
      if self.PaperSize = Custom then
      begin
        pwidth := self.PaperWidth*LXFactor; // width in pix
        pheight := self.PaperLength*LYFactor; // height in pix
      end
      else
      begin
        pheight := printer.PageHeight;
        pwidth := printer.PageWidth;
      end;
      ImageCon := TQRImage.Create(nil);
      //imageCon.Width := trunc(pwidth);
      //imageCon.Height := trunc(pheight);
      PDFFilt := TQRPDFDocumentFilter.Create(filename );
      PDFFilt.Owner := TQuickrep( parentReport);
      PDFFilt.Start( trunc(pwidth), trunc(pheight), nil);
      for i := frompage to topage do
      begin
          pagefile := pagelist.GetPage(i);
          imageCon.Width := pagefile.Width;
          imageCon.Height := pagefile.Height;
          imageCon.Picture.Assign(pagefile);
          PDFFilt.AcceptGraphic(round(DPLeftMargin*LXFactor), round(DPTopmargin*LYFactor), imageCon);
          PDFFilt.NewPage;
      end;
      PDFFilt.Finish;
      PDFFilt.Free;
      imageCon.Free;
end;

procedure TQRPrinter.AddHyperlink(ARect : TRect; AHyperlink : string);
begin
end;

procedure TQRPrinter.AddOutline(Level : integer; Caption : string; Target : TRect);
begin
  if FStatus = mpBusy then
    PageList.AddOutline(Level, Caption, Target, PageNumber);
end;

procedure TQRPrinter.ExportToFilter(AFilter : TQRExportFilter);
begin
  if assigned(FOnExportToFilterEvent) then
    FOnExportToFilterEvent(AFilter);
end;

procedure TQRPrinter.Preview;
begin
  if assigned(FOnPreviewEvent) then
  try
    FOnPreviewEvent(Self)
  finally
  end
  else
    with GlobalPreviewInterface.Create(nil) do
    try
      PreviewControl := Show(Self)
    finally
      Free;
    end;
end;

procedure TQRPrinter.PreviewModal;
begin
  if assigned(FOnPreviewEvent) then
  try
    FOnPreviewEvent(Self)
  finally
  end
  else
    with GlobalPreviewInterface.Create(nil) do
    try
      ShowModal(Self)
    finally
      Free;
    end;
end;

procedure TQRPrinter.Print; 
var 
  I : integer; 
  APage : TMetafile; 
  FromPage, ToPage: integer; 
  AProgress : TQRProgressForm; 
  TmpRect : TRect;
  XFact, YFact : Double;
  HUnits: TQRUnit;                               
  tempRep : TQuickrep;
  showProgress : boolean;
begin 
  AProgress := nil;
{$ifdef EVAL} 
  if not DelphiRunning then 
    MessageDlg('Unregistered evaluation copy - Printing is only allowed while Delphi is running',mtWarning,[mbOK],0) 
  else 
{$endif} 
    if assigned(FMaster) and not ReportLoaded and (not PrintMetafile and (Status = mpFinished)) then 
      PostMessage(Master.Handle, CM_QRPRINT, 0, 0) 
    else 
      if (Status = mpFinished) and PrinterOK then 
      try
        AProgress := nil; // compiler warning off
        if self.FParentReport <> nil then
        begin
             temprep := TQuickrep( FParentReport );
             showProgress := temprep.ShowProgress;
        end
        else
            showProgress := false;

        APrinter.Title := Title;

        if APrinter.Printing then 
          APrinter.Abort; 
        Self.APrinterSettings.ApplySettings; 
        APrinter.BeginDoc; 
        FromPage := 1; 
        ToPage := PageCount; 

        if FirstPage <> 0 then 
          FromPage := FirstPage; 

        if LastPage <> 0 then 
          ToPage := LastPage; 
        // progress
        if showProgress then
        begin
           AProgress := TQRProgressForm.Create(nil);
           AProgress.QRPrinter := self;
           AProgress.Show;
           self.Client := AProgress;
        end;
        for I := FromPage to ToPage do 
        begin 
          Application.ProcessMessages; 
          // progress
          if showprogress then
              self.Progress := round( 100* ( i / (toPage-frompage + 1)));
          PageNumber := I; 
          APage := GetPage(I);
          try 
//            APrinter.Canvas.StretchDraw(Rect(0, 0, APrinter.PageWidth, APrinter.PageHeight), APage); {CMT}
            XFact := aPrinterSettings.PixelsPerX/254;
            YFact := aPrinterSettings.PixelsPerY/254;
            if FParentReport = nil  then
                 APrinter.Canvas.StretchDraw(Rect(0, 0, APrinter.PageWidth, APrinter.PageHeight), APage)
            else
            begin
              with TCustomQuickRep(parentreport).Page do begin
                HUnits := Units;
                Units := Native;
                TmpRect := rect(-Round(aPrinterSettings.LeftOffset*XFact),
                              -Round(aPrinterSettings.TopOffset*YFact),
                              Round((Width - aPrinterSettings.LeftOffset)*XFact),
                              Round((Length -aPrinterSettings.TopOffset)*YFact));
                Units := HUnits;
              end;
              APrinter.Canvas.StretchDraw(TmpRect,APage);
            end;
            //PlayEnhMetafile( APrinter.Canvas.handle, APage.Handle, TmpRect);
          finally
            FreeAndNil(APage); 
          end; 
          if I < ToPage then 
                APrinter.NewPage; 
          if Cancelled then 
            APrinter.Abort; 
        end;
        if showprogress then
                AProgress.Hide;
        if self.FParentReport <> nil then
        begin
             temprep := TQuickrep( FParentReport );
             if assigned(temprep.AfterPrint) then
                 temprep.AfterPrint( temprep);
        end;
      finally
        if APrinter.Printing then 
          APrinter.EndDoc; 
        if Assigned(AProgress) then
          FreeAndNil(AProgress)
      end; 
end; 

procedure TQRPrinter.PrintSetup;
begin
  if assigned(FOnPrintSetupEvent) then
    FOnPrintSetupEvent;
end;


function QRPrinter : TQRPRinter;
var
    parentRep : TQuickrep;
begin
  if FQRPrinter = nil then
  begin
      parentRep := TQuickrep.CreateNew( nil,1);
      FQRPrinter := TQRPrinter.Create(parentRep);
  end;
  Result := FQRPrinter;
end;

function QRHyperlinkSources : TList;
begin
  if FQRHyperlinkSources = nil then
    FQRHyperlinkSources := TList.Create;
  Result := FQRHyperlinkSources;
end;

procedure RegisterPreviewClass(APreviewInterface : TQRPreviewInterfaceClass);
begin
  GlobalPreviewInterface := APreviewInterface;
end;

procedure FreeHyperlinkSources;
var
  I : integer;
begin
  for I := 0 to QRHyperlinkSources.Count - 1 do
    Dispose(PQRHyperlinkSourceRecord(QRHyperlinkSources[I]));
  FQRHyperlinkSources.Free;
end;

initialization
  FQRPrinter := nil;
  FQRHyperlinkSources := nil;
  GlobalPreviewInterface := TQRStandardPreviewInterface;
  GlobalXMLPreviewInterface := TQRXMLStandardPreviewInterface;
  QRExportFilterLibrary := TQRExportFilterLibrary.Create;

finalization
  if FQRPrinter <> nil then
    FQRPrinter.Free;
  QRExportFilterLibrary.Free;
  if FQRHyperlinkSources <> nil then
    FreeHyperlinkSources;
end.
