@echo off
if exist setenv.bat call setenv.bat
computil SetupXE3
if exist setenv.bat call setenv.bat
if "%NDXE3%"=="" goto endok
call clean.bat
if not exist ..\..\DataLinks\*.* md ..\..\DataLinks >nul

set DCCOPTS=-N..\..\XE3-32 -E..\..\DataLinks -LN..\..\DataLinks -U..\..\XE3-32;..\..\IDE;..\..\QUAD -I..\Win;..\DataLink -$D-,L- -V-
set LIBRARIES=-NSwinapi;vcl;system;data;data.win;bde;system.win 

REM ***************************************************
REM Compile DataLink drivers
REM ***************************************************
%NDXE3%\bin\dcc32.exe ..\DataLink\DataLinkBDE.dpr -M -H -W %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\DataLink\DataLinkADO.dpr -M -H -W %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\DataLink\DataLinkDBX.dpr -M -H -W %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

%NDXE3%\bin\dcc32.exe ..\DataLink\DataLinkInterbase.dpr -M -H -W %LIBRARIES% %DCCOPTS% %1 %2 %3 | quiet.exe
if errorlevel 1 goto enderror

del ..\..\XE3-32\RvDLADOCfg.dcu
del ..\..\XE3-32\RvDLBDECfg.dcu
del ..\..\XE3-32\RvDLDBXCfg.dcu
del ..\..\XE3-32\RvDLInterbaseCfg.dcu

echo.
echo SUCCESS: DataLink Drivers Compiled
echo.
goto endok
:enderror
call clean
echo.
echo FAILURE: DataLink Drivers NOT Compiled
echo.
exit /b 1
:endok
exit /b 0
