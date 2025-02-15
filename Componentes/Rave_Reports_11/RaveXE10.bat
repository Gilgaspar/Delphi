@echo off
if exist setenv.bat call setenv.bat
REM computil SetupXE10
if exist setenv.bat call setenv.bat
if "%NDXE10%"=="" goto endok
call clean.bat

set DCCOPTS=-H -W -N..\..\XE10-32 -LE..\.. -LN..\..\XE10-32 -U..\..\XE10-32;..\Designer -I..\Designer -R..\Designer -$D-,L- -V-
set LIBRARIES=-NSwinapi;vcl;system;data;data.win;bde;vcl.imaging;system.win 

REM ***************************************************
REM Compile Rave Packages
REM ***************************************************
if exist ..\Designer\*.dcu del ..\Designer\*.dcu
%NDXE10%\bin\dcc32.exe ..\Designer\RvCore.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE10%\bin\dcc32.exe ..\Designer\RvBarcode.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE10%\bin\dcc32.exe ..\Designer\RvGraphics.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE10%\bin\dcc32.exe ..\Designer\RvStandard.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE10%\bin\dcc32.exe ..\Designer\RvReport.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

rem ..\RVS\RVS2INC ..\RVS\SYSFUNC.RVS ..\RVS\Rv*.rvs >nul
%NDXE10%\bin\dcc32.exe ..\Designer\RvEngine.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE10%\bin\dcc32.exe ..\Designer\RvCompiler.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE10%\bin\dcc32.exe ..\Designer\RvDesign.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

echo.
echo SUCCESS: Rave Packages Compiled
echo.
goto endok
:enderror
call clean
echo.
echo FAILURE: Rave Packages NOT Compiled
echo.
exit /b 1
:endok
exit /b 0
