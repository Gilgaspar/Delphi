// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEMFAbstractExport.pas' rev: 32.00 (Windows)

#ifndef FrxemfabstractexportHPP
#define FrxemfabstractexportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <frxEMFFormat.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <frxClass.hpp>
#include <frxUtils.hpp>
#include <frxAnaliticGeometry.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxemfabstractexport
{
//-- forward type declarations -----------------------------------------------
struct TDeviceContextData;
class DELPHICLASS TDeviceContext;
struct TMemoExternalParams;
class DELPHICLASS TEMFFont;
class DELPHICLASS TEMFAbstractExport;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TDeviceContextData
{
	
private:
	typedef System::DynamicArray<System::Uitypes::TColor> _TDeviceContextData__1;
	
	
public:
	System::Types::TPoint DeviceTopLeft;
	Frxclass::TfrxPoint rTopLeft;
	unsigned Layout;
	unsigned MapMode;
	System::Types::TPoint WindowOrgEx;
	System::Types::TPoint ViewPortOrgEx;
	System::Types::TPoint BrushOrgEx;
	System::Types::TSize WindowExtEx;
	System::Types::TSize ViewPortExtEx;
	Frxemfformat::TEnhMetaObj* Pen;
	Frxemfformat::TEnhMetaObj* Brush;
	Frxemfformat::TEnhMetaObj* Font;
	Frxemfformat::TEnhMetaObj* Palette;
	Frxemfformat::TEnhMetaObj* ColorSpace;
	Frxemfformat::TEnhMetaObj* ColorAdjustment;
	System::Types::TPoint PositionCurrent;
	System::Types::TPoint PositionNext;
	unsigned BkMode;
	float MiterLimit;
	unsigned BkColor;
	unsigned TextColor;
	unsigned SetRop2;
	unsigned PolyFillMode;
	HRGN ClipRgn;
	_TDeviceContextData__1 EOFPalette;
	unsigned StretchMode;
	bool IsPathBracketOpened;
	unsigned TextAlignmentMode;
	unsigned ICMMode;
	tagXFORM XForm;
	unsigned MapperFlags;
	unsigned iArcDirection;
};


typedef System::DynamicArray<Frxemfformat::TEnhMetaObj*> TEnhMetaObjArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDeviceContext : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	tagXFORM FRotationXForm;
	tagXFORM FShiftXForm;
	tagXFORM FScaleXForm;
	bool FIsDecomposited;
	unsigned __fastcall GetLogPenStyle(void);
	unsigned __fastcall GetPenType(void);
	unsigned __fastcall GetPenStyle(void);
	unsigned __fastcall GetPenEndCap(void);
	unsigned __fastcall GetPenLineJoin(void);
	System::Extended __fastcall GetPenWidth(void);
	float __fastcall GetMiterLimit(void);
	System::Uitypes::TColor __fastcall GetPenColor(void);
	System::Uitypes::TColor __fastcall GetBrushColor(void);
	unsigned __fastcall GetBrushStyle(void);
	unsigned __fastcall GetBrushHatch(void);
	System::Uitypes::TColor __fastcall GetTextColor(void);
	System::UnicodeString __fastcall GetFontFamily(void);
	int __fastcall GetFontSize(void);
	int __fastcall GetFontWeight(void);
	bool __fastcall GetFontItalic(void);
	bool __fastcall GetFontStrikeOut(void);
	System::Byte __fastcall GetFontCharSet(void);
	bool __fastcall GetFontUnderline(void);
	int __fastcall GetFontOrientation(void);
	System::Extended __fastcall GetFontRadian(void);
	System::Uitypes::TColor __fastcall GetBkColor(void);
	Frxclass::TfrxHAlign __fastcall GetHAlign(void);
	Frxclass::TfrxVAlign __fastcall GetVAlign(void);
	void __fastcall SetXForm(const tagXFORM &Value);
	int __fastcall GetLineOrientation(void);
	void __fastcall Decomposition(void);
	Frxclass::TfrxPoint __fastcall GetXFormScale(void);
	System::Extended __fastcall GetXFormAverageScale(void);
	
protected:
	TDeviceContextData FData;
	void __fastcall DeleteObject(unsigned ih);
	void __fastcall SelectObject(unsigned ih, TEnhMetaObjArray EnhMetaObjArray);
	
public:
	virtual void __fastcall CopyFrom(System::TObject* ADC);
	virtual void __fastcall Init(void);
	bool __fastcall IsFontHeight(void);
	System::Uitypes::TColor __fastcall MonoBrushAverageColor(unsigned ih, TEnhMetaObjArray EnhMetaObjArray);
	__property HRGN ClipRgn = {read=FData.ClipRgn, nodefault};
	__property bool IsPathBracketOpened = {read=FData.IsPathBracketOpened, nodefault};
	__property unsigned Layout = {read=FData.Layout, nodefault};
	__property unsigned MapMode = {read=FData.MapMode, nodefault};
	__property unsigned PolyFillMode = {read=FData.PolyFillMode, nodefault};
	__property System::Types::TPoint PositionCurrent = {read=FData.PositionCurrent};
	__property System::Types::TPoint PositionNext = {read=FData.PositionNext};
	__property unsigned ICMMode = {read=FData.ICMMode, nodefault};
	__property unsigned MapperFlags = {read=FData.MapperFlags, nodefault};
	__property unsigned iArcDirection = {read=FData.iArcDirection, nodefault};
	__property unsigned LogPenStyle = {read=GetLogPenStyle, nodefault};
	__property unsigned PenType = {read=GetPenType, nodefault};
	__property unsigned PenStyle = {read=GetPenStyle, nodefault};
	__property unsigned PenEndCap = {read=GetPenEndCap, nodefault};
	__property unsigned PenLineJoin = {read=GetPenLineJoin, nodefault};
	__property System::Extended PenWidth = {read=GetPenWidth};
	__property System::Uitypes::TColor PenColor = {read=GetPenColor, nodefault};
	__property float MiterLimit = {read=GetMiterLimit};
	__property unsigned SetRop2 = {read=FData.SetRop2, nodefault};
	__property unsigned StretchMode = {read=FData.StretchMode, nodefault};
	__property unsigned TextAlignmentMode = {read=FData.TextAlignmentMode, nodefault};
	__property System::Uitypes::TColor TextColor = {read=GetTextColor, nodefault};
	__property System::Uitypes::TColor BkColor = {read=GetBkColor, nodefault};
	__property System::UnicodeString FontFamily = {read=GetFontFamily};
	__property int FontSize = {read=GetFontSize, nodefault};
	__property int FontWeight = {read=GetFontWeight, nodefault};
	__property bool FontItalic = {read=GetFontItalic, nodefault};
	__property System::Byte FontCharSet = {read=GetFontCharSet, nodefault};
	__property bool FontUnderline = {read=GetFontUnderline, nodefault};
	__property bool FontStrikeOut = {read=GetFontStrikeOut, nodefault};
	__property int FontOrientation = {read=GetFontOrientation, nodefault};
	__property System::Extended FontRadian = {read=GetFontRadian};
	__property int LineOrientation = {read=GetLineOrientation, nodefault};
	__property Frxclass::TfrxPoint XFormScale = {read=GetXFormScale};
	__property System::Extended XFormAverageScale = {read=GetXFormAverageScale};
	__property System::Uitypes::TColor BrushColor = {read=GetBrushColor, nodefault};
	__property unsigned BrushStyle = {read=GetBrushStyle, nodefault};
	__property unsigned BrushHatch = {read=GetBrushHatch, nodefault};
	__property unsigned BkMode = {read=FData.BkMode, nodefault};
	__property System::Types::TPoint DeviceTopLeft = {read=FData.DeviceTopLeft};
	__property Frxclass::TfrxPoint rTopLeft = {read=FData.rTopLeft};
	__property System::Types::TPoint WindowOrgEx = {read=FData.WindowOrgEx};
	__property System::Types::TPoint ViewPortOrgEx = {read=FData.ViewPortOrgEx};
	__property System::Types::TPoint BrushOrgEx = {read=FData.BrushOrgEx};
	__property System::Types::TSize WindowExtEx = {read=FData.WindowExtEx};
	__property System::Types::TSize ViewPortExtEx = {read=FData.ViewPortExtEx};
	__property tagXFORM XForm = {read=FData.XForm, write=SetXForm};
	__property Frxclass::TfrxVAlign VAlign = {read=GetVAlign, nodefault};
	__property Frxclass::TfrxHAlign HAlign = {read=GetHAlign, nodefault};
public:
	/* TObject.Create */ inline __fastcall TDeviceContext(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TDeviceContext(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<System::WideChar, 1> TWideCharArray;

typedef TWideCharArray *PWideCharArray;

struct DECLSPEC_DRECORD TMemoExternalParams
{
public:
	bool IsExternal;
	Frxclass::TfrxRect Margins;
	System::Extended Width;
	System::Extended Height;
	Frxclass::TfrxPoint Shift;
};


class PASCALIMPLEMENTATION TEMFFont : public Vcl::Graphics::TFont
{
	typedef Vcl::Graphics::TFont inherited;
	
private:
	double FPreciseSize;
	double FDownSizeFactor;
	
public:
	__property double PreciseSize = {read=FPreciseSize, write=FPreciseSize};
	__property double DownSizeFactor = {read=FDownSizeFactor, write=FDownSizeFactor};
public:
	/* TFont.Create */ inline __fastcall TEMFFont(void) : Vcl::Graphics::TFont() { }
	/* TFont.Destroy */ inline __fastcall virtual ~TEMFFont(void) { }
	
};


class PASCALIMPLEMENTATION TEMFAbstractExport : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FShowComments;
	bool FFormatted;
	bool FEnableTransform;
	System::WideString FParsing;
	System::Classes::TStream* FInStream;
	tagEMR FLastRecord;
	System::Contnrs::TObjectList* FDCList;
	void __fastcall SetParsing(const System::WideString Value);
	void __fastcall ReadCurrentRecord(void);
	void __fastcall PlayMetaCommand(void);
	void __fastcall AddLastRecord(void);
	System::UnicodeString __fastcall ByteToHex(System::Byte B);
	void __fastcall ReadEoFPalette(void);
	void __fastcall ReadAlign(void);
	void __fastcall TransformPoint(Frxclass::TfrxPoint &DP, bool IsScalingOnly = false);
	void __fastcall Parse_Poly(System::UnicodeString Name);
	void __fastcall Parse_Poly16(System::UnicodeString Name);
	void __fastcall Parse_PolyPoly(System::UnicodeString Name);
	void __fastcall Parse_PolyPoly16(System::UnicodeString Name);
	System::UnicodeString __fastcall CommentRect(const System::Types::TRect &Rect);
	System::UnicodeString __fastcall CommentPoint(const System::Types::TPoint &Point);
	System::Extended __fastcall LogToDevX(System::Extended LX);
	System::Extended __fastcall LogToDevY(System::Extended LY);
	
protected:
	System::Classes::TStream* FOutStream;
	System::Contnrs::TObjectList* FEMRList;
	TEnhMetaObjArray FEMRLastCreated;
	TDeviceContext* FDC;
	TMemoExternalParams FMEP;
	void __fastcall CalcMemoExternalParams(Frxclass::TfrxView* Obj);
	System::Uitypes::TColor __fastcall MonoBrushAverageColor(unsigned ih);
	virtual void __fastcall Comment(System::UnicodeString CommentString = System::UnicodeString());
	System::UnicodeString __fastcall CommentArray(Frxutils::TByteDinArray A)/* overload */;
	System::UnicodeString __fastcall CommentArray(Frxutils::TWordDinArray A)/* overload */;
	System::UnicodeString __fastcall CommentArray(Frxutils::TLongWordDinArray A)/* overload */;
	System::UnicodeString __fastcall CommentArray(Frxutils::TIntegerDinArray A)/* overload */;
	System::UnicodeString __fastcall CommentArray(Frxanaliticgeometry::TDoubleArray A, int Prec = 0x1)/* overload */;
	System::UnicodeString __fastcall CommentArraySum(Frxutils::TLongWordDinArray A)/* overload */;
	System::UnicodeString __fastcall CommentArraySum(Frxanaliticgeometry::TDoubleArray A, int Prec = 0x1)/* overload */;
	Frxemfformat::PEnhMetaData __fastcall PLast(void);
	virtual void __fastcall DCCreate(void);
	virtual TEMFFont* __fastcall FontCreate(void);
	Frxclass::TfrxPoint __fastcall LogToDevPoint(System::Types::TSmallPoint LP, bool IsScalingOnly = false)/* overload */;
	Frxclass::TfrxPoint __fastcall LogToDevPoint(const System::Types::TPoint &LP, bool IsScalingOnly = false)/* overload */;
	Frxclass::TfrxPoint __fastcall LogToDevPoint(const Frxclass::TfrxPoint &LP, bool IsScalingOnly = false)/* overload */;
	Frxclass::TfrxPoint __fastcall LogToDevPoint(const Frxanaliticgeometry::TDoublePoint &LP, bool IsScalingOnly = false)/* overload */;
	Frxclass::TfrxPoint __fastcall LogToDevPoint(System::Extended X, System::Extended Y, bool IsScalingOnly = false)/* overload */;
	Frxclass::TfrxRect __fastcall LogToDevRect(const System::Types::TRect &LR);
	System::Extended __fastcall LogToDevSizeX(System::Extended Value);
	System::Extended __fastcall LogToDevSizeY(System::Extended Value);
	System::Extended __fastcall LogToDevSize(System::Extended Value);
	virtual void __fastcall DoEMR_AbortPath(void);
	virtual void __fastcall DoEMR_AlphaBlend(void);
	virtual void __fastcall DoEMR_AngleArc(void);
	virtual void __fastcall DoEMR_Arc(void);
	virtual void __fastcall DoEMR_ArcTo(void);
	virtual void __fastcall DoEMR_BeginPath(void);
	virtual void __fastcall DoEMR_BitBlt(void);
	virtual void __fastcall DoEMR_Chord(void);
	virtual void __fastcall DoEMR_CloseFigure(void);
	virtual void __fastcall DoEMR_ColorCorrectPalette(void);
	virtual void __fastcall DoEMR_ColorMatchToTargetW(void);
	virtual void __fastcall DoEMR_CreateBrushIndirect(void);
	virtual void __fastcall DoEMR_CreateColorSpace(void);
	virtual void __fastcall DoEMR_CreateColorSpaceW(void);
	virtual void __fastcall DoEMR_CreateDIBPatternBrushPt(void);
	virtual void __fastcall DoEMR_CreateMonoBrush(void);
	virtual void __fastcall DoEMR_CreatePalette(void);
	virtual void __fastcall DoEMR_CreatePen(void);
	virtual void __fastcall DoEMR_DeleteColorSpace(void);
	virtual void __fastcall DoEMR_DeleteObject(void);
	virtual void __fastcall DoEMR_DrawEscape(void);
	virtual void __fastcall DoEMR_Ellipse(void);
	virtual void __fastcall DoEMR_EndPath(void);
	virtual void __fastcall DoEMR_EoF(void);
	virtual void __fastcall DoEMR_ExcludeClipRect(void);
	virtual void __fastcall DoEMR_ExtCreateFontIndirectW(void);
	virtual void __fastcall DoEMR_ExtCreatePen(void);
	virtual void __fastcall DoEMR_ExtEscape(void);
	virtual void __fastcall DoEMR_ExtFloodFill(void);
	virtual void __fastcall DoEMR_ExtSelectClipRgn(void);
	virtual void __fastcall DoEMR_ExtTextOutA(void);
	virtual void __fastcall DoEMR_ExtTextOutW(void);
	virtual void __fastcall DoEMR_FillPath(void);
	virtual void __fastcall DoEMR_FillRgn(void);
	virtual void __fastcall DoEMR_FlattenPath(void);
	virtual void __fastcall DoEMR_ForceUFIMapping(void);
	virtual void __fastcall DoEMR_FrameRgn(void);
	virtual void __fastcall DoEMR_GDIComment(void);
	virtual void __fastcall DoEMR_GLSBoundedRecord(void);
	virtual void __fastcall DoEMR_GLSRecord(void);
	virtual void __fastcall DoEMR_GradientFill(void);
	virtual void __fastcall DoEMR_Header(void);
	virtual void __fastcall DoEMR_IntersectClipRect(void);
	virtual void __fastcall DoEMR_InvertRgn(void);
	virtual void __fastcall DoEMR_LineTo(void);
	virtual void __fastcall DoEMR_MaskBlt(void);
	virtual void __fastcall DoEMR_ModifyWorldTransform(void);
	virtual void __fastcall DoEMR_MoveToEx(void);
	virtual void __fastcall DoEMR_NamedEscape(void);
	virtual void __fastcall DoEMR_OffsetClipRgn(void);
	virtual void __fastcall DoEMR_PaintRgn(void);
	virtual void __fastcall DoEMR_Pie(void);
	virtual void __fastcall DoEMR_PixelFormat(void);
	virtual void __fastcall DoEMR_PLGBlt(void);
	virtual void __fastcall DoEMR_PolyBezier(void);
	virtual void __fastcall DoEMR_PolyBezier16(void);
	virtual void __fastcall DoEMR_PolyBezierTo(void);
	virtual void __fastcall DoEMR_PolyBezierTo16(void);
	virtual void __fastcall DoEMR_PolyDraw(void);
	virtual void __fastcall DoEMR_PolyDraw16(void);
	virtual void __fastcall DoEMR_Polygon(void);
	virtual void __fastcall DoEMR_Polygon16(void);
	virtual void __fastcall DoEMR_Polyline(void);
	virtual void __fastcall DoEMR_Polyline16(void);
	virtual void __fastcall DoEMR_PolylineTo(void);
	virtual void __fastcall DoEMR_PolylineTo16(void);
	virtual void __fastcall DoEMR_PolyPolygon(void);
	virtual void __fastcall DoEMR_PolyPolygon16(void);
	virtual void __fastcall DoEMR_PolyPolyline(void);
	virtual void __fastcall DoEMR_PolyPolyline16(void);
	virtual void __fastcall DoEMR_PolyTextOutA(void);
	virtual void __fastcall DoEMR_PolyTextOutW(void);
	virtual void __fastcall DoEMR_RealizePalette(void);
	virtual void __fastcall DoEMR_Rectangle(void);
	virtual void __fastcall DoEMR_Reserved_69(void);
	virtual void __fastcall DoEMR_ResizePalette(void);
	virtual void __fastcall DoEMR_RestoreDC(void);
	virtual void __fastcall DoEMR_RoundRect(void);
	virtual void __fastcall DoEMR_SaveDC(void);
	virtual void __fastcall DoEMR_ScaleViewportExtEx(void);
	virtual void __fastcall DoEMR_ScaleWindowExtEx(void);
	virtual void __fastcall DoEMR_SelectClipPath(void);
	virtual void __fastcall DoEMR_SelectObject(void);
	virtual void __fastcall DoEMR_SelectPalette(void);
	virtual void __fastcall DoEMR_SetArcDirection(void);
	virtual void __fastcall DoEMR_SetBkColor(void);
	virtual void __fastcall DoEMR_SetBkMode(void);
	virtual void __fastcall DoEMR_SetBrushOrgEx(void);
	virtual void __fastcall DoEMR_SetColorSpace(void);
	virtual void __fastcall DoEMR_SetColorAdjustment(void);
	virtual void __fastcall DoEMR_SetDIBitsToDevice(void);
	virtual void __fastcall DoEMR_SetICMMode(void);
	virtual void __fastcall DoEMR_SetIcmProfileA(void);
	virtual void __fastcall DoEMR_SetIcmProfileW(void);
	virtual void __fastcall DoEMR_SetLayout(void);
	virtual void __fastcall DoEMR_SetLinkedUFIs(void);
	virtual void __fastcall DoEMR_SetMapMode(void);
	virtual void __fastcall DoEMR_SetMapperFlags(void);
	virtual void __fastcall DoEMR_SetMetaRgn(void);
	virtual void __fastcall DoEMR_SetMiterLimit(void);
	virtual void __fastcall DoEMR_SetPaletteEntries(void);
	virtual void __fastcall DoEMR_SetPixelV(void);
	virtual void __fastcall DoEMR_SetPolyFillMode(void);
	virtual void __fastcall DoEMR_SetRop2(void);
	virtual void __fastcall DoEMR_SetStretchBltMode(void);
	virtual void __fastcall DoEMR_SetTextAlign(void);
	virtual void __fastcall DoEMR_SetTextColor(void);
	virtual void __fastcall DoEMR_SetTextJustification(void);
	virtual void __fastcall DoEMR_SetViewPortExtEx(void);
	virtual void __fastcall DoEMR_SetViewPortOrgEx(void);
	virtual void __fastcall DoEMR_SetWindowExtEx(void);
	virtual void __fastcall DoEMR_SetWindowOrgEx(void);
	virtual void __fastcall DoEMR_SetWorldTransform(void);
	virtual void __fastcall DoEMR_SmallTextOut(void);
	virtual void __fastcall DoEMR_StartDoc(void);
	virtual void __fastcall DoEMR_StretchBlt(void);
	virtual void __fastcall DoEMR_StretchDIBits(void);
	virtual void __fastcall DoEMR_StrokeAndFillPath(void);
	virtual void __fastcall DoEMR_StrokePath(void);
	virtual void __fastcall DoEMR_TransparentBlt(void);
	virtual void __fastcall DoEMR_TransparentDIB(void);
	virtual void __fastcall DoEMR_WidenPath(void);
	virtual void __fastcall DoStart(void);
	virtual void __fastcall DoFinish(void);
	virtual void __fastcall DoUnknown(void);
	
public:
	__fastcall TEMFAbstractExport(System::Classes::TStream* InStream, System::Classes::TStream* OutStream);
	__fastcall virtual ~TEMFAbstractExport(void);
	void __fastcall PlayMetaFile(void);
	__property bool ShowComments = {read=FShowComments, write=FShowComments, nodefault};
	__property bool Formatted = {read=FFormatted, write=FFormatted, nodefault};
	__property System::WideString Parsing = {read=FParsing, write=SetParsing};
	__property bool EnableTransform = {read=FEnableTransform, write=FEnableTransform, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Classes::TMemoryStream* __fastcall CreateMetaStream(Frxclass::TfrxView* const Obj);
}	/* namespace Frxemfabstractexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEMFABSTRACTEXPORT)
using namespace Frxemfabstractexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxemfabstractexportHPP
