// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRAbsDatas.pas' rev: 32.00 (Windows)

#ifndef QrabsdatasHPP
#define QrabsdatasHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Data.DB.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrabsdatas
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRAbsTable;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TQRDataAbsSetEvent)(const System::UnicodeString DataStr, Data::Db::TField* Field, void * buffer);

typedef void __fastcall (__closure *TQRAbsRecordEvent)(TQRAbsTable* Sender, bool &Moredata);

class PASCALIMPLEMENTATION TQRAbsTable : public Data::Db::TDataSet
{
	typedef Data::Db::TDataSet inherited;
	
private:
	TQRDataAbsSetEvent FOnSetFieldValue;
	TQRAbsRecordEvent FOnGetRecord;
	System::Word FRecBufSize;
	System::Word FRecordSize;
	int FDefFieldLen;
	int FRecordCount;
	int FCurRecord;
	bool FEOF;
	bool FBOF;
	bool FMoredata;
	bool FDoneFielddefs;
	System::Classes::TStringList* FFieldnames;
	Data::Db::TGetMode FLastGetOp;
	Data::Db::TGetMode FCurrentGetOp;
	
protected:
	void __fastcall ClearData(void);
	virtual System::PByte __fastcall AllocRecordBuffer(void);
	virtual void __fastcall FreeRecordBuffer(System::PByte &Buffer);
	virtual void __fastcall GetBookmarkData(System::PByte Buffer, void * Data)/* overload */;
	virtual Data::Db::TBookmarkFlag __fastcall GetBookmarkFlag(System::PByte Buffer)/* overload */;
	virtual Data::Db::TGetResult __fastcall GetRecord(System::PByte Buffer, Data::Db::TGetMode GetMode, bool DoCheck)/* overload */;
	virtual System::Word __fastcall GetRecordSize(void);
	virtual void __fastcall InternalAddRecord(void * Buffer, bool Append)/* overload */;
	virtual void __fastcall InternalClose(void);
	virtual void __fastcall InternalDelete(void);
	virtual void __fastcall InternalFirst(void);
	virtual void __fastcall InternalGotoBookmark(void * Bookmark)/* overload */;
	virtual void __fastcall InternalHandleException(void);
	virtual void __fastcall InternalInitFieldDefs(void);
	virtual void __fastcall InternalInitRecord(System::PByte Buffer)/* overload */;
	virtual void __fastcall InternalLast(void);
	virtual void __fastcall InternalOpen(void);
	virtual void __fastcall InternalPost(void);
	virtual void __fastcall InternalSetToRecord(System::PByte Buffer)/* overload */;
	virtual bool __fastcall IsCursorOpen(void);
	virtual void __fastcall SetBookmarkFlag(System::PByte Buffer, Data::Db::TBookmarkFlag Value)/* overload */;
	virtual void __fastcall SetBookmarkData(System::PByte Buffer, void * Data)/* overload */;
	virtual void __fastcall SetFieldData(Data::Db::TField* Field, void * Buffer)/* overload */;
	virtual void __fastcall SetFieldData(Data::Db::TField* Field, void * Buffer, bool NativeFormat)/* overload */;
	virtual void __fastcall ActivateBuffers(void);
	virtual void __fastcall CreateFields(void);
	virtual int __fastcall GetRecordCount(void);
	virtual int __fastcall GetRecNo(void);
	
public:
	__fastcall virtual TQRAbsTable(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TQRAbsTable(void);
	virtual bool __fastcall GetFieldData(Data::Db::TField* Field, void * Buffer)/* overload */;
	virtual bool __fastcall GetFieldData(Data::Db::TField* Field, void * Buffer, bool NativeFormat)/* overload */;
	virtual int __fastcall MoveBy(int Distance);
	HIDESBASE void __fastcall Next(void);
	
__published:
	__property Active = {default=0};
	__property TQRAbsRecordEvent OnGetRecord = {read=FOnGetRecord, write=FOnGetRecord};
	__property TQRDataAbsSetEvent OnSetFieldValue = {read=FOnSetFieldValue, write=FOnSetFieldValue};
	__property int RecordCount = {read=FRecordCount, nodefault};
	__property int CurrentRecord = {read=FCurRecord, nodefault};
	__property int DefFieldLen = {read=FDefFieldLen, write=FDefFieldLen, default=50};
	__property bool EOF = {read=FEOF, nodefault};
	__property bool BOF = {read=FBOF, nodefault};
	__property FieldDefs;
	__property BeforeOpen;
	__property AfterOpen;
	__property BeforeClose;
	__property AfterClose;
	__property BeforeScroll;
	__property AfterScroll;
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  GetBookmarkData(NativeInt Buffer, System::DynamicArray<System::Byte> Data){ Data::Db::TDataSet::GetBookmarkData(Buffer, Data); }
	inline void __fastcall  GetBookmarkData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (System::PByte Buffer, System::DynamicArray<System::Byte> Data){ Data::Db::TDataSet::GetBookmarkData(Buffer, Data); }
	inline Data::Db::TBookmarkFlag __fastcall  GetBookmarkFlag(NativeInt Buffer){ return Data::Db::TDataSet::GetBookmarkFlag(Buffer); }
	inline Data::Db::TGetResult __fastcall  GetRecord(NativeInt Buffer, Data::Db::TGetMode GetMode, bool DoCheck){ return Data::Db::TDataSet::GetRecord(Buffer, GetMode, DoCheck); }
	inline void __fastcall  InternalAddRecord(NativeInt Buffer, bool Append){ Data::Db::TDataSet::InternalAddRecord(Buffer, Append); }
	inline void __fastcall  InternalAddRecord _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (System::PByte Buffer, bool Append){ Data::Db::TDataSet::InternalAddRecord(Buffer, Append); }
	inline void __fastcall  InternalGotoBookmark(System::DynamicArray<System::Byte> Bookmark){ Data::Db::TDataSet::InternalGotoBookmark(Bookmark); }
	inline void __fastcall  InternalInitRecord(NativeInt Buffer){ Data::Db::TDataSet::InternalInitRecord(Buffer); }
	inline void __fastcall  InternalSetToRecord(NativeInt Buffer){ Data::Db::TDataSet::InternalSetToRecord(Buffer); }
	inline void __fastcall  SetBookmarkFlag(NativeInt Buffer, Data::Db::TBookmarkFlag Value){ Data::Db::TDataSet::SetBookmarkFlag(Buffer, Value); }
	inline void __fastcall  SetBookmarkData(NativeInt Buffer, System::DynamicArray<System::Byte> Data){ Data::Db::TDataSet::SetBookmarkData(Buffer, Data); }
	inline void __fastcall  SetBookmarkData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (System::PByte Buffer, System::DynamicArray<System::Byte> Data){ Data::Db::TDataSet::SetBookmarkData(Buffer, Data); }
	inline void __fastcall  SetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> Buffer){ Data::Db::TDataSet::SetFieldData(Field, Buffer); }
	inline void __fastcall  SetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> Buffer, bool NativeFormat){ Data::Db::TDataSet::SetFieldData(Field, Buffer, NativeFormat); }
	
public:
	inline bool __fastcall  GetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> &Buffer){ return Data::Db::TDataSet::GetFieldData(Field, Buffer); }
	inline bool __fastcall  GetFieldData(int FieldNo, System::DynamicArray<System::Byte> &Buffer){ return Data::Db::TDataSet::GetFieldData(FieldNo, Buffer); }
	inline bool __fastcall  GetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> &Buffer, bool NativeFormat){ return Data::Db::TDataSet::GetFieldData(Field, Buffer, NativeFormat); }
	inline bool __fastcall  GetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (int FieldNo, void * Buffer){ return Data::Db::TDataSet::GetFieldData(FieldNo, Buffer); }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word MAX_STRING = System::Word(0xfa00);
extern DELPHI_PACKAGE System::UnicodeString __fastcall StripXChars(System::UnicodeString ss);
}	/* namespace Qrabsdatas */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QRABSDATAS)
using namespace Qrabsdatas;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrabsdatasHPP
