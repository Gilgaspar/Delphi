// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportPSDialog.pas' rev: 32.00 (Windows)

#ifndef FrxexportpsdialogHPP
#define FrxexportpsdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <frxExportBaseDialog.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexportpsdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxExportPSDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxExportPSDialog : public Frxexportbasedialog::TfrxBaseExportDialog
{
	typedef Frxexportbasedialog::TfrxBaseExportDialog inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* Pictures;
	Vcl::Stdctrls::TCheckBox* IncludeImages;
	Vcl::Stdctrls::TCheckBox* HasMultipleFiles;
	Vcl::Stdctrls::TComboBox* ComboBox1;
	
protected:
	virtual void __fastcall InitControlsFromFilter(Frxexportbasedialog::TfrxBaseDialogExportFilter* ExportFilter);
	virtual void __fastcall InitFilterFromDialog(Frxexportbasedialog::TfrxBaseDialogExportFilter* ExportFilter);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxExportPSDialog(System::Classes::TComponent* AOwner) : Frxexportbasedialog::TfrxBaseExportDialog(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxExportPSDialog(System::Classes::TComponent* AOwner, int Dummy) : Frxexportbasedialog::TfrxBaseExportDialog(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxExportPSDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxExportPSDialog(HWND ParentWindow) : Frxexportbasedialog::TfrxBaseExportDialog(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxExportPSDialog* frxExportPSDialoge;
}	/* namespace Frxexportpsdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTPSDIALOG)
using namespace Frxexportpsdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportpsdialogHPP
