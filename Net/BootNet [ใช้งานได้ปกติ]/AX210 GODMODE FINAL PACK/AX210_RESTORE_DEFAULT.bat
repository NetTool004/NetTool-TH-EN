@echo off
title AX210 RESTORE DEFAULT
color 0E

echo ============================================
echo   AX210 RESTORE DEFAULT
echo   Restore safe Windows network defaults
echo   Run as Administrator
echo ============================================
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Please run as Administrator!
    pause
    exit /b
)

echo [1/6] Restoring TCP global defaults...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global timestamps=allowed >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1

echo [2/6] Restoring multimedia defaults...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 20 /f >nul

echo [3/6] Removing AX210 Nagle tweaks...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TcpAckFrequency /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TCPNoDelay /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TcpDelAckTicks /f >nul 2>&1

echo [4/6] Resetting network stack...
ipconfig /flushdns >nul
netsh winsock reset >nul
netsh int ip reset >nul

echo [5/6] Re-enabling hibernation...
powercfg -h on >nul 2>&1

echo [6/6] Showing current status...
netsh int tcp show global

echo.
echo ============================================
echo   RESTORE COMPLETE
echo   Recommended: RESTART PC
echo ============================================
pause