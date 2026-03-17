@echo off
setlocal EnableExtensions

title PRO MENU v4 Launcher
color 0A

:: =========================================================
:: PRO MENU v4 POWERSHELL GODMODE UI - AUTO ADMIN LAUNCHER
:: =========================================================

cd /d "%~dp0"

:: ------------------------------
:: Auto-elevate to Administrator
:: ------------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrator privileges...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo =========================================================
echo         PRO MENU v4 POWERSHELL GODMODE UI
echo                AUTO ADMIN LAUNCHER
echo =========================================================
echo.

set "PS1_FILE=PRO_MENU_V4_GODMODE_UI.ps1"

if not exist "%PS1_FILE%" (
    echo [ERROR] Could not find: %PS1_FILE%
    echo.
    echo Make sure this BAT file is in the SAME folder as the PS1 file.
    echo.
    pause
    exit /b
)

powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "try { Unblock-File -Path '%CD%\%PS1_FILE%' -ErrorAction SilentlyContinue } catch {}" >nul 2>&1

echo [INFO] Launching PowerShell script...
echo.

powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%CD%\%PS1_FILE%"
set "PS_EXIT=%errorlevel%"

echo.
echo =========================================================
if "%PS_EXIT%"=="0" (
    echo [DONE] Script finished successfully.
) else (
    echo [WARNING] Script exited with code: %PS_EXIT%
    echo.
    echo Tips:
    echo - Make sure PowerShell is available
    echo - Keep files in a simple folder like C:\NetTool\
    echo - If using OneDrive, try moving the folder to C:\NetTool\
)
echo =========================================================
echo.
pause
endlocal