// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxGS1Databar.pas' rev: 32.00 (Windows)

#ifndef Frxgs1databarHPP
#define Frxgs1databarHPP

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
#include <System.Types.hpp>
#include <System.StrUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <frxBarcode2DBase.hpp>
#include <frxGS1Databar_Helper.hpp>

//-- user supplied -----------------------------------------------------------

namespace Frxgs1databar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrxGS1Databar;
class DELPHICLASS TfrxGS1DatabarE;
class DELPHICLASS TfrxGS1DatabarES;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrxGS1Databar : public Frxbarcode2dbase::TfrxBarcode2DBaseWithUnion
{
	typedef Frxbarcode2dbase::TfrxBarcode2DBaseWithUnion inherited;
	
private:
	Frxgs1databar_helper::TBaseDatabar* base;
	int FOriginalHeight;
	
protected:
	virtual int __fastcall Generate(System::UnicodeString Text, bool rebase = true) = 0 ;
	virtual void __fastcall SetHeight(const int Value);
	virtual int __fastcall GetHeight(void);
	
public:
	__fastcall virtual TfrxGS1Databar(void);
	__fastcall virtual ~TfrxGS1Databar(void);
	virtual void __fastcall Assign(Frxbarcode2dbase::TfrxBarcode2DBase* src);
	void __fastcall RePaint(void);
	virtual bool __fastcall IsScaled(void);
};


class PASCALIMPLEMENTATION TfrxGS1DatabarE : public TfrxGS1Databar
{
	typedef TfrxGS1Databar inherited;
	
protected:
	virtual int __fastcall Generate(System::UnicodeString Text, bool rebase = true);
	
public:
	virtual void __fastcall SetText(System::UnicodeString v);
	__fastcall virtual TfrxGS1DatabarE(void);
public:
	/* TfrxGS1Databar.Destroy */ inline __fastcall virtual ~TfrxGS1DatabarE(void) { }
	
};


class PASCALIMPLEMENTATION TfrxGS1DatabarES : public TfrxGS1Databar
{
	typedef TfrxGS1Databar inherited;
	
protected:
	int FColumns;
	void __fastcall SetColumns(int Col);
	virtual int __fastcall Generate(System::UnicodeString Text, bool rebase = true);
	
public:
	virtual void __fastcall SetText(System::UnicodeString v);
	__fastcall virtual TfrxGS1DatabarES(void);
	__property int Columns = {read=FColumns, write=SetColumns, nodefault};
public:
	/* TfrxGS1Databar.Destroy */ inline __fastcall virtual ~TfrxGS1DatabarES(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxgs1databar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXGS1DATABAR)
using namespace Frxgs1databar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxgs1databarHPP
