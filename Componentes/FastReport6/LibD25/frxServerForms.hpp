// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerForms.pas' rev: 32.00 (Windows)

#ifndef FrxserverformsHPP
#define FrxserverformsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <frxClass.hpp>
#include <frxDCtrl.hpp>
#include <frxUtils.hpp>
#include <frxExportMatrix.hpp>
#include <frxServerFormControls.hpp>
#include <frxUnicodeUtils.hpp>
#include <frxServerTemplates.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxserverforms
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxWebForm;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxWebForm : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TFileStream* Exp;
	Frxexportmatrix::TfrxIEMatrix* FMatrix;
	Frxclass::TfrxDialogPage* FDialog;
	System::UnicodeString FRepName;
	System::UnicodeString FSession;
	void __fastcall WriteExpLn(const System::AnsiString str)/* overload */;
	void __fastcall WriteExpLn(const System::UnicodeString str)/* overload */;
	System::AnsiString __fastcall GetHTML(Frxclass::TfrxDialogControl* Obj);
	
public:
	__fastcall TfrxWebForm(Frxclass::TfrxDialogPage* Dialog, System::UnicodeString Session);
	__fastcall virtual ~TfrxWebForm(void);
	void __fastcall Prepare(void);
	void __fastcall Clear(void);
	void __fastcall SaveFormToFile(System::UnicodeString FName);
	__property System::UnicodeString ReportName = {read=FRepName, write=FRepName};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxserverforms */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERFORMS)
using namespace Frxserverforms;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverformsHPP
