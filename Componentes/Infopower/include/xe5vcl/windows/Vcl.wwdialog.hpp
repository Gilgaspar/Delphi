// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwDialog.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwdialogHPP
#define Vcl_WwdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwdialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwCustomDialog;
class PASCALIMPLEMENTATION TwwCustomDialog : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	virtual bool __fastcall Execute(void) = 0 ;
	virtual Data::Db::TDataSet* __fastcall GetPrimaryDataSet(void) = 0 ;
public:
	/* TComponent.Create */ inline __fastcall virtual TwwCustomDialog(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TwwCustomDialog(void) { }
	
};


typedef System::TMetaClass* TwwCustomDialogClass;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Wwdialog */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWDIALOG)
using namespace Vcl::Wwdialog;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwdialogHPP
