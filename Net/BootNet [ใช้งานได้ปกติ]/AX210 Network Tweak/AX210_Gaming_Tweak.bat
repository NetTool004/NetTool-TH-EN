@echo off
title Roblox / Wi-Fi AX210 Safe Network Tweak
color 0A

echo ============================================
echo   Roblox / Wi-Fi AX210 Safe Network Tweak
echo   Run as Administrator
echo ============================================
echo.

:: --- Check Admin ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Please Run this .bat as Administrator!
    echo Right-click the file and choose "Run as administrator"
    pause
    exit /b
)

echo [1/6] Setting Ultimate Performance power plan...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /S b39eb9be-ab87-4f5a-b587-a718553a7860 >nul 2>&1

echo [2/6] Applying safe TCP global settings...
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global ecncapability=disabled
netsh int tcp set global rss=enabled

echo [3/6] Applying Multimedia SystemProfile tweaks...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f

echo [4/6] Applying Game task scheduler tweaks...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f

echo [5/6] Turning off hibernation (optional but recommended)...
powercfg -h off

echo [6/6] Showing current power plan + TCP status...
echo.
echo ---------- POWER PLANS ----------
powercfg /L
echo.
echo ---------- TCP GLOBAL ----------
netsh int tcp show global

echo.
echo ============================================
echo   DONE! Recommended: Restart your PC now.
echo ============================================
echo.
pause