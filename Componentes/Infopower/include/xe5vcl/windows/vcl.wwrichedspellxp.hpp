// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwrichedspellxp.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwrichedspellxpHPP
#define Vcl_WwrichedspellxpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <vcl.wwriched.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwrichedspellxp
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwDBRichEditMSWord;
class PASCALIMPLEMENTATION TwwDBRichEditMSWord : public Vcl::Wwriched::TwwDBRichEdit
{
	typedef Vcl::Wwriched::TwwDBRichEdit inherited;
	
public:
	virtual bool __fastcall MSWordSpellChecker(void);
public:
	/* TwwDBRichEdit.Create */ inline __fastcall virtual TwwDBRichEditMSWord(System::Classes::TComponent* AOwner) : Vcl::Wwriched::TwwDBRichEdit(AOwner) { }
	/* TwwDBRichEdit.Destroy */ inline __fastcall virtual ~TwwDBRichEditMSWord(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwDBRichEditMSWord(HWND ParentWindow) : Vcl::Wwriched::TwwDBRichEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall MSWordSpellChecker(Vcl::Wwriched::TwwDBRichEdit* RichEdit);
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Wwrichedspellxp */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWRICHEDSPELLXP)
using namespace Vcl::Wwrichedspellxp;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwrichedspellxpHPP
