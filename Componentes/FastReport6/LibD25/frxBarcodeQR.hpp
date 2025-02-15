// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcodeQR.pas' rev: 32.00 (Windows)

#ifndef FrxbarcodeqrHPP
#define FrxbarcodeqrHPP

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
#include <System.Types.hpp>
#include <System.StrUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <frxBarcode2DBase.hpp>
#include <frxDelphiZXingQRCode.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxbarcodeqr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcodeLogo;
class DELPHICLASS TfrxBarcodeGraphicMarker;
class DELPHICLASS TfrxBarcodeQR;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxBarcodeLogo : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Graphics::TPicture* FLogo;
	int FWidth;
	int FHeight;
	void __fastcall SetLogo(Vcl::Graphics::TPicture* const Value);
	Vcl::Graphics::TPicture* __fastcall GetLogo(void);
	Vcl::Graphics::TPicture* __fastcall GetLogoInst(void);
	
public:
	__fastcall TfrxBarcodeLogo(void);
	__fastcall virtual ~TfrxBarcodeLogo(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Draw(const System::Types::TRect &DrawRect, System::Extended ScaleX, System::Extended ScaleY, Vcl::Graphics::TCanvas* Canvas, System::Extended Zoom);
	
__published:
	__property Vcl::Graphics::TPicture* Logo = {read=GetLogo, write=SetLogo};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxBarcodeGraphicMarker : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FShowGraphicMarker;
	int FWidthLine;
	int FDistance;
	int FPixelSize;
	System::Extended FScaleX;
	System::Extended FScaleY;
	void __fastcall SetWidthLine(const int Value);
	void __fastcall SetDistance(const int Value);
	void __fastcall SetPixelSize(const int Value);
	
public:
	__fastcall TfrxBarcodeGraphicMarker(int PixelSize);
	void __fastcall Draw(const System::Types::TRect &DrawRect, System::Extended ScaleX, System::Extended ScaleY, Vcl::Graphics::TCanvas* &Canvas, System::Extended Zoom, int FooterHeight);
	
__published:
	__property bool ShowGraphicMarker = {read=FShowGraphicMarker, write=FShowGraphicMarker, nodefault};
	__property int WidthLine = {read=FWidthLine, write=SetWidthLine, nodefault};
	__property int Distance = {read=FDistance, write=SetDistance, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxBarcodeGraphicMarker(void) { }
	
};


class PASCALIMPLEMENTATION TfrxBarcodeQR : public Frxbarcode2dbase::TfrxBarcode2DBaseWithUnion
{
	typedef Frxbarcode2dbase::TfrxBarcode2DBaseWithUnion inherited;
	
private:
	Frxdelphizxingqrcode::TDelphiZXingQRCode* FDelphiZXingQRCode;
	TfrxBarcodeLogo* FLogo;
	TfrxBarcodeGraphicMarker* FGraphicMarker;
	void __fastcall Generate(void);
	Frxdelphizxingqrcode::TQRCodeEncoding __fastcall GetEncoding(void);
	int __fastcall GetQuietZone(void);
	void __fastcall SetEncoding(const Frxdelphizxingqrcode::TQRCodeEncoding Value);
	void __fastcall SetQuietZone(const int Value);
	Frxdelphizxingqrcode::TQRErrorLevels __fastcall GetErrorLevels(void);
	void __fastcall SetErrorLevels(const Frxdelphizxingqrcode::TQRErrorLevels Value);
	int __fastcall GetPixelSize(void);
	void __fastcall SetPixelSize(int v);
	int __fastcall GetCodepage(void);
	void __fastcall SetCodepage(const int Value);
	
protected:
	virtual void __fastcall SetText(System::UnicodeString v);
	virtual int __fastcall GetWidth(void);
	virtual int __fastcall GetHeight(void);
	
public:
	__fastcall virtual TfrxBarcodeQR(void);
	__fastcall virtual ~TfrxBarcodeQR(void);
	virtual void __fastcall Assign(Frxbarcode2dbase::TfrxBarcode2DBase* src);
	virtual void __fastcall Draw2DBarcode(Vcl::Graphics::TCanvas* &g, System::Extended scalex, System::Extended scaley, int x, int y);
	
__published:
	__property Frxdelphizxingqrcode::TQRCodeEncoding Encoding = {read=GetEncoding, write=SetEncoding, nodefault};
	__property int QuietZone = {read=GetQuietZone, write=SetQuietZone, nodefault};
	__property Frxdelphizxingqrcode::TQRErrorLevels ErrorLevels = {read=GetErrorLevels, write=SetErrorLevels, nodefault};
	__property int PixelSize = {read=GetPixelSize, write=SetPixelSize, nodefault};
	__property int Codepage = {read=GetCodepage, write=SetCodepage, nodefault};
	__property TfrxBarcodeLogo* Logo = {read=FLogo};
	__property TfrxBarcodeGraphicMarker* GraphicMarker = {read=FGraphicMarker};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcodeqr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODEQR)
using namespace Frxbarcodeqr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbarcodeqrHPP
