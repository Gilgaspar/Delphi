// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fs_iFDRTTI.pas' rev: 32.00 (Windows)

#ifndef Fs_ifdrttiHPP
#define Fs_ifdrttiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Data.DB.hpp>
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <fs_iinterpreter.hpp>
#include <fs_itools.hpp>
#include <fs_idbrtti.hpp>
#include <FireDAC.DatS.hpp>
#include <FireDAC.Comp.DataSet.hpp>
#include <FireDAC.Comp.Client.hpp>
#include <FireDAC.Stan.Param.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fs_ifdrtti
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfsFDRTTI;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfsFDRTTI : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfsFDRTTI(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfsFDRTTI(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Firedac::Comp::Dataset::TFDDataSetLocateOptions __fastcall IntToFDDataSetLocateOptions(int i);
extern DELPHI_PACKAGE Firedac::Comp::Dataset::TFDCopyDataSetOptions __fastcall IntToFDCopyDataSetOptions(int i);
}	/* namespace Fs_ifdrtti */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FS_IFDRTTI)
using namespace Fs_ifdrtti;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fs_ifdrttiHPP
