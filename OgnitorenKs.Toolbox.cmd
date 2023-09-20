:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
::
::       ██████   ██████   ██    ██ ████ ████████  ██████  ████████  ████████ ██    ██ ██    ██  ██████
::      ██    ██ ██    ██  ███   ██  ██     ██    ██    ██ ██     ██ ██       ███   ██ ██   ██  ██    █
::      ██    ██ ██        ████  ██  ██     ██    ██    ██ ██     ██ ██       ████  ██ ██  ██   ██     
::      ██    ██ ██   ████ ██ ██ ██  ██     ██    ██    ██ ████████  ██████   ██ ██ ██ █████      ██████
::      ██    ██ ██    ██  ██  ████  ██     ██    ██    ██ ██   ██   ██       ██  ████ ██  ██         ██
::      ██    ██ ██    ██  ██   ███  ██     ██    ██    ██ ██    ██  ██       ██   ███ ██   ██  ██    ██
::       ██████   ██████   ██    ██ ████    ██     ██████  ██     ██ ████████ ██    ██ ██    ██  ██████ 
::
::                    ████████ ███████ ███████ ██      ██████  ███████  ██    ██
::                       ██    ██   ██ ██   ██ ██      ██   ██ ██   ██   ██  ██ 
::                       ██    ██   ██ ██   ██ ██      ██████  ██   ██     ██   
::                       ██    ██   ██ ██   ██ ██      ██   ██ ██   ██   ██  ██ 
::                       ██    ███████ ███████ ███████ ██████  ███████  ██    ██
::
::  ► Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
::
::  ► İletişim - Contact;
::  --------------------------------------
::  • Discord: ognitorenks
::  •    Mail: ognitorenks@gmail.com
::  •    Site: https://ognitorenks.blogspot.com
::
:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:OgnitorenKs.Toolbox
echo off
chcp 65001 > NUL 2>&1
setlocal enabledelayedexpansion
title  OgnitorenKs Toolbox
set Version=4.0.9
mode con cols=100 lines=23

:: -------------------------------------------------------------
:: Renklendirm için gerekli
FOR /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E#&echo on&for %%b in (1) do rem"') do (set R=%%b)

:: -------------------------------------------------------------
Call :Ogni_Label
:: -------------------------------------------------------------
:: Toolbox konumunu değişkene tanımlar
cd /d "%~dp0"
FOR /F "tokens=*" %%a in ('cd') do (set Konum=%%a)
:: Değişkenler
set NSudo="%Konum%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c
MD "%Konum%\Log" > NUL 2>&1
set Error=NT

:: -------------------------------------------------------------
:: Yönetici yetkisi
reg query "HKU\S-1-5-19" > NUL 2>&1
	if !errorlevel! NEQ 0 (Call :Powershell "Start-Process '%Konum%\OgnitorenKs.Toolbox.cmd' -Verb Runas"&exit)

:: -------------------------------------------------------------
Findstr /i "Language_Pack" %Konum%\Settings.ini > NUL 2>&1
	if !errorlevel! NEQ 0 (FOR /F "tokens=6" %%a in ('Dism /Online /Get-intl ^| Find /I "Default system UI language"') do (
								if %%a EQU tr-TR (echo. >> %Konum%\Settings.ini
												  echo Language_Pack^>Turkish^> >> %Konum%\Settings.ini
												  set Dil=%Konum%\Bin\Language\Turkish.cmd)
								if %%a NEQ tr-TR (echo. >> %Konum%\Settings.ini
												  echo Language_Pack^>English^> >> %Konum%\Settings.ini
												  set Dil=%Konum%\Bin\Language\English.cmd)))
	if !errorlevel! EQU 0 (FOR /F "delims=> tokens=2" %%a in ('Findstr /i "Language_Pack" %Konum%\Settings.ini') do (set Dil=%Konum%\Bin\Language\%%a.cmd))

:: -------------------------------------------------------------
:: Boşluk ve Türkçe karakter kontrolü
FOR %%a in (Ö ö Ü ü Ğ ğ Ş ş Ç ç ı İ) do (
	echo %Konum% | Find "%%a" > NUL 2>&1
		if !errorlevel! EQU 0 (cls&Call :Dil A 2 Error_1_&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 5&exit)
)
if "%Konum%" NEQ "%Konum: =%" (cls&Call :Dil A 2 Error_2_&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 5&exit)

:: -------------------------------------------------------------
:: Sistem mimari kontrolü
FOR /F "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE" 2^>NUL') do (
	if %%a NEQ AMD64 (cls&Call :Dil A 2 Error_3_&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 5&exit)
)

:: -------------------------------------------------------------
:: Sistem bilgileri
Call :Powershell "Get-CimInstance Win32_OperatingSystem | Select-Object Caption,InstallDate,OSArchitecture,RegisteredUser,CSName | FL" > %Konum%\Log\OS
FOR /F "tokens=5" %%a in ('Findstr /i "Caption" %Konum%\Log\OS') do set Win=%%a
:: Sistem kontrolü
:: Windows 8.1 kontrol sisteminde hataya neden olduğu için iki farklı kontrol durumu oluşturdum
:: 8.1 tespit edildiğinde birim 8 olarak alınıyor.
echo %Win% | Findstr /i "." > NUL 2>&1
	if !errorlevel! EQU 0 (FOR /F "delims=. tokens=1" %%a in ('echo %Win%') do (if %%a LSS 10 (cls&Call :Dil A 2 Error_7_&echo %R%[31m !LA2! %R%[0m&Call :Bekle 5&exit)))
	if !errorlevel! NEQ 0 (if %Win% LSS 10 (cls&Call :Dil A 2 Error_7_&echo %R%[31m !LA2! %R%[0m&Call :Bekle 5&exit))
::FOR /F "skip=2 delims=. tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Update\TargetingInfo\Installed\Client.OS.rs2.amd64" /v "Version"') do (
::	if !Win! EQU 10 if %%a GEQ 19045 (goto Kontrol)
::	if !Win! EQU 11 if %%a GEQ 22621 (goto Kontrol)
::)
::Call :Dil A 2 Error_8&cls&echo.&echo %R%[91m !LA2! %R%[0m&Call :Bekle 7&exit

:: -------------------------------------------------------------
:Kontrol
Call :Check_Internet
if %Internet% EQU Offline (goto Main_Menu)
:: -------------------------------------------------------------
:: Toolbox güncelleştirme bölümü
FOR /F "delims=> tokens=2" %%a in ('Findstr /i "Toolbox.Update." %Konum%\Settings.ini') do (
	if %%a EQU 0 (Call :Link 4&Call :PSDownload "%Konum%\Bin\Extra\Link.txt"
				  FOR /F "delims=> tokens=2" %%b in ('Findstr /i "Toolbox.Version." %Konum%\Bin\Extra\Link.txt') do (
					if !Version! NEQ %%b (cls&Call :Dil A 2 T0022&echo.&echo %R%[92m !LA2! %R%[0m
										  Call :Dil A 2 T0023&echo.&echo %R%[33m !LA2! %R%[90m=%R%[37m !Version! %R%[0m
										  Call :Dil A 2 T0024&echo %R%[33m !LA2! %R%[90m=%R%[37m %%b %R%[0m
										  Call :Bekle 5
										  Call :Link 3&Call :PSDownload "%Temp%\ToolboxUpdate.cmd"
										  Call :Powershell "Start-Process '%Temp%\ToolboxUpdate.cmd'"
										  exit)
		)
	)
)

:: ██████████████████████████████████████████████████████████████████
:Main_Menu
FOR /F "tokens=2 delims=':'" %%a in ('FIND "Caption" %Konum%\Log\OS') do set Value1=%%a
set Value1=%Value1:~11%
FOR /F "tokens=2 delims=':'" %%b in ('FIND "RegisteredUser" %Konum%\Log\OS') do set Value2=%%b
FOR /F "tokens=3 delims= " %%f in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Update\TargetingInfo\Installed\Client.OS.rs2.amd64" /v "Version" 2^>NUL') do set Value3=%%f
set Value3=%Value3:~5%
FOR /F "skip=1 tokens=3" %%b in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "DisplayVersion" 2^>NUL') do (set Value4=%%b)
Call :Date
set DateYear=
set Value_M=NT
mode con cols=100 lines=23
title               O  G  N  I  T  O  R  E  N  K  S     ^|    OGNITORENKS TOOLBOX    ^|       T   O   O   L   B   O   X
echo    %R%[90mAMD64                                                                               %DateDay%%R%[0m
echo    %R%[90m████ ████ █   █ ███ █████ ████ ████ ███ █   █ █  █ ████    %R%[90m█████ ████ ████ █   ███  ████ █   █%R%[0m
echo    %R%[90m█  █ █    ██  █  █    █   █  █ █  █ █   ██  █ █ █  █       %R%[90m  █   █  █ █  █ █   █  █ █  █  █ █ %R%[0m
echo    %R%[90m█  █ █ ██ █ █ █  █    █   █  █ ████ ██  █ █ █ ██   ████    %R%[90m  █   █  █ █  █ █   ███  █  █   █  %R%[0m
echo    %R%[90m█  █ █  █ █  ██  █    █   █  █ █ █  █   █  ██ █ █     █    %R%[90m  █   █  █ █  █ █   █  █ █  █  █ █ %R%[0m
echo    %R%[90m████ ████ █   █ ███   █   ████ █  █ ███ █   █ █  █ ████    %R%[90m  █   ████ ████ ███ ███  ████ █   █%R%[0m
echo    %R%[90mhttps://ognitorenks.blogspot.com                                                         %R%[90m%version%%R%[0m
echo.
echo       %R%[90m %Value2%: %Value1% ^| %Value4% ^| %Value3%%R%[0m
Call %Dil% :Menu_1
Call :Dil A 2 D0001&set /p Value_M=%R%[32m        !LA2!: %R%[0m
Call :Upper %Value_M% Value_M
title  OgnitorenKs Toolbox
	if %Value_M% EQU 1 (goto Software_Installer)
	if %Value_M% EQU 2 (goto Service_Menu)
	if %Value_M% EQU 3 (goto Features_Warning)
	if %Value_M% EQU 4 (goto Oto_Kapat)
	if %Value_M% EQU 5 (goto Ping_Metre)
	if %Value_M% EQU 6 (goto User_Licence_Manager)
	if %Value_M% EQU 7 (goto Sistem_Bilgi)
	if %Value_M% EQU 8 (goto Wifi_Info)
	if %Value_M% EQU 9 (set Error=X&Call :Cleaner)
	if %Value_M% EQU 10 (Call :Windows_Repair)
	if %Value_M% EQU 11 (goto Performans_Edit)
	if %Value_M% EQU Z (goto Language_Select)
	if %Value_M% EQU X (exit)
	if %Error% EQU X (goto Main_Menu)
Call :ProcessCompleted
goto Main_Menu

:: -------------------------------------------------------------
:Software_Installer
Call :Check_Internet
if %Internet% EQU Offline (Call :Dil A 2 Error_9_&cls&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 4&goto Main_Menu)
mode con cols=98 lines=38
Call :Powershell "Get-AppxPackage -AllUsers" > %Konum%\Log\Appx
Findstr /i "Microsoft.WindowsStore_8wekyb3d8bbwe" %Konum%\Log\Appx > NUL 2>&1
	if !errorlevel! NEQ 0 (Call :Dil A 2 E0006&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 7&goto Main_Menu)
Findstr /i "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe" %Konum%\Log\Appx > NUL 2>&1
	 if !errorlevel! NEQ 0 (Call :Dil A 2 T0016&echo.&echo %R%[31m !LA2!%R%[0m&Call :Link 1&start !Link!&Call :Bekle 7&goto Main_Menu)
winget > NUL 2>&1
	if !errorlevel! NEQ 0 (Call :Dil A 2 T0017&echo.&echo %R%[32m !LA2!%R%[0m&Call :Link 2&start !Link!&Call :Bekle 7&goto Main_Menu)
Call :DEL %Konum%\Log\Appx
Call %Dil% :Menu_2
set Value_M=NT
Call :Dil A 2 D0002&set /p Value_M=%R%[32m  !LA2! %R%[90mx,y: %R%[0m
Call :Upper %Value_M% Value_M
echo %Value_M% | Findstr /i "X" > NUL 2>&1
	if !errorlevel! EQU 0 (goto Main_Menu)
echo %Value_M% | Findstr /i "81" > NUL 2>&1
	if !errorlevel! EQU 0 (winget upgrade --all --uninstall-previous)
echo %Value_M% | Findstr /i "80" > NUL 2>&1
	if !errorlevel! EQU 0 (Call :Link 2&start !Link!)
Call :Dil A 2 T0003
FOR %%a in (%Value_M%) do (
	cls&echo.&echo  ►%R%[92m !LA2!:%R%[0m %Value_M%
	if %%a EQU 1 (Call :AIO.Runtimes)
	if %%a EQU 2 (Call :Winget Discord.Discord)
	if %%a EQU 3 (Call :Winget WhatsApp.WhatsApp)
	if %%a EQU 4 (Call :Winget OpenWhisperSystems.Signal)
	if %%a EQU 5 (Call :Winget Telegram.TelegramDesktop)
	if %%a EQU 6 (Call :Winget Zoom.Zoom)
	if %%a EQU 7 (Call :Winget EpicGames.EpicGamesLauncher)
	if %%a EQU 8 (Call :Winget Valve.Steam)
	if %%a EQU 9 (Call :Winget GOG.Galaxy)
	if %%a EQU 10 (Call :Winget Ubisoft.Connect)
	if %%a EQU 11 (Call :Winget ElectronicArts.EADesktop)
	if %%a EQU 12 (Call :Winget Playnite.Playnite)
	if %%a EQU 13 (Call :Winget Hibbiki.Chromium)
	if %%a EQU 14 (Call :Winget eloston.ungoogled-chromium)
	if %%a EQU 15 (Call :Winget Google.Chrome)
	if %%a EQU 16 (Call :Winget Microsoft.Edge)
	if %%a EQU 17 (Call :Winget Brave.Brave)
	if %%a EQU 18 (Call :Winget CentStudio.CentBrowser)
	if %%a EQU 19 (Call :Winget VivaldiTechnologies.Vivaldi)
	if %%a EQU 20 (Call :Winget DuckDuckGo.DesktopBrowser)
	if %%a EQU 21 (Call :Winget Opera.Opera)
	if %%a EQU 22 (Call :Winget Opera.OperaGX)
	if %%a EQU 23 (Call :Winget Mozilla.Firefox)
	if %%a EQU 24 (Call :Winget LibreWolf.LibreWolf)
	if %%a EQU 25 (Call :Winget TorProject.TorBrowser)
	if %%a EQU 26 (Call :Winget KDE.Kdenlive)
	if %%a EQU 27 (Call :Winget OpenShot.OpenShot)
	if %%a EQU 28 (Call :Winget Meltytech.Shotcut)
	if %%a EQU 29 (Call :Winget KDE.Krita)
	if %%a EQU 30 (Call :Winget GIMP.GIMP)
	if %%a EQU 31 (Call :Winget sylikc.JPEGView
				   set AppRoad=%programfiles%\JPEGView\JPEGView.exe
				   set AppIcon=%programfiles%\JPEGView\JPEGView.exe
				   set AppKey=JPEGView
				   set Default=bmp jpg jpeg png gif tiff webp tga jxl heif heic avif wdp hdp jxr dng crw cr2 nef nrw arw sr2 orf rw2 raf x3f pef mrw kdc dcr wic
				   Call :Default_App
				   MD "%AppData%\JPEGView" > NUL 2>&1
				   Copy /y "%Konum%\Bin\Icon\JPEGView.ini" "%AppData%\JPEGView" > NUL 2>&1)
	if %%a EQU 32 (Call :Winget OBSProject.OBSStudio)
	if %%a EQU 33 (Call :Winget ShareX.ShareX)
	if %%a EQU 34 (Call :Winget Skillbrains.Lightshot)
	if %%a EQU 35 (Call :Winget Audacity.Audacity)
	if %%a EQU 36 (Call :Winget HandBrake.HandBrake)
	if %%a EQU 37 (Call :Winget AdrianAllard.FileConverter)
	if %%a EQU 38 (Call :Winget CodecGuide.K-LiteCodecPack.Mega)
	if %%a EQU 39 (Call :Winget VideoLAN.VLC)
	if %%a EQU 40 (Call :Winget Daum.PotPlayer)
	if %%a EQU 41 (Call :Winget AIMP.AIMP)
	if %%a EQU 42 (Call :Winget Spotify.Spotify)
	if %%a EQU 43 (Call :Winget SoftDeluxe.FreeDownloadManager)
	if %%a EQU 44 (Call :Winget subhra74.XtremeDownloadManager)
	if %%a EQU 45 (Call :Winget AppWork.JDownloader)
	if %%a EQU 46 (Call :Winget qBittorrent.qBittorrent)
	if %%a EQU 47 (Call :Winget TheDocumentFoundation.LibreOffice)
	if %%a EQU 48 (Call :Winget ONLYOFFICE.DesktopEditors)
	if %%a EQU 49 (Call :Winget Adobe.Acrobat.Reader.64-bit)
	if %%a EQU 50 (Call :Winget TrackerSoftware.PDF-XChangeEditor)
	if %%a EQU 51 (Call :Winget calibre.calibre)
	if %%a EQU 52 (Call :Winget Notepad++.Notepad++)
	if %%a EQU 53 (Call :Winget Microsoft.VisualStudioCode)
	if %%a EQU 54 (Call :Winget GitHub.GitHubDesktop)
	if %%a EQU 55 (Call :Winget Git.Git)
	if %%a EQU 56 (Call :Winget OpenJS.NodeJS)
	if %%a EQU 57 (Call :Winget Unity.UnityHub)
	if %%a EQU 58 (Call :Winget BlenderFoundation.Blender)
	if %%a EQU 59 (Call :Winget TeamViewer.TeamViewer)
	if %%a EQU 60 (Call :Winget AnyDeskSoftwareGmbH.AnyDesk)
	if %%a EQU 61 (Call :Winget IObit.IObitUnlocker)
	if %%a EQU 62 (Call :Winget RevoUninstaller.RevoUninstaller)
	if %%a EQU 63 (Call :Winget 7zip.7zip
				   MD "%ProgramFiles%\7-Zip" > NUL 2>&1
				   Copy /y "%Konum%\Bin\Icon\7-zipp.ico" "%programfiles%\7-Zip" > NUL 2>&1
				   set AppRoad=%programfiles%\7-Zip\7zFM.exe
				   set AppIcon=%programfiles%\7-Zip\7-zipp.ico
				   set AppKey=7-Zip
				   set Default=001 7z apfs arj bz2 bzip2 cpio deb dmg esd fat gz gzip hfs lha lzh lzma ntfs rar rpm squashfs swm tar taz tbz tbz2 tgz tpz txz wim xar xz z zip
				   Call :Default_App)
	if %%a EQU 64 (Call :Winget Open-Shell.Open-Shell-Menu)
	if %%a EQU 65 (Call :Winget Henry++.MemReduct)
	if %%a EQU 66 (Call :Winget Guru3D.Afterburner)
	if %%a EQU 67 (Call :Winget voidtools.Everything)
	if %%a EQU 68 (Call :Winget LogMeIn.Hamachi)
	if %%a EQU 69 (Call :Winget GlassWire.GlassWire)
	if %%a EQU 70 (Call :Winget Safing.Portmaster)
	if %%a EQU 71 (Call :Winget Stremio.Stremio)
	if %%a EQU 72 (Call :Winget Flow-Launcher.Flow-Launcher)
	if %%a EQU 73 (Call :Winget Cloudflare.Warp)
)
goto Software_Installer

:: -------------------------------------------------------------
:AIO.Runtimes
cls&Call :Dil B 2 T0018&echo %R%[32m !LB2! %R%[0m
Dism /Online /Get-Capabilities /format:table > %Konum%\Log\Capabilities
Dism /Online /Get-Features /format:table > %Konum%\Log\Features
FOR /F "tokens=3" %%g in ('Findstr /C:"NetFX3~~~~" %Konum%\Log\Capabilities') do (
	echo %%g | Findstr /C:"Installed" > NUL 2>&1
		if !errorlevel! NEQ 0 (Call :Dil B 2 T0019&echo %R%[92m !LB2! %R%[0m
							   Dism /Online /Enable-Feature /Featurename:NetFx3 /All /NoRestart)
)
FOR /F "tokens=3" %%g in ('findstr /C:"IIS-ASPNET45" %Konum%\Log\Features') do (
	echo %%g | Findstr /C:"Enabled" > NUL 2>&1
		if !errorlevel! NEQ 0 (Call :Dil B 2 T0020&echo %R%[92m !LB2! %R%[0m
							   Dism /Online /Enable-Feature /FeatureName:IIS-ASPNET45 /All /NoRestart)
)
FOR /F "tokens=3" %%g in ('findstr /C:"DirectPlay" %Konum%\Log\Features') do (
	echo %%g | Findstr /C:"Enabled" > NUL 2>&1
		if !errorlevel! NEQ 0 (Call :Dil B 2 T0021&echo %R%[92m !LB2! %R%[0m
							   Dism /Online /Enable-Feature /FeatureName:DirectPlay /All /NoRestart)
)
FOR %%g in (
Microsoft.VCRedist.2005.x86
Microsoft.VCRedist.2005.x64
Microsoft.VCRedist.2008.x86
Microsoft.VCRedist.2008.x64
Microsoft.VCRedist.2010.x86
Microsoft.VCRedist.2010.x64
Microsoft.VCRedist.2012.x86
Microsoft.VCRedist.2012.x64
Microsoft.VCRedist.2013.x86
Microsoft.VCRedist.2013.x64
Microsoft.VCRedist.2015+.x86
Microsoft.VCRedist.2015+.x64
Oracle.JavaRuntimeEnvironment
Microsoft.XNARedist
OpenAL.OpenAL
Microsoft.DotNet.DesktopRuntime.6
Microsoft.DotNet.DesktopRuntime.7
Microsoft.DirectX
) do (
	cls&Call :Dil B 2 T0018&echo %R%[32m !LB2! %R%[0m&Call :Winget %%g
)
FOR %%g in (Capabilities Features) do (Call :DEL %Konum%\Log\%%g)
goto :eof

:: -------------------------------------------------------------
:Service_Menu
mode con cols=130 lines=36
echo.
Call :Dil A 2 B0001
Call :Dil B 2 T0004
Call :Dil B 3 T0004
Call :Dil C 2 T0005
echo %R%[91m  ► !LA2! %R%[90m [ E: !LB2! │ D: !LB3! │ !LC2!: E,1,4,5,D,6,10,14 ]%R%[0m
FOR %%a in (LA2 LB2 LB3 LC2) do (set %%a=)
echo   %R%[90m┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐%R%[0m
FOR /L %%a in (1,1,28) do (
	Call :Dil A 2 SL_%%a_
	Call :Dil A 3 SL_%%a_
	Call :Service_Check %%a
	if %%a LSS 10 (echo  %R%[32m    %%a%R%[90m-%R%[0m !Check!%R%[33m !LA2!%R%[90m !LA3! %R%[0m)
	if %%a GEQ 10 (echo  %R%[32m   %%a%R%[90m-%R%[0m !Check!%R%[33m !LA2!%R%[90m !LA3! %R%[0m)
)
Call :Dil A 2 T0006&echo  %R%[32m    X%R%[90m-%R%[37m   !LA2!%R%[0m
FOR %%a in (LA2 LA3) do (set %%a=)
echo   %R%[90m└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘%R%[0m
Call :Dil A 2 D0002&set /p Value_S=%R%[92m   !LA2!: %R%[0m
Call :Upper "%Value_S%" Value_S 
echo !Value_S! | Findstr /i "X" > NUL 2>&1
	if !errorlevel! EQU 0 (set Error=X&goto Main_Menu)
cls
FOR %%a in (!Value_S!) do (
	Call :Service_Management %%a
	if %%a EQU 16 (Call :Reg01)
	if %%a EQU 16 (Call :Reg01)
)
goto Service_Menu

:: -------------------------------------------------------------
:Features_Warning
mode con cols=130 lines=38
Call :Dil A 2 T0025
Call :Dil B 2 T0026
Call :Dil C 2 T0028
Call :Dil D 2 Error_0_
Call :Dil E 2 T0027
echo.&echo %R%[91m !LD2! %R%[0m
echo.&echo %R%[33m !LA2! %R%[0m
echo %R%[33m !LB2! %R%[0m
echo %R%[33m !LE2! %R%[0m
echo.&echo %R%[32m !LC2! %R%[0m
FOR %%a in (LA2 LB2 LC2 LD2 LE2) do (set %%a=)
pause > NUL
:Features_Menu
mode con cols=130 lines=55
FOR %%g in (C_Packages C_Capabilities) do (Call :DEL "%Konum%\Log\%%g")
DISM /Online /Get-Capabilities /format:table | Findstr /i "Installed" > %Konum%\Log\C_Capabilities
FOR /F "tokens=4" %%g in ('Dism /Online /Get-Packages ^| Findstr /i "Package Identity"') do echo %%g >> %Konum%\Log\C_Packages
Call :Dil A 2 B0002
Call :Dil B 2 T0007
Call :Dil C 2 T0005
echo.
echo %R%[91m  ► !LA2! %R%[90m [ !LB2! │ !LC2!: 1,4,5,6,10,14 ]%R%[0m
echo   %R%[90m┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐%R%[0m
FOR /L %%a in (1,1,45) do (
	Call :Dil A 2 SR_%%a_
	Call :Dil A 3 SR_%%a_
	Call :Read_Features COM_%%a_
	Call :Check_!Value_C! COM_%%a_
	if %%a LSS 10 (echo  %R%[36m    %%a%R%[90m-%R%[0m !Check!%R%[33m !LA2!%R%[90m !LA3! %R%[0m)
	if %%a GEQ 10 (echo  %R%[36m   %%a%R%[90m-%R%[0m !Check!%R%[33m !LA2!%R%[90m !LA3! %R%[0m)
)
Call :Dil A 2 T0006&echo  %R%[36m    X%R%[90m-%R%[37m   !LA2!%R%[0m
echo   %R%[90m└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘%R%[0m
Call :Dil A 2 D0002&set /p Value_S=%R%[92m   !LA2!: %R%[0m
Call :Upper "%Value_S%" Value_S 
echo !Value_S! | Findstr /i "X" > NUL 2>&1
	if !errorlevel! EQU 0 (set Error=X&goto Main_Menu)
cls
set Check=NT
Call :Dil B 2 T0008
FOR %%a in (!Value_S!) do (
	Call :Dil A 2 SR_%%a_
	Call :Read_Features COM_%%a_
	echo ►%R%[32m "!LA2!" %R%[37m !LB2! %R%[0m  
	Call :Remove_!Value_C! "COM_%%a_"
	if %%a EQU 12 (Call :Schtasks-Remove "\Microsoft\Windows\SystemRestore\SR")
)
goto Features_Menu

:: -------------------------------------------------------------
:Oto_Kapat
shutdown -s -f -t 999999 > NUL 2>&1
	if !errorlevel! EQU 1190 (
		Call :Dil A 2 D0003
		Call :Dil A 3 D0003
		set /p Value_M=%R%[36m        !LA2! %R%[90m'%R%[33mD%R%[90m'%R%[36m !LA3! %R%[90m'%R%[33mX%R%[90m': %R%[0m
		Call :Upper !Value_M! Value_M
			if !Value_M! EQU X (set Error=X)
			if !Value_M! EQU D (shutdown /a > NUL 2>&1)
	) else (
		shutdown /a > NUL 2>&1
		Call :Dil A 2 D0004&set /p Value_M=%R%[36m        !LA2!: %R%[0m
		Call :Upper !Value_M! Value_M
			if !Value_M! EQU X (goto Main_Menu)
		set /a Value_N=!Value_M!*60
		shutdown -s -f -t !Value_N!
)
goto Main_Menu

:: -------------------------------------------------------------
:Ping_Metre
mode con cols=100 lines=30
Call :Dil A 2 B0003&echo.&echo %R%[91m ► !LA2! %R%[0m
echo.
Call :Ping_M1 www.youtube.com&echo  %R%[90m•%R%[33m    Youtube %R%[90m=%R%[37m !Value_M1! %R%[90mMS%R%[0m
Call :Ping_M1 www.facebook.com&echo  %R%[90m•%R%[33m   Facebook %R%[90m=%R%[37m !Value_M1! %R%[90mMS%R%[0m
Call :Ping_M1 www.twitter.com&echo  %R%[90m•%R%[33m    Twitter %R%[90m=%R%[37m !Value_M1! %R%[90mMS%R%[0m
Call :Ping_M1 www.instagram.com&echo  %R%[90m•%R%[33m  Instagram %R%[90m=%R%[37m !Value_M1! %R%[90mMS%R%[0m
Call :Ping_M1 www.reddit.com&echo  %R%[90m•%R%[33m     Reddit %R%[90m=%R%[37m !Value_M1! %R%[90mMS%R%[0m
Call :Ping_M1 www.twitch.tv&echo  %R%[90m•%R%[33m     Twitch %R%[90m=%R%[37m !Value_M1! %R%[90mMS%R%[0m
echo %R%[36m ► DNS%R%[0m 
Call :Ping_M1 1.1.1.1
Call :Ping_M2 1.0.0.1
echo  %R%[90m•%R%[33m     Claudflare %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS%R%[0m
Call :Ping_M1 8.8.8.8
Call :Ping_M2 8.8.4.4
echo  %R%[90m•%R%[33m         Google %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS%R%[0m
Call :Ping_M1 9.9.9.9
Call :Ping_M2 149.112.112.112
echo  %R%[90m•%R%[33m          Quad9 %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS%R%[0m
Call :Ping_M1 208.67.222.222
Call :Ping_M2 208.67.220.220
echo  %R%[90m•%R%[33m        OpenDNS %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS%R%[0m
Call :Ping_M1 156.154.70.2
Call :Ping_M2 156.154.71.2
echo  %R%[90m•%R%[33m UltraRecursive %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS%R%[0m
Call :Ping_M1 94.140.14.14
Call :Ping_M2 94.140.15.15
echo  %R%[90m•%R%[33m        Adguard %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS%R%[0m
Call :Dil A 2 T0006&echo.&echo  %R%[32m X%R%[90m-%R%[37m !LA2! %R%[0m
Call :Dil A 2 T0009&echo  %R%[90m !LA2! %R%[0m
Call :Dil A 2 D0001&echo.&set /p Value_M=%R%[92m ► !LA2!= %R%[0m
FOR %%a in (x X) do (
	if %Value_M% EQU %%a (set Error=X&goto Main_Menu)
)
Call :Ping_M1 %Value_M%&echo.&echo  %R%[90m•%R%[33m %Value_M% %R%[90m=%R%[37m !Value_M1! %R%[90mMS%R%[0m
Call :Dil A 2 T0028&echo.&echo  %R%[32m !LA2! %R%[0m
FOR /L %%a in (1,1,2) do (set Value_M%%a=)
pause > NUL
goto Main_Menu

:: -------------------------------------------------------------
:User_Licence_Manager
mode con cols=100 lines=27
FOR /L %%a in (1,1,13) do (
	if %%a EQU 1 (Call :Dil A 2 SBB_1_&echo.&echo  %R%[96m► !LA2! %R%[0m)
	if %%a EQU 8 (Call :Dil A 2 SBB_2_&echo.&echo  %R%[96m► !LA2! %R%[0m)
	Call :Dil A 2 SB_%%a_
	if %%a LSS 10 (echo   %R%[32m  %%a %R%[90m-%R%[33m !LA2! %R%[0m)
	if %%a GEQ 10 (echo   %R%[32m %%a %R%[90m-%R%[33m !LA2! %R%[0m)
)
Call :Dil A 2 T0006&echo   %R%[32m  X %R%[90m-%R%[37m !LA2! %R%[0m
Call :Dil A 2 D0001&echo.&set /p Value_M=%R%[92m► !LA2!= %R%[0m
Call :Upper !Value_M! Value_M
	if %Value_M% EQU 1 (net user administrator /active:yes)
	if %Value_M% EQU 2 (net user Administrator /active:no)
	if %Value_M% EQU 3 (Call :Dil A 2 D0005&set /p Value=%R%[36m► !LA2!= %R%[0m&net localgroup Administrators "!Value!" /add)
	if %Value_M% EQU 4 (Call :Dil A 2 D0005&set /p Value=%R%[36m► !LA2!= %R%[0m&net user "!Value!" * /add)
	if %Value_M% EQU 5 (Call :Dil A 2 D0005&set /p Value=%R%[36m► !LA2!= %R%[0m&net user "!Value!" /delete)
	if %Value_M% EQU 6 (Call :Dil A 2 D0005&set /p Value=%R%[36m► !LA2!= %R%[0m&net user "!Value!" *)
	if %Value_M% EQU 7 (start cmd /k Powershell -C "Get-LocalUser"&goto User_Licence_Manager)
	if %Value_M% EQU 8 (Call :Dil A 2 D0006&set /p Value=%R%[36m► !LA2!= %R%[0m&slmgr /ipk "!Value!")
	if %Value_M% EQU 9 (slmgr /dli)
	if %Value_M% EQU 10 (slmgr /dlv)
	if %Value_M% EQU 11 (slmgr /xpr)
	if %Value_M% EQU 12 (slmgr /upk)
	if %Value_M% EQU 13 (slmgr /rearm)
	if %Value_M% EQU X (set Error=X&goto Main_Menu)
Call :ProcessCompleted
goto User_Licence_Manager

:: -------------------------------------------------------------
:Wifi_Info
mode con cols=65 lines=45
Call :Dil A 2 B0005&echo.&echo %R%[91m !LA2! %R%[90m│ Archley %R%[0m
netsh wlan show profil ^| find "All" > NUL 2>&1
	if !errorlevel! NEQ 0 (Call :Dil A 2 T0029&echo.&echo %R%[92m !LA2! %R%[0m&set Error=X&Call :Bekle 5&goto Main_Menu)
echo  %R%[90m┌─────────────────────────────────────────────────────────────┐%R%[0m
FOR /F "tokens=5" %%a in ('netsh wlan show profil ^| find "All"') do (
	FOR /F "tokens=4" %%b in ('netsh wlan show profile "%%a" key^=clear ^| find "Content"') do (
		echo   ► %R%[36m%%a :%R%[33m %%b%R%[0m
		echo.
		)
	)
)
echo  %R%[90m└─────────────────────────────────────────────────────────────┘%R%[0m
Call :Dil A 2 T0028&echo %R%[92m !LA2! %R%[0m
pause > NUL
goto Main_Menu

:: -------------------------------------------------------------
:Cleaner
cls
if %Error% EQU X (Call :Dil A 2 B0006&echo.&echo %R%[91m !LA2! %R%[0m
				  Call :Dil B 2 T0030&echo.&echo %R%[32m !LB2! %R%[0m
)
ie4uinit.exe -show
ie4uinit.exe -ClearIconCache
taskkill /f /im explorer.exe > NUL 2>&1
Call :DEL "%LocalAppData%\IconCache.db"
Call :DEL "%LocalAppData%\Microsoft\Windows\Explorer\*"
Call :DEL "%LocalAppData%\Microsoft\Windows\Explorer\IconCacheToDelete\*"
Call :DEL "%LocalAppData%\Microsoft\Windows\Explorer\NotifyIcon\*"
Call :DEL "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
Call :RD "%LocalAppData%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\AppIconCache"
MD "%LocalAppData%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\AppIconCache" > NUL 2>&1
Call :DEL "%LocalAppData%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\TempState\*"
Call :RegDel "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams
Call :RegDel "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream
Call :Powershell "Start-Process '%Windir%\explorer.exe'"
::
Call :DEL "%temp%\*"
Call :FA RD "%temp%\*"
Call :DEL "%Windir%\Temp\*"
Call :FA RD "%Windir%\Temp\*"
Call :DEL "%LocalAppData%\Temp\*"
Call :FA RD "%LocalAppData%\Temp\*"
Call :FA RD "%Windir%\System32\config\systemprofile\AppData\Local\*.tmp"
Call :FA DELS "%systemdrive%\*log"
Call :FA DELS "%Windir%\*etl"
Call :FA DELS "%LocalAppData%\*etl"
Call :FA DEL "%Windir%\Installer\*"
Call :FA RD "%Windir%\Installer\*"
Call :FA RD "%Windir%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*"
Call :DEL "%Windir%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*"
Call :DEL "%windir%\prefetch\*"
:: Clear recently accessed files
Call :DEL "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*"
:: Clear user pins
Call :DEL "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*"
:: Clear main telemetry file
Call :DEL "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\*.etl"
::
Call :DEL "%SystemRoot%\DtcInstall.log"
Call :DEL "%SystemRoot%\comsetup.log"
Call :DEL "%SystemRoot%\PFRO.log"
Call :DEL "%SystemRoot%\setupact.log"
Call :DEL "%SystemRoot%\setupapi.log"
Call :DEL "%SystemRoot%\Panther\*"
Call :DEL "%SystemRoot%\inf\setupapi.app.log"
Call :DEL "%SystemRoot%\inf\setupapi.dev.log"
Call :DEL "%SystemRoot%\inf\setupapi.offline.log"
Call :DEL "%SystemRoot%\Performance\WinSAT\winsat.log"
Call :DEL "%SystemRoot%\debug\PASSWD.LOG"
Call :DEL "%localappdata%\Microsoft\Windows\WebCache\*.*"
Call :DEL "%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp\*.*"
Call :DEL "%SystemRoot%\Logs\CBS\CBS.log"
Call :DEL "%SystemRoot%\Logs\DISM\DISM.log"
Call :DEL "%SystemRoot%\Logs\SIH\*"
Call :DEL "%LocalAppData%\Microsoft\CLR_v4.0\UsageTraces\*"
Call :DEL "%LocalAppData%\Microsoft\CLR_v4.0_32\UsageTraces\*"
Call :DEL "%SystemRoot%\Logs\NetSetup\*"
Call :DEL "%SystemRoot%\System32\LogFiles\setupcln\*"
Call :DEL "%SystemRoot%\Temp\CBS\*"
Call :DEL "%SystemRoot%\System32\catroot2\dberr.txt"
Call :DEL "%SystemRoot%\System32\catroot2.log"
Call :DEL "%SystemRoot%\System32\catroot2.jrs"
Call :DEL "%SystemRoot%\System32\catroot2.edb"
Call :DEL "%SystemRoot%\System32\catroot2.chk"
Call :DEL "%SystemRoot%\Logs\SIH\*"
Call :DEL "%SystemRoot%\Traces\WindowsUpdate\*"
Call :RD "%SystemRoot%\Logs\waasmedic"
::
Call :RD "%systemdrive%\AMD"
Call :RD "%systemdrive%\NVIDIA"
Call :RD "%systemdrive%\INTEL"
::
Call :NET stop wuauserv
Call :RD "%windir%\SoftwareDistribution"
Call :NET start wuauserv
::
Dism /Online /Cleanup-Image /StartComponentCleanup
::
Call :Powershell "Start-Process cleanmgr -ArgumentList '/verylowdisk /sagerun:5'"
::
chcp 437 > NUL
PowerShell -ExecutionPolicy Unrestricted -Command "$bin = (New-Object -ComObject Shell.Application).NameSpace(10); $bin.items() | ForEach {; Write-Host "^""Deleting $($_.Name) from Recycle Bin"^""; Remove-Item $_.Path -Recurse -Force; }"
chcp 65001 > NUL
::
ipconfig /flushdns > NUL 2>&1
ipconfig /release > NUL 2>&1
ipconfig /renew > NUL 2>&1
::
FOR /F "tokens=*" %%g in ('wevtutil.exe el') do (wevtutil.exe cl "%%g" > NUL 2>&1)
::
goto :eof

:: -------------------------------------------------------------
:Windows_Repair
cls&set Error=X&Call :Cleaner&cls
Call :Dil A 2 B0007&echo.&echo %R%[91m !LA2! %R%[0m
Call :Dil A 2 T0031&echo.&echo %R%[32m !LA2! %R%[0m
sfc /scannow
Call :Dil A 2 T0032&echo.&echo %R%[32m !LA2! %R%[0m
Dism /Online /Cleanup-Image /StartComponentCleanup 
Call :Dil A 2 T0033&echo.&echo %R%[32m !LA2! %R%[0m
DISM /Online /Cleanup-Image /RestoreHealth
cls
Call :Dil A 2 B0007&echo.&echo %R%[91m !LA2! %R%[0m
Call :Dil A 2 T0034&echo.&echo %R%[32m !LA2! %R%[0m
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "RemoveWindowsStore" REG_DWORD "0"
:: BITS hizmeti varsayılan hale getiriliyor.
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode"
FOR %%a in (AppXSvc camsvc wuauserv StorSvc LicenseManager trustedinstaller ClipSVC UserDataSvc UnistoreSvc InstallService PushToInstall TimeBrokerSvc TokenBroker) do (
	Call :SC %%a demand
	Call :NET start %%a
)
FOR %%a in (cryptsvc bits OneSyncSvc UsoSvc DoSvc) do (
	Call :SC %%a auto
	Call :NET start %%a
)
FOR %%a in (WFDSConMgrSvc DevicesFlowUserSvc DevicePickerUserSvc ConsentUxUserSvc) do (
	Call :SC %%a demand
	Call :NET start %%a
)
FOR %%a in (softpub.dll wintrust.dll initpki.dll dssenh.dll rsaenh.dll gpkcsp.dll sccbase.dll slbcsp.dll mssip32.dll cryptdlg.dll
			msxml3.dll comcat.dll Msxml.dll Msxml2.dll mshtml.dll shdocvw.dll browseui.dll msjava.dll shdoc401.dll cdm.dll gpkcsp.dll
			sccbase.dll asctrls.ocx wintrust.dll initpki.dll softpub.dll oleaut32.dll Shell32.dll browseui.dll msrating.dll mlang.dll
			hlink.dll mshtmled.dll urlmon.dll plugin.ocx sendmail.dll scrobj.dll mmefxe.ocx corpol.dll jscript.dll imgutil.dll thumbvw.dll
			cryptext.dll rsabase.dll inseng.dll actxprxy.dll dispex.dll occache.dll iepeers.dll cdfview.dll webcheck.dll mobsync.dll pngfilt.dll
			licmgr10.dll icmfilter.dll hhctrl.ocx inetcfg.dll tdc.ocx MSR2C.DLL msident.dll msieftp.dll xmsconf.ocx ils.dll msoeacct.dll inetcomm.dll
			msdxm.ocx dxmasf.dll l3codecx.ax acelpdec.ax mpg4ds32.ax voxmsdec.ax danim.dll Daxctle.ocx lmrt.dll datime.dll dxtrans.dll dxtmsft.dll
			WEBPOST.DLL WPWIZDLL.DLL POSTWPP.DLL CRSWPP.DLL FTPWPP.DLL FPWPP.DLL WUAPI.DLL wups2.dll WUAUENG.DLL ATL.DLL WUCLTUI.DLL WUPS.DLL
			WUWEB.DLL wshom.ocx wshext.dll vbscript.dll scrrun.dll) do (regsvr32 %%a /s)	
FOR %%a in (shdoc401.dll shdocvw.dll browseui.dll urlmon.dll iesetup.dll occache.dll) do (regsvr32 %%a /i /s)
regsvr32 mstinit.exe /setup
regsvr32 msnsspc.dll /SspcCreateSspiReg
regsvr32 msapsspc.dll /SspcCreateSspiReg /s
wsreset
Call :CurrentUserName
:: Görev çubuğunda ekran tepsisi simgelerini açar
Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoTrayItemsDisplay"
Call :RegDel "HKU\!CUS!\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoTrayItemsDisplay"
:: CMD-Powershell sürekli yönetici çalışma sorununu giderir
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "EnableLUA" REG_DWORD 1
set Error=NT
goto :eof

:: ██████████████████████████████████████████████████████████████████
:___HANGAR___
:Dil
:: Dil verilerini buradan alıyorum. Call komutu ile buraya uygun değerleri gönderiyorum.
:: %~1= Harf │ %~2= tokens değeri │ %~3= Find değeri
set L%~1%~2=
FOR /F "delims=> tokens=%~2" %%z in ('Findstr /i "%~3" %Dil%') do (set L%~1%~2=%%z)
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Date
:: Tarih bilgisi için
FOR /F "tokens=2" %%g in ('echo %date%') do set Date=%%g
set DateYear=%Date:~6%-%Date:~3,-5%-%Date:~0,-8%
set DateDay=%Date:~0,-8%.%Date:~3,-5%.%Date:~6%
goto :eof

:: -------------------------------------------------------------
:Time
:: Saat bilgisi için
FOR /F "tokens=1" %%g in ('echo %time%') do set Time=%%g
goto :eof

:: -------------------------------------------------------------
:Bekle
:: Timeout beklemeleri için
timeout /t %~1 /nobreak > NUL
goto :eof

:: -------------------------------------------------------------
:CurrentUserName
Call :Powershell "Get-CimInstance -ClassName Win32_UserAccount | Select-Object -Property Name,SID" > %Konum%\Log\cusername
FOR /F "tokens=2" %%a in ('Find "%username%" %Konum%\Log\cusername') do set CUS=%%a
Call :Del "%Konum%\Log\cusername"
goto :eof

:: -------------------------------------------------------------
:Winget
winget install -e --silent --force --accept-source-agreements --accept-package-agreements --uninstall-previous --id %~1
	if !errorlevel! NEQ 0 (cls&"%Konum%\Bin\NSudo.exe" -U:C -Wait cmd /c winget install -e --silent --force --accept-source-agreements --accept-package-agreements --uninstall-previous --id %~1)
goto :eof

:: -------------------------------------------------------------
:RD
:: Klasör silmek için
RD /S /Q "%~1" > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% RD /S /Q "%~1")
goto :eof

:: -------------------------------------------------------------
:DEL
:: Dosya silmek için
DEL /F /Q /A "%~1" > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% DEL /F /Q /A "%~1")
goto :eof

:: -------------------------------------------------------------
:FA
:: %~1: İşlem yapılacak konum  %~2: Aranacak değer
if %~1 EQU RD (FOR /F "tokens=*" %%g in ('Dir /AD /B "%~2" 2^>NUL') do (Call :RD "%~dp2%%g"))
if %~1 EQU DEL (FOR /F "tokens=*" %%g in ('Dir /A-D /B "%~2" 2^>NUL') do (Call :DEL "%~dp2%%g"))
if %~1 EQU RDS (FOR /F "tokens=*" %%g in ('Dir /AD /B /S "%~2" 2^>NUL') do (Call :RD "%%g"))
if %~1 EQU DELS (FOR /F "tokens=*" %%g in ('Dir /A-D /B /S "%~2" 2^>NUL') do (Call :DEL "%%g"))
goto :eof

:: -------------------------------------------------------------
:Powershell
:: chcp 65001 kullanıldığında Powershell komutları ekranı kompakt görünüme sokuyor. Bunu önlemek için bu bölümde uygun geçişi sağlıyorum.
chcp 437 > NUL 2>&1
Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C %*
chcp 65001 > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Upper
:: Bu bölüme yönlendirdiğim kelimeleri büyük harf yaptırıyorum.
chcp 437 > NUL 2>&1
FOR /F %%g in ('Powershell -command "'%~1'.ToUpper()"') do (set %~2=%%g)
chcp 65001 > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Link
set Link=
FOR /F "delims=> tokens=2" %%z in ('Findstr /i "Link_%~1_" %Konum%\Bin\Extra\Link.txt 2^>NUL') do (set Link=%%z)
goto :eof

:: -------------------------------------------------------------
:PSDownload
:: %~1= İndirme konumu
Call :Powershell "& { iwr %Link% -OutFile %~1 }"
goto :eof

:: -------------------------------------------------------------
:SC
:: %~1: Hizmet %~2: Hizmet çalışma değeri
sc config %~1 start= %~2 > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% sc config %~1 start= %~2)
goto :eof

:: -------------------------------------------------------------
:NET
:: %~1: start │ stop  %~2: Hizmet
net %~1 %~2 /y > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% net %~1 %~2 /y)
goto :eof

:: -------------------------------------------------------------
:Sahip
takeown /f "%~1" > NUL 2>&1
icacls "%~1" /grant administrators:F > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Uzunluk
:: %~1: Değişken değeri  %~2: Uzunluğu hesaplanacak olan değer
chcp 437 > NUL
FOR /F "tokens=*" %%a in ('Powershell -C "'%~2'.Length"') do (set Uzunluk%~1=%%a)
chcp 65001 > NUL
goto :eof

:: -------------------------------------------------------------
:Schtasks-Remove
schtasks /Delete /TN "%~1" /F > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% schtasks /Delete /TN "%~1" /F)
goto :eof

:: -------------------------------------------------------------
:Check_Internet
set Internet=Offline
FOR %%a in (
1.1.1.1
8.8.8.8
www.google.com
www.bing.com
www.msn.com
) do (
	ping -n 1 %%a -w 1000 > NUL
		if !errorlevel! EQU 0 (set Internet=Online)
)
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Default_App
:: %~1: Uzantılar
FOR %%g in (!Default!) do (
	reg delete "HKCR\.%%g" /f > NUL 2>&1
	reg delete "HKCR\%AppKey%.%%g" /f > NUL 2>&1
	reg add "HKCR\.%%g" /f /ve /t REG_SZ /d "%AppKey%.%%g" > NUL 2>&1
	reg add "HKCR\%AppKey%.%%g\DefaultIcon" /f /ve /t REG_SZ /d "%AppIcon%" > NUL 2>&1
	reg add "HKCR\%AppKey%.%%g\shell\open\command" /f /ve /t REG_SZ /d "\"%AppRoad%\" \"%%1\"" > NUL 2>&1
)
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Ping_M1
FOR /F "tokens=9" %%b in ('ping -n 1 %~1') do (set Value_M1=%%b)
set Value_M1=!Value_M1:~0,-2!
goto :eof

:: -------------------------------------------------------------
:Ping_M2
FOR /F "tokens=9" %%b in ('ping -n 1 %~1') do (set Value_M2=%%b)
set Value_M2=!Value_M2:~0,-2!
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Service_Check
:: Hizmetleri kontrol eder
set X=NT
if %Win% EQU 11 (set Value_W=0 11)
if %Win% EQU 10 (set Value_W=0 10)
FOR %%j in (!Value_W!) do (
	FOR /F "delims=> tokens=2" %%g in ('Findstr /i "_%%j_%~1_" %Konum%\Bin\Extra\Data.cmd') do (
		set Check=%R%[91m█%R%[0m
		reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%g" /v "Start" > NUL 2>&1
			if !errorlevel! EQU 0 (FOR /F "skip=1 delims=x tokens=2" %%j in ('reg query "HKLM\System\CurrentControlSet\Services\%%g" /v "Start" 2^>NUL') do (
																				if %%j EQU 4 (if !X! NEQ ON (set Check=%R%[90m█%R%[0m))
																				if %%j EQU 3 (set X=ON&set Check=%R%[92m♦%R%[0m)
																				if %%j EQU 2 (set X=ON&set Check=%R%[92m♦%R%[0m)
																				if %%j EQU 1 (set X=ON&set Check=%R%[92m♦%R%[0m)
																				if %%j EQU 0 (set X=ON&set Check=%R%[92m♦%R%[0m)
			)
		)
	)
)
goto :eof
:: ► Regedit çalışma değerleri 
::	• 0 = Ön yükleme (Boot)
::	• 1 = Sistem (System)
::	• 2 = Otomatik (Auto)
::	• 3 = Manuel (Demand)
::	• 4 = Devre dışı (Disable)

:: -------------------------------------------------------------
:Service_Management
if %Win% EQU 11 (set Value_W=0 11)
if %Win% EQU 10 (set Value_W=0 10)
if %~1 EQU E (set Value=E&Call :Dil B 2 T0001&goto :eof)
if %~1 EQU D (set Value=D&Call :Dil B 2 T0002&goto :eof)
Call :Dil A 2 SL_%~1_
echo %R%[96m "!LA2!" %R%[37m !LB2! %R%[0m
FOR %%j in (!Value_W!) do (
	FOR /F "delims=> tokens=2" %%g in ('Findstr /i "_%%j_%~1_" %Konum%\Bin\Extra\Data.cmd') do (
		FOR /F "delims=> tokens=5" %%k in ('Findstr /i "_%%j_%~1_" %Konum%\Bin\Extra\Data.cmd') do (
			reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%g" /v "Start" > NUL 2>&1
				if !errorlevel! EQU 0 (if !Value! EQU E (Call :SC %%g %%k
														 Call :NET start %%g)
									   if !Value! EQU D (Call :SC %%g disabled
														 Call :NET stop %%g)
			)
		)
	)
)	
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Read_Features
FOR /F "delims=> tokens=3" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (set Value_C=%%g)
goto :eof

:: -------------------------------------------------------------
:Check_Capability
set Check=%R%[90m█%R%[0m
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	Findstr /i "%%g" %Konum%\Log\C_Capabilities > NUL 2>&1
		if !errorlevel! EQU 0 (set Check=%R%[92m♦%R%[0m)
)
goto :eof

:: -------------------------------------------------------------
:Check_Package
set Check=%R%[90m█%R%[0m
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	Findstr /i "%%g" %Konum%\Log\C_Packages > NUL 2>&1
		if !errorlevel! EQU 0 (set Check=%R%[92m♦%R%[0m)
)
goto :eof

:: -------------------------------------------------------------
:Check_Component
set Check=%R%[90m█%R%[0m
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /f "%%g" > NUL 2>&1
		if !errorlevel! EQU 0 (set Check=%R%[92m♦%R%[0m)
)
goto :eof

:: -------------------------------------------------------------
:Remove_Component
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	FOR /F "tokens=8 delims='\'" %%k in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /f "%%g" 2^>NUL') do (
		Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%%k" "Visibility" REG_DWORD 1
		Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%%k" "DefVis" REG_DWORD 2
		Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%%k\Owners"
	)
)
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	FOR /F "tokens=8 delims='\'" %%k in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /f "%%g" 2^>NUL') do (
		reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /f "%%k" > NUL 2>&1
			if !errorlevel! EQU 0 (Dism /Online /Remove-Package /PackageName:%%k /NoRestart /Quiet)
	)
)
goto :eof

:: -------------------------------------------------------------
:Remove_Capability
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	Findstr /i "%%g" %Konum%\Log\C_Capabilities > NUL 2>&1
		if !errorlevel! EQU 0 (FOR /F "tokens=1" %%k in ('Findstr /i "%%g" %Konum%\Log\C_Capabilities') do (Dism /Online /Remove-Capability /CapabilityName:%%k /NoRestart /Quiet))													
)
goto :eof

:: -------------------------------------------------------------
:Remove_Package
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	Findstr /i "%%g" %Konum%\Log\C_Packages > NUL 2>&1
		if !errorlevel! EQU 0 (FOR /F "tokens=1" %%k in ('Findstr /i "%%g" %Konum%\Log\C_Packages') do (Dism /Online /Remove-Package /PackageName:%%k /NoRestart /Quiet))
)
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Ram_Type
if %~1 EQU 0 (set Value_R=Unkown)
if %~1 EQU 1 (set Value_R=Other)
if %~1 EQU 2 (set Value_R=DRAM)
if %~1 EQU 3 (set Value_R=Senkron Ram)
if %~1 EQU 4 (set Value_R=Cache Ram)
if %~1 EQU 5 (set Value_R=EDO)
if %~1 EQU 6 (set Value_R=EDRAM)
if %~1 EQU 7 (set Value_R=VRAM)
if %~1 EQU 8 (set Value_R=SRAM)
if %~1 EQU 9 (set Value_R=RAM)
if %~1 EQU 10 (set Value_R=ROM)
if %~1 EQU 11 (set Value_R=Flash)
if %~1 EQU 12 (set Value_R=EEPROM)
if %~1 EQU 13 (set Value_R=FEPR0M)
if %~1 EQU 14 (set Value_R=EPROM)
if %~1 EQU 15 (set Value_R=CDRAM)
if %~1 EQU 16 (set Value_R=3DRAM)
if %~1 EQU 17 (set Value_R=SDRAM)
if %~1 EQU 18 (set Value_R=SGRAM)
if %~1 EQU 19 (set Value_R=RDRAM)
if %~1 EQU 20 (set Value_R=DDR)
if %~1 EQU 21 (set Value_R=DDR2)
if %~1 EQU 22 (set Value_R=DDR2 FB-DIMM)
if %~1 EQU 24 (set Value_R=DDR3)
if %~1 EQU 25 (set Value_R=FBD2)
if %~1 EQU 26 (set Value_R=DDR4)
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:RegKey
Reg add "%~1" /f > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /f)
goto :eof
::
:RegAdd
Reg add "%~1" /v "%~2" /t "%~3" /d "%~4" /f > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /v "%~2" /t "%~3" /d "%~4" /f)
goto :eof
::
:RegVeAdd
Reg add "%~1" /ve /t "%~2" /d "%~3" /f > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /ve /t "%~2" /d "%~3" /f)
goto :eof
::
:RegDel
Reg delete %* /f > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg delete %* /f)
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:ProcessCompleted
mode con cols=39 lines=12
echo.
echo            %R%[90m┌───────────────┐%R%[0m
echo            %R%[90m│%R%[32m               %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m          ██   %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m         ██    %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m   ██   ██     %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m    ██ ██      %R%[90m│%R%[0m
echo            %R%[90m│%R%[32m     ███       %R%[90m│%R%[0m
echo            %R%[90m│               %R%[90m│%R%[0m
echo            %R%[90m└───────────────┘%R%[0m
echo.
Call :Bekle 2
goto :eof

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Ogni_Label
echo. 
echo.
echo.
echo.
echo.
echo                       %R%[33m████ ████ █   █ ███ █████ ████ ████ ███ █   █ █  █ ████%R%[0m
echo                       %R%[33m█  █ █    ██  █  █    █   █  █ █  █ █   ██  █ █ █  █   %R%[0m
echo                       %R%[33m█  █ █ ██ █ █ █  █    █   █  █ ████ ██  █ █ █ ██   ████%R%[0m
echo                       %R%[33m█  █ █  █ █  ██  █    █   █  █ █ █  █   █  ██ █ █     █%R%[0m
echo                       %R%[33m████ ████ █   █ ███   █   ████ █  █ ███ █   █ █  █ ████%R%[0m
echo.
echo                                %R%[37m█████ ████ ████ █   ███  ████ █   █%R%[0m
echo                                %R%[37m  █   █  █ █  █ █   █  █ █  █  █ █ %R%[0m
echo                                %R%[37m  █   █  █ █  █ █   ███  █  █   █  %R%[0m
echo                                %R%[37m  █   █  █ █  █ █   █  █ █  █  █ █ %R%[0m
echo                                %R%[37m  █   ████ ████ ███ ███  ████ █   █%R%[0m
goto :eof
:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Language_Select
cls
Call :DEL %Konum%\Log\Dil
Call :Dil A 2 B0009&echo.&echo %R%[91m !LA2! %R%[0m&echo.
set Count=0
FOR /F "delims=. tokens=1" %%g in ('dir /b "%Konum%\Bin\Language\*.cmd" 2^>NUL') do (
	set /a Count+=1
	echo Lang_!Count!_^>%%g^> >> %Konum%\Log\Dil
	echo %R%[32m   !Count! %R%[90m- %R%[33m %%g %R%[0m
)
Call :Dil A 2 T0006&echo %R%[32m   X %R%[90m- %R%[37m !LA2! %R%[0m
Call :Dil A 2 D0001&echo.&set /p Value_M=►%R%[32m !LA2!%R%[90m= %R%[0m
Call :Upper %Value_M% Value_M
	if %Value_M% EQU X (goto Main_Menu)
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "Lang_!Value_M!_" %Konum%\Log\Dil') do (
	FOR /F "delims=> tokens=2" %%k in ('Findstr /i "Language_Pack" %Konum%\Settings.ini') do (
		set Dil=%Konum%\Bin\Language\%%g.cmd
		Call :Powershell "(Get-Content %Konum%\Settings.ini) | ForEach-Object { $_ -replace '%%k', '%%g' } | Set-Content '%Konum%\Settings.ini'"
	)
)
goto Main_Menu

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Sistem_Bilgi
mode con cols=140 lines=50
Call :Date&Call :Time
Call :Dil A 2 B0004&echo.&echo %R%[91m !LA2! %R%[90m[ %DateDay% - %Time% ] %R%[0m
Call :Dil A 2 Error_0_&Call :Dil B 2 T0035&echo %R%[90m !LA2!= !LB2! %R%[0m 
echo  %R%[90m┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐%R%[0m
Call :Powershell "Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property Caption,InstallDate,OSArchitecture,RegisteredUser,CSName | format-list" > %Konum%\Log\OS.txt
FOR /F "tokens=3" %%a in ('Findstr /i "CSName" %Konum%\Log\OS.txt 2^>NUL') do (
	FOR /F "tokens=3" %%b in ('Findstr /i "RegisteredUser" %Konum%\Log\OS.txt 2^>NUL') do (
		Call :Dil A 2 EE_1_
		Call :Dil B 2 EE_2_
		echo   ►%R%[36m !LA2!:%R%[33m %%a %R%[0m
		echo   ►%R%[36m !LB2!:%R%[33m %%b %R%[0m
	)
)
echo  %R%[90m├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤%R%[0m
Call :Powershell "Get-CimInstance -ClassName Win32_TimeZone | Select-Object -Property Caption | format-list" > %Konum%\Log\utc.txt
Call :Dil A 2 EE_6_
FOR /F "tokens=5" %%a in ('Findstr /i "Caption" %Konum%\Log\OS.txt 2^>NUL') do (
	FOR /F "delims=:1 tokens=3" %%b in ('Findstr /i "Caption" %Konum%\Log\OS.txt 2^>NUL') do (
		FOR /F "tokens=3" %%c in ('Findstr /i "OSArchitecture" %Konum%\Log\OS.txt 2^>NUL') do (
			FOR /F "skip=2 delims=. tokens=3" %%d in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Update\TargetingInfo\Installed\Client.OS.rs2.amd64" /v "Version" 2^>NUL') do (
				FOR /F "skip=2 delims=. tokens=4" %%e in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Update\TargetingInfo\Installed\Client.OS.rs2.amd64" /v "Version" 2^>NUL') do (
					FOR /F "skip=2 tokens=3" %%f in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "DisplayVersion" 2^>NUL') do (
						echo   ►%R%[36m !LA2!:%R%[33m Windows %%a%%b %R%[90m│%R%[33m x%%c %R%[90m│%R%[33m %%f %R%[90m│%R%[33m %%d.%%e %R%[0m
					)
				)
			)
		)
	)
)
:: ──────────────────────────────────────
bcdedit > %Konum%\Log\Bcdedit.txt
Findstr /i "winload.efi" %Konum%\Log\Bcdedit.txt > NUL 2>&1
	if !errorlevel! EQU 0 (set Value=UEFI-GPT)
	if !errorlevel! NEQ 0 (set Value=BIOS-MBR)
Call :Dil A 2 EE_3_
Call :Dil B 2 EE_4_
Call :Dil C 2 EE_5_
FOR /F "tokens=3" %%a in ('Findstr /i "InstallDate" %Konum%\Log\OS.txt 2^>NUL') do (
	FOR /F "delims=(: tokens=3" %%b in ('Findstr /i "Caption" %Konum%\Log\utc.txt 2^>NUL') do (
		echo   ►%R%[36m !LA2!:%R%[33m %%a %R%[90m│%R%[36m !LB2!:%R%[33m !Value! %R%[90m│%R%[36m !LC2!:%R%[33m %%b %R%[0m
	)
)
echo  %R%[90m├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤%R%[0m
Call :Powershell "Get-CimInstance -ClassName Win32_computerSystem | Select-Object -Property Name,Model,Manufacturer,PrimaryOwnerName,TotalPhysicalMemory | format-list" > %Konum%\Log\ComputerSystem.txt
Call :Powershell "Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property Name | format-list" > %Konum%\Log\Bios.txt
Call :Powershell "Get-CimInstance -ClassName Win32_Processor | Select-Object -Property Name,CurrentClockSpeed,SocketDesignation,L2CacheSize,L3CacheSize,NumberOfCores,NumberOfLogicalProcessors | format-list" > %Konum%\Log\CPU.txt
Call :Dil A 2 EE_7_
Call :Dil B 2 EE_8_
Call :Dil C 2 EE_9_
Call :Dil D 2 EE_10_
Call :Dil E 2 EE_11_
FOR /F "delims=: tokens=2" %%a in ('Findstr /i "Manufacturer" %Konum%\Log\ComputerSystem.txt 2^>NUL') do (
	FOR /F "tokens=2 delims=':'" %%b in ('Findstr /i "Model" %Konum%\Log\ComputerSystem.txt 2^>NUL') do (
		FOR /F "tokens=2 delims=':'" %%c in ('Findstr /i "SocketDesignation" %Konum%\Log\CPU.txt 2^>NUL') do (
			FOR /F "tokens=2 delims=':'" %%d in ('Findstr /i "Name" %Konum%\Log\Bios.txt 2^>NUL') do (
				echo   %R%[35m▼ !LA2! %R%[0m
				echo   ►%R%[36m !LB2!:%R%[33m%%a %R%[0m
				echo   ►%R%[36m !LC2!:%R%[33m%%b %R%[90m│%R%[36m !LD2!:%R%[33m%%c %R%[90m│%R%[36m !LE2!:%R%[33m%%d %R%[0m 
			)
		)
	)
)
echo  %R%[90m├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤%R%[0m
Call :Dil A 2 EE_12_
Call :Dil B 2 EE_8_
Call :Dil C 2 EE_9_
Call :Dil D 2 EE_13_
Call :Dil E 2 EE_14_
Call :Dil F 2 EE_15_
FOR /F "delims=: tokens=2" %%a in ('Findstr /i "Name" %Konum%\Log\CPU.txt 2^>NUL') do (
	FOR /F "delims=: tokens=2" %%b in ('Findstr /i "NumberOfCores" %Konum%\Log\CPU.txt 2^>NUL') do (
		FOR /F "delims=: tokens=2" %%c in ('Findstr /i "NumberOfLogicalProcessors" %Konum%\Log\CPU.txt 2^>NUL') do (
			FOR /F "delims=: tokens=2" %%d in ('Findstr /i "L2CacheSize" %Konum%\Log\CPU.txt 2^>NUL') do (
				FOR /F "delims=: tokens=2" %%e in ('Findstr /i "L3CacheSize" %Konum%\Log\CPU.txt 2^>NUL') do (
					FOR /F "delims=: tokens=2" %%f in ('Findstr /i "CurrentClockSpeed" %Konum%\Log\CPU.txt 2^>NUL') do (
						echo   %R%[35m▼ !LA2! %R%[0m
						echo   ►%R%[36m !LB2!-!LC2!:%R%[33m%%a %R%[0m
						echo   ►%R%[36m !LD2!:%R%[33m%%b %R%[90m│%R%[36m !LE2!:%R%[33m%%c %R%[90m│%R%[36m L2:%R%[33m%%d%R%[37m KB %R%[90m│%R%[36m L3:%R%[33m%%e%R%[37m KB %R%[90m│%R%[36m !LF2!:%R%[33m%%f%R%[37m MHZ %R%[0m
					)
				)
			)
		)
	)
)
echo  %R%[90m├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤%R%[0m
DEL /F /Q /A "%Konum%\Log\DiskDetail" > NUL 2>&1
Call :Powershell "Get-PhysicalDisk | Select-Object -Property MediaType,FriendlyName,Size | Format-List" > %Konum%\Log\DiskDetailAll
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "MediaType" %Konum%\Log\DiskDetailAll 2^>NUL') do (
	set /a Count+=1
	echo  TYPE_!Count!_^>%%a^> >> %Konum%\Log\DiskDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "FriendlyName" %Konum%\Log\DiskDetailAll 2^>NUL') do (
	set /a Count+=1
	echo  Brand_!Count!_^>%%a^> >> %Konum%\Log\DiskDetail
)
set Count=0
FOR /F "tokens=4" %%a in ('Findstr /i "FriendlyName" %Konum%\Log\DiskDetailAll 2^>NUL') do (
	set /a Count+=1
	echo  Model_!Count!_^>%%a^> >> %Konum%\Log\DiskDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "Size" %Konum%\Log\DiskDetailAll 2^>NUL') do (
	set /a Count+=1
	echo  Boyut_!Count!_^>%%a^> >> %Konum%\Log\DiskDetail
)
Call :Dil A 2 EE_16_&echo   %R%[35m▼ !LA2! %R%[0m
Call :Dil A 2 EE_9_
Call :Dil B 2 EE_17_
FOR /L %%a in (1,1,!Count!) do (
	FOR /F "delims=> tokens=2" %%b in ('Findstr /i "TYPE_%%a_" %Konum%\Log\DiskDetail 2^>NUL') do (
		FOR /F "delims=> tokens=2" %%c in ('Findstr /i "Brand_%%a_" %Konum%\Log\DiskDetail 2^>NUL') do (
			FOR /F "delims=> tokens=2" %%d in ('Findstr /i "Model_%%a_" %Konum%\Log\DiskDetail 2^>NUL') do (
				FOR /F "delims=> tokens=2" %%e in ('Findstr /i "Boyut_%%a_" %Konum%\Log\DiskDetail 2^>NUL') do (
					set Value1=%%b
					set Value2=%%e
					Call :Uzunluk 1 !Value2!
					if !Uzunluk1! EQU 10 (echo   ►%R%[36m !Value1: =!:%R%[33m %%c %R%[90m│%R%[36m !LA2!:%R%[33m %%d %R%[90m│%R%[36m !LB2!:%R%[33m !Value2:~0,1!%R%[37m GB %R%[0m)
					if !Uzunluk1! EQU 11 (echo   ►%R%[36m !Value1: =!:%R%[33m %%c %R%[90m│%R%[36m !LA2!:%R%[33m %%d %R%[90m│%R%[36m !LB2!:%R%[33m !Value2:~0,2!%R%[37m GB %R%[0m)
					if !Uzunluk1! EQU 12 (echo   ►%R%[36m !Value1: =!:%R%[33m %%c %R%[90m│%R%[36m !LA2!:%R%[33m %%d %R%[90m│%R%[36m !LB2!:%R%[33m !Value2:~0,3!%R%[37m GB %R%[0m)
					if !Uzunluk1! EQU 13 (echo   ►%R%[36m !Value1: =!:%R%[33m %%c %R%[90m│%R%[36m !LA2!:%R%[33m %%d %R%[90m│%R%[36m !LB2!:%R%[33m !Value2:~0,1!%R%[37m TB %R%[0m)
				)
			)
		)
	)
)
echo  %R%[90m├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤%R%[0m
DEL /F /Q /A "%Konum%\Log\RamDetail" > NUL 2>&1
Call :PowerShell "Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object -Property Manufacturer,PartNumber,Capacity,Speed,SMBIOSMemoryType | Format-List" > %Konum%\Log\RamDetailAll
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "Manufacturer" %Konum%\Log\RamDetailAll 2^>NUL') do (
	set /a Count+=1
	echo Brand_!Count!_^>%%a^> >> %Konum%\Log\RamDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "PartNumber" %Konum%\Log\RamDetailAll 2^>NUL') do (
	set /a Count+=1
	echo Model_!Count!_^>%%a^> >> %Konum%\Log\RamDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "Capacity" %Konum%\Log\RamDetailAll 2^>NUL') do (
	set /a Count+=1
	echo Boyut_!Count!_^>%%a^> >> %Konum%\Log\RamDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "Speed" %Konum%\Log\RamDetailAll 2^>NUL') do (
	set /a Count+=1
	echo Speed_!Count!_^>%%a^> >> %Konum%\Log\RamDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "SMBIOSMemoryType" %Konum%\Log\RamDetailAll 2^>NUL') do (
	set /a Count+=1
	echo Type_!Count!_^>%%a^> >> %Konum%\Log\RamDetail
)
Call :Dil A 2 EE_18_&echo   %R%[35m▼ !LA2! %R%[0m
Call :Dil A 2 EE_8_
Call :Dil B 2 EE_9_
Call :Dil C 2 EE_17_
Call :Dil D 2 EE_15_
Call :Dil E 2 EE_10_
FOR /L %%a in (1,1,!Count!) do (
	FOR /F "delims=> tokens=2" %%b in ('Findstr /i "Brand_%%a_" %Konum%\Log\RamDetail 2^>NUL') do (
		FOR /F "delims=> tokens=2" %%c in ('Findstr /i "Model_%%a_" %Konum%\Log\RamDetail 2^>NUL') do (
			FOR /F "delims=> tokens=2" %%d in ('Findstr /i "Boyut_%%a_" %Konum%\Log\RamDetail 2^>NUL') do (
				FOR /F "delims=> tokens=2" %%e in ('Findstr /i "Speed_%%a_" %Konum%\Log\RamDetail 2^>NUL') do (
					FOR /F "delims=> tokens=2" %%f in ('Findstr /i "Type_%%a_" %Konum%\Log\RamDetail 2^>NUL') do (
						Call :Ram_Type "%%f"
						set Value=%%d
						Call :Uzunluk 1 !Value!
						if !Uzunluk1! EQU 10 (set Value=!Value:~0,1!)
						if !Uzunluk1! EQU 11 (set Value=!Value:~0,2!)
						if !Uzunluk1! EQU 12 (set Value=!Value:~0,3!)
						echo   ►%R%[36m !LA2!:%R%[33m %%b %R%[90m│%R%[36m !LB2!:%R%[33m %%c %R%[90m│%R%[36m !LC2!:%R%[33m !Value!%R%[37m GB %R%[90m│%R%[36m !LD2!:%R%[33m %%e%R%[37m MHZ %R%[90m│%R%[36m !LE2!:%R%[33m !Value_R! %R%[0m
					)
				)
			)
		)
	)
)
Call :Dil A 2 EE_19_
Call :Dil B 2 EE_18_
FOR /F "tokens=4" %%a in ('systeminfo ^| Find "Total Physical Memory"') do (
	FOR /F "delims=. tokens=1" %%b in ('echo %%a') do (
		echo   ►%R%[36m !LA2! !LB2!:%R%[33m %%b%R%[37m GB %R%[0m
	)
)
echo  %R%[90m├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤%R%[0m
Call :PowerShell "Get-CimInstance -ClassName win32_videocontroller | Select-Object -Property Name,CurrentHorizontalResolution,CurrentVerticalResolution,CurrentRefreshRate,AdapterRAM,DriverDate,DriverVersion | Format-List" > %Konum%\Log\GPUAll
DEL /F /Q /A "%Konum%\Log\GPUDetail" > NUL 2>&1
set Count=0
FOR /F "delims=: tokens=2" %%a in ('Findstr /i "Name" %Konum%\Log\GPUAll 2^>NUL') do (
	set /a Count+=1
	echo Name_!Count!_^>%%a^> >> %Konum%\Log\GPUDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "AdapterRAM" %Konum%\Log\GPUAll 2^>NUL') do (
	set /a Count+=1
	echo RAM_!Count!_^>%%a^> >> %Konum%\Log\GPUDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "DriverDate" %Konum%\Log\GPUAll 2^>NUL') do (
	set /a Count+=1
	echo DriverDate_!Count!_^>%%a^> >> %Konum%\Log\GPUDetail
)
set Count=0
FOR /F "tokens=3" %%a in ('Findstr /i "DriverVersion" %Konum%\Log\GPUAll 2^>NUL') do (
	set /a Count+=1
	echo DriverVersion_!Count!_^>%%a^> >> %Konum%\Log\GPUDetail
)
Call :Dil A 2 EE_20_&echo   %R%[35m▼ !LA2! %R%[0m
Call :Dil A 2 EE_21_
Call :Dil B 2 EE_22_
Call :Dil C 2 EE_8_
Call :Dil D 2 EE_9_
Call :Dil E 2 EE_23_
FOR /L %%a in (1,1,!Count!) do (
	FOR /F "delims=> tokens=2" %%b in ('Findstr /i "Name_%%a_" %Konum%\Log\GPUDetail 2^>NUL') do (
		FOR /F "delims=> tokens=2" %%c in ('Findstr /i "RAM_%%a_" %Konum%\Log\GPUDetail 2^>NUL') do (
			FOR /F "delims=> tokens=2" %%d in ('Findstr /i "DriverDate_%%a_" %Konum%\Log\GPUDetail 2^>NUL') do (
				FOR /F "delims=> tokens=2" %%e in ('Findstr /i "DriverVersion_%%a_" %Konum%\Log\GPUDetail 2^>NUL') do (
					set Value=%%c
					Call :Uzunluk 1 !Value!
					if !Uzunluk1! EQU 7 (set Value=!Value:~0,1!%R%[37m MB)
					if !Uzunluk1! EQU 8 (set Value=!Value:~0,2!%R%[37m MB)
					if !Uzunluk1! EQU 9 (set Value=!Value:~0,3!%R%[37m MB)
					if !Uzunluk1! EQU 10 (set Value=!Value:~0,1!%R%[37m GB)
					if !Uzunluk1! EQU 11 (set Value=!Value:~0,2!%R%[37m GB)
					if !Uzunluk1! EQU 12 (set Value=!Value:~0,3!%R%[37m GB)
					echo   ►%R%[36m !LC2!-!LD2!:%R%[33m%%b %R%[90m│%R%[36m !LE2!:%R%[33m !Value! %R%[90m│%R%[36m !LA2!:%R%[33m %%e %R%[90m│%R%[36m !LA2! !LB2!:%R%[33m %%d %R%[0m
				)
			)
		)
	)
)
echo  %R%[90m└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘%R%[0m
Call :Dil A 2 T0028&echo %R%[92m !LA2! %R%[0m
FOR %%a in (LA2 LB2 LC2 LD2 LE2 LF2 Value Value1 Value2 Value_R Uzunluk1 DateDay DateYear Time) do (set %%a=)
DEL /F /Q /A %Konum%\Log\* > NUL 2>&1
Call :Powershell "Get-CimInstance Win32_OperatingSystem | Select-Object Caption,InstallDate,OSArchitecture,RegisteredUser,CSName | FL" > %Konum%\Log\OS
pause > NUL
goto Main_Menu

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Performans_Edit
mode con cols=120 lines=35
Call :Dil A 2 B0008&echo.&echo %R%[36m► !LA2! %R%[0m
Call :Dil A 2 WW_0_&echo %R%[36m▼ !LA2! %R%[0m
Call :Dil A 2 WW_1_&echo.&echo %R%[33m !LA2! %R%[0m
Call :Dil A 2 WW_2_&echo %R%[33m !LA2! %R%[0m
echo.
Call :Dil A 2 WW_3_&echo %R%[33m !LA2! %R%[0m
Call :Dil A 2 WW_4_&echo %R%[33m !LA2! %R%[0m
Call :Dil A 2 WW_5_&Call :Dil A 3 WW_5_&echo %R%[33m !LA2!;%R%[37m !LA3! %R%[0m
echo.
Call :Dil A 2 WW_6_&echo %R%[33m !LA2! %R%[0m
Call :Dil A 2 WW_7_&echo %R%[33m !LA2! %R%[0m
:: UAC kapat
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "ConsentPromptBehaviorAdmin" REG_DWORD 0
Call :Powershell "Start-Process 'windowsdefender://ThreatSettings'"
Call :Dil A 2 WW_8_&echo.&set /p Value_MM=►%R%[32m !LA2!%R%[90m [%R%[36m Y%R%[90m │%R%[36m N%R%[90m ]: %R%[0m
Call :Upper %Value_M% Value_M
	if %Value_M% EQU N (set Error=X&goto Main_Menu)
	if %Value_M% NEQ N (Call :Dil A 2 WW_9_&echo.&set /p Value_MM=►%R%[31m !LA2!%R%[90m [%R%[36m Y%R%[90m │%R%[36m N%R%[90m ]: %R%[0m
						Call :Upper !Value_MM! Value_MM
						if !Value_MM! EQU N (set Error=X&goto Main_Menu))
set Value_M=
set Value_MM=
:: -------------------------------------------------------------
cls
FOR /F "tokens=6" %%a in ('Dism /online /Get-intl ^| Find /I "Default system UI language"') do (
	if %%a EQU tr-TR (powercfg -list ^| findstr /C:"Nihai" > NUL 2>&1
						if !errorlevel! NEQ 0 (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
											   FOR /F "tokens=4" %%b in ('powercfg -list ^| findstr /C:"Nihai"') do (powercfg -setactive %%b))
	)
)
:: -------------------------------------------------------------
cls
Call :Dil A 2 OG_1_&echo ►%R%[32m !LA2! %R%[0m
FOR /L %%a in (1,1,3) do (
	Call :Read_Features "OGNI_%%a_"
	Call :Remove_!Value_C! "OGNI_%%a_"
)
FOR %%a in (1 2 4 5 6 8 9 14 18 20 21 22 30 38 45) do (
	Call :Read_Features "COM_%%a_"
	Call :Remove_!Value_C! "COM_%%a_"
)
:: -------------------------------------------------------------
cls&Call :Dil A 2 OG_2_&echo ►%R%[32m !LA2! %R%[0m
Call :Powershell "Get-CimInstance -ClassName Win32_Processor | Select-Object -Property Name | format-list" > %Konum%\Log\Brand
FOR /F "tokens=3" %%a in ('Findstr /i "Name" %Konum%\Log\Brand') do (
	if %%a EQU AMD (FOR %%b in (intelpep Telemetry iai2c iaLPSS2i_I2C iaLPSS2i_I2C_BXT_P iaLPSS2i_I2C_CNL iaLPSS2i_I2C_GLK iaLPSS2i_GPIO2_GLK iaLPSS2i_GPIO2_CNL iaLPSS2i_GPIO2_BXT_P iaLPSS2i_GPIO2 iaLPSSi_GPIO intelpmax iagpio iaStorV intelppm) do (Call :Service_Check %%b))
	if %%a NEQ AMD (FOR %%b in (amdgpio2 amdi2c AmdPPM AmdK8 amdsata amdsbs amdxata) do (Call :Service_Check %%b))
)
DEL /F /Q /A "%Konum%\Log\Brand" > NUL 2>&1
:: -------------------------------------------------------------
:: Silinecek hizmetler
FOR %%a in (
DiagTrack
dmwappushservice
diagnosticshub.standartcollector.service
SecurityHealthService
Sense
SgrmBroker
WdNisSvc
WinDefend
wscsvc
WdNisDrv
WdFilter
WdBoot
SgrmAgent
MsSecFlt
webthreatdefsvc
webthreatdefusersvc
PimIndexMaintenanceSvc
PenService
RetailDemo
) do (
	reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%a" > NUL 2>&1
		if !errorlevel! EQU 0 (%NSudo% sc delete %%a)
)
:: -------------------------------------------------------------
:: Kapatılacak hizmetler
:: VSS
:: wbengine
:: SDRSVC
:: swprv
:: fhsvc
FOR %%a in (
diagsvc
InventorySvc
edgeupdate
edgeupdatem
PcaSvc
wercplsupport
DPS
WdiServiceHost
WdiSystemHost
Themes
SharedRealitySvc
spectrum
perceptionsimulation
VacSvc
MixedRealityOpenXRSvc
WerSvc
wisvc
WSearch
SEMgrSvc
TroubleshootingSvc
MapsBroker
Spooler
TabletInputService
DusmSvc
WalletService
GpuEnergyDrv
) do (
	reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%a" > NUL 2>&1
		if !errorlevel! EQU 0 (%NSudo% sc config %%a start= disabled)
)
:: -------------------------------------------------------------
:: Manuel hizmetler
FOR %%a in (
StorSvc
) do (
	reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%a" > NUL 2>&1
		if !errorlevel! EQU 0 (%NSudo% sc config %%a start= demand)
)
:: -------------------------------------------------------------
:: Kaldırılacak uygulamalar
cls&Call :Dil A 2 OG_3_&echo ►%R%[32m !LA2! %R%[0m
:: Windows.Photos
:: Paint
:: StickyNotes
:: ZuneVideo
:: ZuneMusic
:: WindowsTerminal
FOR %%a in (
549981C3F5F10
BingWeather
BingNews
ScoobeSystemSettingEnabled
Family
QuickAssist
teams
Skype
WindowsMaps
Todos
PowerAutomateDesktop
MicrosoftStickyNotes
Office
Microsoft3DViewer
RawImageExtension
WebpImageExtension
WebMediaExtensions
VP9VideoExtensions
HEIFImageExtension
WindowsFeedbackHub
Getstarted
GetHelp
Clipchamp
solitairecollection
MixedReality
Wallet
) do (
	Call :Powershell "Get-AppXPackage -AllUsers *%%a* | Remove-AppxPackage"
	Call :FA RD "%programfiles%\WindowsApps\*%%a*"
)
:: -------------------------------------------------------------
cls&Call :Dil A 2 OG_4_&echo ►%R%[32m !LA2! %R%[0m
Call :CurrentUserName
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
Call :RegDel "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
Call :RD "C:\Users\%username%\3D Objects"
Call :RD "C:\Users\%username%\Searches"
Call :RD "C:\Users\%username%\Links"
Call :RD "C:\Users\%username%\Contacts"
Call :RegAdd "HKCU\Control Panel\Desktop" "AutoEndTasks" REG_SZ 1 
Call :RegAdd "HKCU\Control Panel\Desktop" "HungAppTimeout" REG_SZ "3000"
Call :RegAdd "HKCU\Control Panel\Desktop" "WaitToKillAppTime" REG_SZ "1000"
Call :RegAdd "HKCU\Control Panel\Desktop" "LowLevelHooksTimeout" REG_SZ "4000"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control" "WaitToKillServiceTimeout" REG_SZ "2000"
Call :RegAdd "HKCU\Control Panel\Desktop" "MenuShowDelay" REG_SZ "0"
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoLowDiskSpaceChecks" REG_DWORD 1
Call :RegAdd "HKCU\Control Panel\Mouse" "MouseHoverTime" REG_DWORD 100 
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "LinkResolveIgnoreLinkInfo" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoResolveSearch" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoResolveTrack" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" REG_DWORD 3
Call :RegAdd "HKCU\Control Panel\Desktop" "UserPreferencesMask" REG_BINARY "9012038010000000"
Call :RegAdd "HKCU\Control Panel\Desktop\WindowMetrics" "MinAnimate" REG_SZ 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarAnimations" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "EnableAeroPeek" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "AlwaysHibernateThumbnails" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ListviewAlphaSelect" REG_DWORD 0
Call :RegAdd "HKCU\Control Panel\Desktop" "DragFullWindows" REG_SZ 0
Call :RegAdd "HKCU\Control Panel\Desktop" "FontSmoothing" REG_SZ 2
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ListviewShadow" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" "ShellState" REG_BINARY "240000003E28000000000000000000000000000001000000130000000000000062000000"
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMax" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMin" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMax" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMin" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMax" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMin" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Power" "CoreParkingDisabled" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" REG_DWORD 0
if %Win% EQU 11 (Call :RegKey "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
				 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "UseCompactMode" REG_DWORD 1)
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" REG_DWORD "0x0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" "value" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" "EnableFeeds" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" "ShellFeedsTaskbarViewMode" REG_DWORD 2
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "AccentColor2" REG_DWORD 0xff6b5c51
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "ColorizationColor" REG_DWORD 0xc4515c6b
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "ColorizationColorBalance" REG_DWORD 0x59
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "ColorizationAfterglow" REG_DWORD 0xc4515c6b
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "ColorizationAfterglowBalance" REG_DWORD 0xa
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "ColorizationBlurBalance" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "EnableWindowColorization" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\DWM" "ColorizationGlassAttribute" REG_DWORD 1
:: Ayarlar uygulamasında önerilen içeriği kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338393Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353694Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353696Enabled" REG_DWORD 0
:: Windows karşılama deneyimini kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-310093Enabled" REG_DWORD 0
:: İstenmeyen uygulamaların yüklemesini kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SilentInstalledAppsEnabled" REG_DWORD 0 
:: Önerilen uygulamaların otomatik kurulmasını kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-314563Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-280815Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-314559Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RemediationRequired" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "PreInstalledAppsEverEnabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "PreInstalledAppsEnabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "OemPreInstalledAppsEnabled" REG_DWORD 0 
:: Sponsorlu uygulamaların otomatik kurulmasını engelle
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" REG_DWORD 1 
:: Üçüncü taraf uygulama önerisini kapat
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableThirdPartySuggestions" REG_DWORD 1 
:: Başlat menüsü uygulama önerisini kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338388Enabled" REG_DWORD 0
:: Başlat menüsü kutucuklarını kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "ContentDeliveryAllowed" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "FeatureManagementEnabled" REG_DWORD 0 
:: Windows kullanırken öneri ve ipuçlarını kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContentEnabled" REG_DWORD 0
:: Zaman çizelgesi önerilerini kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353698Enabled" REG_DWORD 0
:: Kilit ekranı ipuçlarını kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338387Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RotatingLockScreenOverlayEnabled" REG_DWORD 0
:: Windows lnk çalışma alanı kapat
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-280813Enabled" REG_DWORD 0
:: Harita uygulamasını yükleme
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338381Enabled" REG_DWORD 0
::
Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\Subscriptions"
Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\SuggestedApps"
::
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableConsumerAccountStateContent" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" "StartupDelayInMSec" REG_DWORD "0"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\Prefetchparameters" "EnableBoottrace" REG_DWORD "0"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\Prefetchparameters" "EnablePrefetcher" REG_DWORD "0"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\Prefetchparameters" "EnableSuperfetch" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout" "EnableAutoLayout" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" "NonBestEffortLimit" REG_DWORD "0"
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\FileSystem" "LongPathsEnabled" REG_DWORD "1"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" "LongPathsEnabled" REG_DWORD "1"
Call :RegAdd "HKCU\Software\Microsoft\GameBar" "AutoGameModeEnabled" REG_DWORD 1
Call :RegAdd "HKCU\System\GameConfigStore" "GameDVR_FSEBehavior" REG_DWORD "2"
Call :RegAdd "HKCU\System\GameConfigStore" "GameDVR_FSEBehaviorMode" REG_DWORD "2"
Call :RegAdd "HKCU\System\GameConfigStore" "GameDVR_Enabled" REG_SZ "0"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" "HiberbootEnabled" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\Power" "HibernateEnabled" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" "ShowHibernateOption" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" REG_DWORD 0
Call :RegAdd "HKCU\Control Panel\Accessibility\StickyKeys" "Flags" REG_SZ 506
Call :RegAdd "HKCU\Control Panel\Accessibility\ToggleKeys" "Flags" REG_SZ "58"
Call :RegAdd "HKCU\Control Panel\Accessibility\Keyboard Response" "Flags" REG_SZ "122"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "NoUseStoreOpenWith" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoInternetOpenWith" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "UploadUserActivities" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" "ShowFrequent" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" "AllowLinguisticDataCollection" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Personalization\Settings" "AcceptedPrivacyPolicy" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Siuf\Rules" "NumberOfSIUFInPeriod" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Input\TIPC" "Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Input\TIPC" "Enabled" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" "AllowExperimentation" REG_DWORD 0
Call :RegAdd "HKCU\Software\NVIDIA Corporation\NVControlPanel2\Client" "OptInOrOutPreference" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Internet Explorer\FlipAhead" "FPEnabled" REG_DWORD 0
Call :RegAdd "HKCU\Control Panel\International\User Profile" "HttpAcceptLanguageOptOut" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" "DisabledByGroupPolicy" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" "DisableInventory" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\MediaPlayer\Preferences" "UsageTracking" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "DoNotShowFeedbackNotifications" REG_DWORD 1
Call :RegDel "HKCU\SOFTWARE\Microsoft\Siuf\Rules" "PeriodInNanoSeconds"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Wifi\AllowWiFiHotSpotReporting" "value" REG_DWORD "0"
Call :RegAdd "HKCU\Microsoft\Speech\Preferences" "ModeForOff" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableTailoredExperiencesWithDiagnosticData" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" "TailoredExperiencesWithDiagnosticDataEnabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" "ShowRecent" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE\AppSettings" "Skype-UserConsentAccepted" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" "NearShareChannelUserAuthzPolicy" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" "CdpSessionUserAuthzPolicy" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "EnableCdp" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Input\Settings" "InsightsEnabled" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" "PaidWifi" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" "WiFiSenseOpen" REG_DWORD 0
:: Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" "AllowInputPersonalization" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_TrackDocs" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "HideFrequentlyUsedApps" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "HideAppList" REG_DWORD 3
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoRecentDocsHistory" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "ReportBootOk" REG_SZ 0
Call :RegAdd "HKCR\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder" "Attributes" REG_DWORD 2696937728
Call :RegAdd "HKCR\WOW6432Node\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder" "Attributes" REG_DWORD 2696937728
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\KDC\Parameters" "EmitLILI" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "HideRecentJumplists" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableCloudOptimizedContent" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "HideRecentlyAddedApps" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "HideRecommendedSection" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_Layout" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "ShowOrHideMostUsedApps" REG_DWORD 2 
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoRecentDocsHistory" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "AllowOnlineTips" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" "DisableHelpSticker" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" "Headlines" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" "MicrosoftKBSearch" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\DeviceHealthAttestationService" "EnableDeviceHealthAttestationService" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "DisableGraphRecentItems" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_TrackProgs" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Context\CloudExperienceHostIntent\Wireless" "ScoobeCheckCompleted" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" "ScoobeSystemSettingEnabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSyncProviderNotifications" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "PromptOnSecureDesktop" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" "EnabledExecution" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoLowDiskSpaceChecks" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "32" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "512" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "2048" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "08" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "256" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "04" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" "01" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "LinkResolveIgnoreLinkInfo" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoResolveSearch" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoResolveTrack" REG_DWORD 1
Call :RegAdd "HKCU\Control Panel\Mouse" MouseThreshold2 REG_SZ 10
Call :RegAdd "HKCU\Control Panel\Mouse" MouseThreshold1 REG_SZ 6
Call :RegAdd "HKCU\Control Panel\Mouse" MouseSpeed REG_SZ 0
Call :RegAdd "HKCU\Control Panel\Mouse" MouseHoverTime REG_SZ 3000
Call :RegAdd "HKCU\Control Panel\Mouse" MouseSensitivity REG_SZ 10
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\Power\PowerThrottling" "PowerThrottlingOff" REG_DWORD 1 
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" "PowerThrottlingOff" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" "NoActiveProbe" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "AllowBlockingAppsAtShutdown" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" "ShippedWithReserves" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" "PassedPolicy" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" "MiscPolicyInfo" REG_DWORD 2
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "DisableOSUpgrade" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RestartNotificationsAllowed2" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "IsExpedited" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "HideMCTLink" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" "DisableGwx" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "SetUpdateNotificationLevel" REG_DWORD 0
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoUpdate" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseFeatureUpdatesStartTime" REG_SZ "2020-01-01T22:47:13Z"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseFeatureUpdatesEndTime" REG_SZ "2099-11-10T22:47:13Z"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseQualityUpdatesStartTime" REG_SZ "2020-01-01T22:47:13Z"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseQualityUpdatesEndTime" REG_SZ "2099-11-10T22:47:13Z"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseUpdatesStartTime" REG_SZ "2020-01-01T22:47:13Z"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseUpdatesExpiryTime" REG_SZ "2099-11-10T22:47:13Z"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" "SearchOrderConfig" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" "ExcludeWUDriversInQualityUpdate" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" "ModelDownloadAllowed" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Speech" "AllowSpeechModelUpdate" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "AutoDownload" REG_DWORD 2 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageHealth" "AllowDiskHealthModelUpdates" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" "DisableWUfBSafeguards" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" "ConfigureChatAutoInstall" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\CrashControl" "AutoReboot" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" "AutoReboot" REG_DWORD 0
Call :RegAdd "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\QuietHours" "Enable" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" "EnthusiastMode" REG_DWORD 1 
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSuperHidden" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" "DisableAutoplay" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" "EnableLog" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" "EnableDpxLog" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" "DisableComponentBackups" REG_DWORD 1
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Services\BFE\Parameters\Policy\Options" "CollectNetEvents" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" "CollectNetEvents" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" "ToastEnabled" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\QuietHours" "Enable" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSyncProviderNotifications" REG_DWORD "0" 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "NoNewAppAlert" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "DisableStartupSound" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" "DisableATMFD" REG_DWORD 1
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\GraphicsDrivers" "HwSchMode" REG_DWORD 2
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "HwSchMode" REG_DWORD 2
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" "TimeStampInterval" REG_DWORD "0"
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "EnableSnapAssistFlyout" REG_DWORD 0 
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" "DisablePagingCombining" REG_DWORD "1"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "DisablePagingCombining" REG_DWORD "1"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /f
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SeparateProcess" REG_DWORD 0 
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Services\LanmanServer\Parameters" "AutoShareWks" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" "AutoShareWks" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" "AllowInsecureGuestAuth" REG_DWORD "0"
if %Win% EQU 11 (Reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "ConfigureStartPins" /t REG_SZ /d "{\"pinnedList\": [{}]}" /f > NUL 2>&1
				 Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "ConfigureStartPins_ProviderSet" REG_DWORD "0"
)
Call :RegDel "HKCR\cmdfile\shell\print"
Call :RegDel "HKCR\batfile\shell\print"
Call :RegDel "HKCR\regfile\shell\print"
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" "ShowCloudFilesInQuickAccess" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" "EnableAutocorrection" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" "EnableSpellchecking" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" "UserAuthPolicy" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" "IsDeviceSearchHistoryEnabled" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" "PeopleBand" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SearchboxTaskbarMode" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" "ShellFeedsTaskbarViewMode" REG_DWORD 2
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowCortanaButton" REG_DWORD 0 
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" "CortanaInAmbientMode" REG_DWORD 0
if %Win% EQU 11 (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" REG_DWORD 0)
if %Win% EQU 10 (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "HideSCAMeetNow" REG_DWORD 1)
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP" "CEIPEnable" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" "CEIPEnable" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Messenger\Client" "CEIP" REG_DWORD 2
Call :RegAdd "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" "CEIPEnable" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\SAM" "SamNGCKeyROCAValidation" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "DontSendAdditionalData" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "LoggingDisabled" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "Disabled" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "BypassNetworkCostThrottling" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "BypassDataThrottling" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "AutoApproveOSDump" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" "IncludeKernelFaults" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "Disabled" REG_DWORD 1 
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "Disabled" REG_DWORD 1 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" "DoReport" REG_DWORD 0 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" "DisableSendRequestAdditionalSoftwareToWER" REG_DWORD 1 
Call :RegAdd "HKCU\Policies\Microsoft\Windows\CloudContent" "DisableTailoredExperiencesWithDiagnosticData" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" "AITEnable" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" "Start" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" "Start" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\CrashControl\StorageTelemetry" "DeviceDumpEnabled" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry" "DeviceDumpEnabled" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\SQMLogger" "Start" REG_DWORD "0"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" "Start" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" "IsCensusDisabled" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" "DontRetryOnError" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" "TaskEnableRun" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\DataCollection" "AllowTelemetry" REG_DWORD 0
Call :RegAdd "HKCU\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" REG_DWORD 0
Call :RegAdd "HKCU\Policies\Microsoft\Assistance\Client\1.0" "NoExplicitFeedback" REG_DWORD 1
Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup"
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-280811Enabled" REG_DWORD 0
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-280810Enabled" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46ac-8BEE-B1715EC634E5}" "DownloadToolsEnabled" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46ac-8BEE-B1715EC634E5}" "ScenarioExecutionEnabled" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Messenger\Client" "PreventAutoRun" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Messenger\Client" "PreventRun" REG_DWORD 1
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\Remote Assistance" "fAllowToGetHelp" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" "fAllowToGetHelp" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\Remote Assistance" "fAllowFullControl" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" "fAllowFullControl" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" "DisableNotifications" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" "DisableEnhancedNotifications" REG_DWORD "1"
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows Security Health\State" "AccountProtection_MicrosoftAccount_Disconnected" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender" "DisableAntiSpyware" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender" "DisableAntiVirus" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" "TamperProtection" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" "TamperProtectionSource" REG_DWORD "2"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\Signature Updates" "FirstAuGracePeriod" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\UX Configuration" "DisablePrivacyMode" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" "SecurityHealth" REG_BINARY "030000000000000000000000"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MRT" "DontOfferThroughWUAU" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MRT" "DontReportInfectionInformation" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" "HideSystray" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" "DisableAntiSpyware" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" "PUAProtection" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" "RandomizRheduleTaskTimes" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions" "DisableAutoExclusions" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" "MpEnablePus" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Quarantine" "LocalSettingOverridePurgeItemsAfterDelay" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Quarantine" "PurgeItemsAfterDelay" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableBehaviorMonitoring" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableIOAVProtection" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableScanOnRealtimeEnable" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableOnAccessProtection" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableRealtimeMonitoring" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableRoutinelyTakingAction" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisablRanOnRealtimeEnable" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisablRriptScanning" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Remediation" "Scan_ScheduleDay" REG_DWORD "8"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Remediation" "Scan_ScheduleTime" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "AdditionalActionTimeOut" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "CriticalFailureTimeOut" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "DisableEnhancedNotifications" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "DisableGenericRePorts" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "NonCriticalTimeOut" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "AvgCPULoadFactor" REG_DWORD "10"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableArchivRanning" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableCatchupFullScan" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableCatchupQuickScan" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableRemovableDrivRanning" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableRestorePoint" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisablRanningMappedNetworkDrivesForFullScan" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisablRanningNetworkFiles" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "PurgeItemsAfterDelay" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "ScanOnlyIfIdle" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "ScanParameters" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "ScheduleDay" REG_DWORD 8
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "ScheduleTime" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" "DisableUpdateOnStartupWithoutEngine" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" "ScheduleDay" REG_DWORD 8
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" "ScheduleTime" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" "SignatureUpdateCatchupInterval" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" "DisableBlockAtFirstSeen" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" "LocalSettingOverrideSpynetReporting" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" "SpyNetReporting" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" "SpyNetReportingLocation" REG_MULTI_SZ "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" "SubmitSamplRonsent" REG_DWORD "2"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" "Start" REG_DWORD "0"
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\DefenderApiLogger" "Start" REG_DWORD "0"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" "Start" REG_DWORD "0"
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\DefenderAuditLogger" "Start" REG_DWORD "0"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "HidRAHealth" REG_DWORD "1"
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 0
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "EnableWebContentEvaluation" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "PreventOverride" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Policies\Microsoft\Edge" "SmartScreenEnabled" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Security Health\State" "AppAndBrowser_StoreAppsSmartScreenOff" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "SmartScreenEnabled" REG_SZ "Off"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "SmartScreenEnabled" REG_SZ "Off"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\PhishingFilter" "EnabledV9" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\PhishingFilter" "PreventOverride" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" "EnabledV9" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" "PreventOverride" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "EnableSmartScreen" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" "ConfigureAppInstallControl" REG_SZ "Anywhere"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" "ConfigureAppInstallControlEnabled" REG_DWORD "0"
Call :RegAdd "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" "PreventOverride" REG_DWORD 0
Call :RegAdd "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" "Enabledv9" REG_DWORD 0
Call :RegDel "HKCR\Drive\shellex\ContextMenuHandlers\EPP"
Call :RegDel "HKCR\Directory\shellex\ContextMenuHandlers\EPP"
Call :RegDel "HKCR\*\shellex\ContextMenuHandlers\EPP"
Call :RegAdd "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell" "BagMRU Size" REG_DWORD "0x4e20"
Call :RegKey "HKCU\Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore"
Call :Powershell "Get-PhysicalDisk | Select-Object -Property MediaType| Format-Table" > %Konum%\Log\SSD
Findstr /i "SSD" %Konum%\Log\SSD > NUL 2>&1
	if !errorlevel! EQU 0 (Call :RegAdd "HKLM\System\CurrentControlSet\Control\Power" "HibernateEnabled" REG_DWORD 0
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Power" "HibernateEnabledDefault" REG_DWORD 0
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\FileSystem" "NtfsDisableLastAccessUpdate" REG_DWORD 0x80000001
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Power" "HiberbootEnabled" REG_DWORD 0
						   Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoThumbnailCache" REG_DWORD 0
						   Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "DisableThumbnailCache" REG_DWORD 0
						   Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "NoThumbnailCache" REG_DWORD 0
						   Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "DisableThumbnailCache" REG_DWORD 0
						   Call :RegAdd "HKCU\Software\Policies\Microsoft\Windows\Explorer" "DisableThumbsDBOnNetworkFolders" REG_DWORD 0
						   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoThumbnailCache" REG_DWORD 0
						   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "DisableThumbnailCache" REG_DWORD 0
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" "DisablePagingExecutive" REG_DWORD 1
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" "EnablePrefetcher" REG_DWORD 0
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" "EnableSuperFetch" REG_DWORD 0
						   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "Enable" REG_SZ N
						   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Wbem\CIMOM" "EnableEvents" REG_DWORD 0
						   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Wbem\CIMOM" "Logging" REG_SZ 0
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\FileSystem" "NtfsDisable8dot3NameCreation" REG_DWORD 1
						   Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Policies" "DisableDeleteNotification" REG_DWORD 0
						   fsutil behavior set disabledeletenotify NTFS 0 >nul 2>&1
						   Call :SC "FontCache" "disabled"
						   Call :SC "FontCache3.0.0.0" "disabled"
						   Call :SC "defragsvc" "auto"
						   Call :SC "WSearch" "disabled")
	if !errorlevel! NEQ 0 (Call :RegAdd "HKLM\System\CurrentControlSet\Control\Power" "HibernateEnabled" REG_DWORD 1
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Power" "HibernateEnabledDefault" REG_DWORD 1
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Power" "HiberbootEnabled" REG_DWORD 1
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" "EnablePrefetcher" REG_DWORD 1
						   Call :RegAdd "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" "EnableSuperFetch" REG_DWORD 1
						   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "Enable" REG_SZ Y
						   fsutil behavior set disabledeletenotify NTFS 1 > NUL 2>&1
						   Call :SC "FontCache" "auto"
						   Call :SC "FontCache3.0.0.0" "demand"
						   Call :SC "SysMain" "auto")
DEL /F /Q /A "%Konum%\Log\SSD" > NUL 2>&1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "SettingsPageVisibility" REG_SZ "hide:windowsdefender;maps;windowsinsider;family-group;pen"
:: Dosya Gezgini arama kutusundaki son arama girişlerinin görüntülenmesini kapatın
Call :RegAdd "HKCU\Software\Policies\Microsoft\Windows\Explorer" "DisableSearchBoxSuggestions" REG_DWORD 1
:: Mürekkep Oluşturma ve Yazma Kişiselleştirmesini kapatma
Call :RegAdd "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" "HarvestContacts" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Policies\Microsoft\InputPersonalization" "RestrictImplicitInkCollection" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" "AcceptedPrivacyPolicy" REG_DWORD 0
:: Arama bölümü için
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowIndexingEncryptedStoresOrItems" REG_DWORD 0 :: Şifrelenmiş dosyaların indekslenme izni kaldırılıyor. 
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "ConnectedSearchUseWebOverMeteredConnections" REG_DWORD 0 :: Tarifeli bağlantılar üzerinden aramada web'de arama yapmayın veya web sonuçlarını görüntülemeyin
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" "SafeSearchMode" REG_DWORD 0 :: Güvenli arama modu kapatılıyor.
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCloudSearch" REG_DWORD 0 :: Bulut arama kapatılıyor.
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "DeviceHistoryEnabled" REG_DWORD "0"
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "HistoryViewEnabled" REG_DWORD "0"
:: Arama bölümü internet araması için
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" REG_DWORD 0 :: Arama - Bing Web sonuçlarını devre dışı bırak
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\SearchCompanion" "DisableContentFileUpdates" REG_DWORD 1 :: Arama yardımcısı içerik güncelleştirmelerini kapat
:: -------------------------------------------------------------
cls&Call :Dil A 2 OG_5_&echo ►%R%[32m !LA2! %R%[0m
FOR %%a in (
"\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
"\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
"\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
"\Microsoft\Windows\Windows Defender\Windows Defender Verification"
"\Microsoft\Windows\WindowsUpdate\Scheduled Start"
"\Microsoft\Windows\Maps\MapsToastTask"
"\Microsoft\Windows\Maps\MapsUpdateTask"
"\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
"\Microsoft\Windows\Speech\SpeechModelDownloadTask"
"\Microsoft\Windows\Application Experience\ProgramDataUpdater"
"\Microsoft\Windows\Application Experience\StartupAppTask"
"\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
"\Microsoft\Windows\DiskCleanup\SilentCleanup"
"\Microsoft\Windows\Windows Error Reporting\QueueReporting"
"\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
"\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
"\Microsoft\Windows\Time Zone\SynchronizeTimeZone"
"\Microsoft\Windows\WaaSMedic\PerformRemediation"
"\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
"\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
"\Microsoft\Windows\Customer Experience Improvement Program\USBCeip"
"\Microsoft\Windows\Shell\FamilySafetyMonitor"
"\Microsoft\Windows\Shell\FamilySafetyRefresh"
"\Microsoft\Windows\Feedback\Siuf\DmClient"
"\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
"\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask"
"\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
"\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
"\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task"
"\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker"
"\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate"
"\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_LicenseAccepted"
"\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work"
"\Microsoft\Windows\UpdateOrchestrator\Schedule Work"
"\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work"
"\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work"
"\Microsoft\Windows\UpdateOrchestrator\Report policies"
"\Microsoft\Windows\RetailDemo\CleanupOfflineContent"
) do (
	schtasks /Change /TN %%a /DISABLE > NUL 2>&1
		if !errorlevel! NEQ 0 (%NSudo% schtasks /Change /TN %%a /DISABLE)
)
:: -------------------------------------------------------------
cls&Call :Dil A 2 OG_6_&echo ►%R%[32m !LA2! %R%[0m
Taskkill /f /im smartscreen.exe > NUL 2>&1
FOR %%a in (
"%windir%\System32\CompatTelRunner.exe"
"%windir%\System32\drivers\MsSecFlt.sys"
"%windir%\System32\drivers\WdBoot.sys"
"%windir%\System32\drivers\WdFilter.sys"
"%windir%\System32\drivers\WdNisDrv.sys"
"%windir%\System32\smartscreen.exe"
"%windir%\System32\securityhealthhost.exe"
"%windir%\System32\securityhealthservice.exe"
"%windir%\System32\securityhealthsystray.exe"
"%windir%\System32\SgrmBroker.exe"
) do (
	%NSudo% DEL /F /Q /A %%a
)
:: -------------------------------------------------------------
FOR %%a in (
"%windir%\*.log"
"%windir%\CbsTemp\*"
"%windir%\Logs\*"
) do (
	Call :FA DEL %%a

)
:: -------------------------------------------------------------
FOR %%a in (
"C:\*guard.wim"
) do (
	Call :FA DELS %%a
)
:: -------------------------------------------------------------
FOR %%a in (
"%programfiles%\Windows Defender Advanced Threat Protection"
"%programfiles%\Windows Defender"
"%programfiles%\Windows Security"
"%programfiles(x86)%\Windows Security"
"%programfiles(x86)%\Windows Defender"
"%programfiles(x86)%\Windows Defender Advanced Threat Protection"
"%programdata%\Microsoft\Windows Security Health"
"%programdata%\Microsoft\Windows Defender Advanced Threat Protection"
"%programdata%\Microsoft\Windows Defender"
"%windir%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy"
"%windir%\WinSxS\Temp"
"%windir%\WinSxS\Backup"
"%windir%\Containers"
) do (
	Call :RD %%a
)
:: -------------------------------------------------------------
FOR %%a in (
"%LocalAppData%\Packages\*.SecHealthUI_*"
"%Windir%\CbsTemp\*"
"%windir%\Logs\*"
) do (
	Call :FA RD %%a
)
:: -------------------------------------------------------------
FOR %%a in (
"%Windir%\System32\OneDriveSetup.exe"
"%Windir%\SysWOW64\OneDriveSetup.exe"
) do (
	%%a /uninstall > NUL 2>&1
)
Call :FA RDS "C:\*onedrive*"
Call :FA DELS "C:\*onedrive*"
:: -------------------------------------------------------------
:: Taskkill /f /im "msedge.exe" > NUL 2>&1
:: FOR %%a in ('Dir /AD /B "%programfiles(x86)%\Microsoft\Edge\Application\*" 2^>NUL') do (
:: 	dir /b "%programfiles(x86)%\Microsoft\Edge\Application\%%a\Installer" > NUL 2>&1
:: 		if !errorlevel! EQU 0 ("%programfiles(x86)%\Microsoft\Edge\Application\%%a\Installer\setup.exe" --uninstall --system-level --force-uninstall)
:: )
:: FOR %%a in ('Dir /AD /B "%programfiles(x86)%\Microsoft\EdgeWebView\Application\*" 2^>NUL') do (
:: 	dir /b "%programfiles(x86)%\Microsoft\EdgeWebView\Application\%%a\Installer" > NUL 2>&1
:: 		if !errorlevel! EQU 0 ("%programfiles(x86)%\Microsoft\EdgeWebView\Application\%%a\Installer\setup.exe" --uninstall --msedgewebview --system-level --force-uninstall)
:: )	
:: Call :RD "%programfiles(x86)%\Microsoft"
:: Call :DEL "C:\Users\%username%\Desktop\edge.lnk"
:: Call :DEL "C:\Users\%username%\Desktop\Microsoft Edge.lnk"
:: Call :RD "%LocalAppData%\Microsoft\Edge"
:: Call :FA DELS "C:\*dge.wim"
:: Call :RegAdd "HKLM\OFF_SOFTWARE\Policies\Microsoft\MicrosoftEdge" "PreventFirstRunPage" REG_DWORD 0
:: Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove
:: Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove
:: Call :RegDel "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove
:: -------------------------------------------------------------
:: Call :FA DELS "C:\*winre.wim"
:: -------------------------------------------------------------
cls&Call :Dil A 2 OG_7_&echo ►%R%[32m !LA2! %R%[0m
bcdedit /set {current} recoveryenabled no > NUL
powercfg /h off > NUL
bcdedit /set useplatformclock false > NUL 2>&1
bcdedit /set disabledynamictick yes > NUL 2>&1
%Konum%\Bin\DevManView.exe /disable "High Precision Event Timer"
:: -------------------------------------------------------------
FOR /F "tokens=4" %%a in ('systeminfo ^| find "Total Physical Memory"') do (
	FOR /F "delims=. tokens=1" %%b in ('echo %%a') do (
		set /a RAM=%%b * 1024 * 1024 + 1024000
	)
)
Call :RegAdd "HKLM\System\CurrentControlSet\Control" "SvcHostSplitThresholdInKB" REG_DWORD "0x%RAM%"
:: -------------------------------------------------------------
Call :Powershell "Expand-Archive -Force '%Konum%\Bin\Mouse.zip' '%Temp%\MouseLightPerf'"
RunDll32 advpack.dll,LaunchINFSection %Temp%\MouseLightPerf\Install.inf,DefaultInstall
:: -------------------------------------------------------------
net stop wuauserv > NUL 2>&1
Call :RD "%windir%\SoftwareDistribution"
net start wuauserv > NUL 2>&1
gpupdate /force > NUL 2>&1
shutdown -r -f -t 5
goto Main_Menu

:Reg01
if !Value! EQU E (set VR=1)
if !Value! EQU D (set VR=0)
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Power" "HibernateEnabled" REG_DWORD !VR!
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" "HiberbootEnabled" REG_DWORD !VR!
goto :eof