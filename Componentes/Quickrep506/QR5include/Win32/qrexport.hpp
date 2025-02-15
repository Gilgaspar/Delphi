// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRExport.pas' rev: 30.00 (Windows)

#ifndef QrexportHPP
#define QrexportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <Data.DB.hpp>
#include <Vcl.StdCtrls.hpp>
#include <QRCtrls.hpp>
#include <qr5const.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Forms.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrexport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTextEntry;
class DELPHICLASS TlineObj;
class DELPHICLASS TQRAbstractExportFilter;
class DELPHICLASS TQRCommaSeparatedFilter;
class DELPHICLASS TQRCSVFilter;
class DELPHICLASS TQRXLSFilter;
class DELPHICLASS TQRExcelFilter;
class DELPHICLASS TQRRTFItem;
class DELPHICLASS TQRRTFLineItem;
class DELPHICLASS TQRRTFExportFilter;
class DELPHICLASS TQRRTFFilter;
class DELPHICLASS TQRWMFExportFilter;
class DELPHICLASS TQRWMFFilter;
class DELPHICLASS TQRAsciiExportFilter;
class DELPHICLASS TQRTextFilter;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTextEntry : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FText;
	System::Extended XPos;
	System::Extended YPos;
	System::Classes::TAlignment FAlignment;
	Vcl::Graphics::TFont* TextFont;
	int Column;
	Qrprntr::TExportType ExportAs;
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTextEntry(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TTextEntry(void) : System::Classes::TPersistent() { }
	
};


class PASCALIMPLEMENTATION TlineObj : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* Entries;
	System::Extended YPos;
	
public:
	__fastcall TlineObj(void);
	__fastcall virtual ~TlineObj(void);
};


class PASCALIMPLEMENTATION TQRAbstractExportFilter : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
private:
	System::Classes::TList* Entries;
	System::Classes::TStream* FStream;
	System::Extended FCharWidth;
	System::Extended FCharHeight;
	System::Extended FPaperWidth;
	System::Extended FPaperHeight;
	int FLineCount;
	int FColCount;
	int FLastSheetrow;
	bool FPageProcessed;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FActiveFont;
	
protected:
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	int __fastcall GetLinecount(void);
	void __fastcall SetLinecount(int value);
	System::UnicodeString __fastcall GetText(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* &Font);
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	void __fastcall WriteToStream(const System::UnicodeString AText);
	void __fastcall WriteLnToStream(const System::UnicodeString AText);
	virtual void __fastcall CreateStream(System::UnicodeString Filename);
	virtual void __fastcall CloseStream(void);
	void __fastcall ClearEntries(void);
	virtual void __fastcall ProcessPage(void);
	void __fastcall ConvertToColumns(void);
	void __fastcall ConvertToLines(void);
	virtual void __fastcall StorePage(void);
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
	__property bool PageProcessed = {read=FPageProcessed, write=FPageProcessed, nodefault};
	__property System::Extended CharWidth = {read=FCharWidth, write=FCharWidth};
	__property System::Extended CharHeight = {read=FCharHeight, write=FCharHeight};
	__property System::Extended PaperWidth = {read=FPaperWidth, write=FPaperWidth};
	__property System::Extended PaperHeight = {read=FPaperHeight, write=FPaperHeight};
	__property int LineCount = {read=GetLinecount, write=SetLinecount, nodefault};
	__property int ColCount = {read=FColCount, write=FColCount, nodefault};
	
public:
	System::Extended PositionLatitude;
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall AcceptGraphic(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	virtual void __fastcall TextOutRec(const Qrprntr::TExportInfoRec &ExportInfo);
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TQRAbstractExportFilter(System::UnicodeString Filename) : Qrprntr::TQRExportFilter(Filename) { }
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRAbstractExportFilter(void) { }
	
};


class PASCALIMPLEMENTATION TQRCommaSeparatedFilter : public TQRAbstractExportFilter
{
	typedef TQRAbstractExportFilter inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	
public:
	virtual void __fastcall StorePage(void);
	virtual void __fastcall Finish(void);
	__property TextEncoding;
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TQRCommaSeparatedFilter(System::UnicodeString Filename) : TQRAbstractExportFilter(Filename) { }
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRCommaSeparatedFilter(void) { }
	
};


class PASCALIMPLEMENTATION TQRCSVFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	System::WideChar __fastcall GetSeparator(void);
	void __fastcall SetSeparator(System::WideChar Value);
	
private:
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
public:
	__fastcall virtual TQRCSVFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRCSVFilter(void);
	
__published:
	__property System::WideChar Separator = {read=GetSeparator, write=SetSeparator, nodefault};
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
};


enum DECLSPEC_DENUM TCellType : unsigned char { CellBlank, CellInteger, CellDouble, CellLabel, CellBoolean };

class PASCALIMPLEMENTATION TQRXLSFilter : public TQRAbstractExportFilter
{
	typedef TQRAbstractExportFilter inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual bool __fastcall GetStreaming(void);
	virtual void __fastcall CreateStream(System::UnicodeString Filename);
	virtual void __fastcall CloseStream(void);
	void __fastcall WriteRecordHeader(int RecType, int Size);
	virtual void __fastcall WriteData(TCellType CellType, int ARow, int ACol, System::UnicodeString Cell);
	void __fastcall setUseXLCols(bool value);
	bool __fastcall getUseXLCols(void);
	
private:
	int FReportNum;
	System::Classes::TStringList* LinesCollection;
	
public:
	bool Concatenating;
	__fastcall virtual TQRXLSFilter(System::UnicodeString filename);
	__fastcall virtual ~TQRXLSFilter(void);
	virtual void __fastcall StorePage(void);
	void __fastcall EndConcat(void);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	virtual void __fastcall Finish(void);
	__property TextEncoding;
	__property bool UseXLColumns = {read=getUseXLCols, write=setUseXLCols, nodefault};
};


class PASCALIMPLEMENTATION TQRExcelFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	void __fastcall setUseXLCols(bool value);
	bool __fastcall getUseXLCols(void);
	
public:
	__fastcall virtual TQRExcelFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRExcelFilter(void);
	
__published:
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
	__property bool UseXLColumns = {read=getUseXLCols, write=setUseXLCols, nodefault};
};


typedef System::StaticArray<System::UnicodeString, 8> Qrexport__8;

class PASCALIMPLEMENTATION TQRRTFItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Uitypes::TColor FontColor;
	System::Uitypes::TFontStyles FontStyle;
	int FontSize;
	int RTFFont;
	System::Extended x;
	System::Extended y;
	System::Classes::TAlignment Alignment;
	System::UnicodeString Text;
public:
	/* TObject.Create */ inline __fastcall TQRRTFItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TQRRTFItem(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRRTFLineItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Classes::TList* RTFItems;
	__fastcall TQRRTFLineItem(void);
	__fastcall virtual ~TQRRTFLineItem(void);
	void __fastcall ClearLineItems(void);
	void __fastcall Add(TQRRTFItem* value);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRRTFExportFilter : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
private:
	int LineCount;
	System::Classes::TList* RTFLines;
	System::TextFile aFile;
	System::Extended XFactor;
	System::Extended YFactor;
	System::UnicodeString Header;
	System::UnicodeString FontTable;
	System::UnicodeString ColorTable;
	System::UnicodeString DefaultLanguage;
	System::UnicodeString NewPar;
	System::UnicodeString ResetPar;
	bool PendingPageBreak;
	bool Started;
	bool Concatenating;
	System::Extended aTop;
	System::Extended aBottom;
	System::Extended aLeft;
	System::Extended aRight;
	System::Extended aLength;
	System::Extended aWidth;
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	void __fastcall CreateRTFLines(void);
	void __fastcall DestroyRTFLines(void);
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
public:
	void __fastcall StartConcat(void);
	void __fastcall EndConcat(void);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TQRRTFExportFilter(System::UnicodeString Filename) : Qrprntr::TQRExportFilter(Filename) { }
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRRTFExportFilter(void) { }
	
};


class PASCALIMPLEMENTATION TQRRTFFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
public:
	__fastcall virtual TQRRTFFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRRTFFilter(void);
	
__published:
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRWMFExportFilter : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
private:
	System::UnicodeString aBase;
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
public:
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TQRWMFExportFilter(System::UnicodeString Filename) : Qrprntr::TQRExportFilter(Filename) { }
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRWMFExportFilter(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRWMFFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	bool __fastcall GetEnhanced(void);
	void __fastcall SetEnhanced(bool Value);
	
public:
	__fastcall virtual TQRWMFFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRWMFFilter(void);
	
__published:
	__property bool Enhanced = {read=GetEnhanced, write=SetEnhanced, nodefault};
};


class PASCALIMPLEMENTATION TQRAsciiExportFilter : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
	
private:
	typedef System::StaticArray<System::UnicodeString, 201> _TQRAsciiExportFilter__1;
	
	
private:
	_TQRAsciiExportFilter__1 Lines;
	int LineCount;
	System::Extended XFactor;
	System::Extended YFactor;
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
public:
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TQRAsciiExportFilter(System::UnicodeString Filename) : Qrprntr::TQRExportFilter(Filename) { }
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRAsciiExportFilter(void) { }
	
};


class PASCALIMPLEMENTATION TQRTextFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	
public:
	__fastcall virtual TQRTextFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRTextFilter(void);
	
__published:
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TColor, 18> QRRTFColors;
extern DELPHI_PACKAGE Qrexport__8 QRRTFFontFamily;
}	/* namespace Qrexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QREXPORT)
using namespace Qrexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrexportHPP
