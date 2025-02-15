// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportTextDialog.pas' rev: 32.00 (Windows)

#ifndef FrxexporttextdialogHPP
#define FrxexporttextdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <frxExportBaseDialog.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Variants.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexporttextdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxSimpleTextExportDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxSimpleTextExportDialog : public Frxexportbasedialog::TfrxBaseExportDialog
{
	typedef Frxexportbasedialog::TfrxBaseExportDialog inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* PageBreaksCB;
	Vcl::Stdctrls::TCheckBox* FramesCB;
	Vcl::Stdctrls::TCheckBox* EmptyLinesCB;
	Vcl::Stdctrls::TCheckBox* OEMCB;
	
protected:
	virtual void __fastcall InitControlsFromFilter(Frxexportbasedialog::TfrxBaseDialogExportFilter* ExportFilter);
	virtual void __fastcall InitFilterFromDialog(Frxexportbasedialog::TfrxBaseDialogExportFilter* ExportFilter);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxSimpleTextExportDialog(System::Classes::TComponent* AOwner) : Frxexportbasedialog::TfrxBaseExportDialog(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSimpleTextExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Frxexportbasedialog::TfrxBaseExportDialog(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxSimpleTextExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxSimpleTextExportDialog(HWND ParentWindow) : Frxexportbasedialog::TfrxBaseExportDialog(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexporttextdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTTEXTDIALOG)
using namespace Frxexporttextdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexporttextdialogHPP
