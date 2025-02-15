// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'QRExpr.pas' rev: 30.00 (Windows)

#ifndef QrexprHPP
#define QrexprHPP

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
#include <qr5const.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qrexpr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRLibraryEntry;
class DELPHICLASS TQRLibrary;
struct TQREvResult;
class DELPHICLASS TQREvResultClass;
class DELPHICLASS TQRFiFo;
class DELPHICLASS TQREvElement;
class DELPHICLASS TQREvElementFunction;
class DELPHICLASS TQREvElementWrapper;
class DELPHICLASS TQREvEmbeddedFunction;
class DELPHICLASS TQREvElementArgumentEnd;
class DELPHICLASS TQREvElementDataField;
class DELPHICLASS TQREvElementError;
class DELPHICLASS TQREvaluator;
class DELPHICLASS TQREvEnvironment;
class DELPHICLASS TQRFunctionLibrary;
//-- type declarations -------------------------------------------------------
_DECLARE_METACLASS(System::TMetaClass, TQRLibraryItemClass);

class PASCALIMPLEMENTATION TQRLibraryEntry : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FDescription;
	System::UnicodeString FData;
	TQRLibraryItemClass FItem;
	System::UnicodeString FName;
	System::UnicodeString FVendor;
	
public:
	__property System::UnicodeString Data = {read=FData, write=FData};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::UnicodeString Vendor = {read=FVendor, write=FVendor};
	__property TQRLibraryItemClass Item = {read=FItem, write=FItem};
public:
	/* TObject.Create */ inline __fastcall TQRLibraryEntry(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TQRLibraryEntry(void) { }
	
};


class PASCALIMPLEMENTATION TQRLibrary : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	System::Classes::TStrings* Entries;
	virtual TQRLibraryEntry* __fastcall GetEntry(int Index);
	
public:
	__fastcall TQRLibrary(void);
	__fastcall virtual ~TQRLibrary(void);
	void __fastcall Add(TQRLibraryItemClass aItem, System::UnicodeString AName, System::UnicodeString ADescription, System::UnicodeString AVendor, System::UnicodeString AData);
	__property System::Classes::TStrings* EntryList = {read=Entries, write=Entries};
	__property TQRLibraryEntry* Entry[int Index] = {read=GetEntry};
};


enum DECLSPEC_DENUM TQREvOperator : unsigned char { opLess, opLessOrEqual, opGreater, opGreaterOrEqual, opEqual, opUnequal, opPlus, opMinus, opOr, opMul, opDiv, opAnd };

enum DECLSPEC_DENUM TQREvResultType : unsigned char { resInt, resDouble, resString, resBool, resError };

struct DECLSPEC_DRECORD TQREvResult
{
public:
	System::Word CodePage;
	System::UnicodeString StringVal;
	
public:
	TQREvResultType Kind;
	union
	{
		struct 
		{
			bool booResult;
		};
		struct 
		{
			System::SmallStringBase<255> strResult;
		};
		struct 
		{
			double dblResult;
		};
		struct 
		{
			int intResult;
		};
		
	};
};


class PASCALIMPLEMENTATION TQREvResultClass : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TQREvResult EvResult;
public:
	/* TObject.Create */ inline __fastcall TQREvResultClass(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TQREvResultClass(void) { }
	
};


class PASCALIMPLEMENTATION TQRFiFo : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FAggreg;
	System::Classes::TList* FiFo;
	int FNextItem;
	
public:
	__fastcall TQRFiFo(void);
	__fastcall virtual ~TQRFiFo(void);
	void __fastcall Put(System::TObject* Value);
	void __fastcall Start(void);
	System::TObject* __fastcall Get(void);
	System::TObject* __fastcall GetAndFree(void);
	__property bool Aggreg = {read=FAggreg, write=FAggreg, nodefault};
};


class PASCALIMPLEMENTATION TQREvElement : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FIsAggreg;
	
public:
	__fastcall virtual TQREvElement(void);
	virtual TQREvResult __fastcall Value(TQRFiFo* FiFo);
	virtual void __fastcall Reset(void);
	__property bool IsAggreg = {read=FIsAggreg, write=FIsAggreg, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQREvElement(void) { }
	
};


class PASCALIMPLEMENTATION TQREvElementFunction : public TQREvElement
{
	typedef TQREvElement inherited;
	
protected:
	System::Classes::TList* ArgList;
	bool __fastcall ArgumentOK(TQREvElement* Value);
	TQREvResult __fastcall Argument(int Index);
	void __fastcall FreeArguments(void);
	void __fastcall GetArguments(TQRFiFo* FiFo);
	virtual void __fastcall Aggregate(void);
	virtual TQREvResult __fastcall Calculate(void);
	
public:
	__fastcall virtual TQREvElementFunction(void);
	__fastcall virtual ~TQREvElementFunction(void);
	virtual TQREvResult __fastcall Value(TQRFiFo* FiFo);
};


_DECLARE_METACLASS(System::TMetaClass, TQREvElementFunctionClass);

class PASCALIMPLEMENTATION TQREvElementWrapper : public TQREvElement
{
	typedef TQREvElement inherited;
	
private:
	TQREvElement* FEmbeddedFunction;
	
public:
	__fastcall TQREvElementWrapper(TQREvElement* AEmbeddedFunction);
	virtual TQREvResult __fastcall Value(TQRFiFo* FiFo);
	__property TQREvElement* EmbeddedFunction = {read=FEmbeddedFunction};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQREvElementWrapper(void) { }
	
};


class PASCALIMPLEMENTATION TQREvEmbeddedFunction : public TQREvElement
{
	typedef TQREvElement inherited;
	
private:
	TQREvaluator* Evaluator;
	System::UnicodeString FExpression;
	bool FInEvaluate;
	
public:
	__fastcall TQREvEmbeddedFunction(System::UnicodeString Expression);
	__fastcall virtual ~TQREvEmbeddedFunction(void);
	virtual TQREvResult __fastcall Value(TQRFiFo* FiFo);
	virtual void __fastcall Reset(void);
	TQREvElement* __fastcall Peek(int Index);
	System::UnicodeString __fastcall Expression(void);
};


class PASCALIMPLEMENTATION TQREvElementArgumentEnd : public TQREvElement
{
	typedef TQREvElement inherited;
	
public:
	/* TQREvElement.Create */ inline __fastcall virtual TQREvElementArgumentEnd(void) : TQREvElement() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQREvElementArgumentEnd(void) { }
	
};


class PASCALIMPLEMENTATION TQREvElementDataField : public TQREvElement
{
	typedef TQREvElement inherited;
	
private:
	Data::Db::TDataSet* FDataSet;
	int FFieldNo;
	Data::Db::TField* FField;
	
public:
	__fastcall virtual TQREvElementDataField(Data::Db::TField* aField);
	virtual TQREvResult __fastcall Value(TQRFiFo* FiFo);
public:
	/* TQREvElement.Create */ inline __fastcall virtual TQREvElementDataField(void) : TQREvElement() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQREvElementDataField(void) { }
	
};


class PASCALIMPLEMENTATION TQREvElementError : public TQREvElement
{
	typedef TQREvElement inherited;
	
private:
	System::UnicodeString FErrorMessage;
	
public:
	__fastcall TQREvElementError(System::UnicodeString ErrorMessage);
	virtual TQREvResult __fastcall Value(TQRFiFo* FiFo);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQREvElementError(void) { }
	
};


class PASCALIMPLEMENTATION TQREvaluator : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* OwnDataSets;
	System::Classes::TList* FDataSets;
	TQRFiFo* FiFo;
	bool FPrepared;
	TQREvEnvironment* FEnvironment;
	TQREvResult __fastcall EvalEnvironment(System::UnicodeString strVariable);
	TQREvResult __fastcall EvalFunctionExpr(const System::UnicodeString strFunc);
	TQREvResult __fastcall EvalSimpleExpr(const System::UnicodeString strSimplExpr);
	TQREvResult __fastcall EvalTerm(const System::UnicodeString strTermExpr);
	TQREvResult __fastcall EvalFactor(System::UnicodeString strFactorExpr);
	TQREvResult __fastcall EvalString(const System::UnicodeString strString);
	TQREvResult __fastcall EvalConstant(const System::UnicodeString strConstant);
	bool __fastcall GetAggregate(void);
	TQREvResult __fastcall Evaluate(const System::UnicodeString strExpr);
	void __fastcall FindDelimiter(System::UnicodeString strArg, int &Pos);
	void __fastcall SetAggregate(bool Value);
	void __fastcall TrimString(System::UnicodeString &strString);
	
protected:
	virtual TQREvResult __fastcall EvalFunction(System::UnicodeString strFunc, const System::UnicodeString strArg);
	virtual TQREvResult __fastcall EvalVariable(System::UnicodeString strVariable);
	bool __fastcall GetIsAggreg(void);
	System::Classes::TList* __fastcall GetDatasets(void);
	void __fastcall SetDatasets(System::Classes::TList* Value);
	
public:
	__fastcall TQREvaluator(void);
	__fastcall virtual ~TQREvaluator(void);
	TQREvResult __fastcall Calculate(const System::UnicodeString StrExpr);
	TQREvResult __fastcall Value(void);
	System::UnicodeString __fastcall AsString(void);
	int __fastcall AsInteger(void);
	System::Extended __fastcall AsFloat(void);
	bool __fastcall AsBoolean(void);
	System::Variant __fastcall AsVariant(void);
	void __fastcall Prepare(const System::UnicodeString StrExpr);
	void __fastcall Reset(void);
	void __fastcall UnPrepare(void);
	void __fastcall DoAggregate(void);
	__property TQREvEnvironment* Environment = {read=FEnvironment, write=FEnvironment};
	__property bool IsAggreg = {read=GetIsAggreg, nodefault};
	__property bool Aggregate = {read=GetAggregate, write=SetAggregate, nodefault};
	__property System::Classes::TList* DataSets = {read=GetDatasets, write=SetDatasets};
	__property bool Prepared = {read=FPrepared, write=FPrepared, nodefault};
};


class PASCALIMPLEMENTATION TQREvEnvironment : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	int PrepareCount;
	System::Classes::TList* OwnDataSets;
	System::Classes::TList* FDatasets;
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadProperties(System::Classes::TReader* Reader);
	void __fastcall WriteProperties(System::Classes::TWriter* Writer);
	System::Classes::TList* __fastcall GetDatasets(void);
	void __fastcall SetDatasets(System::Classes::TList* Value);
	
public:
	__fastcall TQREvEnvironment(void);
	__fastcall virtual ~TQREvEnvironment(void);
	void __fastcall AddFunction(System::UnicodeString AName, System::UnicodeString AExpression);
	virtual void __fastcall Clear(void);
	void __fastcall DeleteFunction(System::UnicodeString AName);
	void __fastcall Update(void);
	void __fastcall Prepare(void);
	void __fastcall UpdateConstant(System::UnicodeString Name, const TQREvResult &Value);
	void __fastcall SetConstant(TQREvElement* Constant, const TQREvResult &Value);
	void __fastcall SetStringConstant(TQREvElement* Constant, System::UnicodeString Value);
	void __fastcall SetIntegerConstant(TQREvElement* Constant, int Value);
	void __fastcall SetFloatConstant(TQREvElement* Constant, double Value);
	void __fastcall SetBooleanConstant(TQREvElement* Constant, bool Value);
	void __fastcall Unprepare(void);
	bool __fastcall Prepared(void);
	TQREvResult __fastcall Value(System::UnicodeString Name);
	TQREvElement* __fastcall Element(System::UnicodeString Name);
	TQREvElement* __fastcall GetConstant(System::UnicodeString Name);
	__property System::Classes::TList* Datasets = {read=GetDatasets, write=SetDatasets};
};


class PASCALIMPLEMENTATION TQRFunctionLibrary : public TQRLibrary
{
	typedef TQRLibrary inherited;
	
public:
	TQREvElement* __fastcall GetFunction(System::UnicodeString Name);
public:
	/* TQRLibrary.Create */ inline __fastcall TQRFunctionLibrary(void) : TQRLibrary() { }
	/* TQRLibrary.Destroy */ inline __fastcall virtual ~TQRFunctionLibrary(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TQRFunctionLibrary* QRFunctionLibrary;
extern DELPHI_PACKAGE System::UnicodeString __fastcall QREvResultToString(const TQREvResult &AValue);
extern DELPHI_PACKAGE int __fastcall QREvResultToInt(const TQREvResult &AValue);
extern DELPHI_PACKAGE System::Extended __fastcall QREvResultToFloat(const TQREvResult &AValue);
extern DELPHI_PACKAGE System::Variant __fastcall QREvResultToVariant(const TQREvResult &AValue);
extern DELPHI_PACKAGE TQREvEnvironment* __fastcall QRGlobalEnvironment(void);
extern DELPHI_PACKAGE void __fastcall UpdateConstant(TQREvElement* AConstant, const TQREvResult &Value);
extern DELPHI_PACKAGE void __fastcall RegisterQRFunction(TQRLibraryItemClass FunctionClass, System::UnicodeString Name, System::UnicodeString Description, System::UnicodeString Vendor, System::UnicodeString Arguments);
}	/* namespace Qrexpr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QREXPR)
using namespace Qrexpr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QrexprHPP
