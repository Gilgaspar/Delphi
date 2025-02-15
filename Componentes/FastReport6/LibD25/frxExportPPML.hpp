// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportPPML.pas' rev: 32.00 (Windows)

#ifndef FrxexportppmlHPP
#define FrxexportppmlHPP

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
#include <frxStorage.hpp>
#include <frxExportPS.hpp>
#include <frxExportPPMLDialog.hpp>
#include <frxExportPPMLDocument.hpp>
#include <frxExportPSHelper.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexportppml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxPPMLExport;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxPPMLExport : public Frxexportps::TfrxPSExport
{
	typedef Frxexportps::TfrxPSExport inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__classmethod virtual Frxexportbasedialog::TfrxBaseExportDialogClass __fastcall ExportDialogClass();
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall Finish(void);
public:
	/* TfrxPSExport.Create */ inline __fastcall virtual TfrxPPMLExport(System::Classes::TComponent* AOwner) : Frxexportps::TfrxPSExport(AOwner) { }
	/* TfrxPSExport.Destroy */ inline __fastcall virtual ~TfrxPPMLExport(void) { }
	
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxPPMLExport(void) : Frxexportps::TfrxPSExport() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportppml */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTPPML)
using namespace Frxexportppml;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportppmlHPP
