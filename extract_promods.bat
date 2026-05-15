@echo off
chcp 65001 >nul
title ProMods Extractor - 7-Zip
echo =========================================
echo   ProMods Automatic Extractor
echo =========================================
echo.

:: -------------------------------------------------------
:: 1. Locate 7-Zip
::    Checks the most common installation paths,
::    then falls back to PATH if 7z.exe is globally available.
:: -------------------------------------------------------
set "SEVENZIP="

if exist "%ProgramFiles%\7-Zip\7z.exe"       set "SEVENZIP=%ProgramFiles%\7-Zip\7z.exe"
if exist "%ProgramFiles(x86)%\7-Zip\7z.exe"  set "SEVENZIP=%ProgramFiles(x86)%\7-Zip\7z.exe"

:: Fallback: check if 7z is available on PATH
if "%SEVENZIP%"=="" (
    where 7z >nul 2>&1
    if not errorlevel 1 set "SEVENZIP=7z"
)

if "%SEVENZIP%"=="" (
    echo [ERROR] 7-Zip was not found on this computer.
    echo.
    echo Please install it from https://www.7-zip.org
    echo then run this script again.
    echo.
    pause
    exit /b 1
)
echo [OK] 7-Zip found : %SEVENZIP%

:: -------------------------------------------------------
:: 2. Find the first volume (.7z.001)
::    The script searches in its own directory so users
::    don't have to move it manually.
:: -------------------------------------------------------
set "SCRIPT_DIR=%~dp0"
set "ARCHIVE="

for %%F in ("%SCRIPT_DIR%*.7z.001") do (
    set "ARCHIVE=%%F"
    goto :found
)

:found
if "%ARCHIVE%"=="" (
    echo [ERROR] No .7z.001 file was found in this folder.
    echo.
    echo Make sure this script is placed in the same folder
    echo as all the archive volumes ^(.7z.001, .7z.002, ...^).
    echo.
    pause
    exit /b 1
)
echo [OK] Archive detected : %ARCHIVE%

:: -------------------------------------------------------
:: 3. Count volumes (informational)
:: -------------------------------------------------------
set "VOLUME_COUNT=0"
for %%F in ("%SCRIPT_DIR%*.7z.0*") do set /a VOLUME_COUNT+=1
echo [INFO] Volume^(s^) found : %VOLUME_COUNT%

:: -------------------------------------------------------
:: 4. Choose output folder
::    Files are extracted next to the archives by default.
::    Change OUTPUT_DIR below to use a custom path, e.g.:
::      set "OUTPUT_DIR=C:\Games\Euro Truck Simulator 2\mod"
:: -------------------------------------------------------
set "OUTPUT_DIR=%SCRIPT_DIR%"

echo.
echo Starting extraction...
echo Output folder : %OUTPUT_DIR%
echo.

:: -------------------------------------------------------
:: 5. Extract
::    -aoa  : overwrite all existing files without prompting
::    -bso0 : suppress standard output (keeps the console clean)
::    -bsp1 : show progress
::    -o    : set output directory
:: -------------------------------------------------------
"%SEVENZIP%" x "%ARCHIVE%" -o"%OUTPUT_DIR%" -aoa -bso0 -bsp1

if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Extraction failed ^(exit code: %ERRORLEVEL%^).
    echo.
    echo Things to check:
    echo   - All volume files are present ^(.7z.001 through the last part^)
    echo   - No volume file is corrupted or incomplete
    echo   - You have enough free disk space
    echo.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo =========================================
echo   Extraction completed successfully!
echo =========================================
echo.
echo Your extracted files should now be visible
echo in the output folder:
echo   %OUTPUT_DIR%
echo.
echo Expected contents: 6 x .scs files + 1 x .zip file
echo.
pause
