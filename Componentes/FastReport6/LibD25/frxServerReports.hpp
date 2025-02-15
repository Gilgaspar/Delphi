// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerReports.pas' rev: 32.00 (Windows)

#ifndef FrxserverreportsHPP
#define FrxserverreportsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <frxClass.hpp>
#include <frxExportHTML.hpp>
#include <frxExportRTF.hpp>
#include <Vcl.StdCtrls.hpp>
#include <frxExportText.hpp>
#include <frxExportCSV.hpp>
#include <frxExportPDF.hpp>
#include <frxExportXML.hpp>
#include <frxExportImage.hpp>
#include <frxVariables.hpp>
#include <frxExportHTMLDiv.hpp>
#include <frxXML.hpp>
#include <frxServerForms.hpp>
#include <frxServerCache.hpp>
#include <frxDCtrl.hpp>
#include <frxServerUtils.hpp>
#include <frxNetUtils.hpp>
#include <frxExportHelpers.hpp>
#include <frxUnicodeUtils.hpp>
#include <frxServerLog.hpp>
#include <frxExportODF.hpp>
#include <frxServerPrinter.hpp>
#include <frxServerTemplates.hpp>
#include <frxImageConverter.hpp>
#include <frxExportBIFF.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxserverreports
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxReportSession;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxReportSession : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	System::UnicodeString FPath;
	System::UnicodeString FBasePath;
	System::UnicodeString FSessionId;
	System::UnicodeString FReportPath;
	System::UnicodeString FPageRange;
	Frxserverutils::TfrxServerFormat FFormat;
	System::UnicodeString FMainDocument;
	System::UnicodeString FName;
	Frxvariables::TfrxVariables* FVariables;
	bool FReportErrors;
	System::UnicodeString FError;
	System::UnicodeString FResultPage;
	Frxclass::TfrxReport* FReport;
	Frxexporthtml::TfrxHTMLExport* FHTMLExport;
	Frxexporthtmldiv::TfrxHTML5DivExport* FHTMLDivExport;
	Frxexportxml::TfrxXMLExport* FXMLExport;
	Frxexportrtf::TfrxRTFExport* FRTFExport;
	Frxexporttext::TfrxSimpleTextExport* FTXTExport;
	Frxexportimage::TfrxJPEGExport* FJPGExport;
	Frxexportimage::TfrxBMPExport* FBMPExport;
	Frxexportimage::TfrxTIFFExport* FTIFFExport;
	Frxexportpdf::TfrxPDFExport* FPDFExport;
	Frxexportcsv::TfrxCSVExport* FCSVExport;
	Frxexportodf::TfrxODSExport* FODSExport;
	Frxexportodf::TfrxODTExport* FODTExport;
	Frxexportimage::TfrxGIFExport* FGIFExport;
	Frxexportbiff::TfrxBIFFExport* FXLSExport;
	System::Classes::TThread* FParentThread;
	Frxclass::TfrxDialogPage* CurPage;
	System::Classes::TComponent* FParentReportServer;
	bool FCached;
	bool FNativeClient;
	System::Classes::TMemoryStream* FStream;
	System::UnicodeString FCacheId;
	System::UnicodeString FPassword;
	bool FAuth;
	System::UnicodeString FMessage;
	bool FPageNav;
	bool FMultipage;
	System::UnicodeString FUserLogin;
	System::UnicodeString FUserGroup;
	System::UnicodeString Fvarstr;
	System::UnicodeString FMime;
	bool FPrint;
	System::UnicodeString FReportTitle;
	void __fastcall DoExports(void);
	void __fastcall DoError(void);
	void __fastcall DoFillForm(void);
	void __fastcall DoSaveForm(void);
	void __fastcall ShowReportDialog(Frxclass::TfrxDialogPage* Page);
	void __fastcall DoAfterBuildReport(void);
	System::UnicodeString __fastcall ExtractReportName(const System::UnicodeString FileName);
	void __fastcall SetNavTemplate(const System::UnicodeString ReportName, bool Multipage, bool PicsInSameFolder, System::UnicodeString Prefix, int TotalPages, System::UnicodeString &Template);
	void __fastcall SetMainTemplate(const System::UnicodeString Title, const System::UnicodeString FrameFolder, bool Multipage, bool Navigator, System::UnicodeString &Template);
	void __fastcall SetToolbarTemplate(int CurrentPage, int TotalPages, bool Multipage, bool Navigator, System::UnicodeString &Template);
	System::UnicodeString __fastcall GetResultFileName(const System::UnicodeString ext);
	System::UnicodeString __fastcall GetNavRequest(System::UnicodeString PageN);
	System::UnicodeString __fastcall GetExportButton(System::UnicodeString expName, System::UnicodeString exp);
	
protected:
	virtual void __fastcall Execute(void);
	virtual void __fastcall TerminatedSet(void);
	
public:
	bool Active;
	bool Continue;
	bool DialogActive;
	bool Readed;
	__fastcall TfrxReportSession(void);
	__fastcall virtual ~TfrxReportSession(void);
	void __fastcall TerminateReport(void);
	__property System::UnicodeString FileName = {read=FName, write=FName};
	__property System::UnicodeString ReportTitle = {read=FReportTitle};
	__property Frxserverutils::TfrxServerFormat Format = {read=FFormat, write=FFormat, nodefault};
	__property System::UnicodeString IndexFileName = {read=FMainDocument, write=FMainDocument};
	__property System::UnicodeString PageRange = {read=FPageRange, write=FPageRange};
	__property System::Classes::TThread* ParentThread = {read=FParentThread, write=FParentThread};
	__property System::UnicodeString ReportPath = {read=FReportPath, write=FReportPath};
	__property System::UnicodeString ResultPage = {read=FResultPage};
	__property System::UnicodeString RootPath = {read=FBasePath, write=FBasePath};
	__property System::UnicodeString SessionId = {read=FSessionId, write=FSessionId};
	__property System::UnicodeString CacheId = {read=FCacheId, write=FCacheId};
	__property Frxvariables::TfrxVariables* Variables = {read=FVariables, write=FVariables};
	__property System::Classes::TComponent* ParentReportServer = {read=FParentReportServer, write=FParentReportServer};
	__property bool NativeClient = {read=FNativeClient, write=FNativeClient, nodefault};
	__property System::Classes::TMemoryStream* Stream = {read=FStream, write=FStream};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property bool Auth = {read=FAuth, nodefault};
	__property System::UnicodeString ReportMessage = {read=FMessage};
	__property bool PageNav = {read=FPageNav, write=FPageNav, nodefault};
	__property bool Multipage = {read=FMultipage, write=FMultipage, nodefault};
	__property System::UnicodeString UserLogin = {read=FUserLogin, write=FUserLogin};
	__property System::UnicodeString UserGroup = {read=FUserGroup, write=FUserGroup};
	__property System::UnicodeString Mime = {read=FMime};
	__property bool Print = {read=FPrint, write=FPrint, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxserverreports */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERREPORTS)
using namespace Frxserverreports;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverreportsHPP
