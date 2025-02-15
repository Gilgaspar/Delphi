// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Qreport.pas' rev: 30.00 (Windows)

#ifndef QreportHPP
#define QreportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <QuickRpt.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <qrpctrls.hpp>
#include <qrpBaseCtrls.hpp>
#include <SupComps.hpp>

//-- user supplied -----------------------------------------------------------

namespace Qreport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TQRFloatProperty;
class DELPHICLASS TQRMasterProperty;
class DELPHICLASS TQRCaptionProperty;
class DELPHICLASS TQRGraphicEditor;
class DELPHICLASS TQRDBStringProperty;
class DELPHICLASS TQRDataFieldProperty;
class DELPHICLASS TQRExprProperty;
class DELPHICLASS TQREnvProperty;
class DELPHICLASS TQRGridReportDesignModeMenu;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRFloatProperty : public Designeditors::TFloatProperty
{
	typedef Designeditors::TFloatProperty inherited;
	
public:
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value)/* overload */;
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TQRFloatProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TFloatProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TQRFloatProperty(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRMasterProperty : public Designeditors::TComponentProperty
{
	typedef Designeditors::TComponentProperty inherited;
	
public:
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TQRMasterProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TComponentProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TQRMasterProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRCaptionProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TQRCaptionProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TQRCaptionProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRGraphicEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TQRGraphicEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQRGraphicEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRDBStringProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValueList(System::Classes::TStrings* List) = 0 ;
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TQRDBStringProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TQRDBStringProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRDataFieldProperty : public TQRDBStringProperty
{
	typedef TQRDBStringProperty inherited;
	
public:
	virtual System::UnicodeString __fastcall GetDataSetPropName(void);
	virtual void __fastcall GetValueList(System::Classes::TStrings* List);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TQRDataFieldProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TQRDBStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TQRDataFieldProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRExprProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TQRExprProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TQRExprProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQREnvProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TQREnvProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TQREnvProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TQRGridReportDesignModeMenu : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
protected:
	Qrpctrls::TQRGridReport* FGridReport;
	
public:
	__fastcall virtual TQRGridReportDesignModeMenu(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner);
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQRGridReportDesignModeMenu(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetDesignVerb(int Index);
extern DELPHI_PACKAGE int __fastcall GetDesignVerbCount(void);
extern DELPHI_PACKAGE void __fastcall ExecuteDesignVerb(int Index, Quickrpt::TQuickRep* Report);
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Qreport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_QREPORT)
using namespace Qreport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// QreportHPP
