// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxQRCodeSberPreset.pas' rev: 32.00 (Windows)

#ifndef FrxqrcodesberpresetHPP
#define FrxqrcodesberpresetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <frxClass.hpp>
#include <System.TypInfo.hpp>
#include <frxBarcode2D.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxqrcodesberpreset
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCustomPresetAttr;
class DELPHICLASS TfrxSberPayee;
class DELPHICLASS TfrxSberPayeeAdditionalInfo;
class DELPHICLASS TfrxSberDepartmentalInfo;
class DELPHICLASS TfrxSberRequiredBankingDetails;
class DELPHICLASS TfrxSberAdditionalBankingDetails;
class DELPHICLASS TfrxSberOtherAdditionalBankingDetails;
class DELPHICLASS TfrxSberData;
class DELPHICLASS TfrxSberPaymentPreset;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxSberEncoding : unsigned char { ec_WIN1251, ec_UTF8, ec_KOI8_R };

enum DECLSPEC_DENUM TfrxFieldTypesQR : unsigned char { fdExpression, fdStatic };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCustomPresetAttr : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::WideChar FSeparator;
	TfrxSberEncoding FEncoding;
	TfrxFieldTypesQR FFieldTypes;
	System::UnicodeString __fastcall GetValue(Frxclass::TfrxReport* aReport, const System::UnicodeString aFileld, const System::UnicodeString aFileldName);
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport) = 0 ;
	
__published:
	TfrxSberEncoding __fastcall GetEncoding(void);
	System::WideChar __fastcall GetSeparator(void);
	TfrxFieldTypesQR __fastcall GetFieldTypes(void);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxCustomPresetAttr(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxCustomPresetAttr(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSberPayee : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FName;
	System::UnicodeString FPersonalAcc;
	System::UnicodeString FBankName;
	System::UnicodeString FBIC;
	System::UnicodeString FCorrespAcc;
	void __fastcall SetName(System::UnicodeString val);
	void __fastcall SetPersonalAcc(System::UnicodeString val);
	void __fastcall SetBankName(System::UnicodeString val);
	void __fastcall SetBIC(System::UnicodeString val);
	void __fastcall SetCorrespAcc(System::UnicodeString val);
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString PersonalAcc = {read=FPersonalAcc, write=SetPersonalAcc};
	__property System::UnicodeString BankName = {read=FBankName, write=SetBankName};
	__property System::UnicodeString BIC = {read=FBIC, write=SetBIC};
	__property System::UnicodeString CorrespAcc = {read=FCorrespAcc, write=SetCorrespAcc};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSberPayee(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSberPayee(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSberPayeeAdditionalInfo : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FPayeeINN;
	System::UnicodeString FKPP;
	void __fastcall SetPayeeINN(System::UnicodeString val);
	void __fastcall SetKPP(System::UnicodeString val);
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString PayeeINN = {read=FPayeeINN, write=SetPayeeINN};
	__property System::UnicodeString KPP = {read=FKPP, write=SetKPP};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSberPayeeAdditionalInfo(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSberPayeeAdditionalInfo(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSberDepartmentalInfo : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FDrawerStatus;
	System::UnicodeString FCBC;
	System::UnicodeString FOKTMO;
	System::UnicodeString FPaytReason;
	System::UnicodeString FTaxPeriod;
	System::UnicodeString FDocNo;
	System::UnicodeString FDocDate;
	System::UnicodeString FTaxPaytKind;
	void __fastcall SetDrawerStatus(System::UnicodeString val);
	void __fastcall SetCBC(System::UnicodeString val);
	void __fastcall SetOKTMO(System::UnicodeString val);
	void __fastcall SetPaytReason(System::UnicodeString val);
	void __fastcall SetTaxPeriod(System::UnicodeString val);
	void __fastcall SetDocNo(System::UnicodeString val);
	void __fastcall SetDocDate(System::UnicodeString val);
	void __fastcall SetTaxPaytKind(System::UnicodeString val);
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString DrawerStatus = {read=FDrawerStatus, write=SetDrawerStatus};
	__property System::UnicodeString CBC = {read=FCBC, write=SetCBC};
	__property System::UnicodeString OKTMO = {read=FOKTMO, write=SetOKTMO};
	__property System::UnicodeString PaytReason = {read=FPaytReason, write=SetPaytReason};
	__property System::UnicodeString TaxPeriod = {read=FTaxPeriod, write=SetTaxPeriod};
	__property System::UnicodeString DocNo = {read=FDocNo, write=SetDocNo};
	__property System::UnicodeString DocDate = {read=FDocDate, write=SetDocDate};
	__property System::UnicodeString TaxPaytKind = {read=FTaxPaytKind, write=SetTaxPaytKind};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSberDepartmentalInfo(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSberDepartmentalInfo(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSberRequiredBankingDetails : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	TfrxSberPayee* FPayee;
	void __fastcall SetPayee(TfrxSberPayee* val);
	
public:
	__fastcall TfrxSberRequiredBankingDetails(void);
	__fastcall virtual ~TfrxSberRequiredBankingDetails(void);
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property TfrxSberPayee* Payee = {read=FPayee, write=SetPayee};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSberAdditionalBankingDetails : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FSum;
	System::UnicodeString FPurpose;
	TfrxSberPayeeAdditionalInfo* FPayeeAdditionalInfo;
	System::UnicodeString FPayerINN;
	TfrxSberDepartmentalInfo* FDepartmentalInfo;
	void __fastcall SetSum(System::UnicodeString val);
	void __fastcall SetPurpose(System::UnicodeString val);
	void __fastcall SetPayeeAdditionalInfo(TfrxSberPayeeAdditionalInfo* val);
	void __fastcall SetPayerINN(System::UnicodeString val);
	void __fastcall SetDepartmentalInfo(TfrxSberDepartmentalInfo* val);
	
public:
	__fastcall TfrxSberAdditionalBankingDetails(void);
	__fastcall virtual ~TfrxSberAdditionalBankingDetails(void);
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString Sum = {read=FSum, write=SetSum};
	__property System::UnicodeString Purpose = {read=FPurpose, write=SetPurpose};
	__property TfrxSberPayeeAdditionalInfo* PayeeAdditionalInfo = {read=FPayeeAdditionalInfo, write=SetPayeeAdditionalInfo};
	__property System::UnicodeString PayerINN = {read=FPayerINN, write=SetPayerINN};
	__property TfrxSberDepartmentalInfo* DepartmentalInfo = {read=FDepartmentalInfo, write=SetDepartmentalInfo};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSberOtherAdditionalBankingDetails : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FLastName;
	System::UnicodeString FFirstName;
	System::UnicodeString FMiddleName;
	System::UnicodeString FPayerAddress;
	System::UnicodeString FPersonalAccount;
	System::UnicodeString FDocIdx;
	System::UnicodeString FPensAcc;
	System::UnicodeString FContract;
	System::UnicodeString FPersAcc;
	System::UnicodeString FFlat;
	System::UnicodeString FPhone;
	System::UnicodeString FPayerIdType;
	System::UnicodeString FPayerIdNum;
	System::UnicodeString FChildFio;
	System::UnicodeString FBirthDate;
	System::UnicodeString FPaymTerm;
	System::UnicodeString FPaymPeriod;
	System::UnicodeString FCategory;
	System::UnicodeString FServiceName;
	System::UnicodeString FCounterId;
	System::UnicodeString FCounterVal;
	System::UnicodeString FQuittId;
	System::UnicodeString FInstNum;
	System::UnicodeString FClassNum;
	System::UnicodeString FSpecFio;
	System::UnicodeString FAddAmount;
	System::UnicodeString FRuleId;
	System::UnicodeString FExecId;
	System::UnicodeString FRegType;
	System::UnicodeString FUIN;
	System::UnicodeString FTechCode;
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString LastName = {read=FLastName, write=FLastName};
	__property System::UnicodeString FirstName = {read=FFirstName, write=FFirstName};
	__property System::UnicodeString MiddleName = {read=FMiddleName, write=FMiddleName};
	__property System::UnicodeString PayerAddress = {read=FPayerAddress, write=FPayerAddress};
	__property System::UnicodeString PersonalAccount = {read=FPersonalAccount, write=FPersonalAccount};
	__property System::UnicodeString DocIdx = {read=FDocIdx, write=FDocIdx};
	__property System::UnicodeString PensAcc = {read=FPensAcc, write=FPensAcc};
	__property System::UnicodeString Contract = {read=FContract, write=FContract};
	__property System::UnicodeString PersAcc = {read=FPersAcc, write=FPersAcc};
	__property System::UnicodeString Flat = {read=FFlat, write=FFlat};
	__property System::UnicodeString Phone = {read=FPhone, write=FPhone};
	__property System::UnicodeString PayerIdType = {read=FPayerIdType, write=FPayerIdType};
	__property System::UnicodeString PayerIdNum = {read=FPayerIdNum, write=FPayerIdNum};
	__property System::UnicodeString ChildFio = {read=FChildFio, write=FChildFio};
	__property System::UnicodeString BirthDate = {read=FBirthDate, write=FBirthDate};
	__property System::UnicodeString PaymTerm = {read=FPaymTerm, write=FPaymTerm};
	__property System::UnicodeString PaymPeriod = {read=FPaymPeriod, write=FPaymPeriod};
	__property System::UnicodeString Category = {read=FCategory, write=FCategory};
	__property System::UnicodeString ServiceName = {read=FServiceName, write=FServiceName};
	__property System::UnicodeString CounterId = {read=FCounterId, write=FCounterId};
	__property System::UnicodeString CounterVal = {read=FCounterVal, write=FCounterVal};
	__property System::UnicodeString QuittId = {read=FQuittId, write=FQuittId};
	__property System::UnicodeString InstNum = {read=FInstNum, write=FInstNum};
	__property System::UnicodeString ClassNum = {read=FClassNum, write=FClassNum};
	__property System::UnicodeString SpecFio = {read=FSpecFio, write=FSpecFio};
	__property System::UnicodeString AddAmount = {read=FAddAmount, write=FAddAmount};
	__property System::UnicodeString RuleId = {read=FRuleId, write=FRuleId};
	__property System::UnicodeString ExecId = {read=FExecId, write=FExecId};
	__property System::UnicodeString RegType = {read=FRegType, write=FRegType};
	__property System::UnicodeString UIN = {read=FUIN, write=FUIN};
	__property System::UnicodeString TechCode = {read=FTechCode, write=FTechCode};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSberOtherAdditionalBankingDetails(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSberOtherAdditionalBankingDetails(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSberData : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FIdFormat;
	System::UnicodeString FVersion;
	TfrxSberRequiredBankingDetails* FRequiredBankingDetails;
	TfrxSberAdditionalBankingDetails* FAdditionalBankingDetails;
	TfrxSberOtherAdditionalBankingDetails* FOtherAdditionalBankingDetails;
	void __fastcall SetIdFormat(System::UnicodeString val);
	void __fastcall SetVersion(System::UnicodeString val);
	void __fastcall SetEncoding(TfrxSberEncoding val);
	void __fastcall SetSeparator(System::WideChar val);
	void __fastcall SetFieldTypes(TfrxFieldTypesQR val);
	
public:
	__fastcall TfrxSberData(void);
	__fastcall virtual ~TfrxSberData(void);
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString IdFormat = {read=FIdFormat, write=SetIdFormat};
	__property System::UnicodeString Version = {read=FVersion, write=SetVersion};
	__property TfrxSberEncoding Encoding = {read=GetEncoding, write=SetEncoding, default=0};
	__property System::WideChar Separator = {read=GetSeparator, write=SetSeparator, default=124};
	__property TfrxFieldTypesQR FieldTypes = {read=GetFieldTypes, write=SetFieldTypes, default=0};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSberPaymentPreset : public Frxclass::TfrxCustomObjectPreset
{
	typedef Frxclass::TfrxCustomObjectPreset inherited;
	
private:
	TfrxSberData* FSberData;
	int FSaveErrorLevels;
	bool FSaveMarker;
	bool FSaveShowText;
	TfrxSberRequiredBankingDetails* __fastcall GetRequiredBankingDetails(void);
	TfrxSberAdditionalBankingDetails* __fastcall GetAdditionalBankingDetails(void);
	TfrxSberOtherAdditionalBankingDetails* __fastcall GetOtherAdditionalBankingDetails(void);
	
public:
	__fastcall virtual TfrxSberPaymentPreset(void);
	__fastcall virtual ~TfrxSberPaymentPreset(void);
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	virtual void __fastcall ApplySettings(Frxclass::TfrxComponent* aComponent);
	virtual void __fastcall SaveComponentState(Frxclass::TfrxComponent* aComponent);
	virtual void __fastcall RestoreComponentState(Frxclass::TfrxComponent* aComponent);
	
__published:
	__property TfrxSberData* SberData = {read=FSberData};
	__property TfrxSberRequiredBankingDetails* RequiredBankingDetails = {read=GetRequiredBankingDetails};
	__property TfrxSberAdditionalBankingDetails* AdditionalBankingDetails = {read=GetAdditionalBankingDetails};
	__property TfrxSberOtherAdditionalBankingDetails* OtherAdditionalBankingDetails = {read=GetOtherAdditionalBankingDetails};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxqrcodesberpreset */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXQRCODESBERPRESET)
using namespace Frxqrcodesberpreset;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxqrcodesberpresetHPP
