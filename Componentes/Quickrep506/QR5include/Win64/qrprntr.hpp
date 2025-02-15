// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRPrntr.pas' rev: 30.00 (Windows)

#ifndef QrprntrHPP
#define QrprntrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.WinSpool.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Data.DB.hpp>
#include <qr5const.hpp>
#include <Vcl.Dialogs.hpp>
#include <QRAbout.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrprntr
{
//-- forward type declarations -----------------------------------------------
struct TExportInfoRec;
class DELPHICLASS EQRError;
struct TCM_QRPRogressUpdate;
struct TCM_QRPageAvailable;
struct TCM_QRPreviewClose;
class DELPHICLASS TQRExportFilterLibraryEntry;
class DELPHICLASS TQRTextEncoding;
class DELPHICLASS TQRExportFilterLibrary;
class DELPHICLASS TQRStream;
class DELPHICLASS TQRCompress;
class DELPHICLASS TQRPageList;
class DELPHICLASS TQRPreviewInterface;
class DELPHICLASS TQRStandardPreviewInterface;
class DELPHICLASS THyperlink;
class DELPHICLASS TQRPreviewImage;
class DELPHICLASS TQRPreview;
class DELPHICLASS TQRExportFilter;
class DELPHICLASS TPrinterSettings;
class DELPHICLASS TQRPrinterSettings;
class DELPHICLASS TQRPrinter;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TExportType : unsigned char { exptText, exptNumeric, exptFormula };

enum DECLSPEC_DENUM TXLNumFormat : unsigned char { nfGeneral, nfInteger, nfDec2, nfIntRound, nfCurrencyNS, nfCurrency, nfCurrency2, nfCurrencyDec, nfCurrencyDec2, nfPercent, nfPercentDec2, nfFraction, nfFraction2, nfDate1, nfDate2, nfDate3, nfDate4, nfTime1, nfTime2, nfTime3, nfTime4, nfDateTime };

struct DECLSPEC_DRECORD TExportInfoRec
{
public:
	System::Extended Xpos;
	System::Extended Ypos;
	Vcl::Graphics::TFont* Font;
	System::Uitypes::TColor BGColor;
	System::Classes::TAlignment Alignment;
	System::UnicodeString Text;
	int Column;
	TExportType ExportAs;
	System::UnicodeString ControlName;
	TXLNumFormat XLNumFormat;
};


enum DECLSPEC_DENUM TTextEncoding : unsigned char { AnsiEncoding, ASCIIEncoding, BigEndianUnicodeEncoding, DefaultEncoding, UnicodeEncoding, UTF7Encoding, UTF8Encoding };

enum DECLSPEC_DENUM TQRPaperSize : unsigned char { Default, Letter, LetterSmall, Tabloid, Ledger, Legal, Statement, Executive, A3, A4, A4Small, A5, B4, B5, Folio, Quarto, qr10X14, qr11X17, Note, Env9, Env10, Env11, Env12, Env14, CSheet, DSheet, ESheet, EnvDL, EnvC5, EnvC3, EnvC4, EnvC6, EnvC65, EnvB4, EnvB5, EnvB6, EnvItaly, EnvMonarch, EnvPersonal, FanfoldUSStd, FanfoldGerStd, FanfoldGerLegal, B4ISO, PostcardJap, qr9X11, qr10X11, qr15X11, EnvInvite, Reserved1, Reserved2, LetterExtra, LegalExtra, TabloidExtra, A4Extra, LetterTrans, A4Trans, LetterExtraTrans, SuperASuperAA4, SuperBSuperBA3, LetterPlus, A4Plus, A5Trans, B5Trans, A3Extra, A5Extra, B5Extra, A2, A3Trans, A3ExtraTrans, Custom };

enum DECLSPEC_DENUM TQRBin : unsigned char { First, Upper, Lower, Middle, Manual, Envelope, EnvManual, Auto, Tractor, SmallFormat, LargeFormat, LargeCapacity, Cassette, Last };

enum DECLSPEC_DENUM TQRBandType : unsigned char { rbTitle, rbPageHeader, rbDetail, rbPageFooter, rbSummary, rbGroupHeader, rbGroupFooter, rbSubDetail, rbColumnHeader, rbOverlay, rbWild, rbChild };

enum DECLSPEC_DENUM TPrevSaveType : unsigned char { stQRP, stPDF, stXL, stHTML, stRTF, stCSV, stASCII, stXML, stXLSX };

typedef System::StaticArray<System::UnicodeString, 9> Qrprntr__1;

class PASCALIMPLEMENTATION EQRError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EQRError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EQRError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EQRError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EQRError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EQRError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EQRError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EQRError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EQRError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EQRError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EQRError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EQRError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EQRError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EQRError(void) { }
	
};


typedef System::Word CodeType;

typedef System::Byte UpIndex;

typedef System::Word DownIndex;

typedef System::StaticArray<DownIndex, 256> TreeDownArray;

typedef System::StaticArray<UpIndex, 513> TreeUpArray;

struct DECLSPEC_DRECORD TCM_QRPRogressUpdate
{
public:
	unsigned Msg;
	NativeInt Position;
	NativeUInt QRPrinter;
};


struct DECLSPEC_DRECORD TCM_QRPageAvailable
{
public:
	unsigned Msg;
	NativeInt PageCount;
	NativeUInt QRPrinter;
};


struct DECLSPEC_DRECORD TCM_QRPreviewClose
{
public:
	unsigned Msg;
	NativeInt Dummy;
	NativeUInt QRPrinter;
};


typedef Winapi::Messages::TMessage TCM_QRPrint;

_DECLARE_METACLASS(System::TMetaClass, TQRExportFilterClass);

class PASCALIMPLEMENTATION TQRExportFilterLibraryEntry : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TQRExportFilterClass FExportFilterClass;
	System::UnicodeString FName;
	System::UnicodeString FExtension;
	
public:
	__property TQRExportFilterClass ExportFilterClass = {read=FExportFilterClass, write=FExportFilterClass};
	__property System::UnicodeString FilterName = {read=FName, write=FName};
	__property System::UnicodeString Extension = {read=FExtension, write=FExtension};
public:
	/* TObject.Create */ inline __fastcall TQRExportFilterLibraryEntry(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TQRExportFilterLibraryEntry(void) { }
	
};


class PASCALIMPLEMENTATION TQRTextEncoding : public System::Sysutils::TEncoding
{
	typedef System::Sysutils::TEncoding inherited;
	
public:
	virtual int __fastcall GetMaxByteCount(int CharCount);
	virtual int __fastcall GetMaxCharCount(int ByteCount);
	virtual System::TArray__1<System::Byte> __fastcall GetPreamble(void);
public:
	/* TObject.Create */ inline __fastcall TQRTextEncoding(void) : System::Sysutils::TEncoding() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TQRTextEncoding(void) { }
	
};


class PASCALIMPLEMENTATION TQRExportFilterLibrary : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FFilterList;
	
protected:
	System::UnicodeString __fastcall GetSaveDialogFilter(void);
	
public:
	__fastcall TQRExportFilterLibrary(void);
	__fastcall virtual ~TQRExportFilterLibrary(void);
	void __fastcall AddFilter(TQRExportFilterClass AFilter);
	void __fastcall RemoveFilter(TQRExportFilterClass AFilter);
	TQRExportFilterLibraryEntry* __fastcall GetFilterByExtension(System::UnicodeString fext);
	__property System::Classes::TList* Filters = {read=FFilterList};
	__property System::UnicodeString SaveDialogFilterString = {read=GetSaveDialogFilter};
};


class PASCALIMPLEMENTATION TQRStream : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	_RTL_CRITICAL_SECTION FLock;
	System::Classes::TMemoryStream* MemoryStream;
	System::UnicodeString FFilename;
	System::Classes::TFileStream* FileStream;
	bool FInMemory;
	int FMemoryLimit;
	
public:
	__fastcall TQRStream(int pMemoryLimit);
	__fastcall TQRStream(System::UnicodeString Filename)/* overload */;
	__fastcall virtual ~TQRStream(void);
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	void __fastcall LockStream(void);
	void __fastcall UnlockStream(void);
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	__property bool InMemory = {read=FInMemory, nodefault};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Write(const System::TArray__1<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::TArray__1<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	inline __int64 __fastcall  Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	inline __int64 __fastcall  Seek _DEPRECATED_ATTRIBUTE0 (const __int64 Offset, System::Word Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	inline int __fastcall  Read(System::TArray__1<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::TArray__1<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	
};


class PASCALIMPLEMENTATION TQRCompress : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Byte BitPos;
	bool CompressFlag;
	CodeType InByte;
	TreeDownArray Left;
	TreeDownArray Right;
	CodeType OutByte;
	System::Classes::TStream* Stream;
	TreeUpArray Up;
	System::Byte __fastcall GetByte(void);
	void __fastcall InitializeSplay(void);
	void __fastcall Splay(CodeType Plain);
	
public:
	__fastcall TQRCompress(System::Classes::TStream* aStream, bool CompressData);
	__fastcall virtual ~TQRCompress(void);
	void __fastcall Expand(System::Byte &Expanded);
	void __fastcall Compress(CodeType Plain);
};


class PASCALIMPLEMENTATION TQRPageList : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	_RTL_CRITICAL_SECTION FLock;
	TQRCompress* aCompressor;
	bool FCompression;
	int FPageCount;
	TQRStream* FStream;
	void __fastcall SeekToFirst(void);
	void __fastcall SeekToLast(void);
	void __fastcall SeekToPage(int PageNumber);
	void __fastcall ReadFileHeader(void);
	void __fastcall WriteFileHeader(void);
	
public:
	__fastcall TQRPageList(void);
	__fastcall virtual ~TQRPageList(void);
	Vcl::Graphics::TMetafile* __fastcall GetPage(int PageNumber);
	void __fastcall GetPageEx(int PageNumber, Vcl::Graphics::TMetafile* &AMetafile, System::Classes::TList* &AHyperlinks);
	void __fastcall AddPage(Vcl::Graphics::TMetafile* aMetafile);
	void __fastcall AddPageEx(Vcl::Graphics::TMetafile* aMetafile, System::Classes::TList* AHyperlinks);
	void __fastcall AddOutline(int Level, System::UnicodeString Caption, const System::Types::TRect &Target, int PageNumber);
	void __fastcall Clear(void);
	void __fastcall Finish(void);
	void __fastcall LoadFromFile(System::UnicodeString Filename);
	void __fastcall LoadFromStream(System::Classes::TMemoryStream* inStream);
	void __fastcall LockList(void);
	void __fastcall SaveToFile(System::UnicodeString Filename);
	void __fastcall SaveToStream(System::Classes::TMemoryStream* inStream);
	void __fastcall UnlockList(void);
	__property bool Compression = {read=FCompression, write=FCompression, nodefault};
	__property int PageCount = {read=FPageCount, nodefault};
	__property TQRStream* Stream = {read=FStream, write=FStream};
};


class PASCALIMPLEMENTATION TQRPreviewInterface : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	virtual Vcl::Controls::TWinControl* __fastcall Show(TQRPrinter* AQRPrinter);
	virtual Vcl::Controls::TWinControl* __fastcall ShowModal(TQRPrinter* AQRPrinter);
public:
	/* TComponent.Create */ inline __fastcall virtual TQRPreviewInterface(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TQRPreviewInterface(void) { }
	
};


_DECLARE_METACLASS(System::TMetaClass, TQRPreviewInterfaceClass);

class PASCALIMPLEMENTATION TQRStandardPreviewInterface : public TQRPreviewInterface
{
	typedef TQRPreviewInterface inherited;
	
public:
	virtual Vcl::Controls::TWinControl* __fastcall Show(TQRPrinter* AQRPrinter);
	virtual Vcl::Controls::TWinControl* __fastcall ShowModal(TQRPrinter* AQRPrinter);
public:
	/* TComponent.Create */ inline __fastcall virtual TQRStandardPreviewInterface(System::Classes::TComponent* AOwner) : TQRPreviewInterface(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TQRStandardPreviewInterface(void) { }
	
};


enum DECLSPEC_DENUM TQRZoomState : unsigned char { qrZoomToFit, qrZoomToWidth, qrZoomOther, qrZoom100 };

class PASCALIMPLEMENTATION THyperlink : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Types::TRect Area;
	System::UnicodeString Link;
	__fastcall THyperlink(const System::Types::TRect &AArea, System::UnicodeString ALink);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THyperlink(void) { }
	
};


enum DECLSPEC_DENUM TQRHyperlinkEventType : unsigned char { heCursorMoveOver, heCursorMoveAway, heGoto, heGotoNewWindow };

typedef void __fastcall (__closure *TQRPreviewHyperlinkEvent)(System::TObject* Sender, TQRHyperlinkEventType EventType, System::UnicodeString Link, bool &Handled);

class PASCALIMPLEMENTATION TQRPreviewImage : public Vcl::Controls::TGraphicControl
{
	typedef Vcl::Controls::TGraphicControl inherited;
	
private:
	System::Classes::TList* FHyperlinks;
	TQRPrinter* FQRPrinter;
	int FPageNumber;
	Vcl::Graphics::TMetafile* FMetafile;
	Vcl::Comctrls::TTreeNodes* FOutline;
	TQRPreviewHyperlinkEvent FOnHyperlink;
	int FZoom;
	bool FIsLink;
	System::UnicodeString FLastLink;
	System::UnicodeString __fastcall Hyperlink(int X, int Y);
	void __fastcall PaintPage(void);
	void __fastcall SetPageNumber(int Value);
	
protected:
	void __fastcall FreeHyperlinks(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetIsLink(bool Value);
	__property bool IsLink = {read=FIsLink, write=SetIsLink, nodefault};
	
public:
	__fastcall virtual TQRPreviewImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRPreviewImage(void);
	virtual void __fastcall Paint(void);
	bool __fastcall ImageOK(void);
	bool __fastcall HyperlinksOK(void);
	__property int PageNumber = {read=FPageNumber, write=SetPageNumber, nodefault};
	__property TQRPrinter* QRPrinter = {read=FQRPrinter, write=FQRPrinter};
	__property Vcl::Graphics::TMetafile* Metafile = {read=FMetafile};
	__property System::Classes::TList* Hyperlinks = {read=FHyperlinks};
	__property Vcl::Comctrls::TTreeNodes* Outline = {read=FOutline};
	__property int Zoom = {read=FZoom, write=FZoom, nodefault};
	__property TQRPreviewHyperlinkEvent OnHyperlink = {read=FOnHyperlink, write=FOnHyperlink};
};


typedef void __fastcall (__closure *TQRProgressUpdateEvent)(System::TObject* Sender, int Progress);

typedef void __fastcall (__closure *TQRPageAvailableEvent)(System::TObject* Sender, int PageNum);

class PASCALIMPLEMENTATION TQRPreview : public Vcl::Forms::TScrollBox
{
	typedef Vcl::Forms::TScrollBox inherited;
	
private:
	TQRPageAvailableEvent FOnPageAvailableEvent;
	TQRProgressUpdateEvent FOnProgressUpdateEvent;
	TQRPreviewImage* FPreviewImage;
	int FPageNumber;
	TQRPrinter* FQRPrinter;
	int FZoom;
	TQRZoomState FZoomState;
	Vcl::Comctrls::TTreeView* FOutlineControl;
	void __fastcall SetPageNumber(int Value);
	void __fastcall SetZoom(int value);
	void __fastcall Fixvalues(System::TObject* Sender);
	void __fastcall SetQRPrinter(TQRPrinter* Value);
	
protected:
	TQRPreviewHyperlinkEvent __fastcall GetOnHyperlink(void);
	void __fastcall SetOnHyperlink(TQRPreviewHyperlinkEvent Value);
	void __fastcall SetOutline(Vcl::Comctrls::TTreeView* Value);
	MESSAGE void __fastcall CMPageAvailable(TCM_QRPageAvailable &Message);
	MESSAGE void __fastcall CMProgressUpdate(TCM_QRPRogressUpdate &Message);
	
public:
	__fastcall virtual TQRPreview(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TQRPreview(void);
	void __fastcall UpdateImage(void);
	void __fastcall UpdateZoom(void);
	void __fastcall ZoomToWidth(void);
	void __fastcall ZoomToFit(void);
	__property TQRPreviewImage* PreviewImage = {read=FPreviewImage};
	__property TQRPrinter* QRPrinter = {read=FQRPrinter, write=SetQRPrinter};
	__property TQRZoomState ZoomState = {read=FZoomState, write=FZoomState, nodefault};
	
__published:
	__property TQRPageAvailableEvent OnPageAvailable = {read=FOnPageAvailableEvent, write=FOnPageAvailableEvent};
	__property TQRProgressUpdateEvent OnProgressUpdate = {read=FOnProgressUpdateEvent, write=FOnProgressUpdateEvent};
	__property TQRPreviewHyperlinkEvent OnHyperlink = {read=GetOnHyperlink, write=SetOnHyperlink};
	__property Vcl::Comctrls::TTreeView* Outline = {read=FOutlineControl, write=SetOutline};
	__property int PageNumber = {read=FPageNumber, write=SetPageNumber, nodefault};
	__property int Zoom = {read=FZoom, write=SetZoom, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TQRPreview(HWND ParentWindow) : Vcl::Forms::TScrollBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TQRExportFilter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TQRPrinter* FOriginalQRPrinter;
	bool FActive;
	System::UnicodeString FFilename;
	System::Classes::TComponent* FOwner;
	
protected:
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetVendorName(void);
	virtual bool __fastcall GetStreaming(void);
	
public:
	System::Classes::TStringList* finalDoc;
	__fastcall virtual TQRExportFilter(System::UnicodeString Filename);
	__fastcall virtual ~TQRExportFilter(void);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall AcceptGraphic(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	virtual void __fastcall AcceptTextControl(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	virtual void __fastcall AcceptBand(Vcl::Controls::TControl* aBand, System::Extended Xoff, System::Extended Yoff, System::Extended Expanded);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	virtual void __fastcall TextOutRec(const TExportInfoRec &ExportInfo);
	__property bool Active = {read=FActive, write=FActive, nodefault};
	__property System::UnicodeString Description = {read=GetDescription};
	__property System::UnicodeString FileExtension = {read=GetExtension};
	__property System::UnicodeString Filename = {read=FFilename};
	__property System::UnicodeString Name = {read=GetFilterName};
	__property System::Classes::TComponent* Owner = {read=FOwner, write=FOwner};
	__property bool Streaming = {read=GetStreaming, nodefault};
	__property System::UnicodeString Vendor = {read=GetVendorName};
	__property TQRPrinter* OriginalQRPrinter = {read=FOriginalQRPrinter, write=FOriginalQRPrinter};
};


typedef System::StaticArray<bool, 69> TPaperSizesSupported;

typedef void __fastcall (__closure *TQRPrinterSettingsEvent)(System::TObject* Sender, bool &Cancel, void * DevMode);

class PASCALIMPLEMENTATION TPrinterSettings : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FIndex;
	System::WideChar *FDevice;
	System::WideChar *FDriver;
	System::WideChar *FPort;
	NativeUInt DeviceMode;
	_devicemodeW *DevMode;
	_devicemodeW *PDevMode;
	int FCopies;
	bool FDuplex;
	bool FPrintMetafile;
	bool FUseStandardPrinter;
	TQRPrinterSettingsEvent FOnGetPrinterSettings;
	TQRPrinterSettingsEvent FOnApplyPrinterSettings;
	bool FUseExtendedDuplex;
	int FExtendedDuplex;
	bool FUseCustomBinCode;
	int FCustomBinCode;
	int FPrintQuality;
	int FCollate;
	int FColorOption;
	int FmemoryLimit;
	bool FUseCustomPaperCode;
	int FCustomPaperCode;
	int FMaxExtentX;
	int FMaxExtentY;
	int FMinExtentX;
	int FMinExtentY;
	System::Uitypes::TPrinterOrientation FOrientation;
	TQRBin FOutputBin;
	TQRPaperSize FPaperSize;
	TPaperSizesSupported FPaperSizes;
	int FPaperWidth;
	int FPaperLength;
	int FPixelsPerX;
	int FPixelsPerY;
	int FTopOffset;
	int FLeftOffset;
	Vcl::Printers::TPrinter* FPrinter;
	System::UnicodeString FTitle;
	int __fastcall GetCopies(void);
	System::UnicodeString __fastcall GetDriver(void);
	bool __fastcall GetDuplex(void);
	int __fastcall GetMaxExtentX(void);
	int __fastcall GetMaxExtentY(void);
	int __fastcall GetMinExtentX(void);
	int __fastcall GetMinExtentY(void);
	System::Uitypes::TPrinterOrientation __fastcall GetOrientation(void);
	TQRBin __fastcall GetOutputBin(void);
	TQRPaperSize __fastcall GetPaperSize(void);
	bool __fastcall GetPaperSizeSupported(TQRPaperSize PaperSize);
	int __fastcall GetPaperWidth(void);
	int __fastcall GetPaperLength(void);
	int __fastcall GetPixelsPerX(void);
	int __fastcall GetPixelsPerY(void);
	System::UnicodeString __fastcall GetPort(void);
	Vcl::Printers::TPrinter* __fastcall GetPrinter(void);
	System::UnicodeString __fastcall GetTitle(void);
	int __fastcall GetTopOffset(void);
	int __fastcall GetLeftOffset(void);
	bool __fastcall Supported(int Setting);
	void __fastcall SetField(int aField);
	void __fastcall GetPrinterSettings(void);
	void __fastcall SetCopies(int Value);
	void __fastcall SetDuplex(bool Value);
	void __fastcall SetOrientation(System::Uitypes::TPrinterOrientation Value);
	void __fastcall SetOutputBin(TQRBin Value);
	void __fastcall SetPaperSize(TQRPaperSize Value);
	void __fastcall SetPaperLength(int Value);
	void __fastcall SetPaperWidth(int Value);
	void __fastcall SetPrinter(Vcl::Printers::TPrinter* Value);
	void __fastcall SetTitle(System::UnicodeString Value);
	
public:
	__fastcall TPrinterSettings(void);
	__fastcall virtual ~TPrinterSettings(void);
	void __fastcall ApplySettings(void);
	__property System::UnicodeString Device = {read=GetDriver};
	__property System::UnicodeString Driver = {read=GetDriver};
	__property int LeftOffset = {read=GetLeftOffset, nodefault};
	__property int MaxExtentX = {read=GetMaxExtentX, nodefault};
	__property int MaxExtentY = {read=GetMaxExtentY, nodefault};
	__property int MinExtentX = {read=GetMinExtentX, nodefault};
	__property int MinExtentY = {read=GetMinExtentY, nodefault};
	__property bool PaperSizeSupported[TQRPaperSize PaperSize] = {read=GetPaperSizeSupported};
	__property int PixelsPerX = {read=GetPixelsPerX, nodefault};
	__property int PixelsPerY = {read=GetPixelsPerY, nodefault};
	__property System::UnicodeString Port = {read=GetPort};
	__property int TopOffset = {read=GetTopOffset, nodefault};
	__property TQRPrinterSettingsEvent OnGetPrinterSettings = {read=FOnGetPrinterSettings, write=FOnGetPrinterSettings};
	__property TQRPrinterSettingsEvent OnApplyPrinterSettings = {read=FOnApplyPrinterSettings, write=FOnApplyPrinterSettings};
	__property int Copies = {read=GetCopies, write=SetCopies, nodefault};
	__property bool Duplex = {read=GetDuplex, write=SetDuplex, nodefault};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=GetOrientation, write=SetOrientation, nodefault};
	__property bool PrintMetafile = {read=FPrintMetafile, write=FPrintMetafile, nodefault};
	__property bool UseStandardprinter = {read=FUseStandardPrinter, write=FUseStandardPrinter, nodefault};
	__property bool UseExtendedDuplex = {read=FUseExtendedDuplex, write=FUseExtendedDuplex, nodefault};
	__property bool UseCustomBinCode = {read=FUseCustomBinCode, write=FUseCustomBinCode, nodefault};
	__property bool UseCustomPaperCode = {read=FUseCustomPaperCode, write=FUseCustomPaperCode, nodefault};
	__property int CustomBinCode = {read=FCustomBinCode, write=FCustomBinCode, nodefault};
	__property int ExtendedDuplex = {read=FExtendedDuplex, write=FExtendedDuplex, nodefault};
	__property int CustomPaperCode = {read=FCustomPaperCode, write=FCustomPaperCode, nodefault};
	__property TQRBin OutputBin = {read=GetOutputBin, write=SetOutputBin, nodefault};
	__property int PaperLength = {read=GetPaperLength, write=SetPaperLength, nodefault};
	__property TQRPaperSize PaperSize = {read=GetPaperSize, write=SetPaperSize, nodefault};
	__property int PaperWidth = {read=GetPaperWidth, write=SetPaperWidth, nodefault};
	__property int MemoryLimit = {read=FmemoryLimit, write=FmemoryLimit, nodefault};
	__property int PrintQuality = {read=FPrintQuality, write=FPrintQuality, nodefault};
	__property int Collate = {read=FCollate, write=FCollate, nodefault};
	__property int ColorOption = {read=FColorOption, write=FColorOption, nodefault};
	__property Vcl::Printers::TPrinter* Printer = {read=GetPrinter, write=SetPrinter};
	__property System::UnicodeString Title = {read=GetTitle, write=SetTitle};
};


class PASCALIMPLEMENTATION TQRPrinterSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FCopies;
	bool FDuplex;
	System::Uitypes::TPrinterOrientation FOrientation;
	TQRBin FOutputBin;
	TQRPaperSize FPaperSize;
	int FPrinterIndex;
	System::UnicodeString FTitle;
	int FFirstPage;
	int FLastPage;
	bool FPrintMetafile;
	bool FUseStandardPrinter;
	bool FUseExtendedDuplex;
	int FExtendedDuplex;
	int FMemoryLimit;
	int FPrintQuality;
	int FCollate;
	int FColorOption;
	bool FUseCustomBinCode;
	int FCustomBinCode;
	bool FUseCustomPaperCode;
	int FCustomPaperCode;
	
public:
	__fastcall TQRPrinterSettings(void);
	void __fastcall ApplySettings(TQRPrinter* APrinter);
	__property int Copies = {read=FCopies, write=FCopies, nodefault};
	__property bool Duplex = {read=FDuplex, write=FDuplex, nodefault};
	__property int FirstPage = {read=FFirstPage, write=FFirstPage, nodefault};
	__property int LastPage = {read=FLastPage, write=FLastPage, nodefault};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=FOrientation, write=FOrientation, nodefault};
	__property TQRBin OutputBin = {read=FOutputBin, write=FOutputBin, nodefault};
	__property TQRPaperSize PaperSize = {read=FPaperSize, write=FPaperSize, nodefault};
	__property int PrinterIndex = {read=FPrinterIndex, write=FPrinterIndex, nodefault};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property bool PrintMetafile = {read=FPrintMetafile, write=FPrintMetafile, nodefault};
	__property bool UseStandardprinter = {read=FUseStandardPrinter, write=FUseStandardPrinter, nodefault};
	__property bool UseExtendedDuplex = {read=FUseExtendedDuplex, write=FUseExtendedDuplex, nodefault};
	__property bool UseCustomBinCode = {read=FUseCustomBinCode, write=FUseCustomBinCode, nodefault};
	__property bool UseCustomPaperCode = {read=FUseCustomPaperCode, write=FUseCustomPaperCode, nodefault};
	__property int CustomBinCode = {read=FCustomBinCode, write=FCustomBinCode, nodefault};
	__property int ExtendedDuplex = {read=FExtendedDuplex, write=FExtendedDuplex, nodefault};
	__property int CustomPaperCode = {read=FCustomPaperCode, write=FCustomPaperCode, nodefault};
	__property int MemoryLimit = {read=FMemoryLimit, write=FMemoryLimit, default=250000};
	__property int PrintQuality = {read=FPrintQuality, write=FPrintQuality, default=600};
	__property int Collate = {read=FCollate, write=FCollate, nodefault};
	__property int ColorOption = {read=FColorOption, write=FColorOption, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TQRPrinterSettings(void) { }
	
};


enum DECLSPEC_DENUM TQRPrinterDestination : unsigned char { qrdMetafile, qrdPrinter };

enum DECLSPEC_DENUM TQRPrinterStatus : unsigned char { mpReady, mpBusy, mpFinished };

typedef void __fastcall (__closure *TQRGenerateToPrinterEvent)(void);

typedef void __fastcall (__closure *TQRPrintSetupEvent)(void);

typedef void __fastcall (__closure *TQRExportToFilterEvent)(TQRExportFilter* aFilter);

typedef void __fastcall (__closure *TQRPreviewEvent)(void);

typedef void __fastcall (__closure *TQRAfterPrintEvent)(System::TObject* Sender);

typedef void __fastcall (__closure *TQRAfterPreviewEvent)(System::TObject* Sender);

class PASCALIMPLEMENTATION TQRPrinter : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Printers::TPrinter* aPrinter;
	System::TObject* FParentReport;
	TQRStream* aStream;
	TQRAfterPrintEvent FAfterPrintEvent;
	TQRAfterPreviewEvent FAfterPreviewEvent;
	int FAvailablePages;
	bool FCancelled;
	Vcl::Graphics::TCanvas* FCanvas;
	Vcl::Controls::TWinControl* FCloseControl;
	TQRPrinterDestination FDestination;
	int FFirstPage;
	int FLastpage;
	int FLeftWaste;
	Vcl::Controls::TWinControl* FClient;
	Vcl::Controls::TWinControl* FMaster;
	Vcl::Graphics::TMetafile* FMetafile;
	TQRExportToFilterEvent FOnExportToFilterEvent;
	System::Classes::TNotifyEvent FOnPreviewEvent;
	TQRPrintSetupEvent FOnPrintSetupEvent;
	Vcl::Graphics::TMetafile* FPage;
	int FPageCount;
	int FPageNumber;
	bool FPrinterOK;
	int FProgress;
	int FMasterProgressStart;
	int FMasterProgressEnd;
	System::UnicodeString FTitle;
	int FTopWaste;
	bool FShowingPreview;
	TQRPrinterStatus FStatus;
	System::Extended FXFactor;
	System::Extended FYFactor;
	TQRPageList* FPageList;
	Vcl::Controls::TWinControl* FPreviewControl;
	bool FReportLoaded;
	bool __fastcall CurrentPageOK(void);
	int __fastcall GetLeftWaste(void);
	TQRBin __fastcall GetBin(void);
	Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	bool __fastcall GetCompression(void);
	int __fastcall GetCopies(void);
	bool __fastcall GetDuplex(void);
	System::Uitypes::TPrinterOrientation __fastcall GetOrientation(void);
	int __fastcall GetPaperLength(void);
	TQRPaperSize __fastcall GetPaperSize(void);
	int __fastcall GetPaperWidth(void);
	int __fastcall GetPrinterIndex(void);
	System::Classes::TStrings* __fastcall GetPrinters(void);
	int __fastcall GetTopWaste(void);
	TQRPrinterSettingsEvent __fastcall GetOnGetPrinterSettings(void);
	TQRPrinterSettingsEvent __fastcall GetOnApplyPrinterSettings(void);
	bool __fastcall GetUseStandardPrinter(void);
	bool __fastcall GetPrintMetafile(void);
	bool __fastcall GetUseCustomBinCode(void);
	NativeUInt __fastcall GetPrinterHandle(void);
	int __fastcall GetPrintQuality(void);
	int __fastcall GetCollate(void);
	int __fastcall GetColorOption(void);
	void __fastcall SetPrintQuality(int value);
	void __fastcall SetCollate(int value);
	void __fastcall SetColorOption(int value);
	bool __fastcall GetUseExtendedDuplex(void);
	bool __fastcall GetUseCustomPaperCode(void);
	int __fastcall GetCustomBinCode(void);
	int __fastcall GetExtendedDuplex(void);
	int __fastcall GetCustomPaperCode(void);
	void __fastcall SetOnGetPrinterSettings(TQRPrinterSettingsEvent Value);
	void __fastcall SetOnApplyPrinterSettings(TQRPrinterSettingsEvent Value);
	void __fastcall SetUseStandardPrinter(bool Value);
	void __fastcall CreateMetafileCanvas(void);
	void __fastcall CreatePrinterCanvas(void);
	void __fastcall EndMetafileCanvas(void);
	void __fastcall EndPrinterCanvas(void);
	void __fastcall SetUseExtendedDuplex(bool value);
	void __fastcall SetUseCustomBinCode(bool value);
	void __fastcall SetUseCustomPaperCode(bool value);
	void __fastcall SetExtendedDuplex(int value);
	void __fastcall SetCustomBinCode(int value);
	void __fastcall SetCustomPaperCode(int value);
	void __fastcall SetAvailablePages(int Value);
	void __fastcall SetBin(TQRBin Value);
	void __fastcall SetCompression(bool Value);
	void __fastcall SetCopies(int Value);
	void __fastcall SetDestination(TQRPrinterDestination Value);
	void __fastcall SetDuplex(bool Value);
	void __fastcall SetOrientation(System::Uitypes::TPrinterOrientation Value);
	void __fastcall SetPaperLength(int Value);
	void __fastcall SetPageNumber(int Value);
	void __fastcall SetPaperSize(TQRPaperSize Value);
	void __fastcall SetPaperWidth(int Value);
	void __fastcall SetPrinterIndex(int Value);
	void __fastcall SetProgress(int Value);
	void __fastcall SetShowingPreview(bool Value);
	void __fastcall SetPrintMetafile(bool Value);
	
public:
	TPrinterSettings* aPrinterSettings;
	System::Extended DPLeftMargin;
	System::Extended DPTopmargin;
	void __fastcall PrintMetafileDirect(System::UnicodeString filename, int frompage, int topage);
	void __fastcall ExportMetafile(System::UnicodeString filename, int frompage, int topage);
	__fastcall TQRPrinter(System::TObject* parentrep);
	__fastcall virtual ~TQRPrinter(void);
	Vcl::Graphics::TMetafile* __fastcall GetPage(int Value);
	void __fastcall GetPageEx(int Value, Vcl::Graphics::TMetafile* &AMetafile, System::Classes::TList* &AHyperlinks);
	int __fastcall XPos(System::Extended Value);
	int __fastcall XSize(System::Extended Value);
	int __fastcall YPos(System::Extended Value);
	int __fastcall YSize(System::Extended Value);
	int __fastcall PaperLengthValue(void);
	int __fastcall PaperWidthValue(void);
	void __fastcall AbortDoc(void);
	void __fastcall BeginDoc(void);
	void __fastcall Cancel(void);
	void __fastcall Cleanup(void);
	void __fastcall ClosePreview(Vcl::Controls::TWinControl* Control);
	void __fastcall EndDoc(void);
	void __fastcall ExportToFilter(TQRExportFilter* aFilter);
	void __fastcall FreeHyperlinks(void);
	void __fastcall AddHyperlink(const System::Types::TRect &ARect, System::UnicodeString AHyperlink);
	void __fastcall AddOutline(int Level, System::UnicodeString Caption, const System::Types::TRect &Target);
	void __fastcall Load(System::UnicodeString Filename);
	void __fastcall LoadFromStream(System::Classes::TMemoryStream* inStream);
	void __fastcall NewPage(void);
	void __fastcall Preview(void);
	void __fastcall PreviewModal(void);
	void __fastcall Print(void);
	void __fastcall PrintSetup(void);
	void __fastcall Save(System::UnicodeString Filename);
	__property System::TObject* ParentReport = {read=FParentReport, write=FParentReport};
	__property bool ReportLoaded = {read=FReportLoaded, write=FReportLoaded, nodefault};
	__property TQRAfterPreviewEvent AfterPreview = {read=FAfterPreviewEvent, write=FAfterPreviewEvent};
	__property TQRAfterPrintEvent AfterPrint = {read=FAfterPrintEvent, write=FAfterPrintEvent};
	__property int AvailablePages = {read=FAvailablePages, write=SetAvailablePages, nodefault};
	__property TQRBin OutputBin = {read=GetBin, write=SetBin, nodefault};
	__property Vcl::Controls::TWinControl* PreviewControl = {read=FPreviewControl, write=FPreviewControl};
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property Vcl::Graphics::TCanvas* Canvas = {read=GetCanvas};
	__property Vcl::Controls::TWinControl* Client = {read=FClient, write=FClient};
	__property bool Compression = {read=GetCompression, write=SetCompression, nodefault};
	__property int Copies = {read=GetCopies, write=SetCopies, nodefault};
	__property TQRPrinterDestination Destination = {read=FDestination, write=SetDestination, nodefault};
	__property bool Duplex = {read=GetDuplex, write=SetDuplex, nodefault};
	__property int FirstPage = {read=FFirstPage, write=FFirstPage, nodefault};
	__property int LastPage = {read=FLastpage, write=FLastpage, nodefault};
	__property int LeftWaste = {read=GetLeftWaste, nodefault};
	__property Vcl::Controls::TWinControl* Master = {read=FMaster, write=FMaster};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=GetOrientation, write=SetOrientation, nodefault};
	__property TQRExportToFilterEvent OnExportToFilter = {read=FOnExportToFilterEvent, write=FOnExportToFilterEvent};
	__property System::Classes::TNotifyEvent OnPreview = {read=FOnPreviewEvent, write=FOnPreviewEvent};
	__property TQRPrintSetupEvent OnPrintSetup = {read=FOnPrintSetupEvent, write=FOnPrintSetupEvent};
	__property TQRPrinterSettingsEvent OnGetPrinterSettings = {read=GetOnGetPrinterSettings, write=SetOnGetPrinterSettings};
	__property TQRPrinterSettingsEvent OnApplyPrinterSettings = {read=GetOnApplyPrinterSettings, write=SetOnApplyPrinterSettings};
	__property TQRPageList* PageList = {read=FPageList, write=FPageList};
	__property int PaperLength = {read=GetPaperLength, write=SetPaperLength, nodefault};
	__property bool UseStandardPrinter = {read=GetUseStandardPrinter, write=SetUseStandardPrinter, nodefault};
	__property bool UseExtendedDuplex = {read=GetUseExtendedDuplex, write=SetUseExtendedDuplex, nodefault};
	__property bool UseCustomBinCode = {read=GetUseCustomBinCode, write=SetUseCustomBinCode, nodefault};
	__property bool UseCustomPaperCode = {read=GetUseCustomPaperCode, write=SetUseCustomPaperCode, nodefault};
	__property int CustomBinCode = {read=GetCustomBinCode, write=SetCustomBinCode, nodefault};
	__property int ExtendedDuplex = {read=GetExtendedDuplex, write=SetExtendedDuplex, nodefault};
	__property int CustomPaperCode = {read=GetCustomPaperCode, write=SetCustomPaperCode, nodefault};
	__property Vcl::Graphics::TMetafile* Page = {read=FPage};
	__property int PageCount = {read=FPageCount, write=FPageCount, nodefault};
	__property int PageNumber = {read=FPageNumber, write=SetPageNumber, nodefault};
	__property int PaperWidth = {read=GetPaperWidth, write=SetPaperWidth, nodefault};
	__property TQRPaperSize PaperSize = {read=GetPaperSize, write=SetPaperSize, nodefault};
	__property int PrinterIndex = {read=GetPrinterIndex, write=SetPrinterIndex, nodefault};
	__property bool PrintMetafile = {read=GetPrintMetafile, write=SetPrintMetafile, nodefault};
	__property bool PrinterOK = {read=FPrinterOK, nodefault};
	__property System::Classes::TStrings* Printers = {read=GetPrinters};
	__property int Progress = {read=FProgress, write=SetProgress, nodefault};
	__property int MasterProgressStart = {read=FMasterProgressStart, write=FMasterProgressStart, nodefault};
	__property int MasterProgressEnd = {read=FMasterProgressEnd, write=FMasterProgressEnd, nodefault};
	__property bool ShowingPreview = {read=FShowingPreview, write=SetShowingPreview, nodefault};
	__property TQRPrinterStatus Status = {read=FStatus, nodefault};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property int TopWaste = {read=GetTopWaste, nodefault};
	__property System::Extended XFactor = {read=FXFactor, write=FXFactor};
	__property System::Extended YFactor = {read=FYFactor, write=FYFactor};
	__property int PrintQuality = {read=GetPrintQuality, write=SetPrintQuality, nodefault};
	__property NativeUInt PrinterHandle = {read=GetPrinterHandle};
	__property int Collate = {read=GetCollate, write=SetCollate, nodefault};
	__property int ColorOption = {read=GetColorOption, write=SetColorOption, nodefault};
};


typedef void __fastcall (__closure *TQRHyperlinkSourceMethod)(System::TObject* Sender, System::UnicodeString Parameters);

//-- var, const, procedure ---------------------------------------------------
#define cQRName L"QuickReport 5.06.0"
static const System::Int8 cQRVersion = System::Int8(0x32);
#define cQRPDefaultExt L"QRP"
#define cQRDefaultExt L"QR"
extern DELPHI_PACKAGE System::StaticArray<System::StaticArray<System::Extended, 2>, 68> cQRPaperSizeMetrics;
extern DELPHI_PACKAGE System::StaticArray<int, 70> cQRPaperTranslate;
extern DELPHI_PACKAGE System::StaticArray<int, 14> cQRBinTranslate;
extern DELPHI_PACKAGE Qrprntr__1 QRSaveExtensions;
static const System::Int8 cQRPageShadowWidth = System::Int8(0x2);
static const System::Int8 cQRPageFrameWidth = System::Int8(0x1);
static const int cQRPageShadowColor = int(0);
static const System::Int8 cQRCornerSize = System::Int8(0x3);
static const System::Word MaxChar = System::Word(0x100);
static const System::Word EofChar = System::Word(0x100);
static const System::Byte PredMax = System::Byte(0xff);
static const System::Word TwiceMax = System::Word(0x200);
static const System::Int8 ROOT = System::Int8(0x0);
extern DELPHI_PACKAGE System::StaticArray<System::Byte, 8> BitMask;
static const System::Word CM_QRPROGRESSUPDATE = System::Word(0x400);
static const System::Word CM_QRPAGEAVAILABLE = System::Word(0x401);
static const System::Word CM_QRPRINT = System::Word(0x402);
static const System::Word CM_QRPRINTSETUP = System::Word(0x403);
static const System::Word CM_QRPREVIEWCLOSE = System::Word(0x404);
extern DELPHI_PACKAGE TQRExportFilterLibrary* QRExportFilterLibrary;
extern DELPHI_PACKAGE int CompositePrinterIndex;
extern DELPHI_PACKAGE TQRPaperSize __fastcall DefaultPrinterPaperSize(void);
extern DELPHI_PACKAGE void __fastcall RegisterHyperlinkSource(System::UnicodeString ASignature, TQRHyperlinkSourceMethod SourceMethod);
extern DELPHI_PACKAGE void __fastcall UnregisterHyperlinkSource(System::UnicodeString ASignature);
extern DELPHI_PACKAGE void __fastcall PerformHyperlink(System::TObject* Sender, System::UnicodeString Link);
extern DELPHI_PACKAGE int __fastcall AnsiPos(System::UnicodeString Substr, System::UnicodeString S);
extern DELPHI_PACKAGE System::UnicodeString __fastcall QRPaperName(TQRPaperSize Size);
extern DELPHI_PACKAGE System::UnicodeString __fastcall TempFilename(void);
extern DELPHI_PACKAGE System::Classes::TStrings* __fastcall GetFonts(void);
extern DELPHI_PACKAGE void __fastcall PaintPageToCanvas(Vcl::Graphics::TMetafile* APage, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool PaintFrameAnyway);
extern DELPHI_PACKAGE TQRPrinter* __fastcall QRPrinter(void);
extern DELPHI_PACKAGE System::Classes::TList* __fastcall QRHyperlinkSources(void);
extern DELPHI_PACKAGE void __fastcall RegisterPreviewClass(TQRPreviewInterfaceClass APreviewInterface);
}	/* namespace Qrprntr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRPRNTR)
using namespace Qrprntr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrprntrHPP
