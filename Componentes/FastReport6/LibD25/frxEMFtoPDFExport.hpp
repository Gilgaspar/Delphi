// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEMFtoPDFExport.pas' rev: 32.00 (Windows)

#ifndef FrxemftopdfexportHPP
#define FrxemftopdfexportHPP

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
#include <frxExportHelpers.hpp>
#include <frxEMFAbstractExport.hpp>
#include <frxEMFFormat.hpp>
#include <frxExportPDFHelpers.hpp>
#include <frxClass.hpp>
#include <frxAnaliticGeometry.hpp>
#include <frxUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxemftopdfexport
{
//-- forward type declarations -----------------------------------------------
struct TBezierResult;
class DELPHICLASS TPDFDeviceContext;
class DELPHICLASS TPDFPath;
class DELPHICLASS TEMFtoPDFExport;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TBezierResult
{
public:
	Frxclass::TfrxPoint P0;
	Frxclass::TfrxPoint P1;
	Frxclass::TfrxPoint P2;
	Frxclass::TfrxPoint P3;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFDeviceContext : public Frxemfabstractexport::TDeviceContext
{
	typedef Frxemfabstractexport::TDeviceContext inherited;
	
public:
	/* TObject.Create */ inline __fastcall TPDFDeviceContext(void) : Frxemfabstractexport::TDeviceContext() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TPDFDeviceContext(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPDFPath : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStream* FOutStream;
	bool FExists;
	
protected:
	System::Classes::TMemoryStream* FStream;
	
public:
	__fastcall TPDFPath(System::Classes::TStream* AOutStream);
	__fastcall virtual ~TPDFPath(void);
	void __fastcall Put(const System::AnsiString S);
	void __fastcall Flush(void);
	__property bool Exists = {read=FExists, write=FExists, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TEMFtoPDFExport : public Frxemfabstractexport::TEMFAbstractExport
{
	typedef Frxemfabstractexport::TEMFAbstractExport inherited;
	
private:
	bool FForceMitterLineJoin;
	bool FForceButtLineCap;
	int FJPGQuality;
	bool FForceNullBrush;
	bool FTransparency;
	bool FForceAnsi;
	bool FClipped;
	void __fastcall Put(const System::AnsiString S);
	void __fastcall PutLn(const System::AnsiString S)/* overload */;
	void __fastcall PutLn(const System::UnicodeString S)/* overload */;
	System::Extended __fastcall pdfSize(System::Extended emfSize);
	Frxclass::TfrxPoint __fastcall pdfFrxPoint(const System::Types::TPoint &emfP, bool IsScalingOnly = false)/* overload */;
	Frxclass::TfrxPoint __fastcall pdfFrxPoint(System::Types::TSmallPoint emfSP, bool IsScalingOnly = false)/* overload */;
	Frxclass::TfrxPoint __fastcall pdfFrxPoint(const Frxclass::TfrxPoint &emfDP, bool IsScalingOnly = false)/* overload */;
	Frxclass::TfrxRect __fastcall pdfFrxRect(const System::Types::TRect &emfR, bool IsScalingOnly = false);
	System::UnicodeString __fastcall emfPoint2Str(const System::Types::TPoint &emfP, bool IsScalingOnly = false)/* overload */;
	System::UnicodeString __fastcall emfPoint2Str(System::Types::TSmallPoint emfSP, bool IsScalingOnly = false)/* overload */;
	System::UnicodeString __fastcall emfPoint2Str(const Frxclass::TfrxPoint &emfFP, bool IsScalingOnly = false)/* overload */;
	System::UnicodeString __fastcall emfRect2Str(const System::Types::TRect &emfR, bool IsScalingOnly = false);
	System::UnicodeString __fastcall EvenOdd(void);
	bool __fastcall IsNullBrush(void);
	bool __fastcall IsNullPen(void);
	TBezierResult __fastcall BezierCurve(const Frxclass::TfrxPoint &Center, const Frxclass::TfrxPoint &Radius, double startAngle, double arcAngle);
	void __fastcall cmd_AngleArc(const Frxclass::TfrxPoint &Center, const Frxclass::TfrxPoint &Radius, float StartAngle, float SweepAngle);
	void __fastcall cmd_RoundRect(System::Extended l, System::Extended t, System::Extended r, System::Extended b, System::Extended rx, System::Extended ry);
	void __fastcall cmdPathPainting(int Options);
	void __fastcall cmdPathParams(int Options);
	void __fastcall cmdSetClippingPath(void);
	void __fastcall cmdCloseSubpath(void);
	void __fastcall cmdAppendAngleArcToPath(const tagEMRANGLEARC &AngleArc);
	void __fastcall cmdAppendPieToPath(const tagEMRARC &Pie);
	void __fastcall cmdAppendEllipsToPath(const System::Types::TRect &emfRect);
	void __fastcall cmdAppendRectangleToPath(const System::Types::TRect &emfRect, bool IsScalingOnly = false);
	void __fastcall cmdAppendEMFRectangleToPath(const System::Types::TRect &emfRect);
	void __fastcall cmdAppendRoundRectToPath(const System::Types::TRect &emfRect, const System::Types::TSize &emfCorners);
	void __fastcall cmdMoveTo(System::Extended X, System::Extended Y)/* overload */;
	void __fastcall cmdMoveTo(const System::Types::TPoint &emfP)/* overload */;
	void __fastcall cmdMoveTo(System::Types::TSmallPoint emfSP)/* overload */;
	void __fastcall cmdMoveTo(const Frxclass::TfrxPoint &emfFP)/* overload */;
	void __fastcall cmdLineTo(System::Extended X, System::Extended Y)/* overload */;
	void __fastcall cmdLineTo(const System::Types::TPoint &emfP)/* overload */;
	void __fastcall cmdLineTo(System::Types::TSmallPoint emfSP)/* overload */;
	void __fastcall cmdLineTo(const Frxclass::TfrxPoint &emfDP)/* overload */;
	void __fastcall cmdSetLineDashPattern(unsigned PenStyle, System::Extended Width);
	void __fastcall cmdSetStrokeColor(System::Uitypes::TColor Color);
	void __fastcall cmdSetFillColor(System::Uitypes::TColor Color);
	void __fastcall cmdSetLineWidth(System::Extended Width)/* overload */;
	void __fastcall cmdSetLineWidth(System::UnicodeString PDFWidth)/* overload */;
	void __fastcall cmdSetMiterLimit(System::Extended MiterLimit);
	void __fastcall cmdSetLineCap(int PenEndCap);
	void __fastcall cmdSetLineJoin(int PenLineJoin);
	void __fastcall cmdAppendCurvedSegment2final(System::Types::TSmallPoint emfSP1, System::Types::TSmallPoint emfSP3)/* overload */;
	void __fastcall cmdAppendCurvedSegment2final(const System::Types::TPoint &emfP1, const System::Types::TPoint &emfP3)/* overload */;
	void __fastcall cmdAppendCurvedSegment3(System::Types::TSmallPoint emfSP1, System::Types::TSmallPoint emfSP2, System::Types::TSmallPoint emfSP3)/* overload */;
	void __fastcall cmdAppendCurvedSegment3(const System::Types::TPoint &emfP1, const System::Types::TPoint &emfP2, const System::Types::TPoint &emfP3)/* overload */;
	void __fastcall cmdAppendCurvedSegment3(const Frxclass::TfrxPoint &emfDP1, const Frxclass::TfrxPoint &emfDP2, const Frxclass::TfrxPoint &emfDP3)/* overload */;
	void __fastcall cmdPolyBezier(int Options = 0x0);
	void __fastcall cmdPolyBezier16(int Options = 0x0);
	void __fastcall cmdPolyLine(int Options = 0x0);
	void __fastcall cmdPolyLine16(int Options = 0x0);
	void __fastcall cmdPolyPolyLine(int Options = 0x0);
	void __fastcall cmdPolyPolyLine16(int Options = 0x0);
	void __fastcall cmdCreateExtSelectClipRgn(void);
	void __fastcall cmdSaveGraphicsState(void);
	void __fastcall cmdRestoreGraphicsState(void);
	void __fastcall cmdBitmap(const System::Types::TRect &emfRect, unsigned dwRop, Frxemfformat::TEMRBitmap* EMRBitmap);
	void __fastcall cmdTranslationAndScaling(System::Extended Sx, System::Extended Sy, System::Extended Tx, System::Extended Ty);
	
protected:
	Frxclass::TfrxRect FPDFRect;
	Frxclass::TfrxPoint FEMFtoPDFFactor;
	Frxexportpdfhelpers::TPDFObjectsHelper* FPOH;
	Frxexporthelpers::TRotation2D* FRotation2D;
	System::Classes::TStringList* FRealizationList;
	int FqQBalance;
	TPDFPath* FPath;
	bool FExtSelectClipRgnCreated;
	virtual void __fastcall Comment(System::UnicodeString CommentString = System::UnicodeString());
	void __fastcall CommentAboutRealization(void);
	void __fastcall CommentTextRect(const System::Types::TRect &rtl, System::Uitypes::TColor Color = (System::Uitypes::TColor)(0xff));
	void __fastcall RealizationListFill(System::UnicodeString *RealizedCommands, const int RealizedCommands_High);
	virtual void __fastcall DCCreate(void);
	virtual Frxemfabstractexport::TEMFFont* __fastcall FontCreate(void);
	TPDFDeviceContext* __fastcall PDFDeviceContext(void);
	void __fastcall DrawFontLines(double FontSize, const Frxclass::TfrxPoint &TextPosition, System::Extended TextWidth);
	void __fastcall DrawFigureStart(void);
	void __fastcall DrawFigureFinish(int Options);
	void __fastcall RestoreExtSelectClipRgn(void);
	int __fastcall FillStrokeOptions(int Options);
	virtual void __fastcall DoEMR_AngleArc(void);
	virtual void __fastcall DoEMR_AlphaBlend(void);
	virtual void __fastcall DoEMR_BitBlt(void);
	virtual void __fastcall DoEMR_CloseFigure(void);
	virtual void __fastcall DoEMR_Ellipse(void);
	virtual void __fastcall DoEMR_EoF(void);
	virtual void __fastcall DoEMR_ExtSelectClipRgn(void);
	virtual void __fastcall DoEMR_ExtTextOutW(void);
	virtual void __fastcall DoEMR_FillPath(void);
	virtual void __fastcall DoEMR_FillRgn(void);
	virtual void __fastcall DoEMR_Header(void);
	virtual void __fastcall DoEMR_IntersectClipRect(void);
	virtual void __fastcall DoEMR_LineTo(void);
	virtual void __fastcall DoEMR_MaskBlt(void);
	virtual void __fastcall DoEMR_MoveToEx(void);
	virtual void __fastcall DoEMR_Pie(void);
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
	virtual void __fastcall DoEMR_Rectangle(void);
	virtual void __fastcall DoEMR_RestoreDC(void);
	virtual void __fastcall DoEMR_RoundRect(void);
	virtual void __fastcall DoEMR_SaveDC(void);
	virtual void __fastcall DoEMR_SelectClipPath(void);
	virtual void __fastcall DoEMR_StretchBlt(void);
	virtual void __fastcall DoEMR_StretchDIBits(void);
	virtual void __fastcall DoEMR_StrokeAndFillPath(void);
	virtual void __fastcall DoEMR_StrokePath(void);
	virtual void __fastcall DoEMR_TransparentBlt(void);
	virtual void __fastcall DoStart(void);
	virtual void __fastcall DoFinish(void);
	
public:
	__fastcall TEMFtoPDFExport(System::Classes::TStream* InStream, System::Classes::TStream* OutStream, const Frxclass::TfrxRect &APDFRect, Frxexportpdfhelpers::TPDFObjectsHelper* APOH);
	__fastcall virtual ~TEMFtoPDFExport(void);
	__property bool ForceMitterLineJoin = {read=FForceMitterLineJoin, write=FForceMitterLineJoin, nodefault};
	__property bool ForceButtLineCap = {write=FForceButtLineCap, nodefault};
	__property int JPGQuality = {write=FJPGQuality, nodefault};
	__property bool ForceNullBrush = {write=FForceNullBrush, nodefault};
	__property bool Transparency = {write=FTransparency, nodefault};
	__property bool ForceAnsi = {write=FForceAnsi, nodefault};
	__property bool Clipped = {write=FClipped, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxemftopdfexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEMFTOPDFEXPORT)
using namespace Frxemftopdfexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxemftopdfexportHPP
