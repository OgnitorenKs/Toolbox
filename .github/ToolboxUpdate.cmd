echo off
chcp 65001 > NUL
setlocal enabledelayedexpansion
mode con cols=80 lines=30
title OgnitorenKs Toolbox Updater
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set R=%%b)
RD /S /Q "%Konum%" > NUL 2>&1
MD "%Konum%" > NUL 2>&1

:: =============================================================
:: Güncelleme dosyası indirilir
cls&Call :Panel "[■■■■■■■■■■■■                                    ]" "%R%[92m   Updating OgnitorenKs Toolbox...%R%[0m"
Call :Powershell "& { iwr https://raw.githubusercontent.com/OgnitorenKs/Toolbox/main/.github/Toolbox.zip -OutFile %temp%\OgnitorenKs_Toolbox.zip }"

:: İndirilen güncelleme zip dosyası klasörü çıkarılır.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■■■■■                        ]" "%R%[92m   Updating OgnitorenKs Toolbox...%R%[0m"
Call :Powershell "Expand-Archive -Force '%temp%\OgnitorenKs_Toolbox.zip' '%Konum%'"

:: Güncelleme zip dosyası silinir.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■            ]" "%R%[92m   Updating OgnitorenKs Toolbox...%R%[0m"
DEL /F /Q /A "%temp%\OgnitorenKs_Toolbox.zip" > NUL 2>&1

(
echo Set oWS = WScript.CreateObject^("WScript.Shell"^)
echo sLinkFile = "C:\Users\%username%\Desktop\OgnitorenKs.Toolbox.lnk"
echo Set oLink = oWS.CreateShortcut^(sLinkFile^)
echo oLink.TargetPath = "%Konum%\OgnitorenKs.Toolbox.cmd"
echo oLink.WorkingDirectory = "%Konum%"
echo oLink.Description = "OgnitorenKs Toolbox"
echo oLink.IconLocation = "%Konum%\Bin\Icon\Ogni.ico"
echo oLink.Save
) > %Temp%\OgnitorenKs.Shortcut.vbs
cscript "%Temp%\OgnitorenKs.Shortcut.vbs" > NUL 2>&1
DEL /F /Q /A "%Temp%\OgnitorenKs.Shortcut.vbs" > NUL 2>&1

:: Güncel Toolbox açılır.
Call :Powershell "Start-Process '%Konum%\OgnitorenKs.Toolbox.cmd' -Verb Runas"
DEL /F /Q /A "%temp%\ToolboxUpdate.cmd"
exit
:: =============================================================
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:Panel
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                     %~2
echo.            
echo               %~1
echo.
echo             %R%[33m████ ████ █   █ █ █████ ████ ████ ███ █   █ █  █ ████%R%[0m
echo             %R%[33m█  █ █    ██  █ █   █   █  █ █  █ █   ██  █ █ █  █   %R%[0m
echo             %R%[33m█  █ █ ██ █ █ █ █   █   █  █ ████ ██  █ █ █ ██   ████%R%[0m
echo             %R%[33m█  █ █  █ █  ██ █   █   █  █ █ █  █   █  ██ █ █     █%R%[0m
echo             %R%[33m████ ████ █   █ █   █   ████ █  █ ███ █   █ █  █ ████%R%[0m
goto :eof

:: -------------------------------------------------------------
:Powershell
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof


