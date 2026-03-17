@echo off
title AX210 WIFI REFRESH
color 0B

echo ============================================
echo   AX210 WIFI REFRESH / QUICK FIX
echo ============================================
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Please run as Administrator!
    pause
    exit /b
)

echo [1/5] Flush DNS...
ipconfig /flushdns

echo [2/5] Release IP...
ipconfig /release

echo [3/5] Waiting 2 sec...
timeout /t 2 /nobreak >nul

echo [4/5] Renew IP...
ipconfig /renew

echo [5/5] Show Wi-Fi status...
netsh wlan show interfaces

echo.
echo ============================================
echo   REFRESH COMPLETE
echo ============================================
pause