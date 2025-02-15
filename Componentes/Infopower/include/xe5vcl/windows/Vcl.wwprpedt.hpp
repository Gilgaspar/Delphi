// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'vcl.wwprpedt.pas' rev: 26.00 (Windows)

#ifndef Vcl_WwprpedtHPP
#define Vcl_WwprpedtHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <vcl.wwdblook.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <vcl.wwdbgrid.hpp>	// Pascal unit
#include <vcl.wwdbigrd.hpp>	// Pascal unit
#include <vcl.Wwcommon.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <vcl.wwselfld.hpp>	// Pascal unit
#include <vcl.Wwstr.hpp>	// Pascal unit
#include <Bde.DBTables.hpp>	// Pascal unit
#include <vcl.wwtable.hpp>	// Pascal unit
#include <vcl.wwquery.hpp>	// Pascal unit
#include <vcl.wwqbe.hpp>	// Pascal unit
#include <vcl.wwstorep.hpp>	// Pascal unit
#include <vcl.wwIDlg.hpp>	// Pascal unit
#include <vcl.Wwdatainspector.hpp>	// Pascal unit
#include <vcl.wwricheditbar.hpp>	// Pascal unit
#include <vcl.wwlocate.hpp>	// Pascal unit
#include <vcl.wwfltfld.hpp>	// Pascal unit
#include <vcl.Wwfltdlg.hpp>	// Pascal unit
#include <vcl.Wwrcdvw.hpp>	// Pascal unit
#include <vcl.wwrcdpnl.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <vcl.Wwrich.hpp>	// Pascal unit
#include <vcl.wwriched.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <vcl.ipabout.hpp>	// Pascal unit
#include <System.Win.Registry.hpp>	// Pascal unit
#include <vcl.wwrgxed2.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <vcl.wwintl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcl
{
namespace Wwprpedt
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwComponentEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
private:
	void __fastcall ShowAboutBox(void);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
	__fastcall virtual TwwComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwGridComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwGridComponentEditor : public TwwComponentEditor
{
	typedef TwwComponentEditor inherited;
	
private:
	bool __fastcall SupportIniSave(void);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwGridComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TwwComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwGridComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwIndexDefsProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwIndexDefsProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwIndexDefsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwIndexDefsProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwControllerListProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwControllerListProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwControllerListProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwControllerListProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwIndexFieldProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwIndexFieldProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwIndexFieldProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwIndexFieldProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwTableProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwTableProperty : public Designeditors::TComponentProperty
{
	typedef Designeditors::TComponentProperty inherited;
	
public:
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwTableProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TComponentProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwTableProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwSearchFieldProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwSearchFieldProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(System::Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwSearchFieldProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwSearchFieldProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwDBLookupDisplayProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwDBLookupDisplayProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwDBLookupDisplayProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwDBLookupDisplayProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwTableDisplayProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwTableDisplayProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwTableDisplayProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwTableDisplayProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwDBLookupDisplayComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwDBLookupDisplayComponentEditor : public TwwComponentEditor
{
	typedef TwwComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwDBLookupDisplayComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TwwComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwDBLookupDisplayComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TSelectedFieldsProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSelectedFieldsProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TSelectedFieldsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TSelectedFieldsProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwDBGridComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwDBGridComponentEditor : public TwwGridComponentEditor
{
	typedef TwwGridComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwDBGridComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TwwGridComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwDBGridComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwRecordViewPanelComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwRecordViewPanelComponentEditor : public TwwComponentEditor
{
	typedef TwwComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwRecordViewPanelComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TwwComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwRecordViewPanelComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwObjPictureProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwObjPictureProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwObjPictureProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwObjPictureProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwObjRegexProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwObjRegexProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwObjRegexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwObjRegexProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwFilterFieldsProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwFilterFieldsProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwFilterFieldsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwFilterFieldsProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwComboItemsProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwComboItemsProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwComboItemsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwComboItemsProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwMultiLineStringProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwMultiLineStringProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString value)/* overload */;
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwMultiLineStringProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwMultiLineStringProperty(void) { }
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};

#pragma pack(pop)

class DELPHICLASS TwwPictureProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwPictureProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwPictureProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwPictureProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwPicturePropertyGen;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwPicturePropertyGen : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwPicturePropertyGen(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwPicturePropertyGen(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwRegexProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwRegexProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwRegexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwRegexProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwRecordViewComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwRecordViewComponentEditor : public TwwComponentEditor
{
	typedef TwwComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwRecordViewComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TwwComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwRecordViewComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwRichEditItemsProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwRichEditItemsProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwRichEditItemsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwRichEditItemsProperty(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwRichEditComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwRichEditComponentEditor : public TwwComponentEditor
{
	typedef TwwComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwRichEditComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TwwComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwRichEditComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwRichEditBarComponentEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwRichEditBarComponentEditor : public TwwComponentEditor
{
	typedef TwwComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	/* TwwComponentEditor.Create */ inline __fastcall virtual TwwRichEditBarComponentEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TwwComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TwwRichEditBarComponentEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TwwGridIndicatorProperty;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TwwGridIndicatorProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TwwGridIndicatorProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TwwGridIndicatorProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall EditSelectedFieldsProperty(System::Classes::TComponent* AComponent, System::Classes::TStrings* listHandle, Data::Db::TDataSet* dataSet, Designintf::_di_IDesigner designer, bool readFromTableComponent, bool &useTFields, Vcl::Wwselfld::TwwSelectedPropertyType propertyType);
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Wwprpedt */
}	/* namespace Vcl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL_WWPRPEDT)
using namespace Vcl::Wwprpedt;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCL)
using namespace Vcl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcl_WwprpedtHPP
