// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRWebFilt.pas' rev: 30.00 (Windows)

#ifndef QrwebfiltHPP
#define QrwebfiltHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Printers.hpp>
#include <Data.DB.hpp>
#include <Vcl.ComCtrls.hpp>
#include <QRExport.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <qr5const.hpp>
#include <QRCtrls.hpp>
#include <grimgctrl.hpp>
#include <Vcl.Imaging.jpeg.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrwebfilt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRGAbstractExportFilter;
class DELPHICLASS TQRGHTMLDocumentFilter;
class DELPHICLASS TQRHTMLFilter;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TQRGAbstractExportFilter : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
private:
	System::Classes::TStream* FStream;
	System::Extended FCharWidth;
	System::Extended FCharHeight;
	System::Extended FPaperWidth;
	System::Extended FPaperHeight;
	int FLineCount;
	int FColCount;
	bool FPageProcessed;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FActiveFont;
	
protected:
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	System::UnicodeString __fastcall GetText(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* &Font);
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	void __fastcall WriteToStream(const System::UnicodeString AText);
	void __fastcall WriteLnToStream(const System::UnicodeString AText);
	virtual void __fastcall CreateStream(System::UnicodeString Filename);
	virtual void __fastcall CloseStream(void);
	virtual void __fastcall ProcessPage(void);
	virtual void __fastcall StorePage(void);
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
	__property bool PageProcessed = {read=FPageProcessed, write=FPageProcessed, nodefault};
	__property System::Extended CharWidth = {read=FCharWidth, write=FCharWidth};
	__property System::Extended CharHeight = {read=FCharHeight, write=FCharHeight};
	__property System::Extended PaperWidth = {read=FPaperWidth, write=FPaperWidth};
	__property System::Extended PaperHeight = {read=FPaperHeight, write=FPaperHeight};
	__property int LineCount = {read=FLineCount, write=FLineCount, nodefault};
	__property int ColCount = {read=FColCount, write=FColCount, nodefault};
	
public:
	__fastcall virtual TQRGAbstractExportFilter(System::UnicodeString filename);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall AcceptGraphic(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
public:
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRGAbstractExportFilter(void) { }
	
};


class PASCALIMPLEMENTATION TQRGHTMLDocumentFilter : public TQRGAbstractExportFilter
{
	typedef TQRGAbstractExportFilter inherited;
	
private:
	bool FFreeStream;
	int FPageLength;
	System::Uitypes::TColor FBodyColor;
	System::UnicodeString FBackgroundPic;
	bool FFirstReport;
	int FReportNumber;
	System::UnicodeString FExtraBody;
	int FPageNumber;
	int FNextPicnum;
	int FPageMaxY;
	bool HTMFirstPage;
	bool HTMLastPage;
	bool __fastcall getTransparentTextBG(void);
	void __fastcall setTransparentTextBG(bool value);
	System::UnicodeString __fastcall getPictureDir(void);
	void __fastcall setPictureDir(System::UnicodeString value);
	bool __fastcall getMultiPage(void);
	void __fastcall setMultiPage(bool value);
	int __fastcall getFinalPage(void);
	void __fastcall setFinalPage(int value);
	bool __fastcall getFirstLastLinks(void);
	void __fastcall setFirstLastLinks(bool value);
	bool __fastcall getPageLinks(void);
	void __fastcall setPageLinks(bool value);
	bool __fastcall getConcatenate(void);
	void __fastcall setConcatenate(bool value);
	int __fastcall getConcatCount(void);
	void __fastcall setConcatCount(int value);
	void __fastcall setLinkFontHeight(int value);
	int __fastcall getLinkFontHeight(void);
	System::UnicodeString __fastcall getLinkFontName(void);
	void __fastcall setLinkFontName(System::UnicodeString value);
	
protected:
	virtual System::UnicodeString __fastcall GetFilterName(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual bool __fastcall GetStreaming(void);
	virtual void __fastcall CreateStream(System::UnicodeString Filename);
	virtual void __fastcall CloseStream(void);
	
public:
	System::UnicodeString LinkPrefix;
	__fastcall virtual TQRGHTMLDocumentFilter(System::UnicodeString filename);
	virtual void __fastcall StorePage(void);
	virtual void __fastcall TextOut(System::Extended X, System::Extended Y, Vcl::Graphics::TFont* Font, System::Uitypes::TColor BGColor, System::Classes::TAlignment Alignment, System::UnicodeString Text);
	virtual void __fastcall ProcessPage(void);
	virtual void __fastcall Start(int PaperWidth, int PaperHeight, Vcl::Graphics::TFont* Font);
	virtual void __fastcall Finish(void);
	void __fastcall SetHTMLBody(System::Uitypes::TColor BodyCol, System::UnicodeString BGPic, System::UnicodeString BExtra);
	__property bool TransparentTextBG = {read=getTransparentTextBG, write=setTransparentTextBG, nodefault};
	virtual void __fastcall NewPage(void);
	virtual void __fastcall EndPage(void);
	void __fastcall EndConcat(void);
	virtual void __fastcall AcceptGraphic(System::Extended Xoff, System::Extended Yoff, Vcl::Controls::TControl* GControl);
	__property System::UnicodeString PictureDir = {read=getPictureDir, write=setPictureDir};
	__property bool MultiPage = {read=getMultiPage, write=setMultiPage, nodefault};
	__property bool PageLinks = {read=getPageLinks, write=setPageLinks, nodefault};
	__property int PageLength = {read=FPageLength, write=FPageLength, nodefault};
	__property int FinalPage = {read=getFinalPage, write=setFinalPage, nodefault};
	__property bool FirstLastLinks = {read=getFirstLastLinks, write=setFirstLastLinks, nodefault};
	__property Stream;
	__property bool FreeStream = {read=FFreeStream, write=FFreeStream, nodefault};
	__property bool Concat = {read=getConcatenate, write=setConcatenate, nodefault};
	__property int ConcatCount = {read=getConcatCount, write=setConcatCount, nodefault};
	__property int LinkFontSize = {read=getLinkFontHeight, write=setLinkFontHeight, nodefault};
	__property System::UnicodeString LinkFontName = {read=getLinkFontName, write=setLinkFontName};
	__property TextEncoding;
public:
	/* TQRExportFilter.Destroy */ inline __fastcall virtual ~TQRGHTMLDocumentFilter(void) { }
	
};


class PASCALIMPLEMENTATION TQRHTMLFilter : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::UnicodeString FImageLinkPrefix;
	System::UnicodeString FPagelinkPrefix;
	Qrprntr::TTextEncoding __fastcall GetEncoding(void);
	void __fastcall SetEncoding(Qrprntr::TTextEncoding value);
	System::UnicodeString __fastcall getPictureDir(void);
	void __fastcall setPictureDir(System::UnicodeString value);
	bool __fastcall getMultiPage(void);
	void __fastcall setMultiPage(bool value);
	int __fastcall getFinalPage(void);
	void __fastcall setFinalPage(int value);
	bool __fastcall getFirstLastLinks(void);
	void __fastcall setFirstLastLinks(bool value);
	bool __fastcall getPageLinks(void);
	void __fastcall setPageLinks(bool value);
	bool __fastcall getConcatenate(void);
	void __fastcall setConcatenate(bool value);
	int __fastcall getConcatCount(void);
	void __fastcall setConcatCount(int value);
	void __fastcall setLinkFontHeight(int value);
	int __fastcall getLinkFontHeight(void);
	System::UnicodeString __fastcall getLinkFontName(void);
	void __fastcall setLinkFontName(System::UnicodeString value);
	
public:
	__fastcall virtual TQRHTMLFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRHTMLFilter(void);
	
__published:
	__property System::UnicodeString ImageLinkPrefix = {read=FImageLinkPrefix, write=FImageLinkPrefix};
	__property System::UnicodeString PagelinkPrefix = {read=FPagelinkPrefix, write=FPagelinkPrefix};
	__property System::UnicodeString PictureDir = {read=getPictureDir, write=setPictureDir};
	__property bool MultiPage = {read=getMultiPage, write=setMultiPage, nodefault};
	__property bool PageLinks = {read=getPageLinks, write=setPageLinks, nodefault};
	__property int FinalPage = {read=getFinalPage, write=setFinalPage, nodefault};
	__property bool FirstLastLinks = {read=getFirstLastLinks, write=setFirstLastLinks, nodefault};
	__property bool Concat = {read=getConcatenate, write=setConcatenate, nodefault};
	__property int ConcatCount = {read=getConcatCount, write=setConcatCount, nodefault};
	__property int LinkFontSize = {read=getLinkFontHeight, write=setLinkFontHeight, nodefault};
	__property System::UnicodeString LinkFontName = {read=getLinkFontName, write=setLinkFontName};
	__property Qrprntr::TTextEncoding TextEncoding = {read=GetEncoding, write=SetEncoding, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall basename(System::UnicodeString fname);
}	/* namespace Qrwebfilt */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRWEBFILT)
using namespace Qrwebfilt;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrwebfiltHPP
