﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerReportsList.pas' rev: 32.00 (Windows)

#ifndef FrxserverreportslistHPP
#define FrxserverreportslistHPP

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
#include <frxClass.hpp>
#include <frxServerTemplates.hpp>
#include <frxXML.hpp>
#include <System.SyncObjs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxserverreportslist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxServerReportsListItem;
class DELPHICLASS TfrxServerReportsList;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerReportsListItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FFileName;
	System::UnicodeString FDescription;
	System::UnicodeString FName;
	System::Classes::TStringList* FGroups;
	int FCacheLatency;
	
public:
	__fastcall virtual TfrxServerReportsListItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TfrxServerReportsListItem(void);
	
__published:
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property System::UnicodeString ReportName = {read=FName, write=FName};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property System::Classes::TStringList* Groups = {read=FGroups};
	__property int CacheLatency = {read=FCacheLatency, write=FCacheLatency, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerReportsList : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
private:
	System::UnicodeString FReportsPath;
	TfrxServerReportsListItem* __fastcall GetItems(int Index);
	void __fastcall BuildListInFolder(const System::UnicodeString Folder);
	HIDESBASE TfrxServerReportsListItem* __fastcall GetItem(System::UnicodeString Name);
	
public:
	__fastcall TfrxServerReportsList(void);
	__fastcall virtual ~TfrxServerReportsList(void);
	__property TfrxServerReportsListItem* Items[int Index] = {read=GetItems};
	void __fastcall BuildListOfReports(void);
	int __fastcall GetCacheLatency(const System::UnicodeString FileName);
	bool __fastcall GetGroupMembership(const System::UnicodeString FileName, const System::UnicodeString Group);
	
__published:
	HIDESBASE TfrxServerReportsListItem* __fastcall Add(void);
	__property System::UnicodeString ReportsPath = {read=FReportsPath, write=FReportsPath};
	void __fastcall GetReports4Group(const System::UnicodeString GroupName, System::AnsiString &Html, System::AnsiString &Lines);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxServerReportsList* ReportsList;
}	/* namespace Frxserverreportslist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERREPORTSLIST)
using namespace Frxserverreportslist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverreportslistHPP
