// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportPDF.pas' rev: 32.00 (Windows)

#ifndef FrxexportpdfHPP
#define FrxexportpdfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.Win.ComObj.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Imaging.jpeg.hpp>
#include <System.Variants.hpp>
#include <System.Contnrs.hpp>
#include <frxExportBaseDialog.hpp>
#include <frxClass.hpp>
#include <frxExportPDFHelpers.hpp>
#include <frxVectorCanvas.hpp>
#include <System.WideStrings.hpp>
#include <System.AnsiStrings.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------
#pragma link "usp10.lib"

namespace Frxexportpdf
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPDFPage;
class DELPHICLASS TfrxPDFAnnot;
class DELPHICLASS TfrxPDFEngineState;
class DELPHICLASS TfrxPDFExport;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxPDFEncBit : unsigned char { ePrint, eModify, eCopy, eAnnot };

typedef System::Set<TfrxPDFEncBit, TfrxPDFEncBit::ePrint, TfrxPDFEncBit::eAnnot> TfrxPDFEncBits;

class PASCALIMPLEMENTATION TfrxPDFPage : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FBackPictureVisible;
	bool FBackPictureStretched;
	double FHeight;
	
public:
	__fastcall TfrxPDFPage(Frxclass::TfrxReportPage* Page);
	__property double Height = {read=FHeight};
	__property bool BackPictureVisible = {read=FBackPictureVisible, nodefault};
	__property bool BackPictureStretched = {read=FBackPictureStretched, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFPage(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPDFAnnot : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Number;
	System::UnicodeString Rect;
	System::UnicodeString Hyperlink;
	int DestPage;
	int DestY;
public:
	/* TObject.Create */ inline __fastcall TfrxPDFAnnot(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPDFAnnot(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxPDFEngineState : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxPDFExport* FExport;
	System::Extended FHeight;
	System::Extended FMarginTop;
	System::Extended FMarginLeft;
	
public:
	__fastcall TfrxPDFEngineState(TfrxPDFExport* AExport);
	__fastcall virtual ~TfrxPDFEngineState(void);
	void __fastcall BeginBBoxMode(System::Extended Height);
	void __fastcall RestoreState(void);
};


enum DECLSPEC_DENUM TEmbeddedRelation : unsigned char { erData, erSource, erAlternative, erSupplement, erUnspecified };

enum DECLSPEC_DENUM TZUGFeRD_ConformanceLevel : unsigned char { clMINIMUM, clBASIC, clCOMFORT, clEXTENDED };

class PASCALIMPLEMENTATION TfrxPDFExport : public Frxexportbasedialog::TfrxBaseDialogExportFilter
{
	typedef Frxexportbasedialog::TfrxBaseDialogExportFilter inherited;
	
private:
	bool FCompressed;
	bool FEmbeddedFonts;
	bool FEmbedProt;
	bool FPrintOpt;
	System::Classes::TList* FPages;
	bool FOutline;
	int FQuality;
	Frxclass::TfrxCustomOutline* FPreviewOutline;
	System::WideString FSubject;
	System::WideString FAuthor;
	bool FBackground;
	System::WideString FCreator;
	bool FTags;
	bool FProtection;
	System::AnsiString FUserPassword;
	System::AnsiString FOwnerPassword;
	TfrxPDFEncBits FProtectionFlags;
	System::WideString FKeywords;
	System::WideString FTitle;
	System::WideString FProducer;
	bool FPrintScaling;
	bool FFitWindow;
	bool FHideMenubar;
	bool FCenterWindow;
	bool FHideWindowUI;
	bool FHideToolbar;
	bool FTransparency;
	bool FSaveOriginalImages;
	System::Classes::TStream* pdf;
	int FPagesNumber;
	int FStartXRef;
	Frxexportpdfhelpers::TPDFObjectsHelper* FPOH;
	System::Classes::TStringList* FPagesRef;
	System::Extended FWidth;
	System::Extended FHeight;
	System::Extended FMarginLeft;
	System::Extended FMarginTop;
	System::AnsiString FEncKey;
	System::AnsiString FOPass;
	System::AnsiString FUPass;
	unsigned FEncBits;
	System::AnsiString FFileID;
	System::Uitypes::TColor FLastColor;
	System::UnicodeString FLastColorResult;
	System::Classes::TMemoryStream* OutStream;
	System::Classes::TMemoryStream* FPageAnnots;
	System::Classes::TList* FAnnots;
	int FMetaFileId;
	int FStructId;
	int FColorProfileId;
	int FAttachmentsNamesId;
	int FAttachmentsListId;
	int FPDFviaEMF;
	bool FPdfA;
	Frxexportpdfhelpers::TPDFStandard FPDFStandard;
	Frxexportpdfhelpers::TPDFVersion FPDFVersion;
	bool FUsePNGAlpha;
	int FPictureDPI;
	bool FInteractiveForms;
	Frxexportpdfhelpers::TInt64List* FAcroFormsRefs;
	TfrxPDFEngineState* FPDFState;
	System::WideString FInteractiveFormsFontSubset;
	int __fastcall AddAcroForm(void);
	System::UnicodeString __fastcall GetPDFDash(const Frxclass::TfrxFrameStyle LineStyle, System::Extended Width);
	System::AnsiString __fastcall GetID(void);
	System::AnsiString __fastcall CryptStr(System::AnsiString Source, int id, bool IsEscapeSpecialChar = true);
	System::AnsiString __fastcall PrepareStr(const System::WideString Text, int Id);
	System::AnsiString __fastcall PrepareAnsiStr(const System::AnsiString Text, int Id);
	System::AnsiString __fastcall EscapeSpecialChar(System::AnsiString TextStr);
	System::AnsiString __fastcall StrToUTF16(const System::WideString Value);
	System::AnsiString __fastcall StrToUTF16H(const System::WideString Value);
	System::AnsiString __fastcall PMD52Str(void * p);
	System::AnsiString __fastcall PadPassword(System::AnsiString Password);
	void __fastcall PrepareKeys(void);
	void __fastcall SetProtectionFlags(const TfrxPDFEncBits Value);
	void __fastcall Clear(void);
	void __fastcall WriteFont(Frxexportpdfhelpers::TfrxPDFFont* pdfFont);
	void __fastcall AddObject(Frxclass::TfrxView* const Obj);
	System::Extended __fastcall AddMemo(Frxclass::TfrxCustomMemoView* const Memo, bool IsInteractiveMemo = false);
	void __fastcall AddMemoField(Frxclass::TfrxCustomMemoView* const Memo, bool ViaEMF);
	void __fastcall AddPictureField(Frxclass::TfrxView* const Obj);
	void __fastcall AddCheckBoxField(Frxclass::TfrxView* const Obj, bool ViaEMF);
	void __fastcall AddLine(Frxclass::TfrxCustomLineView* const Line);
	void __fastcall AddShape(Frxclass::TfrxShapeView* const Shape);
	void __fastcall AddCheckBox(Frxclass::TfrxView* const Obj, bool IsInteractiveCB = false);
	void __fastcall AddViaEMF(Frxclass::TfrxView* const Obj, bool IsInBBOX = false);
	int __fastcall AddAsPicture(Frxclass::TfrxView* const Obj);
	void __fastcall CreateColorMask(Frxclass::TfrxView* Obj, System::Uitypes::TColor TransparentColorMask, System::Extended Scale, const System::Types::TPoint &Offset, Vcl::Graphics::TBitmap* TempBitmap, Frxexportpdfhelpers::TMaskArray &MaskBytes);
	void __fastcall CreatePNGMask(Frxclass::TfrxPictureView* PictObj, System::Extended Scale, const System::Types::TPoint &Offset, Vcl::Graphics::TBitmap* TempBitmap, Frxexportpdfhelpers::TMaskArray &MaskBytes);
	TfrxPDFPage* __fastcall AddPage(Frxclass::TfrxReportPage* Page);
	System::UnicodeString __fastcall GetPDFColor(const System::Uitypes::TColor Color);
	void __fastcall AddAttachments(void);
	void __fastcall AddEmbeddedFileItem(System::TObject* EmbeddedFile);
	void __fastcall AddStructure(void);
	void __fastcall AddMetaData(void);
	void __fastcall AddColorProfile(void);
	void __fastcall WritePDFStream(System::Classes::TStream* Target, System::Classes::TStream* Source, int id, bool Compressed, bool Encrypted, bool startingBrackets, bool endingBrackets, bool enableLength2);
	void __fastcall SetEmbeddedFonts(const bool Value);
	Frxclass::TfrxRect __fastcall GetRect(Frxclass::TfrxView* Obj);
	Frxclass::TfrxRect __fastcall GetClipRect(Frxclass::TfrxView* Obj, bool Internal = false);
	Frxclass::TfrxRect __fastcall GetDMPRect(const Frxclass::TfrxRect &R);
	Frxclass::TfrxRect __fastcall GetRectEMFExport(Frxclass::TfrxView* Obj);
	void __fastcall Cmd(const System::UnicodeString Args);
	void __fastcall Cmd_ObjPath(Frxclass::TfrxView* Obj);
	void __fastcall Cmd_RoundRectanglePath(Frxclass::TfrxShapeView* RoundedRect);
	void __fastcall Cmd_EllipsePath(Frxclass::TfrxShapeView* Ellipse);
	void __fastcall Cmd_TrianglePath(Frxclass::TfrxShapeView* Triangle);
	void __fastcall Cmd_DiamondPath(Frxclass::TfrxShapeView* Diamond);
	void __fastcall Cmd_ClipObj(Frxclass::TfrxView* Obj);
	void __fastcall Cmd_FillObj(Frxclass::TfrxView* Obj, System::Uitypes::TColor Color);
	void __fastcall Cmd_FillBrush(Frxclass::TfrxView* Obj, Frxclass::TfrxBrushFill* BrushFill);
	void __fastcall Cmd_FillGlass(Frxclass::TfrxView* Obj, Frxclass::TfrxGlassFill* GlassFill);
	void __fastcall Cmd_FillGradient(Frxclass::TfrxView* Obj, Frxclass::TfrxGradientFill* GradientFill);
	void __fastcall Cmd_Hatch(Frxclass::TfrxView* Obj, System::Uitypes::TColor Color, Vcl::Graphics::TBrushStyle Style);
	void __fastcall Cmd_ClipRect(Frxclass::TfrxView* Obj);
	Frxexportpdfhelpers::TfrxPDFFont* __fastcall Cmd_Font(Frxclass::TfrxView* Obj)/* overload */;
	Frxexportpdfhelpers::TfrxPDFFont* __fastcall Cmd_Font(Vcl::Graphics::TFont* Font)/* overload */;
	void __fastcall CmdMoveTo(System::Extended x, System::Extended y);
	void __fastcall CmdLineTo(System::Extended x, System::Extended y);
	void __fastcall CmdCurveTo(System::Extended x1, System::Extended y1, System::Extended x2, System::Extended y2, System::Extended x3, System::Extended y3);
	void __fastcall CmdFillColor(System::Uitypes::TColor Color);
	void __fastcall CmdStrokeColor(System::Uitypes::TColor Color);
	void __fastcall CmdStroke(void);
	void __fastcall CmdLineWidth(System::Extended Value);
	bool __fastcall IsInteractiveField(Frxclass::TfrxView* Obj);
	System::Extended __fastcall pdfX(System::Extended x);
	System::Extended __fastcall pdfY(System::Extended y);
	System::Extended __fastcall pdfSize(System::Extended Size);
	Frxclass::TfrxPoint __fastcall pdfPoint(System::Extended x, System::Extended y);
	void __fastcall StartBBoxMode(Frxclass::TfrxView* const Obj);
	System::UnicodeString __fastcall EndBBoxMode(void);
	void __fastcall SetPDFStandard(const Frxexportpdfhelpers::TPDFStandard Value);
	void __fastcall SetPDFVersion(const Frxexportpdfhelpers::TPDFVersion Value);
	void __fastcall SetTransparency(const bool Value);
	void __fastcall SetPdfA(const bool Value);
	void __fastcall SetPictureDPI(const int Value);
	void __fastcall SetSaveOriginalImages(const bool Value);
	void __fastcall SetInteractiveForms(const bool Value);
	
protected:
	Frxclass::TfrxRect FPageRect;
	System::UnicodeString stLeft;
	System::UnicodeString stRight;
	System::UnicodeString stTop;
	System::UnicodeString stBottom;
	System::Contnrs::TObjectList* FEmbeddedFiles;
	System::UnicodeString FZUGFeRDDescription;
	System::TDateTime FCreationDateTime;
	bool __fastcall IsAddViaEMF(Frxclass::TfrxView* const Obj);
	void __fastcall AddAsPictureOld(Frxclass::TfrxView* const Obj);
	void __fastcall DoFill(Frxclass::TfrxView* const Obj);
	void __fastcall DoFrame(Frxclass::TfrxFrame* const aFrame, const Frxclass::TfrxRect &aRect);
	System::UnicodeString __fastcall STpdfPoint(System::Extended x, System::Extended y);
	System::UnicodeString __fastcall STpdfSize(System::Extended Size);
	System::UnicodeString __fastcall STpdfRect(System::Extended x, System::Extended y, System::Extended Width, System::Extended Height);
	void __fastcall ExportViaVector(Frxclass::TfrxCustomMemoView* const Memo);
	void __fastcall Vector_ExtTextOut(Frxclass::TfrxCustomMemoView* Memo, Frxvectorcanvas::TVector_ExtTextOut* Vector);
	
public:
	__fastcall virtual TfrxPDFExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxPDFExport(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__classmethod virtual Frxexportbasedialog::TfrxBaseExportDialogClass __fastcall ExportDialogClass();
	virtual bool __fastcall Start(void);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	virtual void __fastcall Finish(void);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall BeginClip(Frxclass::TfrxView* Obj);
	virtual void __fastcall EndClip(void);
	void __fastcall AddEmbeddedFile(System::UnicodeString Name, System::UnicodeString Description, System::TDateTime ModDate, TEmbeddedRelation Relation, System::UnicodeString MIME, System::Classes::TStream* FileStream);
	void __fastcall AddEmbeddedXML(System::UnicodeString Name, System::UnicodeString Description, System::TDateTime ModDate, System::Classes::TStream* FileStream, TZUGFeRD_ConformanceLevel ZUGFeRDLevel = (TZUGFeRD_ConformanceLevel)(0x1), const System::UnicodeString ZUGFeRDDescription = System::UnicodeString());
	bool __fastcall IsPDFA(void);
	bool __fastcall IsPDFA_1(void);
	__property bool SaveOriginalImages = {read=FSaveOriginalImages, write=SetSaveOriginalImages, nodefault};
	__property int PictureDPI = {read=FPictureDPI, write=SetPictureDPI, nodefault};
	__property bool UsePNGAlpha = {read=FUsePNGAlpha, write=FUsePNGAlpha, nodefault};
	
__published:
	__property bool Compressed = {read=FCompressed, write=FCompressed, default=1};
	__property bool EmbeddedFonts = {read=FEmbeddedFonts, write=SetEmbeddedFonts, default=0};
	__property bool EmbedFontsIfProtected = {read=FEmbedProt, write=FEmbedProt, default=1};
	__property bool InteractiveForms = {read=FInteractiveForms, write=SetInteractiveForms, default=0};
	__property System::WideString InteractiveFormsFontSubset = {read=FInteractiveFormsFontSubset, write=FInteractiveFormsFontSubset};
	__property OpenAfterExport;
	__property bool PrintOptimized = {read=FPrintOpt, write=FPrintOpt, nodefault};
	__property bool Outline = {read=FOutline, write=FOutline, nodefault};
	__property bool Background = {read=FBackground, write=FBackground, nodefault};
	__property bool HTMLTags = {read=FTags, write=FTags, nodefault};
	__property OverwritePrompt;
	__property int Quality = {read=FQuality, write=FQuality, nodefault};
	__property bool Transparency = {read=FTransparency, write=SetTransparency, nodefault};
	__property System::WideString Title = {read=FTitle, write=FTitle};
	__property System::WideString Author = {read=FAuthor, write=FAuthor};
	__property System::WideString Subject = {read=FSubject, write=FSubject};
	__property System::WideString Keywords = {read=FKeywords, write=FKeywords};
	__property System::WideString Creator = {read=FCreator, write=FCreator};
	__property System::WideString Producer = {read=FProducer, write=FProducer};
	__property System::AnsiString UserPassword = {read=FUserPassword, write=FUserPassword};
	__property System::AnsiString OwnerPassword = {read=FOwnerPassword, write=FOwnerPassword};
	__property TfrxPDFEncBits ProtectionFlags = {read=FProtectionFlags, write=SetProtectionFlags, nodefault};
	__property bool HideToolbar = {read=FHideToolbar, write=FHideToolbar, nodefault};
	__property bool HideMenubar = {read=FHideMenubar, write=FHideMenubar, nodefault};
	__property bool HideWindowUI = {read=FHideWindowUI, write=FHideWindowUI, nodefault};
	__property bool FitWindow = {read=FFitWindow, write=FFitWindow, nodefault};
	__property bool CenterWindow = {read=FCenterWindow, write=FCenterWindow, nodefault};
	__property bool PrintScaling = {read=FPrintScaling, write=FPrintScaling, nodefault};
	__property bool PdfA = {read=FPdfA, write=SetPdfA, nodefault};
	__property Frxexportpdfhelpers::TPDFStandard PDFStandard = {read=FPDFStandard, write=SetPDFStandard, nodefault};
	__property Frxexportpdfhelpers::TPDFVersion PDFVersion = {read=FPDFVersion, write=SetPDFVersion, nodefault};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxPDFExport(void) : Frxexportbasedialog::TfrxBaseDialogExportFilter() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetLineColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetLineWidth(double Width);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfStrokeRect(const Frxclass::TfrxRect &R, System::Uitypes::TColor Color, System::Extended LineWidth);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfFillRect(const Frxclass::TfrxRect &R, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfSetColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfStroke(void);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfFill(void);
extern DELPHI_PACKAGE System::AnsiString __fastcall pdfPoint(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfLine(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfMove(double x, double y);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::AnsiString __fastcall PdfString(const System::WideString Str);
}	/* namespace Frxexportpdf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTPDF)
using namespace Frxexportpdf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportpdfHPP
