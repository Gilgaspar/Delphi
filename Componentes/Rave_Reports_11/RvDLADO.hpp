// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'RvDLADO.pas' rev: 32.00 (Windows)

#ifndef RvdladoHPP
#define RvdladoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <RvDLCommon.hpp>
#include <RvDLBase.hpp>
#include <RvDLDataSet.hpp>
#include <System.Classes.hpp>
#include <Data.DB.hpp>
#include <Data.Win.ADODB.hpp>
#include <System.WideStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Rvdlado
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDLADODriver;
class DELPHICLASS TDLAdoConnection;
class DELPHICLASS TDLADOResultSet;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLADODriver : public Rvdldataset::TDLDataSetDriver
{
	typedef Rvdldataset::TDLDataSetDriver inherited;
	
public:
	virtual Rvdlbase::TDLBaseConnection* __fastcall CreateConnection(void);
	virtual Rvdlbase::TDLBaseResultSet* __fastcall CreateResultSet(Rvdlbase::TDLBaseConnection* AConnection);
	virtual void __fastcall Information(Rvdlcommon::TDLInformation &Params);
public:
	/* TDLBaseDriver.Create */ inline __fastcall virtual TDLADODriver(void) : Rvdldataset::TDLDataSetDriver() { }
	/* TDLBaseDriver.Destroy */ inline __fastcall virtual ~TDLADODriver(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLAdoConnection : public Rvdldataset::TDLDataSetConnection
{
	typedef Rvdldataset::TDLDataSetConnection inherited;
	
protected:
	Data::Win::Adodb::TADOConnection* FADOConnection;
	
public:
	virtual void __fastcall Connect(System::UnicodeString DataSource, System::UnicodeString UserName, System::UnicodeString Password, System::Classes::TStringList* OptionList);
	virtual void __fastcall Disconnect(void);
	virtual void __fastcall GetTableNames(System::Classes::TStrings* List);
	__property Data::Win::Adodb::TADOConnection* ADOConnection = {read=FADOConnection, write=FADOConnection};
public:
	/* TDLBaseConnection.Create */ inline __fastcall virtual TDLAdoConnection(void) : Rvdldataset::TDLDataSetConnection() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDLAdoConnection(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLADOResultSet : public Rvdldataset::TDLDataSetResultSet
{
	typedef Rvdldataset::TDLDataSetResultSet inherited;
	
public:
	virtual Data::Db::TDataSet* __fastcall OpenDataSet(System::UnicodeString QueryStr);
public:
	/* TDLBaseResultSet.Create */ inline __fastcall virtual TDLADOResultSet(Rvdlbase::TDLBaseConnection* AConnection) : Rvdldataset::TDLDataSetResultSet(AConnection) { }
	/* TDLBaseResultSet.Destroy */ inline __fastcall virtual ~TDLADOResultSet(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Rvdlado */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_RVDLADO)
using namespace Rvdlado;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// RvdladoHPP
