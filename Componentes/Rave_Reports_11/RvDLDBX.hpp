// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'RvDLDBX.pas' rev: 32.00 (Windows)

#ifndef RvdldbxHPP
#define RvdldbxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <RvDLCommon.hpp>
#include <RvDLBase.hpp>
#include <RvDLDataSet.hpp>
#include <Data.DB.hpp>
#include <Data.SqlExpr.hpp>

//-- user supplied -----------------------------------------------------------

namespace Rvdldbx
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDLDBXDriver;
class DELPHICLASS TDLDBXConnection;
class DELPHICLASS TDLDBXResultSet;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLDBXDriver : public Rvdldataset::TDLDataSetDriver
{
	typedef Rvdldataset::TDLDataSetDriver inherited;
	
public:
	virtual Rvdlbase::TDLBaseConnection* __fastcall CreateConnection(void);
	virtual Rvdlbase::TDLBaseResultSet* __fastcall CreateResultSet(Rvdlbase::TDLBaseConnection* AConnection);
	virtual void __fastcall Information(Rvdlcommon::TDLInformation &Params);
public:
	/* TDLBaseDriver.Create */ inline __fastcall virtual TDLDBXDriver(void) : Rvdldataset::TDLDataSetDriver() { }
	/* TDLBaseDriver.Destroy */ inline __fastcall virtual ~TDLDBXDriver(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLDBXConnection : public Rvdldataset::TDLDataSetConnection
{
	typedef Rvdldataset::TDLDataSetConnection inherited;
	
protected:
	Data::Sqlexpr::TSQLConnection* FSQLConnection;
	
public:
	virtual void __fastcall Connect(System::UnicodeString DataSource, System::UnicodeString UserName, System::UnicodeString Password, System::Classes::TStringList* OptionList);
	virtual void __fastcall Disconnect(void);
	virtual void __fastcall GetTableNames(System::Classes::TStrings* List);
	__property Data::Sqlexpr::TSQLConnection* SQLConnection = {read=FSQLConnection, write=FSQLConnection};
public:
	/* TDLBaseConnection.Create */ inline __fastcall virtual TDLDBXConnection(void) : Rvdldataset::TDLDataSetConnection() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDLDBXConnection(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLDBXResultSet : public Rvdldataset::TDLDataSetResultSet
{
	typedef Rvdldataset::TDLDataSetResultSet inherited;
	
protected:
	virtual Data::Db::TDataSet* __fastcall OpenDataSet(System::UnicodeString QueryStr);
public:
	/* TDLBaseResultSet.Create */ inline __fastcall virtual TDLDBXResultSet(Rvdlbase::TDLBaseConnection* AConnection) : Rvdldataset::TDLDataSetResultSet(AConnection) { }
	/* TDLBaseResultSet.Destroy */ inline __fastcall virtual ~TDLDBXResultSet(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Rvdldbx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_RVDLDBX)
using namespace Rvdldbx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// RvdldbxHPP
