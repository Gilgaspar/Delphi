
#include <vcl.h>
#pragma hdrstop
USEUNIT("fqbRegIBX.pas");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("fqbIBX50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclbde50.bpi");

//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------

