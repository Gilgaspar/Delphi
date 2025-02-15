// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frx2DBarcodesPresets.pas' rev: 32.00 (Windows)

#ifndef Frx2dbarcodespresetsHPP
#define Frx2dbarcodespresetsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <frxClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frx2dbarcodespresets
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxObjectDataPreset;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxObjectDataPreset : public System::Classes::TInterfacedPersistent
{
	typedef System::Classes::TInterfacedPersistent inherited;
	
private:
	Frxclass::TfrxComponent* FOwner;
	Frxclass::TfrxCustomObjectPreset* FDataObject;
	void __fastcall SetPresetClass(const Frxclass::TfrxStringClassName Value);
	Frxclass::TfrxStringClassName __fastcall GetPresetClass(void);
	Frxclass::TfrxCustomObjectPreset* __fastcall GetDataObject(void);
	void __fastcall ClearPreset(void);
	System::Classes::TList* __fastcall GetSupportedClasses(void);
	
public:
	__fastcall TfrxObjectDataPreset(Frxclass::TfrxComponent* AOwner);
	__fastcall virtual ~TfrxObjectDataPreset(void);
	virtual System::UnicodeString __fastcall GetData(Frxclass::TfrxReport* aReport);
	virtual bool __fastcall IsHasPresetData(void);
	
__published:
	__property Frxclass::TfrxStringClassName PresetClass = {read=GetPresetClass, write=SetPresetClass};
	__property Frxclass::TfrxCustomObjectPreset* DataObject = {read=GetDataObject};
private:
	void *__IStringClassNameContainer;	// Frxclass::IStringClassNameContainer 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {97FFA69C-C491-458E-98A7-EFDCFFE05465}
	operator Frxclass::_di_IStringClassNameContainer()
	{
		Frxclass::_di_IStringClassNameContainer intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Frxclass::IStringClassNameContainer*(void) { return (Frxclass::IStringClassNameContainer*)&__IStringClassNameContainer; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Classes::TList* __fastcall frxBarcode2DPresetList(void);
}	/* namespace Frx2dbarcodespresets */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRX2DBARCODESPRESETS)
using namespace Frx2dbarcodespresets;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frx2dbarcodespresetsHPP
