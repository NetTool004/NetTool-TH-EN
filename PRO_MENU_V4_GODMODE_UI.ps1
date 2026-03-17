# =========================================================
# PRO MENU v4 POWERSHELL GODMODE UI (ASCII SAFE RELEASE)
# 100% Safe for PowerShell 5.1 / No Thai in code
# =========================================================

$ErrorActionPreference = "SilentlyContinue"

function Test-IsAdmin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    Write-Host ""
    Write-Host "This script requires Administrator privileges." -ForegroundColor Red
    Write-Host "Please run RUN_NET_TOOL.bat" -ForegroundColor Yellow
    Write-Host ""
    Pause
    exit
}

$global:Lang = "EN"
$global:WiFiName = ""
$global:ScriptVersion = "PRO MENU v4 ASCII SAFE RELEASE"

$TXT = @{
    EN = @{
        TITLE            = "PRO MENU v4 POWERSHELL GODMODE UI"
        SUBTITLE         = "Desktop-Friendly Network Tool"
        WIFI_ACTIVE      = "Active Wi-Fi"
        SELECT_MODE      = "Select mode"
        INVALID          = "Invalid selection."
        EXITING          = "Exiting..."
        BACK             = "Press Enter to return to menu..."
        NO_WIFI          = "No active Wi-Fi interface detected."
        DONE             = "Completed."
        MODE1            = "SAFE DAILY"
        MODE1_DESC       = "Light refresh - recommended for daily use"
        MODE2            = "SMART REFRESH"
        MODE2_DESC       = "Before gaming / streaming / heavy use"
        MODE3            = "RECONNECT WIFI"
        MODE3_DESC       = "Disable/Enable Wi-Fi adapter"
        MODE4            = "FULL CLEAN FIX"
        MODE4_DESC       = "Winsock + IP reset + reconnect"
        MODE5            = "SHOW INTERNET DIAG"
        MODE5_DESC       = "Ping + route + DNS quick info"
        MODE6            = "SHOW WIFI STATUS"
        MODE6_DESC       = "Detailed Wi-Fi interface info"
        MODE7            = "QUICK PING TEST"
        MODE7_DESC       = "Ping 1.1.1.1 x10"
        MODE8            = "BASIC SPEED TEST"
        MODE8_DESC       = "Fast download test via web request"
        MODE9            = "SHOW IP CONFIG"
        MODE9_DESC       = "Display ipconfig /all"
        MODE10           = "CHANGE LANGUAGE"
        MODE10_DESC      = "Switch EN / SIMPLE-TH"
        MODE0            = "EXIT"
        FLUSH_DNS        = "Flushing DNS cache..."
        CLEAR_ARP        = "Clearing ARP cache..."
        RELEASE_RENEW    = "Releasing / renewing IP..."
        APPLY_REFRESH    = "Applying safe network refresh..."
        RECONNECTING     = "Reconnecting Wi-Fi adapter..."
        RESET_WINSOCK    = "Resetting Winsock..."
        RESET_IP         = "Resetting IP stack..."
        SHOWING_WIFI     = "Showing Wi-Fi status..."
        SHOWING_IP       = "Showing IP configuration..."
        PING_TEST        = "Quick ping test (1.1.1.1 x10)"
        SPEED_TEST       = "Basic speed test..."
        INTERNET_DIAG    = "Internet diagnostics"
        LANGUAGE_CHANGED = "Language changed to English."
        SPEED_RESULT     = "Approx download speed"
        NOTE_RESTART     = "A restart may improve full effect after Winsock/IP reset."
    }
    TH = @{
        TITLE            = "PRO MENU v4 POWERSHELL GODMODE UI"
        SUBTITLE         = "Khrueangmue du-lae net samrap desktop"
        WIFI_ACTIVE      = "Wi-Fi tee chai yoo"
        SELECT_MODE      = "Lueak mode"
        INVALID          = "Lueak mai took"
        EXITING          = "Gamlang ork..."
        BACK             = "Kot Enter pheua klap menu..."
        NO_WIFI          = "Mai phob Wi-Fi tee kamlang chueamtor"
        DONE             = "Set riap roi"
        MODE1            = "SAFE DAILY"
        MODE1_DESC       = "Refresh bao bao chai dai thuk wan"
        MODE2            = "SMART REFRESH"
        MODE2_DESC       = "Kon len game / stream / chai nak"
        MODE3            = "RECONNECT WIFI"
        MODE3_DESC       = "Pid/Poed adapter Wi-Fi mai"
        MODE4            = "FULL CLEAN FIX"
        MODE4_DESC       = "Reset Winsock + IP + reconnect"
        MODE5            = "SHOW INTERNET DIAG"
        MODE5_DESC       = "Check Ping + Route + DNS baep reo"
        MODE6            = "SHOW WIFI STATUS"
        MODE6_DESC       = "Sa-daeng rai-la-iat Wi-Fi"
        MODE7            = "QUICK PING TEST"
        MODE7_DESC       = "Test Ping 1.1.1.1 10 krang"
        MODE8            = "BASIC SPEED TEST"
        MODE8_DESC       = "Test khwamreo download baep reo"
        MODE9            = "SHOW IP CONFIG"
        MODE9_DESC       = "Sa-daeng ipconfig /all"
        MODE10           = "CHANGE LANGUAGE"
        MODE10_DESC      = "Saplian EN / SIMPLE-TH"
        MODE0            = "EXIT"
        FLUSH_DNS        = "Gamlang lang DNS cache..."
        CLEAR_ARP        = "Gamlang lang ARP cache..."
        RELEASE_RENEW    = "Gamlang ploi / kho IP mai..."
        APPLY_REFRESH    = "Gamlang refresh network baep safe..."
        RECONNECTING     = "Gamlang reconnect Wi-Fi adapter..."
        RESET_WINSOCK    = "Gamlang reset Winsock..."
        RESET_IP         = "Gamlang reset IP stack..."
        SHOWING_WIFI     = "Gamlang sa-daeng sathana Wi-Fi..."
        SHOWING_IP       = "Gamlang sa-daeng khomun IP..."
        PING_TEST        = "Test Ping reo (1.1.1.1 x10)"
        SPEED_TEST       = "Gamlang test khwamreo..."
        INTERNET_DIAG    = "Wikroh internet"
        LANGUAGE_CHANGED = "Saplian phasa laeo"
        SPEED_RESULT     = "Khwamreo download pramaan"
        NOTE_RESTART     = "Lang reset Winsock/IP nae-nam hai restart"
    }
}

function T($key) {
    return $TXT[$global:Lang][$key]
}

function Pause-Return {
    Write-Host ""
    Read-Host (T "BACK") | Out-Null
}

function Get-ActiveWiFiName {
    $name = ""
    $output = netsh wlan show interfaces
    foreach ($line in $output) {
        if ($line -match '^\s*Name\s*:\s*(.+)$') {
            $name = $Matches[1].Trim()
            break
        }
    }
    return $name
}

function Refresh-WiFiName {
    $global:WiFiName = Get-ActiveWiFiName
}

function Show-Header {
    Clear-Host
    Refresh-WiFiName

    Write-Host "=========================================================" -ForegroundColor Cyan
    Write-Host ("         " + (T "TITLE")) -ForegroundColor Green
    Write-Host ("             " + (T "SUBTITLE")) -ForegroundColor DarkGray
    Write-Host "=========================================================" -ForegroundColor Cyan

    if ([string]::IsNullOrWhiteSpace($global:WiFiName)) {
        Write-Host ("  " + (T "WIFI_ACTIVE") + ' : [Not Connected]') -ForegroundColor Yellow
    } else {
        Write-Host ("  " + (T "WIFI_ACTIVE") + ' : "' + $global:WiFiName + '"') -ForegroundColor Yellow
    }

    Write-Host ("  Language : " + $global:Lang) -ForegroundColor Magenta
    Write-Host "=========================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Show-Menu {
    Show-Header

    Write-Host ('  [1]  ' + (T "MODE1")  + '   (' + (T "MODE1_DESC")  + ')')
    Write-Host ('  [2]  ' + (T "MODE2")  + '   (' + (T "MODE2_DESC")  + ')')
    Write-Host ('  [3]  ' + (T "MODE3")  + '   (' + (T "MODE3_DESC")  + ')')
    Write-Host ('  [4]  ' + (T "MODE4")  + '   (' + (T "MODE4_DESC")  + ')')
    Write-Host ('  [5]  ' + (T "MODE5")  + '   (' + (T "MODE5_DESC")  + ')')
    Write-Host ('  [6]  ' + (T "MODE6")  + '   (' + (T "MODE6_DESC")  + ')')
    Write-Host ('  [7]  ' + (T "MODE7")  + '   (' + (T "MODE7_DESC")  + ')')
    Write-Host ('  [8]  ' + (T "MODE8")  + '   (' + (T "MODE8_DESC")  + ')')
    Write-Host ('  [9]  ' + (T "MODE9")  + '   (' + (T "MODE9_DESC")  + ')')
    Write-Host ('  [10] ' + (T "MODE10") + '   (' + (T "MODE10_DESC") + ')')
    Write-Host ('  [0]  ' + (T "MODE0"))
    Write-Host ""
}

function Run-SafeDaily {
    Show-Header
    Write-Host ("[INFO] " + (T "MODE1")) -ForegroundColor Green
    Write-Host ""

    Write-Host ("[*] " + (T "FLUSH_DNS"))
    ipconfig /flushdns

    Write-Host ""
    Write-Host ("[*] " + (T "CLEAR_ARP"))
    arp -d *

    Write-Host ""
    Write-Host ("[*] " + (T "APPLY_REFRESH"))
    netsh int tcp set global autotuninglevel=normal | Out-Null
    netsh int tcp set heuristics disabled | Out-Null

    Write-Host ""
    Write-Host ("[OK] " + (T "DONE")) -ForegroundColor Green
    Pause-Return
}

function Run-SmartRefresh {
    Show-Header
    Write-Host ("[INFO] " + (T "MODE2")) -ForegroundColor Green
    Write-Host ""

    Write-Host ("[*] " + (T "FLUSH_DNS"))
    ipconfig /flushdns

    Write-Host ""
    Write-Host ("[*] " + (T "CLEAR_ARP"))
    arp -d *

    Write-Host ""
    Write-Host ("[*] " + (T "RELEASE_RENEW"))
    ipconfig /release
    Start-Sleep -Seconds 2
    ipconfig /renew

    Write-Host ""
    Write-Host ("[*] " + (T "APPLY_REFRESH"))
    netsh int tcp set global autotuninglevel=normal | Out-Null
    netsh int tcp set heuristics disabled | Out-Null

    Write-Host ""
    Write-Host ("[OK] " + (T "DONE")) -ForegroundColor Green
    Pause-Return
}

function Run-ReconnectWiFi {
    Show-Header
    Refresh-WiFiName

    if ([string]::IsNullOrWhiteSpace($global:WiFiName)) {
        Write-Host ("[!] " + (T "NO_WIFI")) -ForegroundColor Yellow
        Pause-Return
        return
    }

    Write-Host ("[INFO] " + (T "MODE3")) -ForegroundColor Green
    Write-Host ""

    Write-Host ("[*] " + (T "RECONNECTING"))
    netsh interface set interface name="$($global:WiFiName)" admin=disabled
    Start-Sleep -Seconds 3
    netsh interface set interface name="$($global:WiFiName)" admin=enabled
    Start-Sleep -Seconds 5

    Write-Host ""
    Write-Host ("[OK] " + (T "DONE")) -ForegroundColor Green
    Pause-Return
}

function Run-FullCleanFix {
    Show-Header
    Refresh-WiFiName

    Write-Host ("[INFO] " + (T "MODE4")) -ForegroundColor Green
    Write-Host ""

    Write-Host ("[*] " + (T "RESET_WINSOCK"))
    netsh winsock reset

    Write-Host ""
    Write-Host ("[*] " + (T "RESET_IP"))
    netsh int ip reset

    Write-Host ""
    Write-Host ("[*] " + (T "FLUSH_DNS"))
    ipconfig /flushdns

    Write-Host ""
    Write-Host ("[*] " + (T "CLEAR_ARP"))
    arp -d *

    if (-not [string]::IsNullOrWhiteSpace($global:WiFiName)) {
        Write-Host ""
        Write-Host ("[*] " + (T "RECONNECTING"))
        netsh interface set interface name="$($global:WiFiName)" admin=disabled
        Start-Sleep -Seconds 3
        netsh interface set interface name="$($global:WiFiName)" admin=enabled
        Start-Sleep -Seconds 5
    }

    Write-Host ""
    Write-Host ("[OK] " + (T "DONE")) -ForegroundColor Green
    Write-Host ("[TIP] " + (T "NOTE_RESTART")) -ForegroundColor Yellow
    Pause-Return
}

function Show-InternetDiag {
    Show-Header
    Write-Host ("[INFO] " + (T "INTERNET_DIAG")) -ForegroundColor Green
    Write-Host ""

    Write-Host "=== PING 1.1.1.1 ===" -ForegroundColor Cyan
    ping 1.1.1.1 -n 4

    Write-Host ""
    Write-Host "=== PING google.com ===" -ForegroundColor Cyan
    ping google.com -n 4

    Write-Host ""
    Write-Host "=== ROUTE ===" -ForegroundColor Cyan
    route print | Select-Object -First 25

    Write-Host ""
    Write-Host "=== DNS / GATEWAY ===" -ForegroundColor Cyan
    ipconfig /all | Select-String "DNS Servers|Default Gateway"

    Pause-Return
}

function Show-WiFiDetails {
    Show-Header
    Write-Host ("[INFO] " + (T "SHOWING_WIFI")) -ForegroundColor Green
    Write-Host ""

    netsh wlan show interfaces
    Pause-Return
}

function Run-QuickPingTest {
    Show-Header
    Write-Host ("[INFO] " + (T "PING_TEST")) -ForegroundColor Green
    Write-Host ""

    ping 1.1.1.1 -n 10
    Pause-Return
}

function Run-SpeedTestBasic {
    Show-Header
    Write-Host ("[INFO] " + (T "SPEED_TEST")) -ForegroundColor Green
    Write-Host ""

    try {
        $url = "https://speed.cloudflare.com/__down?bytes=10000000"
        $tempFile = Join-Path $env:TEMP "nettool_speedtest.tmp"

        if (Test-Path $tempFile) { Remove-Item $tempFile -Force }

        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        Invoke-WebRequest -Uri $url -OutFile $tempFile -UseBasicParsing
        $sw.Stop()

        $bytes = (Get-Item $tempFile).Length
        $mbps = [math]::Round((($bytes * 8) / 1MB) / $sw.Elapsed.TotalSeconds, 2)

        Write-Host ""
        Write-Host ((T "SPEED_RESULT") + " : " + $mbps + " Mbps") -ForegroundColor Cyan

        Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
    }
    catch {
        Write-Host ""
        Write-Host "Speed test failed. Check internet access." -ForegroundColor Red
    }

    Pause-Return
}

function Show-IPConfig {
    Show-Header
    Write-Host ("[INFO] " + (T "SHOWING_IP")) -ForegroundColor Green
    Write-Host ""

    ipconfig /all
    Pause-Return
}

function Change-Language {
    if ($global:Lang -eq "EN") {
        $global:Lang = "TH"
    } else {
        $global:Lang = "EN"
    }

    Show-Header
    Write-Host ("[OK] " + (T "LANGUAGE_CHANGED")) -ForegroundColor Green
    Start-Sleep -Milliseconds 900
}

while ($true) {
    Show-Menu
    $choice = Read-Host (T "SELECT_MODE")

    switch ($choice) {
        "1"  { Run-SafeDaily }
        "2"  { Run-SmartRefresh }
        "3"  { Run-ReconnectWiFi }
        "4"  { Run-FullCleanFix }
        "5"  { Show-InternetDiag }
        "6"  { Show-WiFiDetails }
        "7"  { Run-QuickPingTest }
        "8"  { Run-SpeedTestBasic }
        "9"  { Show-IPConfig }
        "10" { Change-Language }
        "0"  {
            Write-Host ""
            Write-Host (T "EXITING") -ForegroundColor Yellow
            Start-Sleep -Milliseconds 700
            break
        }
        default {
            Write-Host ""
            Write-Host (T "INVALID") -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
}