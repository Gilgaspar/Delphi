// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwdbnavedt.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwdbnavedtHPP
#define Vcl_WwdbnavedtHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <vcl.wwdbnavigator.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <vcl.wwcollection.hpp>	// Pascal unit
#include <vcl.wwcollectioneditor.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <vcl.wwprpedt.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwdbnavedt
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwDBNavigatorEditorEvents;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwDBNavigatorEditorEvents : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod void __fastcall AddInfoPowerDialogsClick(System::TObject* Sender);
public:
	/* TObject.Create */ inline __fastcall TwwDBNavigatorEditorEvents(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TwwDBNavigatorEditorEvents(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwDBNavigatorButtonsEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwDBNavigatorButtonsEditor : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
	void __fastcall CollectionCustomize(Vcl::Wwcollectioneditor::TwwCollectionEditorForm* EditorForm);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwDBNavigatorButtonsEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwDBNavigatorButtonsEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwNavButtonEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwNavButtonEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	__fastcall virtual TwwNavButtonEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner);
	__fastcall virtual ~TwwNavButtonEditor(void);
};

#pragma pack(pop)

class DELPHICLASS TwwDBNavigatorEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwDBNavigatorEditor : public Vcl::Wwprpedt::TwwComponentEditor
{
	typedef Vcl::Wwprpedt::TwwComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	void __fastcall CollectionCustomize(Vcl::Wwcollectioneditor::TwwCollectionEditorForm* EditorForm);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwDBNavigatorEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Vcl::Wwprpedt::TwwComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwDBNavigatorEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 WW_ADD_BUTTON = System::Int8(0x0);
static const System::Int8 WW_ADD_INFOPOWERDIALOGS = System::Int8(0x1);
static const System::Int8 WW_SELECT_ALL = System::Int8(0x2);
static const System::Int8 WW_VERB_COUNT = System::Int8(0x3);
}	/* namespace Wwdbnavedt */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWDBNAVEDT)
using namespace Vcl::Wwdbnavedt;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwdbnavedtHPP
