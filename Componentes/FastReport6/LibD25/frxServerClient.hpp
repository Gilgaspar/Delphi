// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerClient.pas' rev: 32.00 (Windows)

#ifndef FrxserverclientHPP
#define FrxserverclientHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Win.ScktComp.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <frxClass.hpp>
#include <frxVariables.hpp>
#include <frxGZip.hpp>
#include <frxHTTPClient.hpp>
#include <frxmd5.hpp>
#include <frxServerUtils.hpp>
#include <frxNetUtils.hpp>
#include <frxUnicodeUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxserverclient
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxServerConnection;
class DELPHICLASS TfrxReportClient;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxServerConnection : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	System::UnicodeString FHost;
	System::UnicodeString FLogin;
	bool FMIC;
	System::UnicodeString FPassword;
	int FPort;
	int FProxyPort;
	System::UnicodeString FProxyHost;
	int FRetryCount;
	unsigned FRetryTimeout;
	unsigned FTimeout;
	System::UnicodeString FPath;
	bool FCompression;
	void __fastcall SetPath(const System::UnicodeString Value);
	
public:
	__fastcall virtual TfrxServerConnection(System::Classes::TComponent* AOwner);
	
__published:
	__property bool Compression = {read=FCompression, write=FCompression, nodefault};
	__property System::UnicodeString Host = {read=FHost, write=FHost};
	__property System::UnicodeString Login = {read=FLogin, write=FLogin};
	__property bool MIC = {read=FMIC, write=FMIC, nodefault};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property int Port = {read=FPort, write=FPort, nodefault};
	__property System::UnicodeString ProxyHost = {read=FProxyHost, write=FProxyHost};
	__property int ProxyPort = {read=FProxyPort, write=FProxyPort, nodefault};
	__property int RetryCount = {read=FRetryCount, write=FRetryCount, nodefault};
	__property unsigned RetryTimeout = {read=FRetryTimeout, write=FRetryTimeout, nodefault};
	__property unsigned Timeout = {read=FTimeout, write=FTimeout, nodefault};
	__property System::UnicodeString Path = {read=FPath, write=SetPath};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxServerConnection(void) { }
	
};


class PASCALIMPLEMENTATION TfrxReportClient : public Frxclass::TfrxReport
{
	typedef Frxclass::TfrxReport inherited;
	
private:
	Frxhttpclient::TfrxHTTPClient* FClient;
	TfrxServerConnection* FConnection;
	System::UnicodeString FReportName;
	System::UnicodeString FSessionId;
	bool FSecondPass;
	void __fastcall FillPreviewPages(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TfrxReportClient(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxReportClient(void);
	HIDESBASE bool __fastcall PrepareReport(void);
	HIDESBASE void __fastcall LoadFromFile(System::UnicodeString FileName);
	HIDESBASE void __fastcall ShowReport(void);
	System::UnicodeString __fastcall GetServerVariable(const System::UnicodeString VariableName);
	void __fastcall Close(void);
	__property Frxhttpclient::TfrxHTTPClient* Client = {read=FClient, write=FClient};
	
__published:
	__property TfrxServerConnection* Connection = {read=FConnection, write=FConnection};
	__property System::UnicodeString ReportName = {read=FReportName, write=FReportName};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxReportClient(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxReport(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxserverclient */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERCLIENT)
using namespace Frxserverclient;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverclientHPP
