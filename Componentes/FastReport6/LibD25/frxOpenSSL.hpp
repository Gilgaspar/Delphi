// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxOpenSSL.pas' rev: 32.00 (Windows)

#ifndef FrxopensslHPP
#define FrxopensslHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Win.ScktComp.hpp>
#include <frxBaseSocketIOHandler.hpp>
#include <Winapi.WinSock.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxopenssl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxSSLIOHandler;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSSLIOHandler : public Frxbasesocketiohandler::TfrxCustomIOHandler
{
	typedef Frxbasesocketiohandler::TfrxCustomIOHandler inherited;
	
private:
	void *FSSL;
	void *FCtx;
	void *FMethod;
	bool FHandshakeDone;
	
protected:
	virtual int __fastcall DoRead(void *Buffer, int Count);
	virtual int __fastcall DoWrite(void *Buffer, int Count);
	virtual int __fastcall GetErrorCode(int ErrCode);
	
public:
	__fastcall virtual TfrxSSLIOHandler(void);
	virtual System::UnicodeString __fastcall GetLastError(void);
	virtual bool __fastcall InitializeHandler(void);
	virtual void __fastcall BindSocket(System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall DoHandshake(void);
	void __fastcall Connect(void);
	virtual bool __fastcall TryConnect(void);
	virtual void __fastcall Disconnect(void);
	virtual bool __fastcall ProcessIO(void);
public:
	/* TfrxCustomIOHandler.Destroy */ inline __fastcall virtual ~TfrxSSLIOHandler(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxopenssl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXOPENSSL)
using namespace Frxopenssl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxopensslHPP
