// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRNewXLSXFiltProcs.pas' rev: 30.00 (Windows)

#ifndef QrnewxlsxfiltprocsHPP
#define QrnewxlsxfiltprocsHPP

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

//-- user supplied -----------------------------------------------------------

namespace Qrnewxlsxfiltprocs
{
//-- forward type declarations -----------------------------------------------
struct TAppParams;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TAppParams
{
public:
	System::UnicodeString creator;
	System::UnicodeString sheetname;
	System::UnicodeString company;
	System::UnicodeString LastCell;
	System::UnicodeString numstrings;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TAppParams appParams;
extern DELPHI_PACKAGE System::Classes::TStringList* fontlist;
extern DELPHI_PACKAGE System::Classes::TStringList* fillslist;
extern DELPHI_PACKAGE System::Classes::TStringList* styleslist;
extern DELPHI_PACKAGE System::Classes::TStringList* colwidths;
extern DELPHI_PACKAGE System::UnicodeString __fastcall num2XLCol(int n);
extern DELPHI_PACKAGE void __fastcall MakeStyles(System::Classes::TStringList* alist);
extern DELPHI_PACKAGE void __fastcall Load_sheet1prolog(System::Classes::TStringList* alist);
extern DELPHI_PACKAGE void __fastcall Load_workbook_file(System::Classes::TStringList* alist, System::UnicodeString sheetname);
extern DELPHI_PACKAGE void __fastcall Load_app_file(System::Classes::TStringList* alist);
extern DELPHI_PACKAGE void __fastcall Load_core_file(System::Classes::TStringList* alist);
extern DELPHI_PACKAGE void __fastcall Load_ContentTypes_file(System::Classes::TStringList* alist);
extern DELPHI_PACKAGE void __fastcall Load_dotrels_file(System::Classes::TStringList* alist);
extern DELPHI_PACKAGE void __fastcall Load_workbookdotrels_file(System::Classes::TStringList* alist);
}	/* namespace Qrnewxlsxfiltprocs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRNEWXLSXFILTPROCS)
using namespace Qrnewxlsxfiltprocs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrnewxlsxfiltprocsHPP
