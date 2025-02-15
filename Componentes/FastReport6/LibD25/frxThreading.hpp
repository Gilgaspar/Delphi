// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxThreading.pas' rev: 32.00 (Windows)

#ifndef FrxthreadingHPP
#define FrxthreadingHPP

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

namespace Frxthreading
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxThreadSynchronizer;
class DELPHICLASS TfrxGuiThread;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxThreadSynchronizer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FIsMain;
	HWND FWindowHandle;
	void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall TfrxThreadSynchronizer(void);
	__fastcall virtual ~TfrxThreadSynchronizer(void);
	__property HWND WindowHandle = {read=FWindowHandle, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxGuiThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TfrxGuiThread(void);
	__fastcall virtual ~TfrxGuiThread(void);
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_FRX_SYNC_THREAD = System::Word(0x4fa);
static const System::Word WM_FRX_SYNC_MESSAGE = System::Word(0x4fb);
extern DELPHI_PACKAGE bool frxDisableThreadSynchronizer;
extern DELPHI_PACKAGE TfrxThreadSynchronizer* __fastcall GetThreadSynchronizer(void);
extern DELPHI_PACKAGE bool __fastcall IsThreadSynchronizerActive(void);
extern DELPHI_PACKAGE NativeInt __fastcall frxSynchSendMessage(HWND hWnd, unsigned Msg, NativeUInt wParam, NativeInt lParam);
extern DELPHI_PACKAGE void __fastcall frxThreadSynchronize(System::Classes::TThreadMethod Method);
}	/* namespace Frxthreading */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXTHREADING)
using namespace Frxthreading;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxthreadingHPP
