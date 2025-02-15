// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxMapLayerForm.pas' rev: 32.00 (Windows)

#ifndef FrxmaplayerformHPP
#define FrxmaplayerformHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <frxCtrls.hpp>
#include <frxMapHelpers.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxmaplayerform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxMapLayerForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxMapLayerForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TRadioButton* rbMapFile;
	Frxctrls::TfrxComboEdit* edMapFile;
	Vcl::Stdctrls::TCheckBox* cbEmbed;
	Vcl::Stdctrls::TRadioButton* rbAppData;
	Vcl::Stdctrls::TLabel* lblSelect;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Stdctrls::TRadioButton* rbInteractive;
	Vcl::Stdctrls::TRadioButton* rbGeodata;
	void __fastcall edMapFileButtonClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
public:
	bool __fastcall IsEmbed(void);
	Frxmaphelpers::TLayerType __fastcall LayerType(void);
	System::UnicodeString __fastcall MapFile(void);
	void __fastcall EnableInteractive(bool Value);
	virtual void __fastcall UpdateResouces(void);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxMapLayerForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxMapLayerForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxMapLayerForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxMapLayerForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxmaplayerform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXMAPLAYERFORM)
using namespace Frxmaplayerform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxmaplayerformHPP
