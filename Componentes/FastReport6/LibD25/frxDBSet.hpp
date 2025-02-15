﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDBSet.pas' rev: 32.00 (Windows)

#ifndef FrxdbsetHPP
#define FrxdbsetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <frxClass.hpp>
#include <Data.DB.hpp>
#include <System.Variants.hpp>
#include <System.WideStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxdbset
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxDBDataset;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxDBDataset : public Frxclass::TfrxCustomDBDataSet
{
	typedef Frxclass::TfrxCustomDBDataSet inherited;
	
private:
	System::DynamicArray<System::Byte> FBookmark;
	Data::Db::TDataSet* FDataSet;
	Data::Db::TDataSource* FDataSource;
	Data::Db::TDataSet* FDS;
	bool FEof;
	bool FBCDToCurrency;
	Data::Db::TDataSetNotifyEvent FSaveOpenEvent;
	Data::Db::TDataSetNotifyEvent FSaveCloseEvent;
	Data::Db::TDataSetNotifyEvent FSaveAfterRefresh;
	System::Classes::TNotifyEvent FSaveFiedsChange;
	bool FNeedFieldsUpdate;
	void __fastcall BeforeClose(Data::Db::TDataSet* Sender);
	void __fastcall AfterOpenEvent(Data::Db::TDataSet* Sender);
	void __fastcall AfterRefresh(Data::Db::TDataSet* Sender);
	void __fastcall FieldsChanged(System::TObject* Sender);
	void __fastcall SetDataSet(Data::Db::TDataSet* Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	bool __fastcall DataSetActive(void);
	bool __fastcall IsDataSetStored(void);
	void __fastcall UpdateFields(void);
	
protected:
	virtual System::WideString __fastcall GetDisplayText(System::UnicodeString Index);
	virtual int __fastcall GetDisplayWidth(System::UnicodeString Index);
	virtual Frxclass::TfrxFieldType __fastcall GetFieldType(System::UnicodeString Index);
	virtual System::Variant __fastcall GetValue(System::UnicodeString Index);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual void __fastcall Initialize(void);
	virtual void __fastcall Finalize(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual void __fastcall Prior(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall Eof(void);
	Data::Db::TDataSet* __fastcall GetDataSet(void);
	virtual bool __fastcall IsBlobField(const System::UnicodeString fName);
	virtual bool __fastcall IsWideMemoBlobField(const System::UnicodeString fName);
	virtual bool __fastcall IsHasMaster(void);
	virtual int __fastcall RecordCount(void);
	virtual void __fastcall AssignBlobTo(const System::UnicodeString fName, System::TObject* Obj);
	virtual void __fastcall GetFieldList(System::Classes::TStrings* List);
	
__published:
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet, stored=IsDataSetStored};
	__property Data::Db::TDataSource* DataSource = {read=FDataSource, write=SetDataSource, stored=IsDataSetStored};
	__property bool BCDToCurrency = {read=FBCDToCurrency, write=FBCDToCurrency, nodefault};
public:
	/* TfrxCustomDBDataSet.Create */ inline __fastcall virtual TfrxDBDataset(System::Classes::TComponent* AOwner) : Frxclass::TfrxCustomDBDataSet(AOwner) { }
	/* TfrxCustomDBDataSet.Destroy */ inline __fastcall virtual ~TfrxDBDataset(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDBDataset(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxCustomDBDataSet(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdbset */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDBSET)
using namespace Frxdbset;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdbsetHPP
