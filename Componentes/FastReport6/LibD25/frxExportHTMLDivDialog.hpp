// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportHTMLDivDialog.pas' rev: 32.00 (Windows)

#ifndef FrxexporthtmldivdialogHPP
#define FrxexporthtmldivdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <frxPreview.hpp>
#include <System.UITypes.hpp>
#include <frxExportBaseDialog.hpp>
#include <Vcl.ComCtrls.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxexporthtmldivdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxHTMLDivExportDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxHTMLDivExportDialog : public Frxexportbasedialog::TfrxBaseExportDialog
{
	typedef Frxexportbasedialog::TfrxBaseExportDialog inherited;
	
__published:
	Vcl::Stdctrls::TLabel* PicturesL;
	Vcl::Stdctrls::TCheckBox* StylesCB;
	Vcl::Stdctrls::TCheckBox* UnifiedPicturesCB;
	Vcl::Stdctrls::TCheckBox* PicturesCB;
	Vcl::Stdctrls::TCheckBox* MultipageCB;
	Vcl::Stdctrls::TComboBox* PFormatCB;
	Vcl::Stdctrls::TCheckBox* FormattedCB;
	Vcl::Stdctrls::TCheckBox* NavigationCB;
	Vcl::Stdctrls::TCheckBox* OutlineCB;
	void __fastcall MultipageCBClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall InitControlsFromFilter(Frxexportbasedialog::TfrxBaseDialogExportFilter* ExportFilter);
	virtual void __fastcall InitFilterFromDialog(Frxexportbasedialog::TfrxBaseDialogExportFilter* ExportFilter);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxHTMLDivExportDialog(System::Classes::TComponent* AOwner) : Frxexportbasedialog::TfrxBaseExportDialog(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxHTMLDivExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Frxexportbasedialog::TfrxBaseExportDialog(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxHTMLDivExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxHTMLDivExportDialog(HWND ParentWindow) : Frxexportbasedialog::TfrxBaseExportDialog(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexporthtmldivdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTHTMLDIVDIALOG)
using namespace Frxexporthtmldivdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexporthtmldivdialogHPP
