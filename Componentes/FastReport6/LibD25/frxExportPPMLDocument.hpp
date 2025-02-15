// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportPPMLDocument.pas' rev: 32.00 (Windows)

#ifndef FrxexportppmldocumentHPP
#define FrxexportppmldocumentHPP

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
#include <frxExportPSDocument.hpp>
#include <frxExportPSHelper.hpp>
#include <frxXML.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexportppmldocument
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS PPMLDocument;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION PPMLDocument : public Frxexportpsdocument::PSDocument
{
	typedef Frxexportpsdocument::PSDocument inherited;
	
protected:
	Frxxml::TfrxXMLDocument* doc;
	Frxxml::TfrxXMLItem* root;
	Frxxml::TfrxXMLItem* internalData;
	Frxxml::TfrxXMLItem* mark;
	Frxxml::TfrxXMLItem* document;
	virtual void __fastcall CreateWindow(System::UnicodeString name, double Width, double Height);
	
public:
	virtual void __fastcall AddPage(void);
	virtual void __fastcall Save(System::Classes::TStream* stream)/* overload */;
	virtual void __fastcall Save(System::UnicodeString fn)/* overload */;
	virtual void __fastcall Finish(void);
	__fastcall virtual ~PPMLDocument(void);
public:
	/* PSDocument.Create */ inline __fastcall PPMLDocument(void)/* overload */ : Frxexportpsdocument::PSDocument() { }
	/* PSDocument.Create */ inline __fastcall PPMLDocument(System::UnicodeString name, double Width, double Height)/* overload */ : Frxexportpsdocument::PSDocument(name, Width, Height) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportppmldocument */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTPPMLDOCUMENT)
using namespace Frxexportppmldocument;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportppmldocumentHPP
