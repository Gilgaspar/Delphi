// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportZPL.pas' rev: 32.00 (Windows)

#ifndef FrxexportzplHPP
#define FrxexportzplHPP

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
#include <frxExportZPLDialog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexportzpl
{
//-- forward type declarations -----------------------------------------------
struct TZplScale;
class DELPHICLASS TfrxZPLExport;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TZplDensity : unsigned char { d6_dpmm_152_dpi, d8_dpmm_203_dpi, d12_dpmm_300_dpi, d24_dpmm_600_dpi, test1to1 };

struct DECLSPEC_DRECORD TZplScale
{
public:
	double PageScale;
	double BarcodeScale;
	int TwoDCodeScale;
};


class PASCALIMPLEMENTATION TfrxZPLExport : public Frxexportbasedialog::TfrxBaseDialogExportFilter
{
	typedef Frxexportbasedialog::TfrxBaseDialogExportFilter inherited;
	
private:
	Frxclass::TfrxReportPage* FPage;
	bool FPrintAsBitmap;
	bool FBMillimeters;
	bool FBreakLines;
	bool FHexText;
	System::Classes::TStream* Exp;
	double FFontScale;
	double leftMargin;
	double topMargin;
	Vcl::Graphics::TBitmap* PageBitmap;
	TZplDensity FZplDensity;
	
public:
	System::UnicodeString PrinterInit;
	System::UnicodeString CodePage;
	System::UnicodeString PrinterFinish;
	System::UnicodeString PageInit;
	System::UnicodeString PrinterFont;
	System::Byte scaleIndex;
	
private:
	void __fastcall ZWrite(System::UnicodeString s);
	void __fastcall ZWriteLn(System::UnicodeString s);
	void __fastcall ZFDWriteLn(System::UnicodeString s, System::UnicodeString prefix = System::UnicodeString());
	void __fastcall SetPosition(int left, int top);
	void __fastcall SetTextAttributes(int width, int lines, int leading, Frxclass::TfrxHAlign HAlign, int gap);
	void __fastcall DrawRectangle(int width, int height, int lineWidth);
	void __fastcall DrawEllipse(int width, int height, int lineWidth);
	void __fastcall DrawLine(int width, int height, int lineWidth, bool direction);
	void __fastcall DrawText(int fontHeight, int fontWidth, System::UnicodeString text);
	void __fastcall DrawPictureObject(Frxclass::TfrxPictureView* pic);
	void __fastcall DrawBorders(Frxclass::TfrxFrame* Frame, double AbsLeft, double AbsTop, double Width, double Height);
	void __fastcall DrawBWPicture(Vcl::Graphics::TBitmap* tbm);
	void __fastcall WriteRotation(int rot);
	void __fastcall ExportTextObject(Frxclass::TfrxCustomMemoView* FfrxCMV);
	void __fastcall ExportRectangle(double Left, double Top, double Width, double Height, double LineWidth);
	void __fastcall ExportEllipse(double Left, double Top, double Width, double Height, double LineWidth);
	void __fastcall ExportLine(double Left, double Top, double Width, double Height, double LineWidth);
	void __fastcall ExportPicture(Frxclass::TfrxPictureView* pic);
	void __fastcall ExportLineObject(Frxclass::TfrxLineView* line);
	void __fastcall ExportBarcodeObject(Frxbarcode::TfrxBarCodeView* b);
	void __fastcall Export2DBarcodeObject(Frxbarcode2d::TfrxBarcode2DView* b);
	void __fastcall ExportShapeObject(Frxclass::TfrxShapeView* ShapeObject);
	int __fastcall GetWidth(double width, double height, int rotation);
	int __fastcall GetTop(double top);
	int __fastcall GetHeight(double width, double height, int rotation);
	int __fastcall GetLeft(double left);
	System::UnicodeString __fastcall GetZPLText(System::UnicodeString source);
	
public:
	__fastcall virtual TfrxZPLExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxZPLExport(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__classmethod virtual Frxexportbasedialog::TfrxBaseExportDialogClass __fastcall ExportDialogClass();
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	void __fastcall SetFZplDensity(TZplDensity ZPLD);
	
__published:
	__property bool PrintAsBitmap = {read=FPrintAsBitmap, write=FPrintAsBitmap, default=1};
	__property bool BMillimeters = {read=FBMillimeters, write=FBMillimeters, default=1};
	__property bool BreakLines = {read=FBreakLines, write=FBreakLines, default=1};
	__property double FontScale = {read=FFontScale, write=FFontScale};
	__property TZplDensity ZplDensity = {read=FZplDensity, write=SetFZplDensity, default=1};
	__property bool HexText = {read=FHexText, write=FHexText, default=0};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxZPLExport(void) : Frxexportbasedialog::TfrxBaseDialogExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE double defaultFontScale;
extern DELPHI_PACKAGE System::UnicodeString Dictionary;
extern DELPHI_PACKAGE System::StaticArray<int, 39> counts;
extern DELPHI_PACKAGE System::StaticArray<TZplScale, 5> ZplScale;
extern DELPHI_PACKAGE void __fastcall WriteToPrinter(int PrinterIndex, System::UnicodeString PrinterName, System::UnicodeString SText)/* overload */;
extern DELPHI_PACKAGE void __fastcall WriteToPrinter(int PrinterIndex, System::UnicodeString PrinterName, System::Classes::TMemoryStream* mem)/* overload */;
}	/* namespace Frxexportzpl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTZPL)
using namespace Frxexportzpl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportzplHPP
