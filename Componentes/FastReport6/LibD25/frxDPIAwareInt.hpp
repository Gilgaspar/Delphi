// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDPIAwareInt.pas' rev: 32.00 (Windows)

#ifndef FrxdpiawareintHPP
#define FrxdpiawareintHPP

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

//-- user supplied -----------------------------------------------------------

namespace Frxdpiawareint
{
//-- forward type declarations -----------------------------------------------
struct DPI_AWARENESS_CONTEXT_;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD DPI_AWARENESS_CONTEXT_
{
public:
	int unused_;
};


typedef DPI_AWARENESS_CONTEXT_ *FRX_DPI_AWARENESS_CONTEXT;

typedef unsigned __stdcall (*TfrxGetDpiForWindow)(HWND hwnd);

typedef System::LongBool __stdcall (*TfrxSetProcessDpiAwarenessContext)(FRX_DPI_AWARENESS_CONTEXT value);

typedef System::LongBool __stdcall (*TfrxSetThreadDpiAwarenessContext)(FRX_DPI_AWARENESS_CONTEXT value);

typedef FRX_DPI_AWARENESS_CONTEXT __stdcall (*TfrxGetThreadDpiAwarenessContext)(void);

//-- var, const, procedure ---------------------------------------------------
static const System::Word FRX_WM_DPICHANGED = System::Word(0x2e0);
static const System::Word FRX_WM_DPICHANGED_AFTERPARENT = System::Word(0x2e3);
extern DELPHI_PACKAGE DPI_AWARENESS_CONTEXT_ *FRX_DPI_AWARENESS_CONTEXT_UNAWARE;
extern DELPHI_PACKAGE DPI_AWARENESS_CONTEXT_ *FRX_DPI_AWARENESS_CONTEXT_SYSTEM_AWARE;
extern DELPHI_PACKAGE DPI_AWARENESS_CONTEXT_ *FRX_DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE;
extern DELPHI_PACKAGE DPI_AWARENESS_CONTEXT_ *FRX_DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2;
extern DELPHI_PACKAGE DPI_AWARENESS_CONTEXT_ *FRX_DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED;
extern DELPHI_PACKAGE unsigned __fastcall frxGetDpiForWindow(NativeInt aHwnd);
extern DELPHI_PACKAGE System::LongBool __fastcall frxSetProcessDpiAwarenessContext(FRX_DPI_AWARENESS_CONTEXT value);
extern DELPHI_PACKAGE System::LongBool __fastcall frxSetThreadDpiAwarenessContext(FRX_DPI_AWARENESS_CONTEXT value);
extern DELPHI_PACKAGE FRX_DPI_AWARENESS_CONTEXT __fastcall frxGetThreadDpiAwarenessContext(void);
}	/* namespace Frxdpiawareint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDPIAWAREINT)
using namespace Frxdpiawareint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdpiawareintHPP
