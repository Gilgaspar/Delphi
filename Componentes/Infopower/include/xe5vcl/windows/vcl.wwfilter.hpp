// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwfilter.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwfilterHPP
#define Vcl_WwfilterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Bde.DBTables.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <vcl.Wwstacks.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <vcl.Wwsystem.hpp>	// Pascal unit
#include <BDE.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwfilter
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall wwSetFilter(System::UnicodeString a_line, Bde::Dbtables::TTable* table, Bde::hDBIFilter &fh, bool InOpen);
extern DELPHI_PACKAGE void __fastcall wwRemoveFilter(Bde::Dbtables::TDBDataSet* table, Bde::hDBIFilter &fh);
extern DELPHI_PACKAGE bool __fastcall wwAddFilter(System::UnicodeString a_line, Bde::Dbtables::TTable* table, Bde::hDBIFilter &fh);
extern DELPHI_PACKAGE bool __fastcall wwSetFilterFunction(void * func, Bde::Dbtables::TDBDataSet* table, Bde::hDBIFilter &fh);
}	/* namespace Wwfilter */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWFILTER)
using namespace Vcl::Wwfilter;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwfilterHPP
