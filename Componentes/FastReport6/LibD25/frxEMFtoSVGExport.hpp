// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEMFtoSVGExport.pas' rev: 32.00 (Windows)

#ifndef FrxemftosvgexportHPP
#define FrxemftosvgexportHPP

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
#include <frxClass.hpp>
#include <frxExportHelpers.hpp>
#include <frxEMFAbstractExport.hpp>
#include <frxEMFFormat.hpp>
#include <frxUtils.hpp>
#include <frxAnaliticGeometry.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxemftosvgexport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSVGDeviceContext;
class DELPHICLASS TEMFtoSVGExport;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSVGDeviceContext : public Frxemfabstractexport::TDeviceContext
{
	typedef Frxemfabstractexport::TDeviceContext inherited;
	
protected:
	System::UnicodeString FLastClipPathName;
	System::UnicodeString FLastPatternName;
	
public:
	virtual void __fastcall CopyFrom(System::TObject* ADC);
	virtual void __fastcall Init(void);
public:
	/* TObject.Create */ inline __fastcall TSVGDeviceContext(void) : Frxemfabstractexport::TDeviceContext() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TSVGDeviceContext(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TEMFtoSVGExport : public Frxemfabstractexport::TEMFAbstractExport
{
	typedef Frxemfabstractexport::TEMFAbstractExport inherited;
	
private:
	Frxexporthelpers::TfrxCSS* FCSS;
	System::UnicodeString FPath;
	bool FEmbedded;
	System::Extended FX;
	System::Extended FY;
	bool FForceMitterLineJoin;
	bool FLinearBarcode;
	void __fastcall NextClipPath(void);
	void __fastcall NextPattern(void);
	System::UnicodeString __fastcall MeasureUnit(System::Extended r, System::UnicodeString DefaultUnits = System::UnicodeString());
	System::UnicodeString __fastcall MU(System::Extended r);
	System::UnicodeString __fastcall MeasureAngleArc(const System::Types::TPoint &Center, int Radius, float StartAngle, float SweepAngle);
	System::UnicodeString __fastcall MeasureClipPath(void);
	System::UnicodeString __fastcall MeasureDominantBaseline(void);
	System::UnicodeString __fastcall MeasureDx(Frxutils::TLongWordDinArray OutputDx, System::WideString OutputString);
	System::UnicodeString __fastcall MeasureDy(Frxutils::TLongWordDinArray OutputDy, System::WideString OutputString);
	System::UnicodeString __fastcall MeasureEllipse(const System::Types::TRect &LR);
	System::UnicodeString __fastcall MeasureEndCap(void);
	System::UnicodeString __fastcall MeasureFill(System::Byte Options);
	System::UnicodeString __fastcall MeasureFontStyle(void);
	System::UnicodeString __fastcall MeasureFontSize(void);
	System::UnicodeString __fastcall MeasureFontOrientation(const System::Types::TPoint &LP)/* overload */;
	System::UnicodeString __fastcall MeasureFontOrientation(const Frxanaliticgeometry::TDoublePoint &LP)/* overload */;
	System::UnicodeString __fastcall MeasureLine(void);
	System::UnicodeString __fastcall MeasureLineJoin(void);
	System::UnicodeString __fastcall MeasurePie(const System::Types::TRect &LR, const System::Types::TPoint &LStart, const System::Types::TPoint &LEnd);
	System::UnicodeString __fastcall MeasurePoint(const Frxclass::TfrxPoint &LP, System::Extended dX = 0.000000E+00)/* overload */;
	System::UnicodeString __fastcall MeasurePoint(const Frxanaliticgeometry::TDoublePoint &LP, System::Extended dX = 0.000000E+00)/* overload */;
	System::UnicodeString __fastcall MeasurePoint(const System::Types::TPoint &LP, System::Extended dX = 0.000000E+00)/* overload */;
	System::UnicodeString __fastcall MeasurePoint(System::Types::TSmallPoint LP, System::Extended dX = 0.000000E+00)/* overload */;
	System::UnicodeString __fastcall MeasurePolyPoints(void);
	System::UnicodeString __fastcall MeasurePoly16Points(void);
	System::UnicodeString __fastcall MeasurePolyFillMode(void);
	System::UnicodeString __fastcall MeasureStroke(System::Byte Options);
	System::UnicodeString __fastcall MeasureStrokeMiterLimit(void);
	System::UnicodeString __fastcall MeasureStrokeDasharray(void);
	System::UnicodeString __fastcall MeasureTextAnchor(void);
	System::UnicodeString __fastcall MeasureTextDecoration(void);
	System::UnicodeString __fastcall MeasureRect(const System::Types::TRect &LR, double dHeight = 0.000000E+00)/* overload */;
	System::UnicodeString __fastcall MeasureRect(int x, int y, int cx, int cy)/* overload */;
	System::UnicodeString __fastcall MeasureRectAsPath(const System::Types::TRect &LR);
	System::UnicodeString __fastcall MeasureRoundRect(const System::Types::TRect &LR, const System::Types::TSize &LS)/* overload */;
	System::UnicodeString __fastcall MeasureXY(const Frxanaliticgeometry::TDoublePoint &LP);
	System::UnicodeString __fastcall MeasureXYText(const Frxanaliticgeometry::TDoublePoint &LP)/* overload */;
	System::UnicodeString __fastcall MeasureXYText(const System::Types::TPoint &LP)/* overload */;
	System::UnicodeString __fastcall MeasureXYText(double X, double Y)/* overload */;
	System::UnicodeString __fastcall SpaceDlm(System::UnicodeString st);
	void __fastcall Puts(const System::WideString s)/* overload */;
	void __fastcall Puts(const System::WideString Fmt, const System::TVarRec *Args, const int Args_High)/* overload */;
	void __fastcall PutsA(const System::AnsiString s);
	void __fastcall PutsRaw(const System::AnsiString s);
	System::UnicodeString __fastcall CSSPaintStyleName(System::Byte Options);
	void __fastcall Do_BitMap(System::UnicodeString DestRect, unsigned dwRop, Frxemfformat::TEMRBitmap* EMRBitmap);
	void __fastcall Do_Pattern(bool XLine, bool YLine, bool Turn);
	void __fastcall Do_PolyPoly(System::UnicodeString Name, System::Byte Options);
	void __fastcall Do_PolyPoly16(System::UnicodeString Name, System::Byte Options);
	
protected:
	virtual void __fastcall Comment(System::UnicodeString CommentString = System::UnicodeString());
	Frxclass::TfrxRect __fastcall NormalizeRect(const Frxclass::TfrxRect &frxRect)/* overload */;
	virtual void __fastcall DCCreate(void);
	virtual Frxemfabstractexport::TEMFFont* __fastcall FontCreate(void);
	TSVGDeviceContext* __fastcall SVGDeviceContext(void);
	bool __fastcall IsNonZero(Frxutils::TIntegerDinArray A);
	System::UnicodeString __fastcall SureFirstM(System::UnicodeString Path);
	virtual void __fastcall DoEMR_AbortPath(void);
	virtual void __fastcall DoEMR_AlphaBlend(void);
	virtual void __fastcall DoEMR_AngleArc(void);
	virtual void __fastcall DoEMR_Arc(void);
	virtual void __fastcall DoEMR_ArcTo(void);
	virtual void __fastcall DoEMR_BeginPath(void);
	virtual void __fastcall DoEMR_BitBlt(void);
	virtual void __fastcall DoEMR_Chord(void);
	virtual void __fastcall DoEMR_CloseFigure(void);
	virtual void __fastcall DoEMR_Ellipse(void);
	virtual void __fastcall DoEMR_EoF(void);
	virtual void __fastcall DoEMR_ExtSelectClipRgn(void);
	virtual void __fastcall DoEMR_ExtTextOutA(void);
	virtual void __fastcall DoEMR_ExtTextOutW(void);
	virtual void __fastcall DoEMR_FillPath(void);
	virtual void __fastcall DoEMR_FillRgn(void);
	virtual void __fastcall DoEMR_FlattenPath(void);
	virtual void __fastcall DoEMR_FrameRgn(void);
	virtual void __fastcall DoEMR_Header(void);
	virtual void __fastcall DoEMR_IntersectClipRect(void);
	virtual void __fastcall DoEMR_LineTo(void);
	virtual void __fastcall DoEMR_MaskBlt(void);
	virtual void __fastcall DoEMR_MoveToEx(void);
	virtual void __fastcall DoEMR_PaintRgn(void);
	virtual void __fastcall DoEMR_Pie(void);
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
	virtual void __fastcall DoEMR_Rectangle(void);
	virtual void __fastcall DoEMR_RoundRect(void);
	virtual void __fastcall DoEMR_SelectClipPath(void);
	virtual void __fastcall DoEMR_SetDIBitsToDevice(void);
	virtual void __fastcall DoEMR_SetMetaRgn(void);
	virtual void __fastcall DoEMR_SetPixelV(void);
	virtual void __fastcall DoEMR_SmallTextOut(void);
	virtual void __fastcall DoEMR_StretchBlt(void);
	virtual void __fastcall DoEMR_StretchDIBits(void);
	virtual void __fastcall DoEMR_StrokeAndFillPath(void);
	virtual void __fastcall DoEMR_StrokePath(void);
	virtual void __fastcall DoEMR_TransparentBlt(void);
	virtual void __fastcall DoEMR_WidenPath(void);
	virtual void __fastcall DoStart(void);
	virtual void __fastcall DoFinish(void);
	
public:
	virtual void __fastcall AfterConstruction(void);
	void __fastcall SetEmbedded(Frxexporthelpers::TfrxCSS* CSS, Frxclass::TfrxView* Obj);
	__property bool ForceMitterLineJoin = {write=FForceMitterLineJoin, nodefault};
	__property bool LinearBarcode = {write=FLinearBarcode, nodefault};
public:
	/* TEMFAbstractExport.Create */ inline __fastcall TEMFtoSVGExport(System::Classes::TStream* InStream, System::Classes::TStream* OutStream) : Frxemfabstractexport::TEMFAbstractExport(InStream, OutStream) { }
	/* TEMFAbstractExport.Destroy */ inline __fastcall virtual ~TEMFtoSVGExport(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxemftosvgexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEMFTOSVGEXPORT)
using namespace Frxemftosvgexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxemftosvgexportHPP
