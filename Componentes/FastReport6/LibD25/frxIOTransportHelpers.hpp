// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxIOTransportHelpers.pas' rev: 32.00 (Windows)

#ifndef FrxiotransporthelpersHPP
#define FrxiotransporthelpersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <frxClass.hpp>
#include <frxProgress.hpp>
#include <System.Classes.hpp>
#include <System.IniFiles.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <frxBaseTransportConnection.hpp>
#include <frxBaseForm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxiotransporthelpers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxBaseTransportDialog;
class DELPHICLASS TfrxInternetIOTransport;
class DELPHICLASS TfrxHTTPIOTransport;
class DELPHICLASS TIdObject;
class DELPHICLASS TDirStack;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxBaseTransportDialog : public Frxbaseform::TfrxBaseForm
{
	typedef Frxbaseform::TfrxBaseForm inherited;
	
protected:
	System::Inifiles::TCustomIniFile* FIni;
	TfrxInternetIOTransport* FFilter;
	System::Inifiles::TCustomIniFile* __fastcall GetIniFile(TfrxInternetIOTransport* TransportFilter);
	virtual void __fastcall InitDialog(void);
	virtual void __fastcall InitControlsFromFilter(TfrxInternetIOTransport* TransportFilter);
	virtual void __fastcall InitFilterFromDialog(TfrxInternetIOTransport* TransportFilter);
	System::UnicodeString __fastcall Decode64(System::UnicodeString Text);
	System::UnicodeString __fastcall Encode64(System::UnicodeString Text);
	void __fastcall IniLoadComboBox(Vcl::Stdctrls::TComboBox* ComboBox);
	void __fastcall IniLoadComboBoxWithItems(Vcl::Stdctrls::TComboBox* ComboBox);
	void __fastcall IniLoadEdit(Vcl::Stdctrls::TEdit* Edit);
	void __fastcall IniLoadCheckBox(Vcl::Stdctrls::TCheckBox* CheckBox);
	void __fastcall IniSaveComboBoxItem(Vcl::Stdctrls::TComboBox* ComboBox);
	void __fastcall IniSaveComboBox(Vcl::Stdctrls::TComboBox* ComboBox);
	void __fastcall IniSaveEdit(Vcl::Stdctrls::TEdit* Edit);
	void __fastcall IniSaveCheckBox(Vcl::Stdctrls::TCheckBox* CheckBox);
	
public:
	__fastcall virtual ~TfrxBaseTransportDialog(void);
	virtual void __fastcall UpdateResouces(void);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxBaseTransportDialog(System::Classes::TComponent* AOwner) : Frxbaseform::TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxBaseTransportDialog(System::Classes::TComponent* AOwner, int Dummy) : Frxbaseform::TfrxBaseForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxBaseTransportDialog(HWND ParentWindow) : Frxbaseform::TfrxBaseForm(ParentWindow) { }
	
};


typedef System::TMetaClass* TfrxBaseTransportDialogClass;

class PASCALIMPLEMENTATION TfrxInternetIOTransport : public Frxclass::TfrxCustomIOTransport
{
	typedef Frxclass::TfrxCustomIOTransport inherited;
	
private:
	bool FUseIniFile;
	bool FShowProgress;
	void __fastcall ConnectionWorkBegin(System::TObject* Sender, Frxbasetransportconnection::TfrxHTTPWorkMode AWorkMode, __int64 AWorkCount);
	void __fastcall ConnectionWork(System::TObject* Sender, Frxbasetransportconnection::TfrxHTTPWorkMode AWorkMode, __int64 AWorkCount);
	
protected:
	bool FIsFilterOpened;
	Frxprogress::TfrxProgress* FProgress;
	__int64 FWorkBeginPosition;
	int FDefaultProxyPort;
	System::UnicodeString FProxyHost;
	int FProxyPort;
	System::UnicodeString FProxyUserName;
	System::UnicodeString FProxyPassword;
	System::UnicodeString FUserName;
	System::UnicodeString FPassword;
	virtual Frxbasetransportconnection::TfrxBaseTransportConnection* __fastcall Connection(void) = 0 ;
	System::Uitypes::TModalResult __fastcall FormShowModal(void);
	void __fastcall CreateProgress(System::UnicodeString ProgressCaption);
	virtual System::UnicodeString __fastcall FilterSection(void) = 0 ;
	System::UnicodeString __fastcall PropertiesSection(void);
	void __fastcall ProcessFiles(void);
	__int64 __fastcall SizeOfFiles(void);
	bool __fastcall IsSelectFileName(void);
	bool __fastcall IsSelectDirectory(void);
	System::UnicodeString __fastcall SendFiles(void);
	virtual System::Classes::TStream* __fastcall DoCreateStream(System::UnicodeString &aFullFilePath, System::UnicodeString aFileName);
	virtual bool __fastcall CreateConnector(void) = 0 ;
	virtual void __fastcall DisposeConnector(void) = 0 ;
	virtual bool __fastcall DoConnectorConncet(void) = 0 ;
	virtual bool __fastcall DoBeforeSent(void);
	virtual void __fastcall Upload(System::Classes::TStream* const Source, System::UnicodeString DestFileName = System::UnicodeString()) = 0 ;
	virtual void __fastcall Download(const System::UnicodeString SourceFileName, System::Classes::TStream* const Source);
	virtual void __fastcall CreateRemoteDir(System::UnicodeString DirName, bool ChangeDir = true);
	virtual void __fastcall ChangeDirUP(void);
	virtual bool __fastcall IsDeleteSupported(void);
	virtual void __fastcall DialogDirChange(System::UnicodeString Name, System::UnicodeString Id, System::Classes::TStrings* DirItems) = 0 ;
	virtual void __fastcall DialogDirCreate(System::UnicodeString Name, System::Classes::TStrings* DirItems) = 0 ;
	virtual void __fastcall DialogDirDelete(System::UnicodeString Name, System::UnicodeString Id, System::Classes::TStrings* DirItems) = 0 ;
	virtual void __fastcall DialogFileDelete(System::UnicodeString Name, System::UnicodeString Id, System::Classes::TStrings* DirItems) = 0 ;
	
public:
	__fastcall virtual TfrxInternetIOTransport(System::Classes::TComponent* AOwner);
	virtual void __fastcall AssignFilter(Frxclass::TfrxCustomIOTransport* Source);
	virtual bool __fastcall OpenFilter(void);
	virtual void __fastcall CloseFilter(void);
	virtual Frxbasetransportconnection::TfrxBaseTransportConnectionClass __fastcall GetConnectorInstance(void) = 0 ;
	virtual void __fastcall GetDirItems(System::Classes::TStrings* DirItems, System::UnicodeString aFilter = System::UnicodeString()) = 0 ;
	__classmethod virtual TfrxBaseTransportDialogClass __fastcall TransportDialogClass();
	virtual void __fastcall TestToken(const System::UnicodeString URL, System::UnicodeString &sToken, bool bUsePOST = false);
	
__published:
	__property bool UseIniFile = {read=FUseIniFile, write=FUseIniFile, nodefault};
	__property bool ShowProgress = {read=FShowProgress, write=FShowProgress, nodefault};
	__property int DefaultProxyPort = {read=FDefaultProxyPort, nodefault};
	__property System::UnicodeString ProxyHost = {read=FProxyHost, write=FProxyHost};
	__property int ProxyPort = {read=FProxyPort, write=FProxyPort, nodefault};
	__property System::UnicodeString ProxyUserName = {read=FProxyUserName, write=FProxyUserName};
	__property System::UnicodeString ProxyPassword = {read=FProxyPassword, write=FProxyPassword};
	__property System::UnicodeString UserName = {read=FUserName, write=FUserName};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
public:
	/* TfrxCustomIOTransport.CreateNoRegister */ inline __fastcall TfrxInternetIOTransport(void) : Frxclass::TfrxCustomIOTransport() { }
	/* TfrxCustomIOTransport.Destroy */ inline __fastcall virtual ~TfrxInternetIOTransport(void) { }
	
};


class PASCALIMPLEMENTATION TfrxHTTPIOTransport : public TfrxInternetIOTransport
{
	typedef TfrxInternetIOTransport inherited;
	
private:
	System::UnicodeString FClientID;
	bool FUseProxyServer;
	bool FConnected;
	
protected:
	Frxbasetransportconnection::TfrxBaseTransportConnection* FHTTP;
	System::UnicodeString FAccessToken;
	System::UnicodeString FRemoteDir;
	System::Classes::TStrings* FAccessTokens;
	virtual Frxbasetransportconnection::TfrxBaseTransportConnection* __fastcall Connection(void);
	void __fastcall SetProxy(void);
	virtual void __fastcall Upload(System::Classes::TStream* const Source, System::UnicodeString DestFileName = System::UnicodeString());
	virtual void __fastcall ChangeDirUP(void);
	virtual void __fastcall TestRemoteDir(void);
	virtual bool __fastcall CreateConnector(void);
	virtual void __fastcall DisposeConnector(void);
	virtual bool __fastcall DoConnectorConncet(void);
	void __fastcall AddToDirItems(System::Classes::TStrings* DirItems, bool IsFolder, bool IsFile, System::UnicodeString Name, System::UnicodeString Id = System::UnicodeString());
	
public:
	__fastcall virtual TfrxHTTPIOTransport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxHTTPIOTransport(void);
	virtual void __fastcall AssignSharedProperties(Frxclass::TfrxCustomIOTransport* Source);
	virtual void __fastcall AssignFilter(Frxclass::TfrxCustomIOTransport* Source);
	__property System::UnicodeString AccessToken = {read=FAccessToken, write=FAccessToken};
	
__published:
	__property System::UnicodeString ClientID = {read=FClientID, write=FClientID};
	__property bool UseProxyServer = {read=FUseProxyServer, write=FUseProxyServer, nodefault};
public:
	/* TfrxCustomIOTransport.CreateNoRegister */ inline __fastcall TfrxHTTPIOTransport(void) : TfrxInternetIOTransport() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TIdObject : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FId;
	
public:
	__fastcall TIdObject(System::UnicodeString AId);
	__property System::UnicodeString Id = {read=FId};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TIdObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDirStack : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* StringList;
	
public:
	__fastcall TDirStack(System::UnicodeString st);
	__fastcall virtual ~TDirStack(void);
	void __fastcall Push(System::UnicodeString st);
	System::UnicodeString __fastcall Pop(void);
	System::UnicodeString __fastcall Top(void);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall ClearWithObjects(System::Classes::TStrings* DirItems);
extern DELPHI_PACKAGE System::UnicodeString __fastcall PathChangeDir(const System::UnicodeString Path, const System::UnicodeString Dir);
extern DELPHI_PACKAGE System::UnicodeString __fastcall PathFirstSlash(const System::UnicodeString Path);
extern DELPHI_PACKAGE System::AnsiString __fastcall SureAnsi(System::UnicodeString str);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SureUTF8(System::UnicodeString str);
extern DELPHI_PACKAGE System::UnicodeString __fastcall JsonEncode(System::UnicodeString str);
extern DELPHI_PACKAGE System::UnicodeString __fastcall CopySubstring(System::UnicodeString Source, System::UnicodeString Left, System::UnicodeString Right);
extern DELPHI_PACKAGE void __fastcall ClearLabelsFontStyle(Vcl::Forms::TForm* Form);
}	/* namespace Frxiotransporthelpers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXIOTRANSPORTHELPERS)
using namespace Frxiotransporthelpers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxiotransporthelpersHPP
