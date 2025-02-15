cd ..\..\source\windows
del *.dcu
cd ..\..\lib\xe5vcl\win32
del *.dcu
cd ..\..\..\bin\xe5vcl
del *.dcu
del *.~*
copy ..\..\source\windows\*.dfm ..\..\lib\xe5vcl\win32
copy ..\..\source\windows\*.res ..\..\lib\xe5vcl\win32
"c:\programas\embarcadero\rad studio\12.0\bin\dcc32" -NB..\..\lib\xe5vcl\win32 -LEwin32 -LUvcl -LN..\..\lib\xe5vcl\win32 -$D- -$L- -B -JL -N..\..\lib\xe5vcl\win32 -NH..\..\bin\xe5vcl\win32 -U..\..\source\windows ..\..\bin\xe5vcl\ipstudiowin.dpk
rem copy ..\..\lib\xe5vcl\win32\ipstudiowin.dcp "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"

"c:\programas\embarcadero\rad studio\12.0\bin\dcc32" -NB..\..\lib\xe5vcl\win32 -LEwin32 -LUvcl;ipstudiowin -LN..\..\lib\xe5vcl\win32 -$D- -$L- -B -JL -N..\..\lib\xe5vcl\win32 -NH..\..\bin\xe5vcl\win32 -u..\..\source\windows ..\..\bin\xe5vcl\ipstudiowindataset.dpk
rem copy ..\..\lib\xe5vcl\win32\ipstudiowindataset.dcp "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"

"c:\programas\embarcadero\rad studio\12.0\bin\dcc32" -NB..\..\lib\xe5vcl\win32 -LEwin32 -LUvcl;ipstudiowin -LN..\..\lib\xe5vcl\win32 -$D- -$L- -B -JL -N..\..\lib\xe5vcl\win32 -NH..\..\bin\xe5vcl\win32 -u..\..\source\windows ..\..\bin\xe5vcl\ipstudiowinclient.dpk
rem copy ..\..\lib\xe5vcl\win32\ipstudiowinclient.dcp "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"

"c:\programas\embarcadero\rad studio\12.0\bin\dcc32" -NB..\..\lib\xe5vcl\win32 -LEwin32 -LUipstudiowin -LN..\..\lib\xe5vcl\win32 -$D- -$L- -JL -B -N..\..\lib\xe5vcl\win32 -NH..\..\bin\xe5vcl\win32 -u..\..\source\windows ..\..\bin\xe5vcl\ipstudiowinWordxp.dpk
rem copy ..\..\lib\xe5vcl\win32\ipstudiowinWordxp.dcp "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"

"c:\programas\embarcadero\rad studio\12.0\bin\dcc32" -NB..\..\lib\xe5vcl\win32 -LEwin32 -LUipstudiowin -LN..\..\lib\xe5vcl\win32 -$D- -$L- -JL -Awintypes=windows -Awinprocs=windows -B -N..\..\lib\xe5vcl\win32 -NH..\..\bin\xe5vcl\win32 -U..\..\source\windows ..\..\bin\xe5vcl\dipstudiowin.dpk
rem copy ..\..\lib\windows\dipstudiowin.dcp "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"

copy *.lib ..\..\lib\xe5vcl\win32
copy win32\*.bpl "c:\programas\embarcadero\rad studio\12.0\bin"
copy ..\..\lib\xe5vcl\win32\*.lib "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"
copy ..\..\lib\xe5vcl\win32\*.dcp "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"
copy ..\..\lib\xe5vcl\win32\*.bpi "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"
copy ..\..\lib\xe5vcl\win32\*.dfm "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"
copy ..\..\lib\xe5vcl\win32\*.res "c:\programas\embarcadero\rad studio\12.0\lib\win32\release"
copy win32\*.hpp "c:\programas\embarcadero\rad studio\12.0\include\windows\vcl"
copy win32\*.hpp "..\..\include\xe5vcl\windows"

del *.lib
del win32\*.hpp

cd ..\source
del *.obj
del *.dcu
del *.~*
del *.old