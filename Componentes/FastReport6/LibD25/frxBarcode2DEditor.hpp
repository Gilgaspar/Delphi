// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcode2DEditor.pas' rev: 32.00 (Windows)

#ifndef Frxbarcode2deditorHPP
#define Frxbarcode2deditorHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <frxClass.hpp>
#include <frxBarcode2D.hpp>
#include <frxCustomEditors.hpp>
#include <frxCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <frxBaseForm.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.ValEdit.hpp>
#include <System.Variants.hpp>
#include <frxDsgnIntf.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxbarcode2deditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBarcode2DEditor;
class DELPHICLASS TfrxBarcode2DEditorForm;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxBarcode2DEditor : public Frxcustomeditors::TfrxViewEditor
{
	typedef Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(void);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall virtual TfrxBarcode2DEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Vcl::Menus::TMenu* Menu) : Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxBarcode2DEditor(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxBarcode2DEditorForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TButton* OkB;
	Frxctrls::TfrxComboEdit* CodeE;
	Vcl::Stdctrls::TLabel* CodeLbl;
	Vcl::Stdctrls::TComboBox* TypeCB;
	Vcl::Stdctrls::TLabel* TypeLbl;
	Vcl::Extctrls::TBevel* ExampleBvl;
	Vcl::Extctrls::TPaintBox* ExamplePB;
	Vcl::Stdctrls::TGroupBox* OptionsLbl;
	Vcl::Stdctrls::TLabel* ZoomLbl;
	Vcl::Stdctrls::TCheckBox* AutoSizeCB;
	Vcl::Stdctrls::TCheckBox* ViewTextCB;
	Vcl::Stdctrls::TEdit* ZoomE;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TGroupBox* RotationLbl;
	Vcl::Stdctrls::TRadioButton* Rotation0RB;
	Vcl::Stdctrls::TRadioButton* Rotation90RB;
	Vcl::Stdctrls::TRadioButton* Rotation180RB;
	Vcl::Stdctrls::TRadioButton* Rotation270RB;
	Vcl::Stdctrls::TEdit* EditText;
	Vcl::Stdctrls::TGroupBox* BarPropertiesLb1;
	Vcl::Valedit::TValueListEditor* BarVList;
	Vcl::Comctrls::TPageControl* BarPageControl;
	Vcl::Comctrls::TTabSheet* TabGeneral;
	Vcl::Comctrls::TTabSheet* TabAdditional;
	void __fastcall ExprBtnClick(System::TObject* Sender);
	void __fastcall UpBClick(System::TObject* Sender);
	void __fastcall DownBClick(System::TObject* Sender);
	void __fastcall ExamplePBPaint(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall GetBarProperties(Frxbarcode2d::TfrxBarcode2DView* PBarcode);
	void __fastcall SetBarProperties(Frxbarcode2d::TfrxBarcode2DView* PBarcode, System::UnicodeString NameProp);
	void __fastcall TypeCBChange(System::TObject* Sender);
	void __fastcall BarVListSetEditText(System::TObject* Sender, int ACol, int ARow, const System::UnicodeString Value);
	void __fastcall EditTextKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall EditTextClick(System::TObject* Sender);
	
private:
	Frxbarcode2d::TfrxBarcode2DView* FBarcode;
	
public:
	virtual void __fastcall UpdateResouces(void);
	__property Frxbarcode2d::TfrxBarcode2DView* Barcode = {read=FBarcode, write=FBarcode};
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxBarcode2DEditorForm(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxBarcode2DEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxBarcode2DEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxBarcode2DEditorForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcode2deditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODE2DEDITOR)
using namespace Frxbarcode2deditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxbarcode2deditorHPP
