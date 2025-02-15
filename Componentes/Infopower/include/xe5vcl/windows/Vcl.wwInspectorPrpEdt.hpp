// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwInspectorPrpEdt.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwinspectorprpedtHPP
#define Vcl_WwinspectorprpedtHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <vcl.Wwdatainspector.hpp>	// Pascal unit
#include <vcl.wwinspectorprop.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <Bde.DBTables.hpp>	// Pascal unit
#include <vcl.wwprpcom.hpp>	// Pascal unit
#include <vcl.wwprpedt.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwinspectorprpedt
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwObjectViewComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwObjectViewComponentEditor : public Vcl::Wwprpedt::TwwComponentEditor
{
	typedef Vcl::Wwprpedt::TwwComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwObjectViewComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Vcl::Wwprpedt::TwwComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwObjectViewComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwInspectorItemsProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwInspectorItemsProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwInspectorItemsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwInspectorItemsProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwCustomEditPropertyEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwCustomEditPropertyEditor : public Designeditors::TComponentProperty
{
	typedef Designeditors::TComponentProperty inherited;
	
public:
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
	void __fastcall wwGetStrProc(const System::UnicodeString s);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwCustomEditPropertyEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TComponentProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwCustomEditPropertyEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwDataFieldEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwDataFieldEditor : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwDataFieldEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwDataFieldEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwInspectorCollectionEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwInspectorCollectionEditor : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwInspectorCollectionEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwInspectorCollectionEditor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Wwinspectorprpedt */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWINSPECTORPRPEDT)
using namespace Vcl::Wwinspectorprpedt;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwinspectorprpedtHPP
