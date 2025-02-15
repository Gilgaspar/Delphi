// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcodeProperties.pas' rev: 32.00 (Windows)

#ifndef FrxbarcodepropertiesHPP
#define FrxbarcodepropertiesHPP

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
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <frxClass.hpp>
#include <frxDesgn.hpp>
#include <frxBarcodePDF417.hpp>
#include <frxBarcodeDataMatrix.hpp>
#include <frxBarcodeQR.hpp>
#include <frxDelphiZXingQRCode.hpp>
#include <frxBarcode2DBase.hpp>
#include <frxBarcodeAztec.hpp>
#include <frxBarcodeMaxiCode.hpp>
#include <frxGS1Databar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxbarcodeproperties
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcode2DProperties;
class DELPHICLASS TfrxPDF417Properties;
class DELPHICLASS TfrxDataMatrixProperties;
class DELPHICLASS TfrxQRProperties;
class DELPHICLASS TfrxAztecProperties;
class DELPHICLASS TfrxMaxiCodeProperties;
class DELPHICLASS TfrxGS1DatabarProperties;
class DELPHICLASS TfrxGS1DatabarEProperties;
class DELPHICLASS TfrxGS1DatabarESProperties;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxBarcode2DProperties : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TNotifyEvent FOnChange;
	
public:
	System::TObject* FWhose;
	void __fastcall Changed(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source) = 0 ;
	void __fastcall SetWhose(System::TObject* w);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxBarcode2DProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxBarcode2DProperties(void) : System::Classes::TPersistent() { }
	
};


class PASCALIMPLEMENTATION TfrxPDF417Properties : public TfrxBarcode2DProperties
{
	typedef TfrxBarcode2DProperties inherited;
	
private:
	System::Extended __fastcall GetAspectRatio(void);
	int __fastcall GetColumns(void);
	int __fastcall GetRows(void);
	Frxbarcodepdf417::PDF417ErrorCorrection __fastcall GetErrorCorrection(void);
	int __fastcall GetCodePage(void);
	Frxbarcodepdf417::PDF417CompactionMode __fastcall GetCompactionMode(void);
	int __fastcall GetPixelWidth(void);
	int __fastcall GetPixelHeight(void);
	void __fastcall SetAspectRatio(System::Extended v);
	void __fastcall SetColumns(int v);
	void __fastcall SetRows(int v);
	void __fastcall SetErrorCorrection(Frxbarcodepdf417::PDF417ErrorCorrection v);
	void __fastcall SetCodePage(int v);
	void __fastcall SetCompactionMode(Frxbarcodepdf417::PDF417CompactionMode v);
	void __fastcall SetPixelWidth(int v);
	void __fastcall SetPixelHeight(int v);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Extended AspectRatio = {read=GetAspectRatio, write=SetAspectRatio};
	__property int Columns = {read=GetColumns, write=SetColumns, nodefault};
	__property int Rows = {read=GetRows, write=SetRows, nodefault};
	__property Frxbarcodepdf417::PDF417ErrorCorrection ErrorCorrection = {read=GetErrorCorrection, write=SetErrorCorrection, nodefault};
	__property int CodePage = {read=GetCodePage, write=SetCodePage, nodefault};
	__property Frxbarcodepdf417::PDF417CompactionMode CompactionMode = {read=GetCompactionMode, write=SetCompactionMode, nodefault};
	__property int PixelWidth = {read=GetPixelWidth, write=SetPixelWidth, nodefault};
	__property int PixelHeight = {read=GetPixelHeight, write=SetPixelHeight, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxPDF417Properties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxPDF417Properties(void) : TfrxBarcode2DProperties() { }
	
};


class PASCALIMPLEMENTATION TfrxDataMatrixProperties : public TfrxBarcode2DProperties
{
	typedef TfrxBarcode2DProperties inherited;
	
private:
	int __fastcall GetCodePage(void);
	int __fastcall GetPixelSize(void);
	Frxbarcodedatamatrix::DatamatrixSymbolSize __fastcall GetSymbolSize(void);
	Frxbarcodedatamatrix::DatamatrixEncoding __fastcall GetEncoding(void);
	bool __fastcall GetGS1Rule(void);
	void __fastcall SetCodePage(int v);
	void __fastcall SetPixelSize(int v);
	void __fastcall SetSymbolSize(Frxbarcodedatamatrix::DatamatrixSymbolSize v);
	void __fastcall SetEncoding(Frxbarcodedatamatrix::DatamatrixEncoding v);
	void __fastcall SetGS1Rule(bool b);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int CodePage = {read=GetCodePage, write=SetCodePage, nodefault};
	__property int PixelSize = {read=GetPixelSize, write=SetPixelSize, nodefault};
	__property Frxbarcodedatamatrix::DatamatrixSymbolSize SymbolSize = {read=GetSymbolSize, write=SetSymbolSize, nodefault};
	__property Frxbarcodedatamatrix::DatamatrixEncoding Encoding = {read=GetEncoding, write=SetEncoding, nodefault};
	__property bool GS1Rule = {read=GetGS1Rule, write=SetGS1Rule, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxDataMatrixProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxDataMatrixProperties(void) : TfrxBarcode2DProperties() { }
	
};


class PASCALIMPLEMENTATION TfrxQRProperties : public TfrxBarcode2DProperties
{
	typedef TfrxBarcode2DProperties inherited;
	
private:
	Frxdelphizxingqrcode::TQRCodeEncoding __fastcall GetEncoding(void);
	int __fastcall GetQuietZone(void);
	int __fastcall GetPixelSize(void);
	void __fastcall SetPixelSize(int v);
	void __fastcall SetEncoding(const Frxdelphizxingqrcode::TQRCodeEncoding Value);
	void __fastcall SetQuietZone(const int Value);
	Frxdelphizxingqrcode::TQRErrorLevels __fastcall GetErrorLevels(void);
	void __fastcall SetErrorLevels(const Frxdelphizxingqrcode::TQRErrorLevels Value);
	int __fastcall GetCodePage(void);
	void __fastcall SetCodePage(const int Value);
	Frxbarcodeqr::TfrxBarcodeLogo* __fastcall GetLogo(void);
	Frxbarcodeqr::TfrxBarcodeGraphicMarker* __fastcall GetGraphicMarker(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Frxdelphizxingqrcode::TQRCodeEncoding Encoding = {read=GetEncoding, write=SetEncoding, nodefault};
	__property int QuietZone = {read=GetQuietZone, write=SetQuietZone, nodefault};
	__property Frxdelphizxingqrcode::TQRErrorLevels ErrorLevels = {read=GetErrorLevels, write=SetErrorLevels, nodefault};
	__property int PixelSize = {read=GetPixelSize, write=SetPixelSize, nodefault};
	__property int CodePage = {read=GetCodePage, write=SetCodePage, nodefault};
	__property Frxbarcodeqr::TfrxBarcodeLogo* Logo = {read=GetLogo};
	__property Frxbarcodeqr::TfrxBarcodeGraphicMarker* GraphicMarker = {read=GetGraphicMarker};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxQRProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxQRProperties(void) : TfrxBarcode2DProperties() { }
	
};


class PASCALIMPLEMENTATION TfrxAztecProperties : public TfrxBarcode2DProperties
{
	typedef TfrxBarcode2DProperties inherited;
	
private:
	int __fastcall GetMinECCPercent(void);
	void __fastcall SetMinECCPercent(const int Value);
	int __fastcall GetPixelSize(void);
	void __fastcall SetPixelSize(const int Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int MinECCPercent = {read=GetMinECCPercent, write=SetMinECCPercent, nodefault};
	__property int PixelSize = {read=GetPixelSize, write=SetPixelSize, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxAztecProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxAztecProperties(void) : TfrxBarcode2DProperties() { }
	
};


class PASCALIMPLEMENTATION TfrxMaxiCodeProperties : public TfrxBarcode2DProperties
{
	typedef TfrxBarcode2DProperties inherited;
	
private:
	int __fastcall GetMode(void);
	void __fastcall SetMode(const int Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int Mode = {read=GetMode, write=SetMode, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxMaxiCodeProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxMaxiCodeProperties(void) : TfrxBarcode2DProperties() { }
	
};


class PASCALIMPLEMENTATION TfrxGS1DatabarProperties : public TfrxBarcode2DProperties
{
	typedef TfrxBarcode2DProperties inherited;
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxGS1DatabarProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxGS1DatabarProperties(void) : TfrxBarcode2DProperties() { }
	
};


class PASCALIMPLEMENTATION TfrxGS1DatabarEProperties : public TfrxGS1DatabarProperties
{
	typedef TfrxGS1DatabarProperties inherited;
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxGS1DatabarEProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxGS1DatabarEProperties(void) : TfrxGS1DatabarProperties() { }
	
};


class PASCALIMPLEMENTATION TfrxGS1DatabarESProperties : public TfrxGS1DatabarProperties
{
	typedef TfrxGS1DatabarProperties inherited;
	
private:
	void __fastcall SetColumns(int Col);
	int __fastcall GetColumns(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int Columns = {read=GetColumns, write=SetColumns, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxGS1DatabarESProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxGS1DatabarESProperties(void) : TfrxGS1DatabarProperties() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcodeproperties */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODEPROPERTIES)
using namespace Frxbarcodeproperties;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbarcodepropertiesHPP
