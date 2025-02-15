// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportPS.pas' rev: 32.00 (Windows)

#ifndef FrxexportpsHPP
#define FrxexportpsHPP

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
#include <frxExportPSDialog.hpp>
#include <frxImageConverter.hpp>
#include <frxExportPSDocument.hpp>
#include <frxStorage.hpp>
#include <frxExportPSHelper.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexportps
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPSExport;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxPSExport : public Frxexportbasedialog::TfrxBaseDialogExportFilter
{
	typedef Frxexportbasedialog::TfrxBaseDialogExportFilter inherited;
	
protected:
	System::UnicodeString FPath;
	System::UnicodeString fileNameWOext;
	System::UnicodeString extension;
	System::UnicodeString pageFileName;
	double FIndent;
	bool FPictures;
	bool FHasMultipleFiles;
	bool FIncludeImages;
	Frxexportpshelper::PSImageFormat FPSImageFormat;
	Frxexportpsdocument::PSDocument* ps;
	Frxstorage::TListStreamHashTable* images;
	System::UnicodeString __fastcall GetImageFormat(void);
	Frximageconverter::TfrxPictureType __fastcall RadGetImageFormat(void);
	void __fastcall SaveImgsToFiles(void);
	System::Uitypes::TColor __fastcall GetBlendColor(System::Uitypes::TColor c, double Blend);
	void __fastcall DrawArrow(double AWidth, double AHeight, double lineWidth, double x1, double y1, double x2, double y2, double &x3, double &y3, double &x4, double &y4);
	void __fastcall NormalizeBackgroundColor(Frxclass::TfrxView* obj, System::UnicodeString &Background);
	void __fastcall NormalizeColor(Frxclass::TfrxShapeView* obj, System::UnicodeString &BorderBrush, System::UnicodeString &Background);
	void __fastcall AddPictureObject(Frxexportpsdocument::PSDocument* ps, Frxclass::TfrxPictureView* obj);
	void __fastcall AddLine(Frxexportpsdocument::PSDocument* ps, Frxclass::TfrxLineView* line);
	void __fastcall AddShape(Frxexportpsdocument::PSDocument* ps, Frxclass::TfrxShapeView* shape);
	void __fastcall AddTextObject(Frxexportpsdocument::PSDocument* ps, Frxclass::TfrxCustomMemoView* text, bool Band);
	
public:
	virtual bool __fastcall Start(void);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall Finish(void);
	__fastcall virtual TfrxPSExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxPSExport(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__classmethod virtual Frxexportbasedialog::TfrxBaseExportDialogClass __fastcall ExportDialogClass();
	
__published:
	__property double Indent = {read=FIndent, write=FIndent};
	__property bool Pictures = {read=FPictures, write=FPictures, nodefault};
	__property bool IncludeImages = {read=FIncludeImages, write=FIncludeImages, nodefault};
	__property Frxexportpshelper::PSImageFormat ImageFormat = {read=FPSImageFormat, write=FPSImageFormat, nodefault};
	__property bool HasMultipleFiles = {read=FHasMultipleFiles, write=FHasMultipleFiles, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxPSExport(void) : Frxexportbasedialog::TfrxBaseDialogExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportps */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTPS)
using namespace Frxexportps;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportpsHPP
