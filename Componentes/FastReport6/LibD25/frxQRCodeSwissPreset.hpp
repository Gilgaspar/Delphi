// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxQRCodeSwissPreset.pas' rev: 32.00 (Windows)

#ifndef FrxqrcodeswisspresetHPP
#define FrxqrcodeswisspresetHPP

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
#include <frxBarcode2D.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxqrcodeswisspreset
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxCustomPresetAttr;
class DELPHICLASS TfrxSPCreditorInformation;
class DELPHICLASS TfrxSPPersonInfo;
class DELPHICLASS TfrxSPCreditor;
class DELPHICLASS TfrxSPUltimateInfo;
class DELPHICLASS TfrxSPUltimateCreditor;
class DELPHICLASS TfrxSPPaymentAmountInfo;
class DELPHICLASS TfrxSPUltimateDebtor;
class DELPHICLASS TfrxSPPaymentReference;
class DELPHICLASS TfrxSPAdditionalInformation;
class DELPHICLASS TfrxSPAlternativeSchemes;
class DELPHICLASS TfrxSwissPaymentPreset;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCustomPresetAttr : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString __fastcall GetValue(Frxclass::TfrxReport* aReport, const System::UnicodeString aFileld);
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport) = 0 ;
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxCustomPresetAttr(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxCustomPresetAttr(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPCreditorInformation : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FIBAN;
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString IBAN = {read=FIBAN, write=FIBAN};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPCreditorInformation(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPCreditorInformation(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TfrxSPAddressType : unsigned char { frAddT_S, frAddT_K };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPPersonInfo : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FTown;
	System::UnicodeString FName;
	System::UnicodeString FAddressTypeExp;
	System::UnicodeString FPostalCode;
	System::UnicodeString FAddressLine2;
	System::UnicodeString FAddressLine1;
	TfrxSPAddressType FAddressType;
	System::UnicodeString FCountry;
	
protected:
	virtual System::UnicodeString __fastcall GetAddrType(Frxclass::TfrxReport* aReport);
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	__property TfrxSPAddressType AddressType = {read=FAddressType, write=FAddressType, nodefault};
	__property System::UnicodeString AddressTypeExp = {read=FAddressTypeExp, write=FAddressTypeExp};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::UnicodeString AddressLine1 = {read=FAddressLine1, write=FAddressLine1};
	__property System::UnicodeString AddressLine2 = {read=FAddressLine2, write=FAddressLine2};
	__property System::UnicodeString PostalCode = {read=FPostalCode, write=FPostalCode};
	__property System::UnicodeString Town = {read=FTown, write=FTown};
	__property System::UnicodeString Country = {read=FCountry, write=FCountry};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPPersonInfo(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPPersonInfo(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPCreditor : public TfrxSPPersonInfo
{
	typedef TfrxSPPersonInfo inherited;
	
__published:
	__property AddressType;
	__property AddressTypeExp = {default=0};
	__property Name = {default=0};
	__property AddressLine1 = {default=0};
	__property AddressLine2 = {default=0};
	__property PostalCode = {default=0};
	__property Town = {default=0};
	__property Country = {default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPCreditor(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPCreditor(void) : TfrxSPPersonInfo() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPUltimateInfo : public TfrxSPPersonInfo
{
	typedef TfrxSPPersonInfo inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetAddrType(Frxclass::TfrxReport* aReport);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPUltimateInfo(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPUltimateInfo(void) : TfrxSPPersonInfo() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPUltimateCreditor : public TfrxSPUltimateInfo
{
	typedef TfrxSPUltimateInfo inherited;
	
__published:
	__property AddressType;
	__property AddressTypeExp = {default=0};
	__property Name = {default=0};
	__property AddressLine1 = {default=0};
	__property AddressLine2 = {default=0};
	__property PostalCode = {default=0};
	__property Town = {default=0};
	__property Country = {default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPUltimateCreditor(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPUltimateCreditor(void) : TfrxSPUltimateInfo() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPPaymentAmountInfo : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FAmount;
	System::UnicodeString FCurrency;
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString Amount = {read=FAmount, write=FAmount};
	__property System::UnicodeString Currency = {read=FCurrency, write=FCurrency};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPPaymentAmountInfo(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPPaymentAmountInfo(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPUltimateDebtor : public TfrxSPUltimateInfo
{
	typedef TfrxSPUltimateInfo inherited;
	
__published:
	__property AddressType;
	__property AddressTypeExp = {default=0};
	__property Name = {default=0};
	__property AddressLine1 = {default=0};
	__property AddressLine2 = {default=0};
	__property PostalCode = {default=0};
	__property Town = {default=0};
	__property Country = {default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPUltimateDebtor(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPUltimateDebtor(void) : TfrxSPUltimateInfo() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TfrxSPReferenceType : unsigned char { frRT_QRR, frRT_SCOR, frRT_NON };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPPaymentReference : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	TfrxSPReferenceType FReferenceTyp;
	System::UnicodeString FReference;
	System::UnicodeString FReferenceTypExp;
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property TfrxSPReferenceType ReferenceTyp = {read=FReferenceTyp, write=FReferenceTyp, nodefault};
	__property System::UnicodeString ReferenceTypExp = {read=FReferenceTypExp, write=FReferenceTypExp};
	__property System::UnicodeString Reference = {read=FReference, write=FReference};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPPaymentReference(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPPaymentReference(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPAdditionalInformation : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FUnstructuredMessage;
	System::UnicodeString FBillInformation;
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString UnstructuredMessage = {read=FUnstructuredMessage, write=FUnstructuredMessage};
	__property System::UnicodeString BillInformation = {read=FBillInformation, write=FBillInformation};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPAdditionalInformation(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPAdditionalInformation(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSPAlternativeSchemes : public TfrxCustomPresetAttr
{
	typedef TfrxCustomPresetAttr inherited;
	
private:
	System::UnicodeString FSchemeParameterOne;
	System::UnicodeString FSchemeParameterTwo;
	
public:
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	
__published:
	__property System::UnicodeString SchemeParameterOne = {read=FSchemeParameterOne, write=FSchemeParameterOne};
	__property System::UnicodeString SchemeParameterTwo = {read=FSchemeParameterTwo, write=FSchemeParameterTwo};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxSPAlternativeSchemes(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxSPAlternativeSchemes(void) : TfrxCustomPresetAttr() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSwissPaymentPreset : public Frxclass::TfrxCustomObjectPreset
{
	typedef Frxclass::TfrxCustomObjectPreset inherited;
	
private:
	TfrxSPAlternativeSchemes* FAlternativeSchemes;
	TfrxSPPaymentReference* FPaymentReference;
	TfrxSPPaymentAmountInfo* FPaymentAmountInfo;
	TfrxSPUltimateCreditor* FUltimateCreditor;
	TfrxSPCreditor* FCreditor;
	TfrxSPCreditorInformation* FCreditorInformation;
	TfrxSPUltimateDebtor* FUltimateDebtor;
	TfrxSPAdditionalInformation* FAdditionalInformation;
	int FSaveErrorLevels;
	Vcl::Graphics::TGraphic* FSaveGraphic;
	
public:
	__fastcall virtual TfrxSwissPaymentPreset(void);
	__fastcall virtual ~TfrxSwissPaymentPreset(void);
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	virtual void __fastcall ApplySettings(Frxclass::TfrxComponent* aComponent);
	virtual void __fastcall SaveComponentState(Frxclass::TfrxComponent* aComponent);
	virtual void __fastcall RestoreComponentState(Frxclass::TfrxComponent* aComponent);
	
__published:
	__property TfrxSPCreditorInformation* CreditorInformation = {read=FCreditorInformation};
	__property TfrxSPCreditor* Creditor = {read=FCreditor};
	__property TfrxSPUltimateCreditor* UltimateCreditor = {read=FUltimateCreditor};
	__property TfrxSPPaymentAmountInfo* PaymentAmountInfo = {read=FPaymentAmountInfo};
	__property TfrxSPUltimateDebtor* UltimateDebtor = {read=FUltimateDebtor};
	__property TfrxSPPaymentReference* PaymentReference = {read=FPaymentReference};
	__property TfrxSPAdditionalInformation* AdditionalInformation = {read=FAdditionalInformation};
	__property TfrxSPAlternativeSchemes* AlternativeSchemes = {read=FAlternativeSchemes};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxqrcodeswisspreset */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXQRCODESWISSPRESET)
using namespace Frxqrcodeswisspreset;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxqrcodeswisspresetHPP
