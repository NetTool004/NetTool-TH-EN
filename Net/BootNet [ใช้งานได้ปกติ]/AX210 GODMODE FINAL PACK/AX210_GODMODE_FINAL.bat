@echo off
title AX210 GODMODE FINAL - Roblox / Ultra Stable Ping
color 0A

echo ============================================
echo   AX210 GODMODE FINAL
echo   Roblox / Low Latency / Stable Ping
echo   Run as Administrator
echo ============================================
echo.

:: ===== Admin Check =====
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Please run this file as Administrator!
    pause
    exit /b
)

:: ===== 1) Enable Ultimate Performance =====
echo [1/8] Enabling Ultimate Performance...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /S b39eb9be-ab87-4f5a-b587-a718553a7860 >nul 2>&1

:: ===== 2) TCP Global =====
echo [2/8] Applying TCP global tweaks...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1

:: ===== 3) Gaming Multimedia Scheduler =====
echo [3/8] Applying multimedia gaming tweaks...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul

:: ===== 4) AX210 REAL NAGLE OFF =====
echo [4/8] Applying Nagle OFF to real AX210 interface...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TcpDelAckTicks /t REG_DWORD /d 0 /f >nul

:: ===== 5) Disable Hibernation =====
echo [5/8] Disabling hibernation...
powercfg -h off >nul 2>&1

:: ===== 6) Flush / Renew / Reset cache =====
echo [6/8] Refreshing network cache...
ipconfig /flushdns >nul
ipconfig /release >nul
timeout /t 2 /nobreak >nul
ipconfig /renew >nul
netsh winsock reset >nul
netsh int ip reset >nul

:: ===== 7) Cleanup fake wrong key =====
echo [7/8] Removing fake {GUID} key if exists...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{GUID}" /f >nul 2>&1

:: ===== 8) Verify =====
echo [8/8] Showing current status...
echo.
echo ===== TCP GLOBAL =====
netsh int tcp show global
echo.
echo ===== NAGLE (REAL AX210) =====
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TcpAckFrequency
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TCPNoDelay
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TcpDelAckTicks
echo.
echo ===== WIFI STATUS =====
netsh wlan show interfaces

echo.
echo ============================================
echo   DONE. IMPORTANT: RESTART PC NOW
echo ============================================
pause