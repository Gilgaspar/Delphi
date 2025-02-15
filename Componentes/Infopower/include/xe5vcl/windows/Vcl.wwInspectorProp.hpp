// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwinspectorprop.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwinspectorpropHPP
#define Vcl_WwinspectorpropHPP

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
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <Vcl.CheckLst.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <vcl.Wwdbedit.hpp>	// Pascal unit
#include <vcl.Wwdotdot.hpp>	// Pascal unit
#include <vcl.Wwdbcomb.hpp>	// Pascal unit
#include <vcl.Wwdatainspector.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwinspectorprop
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TInspectorPropEdit;
class PASCALIMPLEMENTATION TInspectorPropEdit : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Buttons::TSpeedButton* NewItemButton;
	Vcl::Buttons::TSpeedButton* NewSubItemButton;
	Vcl::Buttons::TSpeedButton* DeleteButton;
	Vcl::Buttons::TSpeedButton* MoveUpButton;
	Vcl::Buttons::TSpeedButton* MoveDownButton;
	Vcl::Stdctrls::TButton* Button5;
	void __fastcall NewItemButtonClick(System::TObject* Sender);
	void __fastcall NewSubitemButtonClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall MoveButtonClick(System::TObject* Sender);
	void __fastcall TreeViewDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall TreeViewDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall TreeViewMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DeleteButtonClick(System::TObject* Sender);
	void __fastcall TreeViewChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeViewExpanded(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeViewCollapsed(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeViewCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall Button5Click(System::TObject* Sender);
	
private:
	Vcl::Comctrls::TTreeView* TreeView;
	Designintf::_di_IDesigner Designer;
	Vcl::Wwdatainspector::TwwDataInspector* Inspector;
	bool SkipUpdate;
	bool SkipChange;
	void __fastcall AddChildrenToTree(Vcl::Comctrls::TTreeNode* ParentNode, Vcl::Wwdatainspector::TwwInspectorCollection* Items);
	void __fastcall AddChildrenToInspector(Vcl::Comctrls::TTreeNode* ParentNode, Vcl::Wwdatainspector::TwwInspectorItem* ParentItem);
	void __fastcall RefreshNodeText(Vcl::Comctrls::TTreeNode* ParentNode);
	
public:
	__fastcall virtual ~TInspectorPropEdit(void);
	virtual void __fastcall Update(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TInspectorPropEdit(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TInspectorPropEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorPropEdit(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TInspectorPropEdit* InspectorPropEdit;
extern DELPHI_PACKAGE bool __fastcall ExecuteInspectorEditor(Designintf::_di_IDesigner ADesigner, Vcl::Wwdatainspector::TwwDataInspector* AEdit);
}	/* namespace Wwinspectorprop */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWINSPECTORPROP)
using namespace Vcl::Wwinspectorprop;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwinspectorpropHPP
