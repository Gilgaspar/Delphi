// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwbdecommon.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwbdecommonHPP
#define Vcl_WwbdecommonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <BDE.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <Bde.DBTables.hpp>	// Pascal unit
#include <Data.DBCommon.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <vcl.wwtypes.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwbdecommon
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall wwSaveAnswerTable(Bde::Dbtables::TDBDataSet* ADataSet, Bde::hDBICur AHandle, System::UnicodeString tableName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall wwGetAlias(System::UnicodeString aliasName);
extern DELPHI_PACKAGE int __fastcall wwCallbackMemoRead(Bde::Dbtables::TBDEDataSet* DataSet, void * FFilterBuffer, void *Buffer, Data::Db::TField* curField, int Count);
extern DELPHI_PACKAGE bool __fastcall wwSetLookupField(Data::Db::TDataSet* dataSet, Data::Db::TField* linkedField);
extern DELPHI_PACKAGE char * __fastcall wwGetQueryText(System::Classes::TStrings* tempQBE, bool Sql);
}	/* namespace Wwbdecommon */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWBDECOMMON)
using namespace Vcl::Wwbdecommon;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwbdecommonHPP
