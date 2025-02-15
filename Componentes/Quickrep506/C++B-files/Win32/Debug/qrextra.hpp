// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRExtra.pas' rev: 32.00 (Windows)

#ifndef QrextraHPP
#define QrextraHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Printers.hpp>
#include <Data.DB.hpp>
#include <Vcl.Clipbrd.hpp>
#include <QRPrntr.hpp>
#include <QuickRpt.hpp>
#include <QRCtrls.hpp>
#include <QRCompEd.hpp>
#include <QRExpBld.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrextra
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRPrintJob;
class DELPHICLASS TQRPHandler;
class DELPHICLASS TQRBuilder;
class DELPHICLASS TQRListBuilder;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRPrintJob : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual void __fastcall CreateOutput(Qrprntr::TQRPrinter* AQRPrinter);
	
public:
	Quickrpt::TQuickRep* parentReport;
	void __fastcall Preview(void);
	void __fastcall Print(void);
public:
	/* TObject.Create */ inline __fastcall TQRPrintJob(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TQRPrintJob(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRPHandler : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FFilename;
	
protected:
	void __fastcall SetFilename(System::UnicodeString Value);
	void __fastcall HandlePrintSetup(void);
	
public:
	Qrprntr::TQRPrinter* FQRPrinter;
	Quickrpt::TCustomQuickRep* FQuickrep;
	__fastcall TQRPHandler(void);
	__fastcall virtual ~TQRPHandler(void);
	void __fastcall Preview(void);
	void __fastcall Print(void);
	__property System::UnicodeString Filename = {read=FFilename, write=SetFilename};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TQRBuilder : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FActive;
	Vcl::Graphics::TFont* FFont;
	System::Uitypes::TPrinterOrientation FOrientation;
	Quickrpt::TCustomQuickRep* FReport;
	System::UnicodeString FTitle;
	System::Classes::TStrings* NameList;
	
protected:
	System::UnicodeString __fastcall NewName(System::UnicodeString AClassName);
	virtual void __fastcall BuildFramework(void);
	void __fastcall RenameObjects(void);
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetOrientation(System::Uitypes::TPrinterOrientation Value);
	virtual void __fastcall SetTitle(System::UnicodeString Value);
	
public:
	__fastcall virtual TQRBuilder(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRBuilder(void);
	Quickrpt::TCustomQuickRep* __fastcall FetchReport(void);
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=FFont};
	__property System::Uitypes::TPrinterOrientation Orientation = {read=FOrientation, write=SetOrientation, nodefault};
	__property Quickrpt::TCustomQuickRep* Report = {read=FReport, write=FReport};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
};


class PASCALIMPLEMENTATION TQRListBuilder : public TQRBuilder
{
	typedef TQRBuilder inherited;
	
private:
	Data::Db::TDataSet* FDataSet;
	System::Classes::TStrings* FFields;
	void __fastcall SetFields(System::Classes::TStrings* Value);
	
protected:
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall BuildList(void);
	
public:
	__fastcall virtual TQRListBuilder(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRListBuilder(void);
	void __fastcall AddAllFields(void);
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=FDataSet};
	__property System::Classes::TStrings* Fields = {read=FFields, write=SetFields};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall StrInMetafile(System::UnicodeString AString, Vcl::Graphics::TMetafile* AMetafile, bool MatchCase);
extern DELPHI_PACKAGE void __fastcall PopulateFontSizeCombo(Vcl::Stdctrls::TComboBox* aCombo);
extern DELPHI_PACKAGE System::Classes::TStrings* __fastcall AllDataSets(Vcl::Forms::TCustomForm* Form, bool IncludeDataModules);
extern DELPHI_PACKAGE Quickrpt::TQuickRep* __fastcall QRLoadReport(System::UnicodeString Filename);
extern DELPHI_PACKAGE void __fastcall QRFreeReport(Quickrpt::TQuickRep* aReport);
extern DELPHI_PACKAGE void __fastcall QRCreateList(Quickrpt::TCustomQuickRep* &AReport, System::Classes::TComponent* AOwner, Data::Db::TDataSet* aDataSet, System::UnicodeString aTitle, System::Classes::TStrings* aFieldList);
}	/* namespace Qrextra */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QREXTRA)
using namespace Qrextra;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrextraHPP
