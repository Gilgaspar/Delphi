// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportHTML.pas' rev: 32.00 (Windows)

#ifndef FrxexporthtmlHPP
#define FrxexporthtmlHPP

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
#include <frxClass.hpp>
#include <Vcl.Imaging.jpeg.hpp>
#include <frxExportMatrix.hpp>
#include <frxProgress.hpp>
#include <System.Variants.hpp>
#include <frxExportImage.hpp>
#include <frxImageConverter.hpp>
#include <frxExportBaseDialog.hpp>
#include <frxExportHelpers.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexporthtml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxHTMLExport;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TfrxHTMLExportImage)(Vcl::Graphics::TGraphic* Image, Frximageconverter::TfrxPictureType PicType, System::UnicodeString &FileName);

class PASCALIMPLEMENTATION TfrxHTMLExport : public Frxexportbasedialog::TfrxBaseDialogExportFilter
{
	typedef Frxexportbasedialog::TfrxBaseDialogExportFilter inherited;
	
private:
	System::Classes::TStream* Exp;
	bool FAbsLinks;
	int FCurrentPage;
	bool FExportPictures;
	bool FExportStyles;
	bool FFixedWidth;
	Frxexportmatrix::TfrxIEMatrix* FMatrix;
	bool FMozillaBrowser;
	bool FMultipage;
	bool FNavigator;
	bool FPicsInSameFolder;
	int FPicturesCount;
	Frxprogress::TfrxProgress* FProgress;
	bool FServer;
	System::UnicodeString FPrintLink;
	System::UnicodeString FRefreshLink;
	bool FBackground;
	Vcl::Graphics::TBitmap* FBackImage;
	bool FBackImageExist;
	System::UnicodeString FReportPath;
	bool FCentered;
	bool FEmptyLines;
	System::UnicodeString FURLTarget;
	Frximageconverter::TfrxPictureType FPictureType;
	bool FOutline;
	Frxclass::TfrxCustomOutline* FPreviewOutline;
	Frxexporthelpers::TfrxHTMLOutlineNode* FOutlineTree;
	Frxexporthelpers::TfrxHTMLOutlineNode* FOutlineTreeNode;
	bool FPrint;
	bool FUseTemplates;
	Frxexporthelpers::TfrxHTMLExportGetNavTemplate FGetNavTemplate;
	Frxexporthelpers::TfrxHTMLExportGetMainTemplate FGetMainTemplate;
	Frxexporthelpers::TfrxHTMLExportGetToolbarTemplate FGetToolbarTemplate;
	TfrxHTMLExportImage FExportImage;
	System::Classes::TStrings* FHTMLDocumentBegin;
	System::Classes::TStrings* FHTMLDocumentBody;
	System::Classes::TStrings* FHTMLDocumentEnd;
	void __fastcall WriteExpLn(const System::UnicodeString str);
	void __fastcall WriteExpLnA(const System::AnsiString str);
	void __fastcall ExportPage(void);
	System::UnicodeString __fastcall ChangeReturns(const System::UnicodeString Str, bool ParagraphEnd = false);
	System::WideString __fastcall TruncReturns(const System::WideString Str);
	System::UnicodeString __fastcall GetPicsFolder(void);
	System::UnicodeString __fastcall GetPicsFolderRel(void);
	System::UnicodeString __fastcall GetFrameFolder(void);
	System::UnicodeString __fastcall HTMLCodeStr(const System::UnicodeString Str);
	void __fastcall SetMultipage(const bool Value);
	
protected:
	virtual void __fastcall AfterFinish(void);
	
public:
	__fastcall virtual TfrxHTMLExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxHTMLExport(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__classmethod virtual Frxexportbasedialog::TfrxBaseExportDialogClass __fastcall ExportDialogClass();
	__property bool Server = {read=FServer, write=FServer, nodefault};
	__property System::UnicodeString PrintLink = {read=FPrintLink, write=FPrintLink};
	__property System::UnicodeString RefreshLink = {read=FRefreshLink, write=FRefreshLink};
	__property System::UnicodeString ReportPath = {read=FReportPath, write=FReportPath};
	__property bool UseTemplates = {read=FUseTemplates, write=FUseTemplates, nodefault};
	__property Frxexporthelpers::TfrxHTMLExportGetMainTemplate OnGetMainTemplate = {read=FGetMainTemplate, write=FGetMainTemplate};
	__property Frxexporthelpers::TfrxHTMLExportGetToolbarTemplate OnGetToolbarTemplate = {read=FGetToolbarTemplate, write=FGetToolbarTemplate};
	__property Frxexporthelpers::TfrxHTMLExportGetNavTemplate OnGetNavTemplate = {read=FGetNavTemplate, write=FGetNavTemplate};
	__property TfrxHTMLExportImage OnExportImage = {read=FExportImage, write=FExportImage};
	
__published:
	__property OpenAfterExport;
	__property bool FixedWidth = {read=FFixedWidth, write=FFixedWidth, default=0};
	__property bool ExportPictures = {read=FExportPictures, write=FExportPictures, default=1};
	__property bool PicsInSameFolder = {read=FPicsInSameFolder, write=FPicsInSameFolder, default=0};
	__property bool ExportStyles = {read=FExportStyles, write=FExportStyles, default=1};
	__property bool Navigator = {read=FNavigator, write=FNavigator, default=0};
	__property bool Multipage = {read=FMultipage, write=SetMultipage, default=0};
	__property bool MozillaFrames = {read=FMozillaBrowser, write=FMozillaBrowser, default=0};
	__property bool AbsLinks = {read=FAbsLinks, write=FAbsLinks, default=0};
	__property bool Background = {read=FBackground, write=FBackground, nodefault};
	__property bool Centered = {read=FCentered, write=FCentered, nodefault};
	__property bool EmptyLines = {read=FEmptyLines, write=FEmptyLines, nodefault};
	__property OverwritePrompt;
	__property System::Classes::TStrings* HTMLDocumentBegin = {read=FHTMLDocumentBegin};
	__property System::Classes::TStrings* HTMLDocumentBody = {read=FHTMLDocumentBody};
	__property System::Classes::TStrings* HTMLDocumentEnd = {read=FHTMLDocumentEnd};
	__property System::UnicodeString URLTarget = {read=FURLTarget, write=FURLTarget};
	__property bool Print = {read=FPrint, write=FPrint, nodefault};
	__property Frximageconverter::TfrxPictureType PictureType = {read=FPictureType, write=FPictureType, nodefault};
	__property bool Outline = {read=FOutline, write=FOutline, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxHTMLExport(void) : Frxexportbasedialog::TfrxBaseDialogExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexporthtml */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTHTML)
using namespace Frxexporthtml;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexporthtmlHPP
