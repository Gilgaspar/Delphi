// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxComCtrls.pas' rev: 32.00 (Windows)

#ifndef FrxcomctrlsHPP
#define FrxcomctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <frxDPIAwareBaseControls.hpp>
#include <frxUtils.hpp>
#include <frxCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <frxDPIAwareInt.hpp>
#include <System.Types.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxcomctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDataNode;
class DELPHICLASS TfrxTreeNode;
class DELPHICLASS TfrxTreeNodes;
class DELPHICLASS TfrxTreeView;
class DELPHICLASS TfrxToolPanelCustomButton;
class DELPHICLASS TfrxToolPanelSeparator;
class DELPHICLASS TfrxToolPanelButton;
class DELPHICLASS TfrxToolPanel;
class DELPHICLASS TfrxTreePanel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxFilterAlign : unsigned char { fraLeft, fraRight, fraWidth };

enum DECLSPEC_DENUM TfrxToolAlign : unsigned char { ftaTop, ftaBottom };

enum DECLSPEC_DENUM TfrxTreeSortType : unsigned char { dtsUnsorted, dtsAscending, dtsDescending };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxDataNode : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxDataNode* FParent;
	TfrxDataNode* FFirstChild;
	TfrxDataNode* FRSibling;
	TfrxDataNode* FLSibling;
	System::TObject* FData;
	int FImageIndex;
	int FSelectedIndex;
	Vcl::Comctrls::TTreeNode* FOriginalNode;
	System::UnicodeString FText;
	
public:
	__fastcall virtual ~TfrxDataNode(void);
	void __fastcall Clear(void);
public:
	/* TObject.Create */ inline __fastcall TfrxDataNode(void) : System::TObject() { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TfrxTreeNodeClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxTreeNode : public Vcl::Comctrls::TTreeNode
{
	typedef Vcl::Comctrls::TTreeNode inherited;
	
private:
	TfrxDataNode* FDataNode;
	bool FNeedFixUp;
	
public:
	__fastcall TfrxTreeNode(Vcl::Comctrls::TTreeNodes* AOwner, TfrxDataNode* aDataNode)/* overload */;
	__fastcall virtual ~TfrxTreeNode(void);
	virtual void __fastcall MoveTo(Vcl::Comctrls::TTreeNode* Destination, Vcl::Comctrls::TNodeAttachMode Mode);
public:
	/* TTreeNode.Create */ inline __fastcall virtual TfrxTreeNode(Vcl::Comctrls::TTreeNodes* AOwner) : Vcl::Comctrls::TTreeNode(AOwner) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxTreeNodes : public Vcl::Comctrls::TTreeNodes
{
	typedef Vcl::Comctrls::TTreeNodes inherited;
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
public:
	/* TTreeNodes.Create */ inline __fastcall TfrxTreeNodes(Vcl::Comctrls::TCustomTreeView* AOwner) : Vcl::Comctrls::TTreeNodes(AOwner) { }
	/* TTreeNodes.Destroy */ inline __fastcall virtual ~TfrxTreeNodes(void) { }
	
};

#pragma pack(pop)

typedef bool __fastcall (__closure *TfrxTVFilterCompareEvent)(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, const System::UnicodeString aFilter);

class PASCALIMPLEMENTATION TfrxTreeView : public Vcl::Comctrls::TTreeView
{
	typedef Vcl::Comctrls::TTreeView inherited;
	
private:
	bool FIsUpdating;
	Vcl::Comctrls::TTVEditedEvent FOnEditedNew;
	TfrxDataNode* FRootNode;
	System::UnicodeString FLastFilter;
	TfrxTVFilterCompareEvent FOnFilterCompare;
	System::Classes::TNotifyEvent FOnExpandButtonClick;
	int FExpandLevel;
	bool FDrawExpandButton;
	bool FExpandButtonState;
	bool FExpandButtonActive;
	int FExpandButtonWidth;
	TfrxToolAlign FExpandButtonAlign;
	System::Types::TRect FExpandButtonRect;
	int FCurrentPPI;
	void __fastcall SetDrawExpandButton(const bool Value);
	void __fastcall SetExpandButtonState(const bool Value);
	void __fastcall InvalidateExpandButton(bool HideButton = false);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Message);
	MESSAGE void __fastcall WMDpiChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetExpandButtonAlign(const TfrxToolAlign Value);
	void __fastcall UpdateExpandButton(void);
	void __fastcall DrawArrow(void);
	
protected:
	virtual Vcl::Comctrls::TTreeNode* __fastcall CreateNode(void);
	virtual Vcl::Comctrls::TTreeNodes* __fastcall CreateNodes(void);
	DYNAMIC bool __fastcall CanChange(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC bool __fastcall CanCollapse(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Change(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Delete(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Added(Vcl::Comctrls::TTreeNode* Node);
	void __fastcall DoEdit(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	virtual void __fastcall DoPPIChanged(int aNewPPI);
	virtual void __fastcall DestroyWnd(void);
	virtual bool __fastcall IsCustomDrawn(Vcl::Comctrls::TCustomDrawTarget Target, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDraw(const System::Types::TRect &ARect, Vcl::Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDrawItem(Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TfrxTreeView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxTreeView(void);
	void __fastcall ResetFilter(void);
	void __fastcall Filter(const System::UnicodeString aFilter);
	void __fastcall UpdateFilter(void);
	__property int ExpandLevel = {read=FExpandLevel, write=FExpandLevel, nodefault};
	__property bool DrawExpandButton = {read=FDrawExpandButton, write=SetDrawExpandButton, nodefault};
	__property bool ExpandButtonState = {read=FExpandButtonState, write=SetExpandButtonState, nodefault};
	__property TfrxToolAlign ExpandButtonAlign = {read=FExpandButtonAlign, write=SetExpandButtonAlign, nodefault};
	
__published:
	__property Vcl::Comctrls::TTVEditedEvent OnEdited = {read=FOnEditedNew, write=FOnEditedNew};
	__property TfrxTVFilterCompareEvent OnFilterCompare = {read=FOnFilterCompare, write=FOnFilterCompare};
	__property System::Classes::TNotifyEvent OnExpandButtonClick = {read=FOnExpandButtonClick, write=FOnExpandButtonClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxTreeView(HWND ParentWindow) : Vcl::Comctrls::TTreeView(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TfrxToolButttonStyle : unsigned char { fbsButton, fbsCheckButton, fbsRadioButton, fbsDropDownButton };

enum DECLSPEC_DENUM TfrxToolButttonKind : unsigned char { fbkButton, fbkSeparator };

class PASCALIMPLEMENTATION TfrxToolPanelCustomButton : public Vcl::Controls::TGraphicControl
{
	typedef Vcl::Controls::TGraphicControl inherited;
	
public:
	__fastcall virtual TfrxToolPanelCustomButton(System::Classes::TComponent* AOwner);
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TfrxToolPanelCustomButton(void) { }
	
};


class PASCALIMPLEMENTATION TfrxToolPanelSeparator : public TfrxToolPanelCustomButton
{
	typedef TfrxToolPanelCustomButton inherited;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TfrxToolPanelSeparator(System::Classes::TComponent* AOwner);
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TfrxToolPanelSeparator(void) { }
	
};


class PASCALIMPLEMENTATION TfrxToolPanelButton : public TfrxToolPanelCustomButton
{
	typedef TfrxToolPanelCustomButton inherited;
	
private:
	bool FIsActive;
	bool FIsDown;
	int FImageIndex;
	TfrxToolButttonStyle FButtonStyle;
	int FGroup;
	TfrxToolPanel* __fastcall GetParentPanel(void);
	void __fastcall SetButtonStyle(const TfrxToolButttonStyle Value);
	void __fastcall SetIsDown(const bool Value);
	
protected:
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	int __fastcall GetArrowWidth(void);
	
public:
	__fastcall virtual TfrxToolPanelButton(System::Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property TfrxToolButttonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, nodefault};
	__property bool IsDown = {read=FIsDown, write=SetIsDown, nodefault};
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TfrxToolPanelButton(void) { }
	
};


class PASCALIMPLEMENTATION TfrxToolPanel : public Frxdpiawarebasecontrols::TfrxDPIAwarePanel
{
	typedef Frxdpiawarebasecontrols::TfrxDPIAwarePanel inherited;
	
private:
	System::Classes::TList* FButtons;
	Vcl::Imglist::TCustomImageList* FImageList;
	System::Classes::TNotifyEvent FOnBtnClick;
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall ResetRadioGroup(int GroupIndex);
	
protected:
	int __fastcall CalcButtonsWidth(void);
	
public:
	__fastcall virtual TfrxToolPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxToolPanel(void);
	TfrxToolPanelButton* __fastcall AddButton(int ImageIndex, System::UnicodeString HintText = System::UnicodeString(), NativeInt Tag = (NativeInt)(0xffffffff), TfrxToolButttonStyle ButtonStyle = (TfrxToolButttonStyle)(0x0), int Group = 0xffffffff);
	TfrxToolPanelCustomButton* __fastcall AddCustomButton(TfrxToolButttonKind aKind);
	virtual void __fastcall SetBounds(int aLeft, int aTop, int aWidth, int aHeight);
	int __fastcall GetArrowWidth(void);
	virtual void __fastcall Paint(void);
	void __fastcall RealignButtons(void);
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property System::Classes::TNotifyEvent OnBtnClick = {read=FOnBtnClick, write=FOnBtnClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxToolPanel(HWND ParentWindow) : Frxdpiawarebasecontrols::TfrxDPIAwarePanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TfrxTreePanel : public Frxdpiawarebasecontrols::TfrxDPIAwarePanel
{
	typedef Frxdpiawarebasecontrols::TfrxDPIAwarePanel inherited;
	
private:
	TfrxToolPanel* FToolPanel;
	Frxdpiawarebasecontrols::TfrxDPIAwarePanel* FPanel;
	TfrxTreeView* FTreeView;
	Frxctrls::TfrxFilterEdit* FFilter;
	int FFileterMinWidth;
	int FFileterMaxWidth;
	int FFilterActiveImageIndex;
	int FFilterUnactiveImageIndex;
	TfrxFilterAlign FFilterAlign;
	TfrxToolAlign FToolPanelAlign;
	void __fastcall SetFilterVisible(const bool Value);
	bool __fastcall GetFilterVisible(void);
	bool __fastcall GetToolVisible(void);
	void __fastcall SetToolVisible(const bool Value);
	Vcl::Imglist::TCustomImageList* __fastcall GetImageList(void);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetFilterActiveImageIndex(const int Value);
	void __fastcall SetFilterUnactiveImageIndex(const int Value);
	void __fastcall SetFileterMaxWidth(const int Value);
	void __fastcall SetFileterMinWidth(const int Value);
	void __fastcall ExpandButtonClick(System::TObject* Sender);
	void __fastcall SetFilterAlign(const TfrxFilterAlign Value);
	void __fastcall SetToolPanelAlign(const TfrxToolAlign Value);
	void __fastcall SetFilterColor(const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetFilterColor(void);
	
protected:
	void __fastcall UpdateSize(void);
	int __fastcall CalcButtonsWidth(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall EditChange(System::TObject* Sender);
	virtual void __fastcall DoPPIChanged(int aNewPPI);
	
public:
	__fastcall virtual TfrxTreePanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxTreePanel(void);
	__property System::Uitypes::TColor FilterColor = {read=GetFilterColor, write=SetFilterColor, nodefault};
	__property Frxctrls::TfrxFilterEdit* FilterEdit = {read=FFilter};
	__property bool FilterVisible = {read=GetFilterVisible, write=SetFilterVisible, nodefault};
	__property int FilterActiveImageIndex = {read=FFilterActiveImageIndex, write=SetFilterActiveImageIndex, nodefault};
	__property int FilterUnactiveImageIndex = {read=FFilterUnactiveImageIndex, write=SetFilterUnactiveImageIndex, nodefault};
	__property int FileterMinWidth = {read=FFileterMinWidth, write=SetFileterMinWidth, nodefault};
	__property int FileterMaxWidth = {read=FFileterMaxWidth, write=SetFileterMaxWidth, nodefault};
	__property TfrxFilterAlign FilterAlign = {read=FFilterAlign, write=SetFilterAlign, nodefault};
	__property TfrxToolPanel* ToolPanel = {read=FToolPanel};
	__property bool ToolVisible = {read=GetToolVisible, write=SetToolVisible, nodefault};
	__property Vcl::Imglist::TCustomImageList* ToolImageList = {read=GetImageList, write=SetImageList};
	__property TfrxToolAlign ToolPanelAlign = {read=FToolPanelAlign, write=SetToolPanelAlign, nodefault};
	__property TfrxTreeView* TreeView = {read=FTreeView};
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxTreePanel(HWND ParentWindow) : Frxdpiawarebasecontrols::TfrxDPIAwarePanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcomctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCOMCTRLS)
using namespace Frxcomctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcomctrlsHPP
