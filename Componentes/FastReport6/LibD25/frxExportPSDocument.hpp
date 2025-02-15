// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportPSDocument.pas' rev: 32.00 (Windows)

#ifndef FrxexportpsdocumentHPP
#define FrxexportpsdocumentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <frxExportBaseDialog.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <frxClass.hpp>
#include <frxExportMatrix.hpp>
#include <System.Math.hpp>
#include <frxBarcod.hpp>
#include <frxBarcode.hpp>
#include <frxBarcode2D.hpp>
#include <frxBarcodeMaxiCode.hpp>
#include <frxTableObject.hpp>
#include <frxRes.hpp>
#include <frxImageConverter.hpp>
#include <frxExportPSHelper.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexportpsdocument
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS PSDocument;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION PSDocument : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	System::UnicodeString psData;
	double windowWidth;
	double windowHeight;
	virtual void __fastcall CreateWindow(System::UnicodeString name, double Width, double Height);
	void __fastcall createText(double x, double y, Frxclass::TfrxHAlign HorizontalAlignment, Frxclass::TfrxVAlign VerticalAlignment, double Width, double Height, Vcl::Graphics::TFont* font, System::UnicodeString textstr, double PaddingLeft, double PaddingRight, double PaddingTop, double PaddingBottom, double BorderThickness, System::UnicodeString Foreground, System::UnicodeString Background, double Angle, double Indent);
	Frxexportpshelper::AOF __fastcall TextAlignments(double x, double &y, Frxclass::TfrxHAlign HorizontalAlignment, Frxclass::TfrxVAlign VerticalAlignment, double Width, double Height, Vcl::Graphics::TFont* font, System::Classes::TStringList* txt_lns, double PaddingLeft, double PaddingRight, double PaddingTop, double PaddingBottom, double BorderThikness);
	void __fastcall MoveTo(double x, double y);
	void __fastcall AppendLine(double x2, double y2);
	void __fastcall StartFig(double StrokeThickness);
	System::UnicodeString __fastcall PSFont(System::UnicodeString font);
	void __fastcall EndFig(System::UnicodeString stroke);
	System::UnicodeString __fastcall ColorToPsRgb(System::UnicodeString htmlcolor);
	System::UnicodeString __fastcall FloatToString(double flt);
	
public:
	virtual void __fastcall AddPage(void);
	void __fastcall PSWrite(System::UnicodeString s);
	void __fastcall PSWriteLn(System::UnicodeString s);
	void __fastcall Convert(double &left, double &top, double &width, double &height);
	void __fastcall AddTextLine(Frxexportpshelper::AOF t_x, double t_y, System::UnicodeString Foreground, Vcl::Graphics::TFont* font, double Width, double Height, System::Classes::TStringList* txt_lns, double Angle, double Indent);
	void __fastcall AddRectangle(double x, double y, double Width, double Height, System::UnicodeString Stroke, double StrokeThickness, System::UnicodeString Fill, bool Rounded);
	void __fastcall AddEllipse(double x, double y, double Width, double Height, System::UnicodeString Stroke, double StrokeThickness, System::UnicodeString Fill);
	void __fastcall AddTriangle(double x, double y, double Width, double Height, System::UnicodeString Stroke, double StrokeThickness, System::UnicodeString Fill);
	void __fastcall AddDiamond(double x, double y, double Width, double Height, System::UnicodeString Stroke, double StrokeThickness, System::UnicodeString Fill);
	void __fastcall AddLine(double x, double y, double x2, double y2, System::UnicodeString Stroke, double StrokeThickness, Frxclass::TfrxFrameStyle dash)/* overload */;
	void __fastcall AddLine(double x, double y, double x2, double y2, System::UnicodeString Stroke, double StrokeThickness)/* overload */;
	void __fastcall AddBezier(double x, double y, const System::Types::TPoint &p0, const System::Types::TPoint &p1, const System::Types::TPoint &p2, const System::Types::TPoint &p3, System::UnicodeString Stroke, double StrokeThickness);
	void __fastcall AddImage(System::UnicodeString data, double left, double top, double width, double height, int pwidth, int pheight, bool Involve = true);
	void __fastcall AddTextObject(double x, double y, double Width, double Height, Frxclass::TfrxHAlign HorizontalAlignment, Frxclass::TfrxVAlign VerticalAlignment, System::UnicodeString BorderBrush, double BorderThickness, double LeftLine, double TopLine, double RightLine, double BottomLine, Frxclass::TfrxFrameStyle LeftLineDashStile, Frxclass::TfrxFrameStyle TopLineDashStile, Frxclass::TfrxFrameStyle RightLineDashStile, Frxclass::TfrxFrameStyle BottomLineDashStile, System::UnicodeString colorLeftLine, System::UnicodeString colorTopLine, System::UnicodeString colorRightLine, System::UnicodeString colorBottomLine, bool Shadow, System::UnicodeString ShadowColor, double ShadowWidth, System::UnicodeString Background, Frxclass::TfrxFrameTypes Typ, System::UnicodeString Text, System::UnicodeString Foreground,
		double PaddingLeft, double PaddingTop, double PaddingRight, double PaddingBottom, bool WordWrap, double Angle, bool Glass, System::UnicodeString colorTop, Vcl::Graphics::TFont* font, double FIndent);
	__fastcall PSDocument(void)/* overload */;
	__fastcall PSDocument(System::UnicodeString name, double Width, double Height)/* overload */;
	virtual void __fastcall Save(System::Classes::TStream* stream)/* overload */;
	virtual void __fastcall Save(System::UnicodeString fn)/* overload */;
	virtual void __fastcall Finish(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~PSDocument(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportpsdocument */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTPSDOCUMENT)
using namespace Frxexportpsdocument;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportpsdocumentHPP
