﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportXLSXDialog.pas' rev: 32.00 (Windows)

#ifndef FrxexportxlsxdialogHPP
#define FrxexportxlsxdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.ShellAPI.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <frxExportBaseDialog.hpp>
#include <System.UITypes.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexportxlsxdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxXLSXExportDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxXLSXExportDialog : public Frxexportbasedialog::TfrxBaseExportDialog
{
	typedef Frxexportbasedialog::TfrxBaseExportDialog inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* ContinuousCB;
	Vcl::Stdctrls::TGroupBox* SplitToSheetGB;
	Vcl::Stdctrls::TRadioButton* RPagesRB;
	Vcl::Stdctrls::TRadioButton* NotSplitRB;
	Vcl::Stdctrls::TRadioButton* RowsCountRB;
	Vcl::Stdctrls::TEdit* edChunk;
	Vcl::Stdctrls::TCheckBox* PageBreaksCB;
	Vcl::Stdctrls::TCheckBox* WCB;
	Vcl::Stdctrls::TCheckBox* DataOnlyCB;
	
protected:
	virtual void __fastcall InitControlsFromFilter(Frxexportbasedialog::TfrxBaseDialogExportFilter* ExportFilter);
	virtual void __fastcall InitFilterFromDialog(Frxexportbasedialog::TfrxBaseDialogExportFilter* ExportFilter);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxXLSXExportDialog(System::Classes::TComponent* AOwner) : Frxexportbasedialog::TfrxBaseExportDialog(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxXLSXExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Frxexportbasedialog::TfrxBaseExportDialog(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxXLSXExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxXLSXExportDialog(HWND ParentWindow) : Frxexportbasedialog::TfrxBaseExportDialog(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportxlsxdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTXLSXDIALOG)
using namespace Frxexportxlsxdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportxlsxdialogHPP
