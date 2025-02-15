// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxFDComponents.pas' rev: 32.00 (Windows)

#ifndef FrxfdcomponentsHPP
#define FrxfdcomponentsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Data.DB.hpp>
#include <frxClass.hpp>
#include <frxCustomDB.hpp>
#include <frxXML.hpp>
#include <FireDAC.DatS.hpp>
#include <FireDAC.Comp.Client.hpp>
#include <FireDAC.Stan.Option.hpp>
#include <FireDAC.Comp.DataSet.hpp>
#include <System.Variants.hpp>
#include <fqbClass.hpp>
#include <frxDBSet.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxfdcomponents
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxFDComponents;
class DELPHICLASS TfrxFDDatabase;
class DELPHICLASS TfrxFDQuery;
class DELPHICLASS TfrxFDMemTable;
class DELPHICLASS TfrxFDTable;
class DELPHICLASS TfrxCustomStoredProc;
class DELPHICLASS TfrxFDStoredProc;
class DELPHICLASS TfrxEngineFD;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxFDComponents : public Frxclass::TfrxDBComponents
{
	typedef Frxclass::TfrxDBComponents inherited;
	
private:
	Firedac::Comp::Client::TFDConnection* FDefaultDatabase;
	TfrxFDComponents* FOldComponents;
	bool FDesignTimeExpr;
	void __fastcall SetDefaultDatabase(Firedac::Comp::Client::TFDConnection* const AValue);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TfrxFDComponents(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxFDComponents(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	
__published:
	__property Firedac::Comp::Client::TFDConnection* DefaultDatabase = {read=FDefaultDatabase, write=SetDefaultDatabase};
	__property bool DesignTimeExpr = {read=FDesignTimeExpr, write=FDesignTimeExpr, stored=false, default=0};
};


class PASCALIMPLEMENTATION TfrxFDDatabase : public Frxclass::TfrxCustomDatabase
{
	typedef Frxclass::TfrxCustomDatabase inherited;
	
private:
	Firedac::Comp::Client::TFDConnection* FDatabase;
	System::UnicodeString __fastcall GetDriverName(void);
	void __fastcall SetDriverName(const System::UnicodeString AValue);
	System::UnicodeString __fastcall GetConnectionDefName(void);
	void __fastcall SetConnectionDefName(const System::UnicodeString AValue);
	
protected:
	virtual void __fastcall SetConnected(bool AValue);
	virtual void __fastcall SetDatabaseName(const System::UnicodeString AValue);
	virtual void __fastcall SetLoginPrompt(bool AValue);
	virtual void __fastcall SetParams(System::Classes::TStrings* AValue);
	virtual bool __fastcall GetConnected(void);
	virtual System::UnicodeString __fastcall GetDatabaseName(void);
	virtual bool __fastcall GetLoginPrompt(void);
	virtual System::Classes::TStrings* __fastcall GetParams(void);
	
public:
	__fastcall virtual TfrxFDDatabase(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxFDDatabase(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall SetLogin(const System::UnicodeString ALogin, const System::UnicodeString APassword);
	virtual System::WideString __fastcall ToString(void);
	virtual void __fastcall FromString(const System::WideString AConnection);
	__property Firedac::Comp::Client::TFDConnection* Database = {read=FDatabase};
	
__published:
	__property System::UnicodeString ConnectionDefName = {read=GetConnectionDefName, write=SetConnectionDefName};
	__property System::UnicodeString DriverName = {read=GetDriverName, write=SetDriverName};
	__property DatabaseName = {default=0};
	__property Params;
	__property LoginPrompt = {default=1};
	__property Connected = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxFDDatabase(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxCustomDatabase(AOwner, Flags) { }
	
};


typedef System::UnicodeString TfrxDataSetNotifyEvent;

typedef System::UnicodeString TfrxFilterRecordEvent;

class PASCALIMPLEMENTATION TfrxFDQuery : public Frxcustomdb::TfrxCustomQuery
{
	typedef Frxcustomdb::TfrxCustomQuery inherited;
	
private:
	TfrxFDDatabase* FDatabase;
	Firedac::Comp::Client::TFDQuery* FQuery;
	Frxcustomdb::TfrxParams* FMacroParams;
	TfrxDataSetNotifyEvent FAfterOpen;
	TfrxDataSetNotifyEvent FBeforeOpen;
	TfrxDataSetNotifyEvent FAfterScroll;
	TfrxDataSetNotifyEvent FBeforeScroll;
	TfrxFilterRecordEvent FOnFilterRecord;
	System::Classes::TStrings* FChangeFieldEventList;
	System::Classes::TStrings* FGetTextFieldEventList;
	void __fastcall SetDatabase(TfrxFDDatabase* const AValue);
	bool __fastcall GetUniDirectional(void);
	void __fastcall SetUniDirectional(const bool AValue);
	void __fastcall DoMasterSetValues(Firedac::Comp::Dataset::TFDDataSet* ASender);
	void __fastcall SetMacroParams(Frxcustomdb::TfrxParams* const Value);
	HIDESBASE void __fastcall ReadData(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteData(System::Classes::TWriter* Writer);
	void __fastcall FDMacrosToMacroParams(void);
	void __fastcall MacroParamsToFDParams(void);
	bool __fastcall GetCachedUpdates(void);
	void __fastcall SetCachedUpdates(const bool Value);
	bool __fastcall GetMacroCreate(void);
	void __fastcall SetMacroCreate(const bool Value);
	bool __fastcall GetMacroExpand(void);
	void __fastcall SetMacroExpand(const bool Value);
	int __fastcall GetFDRecNo(void);
	void __fastcall SetFDRecNo(const int Value);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall DoAfterOpen(Data::Db::TDataSet* DataSet);
	void __fastcall DoBeforeOpen(Data::Db::TDataSet* DataSet);
	void __fastcall DoAfterScroll(Data::Db::TDataSet* DataSet);
	void __fastcall DoBeforeScroll(Data::Db::TDataSet* DataSet);
	void __fastcall DoFilterRecord(Data::Db::TDataSet* DataSet, bool &Accept);
	void __fastcall DoChangeField(Data::Db::TField* Field);
	void __fastcall DoGetTextField(Data::Db::TField* Field, System::UnicodeString &Text, bool DisplayText);
	
protected:
	bool FLocked;
	System::Classes::TStrings* FStrings;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation AOperation);
	virtual void __fastcall OnChangeSQL(System::TObject* Sender);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const AValue);
	virtual void __fastcall SetMasterFields(const System::UnicodeString AValue);
	virtual void __fastcall SetSQL(System::Classes::TStrings* AValue);
	virtual System::Classes::TStrings* __fastcall GetSQL(void);
	virtual void __fastcall SetName(const System::Classes::TComponentName AName);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TfrxFDQuery(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxFDQuery(System::Classes::TComponent* AOwner, System::Word AFlags);
	__fastcall virtual ~TfrxFDQuery(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall WriteNestedProperties(Frxxml::TfrxXMLItem* Item, System::Classes::TPersistent* aAcenstor = (System::Classes::TPersistent*)(0x0));
	virtual bool __fastcall ReadNestedProperty(Frxxml::TfrxXMLItem* Item);
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall FetchParams(void);
	virtual void __fastcall UpdateParams(void);
	void __fastcall SetChangeFieldEvent(System::UnicodeString cFieldName, System::UnicodeString cEventName);
	void __fastcall SetGetTextFieldEvent(System::UnicodeString cFieldName, System::UnicodeString cEventName);
	Frxcustomdb::TfrxParamItem* __fastcall MacroByName(const System::UnicodeString MacroName);
	void __fastcall ExecSQL(void);
	void __fastcall FetchAll(void);
	void __fastcall EnableControls(void);
	void __fastcall DisableControls(void);
	System::Classes::TStream* __fastcall CreateBlobStream(Data::Db::TField* Field, Data::Db::TBlobStreamMode Mode);
	Data::Db::TField* __fastcall FindField(const System::UnicodeString FieldName);
	bool __fastcall LocateEx(const System::UnicodeString AKeyFields, const System::Variant &AKeyValues, Firedac::Comp::Dataset::TFDDataSetLocateOptions AOptions = Firedac::Comp::Dataset::TFDDataSetLocateOptions() )/* overload */;
	bool __fastcall LocateEx(const System::UnicodeString AExpression, Firedac::Comp::Dataset::TFDDataSetLocateOptions AOptions = Firedac::Comp::Dataset::TFDDataSetLocateOptions() )/* overload */;
	virtual void __fastcall Prepare(void);
	virtual bool __fastcall OpenOrExecute(void);
	virtual Fqbclass::TfqbEngine* __fastcall QBEngine(void);
	__property Firedac::Comp::Client::TFDQuery* Query = {read=FQuery};
	__property int FDRecNo = {read=GetFDRecNo, write=SetFDRecNo, nodefault};
	
__published:
	__property bool MacroCreate = {read=GetMacroCreate, write=SetMacroCreate, nodefault};
	__property bool MacroExpand = {read=GetMacroExpand, write=SetMacroExpand, nodefault};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, nodefault};
	__property SQL;
	__property TfrxFDDatabase* Database = {read=FDatabase, write=SetDatabase};
	__property bool UniDirectional = {read=GetUniDirectional, write=SetUniDirectional, default=0};
	__property MasterFields = {default=0};
	__property Frxcustomdb::TfrxParams* Macros = {read=FMacroParams, write=SetMacroParams};
	__property bool CachedUpdates = {read=GetCachedUpdates, write=SetCachedUpdates, default=0};
	__property Active = {default=0};
	__property TfrxDataSetNotifyEvent AfterOpen = {read=FAfterOpen, write=FAfterOpen};
	__property TfrxDataSetNotifyEvent BeforeOpen = {read=FBeforeOpen, write=FBeforeOpen};
	__property TfrxDataSetNotifyEvent AfterScroll = {read=FAfterScroll, write=FAfterScroll};
	__property TfrxDataSetNotifyEvent BeforeScroll = {read=FBeforeScroll, write=FBeforeScroll};
	__property TfrxFilterRecordEvent OnFilterRecord = {read=FOnFilterRecord, write=FOnFilterRecord};
	__property Left = {default=0};
	__property Top = {default=0};
};


class PASCALIMPLEMENTATION TfrxFDMemTable : public Frxcustomdb::TfrxCustomDataset
{
	typedef Frxcustomdb::TfrxCustomDataset inherited;
	
private:
	Firedac::Comp::Client::TFDMemTable* FFDMemTable;
	TfrxDataSetNotifyEvent FAfterOpen;
	TfrxDataSetNotifyEvent FBeforeOpen;
	TfrxDataSetNotifyEvent FAfterScroll;
	TfrxDataSetNotifyEvent FBeforeScroll;
	TfrxFilterRecordEvent FOnFilterRecord;
	System::Classes::TStrings* FChangeFieldEventList;
	System::Classes::TStrings* FGetTextFieldEventList;
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(const bool Value);
	bool __fastcall GetAutoCalcFields(void);
	void __fastcall SetAutoCalcFields(const bool Value);
	Data::Db::TFieldDefs* __fastcall GetFieldDefs(void);
	void __fastcall SetFieldDefs(Data::Db::TFieldDefs* const Value);
	System::UnicodeString __fastcall GetIndexFieldNames(void);
	void __fastcall SetIndexFieldNames(const System::UnicodeString Value);
	int __fastcall GetFDRecNo(void);
	void __fastcall SetFDRecNo(const int Value);
	void __fastcall DoAfterOpen(Data::Db::TDataSet* DataSet);
	void __fastcall DoBeforeOpen(Data::Db::TDataSet* DataSet);
	void __fastcall DoAfterScroll(Data::Db::TDataSet* DataSet);
	void __fastcall DoBeforeScroll(Data::Db::TDataSet* DataSet);
	void __fastcall DoFilterRecord(Data::Db::TDataSet* DataSet, bool &Accept);
	void __fastcall DoChangeField(Data::Db::TField* Field);
	void __fastcall DoGetTextField(Data::Db::TField* Field, System::UnicodeString &Text, bool DisplayText);
	
protected:
	virtual void __fastcall SetName(const System::Classes::TComponentName AName);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetMasterFields(const System::UnicodeString Value);
	
public:
	__fastcall virtual TfrxFDMemTable(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxFDMemTable(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	void __fastcall CreateDataSet(void);
	void __fastcall EnableControls(void);
	void __fastcall DisableControls(void);
	void __fastcall CopyDataSet(Data::Db::TDataSet* ASource, Firedac::Comp::Dataset::TFDCopyDataSetOptions AOptions);
	void __fastcall Refresh(void);
	Data::Db::TField* __fastcall FindField(const System::UnicodeString FieldName);
	bool __fastcall LocateEx(const System::UnicodeString AKeyFields, const System::Variant &AKeyValues, Firedac::Comp::Dataset::TFDDataSetLocateOptions AOptions = Firedac::Comp::Dataset::TFDDataSetLocateOptions() )/* overload */;
	bool __fastcall LocateEx(const System::UnicodeString AExpression, Firedac::Comp::Dataset::TFDDataSetLocateOptions AOptions = Firedac::Comp::Dataset::TFDDataSetLocateOptions() )/* overload */;
	void __fastcall SetFDData(Firedac::Comp::Dataset::TFDDataSet* ASource);
	void __fastcall SetChangeFieldEvent(System::UnicodeString cFieldName, System::UnicodeString cEventName);
	void __fastcall SetGetTextFieldEvent(System::UnicodeString cFieldName, System::UnicodeString cEventName);
	__property Firedac::Comp::Client::TFDMemTable* FDMemTable = {read=FFDMemTable};
	__property Data::Db::TFieldDefs* FieldDefs = {read=GetFieldDefs, write=SetFieldDefs};
	__property int FDRecNo = {read=GetFDRecNo, write=SetFDRecNo, nodefault};
	
__published:
	__property System::UnicodeString IndexFieldNames = {read=GetIndexFieldNames, write=SetIndexFieldNames};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool AutoCalcFields = {read=GetAutoCalcFields, write=SetAutoCalcFields, default=1};
	__property MasterFields = {default=0};
	__property Active = {default=0};
	__property TfrxDataSetNotifyEvent AfterOpen = {read=FAfterOpen, write=FAfterOpen};
	__property TfrxDataSetNotifyEvent BeforeOpen = {read=FBeforeOpen, write=FBeforeOpen};
	__property TfrxDataSetNotifyEvent AfterScroll = {read=FAfterScroll, write=FAfterScroll};
	__property TfrxDataSetNotifyEvent BeforeScroll = {read=FBeforeScroll, write=FBeforeScroll};
	__property TfrxFilterRecordEvent OnFilterRecord = {read=FOnFilterRecord, write=FOnFilterRecord};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxFDMemTable(System::Classes::TComponent* AOwner, System::Word Flags) : Frxcustomdb::TfrxCustomDataset(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxFDTable : public Frxcustomdb::TfrxCustomTable
{
	typedef Frxcustomdb::TfrxCustomTable inherited;
	
private:
	TfrxFDDatabase* FDatabase;
	Firedac::Comp::Client::TFDTable* FTable;
	void __fastcall SetDatabase(TfrxFDDatabase* const AValue);
	System::UnicodeString __fastcall GetCatalogName(void);
	System::UnicodeString __fastcall GetSchemaName(void);
	void __fastcall SetCatalogName(const System::UnicodeString AValue);
	void __fastcall SetSchemaName(const System::UnicodeString AValue);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation AOperation);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const AValue);
	virtual void __fastcall SetMasterFields(const System::UnicodeString AValue);
	virtual void __fastcall SetIndexFieldNames(const System::UnicodeString AValue);
	virtual void __fastcall SetIndexName(const System::UnicodeString AValue);
	virtual void __fastcall SetTableName(const System::UnicodeString AValue);
	virtual System::UnicodeString __fastcall GetIndexFieldNames(void);
	virtual System::UnicodeString __fastcall GetIndexName(void);
	virtual System::UnicodeString __fastcall GetTableName(void);
	
public:
	__fastcall virtual TfrxFDTable(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxFDTable(System::Classes::TComponent* AOwner, System::Word AFlags);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	__property Firedac::Comp::Client::TFDTable* Table = {read=FTable};
	
__published:
	__property TfrxFDDatabase* Database = {read=FDatabase, write=SetDatabase};
	__property System::UnicodeString CatalogName = {read=GetCatalogName, write=SetCatalogName};
	__property System::UnicodeString SchemaName = {read=GetSchemaName, write=SetSchemaName};
public:
	/* TfrxCustomDataset.Destroy */ inline __fastcall virtual ~TfrxFDTable(void) { }
	
};


class PASCALIMPLEMENTATION TfrxCustomStoredProc : public Frxcustomdb::TfrxCustomDataset
{
	typedef Frxcustomdb::TfrxCustomDataset inherited;
	
private:
	Frxcustomdb::TfrxParams* FParams;
	Data::Db::TDataSetNotifyEvent FSaveOnBeforeOpen;
	Data::Db::TDataSetNotifyEvent FSaveOnAfterOpen;
	void __fastcall ReadParamData(System::Classes::TReader* AReader);
	void __fastcall WriteParamData(System::Classes::TWriter* AWriter);
	void __fastcall SetParams(Frxcustomdb::TfrxParams* AValue);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* AFiler);
	virtual System::UnicodeString __fastcall GetStoredProcName(void);
	virtual void __fastcall SetStoredProcName(const System::UnicodeString AValue);
	virtual void __fastcall TriggerOnBeforeOpen(Data::Db::TDataSet* ADataSet);
	virtual void __fastcall TriggerOnAfterOpen(Data::Db::TDataSet* ADataSet);
	
public:
	__fastcall virtual TfrxCustomStoredProc(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomStoredProc(void);
	virtual void __fastcall ExecProc(void);
	virtual void __fastcall UpdateParams(void);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall FetchParams(void);
	Frxcustomdb::TfrxParamItem* __fastcall ParamByName(const System::UnicodeString AValue);
	virtual bool __fastcall OpenOrExecute(void);
	virtual System::Variant __fastcall ExecFunc(void);
	
__published:
	__property Frxcustomdb::TfrxParams* Params = {read=FParams, write=SetParams};
	__property System::UnicodeString StoredProcName = {read=GetStoredProcName, write=SetStoredProcName};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomStoredProc(System::Classes::TComponent* AOwner, System::Word Flags) : Frxcustomdb::TfrxCustomDataset(AOwner, Flags) { }
	
};


class PASCALIMPLEMENTATION TfrxFDStoredProc : public TfrxCustomStoredProc
{
	typedef TfrxCustomStoredProc inherited;
	
private:
	TfrxFDDatabase* FDatabase;
	Firedac::Comp::Client::TFDStoredProc* FStoredProc;
	void __fastcall DoMasterSetValues(Firedac::Comp::Dataset::TFDDataSet* ASender);
	void __fastcall SetDatabase(TfrxFDDatabase* const AValue);
	System::UnicodeString __fastcall GetPackageName(void);
	void __fastcall SetPackageName(const System::UnicodeString AValue);
	System::UnicodeString __fastcall GetCatalogName(void);
	System::UnicodeString __fastcall GetSchemaName(void);
	void __fastcall SetCatalogName(const System::UnicodeString AValue);
	void __fastcall SetSchemaName(const System::UnicodeString AValue);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation AOperation);
	virtual System::UnicodeString __fastcall GetStoredProcName(void);
	virtual void __fastcall SetStoredProcName(const System::UnicodeString AValue);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const AValue);
	virtual void __fastcall TriggerOnAfterOpen(Data::Db::TDataSet* ADataSet);
	
public:
	__fastcall virtual TfrxFDStoredProc(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxFDStoredProc(System::Classes::TComponent* AOwner, System::Word AFlags);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall ExecProc(void);
	virtual void __fastcall Prepare(void);
	virtual void __fastcall UpdateParams(void);
	virtual void __fastcall FetchParams(void);
	virtual bool __fastcall OpenOrExecute(void);
	virtual System::Variant __fastcall ExecFunc(void);
	__property Firedac::Comp::Client::TFDStoredProc* StoredProc = {read=FStoredProc};
	
__published:
	__property TfrxFDDatabase* Database = {read=FDatabase, write=SetDatabase};
	__property System::UnicodeString CatalogName = {read=GetCatalogName, write=SetCatalogName};
	__property System::UnicodeString SchemaName = {read=GetSchemaName, write=SetSchemaName};
	__property System::UnicodeString PackageName = {read=GetPackageName, write=SetPackageName};
public:
	/* TfrxCustomStoredProc.Destroy */ inline __fastcall virtual ~TfrxFDStoredProc(void) { }
	
};


class PASCALIMPLEMENTATION TfrxEngineFD : public Fqbclass::TfqbEngine
{
	typedef Fqbclass::TfqbEngine inherited;
	
private:
	Firedac::Comp::Client::TFDQuery* FQuery;
	
public:
	__fastcall virtual TfrxEngineFD(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxEngineFD(void);
	virtual void __fastcall ReadTableList(System::Classes::TStrings* ATableList);
	virtual void __fastcall ReadFieldList(const System::UnicodeString ATableName, Fqbclass::TfqbFieldList* &AFieldList);
	virtual Data::Db::TDataSet* __fastcall ResultDataSet(void);
	virtual void __fastcall SetSQL(const System::UnicodeString AValue);
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxFDComponents* GFDComponents;
}	/* namespace Frxfdcomponents */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXFDCOMPONENTS)
using namespace Frxfdcomponents;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxfdcomponentsHPP
