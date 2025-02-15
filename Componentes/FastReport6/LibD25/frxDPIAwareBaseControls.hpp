// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDPIAwareBaseControls.pas' rev: 32.00 (Windows)

#ifndef FrxdpiawarebasecontrolsHPP
#define FrxdpiawarebasecontrolsHPP

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
#include <frxDPIAwareInt.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxdpiawarebasecontrols
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDPIAwareBasePanel;
class DELPHICLASS TfrxDPIAwarePanel;
class DELPHICLASS TfrxDPIAwareCustomControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDPIAwareBasePanel : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
private:
	int FCurrentPPI;
	MESSAGE void __fastcall WMDpiChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall DoPPIChanged(int aNewPPI);
	
public:
	__fastcall virtual TfrxDPIAwareBasePanel(System::Classes::TComponent* AOwner);
	float __fastcall GetScale(void);
	float __fastcall GetReleativeScale(void);
	virtual void __fastcall ScaleForPPI(int NewPPI);
	__property int CurrentPPI = {read=FCurrentPPI, write=FCurrentPPI, nodefault};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxDPIAwareBasePanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDPIAwareBasePanel(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TfrxDPIAwarePanel : public TfrxDPIAwareBasePanel
{
	typedef TfrxDPIAwareBasePanel inherited;
	
public:
	__property DockManager;
	
__published:
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property BorderStyle = {default=0};
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Ctl3D;
	__property BevelKind = {default=0};
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FullRepaint = {default=1};
	__property Font;
	__property Locked = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentBackground = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
public:
	/* TfrxDPIAwareBasePanel.Create */ inline __fastcall virtual TfrxDPIAwarePanel(System::Classes::TComponent* AOwner) : TfrxDPIAwareBasePanel(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxDPIAwarePanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDPIAwarePanel(HWND ParentWindow) : TfrxDPIAwareBasePanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TfrxDPIAwareCustomControl : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	int FCurrentPPI;
	MESSAGE void __fastcall WMDpiChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall DoPPIChanged(int aNewPPI);
	
public:
	__fastcall virtual TfrxDPIAwareCustomControl(System::Classes::TComponent* AOwner);
	virtual void __fastcall ScaleForPPI(int NewPPI);
	float __fastcall GetScale(void);
	float __fastcall GetReleativeScale(void);
	__property int CurrentPPI = {read=FCurrentPPI, write=FCurrentPPI, nodefault};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxDPIAwareCustomControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDPIAwareCustomControl(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdpiawarebasecontrols */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDPIAWAREBASECONTROLS)
using namespace Frxdpiawarebasecontrols;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdpiawarebasecontrolsHPP
