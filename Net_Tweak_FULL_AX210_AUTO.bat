@echo off
title AX210 FULL REAL TWEAK - Roblox / Low Latency
color 0A

echo ============================================
echo   AX210 FULL REAL TWEAK - WORKING VERSION
echo   For Roblox / Low Latency / Stable Ping
echo   Run as Administrator
echo ============================================
echo.

:: =========================================================
:: 1) POWER PLAN - Ultimate Performance
:: =========================================================
echo [1/7] Enabling Ultimate Performance...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /S b39eb9be-ab87-4f5a-b587-a718553a7860 >nul 2>&1

:: =========================================================
:: 2) TCP GLOBAL
:: =========================================================
echo [2/7] Applying TCP global tweaks...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1

:: =========================================================
:: 3) MMCSS / GAMING
:: =========================================================
echo [3/7] Applying gaming scheduler tweaks...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul

:: =========================================================
:: 4) AX210 REAL INTERFACE NAGLE OFF (YOUR REAL GUID)
:: =========================================================
echo [4/7] Applying Nagle OFF to real AX210 interface...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}" /v TcpDelAckTicks /t REG_DWORD /d 0 /f >nul

:: =========================================================
:: 5) OPTIONAL POWER CLEANUP
:: =========================================================
echo [5/7] Disabling hibernate...
powercfg -h off >nul 2>&1

:: =========================================================
:: 6) CLEAN WRONG FAKE {GUID} KEY (if created before)
:: =========================================================
echo [6/7] Removing fake registry key if exists...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{GUID}" /f >nul 2>&1

:: =========================================================
:: 7) SHOW RESULT
:: =========================================================
echo [7/7] Verifying applied settings...
echo.
echo ===== TCP GLOBAL =====
netsh int tcp show global
echo.
echo ===== NAGLE VALUES (REAL AX210) =====
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{af35fef3-084c-40a4-af23-c9df8ca119c4}"
echo.
echo ============================================
echo   DONE.
echo   IMPORTANT: RESTART PC 1 TIME
echo ============================================
pause