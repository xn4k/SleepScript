@echo off
title Simple Shutdown Timer by xn4k
setlocal EnableExtensions EnableDelayedExpansion
color 0A

echo ===================================
echo        Simple Shutdown Timer
echo ===================================
echo.

echo This script schedules a system shutdown after
echo the requested number of hours and displays a

echo live countdown.
echo.

echo Cancel anytime with CTRL+C or from another

echo Command Prompt window by running: shutdown /a
echo.

call :setupCtrlCHandler

:ask
set /p hours=How many hours from now should the PC shut down? (e.g. 1, 2, 5): 
if "!hours!"=="" (
    echo Please enter a number.
    echo.
    goto ask
)

REM Simple validation (digits only)
for /f "delims=0123456789" %%G in ("!hours!") do (
    echo Only whole numbers are supported.
    echo.
    goto ask
)

set /a hoursInt=!hours!
if !hoursInt! LSS 1 (
    echo Please enter a value of at least 1 hour.
    echo.
    goto ask
)

REM Hours -> seconds
set /a total=!hoursInt!*3600

echo.
echo PC will shut down in !hoursInt! hour(s).
echo (System timer set with: shutdown /s /t !total!)
echo Cancel or check in another window with: shutdown /a
echo -----------------------------------------------
echo.

REM Configure Windows shutdown timer (can be checked/cancelled globally)
shutdown /s /t !total!

set /a remaining=!total!

REM Jump to countdown to avoid falling through to helper routines
goto countdown

REM ====== FX: simple Matrix-style line ======
:fx_randline
setlocal EnableDelayedExpansion
set /a W=64
set "line="
for /L %%I in (1,1,!W!) do (
  set /a r=!random!%%16
  set "ch=0"
  if !r! GEQ 1  set "ch=1"
  if !r! GEQ 2  set "ch=2"
  if !r! GEQ 3  set "ch=3"
  if !r! GEQ 4  set "ch=4"
  if !r! GEQ 5  set "ch=5"
  if !r! GEQ 6  set "ch=6"
  if !r! GEQ 7  set "ch=7"
  if !r! GEQ 8  set "ch=8"
  if !r! GEQ 9  set "ch=9"
  if !r! GEQ 10 set "ch=A"
  if !r! GEQ 11 set "ch=B"
  if !r! GEQ 12 set "ch=C"
  if !r! GEQ 13 set "ch=D"
  if !r! GEQ 14 set "ch=E"
  if !r! GEQ 15 set "ch=F"
  set "line=!line!!ch!"
)
echo      !line!
endlocal
goto :eof

REM ====== FX: multiple lines per frame ======
:fx_frame
setlocal EnableDelayedExpansion
set /a LINES=10
for /L %%R in (1,1,!LINES!) do call :fx_randline
endlocal
goto :eof

:countdown
cls
set /a h=remaining/3600
set /a m=(remaining%%3600)/60
set /a s=remaining%%60

set "hh=!h!"
set "mm=!m!"
set "ss=!s!"
if !h! LSS 10 set "hh=0!h!"
if !m! LSS 10 set "mm=0!m!"
if !s! LSS 10 set "ss=0!s!"

echo ***************************************
echo        Shutdown Countdown
echo ***************************************
echo   Remaining Time: !hh!:!mm!:!ss!   (hh:mm:ss)
echo   Cancel: CTRL+C  or from another window: shutdown /a
echo ***************************************
call :fx_frame

timeout /t 1 /nobreak >nul
set /a remaining-=1
if !remaining! GTR 0 goto countdown

echo.
echo (If the shutdown was canceled, the countdown above was only visual.)
color 07
call :teardownCtrlCHandler
pause
goto :eof

:setupCtrlCHandler
REM Install a background PowerShell helper that will run "shutdown /a" when CTRL+C is pressed.
set "CTRLCHelperActive="
where powershell.exe >nul 2>&1 || (
    echo Warning: PowerShell not found. CTRL+C will not automatically cancel the system shutdown timer.
    goto :eof
)

set "ctrlcScript=%temp%\sleep-ctrlc-!random!!random!.ps1"
set "ctrlcSentinel=%temp%\sleep-ctrlc-sentinel-!random!!random!.tmp"
type nul >"!ctrlcSentinel!"

>"!ctrlcScript!" (
    echo param([string]$SentinelPath)
    echo $ErrorActionPreference = 'SilentlyContinue'
    echo $handler = [System.ConsoleCancelEventHandler]{
    echo     param($sender, $eventArgs)
    echo     try { Start-Process -FilePath "shutdown" -ArgumentList "/a" -WindowStyle Hidden ^| Out-Null } catch { }
    echo     try { Remove-Item -LiteralPath $SentinelPath -ErrorAction SilentlyContinue } catch { }
    echo }
    echo try {
    echo     [Console]::CancelKeyPress += $handler
    echo     while (Test-Path -LiteralPath $SentinelPath) {
    echo         Start-Sleep -Milliseconds 200
    echo     }
    echo }
    echo finally {
    echo     [Console]::CancelKeyPress -= $handler
    echo }
)

start "" /B powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File "!ctrlcScript!" "!ctrlcSentinel!"
set "CTRLCHelperActive=1"
goto :eof

:teardownCtrlCHandler
if not defined CTRLCHelperActive goto :eof
if defined ctrlcSentinel if exist "!ctrlcSentinel!" del "!ctrlcSentinel!" >nul 2>&1
if defined ctrlcScript if exist "!ctrlcScript!" del "!ctrlcScript!" >nul 2>&1
set "CTRLCHelperActive="
goto :eof
