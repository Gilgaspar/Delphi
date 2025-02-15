// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ECC200procs.pas' rev: 30.00 (Windows)

#ifndef Ecc200procsHPP
#define Ecc200procsHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <ECC200Consts.hpp>
#include <Vcl.Dialogs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Ecc200procs
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<int> Ecc200procs__1;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int nrow;
extern DELPHI_PACKAGE int ncol;
extern DELPHI_PACKAGE Ecc200procs__1 barray;
extern DELPHI_PACKAGE int matrixsize;
extern DELPHI_PACKAGE int modulesize;
extern DELPHI_PACKAGE bool _globalQZflag;
extern DELPHI_PACKAGE void __fastcall DrawModule(int x, int y, Vcl::Graphics::TCanvas* acanvas);
extern DELPHI_PACKAGE void __fastcall DrawFrame(int x, int y, Vcl::Graphics::TCanvas* acanvas);
extern DELPHI_PACKAGE void __fastcall RandomBC(int x, int y, Vcl::Graphics::TCanvas* acanvas);
extern DELPHI_PACKAGE void __fastcall PaintRandomBC(int x, int y, int matrixrows, const System::Types::TRect &destrect, bool quietzone, Vcl::Graphics::TCanvas* acanvas);
extern DELPHI_PACKAGE void __fastcall AscEncodeText(Ecc200consts::TVarInt databits, System::UnicodeString dtext, bool GS1, System::WideChar FNCChar, int maxindex, int &datalength);
extern DELPHI_PACKAGE void __fastcall DrawRandomBC(int x, int y, int matrixrows, const System::Types::TRect &destrect, Vcl::Graphics::TCanvas* acanvas);
extern DELPHI_PACKAGE void __fastcall RenderBarcode(System::UnicodeString textdata, bool GS1, System::WideChar FNCChar, int xpos, int ypos, Ecc200consts::TMatrixsize matrixrows, const System::Types::TRect &destrect, bool quietzone, Vcl::Graphics::TCanvas* acanvas);
extern DELPHI_PACKAGE void __fastcall ECC200Code(void);
extern DELPHI_PACKAGE void __fastcall MakeBitPlacementArray(int matrixrows, int matrixcols);
}	/* namespace Ecc200procs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ECC200PROCS)
using namespace Ecc200procs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ecc200procsHPP
