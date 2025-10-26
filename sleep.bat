@echo off
title Simpler Shutdown Timer
setlocal EnableExtensions EnableDelayedExpansion

echo ================================
echo    Einfacher Shutdown-Timer
echo ================================
echo.

:ask
set /p hours=In wie vielen Stunden soll der PC herunterfahren? (z.B. 1, 2, 5):
REM simple Validierung (nur Zahlen)
set /a _test=%hours%*1 2>nul || (echo Ungueltige Zahl.& echo.& goto ask)

REM Stunden → Sekunden
set /a total=%hours%*3600

echo.
echo PC wird in %hours% Stunde(n) heruntergefahren.
echo (System-Timer gesetzt: shutdown /s /t !total!)
echo Abbrechen/pruefen in zweiter Konsole:  shutdown /a
echo -----------------------------------------------
echo.

REM Windows-eigenen Shutdown-Timer setzen (pruef-/abbrechbar)
shutdown /s /t !total!

set /a remaining=!total!

:countdown
cls
set /a h=remaining/3600
set /a m=(remaining%%3600)/60
set /a s=remaining%%60

if !h! LSS 10 set "h=0!h!"
if !m! LSS 10 set "m=0!m!"
if !s! LSS 10 set "s=0!s!"

echo ***************************************
echo   Countdown zum Herunterfahren
echo ***************************************
echo   Verbleibende Zeit: !h!:!m!:!s!   (hh:mm:ss)
echo   Abbrechen: STRG+C  oder  in anderem Fenster:  shutdown /a
echo ***************************************

timeout /t 1 /nobreak >nul
set /a remaining-=1
if !remaining! GTR 0 goto countdown

REM Kein eigener shutdown hier, das macht Windows via /t !
echo.
echo (Hinweis: Falls der Shutdown abgebrochen wurde, lief die Zeit hier nur visuell.)
pause
