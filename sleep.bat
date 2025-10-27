@echo off
title Simple Shutdown Timer by xn4k
setlocal EnableExtensions EnableDelayedExpansion
color 0A

echo ================================
echo    Simple Shutdown-Timer
echo ================================
echo.

:ask
set /p hours=How many hours should the PC shut down? (z.B. 1, 2, 5):
REM simple Validierung (nur Zahlen)
set /a _test=%hours%*1 2>nul || (echo Incorrect numbers.& echo.& goto ask)

REM Stunden → Sekunden
set /a total=%hours%*3600

echo.
echo PC will shut down in %hours% hour(s).
echo (System timer set: shutdown /s /t !total!)
echo Cancel/check in second console: shutdown /a
echo -----------------------------------------------
echo.

REM Windows-eigenen Shutdown-Timer setzen (pruef-/abbrechbar)
shutdown /s /t !total!

set /a remaining=!total!

REM >>> WICHTIG: vor die Subroutinen springen, sonst faellt der Flow in :fx_* und beendet die Batch
goto countdown

REM ====== FX: einfache Matrix-Zeile (nur Batch) ======
:fx_randline
rem Breite der Zeile (anpassen, z.B. 64)
setlocal EnableDelayedExpansion
set /a W=64
set "line="
for /L %%I in (1,1,!W!) do (
  rem Zufallshex-Zeichen 0..15 -> 0..F
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

REM ====== FX: mehrere Zeilen pro Frame ======
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
echo   Countdown zum Herunterfahren
echo ***************************************
echo   Verbleibende Zeit: !hh!:!mm!:!ss!   (hh:mm:ss)
echo   Abbrechen: STRG+C  oder  in anderem Fenster:  shutdown /a
echo ***************************************
call :fx_frame

timeout /t 1 /nobreak >nul
set /a remaining-=1
if !remaining! GTR 0 goto countdown

REM Kein eigener shutdown hier, das macht Windows via /t !
echo.
echo (Hinweis: Falls der Shutdown abgebrochen wurde, lief die Zeit hier nur visuell.)
color 07
pause
