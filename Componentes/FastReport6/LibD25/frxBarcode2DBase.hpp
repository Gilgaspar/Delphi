// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcode2DBase.pas' rev: 32.00 (Windows)

#ifndef Frxbarcode2dbaseHPP
#define Frxbarcode2dbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <frxPrinter.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxbarcode2dbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcode2DBase;
class DELPHICLASS TfrxBarcode2DBaseWithUnion;
class DELPHICLASS TfrxBarcode2DBaseWithOutUnion;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<bool> Frxbarcode2dbase__1;

typedef System::DynamicArray<System::DynamicArray<bool> > T2DBooleanArray;

class PASCALIMPLEMENTATION TfrxBarcode2DBase : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	int FHeight;
	int FWidth;
	int FPixelWidth;
	int FPixelHeight;
	bool FShowText;
	int FRotation;
	System::UnicodeString FText;
	System::Extended FZoom;
	bool FFontScaled;
	Vcl::Graphics::TFont* FFont;
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FColorBar;
	System::UnicodeString FErrorText;
	int FQuietZone;
	virtual void __fastcall SetShowText(bool v);
	virtual void __fastcall SetRotation(int v);
	virtual void __fastcall SetText(System::UnicodeString v);
	virtual void __fastcall SetZoom(System::Extended v);
	virtual void __fastcall SetFontScaled(bool v);
	virtual void __fastcall SetFont(Vcl::Graphics::TFont* v);
	virtual void __fastcall SetColor(System::Uitypes::TColor v);
	virtual void __fastcall SetColorBar(System::Uitypes::TColor v);
	virtual void __fastcall SetErrorText(System::UnicodeString v);
	virtual void __fastcall SetHeight(const int Value);
	virtual int __fastcall GetWidth(void);
	virtual int __fastcall GetHeight(void);
	virtual void __fastcall InternalDraw(Vcl::Graphics::TCanvas* aCanvas, System::Extended scalex, System::Extended scaley, int x, int y, int footerHeight, int dx, int dy, int paddingX, int paddingY, System::Extended kx, System::Extended ky);
	
public:
	__fastcall virtual TfrxBarcode2DBase(void);
	__fastcall virtual ~TfrxBarcode2DBase(void);
	virtual void __fastcall Assign(TfrxBarcode2DBase* src);
	virtual int __fastcall GetFooterHeight(void);
	virtual void __fastcall Draw2DBarcode(Vcl::Graphics::TCanvas* &g, System::Extended scalex, System::Extended scaley, int x, int y);
	void __fastcall FillRect(Vcl::Graphics::TCanvas* Canv, const System::Types::TRect &Rect);
	virtual bool __fastcall IsScaled(void);
	__property bool ShowText = {read=FShowText, write=SetShowText, nodefault};
	__property int Rotation = {read=FRotation, write=SetRotation, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property System::Extended Zoom = {read=FZoom, write=SetZoom};
	__property bool FontScaled = {read=FFontScaled, write=SetFontScaled, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property System::Uitypes::TColor ColorBar = {read=FColorBar, write=SetColorBar, nodefault};
	__property System::UnicodeString ErrorText = {read=FErrorText, write=SetErrorText};
	__property int Width = {read=GetWidth, nodefault};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property int PixelWidth = {read=FPixelWidth, write=FPixelWidth, nodefault};
	__property int PixelHeight = {read=FPixelHeight, write=FPixelHeight, nodefault};
	__property int QuietZone = {read=FQuietZone, write=FQuietZone, nodefault};
};


class PASCALIMPLEMENTATION TfrxBarcode2DBaseWithUnion : public TfrxBarcode2DBase
{
	typedef TfrxBarcode2DBase inherited;
	
	
private:
	typedef System::DynamicArray<int> _TfrxBarcode2DBaseWithUnion__1;
	
	
protected:
	System::Classes::TList* FVectorPrimitives;
	_TfrxBarcode2DBaseWithUnion__1 DotsR;
	_TfrxBarcode2DBaseWithUnion__1 DotsL;
	
public:
	void __fastcall FVectorPrimitivesAdd(int ALeft, int ATop, int AWidth, int AHeight);
	__fastcall virtual TfrxBarcode2DBaseWithUnion(void);
	__fastcall virtual ~TfrxBarcode2DBaseWithUnion(void);
	void __fastcall ClearFigures(void);
	void __fastcall T2DBooleanArrayToVectorPrimitives(T2DBooleanArray GlArr, int x, int y, System::Byte QuietZone = (System::Byte)(0x0));
	virtual void __fastcall InternalDraw(Vcl::Graphics::TCanvas* aCanvas, System::Extended scalex, System::Extended scaley, int x, int y, int footerHeight, int dx, int dy, int paddingX, int paddingY, System::Extended kx, System::Extended ky);
};


class PASCALIMPLEMENTATION TfrxBarcode2DBaseWithOutUnion : public TfrxBarcode2DBase
{
	typedef TfrxBarcode2DBase inherited;
	
	
private:
	typedef System::DynamicArray<System::Byte> _TfrxBarcode2DBaseWithOutUnion__1;
	
	
protected:
	_TfrxBarcode2DBaseWithOutUnion__1 FImage;
	
public:
	__fastcall virtual TfrxBarcode2DBaseWithOutUnion(void);
	__fastcall virtual ~TfrxBarcode2DBaseWithOutUnion(void);
	virtual void __fastcall InternalDraw(Vcl::Graphics::TCanvas* aCanvas, System::Extended scalex, System::Extended scaley, int x, int y, int footerHeight, int dx, int dy, int paddingX, int paddingY, System::Extended kx, System::Extended ky);
};


//-- var, const, procedure ---------------------------------------------------
#define cbDefaultText L"12345678"
}	/* namespace Frxbarcode2dbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODE2DBASE)
using namespace Frxbarcode2dbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxbarcode2dbaseHPP
