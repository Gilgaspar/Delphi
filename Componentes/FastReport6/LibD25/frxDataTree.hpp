// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDataTree.pas' rev: 32.00 (Windows)

#ifndef FrxdatatreeHPP
#define FrxdatatreeHPP

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
#include <frxClass.hpp>
#include <fs_xml.hpp>
#include <Vcl.ComCtrls.hpp>
#include <frxBaseForm.hpp>
#include <frxComCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Tabs.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxdatatree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDataTreeForm;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxDataTreeActions : unsigned char { dtaNode, dtaDataEdit = 53, dtaVariablesEdit = 52, dtaSortData = 60, dtaUnsorted = 127, dtaAscending = 125, dtaDescending, dtaCollapse = 117, dtaExpand, dtadtfInsCaption = 123, dtaInsField };

enum DECLSPEC_DENUM TfrxDataTreeFlag : unsigned char { dtfInsField, dtfInsCaption };

typedef System::Set<TfrxDataTreeFlag, TfrxDataTreeFlag::dtfInsField, TfrxDataTreeFlag::dtfInsCaption> TfrxDataTreeFlags;

class PASCALIMPLEMENTATION TfrxDataTreeForm : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* FunctionsPn;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Forms::TScrollBox* HintPanel;
	Vcl::Stdctrls::TLabel* FunctionDescL;
	Vcl::Stdctrls::TLabel* FunctionNameL;
	Vcl::Forms::TScrollBox* NoDataPn;
	Vcl::Stdctrls::TLabel* NoDataL;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall DataTreeCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall FunctionsTreeChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall DataTreeDblClick(System::TObject* Sender);
	void __fastcall ClassesTreeExpanding(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowExpansion);
	void __fastcall ClassesTreeCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall SortCBClick(System::TObject* Sender);
	
private:
	Fs_xml::TfsXMLDocument* FXML;
	Vcl::Controls::TImageList* FImages;
	Frxclass::TfrxReport* FReport;
	bool FUpdating;
	bool FFirstTime;
	bool FMultiSelectAllowed;
	Vcl::Tabs::TTabSet* FTabs;
	Frxcomctrls::TfrxTreeView* FDataTree;
	Frxcomctrls::TfrxTreeView* FClassesTree;
	Frxcomctrls::TfrxTreePanel* FDataPanel;
	Frxcomctrls::TfrxTreePanel* FClassesPanel;
	Frxcomctrls::TfrxTreePanel* FVariablesPanel;
	Frxcomctrls::TfrxTreeView* FVariablesTree;
	Frxcomctrls::TfrxTreePanel* FFunctionsPanel;
	Frxcomctrls::TfrxTreeView* FFunctionsTree;
	TfrxDataTreeFlags FDataTreeFlags;
	Frxcomctrls::TfrxTreeSortType FDataTreeSortType;
	Vcl::Menus::TPopupMenu* FSortPopUp;
	Frxcomctrls::TfrxToolPanelButton* FSortButton;
	Frxcomctrls::TfrxToolPanelButton* FVariablesButton;
	System::StaticArray<Frxcomctrls::TfrxToolPanelButton*, 2> FActionBtnList;
	bool FUpdateLocked;
	void __fastcall FillClassesTree(void);
	void __fastcall FillDataTree(void);
	void __fastcall FillFunctionsTree(void);
	void __fastcall FillVariablesTree(void);
	void __fastcall CollapseExpand(bool aExpand = false);
	void __fastcall TabsChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetCollapsedNodes(void);
	void __fastcall ToolOnClick(System::TObject* Sender);
	bool __fastcall FilterCompare(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, const System::UnicodeString aFilter);
	void __fastcall CreateSortPopup(void);
	void __fastcall CreatefrxTreePanel(Frxcomctrls::TfrxTreePanel* &TreePanel, Frxcomctrls::TfrxTreeView* &aTreeView);
	void __fastcall CreateDataTreeView(void);
	void __fastcall CreateClassesTreeView(void);
	void __fastcall CreateVariablesTreeView(void);
	void __fastcall CreateFunctionsTreeView(void);
	Vcl::Comctrls::TTreeView* __fastcall GetClassesTree(void);
	Vcl::Comctrls::TTreeView* __fastcall GetDataTree(void);
	Vcl::Comctrls::TTreeView* __fastcall GetFunctionsTree(void);
	Vcl::Comctrls::TTreeView* __fastcall GetVariablesTree(void);
	void __fastcall SetDataTreeFlags(const TfrxDataTreeFlags Value);
	void __fastcall SetDataTreeSortType(const Frxcomctrls::TfrxTreeSortType Value);
	void __fastcall SetReport(Frxclass::TfrxReport* const Value);
	
public:
	__fastcall virtual TfrxDataTreeForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDataTreeForm(void);
	void __fastcall SetColor_(System::Uitypes::TColor AColor);
	void __fastcall SetControlsParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetLastPosition(const System::Types::TPoint &p);
	void __fastcall ShowTab(int Index);
	void __fastcall UpdateItems(void);
	void __fastcall UpdateSelection(void);
	void __fastcall UpdateSize(void);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
	void __fastcall CheclMultiSelection(void);
	void __fastcall DisableUpdate(void);
	void __fastcall EnableUpdate(void);
	int __fastcall GetActivePage(void);
	System::UnicodeString __fastcall GetFieldName(int SelectionIndex = 0xffffffff);
	Frxclass::TfrxDataSet* __fastcall GetDataSet(int SelectionIndex);
	System::UnicodeString __fastcall ActiveDS(void);
	System::Types::TPoint __fastcall GetLastPosition(void);
	bool __fastcall IsDataField(void);
	int __fastcall GetSelectionCount(void);
	bool __fastcall IsDataTree(System::TObject* aSource);
	virtual void __fastcall LoadFormPreferences(System::TObject* PreferencesStorage, System::TObject* DefPreferencesStorage);
	virtual void __fastcall SaveFormPreferences(System::TObject* PreferencesStorage, System::TObject* DefPreferencesStorage);
	__property TfrxDataTreeFlags DataTreeFlags = {read=FDataTreeFlags, write=SetDataTreeFlags, nodefault};
	__property Frxcomctrls::TfrxTreeSortType DataTreeSortType = {read=FDataTreeSortType, write=SetDataTreeSortType, nodefault};
	__property Frxclass::TfrxReport* Report = {read=FReport, write=SetReport};
	__property bool MultiSelectAllowed = {read=FMultiSelectAllowed, write=FMultiSelectAllowed, nodefault};
	__property Vcl::Comctrls::TTreeView* ClassesTree = {read=GetClassesTree};
	__property Vcl::Comctrls::TTreeView* DataTree = {read=GetDataTree};
	__property Vcl::Comctrls::TTreeView* FunctionsTree = {read=GetFunctionsTree};
	__property Vcl::Comctrls::TTreeView* VariablesTree = {read=GetVariablesTree};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDataTreeForm(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDataTreeForm(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdatatree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDATATREE)
using namespace Frxdatatree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdatatreeHPP
