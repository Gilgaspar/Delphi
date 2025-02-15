@echo off
if exist setenv.bat call setenv.bat
computil SetupXE3
if exist setenv.bat call setenv.bat
if "%NDXE3%"=="" goto endok
call clean.bat

set DCCOPTS=-H -W -N..\..\XE3-32 -LE..\.. -LN..\..\XE3-32 -U..\..\XE3-32;..\Designer -I..\Designer -R..\Designer -$D-,L- -V-
set LIBRARIES=-NSwinapi;vcl;system;data;data.win;bde;vcl.imaging;system.win 

REM ***************************************************
REM Compile Rave Packages
REM ***************************************************
if exist ..\Designer\*.dcu del ..\Designer\*.dcu
%NDXE3%\bin\dcc32.exe ..\Designer\RvCore.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\Designer\RvBarcode.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\Designer\RvGraphics.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\Designer\RvStandard.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\Designer\RvReport.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

rem ..\RVS\RVS2INC ..\RVS\SYSFUNC.RVS ..\RVS\Rv*.rvs >nul
%NDXE3%\bin\dcc32.exe ..\Designer\RvEngine.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\Designer\RvCompiler.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\Designer\RvDesign.dpk -M %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
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
