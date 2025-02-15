// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'RvDLDataSet.pas' rev: 32.00 (Windows)

#ifndef RvdldatasetHPP
#define RvdldatasetHPP

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
#include <Data.DB.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <RvDLCommon.hpp>
#include <RvDLBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Rvdldataset
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDLDataSetDriver;
class DELPHICLASS TDLDataSetConnection;
class DELPHICLASS TDLDataSetResultSet;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLDataSetDriver : public Rvdlbase::TDLBaseDriver
{
	typedef Rvdlbase::TDLBaseDriver inherited;
	
public:
	virtual void __fastcall ResultSetGetRow(Rvdlcommon::TDLResultSetRow &Params);
public:
	/* TDLBaseDriver.Create */ inline __fastcall virtual TDLDataSetDriver(void) : Rvdlbase::TDLBaseDriver() { }
	/* TDLBaseDriver.Destroy */ inline __fastcall virtual ~TDLDataSetDriver(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLDataSetConnection : public Rvdlbase::TDLBaseConnection
{
	typedef Rvdlbase::TDLBaseConnection inherited;
	
public:
	/* TDLBaseConnection.Create */ inline __fastcall virtual TDLDataSetConnection(void) : Rvdlbase::TDLBaseConnection() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDLDataSetConnection(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDLDataSetResultSet : public Rvdlbase::TDLBaseResultSet
{
	typedef Rvdlbase::TDLBaseResultSet inherited;
	
private:
	Data::Db::TDataSet* FDataSet;
	bool FFirstEOFCheck;
	
protected:
	virtual Data::Db::TDataSet* __fastcall OpenDataSet(System::UnicodeString QueryStr) = 0 ;
	
public:
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall GetFields(Rvdlbase::TDLFieldListManager* AFields);
	virtual void __fastcall Open(System::UnicodeString QueryStr);
	virtual void __fastcall Close(void);
	__property Data::Db::TDataSet* DataSet = {read=FDataSet};
public:
	/* TDLBaseResultSet.Create */ inline __fastcall virtual TDLDataSetResultSet(Rvdlbase::TDLBaseConnection* AConnection) : Rvdlbase::TDLBaseResultSet(AConnection) { }
	/* TDLBaseResultSet.Destroy */ inline __fastcall virtual ~TDLDataSetResultSet(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Rvdldataset */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_RVDLDATASET)
using namespace Rvdldataset;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// RvdldatasetHPP
