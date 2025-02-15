// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEMFFormat.pas' rev: 32.00 (Windows)

#ifndef FrxemfformatHPP
#define FrxemfformatHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <frxTrueTypeFont.hpp>
#include <frxTrueTypeCollection.hpp>
#include <frxUtils.hpp>
#include <Vcl.Imaging.pngimage.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------
  struct TEnhMetaData;

namespace Frxemfformat
{
//-- forward type declarations -----------------------------------------------
struct TEMRextEscape;
struct TEMRColorCorrectPalette;
struct TEMRSetIcmProfile;
struct TEMRForceUFIMapping;
struct TEMRSmallTextOut;
struct TEMRColorMatchToTarget;
class DELPHICLASS TEnhMetaObj;
class DELPHICLASS TEnhMetaHeaderObj;
class DELPHICLASS TEoFObj;
class DELPHICLASS TEMRPolyPolygon16Obj;
class DELPHICLASS TEMRPolyPolyline16Obj;
class DELPHICLASS TEMRPolyPolygonObj;
class DELPHICLASS TEMRPolyPolylineObj;
class DELPHICLASS TEMRExtSelectClipRgnObj;
class DELPHICLASS TEMRBitmap;
class DELPHICLASS TEMRBitBltObj;
class DELPHICLASS TEMRStretchBltObj;
class DELPHICLASS TEMRStretchDIBitsObj;
class DELPHICLASS TEMRMaskBltObj;
class DELPHICLASS TEMRPLGBltObj;
class DELPHICLASS TEMRSetDIBitsToDeviceObj;
class DELPHICLASS TEMRAlphaBlendObj;
class DELPHICLASS TEMRTransparentBltObj;
class DELPHICLASS TEMRCreateMonoBrushObj;
class DELPHICLASS TEMRExtCreatePenObj;
class DELPHICLASS TEMRCreateDIBPatternBrushPtObj;
class DELPHICLASS TEMRExtTextOutWObj;
class DELPHICLASS TEMRExtTextOutAObj;
class DELPHICLASS TEMRPolyTextOutWObj;
class DELPHICLASS TEMRPolyTextOutAObj;
class DELPHICLASS TEMRPolyDrawObj;
class DELPHICLASS TEMRPolyDraw16Obj;
class DELPHICLASS TEMRSmallTextOutObj;
//-- type declarations -------------------------------------------------------
typedef tagEMRPOLYPOLYLINE16 TEMRPolyPolygon16;

typedef tagEMRPOLYLINE16 TEMRPolyBezier16;

typedef tagEMRPOLYLINE16 TEMRPolyBezierTo16;

typedef tagEMRPOLYLINE16 TEMRPolygon16;

typedef tagEMRPOLYLINE16 TEMRPolylineTo16;

typedef tagEMRSELECTOBJECT TEMRDeleteObject;

typedef tagEMRELLIPSE TEMRRectangle;

typedef tagEMRLINETO TEMRMoveToEx;

typedef tagEMREXTCREATEFONTINDIRECTW TEMRExtCreateFontIndirectW;

typedef tagEMRFILLPATH TEMRStrokeAndFillPath;

typedef tagEMRFILLPATH TEMRStrokePath;

typedef tagEMREXTTEXTOUTA TEMRExtTextOutW;

typedef tagEMREXTTEXTOUTA TEMRExtTextOutA;

typedef tagEMRSETVIEWPORTORGEX TSetBrushOrgEx;

typedef tagEMREXCLUDECLIPRECT TEMRIntersectClipRect;

typedef tagEMRSCALEVIEWPORTEXTEX TEMRScaleWindowExtEx;

typedef tagEMRARC TEMRChord;

typedef tagEMRARC TEMRPie;

typedef tagEMRARC TEMRArcTo;

typedef tagEMRINVERTRGN TEMRPaintRgn;

typedef tagEMRPOLYTEXTOUTA TEMRPolyTextOutA;

typedef tagEMRPOLYTEXTOUTA TEMRPolyTextOutW;

typedef tagEMRSETCOLORSPACE TEMRDeleteColorSpace;

typedef tagEMRSETCOLORSPACE TEMRSetColorSpace;

struct DECLSPEC_DRECORD TEMRextEscape
{
public:
	tagEMR emr;
	int iEscape;
	int cbEscData;
	System::StaticArray<System::Byte, 1> EscData;
};


typedef TEMRextEscape TEMRDrawEsc;

struct DECLSPEC_DRECORD TEMRColorCorrectPalette
{
public:
	tagEMR emr;
	unsigned ihPalette;
	unsigned nFirstEntry;
	unsigned nPalEntries;
	unsigned nReserved;
};


struct DECLSPEC_DRECORD TEMRSetIcmProfile
{
public:
	tagEMR emr;
	unsigned dwFlags;
	unsigned cbName;
	unsigned cbData;
	System::StaticArray<System::Byte, 1> Data;
};


typedef tagEMRSELECTCLIPPATH TEMRSetLayout;

typedef tagEMRPOLYLINE TEMRPolyBezier;

typedef tagEMRPOLYLINE TEMRPolygon;

typedef tagEMRPOLYLINE TEMRPolyBezierTo;

typedef tagEMRPOLYLINE TEMRPolylineTo;

typedef tagEMRPOLYPOLYLINE TEMRPolyPolygon;

struct DECLSPEC_DRECORD TEMRForceUFIMapping
{
public:
	tagEMR emr;
	unsigned Checksum;
	unsigned Index;
};


struct DECLSPEC_DRECORD TEMRSmallTextOut
{
public:
	tagEMR emr;
	System::Types::TPoint ptlReference;
	unsigned nChars;
	unsigned fuOptions;
	unsigned iGraphicsMode;
	float exScale;
	float eyScale;
	System::Types::TRect rclClip;
};


typedef tagEMRGRADIENTFILL TEMRGradientFill;

struct DECLSPEC_DRECORD TEMRColorMatchToTarget
{
public:
	tagEMR emr;
	unsigned dwAction;
	unsigned dwFlags;
	unsigned cbName;
	unsigned cbData;
	System::StaticArray<System::Byte, 1> Data;
};


typedef System::StaticArray<System::Byte, 1> TBytes;

typedef System::StaticArray<unsigned, 1> TLongWords;

typedef TEnhMetaData *PEnhMetaData;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEnhMetaObj : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TEnhMetaData *FP;
	System::WideString __fastcall GetWideString(int Length, int Offset);
	System::AnsiString __fastcall GetANSIString(int Length, int Offset);
	
public:
	__fastcall TEnhMetaObj(System::Classes::TStream* Stream, int Size);
	__fastcall TEnhMetaObj(void *EMR);
	__fastcall virtual ~TEnhMetaObj(void);
	__property PEnhMetaData P = {read=FP};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEnhMetaHeaderObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	int __fastcall GetExtension(void);
	System::WideString __fastcall GetDescription(void);
	tagPIXELFORMATDESCRIPTOR __fastcall GetPixelFormatDescriptor(void);
	
public:
	__property int Extension = {read=GetExtension, nodefault};
	__property System::WideString Description = {read=GetDescription};
	__property tagPIXELFORMATDESCRIPTOR PixelFormatDescriptor = {read=GetPixelFormatDescriptor};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEnhMetaHeaderObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEnhMetaHeaderObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEnhMetaHeaderObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEoFObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	tagPALETTEENTRY __fastcall GetPaletteEntry(unsigned Index);
	unsigned __fastcall GetnSizeLast(void);
	
public:
	__property tagPALETTEENTRY PaletteEntry[unsigned Index] = {read=GetPaletteEntry};
	__property unsigned nSizeLast = {read=GetnSizeLast, nodefault};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEoFObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEoFObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEoFObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPolyPolygon16Obj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	System::Types::TSmallPoint __fastcall GetPolyPoint(int Poly, int Point);
	
public:
	__property System::Types::TSmallPoint PolyPoint[int Poly][int Point] = {read=GetPolyPoint};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPolyPolygon16Obj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPolyPolygon16Obj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPolyPolygon16Obj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPolyPolyline16Obj : public TEMRPolyPolygon16Obj
{
	typedef TEMRPolyPolygon16Obj inherited;
	
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPolyPolyline16Obj(System::Classes::TStream* Stream, int Size) : TEMRPolyPolygon16Obj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPolyPolyline16Obj(void *EMR) : TEMRPolyPolygon16Obj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPolyPolyline16Obj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPolyPolygonObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	System::Types::TPoint __fastcall GetPolyPoint(int Poly, int Point);
	
public:
	__property System::Types::TPoint PolyPoint[int Poly][int Point] = {read=GetPolyPoint};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPolyPolygonObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPolyPolygonObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPolyPolygonObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPolyPolylineObj : public TEMRPolyPolygon16Obj
{
	typedef TEMRPolyPolygon16Obj inherited;
	
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPolyPolylineObj(System::Classes::TStream* Stream, int Size) : TEMRPolyPolygon16Obj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPolyPolylineObj(void *EMR) : TEMRPolyPolygon16Obj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPolyPolylineObj(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<System::Types::TRect, 1> TRectArray;

typedef TRectArray *PRectArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRExtSelectClipRgnObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	Winapi::Windows::PRgnData __fastcall GetRegionData(void);
	System::Types::TRect __fastcall GetRegion(unsigned Index);
	
public:
	__property Winapi::Windows::PRgnData PRegionData = {read=GetRegionData};
	__property System::Types::TRect Region[unsigned Index] = {read=GetRegion};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRExtSelectClipRgnObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRExtSelectClipRgnObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRExtSelectClipRgnObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRBitmap : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void) = 0 ;
	
public:
	Vcl::Graphics::TBitmap* __fastcall GetBitmap(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRBitmap(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRBitmap(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRBitmap(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRBitBltObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRBitBltObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRBitBltObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRBitBltObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRStretchBltObj : public TEMRBitBltObj
{
	typedef TEMRBitBltObj inherited;
	
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRStretchBltObj(System::Classes::TStream* Stream, int Size) : TEMRBitBltObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRStretchBltObj(void *EMR) : TEMRBitBltObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRStretchBltObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRStretchDIBitsObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
	
public:
	void __fastcall FlipVertical(Vcl::Graphics::TBitmap* Bitmap);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRStretchDIBitsObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRStretchDIBitsObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRStretchDIBitsObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRMaskBltObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRMaskBltObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRMaskBltObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRMaskBltObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPLGBltObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPLGBltObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPLGBltObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPLGBltObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRSetDIBitsToDeviceObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRSetDIBitsToDeviceObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRSetDIBitsToDeviceObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRSetDIBitsToDeviceObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRAlphaBlendObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
	
public:
	Vcl::Imaging::Pngimage::TPngImage* __fastcall GetPngObject(void);
	Vcl::Graphics::TBitmap* __fastcall GetBitmap24(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRAlphaBlendObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRAlphaBlendObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRAlphaBlendObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRTransparentBltObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRTransparentBltObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRTransparentBltObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRTransparentBltObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRCreateMonoBrushObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRCreateMonoBrushObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRCreateMonoBrushObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRCreateMonoBrushObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRExtCreatePenObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRExtCreatePenObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRExtCreatePenObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRExtCreatePenObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRCreateDIBPatternBrushPtObj : public TEMRBitmap
{
	typedef TEMRBitmap inherited;
	
protected:
	virtual unsigned __fastcall OffsetBmiSrc(void);
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRCreateDIBPatternBrushPtObj(System::Classes::TStream* Stream, int Size) : TEMRBitmap(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRCreateDIBPatternBrushPtObj(void *EMR) : TEMRBitmap(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRCreateDIBPatternBrushPtObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRExtTextOutWObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	unsigned __fastcall GetTextLength(void);
	
public:
	System::WideString __fastcall OutputString(System::UnicodeString FontName, bool IsRTL = false);
	Frxutils::TLongWordDinArray __fastcall OutputDx(void);
	Frxutils::TLongWordDinArray __fastcall OutputDy(void);
	bool __fastcall IsOption(unsigned O);
	__property unsigned TextLength = {read=GetTextLength, nodefault};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRExtTextOutWObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRExtTextOutWObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRExtTextOutWObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRExtTextOutAObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	System::AnsiString __fastcall GetOutputString(void);
	unsigned __fastcall GetTextLength(void);
	
public:
	Frxutils::TLongWordDinArray __fastcall OutputDx(void);
	Frxutils::TLongWordDinArray __fastcall OutputDy(void);
	bool __fastcall IsOption(unsigned O);
	__property unsigned TextLength = {read=GetTextLength, nodefault};
	__property System::AnsiString OutputString = {read=GetOutputString};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRExtTextOutAObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRExtTextOutAObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRExtTextOutAObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPolyTextOutWObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	System::WideString __fastcall GetOutputString(int Index);
	
public:
	__property System::WideString OutputString[int Index] = {read=GetOutputString};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPolyTextOutWObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPolyTextOutWObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPolyTextOutWObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPolyTextOutAObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	System::AnsiString __fastcall GetOutputString(int Index);
	
public:
	__property System::AnsiString OutputString[int Index] = {read=GetOutputString};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPolyTextOutAObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPolyTextOutAObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPolyTextOutAObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPolyDrawObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	System::Byte __fastcall GetTypes(unsigned Index);
	
public:
	__property System::Byte Types[unsigned Index] = {read=GetTypes};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPolyDrawObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPolyDrawObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPolyDrawObj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRPolyDraw16Obj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	System::Byte __fastcall GetTypes(unsigned Index);
	
public:
	__property System::Byte Types[unsigned Index] = {read=GetTypes};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRPolyDraw16Obj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRPolyDraw16Obj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRPolyDraw16Obj(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEMRSmallTextOutObj : public TEnhMetaObj
{
	typedef TEnhMetaObj inherited;
	
private:
	System::WideString __fastcall GetOutputStringWide(void);
	System::AnsiString __fastcall GetOutputStringANSI(void);
	int __fastcall StringOffset(void);
	
public:
	bool __fastcall IsNoRect(void);
	bool __fastcall IsANSI(void);
	__property System::WideString OutputStringWide = {read=GetOutputStringWide};
	__property System::AnsiString OutputStringANSI = {read=GetOutputStringANSI};
public:
	/* TEnhMetaObj.Create */ inline __fastcall TEMRSmallTextOutObj(System::Classes::TStream* Stream, int Size) : TEnhMetaObj(Stream, Size) { }
	/* TEnhMetaObj.CreateRec */ inline __fastcall TEMRSmallTextOutObj(void *EMR) : TEnhMetaObj(EMR) { }
	/* TEnhMetaObj.Destroy */ inline __fastcall virtual ~TEMRSmallTextOutObj(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 EMR_Reserved_69 = System::Int8(0x45);
static const System::Int8 EMR_SetLayout = System::Int8(0x73);
static const System::Int8 EMR_LAYOUT_RTL = System::Int8(0x1);
static const System::Int8 EMR_ColorMatchToTargetW = System::Int8(0x79);
static const System::Int8 EMR_CreateColorSpaceW = System::Int8(0x7a);
static const System::Int8 EMR_EMR = System::Int8(0x7b);
static const System::Int8 EMR_Bytes = System::Int8(0x7c);
static const System::Int8 EMR_CreateHandle = System::Int8(0x7d);
static const System::Int8 EMR_LongWords = System::Int8(0x7e);
static const System::Int8 MWT_SET = System::Int8(0x4);
static const System::Word ETO_NO_RECT = System::Word(0x100);
static const System::Word ETO_SMALL_CHARS = System::Word(0x200);
static const unsigned EMR_COMMENT_WINDOWS_METAFILE = unsigned(0x80000001);
static const System::Int8 EMR_COMMENT_BEGINGROUP = System::Int8(0x2);
static const System::Int8 EMR_COMMENT_ENDGROUP = System::Int8(0x3);
static const int EMR_COMMENT_MULTIFORMATS = int(0x40000004);
static const System::Int8 EMR_COMMENT_UNICODE_STRING = System::Int8(0x40);
static const System::Byte EMR_COMMENT_UNICODE_END = System::Byte(0x80);
static const System::Int8 ehUnknown = System::Int8(-1);
static const System::Int8 ehOriginal = System::Int8(0x0);
static const System::Int8 ehExtension1 = System::Int8(0x1);
static const System::Int8 ehExtension2 = System::Int8(0x2);
extern DELPHI_PACKAGE bool __fastcall IsStockBrush(const unsigned ih)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockBrush(TEnhMetaObj* EnhMetaObj)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockPen(const unsigned ih)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockPen(TEnhMetaObj* EnhMetaObj)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockFont(const unsigned ih)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockFont(TEnhMetaObj* EnhMetaObj)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockPalette(const unsigned ih)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockPalette(TEnhMetaObj* EnhMetaObj)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockObject(const unsigned ih)/* overload */;
extern DELPHI_PACKAGE bool __fastcall IsStockObject(TEnhMetaObj* EnhMetaObj)/* overload */;
extern DELPHI_PACKAGE TEnhMetaObj* __fastcall StockObject(const unsigned ih);
}	/* namespace Frxemfformat */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEMFFORMAT)
using namespace Frxemfformat;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxemfformatHPP
