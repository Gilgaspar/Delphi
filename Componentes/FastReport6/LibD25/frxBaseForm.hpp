// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBaseForm.pas' rev: 32.00 (Windows)

#ifndef FrxbaseformHPP
#define FrxbaseformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.IniFiles.hpp>
#include <frxDPIAwareInt.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxbaseform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxMessageObject;
class DELPHICLASS TfrxBaseForm;
class DELPHICLASS TfrxBaseLoadSavePrefForm;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxPreferencesAction : unsigned char { frPaLoad, frPaSave, frPaRestore };

enum DECLSPEC_DENUM TfrxPreferencesType : unsigned char { frPtFormPos, frPtFormSize, frPtFormVisibility, frPtFormDockInfo, frPtFormDockPos, frPtFormDockSize, frPtFormCustom };

typedef System::Set<TfrxPreferencesType, TfrxPreferencesType::frPtFormPos, TfrxPreferencesType::frPtFormCustom> TfrxPreferencesTypes;

enum DECLSPEC_DENUM TfrxPreferencesLoadEvent : unsigned char { peAtCreate, peAtShowOnce, peAtShow };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxMessageObject : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	unsigned Msg;
	NativeUInt WParam;
	System::Types::TRect FormRect;
public:
	/* TObject.Create */ inline __fastcall TfrxMessageObject(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxMessageObject(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxBaseForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
	
private:
	typedef System::DynamicArray<Vcl::Controls::TControl*> _TfrxBaseForm__1;
	
	
private:
	int FCurrentFormPPI;
	bool FShowed;
	int FSavedPPI;
	bool FNeedUpdatePPI;
	TfrxMessageObject* FUpdatingPPI;
	TfrxPreferencesTypes FPreferences;
	bool FIsPPIChanging;
	bool FPrefIsLoaded;
	bool FPrefIsSaved;
	bool FPrefIsLocked;
	HIDESBASE MESSAGE void __fastcall WMDpiChanged(Winapi::Messages::TMessage &Message);
	int __fastcall GetCurrentFormPPI(void);
	
protected:
	TfrxPreferencesLoadEvent FPrefEvent;
	_TfrxBaseForm__1 FHostedControls;
	DYNAMIC void __fastcall DoShow(void);
	DYNAMIC void __fastcall DoClose(System::Uitypes::TCloseAction &Action);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	DYNAMIC void __fastcall ChangeScale(int M, int D, bool isDpiChange)/* overload */;
	virtual void __fastcall BeforePPIChange(void);
	virtual void __fastcall AfterPPIChange(void);
	virtual void __fastcall AfterPPIMessage(void);
	void __fastcall DoUpdateFormPPI(int aNewPPI);
	virtual void __fastcall FormShowBeforeLoad(void);
	virtual void __fastcall FormShowAfterLoad(void);
	virtual void __fastcall LoadFormPreferences(System::TObject* PreferencesStorage, System::TObject* DefPreferencesStorage);
	virtual void __fastcall SaveFormPreferences(System::TObject* PreferencesStorage, System::TObject* DefPreferencesStorage);
	virtual void __fastcall ResetFormPreferences(System::TObject* PreferencesStorage);
	virtual System::UnicodeString __fastcall GetFormSectionName(void);
	virtual TfrxPreferencesTypes __fastcall GetAvailablePreferences(void);
	
public:
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall BeforeDestruction(void);
	__fastcall virtual TfrxBaseForm(System::Classes::TComponent* AOwner);
	virtual System::TObject* __fastcall GetPreferencesStorage(bool aDefault);
	void __fastcall ProcessPreferences(TfrxPreferencesAction aPrefArction)/* overload */;
	void __fastcall ProcessPreferences(TfrxPreferencesAction aPrefArction, TfrxPreferencesTypes PrefTyp)/* overload */;
	void __fastcall LoadFormPrefType(System::TObject* PreferencesStorage, System::TObject* DefPreferencesStorage, TfrxPreferencesTypes PrefTyp);
	virtual void __fastcall UpdateResouces(void);
	virtual void __fastcall HostControls(Vcl::Controls::TWinControl* Host);
	virtual void __fastcall UnhostControls(System::Uitypes::TModalResult AModalResult);
	virtual void __fastcall UpdateFormPPI(int aNewPPI);
	__property int CurrentFormPPI = {read=GetCurrentFormPPI, nodefault};
	void __fastcall SendPPIMessage(Vcl::Controls::TWinControl* aWinControl, int aNewPPI);
	void __fastcall SaveFormPrefType(System::TObject* PreferencesStorage, System::TObject* DefPreferencesStorage, TfrxPreferencesTypes PrefTyp);
	virtual void __fastcall ScaleForPPI(int NewPPI);
	__property bool IsPPIChanging = {read=FIsPPIChanging, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxBaseForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxBaseForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxBaseForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TfrxBaseLoadSavePrefForm : public TfrxBaseForm
{
	typedef TfrxBaseForm inherited;
	
protected:
	virtual TfrxPreferencesTypes __fastcall GetAvailablePreferences(void);
public:
	/* TfrxBaseForm.Create */ inline __fastcall virtual TfrxBaseLoadSavePrefForm(System::Classes::TComponent* AOwner) : TfrxBaseForm(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxBaseLoadSavePrefForm(System::Classes::TComponent* AOwner, int Dummy) : TfrxBaseForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxBaseLoadSavePrefForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxBaseLoadSavePrefForm(HWND ParentWindow) : TfrxBaseForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbaseform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBASEFORM)
using namespace Frxbaseform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbaseformHPP
