﻿// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwcollectioneditor.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwcollectioneditorHPP
#define Vcl_WwcollectioneditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <vcl.wwcollection.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwcollectioneditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwCollectionEditorForm;
class PASCALIMPLEMENTATION TwwCollectionEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TListView* ItemsList;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* AddButton;
	Vcl::Comctrls::TToolButton* DeleteButton;
	Vcl::Comctrls::TToolButton* MoveUpButton;
	Vcl::Comctrls::TToolButton* MoveDownButton;
	Vcl::Controls::TImageList* EnabledImageList;
	Vcl::Controls::TImageList* DisabledImageList;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* UserButtonDivider;
	Vcl::Comctrls::TToolButton* UserButton1;
	Vcl::Comctrls::TToolButton* UserButton2;
	void __fastcall MoveButtonClick(System::TObject* Sender);
	void __fastcall DeleteButtonClick(System::TObject* Sender);
	void __fastcall AddButtonClick(System::TObject* Sender);
	void __fastcall ItemsListBoxKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall ItemsListDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall ItemsListDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall ItemsListChange(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TItemChange Change);
	void __fastcall ItemsListClick(System::TObject* Sender);
	
protected:
	bool IgnoreChange;
	Vcl::Wwcollection::_di_IwwCollectionItem __fastcall GetSelectedComponent(int Index);
	System::UnicodeString __fastcall GetItemText(Vcl::Wwcollection::_di_IwwCollectionItem Item);
	void __fastcall ItemUpdateName(Vcl::Wwcollection::_di_IwwCollectionItem Item);
	void __fastcall ItemUpdateSelection(Vcl::Wwcollection::_di_IwwCollectionItem Item);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation AOperation);
	
public:
	Vcl::Wwcollection::_di_IwwCollection Collection;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall Reload(void);
	virtual void __fastcall SetSelection(System::Classes::TPersistent* Instance, bool Selected);
	virtual void __fastcall Update(void);
	__fastcall virtual ~TwwCollectionEditorForm(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TwwCollectionEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwCollectionEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TwwCollectionEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TwwCollectionCustomizeEvent)(TwwCollectionEditorForm* EditorForm);

//-- var, const, procedure ---------------------------------------------------
#define swwInvalidParameter L"Parameter %s of %s cannot be %s"
extern DELPHI_PACKAGE TwwCollectionEditorForm* wwCollectionEditorForm;
extern DELPHI_PACKAGE void __fastcall wwExecuteCollectionEditor(System::UnicodeString ACaption, Designintf::_di_IDesigner ADesigner, Vcl::Wwcollection::_di_IwwCollection ACollection, TwwCollectionCustomizeEvent CustomizeEvent);
}	/* namespace Wwcollectioneditor */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWCOLLECTIONEDITOR)
using namespace Vcl::Wwcollectioneditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwcollectioneditorHPP
