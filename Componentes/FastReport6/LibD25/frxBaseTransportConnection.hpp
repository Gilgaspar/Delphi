// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBaseTransportConnection.pas' rev: 32.00 (Windows)

#ifndef FrxbasetransportconnectionHPP
#define FrxbasetransportconnectionHPP

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

//-- user supplied -----------------------------------------------------------

namespace Frxbasetransportconnection
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBaseTransportConnection;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxHTTPWorkMode : unsigned char { hwmRead, hwmWrite };

typedef void __fastcall (__closure *TfrxHTTPWorkNotifyEvent)(System::TObject* Sender, TfrxHTTPWorkMode AWorkMode, __int64 AWorkCount);

class PASCALIMPLEMENTATION TfrxBaseTransportConnection : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	TfrxHTTPWorkNotifyEvent FOnWorkBegin;
	TfrxHTTPWorkNotifyEvent FOnWorkEnd;
	TfrxHTTPWorkNotifyEvent FOnWork;
	
protected:
	virtual System::UnicodeString __fastcall GetProxyHost(void);
	virtual System::UnicodeString __fastcall GetProxyLogin(void);
	virtual System::UnicodeString __fastcall GetProxyPassword(void);
	virtual int __fastcall GetProxyPort(void);
	virtual void __fastcall SetProxyHost(const System::UnicodeString Value);
	virtual void __fastcall SetProxyLogin(const System::UnicodeString Value);
	virtual void __fastcall SetProxyPassword(const System::UnicodeString Value);
	virtual void __fastcall SetProxyPort(const int Value);
	
public:
	__fastcall virtual TfrxBaseTransportConnection(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxBaseTransportConnection(void);
	virtual void __fastcall Connect(void) = 0 ;
	virtual void __fastcall Disconnect(void) = 0 ;
	virtual void __fastcall SetDefaultParametersWithToken(System::UnicodeString AToken) = 0 ;
	__property System::UnicodeString ProxyHost = {read=GetProxyHost, write=SetProxyHost};
	__property int ProxyPort = {read=GetProxyPort, write=SetProxyPort, nodefault};
	__property System::UnicodeString ProxyLogin = {read=GetProxyLogin, write=SetProxyLogin};
	__property System::UnicodeString ProxyPassword = {read=GetProxyPassword, write=SetProxyPassword};
	__property TfrxHTTPWorkNotifyEvent OnWork = {read=FOnWork, write=FOnWork};
	__property TfrxHTTPWorkNotifyEvent OnWorkBegin = {read=FOnWorkBegin, write=FOnWorkBegin};
	__property TfrxHTTPWorkNotifyEvent OnWorkEnd = {read=FOnWorkEnd, write=FOnWorkEnd};
};


typedef System::TMetaClass* TfrxBaseTransportConnectionClass;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbasetransportconnection */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBASETRANSPORTCONNECTION)
using namespace Frxbasetransportconnection;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbasetransportconnectionHPP
