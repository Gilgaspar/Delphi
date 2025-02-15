﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxOLEEditor.pas' rev: 32.00 (Windows)

#ifndef FrxoleeditorHPP
#define FrxoleeditorHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Dialogs.hpp>
#include <frxClass.hpp>
#include <frxCustomEditors.hpp>
#include <frxDsgnIntf.hpp>
#include <frxOLE.hpp>
#include <frxBaseForm.hpp>
#include <Vcl.OleCtnrs.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxoleeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxOLEEditor;
class DELPHICLASS TfrxOleEditorForm;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxOLEEditor : public Frxcustomeditors::TfrxViewEditor
{
	typedef Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(void);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall virtual TfrxOLEEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Vcl::Menus::TMenu* Menu) : Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxOLEEditor(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxOleEditorForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* InsertB;
	Vcl::Stdctrls::TButton* EditB;
	Vcl::Stdctrls::TButton* CloseB;
	Vcl::Olectnrs::TOleContainer* OleContainer;
	void __fastcall InsertBClick(System::TObject* Sender);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
public:
	virtual void __fastcall UpdateResouces(void);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxOleEditorForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxOleEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxOleEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxOleEditorForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxoleeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXOLEEDITOR)
using namespace Frxoleeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxoleeditorHPP
