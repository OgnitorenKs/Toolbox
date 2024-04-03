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
:: Girdileri gizlemek için
echo off
REM Türkçe karakterler ve ► • gibi semboller için gerekli.
chcp 65001 > NUL 2>&1
REM For döngüleri içinde değişken kullanımı için gerekli
setlocal enabledelayedexpansion
REM Başlık
title 🤖 OgnitorenKs Toolbox 🤖
REM Toolbox versiyon
set Version=4.2.8
REM Pencere ayarı
mode con cols=100 lines=23

REM -------------------------------------------------------------
REM Renklendirm için gerekli
FOR /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E#&for %%b in (1) do rem"') do (set R=%%b)

REM -------------------------------------------------------------
Call :Ogni_Label
REM -------------------------------------------------------------
REM Toolbox konumunu değişkene tanımlar
cd /d "%~dp0"
FOR /F "tokens=*" %%a in ('cd') do (set Konum=%%a)
REM Değişkenler
set NSudo="%Konum%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c
REM Log klasörünü oluşturur
MD "%Konum%\Log" > NUL 2>&1
REM Hata mesajlarında olası kapanmaları önler
set Error=NT
REM Kullanıcı sid bilgisini alır
Call :CurrentUserName

REM -------------------------------------------------------------
REM Yönetici yetkisi
reg query "HKU\S-1-5-19" > NUL 2>&1
	if !errorlevel! NEQ 0 (Call :Powershell "Start-Process '%Konum%\OgnitorenKs.Toolbox.cmd' -Verb Runas"&exit)

REM -------------------------------------------------------------
REM Settings.ini dosyası içine dil bilgisi kayıtlı ise onu alır. Yok ise sistem varsayılan diline göre atama yapar.
Call :Default_System_Language
Findstr /i "Language_Pack" %Konum%\Settings.ini > NUL 2>&1
	if !errorlevel! NEQ 0 (if "!DefaultLang!" EQU "tr-TR" (echo. >> %Konum%\Settings.ini
														   echo ► Language_Pack^= Turkish >> %Konum%\Settings.ini
														   set Dil=%Konum%\Bin\Language\Turkish.cmd
														  )
						   if "!DefaultLang!" NEQ "tr-TR" (echo. >> %Konum%\Settings.ini
														   echo ► Language_Pack= English >> %Konum%\Settings.ini
														   set Dil=%Konum%\Bin\Language\English.cmd
														  ) 
						  )
	if !errorlevel! EQU 0 (FOR /F "tokens=3" %%a in ('Findstr /i "Language_Pack" %Konum%\Settings.ini') do (set Dil=%Konum%\Bin\Language\%%a.cmd))
REM -------------------------------------------------------------
REM Klasör yolunda Türkçe karakter kontrolü yapar
FOR %%a in (Ö ö Ü ü Ğ ğ Ş ş Ç ç ı İ) do (
	echo %Konum% | Find "%%a" > NUL 2>&1
		if !errorlevel! EQU 0 (cls&Call :Dil A 2 Error_1_&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 5&exit)
)
REM Klasör yolunda boşluk olup olmadığını kontrol eder
if "%Konum%" NEQ "%Konum: =%" (cls&Call :Dil A 2 Error_2_&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 5&exit)

REM -------------------------------------------------------------
REM Sistem mimari kontrolü
FOR /F "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE" 2^>NUL') do (
	if %%a NEQ AMD64 (cls&Call :Dil A 2 Error_3_&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 5&exit)
)
REM Sistem bilgileri
Call :Powershell "Get-CimInstance Win32_OperatingSystem | Select-Object Caption,InstallDate,OSArchitecture,RegisteredUser,CSName | FL" > %Konum%\Log\OS
FOR /F "tokens=5" %%a in ('Findstr /i "Caption" %Konum%\Log\OS') do set Win=%%a

REM -------------------------------------------------------------
:Kontrol
REM İnternet bağlantı durumunu kontrol ediyorum
Call :Check_Internet
	if "%Internet%" EQU "Offline" (goto Main_Menu)
REM -------------------------------------------------------------
REM Toolbox güncelleştirme bölümü
REM Github reposundan indirdiğim Link.txt dosyası içnideki version ile toolbox versiyonunu karşılaştırıyorum. Farklı ise güncel sürümü indiriyorum.
FOR /F "tokens=2" %%a in ('Findstr /i "Setting_1_" %Konum%\Settings.ini') do (
	if %%a EQU 0 (Call :Link 4&Call :PSDownload "%Konum%\Bin\Extra\Link.txt"
				  FOR /F "delims=> tokens=2" %%b in ('Findstr /i "Toolbox.Version." %Konum%\Bin\Extra\Link.txt') do (
					if "!Version!" NEQ "%%b" (cls&Call :Dil A 2 T0022&echo.&echo %R%[92m !LA2! %R%[0m
											  Call :Dil A 2 T0023&echo.&echo %R%[33m !LA2! %R%[90m=%R%[37m !Version! %R%[0m
											  Call :Dil A 2 T0024&echo %R%[33m !LA2! %R%[90m=%R%[37m %%b %R%[0m
											  Call :Bekle 5
											  Call :Link 3&Call :PSDownload "%Temp%\ToolboxUpdate.cmd"
											  Call :Powershell "Start-Process '%Temp%\ToolboxUpdate.cmd'"
											  exit
			)
		)
	)
)
REM ██████████████████████████████████████████████████████████████████
:Main_Menu
set PB_Version=
REM Regedit bölümünde yapılan işlemlerin gösterilip gösterilmeyeceğini belirler. 1 gösterir. 0 göstermez
REM Playbook bölümünde ayarları göstermek için bu değişkeni 0 olarak ayarlıyorum. Burada daha düzgün bir arayüz için regedit kayıtlarını uygularken göstermiyorum.
set Show=0
REM Sistem hakkında bilgi alınır. Ana menüde gösterilir.
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
title           O  G  N  I  T  O  R  E  N  K  S     ^|  🤖  OGNITORENKS TOOLBOX  🤖  ^|       T   O   O   L   B   O   X
echo    %R%[90mAMD64                                                                               %DateDay%%R%[0m
echo    %R%[90m████ ████ █   █ ███ █████ ████ ████ ███ █   █ █  █ ████    %R%[90m█████ ████ ████ █   ███  ████ █   █%R%[0m
echo    %R%[90m█  █ █    ██  █  █    █   █  █ █  █ █   ██  █ █ █  █       %R%[90m  █   █  █ █  █ █   █  █ █  █  █ █ %R%[0m
echo    %R%[90m█  █ █ ██ █ █ █  █    █   █  █ ████ ██  █ █ █ ██   ████    %R%[90m  █   █  █ █  █ █   ███  █  █   █  %R%[0m
echo    %R%[90m█  █ █  █ █  ██  █    █   █  █ █ █  █   █  ██ █ █     █    %R%[90m  █   █  █ █  █ █   █  █ █  █  █ █ %R%[0m
echo    %R%[90m████ ████ █   █ ███   █   ████ █  █ ███ █   █ █  █ ████    %R%[90m  █   ████ ████ ███ ███  ████ █   █%R%[0m
echo    %R%[90mhttps://ognitorenks.blogspot.com                                                         %R%[90m%version%%R%[0m
echo.
echo       %R%[90m %Value2%: %Value1% ^| %Value4% ^| %Value3%%R%[0m
FOR /L %%a in (1,1,4) do (set Value%%a=)
Call %Dil% :Menu_1_%Win%
Call :Dil A 2 D0001&set /p Value_M=%R%[32m        !LA2!: %R%[0m
Call :Upper !Value_M! Value_M
title 🤖 OgnitorenKs Toolbox 🤖
	if "!Value_M!" EQU "1" (goto Software_Installer)
	if "!Value_M!" EQU "2" (goto Service_Menu)
	if "!Value_M!" EQU "3" (goto Features_Warning)
	if "!Value_M!" EQU "4" (goto Oto_Kapat)
	if "!Value_M!" EQU "5" (goto Ping_Metre)
	if "!Value_M!" EQU "6" (goto User_Licence_Manager)
	if "!Value_M!" EQU "7" (goto Sistem_Bilgi)
	if "!Value_M!" EQU "8" (goto Wifi_Info)
	if "!Value_M!" EQU "9" (Call :Cleaner)
	if "!Value_M!" EQU "10" (Call :Windows_Repair)
	if "!Value_M!" EQU "11" (goto Playbook_Manager)
	if "!Value_M!" EQU "Z" (goto Language_Select)
	if "!Value_M!" EQU "X" (exit)
	if "!Error!" EQU "X" (goto Main_Menu)
Call :ProcessCompleted
goto Main_Menu

REM -------------------------------------------------------------
:Software_Installer
mode con cols=98 lines=38
REM Winget sistemini kontrol eder
Call :Dil A 2 T0013&echo.&echo %R%[92m !LA2! %R%[0m
Winget show "Google.Chrome" --accept-source-agreements > NUL 2>&1
	if "!errorlevel!" NEQ "0" (Call :Dil A 2 Error_4_
							   Call :Dil B 2 Error_5_
							   echo.&echo %R%[31m !LA2! %R%[0m
							   echo.&echo %R%[31m !LB2! %R%[0m
							   Call :Bekle 10&goto Main_Menu
)
:Jump_1
cls
REM Dil dosyasından ilgili bölüm çağırılır
Call %Dil% :Menu_2
REM Boş değişken kullanımında toolbox kapanacağı için değişkeni geçersiz bir değer ile dolduruyoruz.
set Value_M=NT
Call :Dil A 2 D0002&set /p Value_M=%R%[32m  !LA2! %R%[90mx,y: %R%[0m
REM Kullanıcının girdiği veriyi büyük harfe dönüştürüyorum.
Call :Upper %Value_M% Value_M
REM Alt bölümde yönlendirmeleri yapıyorum.
echo %Value_M% | Findstr /i "X" > NUL 2>&1
	if !errorlevel! EQU 0 (goto Main_Menu)
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
	if %%a EQU 20 (Call :Winget Maxthon.Maxthon)
	if %%a EQU 21 (Call :Winget Opera.Opera)
	if %%a EQU 22 (Call :Winget Opera.OperaGX)
	if %%a EQU 23 (Call :Winget Mozilla.Firefox)
	if %%a EQU 24 (Call :Winget LibreWolf.LibreWolf)
	if %%a EQU 25 (Call :Winget TorProject.TorBrowser)
	if %%a EQU 26 (Call :Winget KDE.Kdenlive)
	if %%a EQU 27 (Call :Winget OpenShot.OpenShot)
	if %%a EQU 28 (Call :Winget Meltytech.Shotcut)
	if %%a EQU 29 (Call :Winget KDE.Krita)
	if %%a EQU 30 (Call :Winget GIMP.GIM)
	if %%a EQU 31 (Call :Jpegview_Default&Call :Winget sylikc.JPEGView)
	if %%a EQU 32 (Call :Winget OBSProject.OBSStudio)
	if %%a EQU 33 (Call :Winget ShareX.ShareX)
	if %%a EQU 34 (Call :Winget Skillbrains.Lightshot)
	if %%a EQU 35 (Call :Winget Audacity.Audacity)
	if %%a EQU 36 (Call :Winget HandBrake.HandBrake)
	if %%a EQU 37 (Call :Winget AdrienAllard.FileConverter)
	if %%a EQU 38 (Call :Winget CodecGuide.K-LiteCodecPack.Mega)
	if %%a EQU 39 (Call :Winget VideoLAN.VLC)
	if %%a EQU 40 (Call :Winget Daum.PotPlayer)
	if %%a EQU 41 (Call :Winget Spotify.Spotify)
	if %%a EQU 42 (Call :Winget SoftDeluxe.FreeDownloadManager)
	if %%a EQU 43 (Call :Winget subhra74.XtremeDownloadManager)
	if %%a EQU 44 (Call :Winget qBittorrent.qBittorrent)
	if %%a EQU 45 (Call :Winget TheDocumentFoundation.LibreOffice)
	if %%a EQU 46 (Call :Winget ONLYOFFICE.DesktopEditors)
	if %%a EQU 47 (Call :Winget Adobe.Acrobat.Reader.64-bit)
	if %%a EQU 48 (Call :Winget TrackerSoftware.PDF-XChangeEditor)
	if %%a EQU 49 (Call :Winget calibre.calibre)
	if %%a EQU 50 (Call :Winget Notepad++.Notepad++)
	if %%a EQU 51 (Call :Winget Microsoft.VisualStudioCode)
	if %%a EQU 52 (Call :Winget GitHub.GitHubDesktop)
	if %%a EQU 53 (Call :Winget Git.Git)
	if %%a EQU 54 (Call :Winget OpenJS.NodeJS)
	if %%a EQU 55 (Call :Winget Unity.UnityHub)
	if %%a EQU 56 (Call :Winget BlenderFoundation.Blender)
	if %%a EQU 57 (Call :Winget IObit.IObitUnlocker)
	if %%a EQU 58 (Call :Winget RevoUninstaller.RevoUninstaller)
	if %%a EQU 59 (Call :7Zip_Default&Call :Winget 7zip.7zip)
	if %%a EQU 60 (Call :Winget Open-Shell.Open-Shell-Menu)
	if %%a EQU 61 (Call :Winget AnyDeskSoftwareGmbH.AnyDesk)
	if %%a EQU 62 (Call :Winget Henry++.MemReduct)
	if %%a EQU 63 (Call :Winget Guru3D.Afterburner)
	if %%a EQU 64 (Call :Winget LogMeIn.Hamachi)
	if %%a EQU 65 (Call :Winget GlassWire.GlassWire)
	if %%a EQU 66 (Call :Winget Safing.Portmaster)
	if %%a EQU 67 (Call :Winget voidtools.Everything)
	if %%a EQU 68 (Call :Winget Flow-Launcher.Flow-Launcher)
	if %%a EQU 69 (Call :Winget Stremio.Stremio)
)
goto Jump_1
REM -------------------------------------------------------------
:AIO.Runtimes
cls&Call :Dil B 2 T0018&echo %R%[32m !LB2! %R%[0m
REM Dism üzerinden sistem componentleri hakkında bilgi alıyorum.
Dism /Online /Get-Capabilities /format:table > %Konum%\Log\Capabilities
Dism /Online /Get-Features /format:table > %Konum%\Log\Features
REM Netframework 3.5'in yüklü olup olmadığını kontrol eder. Yüklü değil ise yükler
FOR /F "tokens=3" %%g in ('Findstr /C:"NetFX3~~~~" %Konum%\Log\Capabilities') do (
	echo %%g | Findstr /C:"Installed" > NUL 2>&1
		if !errorlevel! NEQ 0 (Call :Dil B 2 T0019&echo %R%[92m !LB2! %R%[0m
							   Dism /Online /Enable-Feature /Featurename:NetFx3 /All /NoRestart)
)
REM Netframework 4.5'in yüklü olup olmadığını kontrol eder. Yüklü değil ise yükler
FOR /F "tokens=3" %%g in ('findstr /C:"IIS-ASPNET45" %Konum%\Log\Features') do (
	echo %%g | Findstr /C:"Enabled" > NUL 2>&1
		if !errorlevel! NEQ 0 (Call :Dil B 2 T0020&echo %R%[92m !LB2! %R%[0m
							   Dism /Online /Enable-Feature /FeatureName:IIS-ASPNET45 /All /NoRestart)
)
REM DirectPlay'in yüklü olup olmadığını kontrol eder. Yüklü değil ise yükler
FOR /F "tokens=3" %%g in ('findstr /C:"DirectPlay" %Konum%\Log\Features') do (
	echo %%g | Findstr /C:"Enabled" > NUL 2>&1
		if !errorlevel! NEQ 0 (Call :Dil B 2 T0021&echo %R%[92m !LB2! %R%[0m
							   Dism /Online /Enable-Feature /FeatureName:DirectPlay /All /NoRestart)
)
REM Winget üzerinden All in One Runtimes bileşenlerinin tamamını indirir ve yükler
Call :Dil B 2 T0018
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
Microsoft.DotNet.DesktopRuntime.8
Microsoft.DirectX
) do (
	cls
	Call :Echo_Print %R%[32m !LB2! %R%[0m
	Call :Winget %%g
)
REM Loglar silinir
FOR %%g in (Capabilities Features) do (Call :DEL_Direct "%Konum%\Log\%%g")
goto :eof

REM -------------------------------------------------------------
:Service_Menu
REM mode con cols=130 lines=39
mode con cols=130 lines=50
Call :DEL_Direct "%Konum%\Log\Services.txt"
REM Servis menüsünün yönetimi hakkındaki bilgileri dil dosyasından çeker
echo.
Call :Dil A 2 B0001
Call :Dil B 2 T0004
Call :Dil B 3 T0004
Call :Dil C 2 T0005
echo %R%[91m  ► !LA2! %R%[90m [ E: !LB2! │ D: !LB3! │ !LC2!: E,1,4,5,D,6,10,14 ]%R%[0m
Call :Dil A 2 T0010
Call :Dil A 3 T0010
Call :Dil A 4 T0010
Call :Dil A 5 T0010
Call :Dil A 6 T0010
Call :Dil A 7 T0010
Call :Dil A 8 T0010
echo %R%[92m  ♦%R%[90m = !LA2! │ █ = !LA3! │%R%[91m █%R%[90m = !LA4! │%R%[96m ♦%R%[90m = !LA5! [!LA6!]%R%[0m 
echo %R%[91m  ♦%R%[90m = !LA5! [!LA7!] │%R%[95m ♦%R%[90m = !LA5! [!LA8!]%R%[0m
REM Dil değişkenleri çok olduğu için kullanım sonrası içlerini boşaltıyoruz.
FOR %%a in (LA2 LA3 LA4 LA5 LA6 LA7 LA8 LB2 LB3 LC2) do (set %%a=)
REM Dil dosyasından hizmet verilerini alarak kontrolleri sağlıyoruz.
echo   %R%[90m┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐%R%[0m
FOR /L %%a in (1,1,40) do (
	Call :Dil A 2 SL_%%a_
	Call :Dil A 3 SL_%%a_
	Call :Service_Check %%a
	if %%a LSS 10 (echo  %R%[32m    %%a%R%[90m-%R%[0m !Check!%R%[33m !LA2!%R%[90m !LA3! %R%[0m)
	if %%a GEQ 10 (echo  %R%[32m   %%a%R%[90m-%R%[0m !Check!%R%[33m !LA2!%R%[90m !LA3! %R%[0m)
)
Call :Dil A 2 T0006&echo  %R%[32m    X%R%[90m-%R%[37m   !LA2!%R%[0m
REM Değişkenlerin içini boşaltıyoruz.
FOR %%a in (LA2 LA3) do (set %%a=)
echo   %R%[90m└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘%R%[0m
Call :Dil A 2 D0002&set /p Value_S=%R%[92m   !LA2! %R%[90m[E,1,2,3,D,6,7,8] : %R%[0m
REM Kullanıcının girdiği veriyi büyük harf olarak düzenliyorum.
Call :Upper "%Value_S%" Value_S
REM Yönlendirmeleri yapıyorum.
echo !Value_S! | Findstr /i "X" > NUL 2>&1
	if !errorlevel! EQU 0 (set Error=X&goto Main_Menu)
cls
FOR %%a in (!Value_S!) do (
	Call :Service_Management %%a
	if %%a EQU 16 (Call :SS_16)
	if %%a EQU 29 (Call :SS_29)
)
REM İşlem bitince menüye gönderiyorum.
goto Service_Menu

REM -------------------------------------------------------------
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
FOR %%g in (C_Packages C_Capabilities) do (Call :DEL_Direct "%Konum%\Log\%%g")
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
REM Check_!Value_C! başlıklarındaki değişkeni temizlemek için
set PB_Check=
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

REM -------------------------------------------------------------
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

REM -------------------------------------------------------------
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
echo  %R%[90m•%R%[33m     Claudflare %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS ► [%R%[33m1.1.1.1 %R%[90m│%R%[33m 1.0.0.1%R%[90m]%R%[0m
Call :Ping_M1 8.8.8.8
Call :Ping_M2 8.8.4.4
echo  %R%[90m•%R%[33m         Google %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS ► [%R%[33m8.8.8.8 %R%[90m│%R%[33m 8.8.4.4%R%[90m]%R%[0m
Call :Ping_M1 9.9.9.9
Call :Ping_M2 149.112.112.112
echo  %R%[90m•%R%[33m          Quad9 %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS ► [%R%[33m9.9.9.9 %R%[90m│%R%[33m 149.112.112.112%R%[90m]%R%[0m
Call :Ping_M1 208.67.222.222
Call :Ping_M2 208.67.220.220
echo  %R%[90m•%R%[33m        OpenDNS %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS ► [%R%[33m208.67.222.222 %R%[90m│%R%[33m 208.67.220.220%R%[90m]%R%[0m
Call :Ping_M1 156.154.70.2
Call :Ping_M2 156.154.71.2
echo  %R%[90m•%R%[33m UltraRecursive %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS ► [%R%[33m156.154.70.2 %R%[90m│%R%[33m 156.154.71.2%R%[90m]%R%[0m
Call :Ping_M1 94.140.14.14
Call :Ping_M2 94.140.15.15
echo  %R%[90m•%R%[33m        Adguard %R%[90m=%R%[37m !Value_M1! %R%[90m│%R%[37m !Value_M2! %R%[90mMS ► [%R%[33m94.140.14.14 %R%[90m│%R%[33m 94.140.15.15%R%[90m]%R%[0m
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

REM -------------------------------------------------------------
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

REM -------------------------------------------------------------
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

REM -------------------------------------------------------------
:Cleaner
cls
Call :Dil A 2 B0006&title !LA2!
set Show=1
REM Çöp dosyaları temizleme komutları
ie4uinit.exe -show
ie4uinit.exe -ClearIconCache
Call :ExplorerResetAsk
	if "!Explorer_Reset!" EQU "0" (taskkill /f /im explorer.exe > NUL 2>&1)
Call :DEL_Direct "%LocalAppData%\IconCache.db"
Call :DEL_Search "%LocalAppData%\Microsoft\Windows\Explorer\*"
Call :DEL_Search "%LocalAppData%\Microsoft\Windows\Explorer\IconCacheToDelete\*"
Call :DEL_Search "%LocalAppData%\Microsoft\Windows\Explorer\NotifyIcon\*"
Call :DEL_Search "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
Call :RD_Direct "%LocalAppData%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\AppIconCache"
MD "%LocalAppData%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\AppIconCache" > NUL 2>&1
Call :DEL_Search "%LocalAppData%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\TempState\*"
Call :RegDel "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams
Call :RegDel "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream
	if "!Explorer_Reset!" EQU "0" (Call :Powershell "Start-Process '%Windir%\explorer.exe'")
REM Temp klasörlerini temizler
Call :DEL_Search "%temp%\*"
Call :RD_Search "%temp%\*"
Call :DEL_Search "%Windir%\Temp\*"
Call :RD_Search "%Windir%\Temp\*"
Call :DEL_Search "%LocalAppData%\Temp\*"
Call :RD_Search "%LocalAppData%\Temp\*"
REM Sistem içerisindeki gereksiz log dosyalarını temizler
Call :RD_Search "%Windir%\System32\config\systemprofile\AppData\Local\*.tmp"
Call :DEL_Deep_Search "%systemdrive%\*log"
Call :DEL_Deep_Search "%Windir%\*etl"
Call :DEL_Deep_Search "%LocalAppData%\*etl"
Call :RD_Search "%Windir%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*"
Call :DEL_Search "%Windir%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*"
Call :RD_Direct "%Windir%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache"
Call :DEL_Search "%windir%\prefetch\*"
REM Telemetri dosyalarını temziler
Call :DEL_Search "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\*.etl"
REM Windows'un oluşturduğu gereksiz boş klasörleri temizler
FOR /F %%a in ('dir /b "%LocalAppData%\tw-*.tmp"') do (Call :RD_Direct "%LocalAppData%\%%a")
REM Sistem üzerinde oluşan gereksiz log dosyalarını temizler
Call :DEL_Direct "%SystemRoot%\DtcInstall.log"
Call :DEL_Direct "%SystemRoot%\comsetup.log"
Call :DEL_Direct "%SystemRoot%\PFRO.log"
Call :DEL_Direct "%SystemRoot%\setupact.log"
Call :DEL_Direct "%SystemRoot%\setupapi.log"
Call :DEL_Direct "%SystemRoot%\Panther\*"
Call :DEL_Direct "%SystemRoot%\inf\setupapi.app.log"
Call :DEL_Direct "%SystemRoot%\inf\setupapi.dev.log"
Call :DEL_Direct "%SystemRoot%\inf\setupapi.offline.log"
Call :DEL_Direct "%SystemRoot%\Performance\WinSAT\winsat.log"
Call :DEL_Direct "%SystemRoot%\debug\PASSWD.LOG"
Call :DEL_Search "%localappdata%\Microsoft\Windows\WebCache\*.*"
Call :DEL_Search "%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp\*.*"
Call :DEL_Direct "%SystemRoot%\Logs\CBS\CBS.log"
Call :DEL_Direct "%SystemRoot%\Logs\DISM\DISM.log"
Call :DEL_Search "%SystemRoot%\Logs\SIH\*"
Call :DEL_Search "%LocalAppData%\Microsoft\CLR_v4.0\UsageTraces\*"
Call :DEL_Search "%LocalAppData%\Microsoft\CLR_v4.0_32\UsageTraces\*"
Call :DEL_Search "%SystemRoot%\Logs\NetSetup\*"
Call :DEL_Search "%SystemRoot%\System32\LogFiles\setupcln\*"
Call :DEL_Search "%SystemRoot%\Temp\CBS\*"
Call :DEL_Direct "%SystemRoot%\System32\catroot2\dberr.txt"
Call :DEL_Direct "%SystemRoot%\System32\catroot2.log"
Call :DEL_Direct "%SystemRoot%\System32\catroot2.jrs"
Call :DEL_Direct "%SystemRoot%\System32\catroot2.edb"
Call :DEL_Direct "%SystemRoot%\System32\catroot2.chk"
Call :DEL_Search "%SystemRoot%\Logs\SIH\*"
Call :DEL_Search "%SystemRoot%\Traces\WindowsUpdate\*"
Call :RD_Direct "%SystemRoot%\Logs\waasmedic"
REM Windows hata bildirimi
Call :RD_Direct "%ProgramData%\Microsoft\Windows\WER\ReportArchive"
Call :RD_Direct "%ProgramData%\Microsoft\Windows\WER\Temp"
REM Windows günlüğü
Call :DEL_Search "%Windir%\System32\LogFiles\WMI\*"
Call :DEL_Search "%Windir%\System32\LogFiles\Scm\*"
REM Net makine kodu önbelleği
Call :RD_Search "%Windir%\assembly\NativeImage*"
REM Winget artıklarını siler
Call :RD_Direct "%ProgramData%\Package Cache"
FOR %%g in (msi msp) do (Call :DEL_Deep_Search "%Windir%\Installer\*.%%g")
Call :DEL_Deep_Search "%Windir%\Installer\SourceHash*"
Call :RD_Search "%Windir%\Installer\$PatchCache$\Managed\*"
REM Ekran kartı kurulum dosyaları
Call :RD_Direct "%systemdrive%\AMD"
Call :RD_Direct "%systemdrive%\NVIDIA"
Call :RD_Direct "%systemdrive%\INTEL"
REM WinINet Web önbelleği
FOR /F "tokens=*" %%a in ('dir /ad /b "%LocalAppData%\Packages\*" 2^>NUL') do (
	Call :RD_Direct "%LocalAppData%\Packages\%%a\AC\INetCache"
	Call :RD_Direct "%LocalAppData%\Packages\%%a\AC\Temp"
)
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\INetCache\IE"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\INetCache\Low"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\INetCache\Virtualized"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\IE"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\Low"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\Virtualized"
Call :RD_Direct "%Windir%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\IE"
REM
Call :NET stop wuauserv
Call :RD_Direct "%windir%\SoftwareDistribution"
Call :NET start wuauserv
REM Call :Powershell "Start-Process cleanmgr -ArgumentList '/verylowdisk /sagerun:5'"
REM Çöp kutusunu temizler
Call :RD_Direct "C:\$Recycle.Bin\!CUS!"
REM DNS önbelleği temizler
Call :Dil A 2 T0030&echo ►%R%[32m !LA2! %R%[0m
ipconfig /flushdns > NUL 2>&1
ipconfig /release > NUL 2>&1
ipconfig /renew > NUL 2>&1
REM Olay günlüğü temizleniyor
Call :Dil A 2 T0017&echo ►%R%[32m !LA2! %R%[0m
FOR /F "tokens=*" %%g in ('wevtutil.exe el') do (wevtutil.exe cl "%%g" > NUL 2>&1)
REM Güncelleme artıklarını temizler
Call :Dil A 2 T0032&echo.&echo %R%[32m !LA2! %R%[0m
Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
set Show=0
goto :eof

REM -------------------------------------------------------------
:Windows_Repair
cls&Call :Cleaner&cls
Call :Dil A 2 B0007&echo.&echo %R%[93m !LA2! %R%[0m
title !LA2!
Call :Dil A 2 T0031&echo.&echo %R%[32m !LA2! %R%[0m
sfc /scannow
Call :Dil A 2 T0033&echo.&echo %R%[32m !LA2! %R%[0m
DISM /Online /Cleanup-Image /RestoreHealth
cls
Call :Dil A 2 B0007&echo.&echo %R%[93m !LA2! %R%[0m
Call :Dil A 2 T0034&echo.&echo %R%[32m !LA2! %R%[0m
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "RemoveWindowsStore" REG_DWORD "0"
REM BITS hizmeti varsayılan hale getiriliyor.
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode"
FOR %%a in (AppXSvc camsvc wuauserv StorSvc LicenseManager trustedinstaller ClipSVC UserDataSvc UnistoreSvc InstallService PushToInstall TimeBrokerSvc TokenBroker) do (
	Call :Service_Admin "%%a" 3
)
FOR %%a in (cryptsvc bits OneSyncSvc UsoSvc DoSvc) do (
	Call :Service_Admin "%%a" 2
)
FOR %%a in (WFDSConMgrSvc DevicesFlowUserSvc DevicePickerUserSvc ConsentUxUserSvc) do (
	Call :Service_Admin "%%a" 3
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
REM Call :CurrentUserName
REM Görev çubuğunda ekran tepsisi simgelerini açar
REM Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoTrayItemsDisplay"
REM Call :RegDel "HKU\!CUS!\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoTrayItemsDisplay"
REM CMD-Powershell sürekli yönetici çalışma sorununu giderir
REM Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "EnableLUA" REG_DWORD 1
set Error=NT
goto :eof

REM ██████████████████████████████████████████████████████████████████
:___HANGAR___
:Dil
REM Dil verilerini buradan alıyorum. Call komutu ile buraya uygun değerleri gönderiyorum.
REM %~1= Harf │ %~2= tokens değeri │ %~3= Find değeri
set L%~1%~2=
FOR /F "delims=> tokens=%~2" %%z in ('Findstr /i "%~3" %Dil% 2^>NUL') do (set L%~1%~2=%%z)
goto :eof

:Echo_Print
REM For döngüsü içinde renklendirme komutları hataya düşmemesi için bu bölüme yönlendirilir.
echo %*
goto :eof

REM -------------------------------------------------------------
:Date
REM Tarih bilgisi için
FOR /F "tokens=2" %%g in ('echo %date%') do set Date=%%g
set DateYear=%Date:~6%-%Date:~3,-5%-%Date:~0,-8%
set DateDay=%Date:~0,-8%.%Date:~3,-5%.%Date:~6%
goto :eof

REM -------------------------------------------------------------
:Time
REM Saat bilgisi için
FOR /F "tokens=1" %%g in ('echo %time%') do set Time=%%g
goto :eof

REM -------------------------------------------------------------
:Bekle
REM Timeout beklemeleri için
timeout /t %~1 /nobreak > NUL
goto :eof

REM -------------------------------------------------------------
:PSDownload
REM %~1= İndirme konumu
Call :Powershell "& { iwr %Link% -OutFile %~1 }"
goto :eof

REM -------------------------------------------------------------
:Winget
winget list "%~1" --accept-source-agreements > NUL 2>&1
	if "!errorlevel!" NEQ "0" (winget install -e --silent --force --accept-source-agreements --accept-package-agreements --id %~1
									if "!errorlevel!" NEQ "0" (cls&"%Konum%\Bin\NSudo.exe" -U:C -Wait cmd /c winget install -e --silent --force --accept-source-agreements --accept-package-agreements --id %~1)
	)
)
goto :eof

REM -------------------------------------------------------------
:Winget_Link
REM %~1 winget program adı
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %PB% 2^>NUL') do (
	set Silent=%%g
)
FOR /F "tokens=3" %%g in ('Winget show %~1 --accept-source-agreements ^| Find "Installer Url"') do (
	set Link=%%g
	set Setup=%%~nxg
)
goto :eof

REM -------------------------------------------------------------
:Link
set Link=
FOR /F "delims=> tokens=2" %%z in ('Findstr /i "Link_%~1_" %Konum%\Bin\Extra\Link.txt 2^>NUL') do (
	set Link=%%z
	set Setup=%%~nxz
)
goto :eof

REM -------------------------------------------------------------
:Powershell
REM chcp 65001 kullanıldığında Powershell komutları ekranı kompakt görünüme sokuyor. Bunu önlemek için bu bölümde uygun geçişi sağlıyorum.
chcp 437 > NUL 2>&1
Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C %*
chcp 65001 > NUL 2>&1
goto :eof

REM -------------------------------------------------------------
:Upper
REM Bu bölüme yönlendirdiğim kelimeleri büyük harf yaptırıyorum.
chcp 437 > NUL 2>&1
FOR /F %%g in ('Powershell -command "'%~1'.ToUpper()"') do (set %~2=%%g)
chcp 65001 > NUL 2>&1
goto :eof

REM -------------------------------------------------------------
:Sahip
takeown /f "%~1" > NUL 2>&1
icacls "%~1" /grant administrators:F > NUL 2>&1
goto :eof

REM -------------------------------------------------------------
:Uzunluk
REM %~1: Değişken değeri  %~2: Uzunluğu hesaplanacak olan değer
chcp 437 > NUL
FOR /F "tokens=*" %%a in ('Powershell -C "'%~2'.Length"') do (set Uzunluk%~1=%%a)
chcp 65001 > NUL
goto :eof

REM -------------------------------------------------------------
:Check_Internet
set Internet=Offline
FOR %%n in (
www.google.com
www.bing.com
github.com
) do (
	ping -n 1 %%n -w 1000 > NUL
		if !errorlevel! EQU 0 (set Internet=Online)
)
goto :eof

REM -------------------------------------------------------------
:Ping_M1
FOR /F "tokens=9" %%b in ('ping -n 1 %~1') do (set Value_M1=%%b)
set Value_M1=!Value_M1:~0,-2!
goto :eof

REM -------------------------------------------------------------
:Ping_M2
FOR /F "tokens=9" %%b in ('ping -n 1 %~1') do (set Value_M2=%%b)
set Value_M2=!Value_M2:~0,-2!
goto :eof

REM -------------------------------------------------------------
:ExplorerResetAsk
set Explorer_Reset=NT
set Value_Reset=NT
FOR /F "tokens=2" %%l in ('Findstr /i "Setting_2_" %Konum%\Settings.ini 2^>NUL') do (set Value_Reset=%%l)
	 if "!Value_Reset!" NEQ "0" (set Explorer_Reset=0
								 set Value_Reset=
								 goto :eof)
set Value_Reset=
Call :Dil A 2 D0008
echo.
set /p Value_Reset=►%R%[92m !LA2! %R%[90m[%R%[96m Y%R%[90m │%R%[96m N%R%[90m ]: %R%[0m
Call :Upper !Value_Reset! Value_Reset
	if "!Value_Reset!" EQU "Y" (set Explorer_Reset=0)
set Value_Reset=
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:RD_Direct
REM Klasör silmek için
if !Show! EQU 1 echo %R%[90m [RD_Direct]-%R%[33m[%~1]%R%[0m
RD /S /Q "%~1" > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% RD /S /Q "%~1")
set RemoveValue=
goto :eof

:RD_Search
REM Klasör silmek için (dizin aramalı)
FOR /F "tokens=*" %%v in ('Dir /AD /B "%~1" 2^>NUL') do (
	if !Show! EQU 1 echo %R%[90m [RD_Search]-%R%[33m [%~dp1%%v]%R%[0m
	RD /S /Q "%~dp1%%v" > NUL 2>&1
		if !errorlevel! NEQ 0 (%NSudo% RD /S /Q "%~dp1%%v")
)
goto :eof

:RD_Deep_Search
REM Klasör silmek için (derin aramalı)
FOR /F "tokens=*" %%v in ('Dir /AD /B /S "%~1" 2^>NUL') do (
	if !Show! EQU 1 echo %R%[90m [RD_Deep_Search]-%R%[33m [%%v]%R%[0m
	RD /S /Q "%%v" > NUL 2>&1
		if !errorlevel! NEQ 0 (%NSudo% RD /S /Q "%%v")
)
goto :eof

:DEL_Direct
REM Dosya silmek için
DEL /F /Q /A "%~1" > NUL 2>&1
	if !Show! EQU 1 echo %R%[90m [DEL_Direct]-%R%[33m [%~1]%R%[0m
	if !errorlevel! NEQ 0 (%NSudo% DEL /F /Q /A "%~1")
goto :eof

:DEL_Search
REM Dosya silmek için (dizin aramalı)
FOR /F "tokens=*" %%v in ('Dir /A-D /B "%~1" 2^>NUL') do (
	if !Show! EQU 1 echo %R%[90m [DEL_Search]-%R%[33m [%~dp1%%v]%R%[0m
	DEL /F /Q /A "%~dp1%%v" > NUL 2>&1
		if !errorlevel! NEQ 0 (%NSudo% DEL /F /Q /A "%~dp1%%v")
)
goto :eof

:DEL_Deep_Search
REM Dosya silmek için (derin aramalı)
FOR /F "tokens=*" %%v in ('Dir /A-D /B /S "%~1" 2^>NUL') do (
	if !Show! EQU 1 echo %R%[90m [DEL_Deep_Search]-%R%[33m [%%v]%R%[0m
	DEL /F /Q /A "%%v" > NUL 2>&1
		if !errorlevel! NEQ 0 (%NSudo% DEL /F /Q /A "%%v")
)
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:CurrentUserName
Call :Powershell "Get-CimInstance -ClassName Win32_UserAccount | Select-Object -Property Name,SID" > %Konum%\Log\cusername
FOR /F "tokens=2" %%a in ('Find "%username%" %Konum%\Log\cusername') do set CUS=%%a
Call :DEL_Direct "%Konum%\Log\cusername"
goto :eof

REM -------------------------------------------------------------
:Default_System_Language
FOR /F "tokens=6" %%a in ('Dism /online /Get-intl ^| Find /I "Default system UI language"') do (set DefaultLang=%%a)
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Default_App
REM !Default!= Uzantıları içeren değişken
REM !AppKey!= Program adı
REM !AppIcon!= Uygulama simgesi
REM !AppRoad!= Uygulama .exe'sinin yüklü olduğu dizin
echo Windows Registry Editor Version 5.00 > %Konum%\DefaultApp.reg
echo. >> %Konum%\DefaultApp.reg
FOR %%g in (!Default!) do (
	echo [-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.%%g] >> %Konum%\DefaultApp.reg
	echo [-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\!AppKey!.%%g] >> %Konum%\DefaultApp.reg
	echo [-HKEY_CLASSES_ROOT\.%%g] >> %Konum%\DefaultApp.reg 
	echo [-HKEY_CLASSES_ROOT\!AppKey!.%%g] >> %Konum%\DefaultApp.reg
	echo [-HKEY_CURRENT_USER\Software\Classes\.%%g] >> %Konum%\DefaultApp.reg 
	echo [-HKEY_CURRENT_USER\Software\Classes\!AppKey!.%%g] >> %Konum%\DefaultApp.reg
	echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.%%g] >> %Konum%\DefaultApp.reg 
	echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\!AppKey!.%%g] >> %Konum%\DefaultApp.reg
)
regedit /s "%Konum%\DefaultApp.reg" > NUL 2>&1
Call :DEL_Direct "%Konum%\DefaultApp.reg"
FOR %%g in (!Default!) do (
	Call :RegDel "HKCR\.%%g"
	Call :RegDel "HKCR\!AppKey!.%%g"
	Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.%%g"
	Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\!AppKey!.%%g"
	Call :RegDel "HKCU\Software\Classes\.%%g"
	Call :RegDel "HKCU\Software\Classes\!AppKey!.%%g"
	Call :RegDel "HKLM\SOFTWARE\Classes\SystemFileAssociations\.%%g"
	Call :RegDel "HKLM\SOFTWARE\Classes\SystemFileAssociations\!AppKey!.%%g"
)
FOR %%g in (!Default!) do (
	reg add "HKCR\.%%g" /ve /t REG_SZ /d "!AppKey!.%%g" /f > NUL 2>&1
	reg add "HKCR\!AppKey!.%%g\DefaultIcon" /ve /t REG_SZ /d "!AppIcon!" /f > NUL 2>&1
	reg add "HKCR\!AppKey!.%%g\shell\open\command" /ve /t REG_SZ /d "\"!AppRoad!\" \"%%1\"" /f > NUL 2>&1
)
FOR %%g in (AppRoad AppIcon AppKey Default) do (set %%g=)
goto :eof

REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.%%g" /ve /t REG_SZ /d "!AppKey!.%%g" /f > NUL 2>&1
REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\!AppKey!.%%g\DefaultIcon" /ve /t REG_SZ /d "!AppIcon!" /f > NUL 2>&1
REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\!AppKey!.%%g\shell\open\command" /ve /t REG_SZ /d "\"!AppRoad!\" \"%%1\"" /f > NUL 2>&1
REM reg add "HKCU\Software\Classes\.%%g" /ve /t REG_SZ /d "!AppKey!.%%g" /f > NUL 2>&1
REM reg add "HKCU\Software\Classes\!AppKey!.%%g\DefaultIcon" /ve /t REG_SZ /d "!AppIcon!" /f > NUL 2>&1
REM reg add "HKCU\Software\Classes\!AppKey!.%%g\shell\open\command" /ve /t REG_SZ /d "\"!AppRoad!\" \"%%1\"" /f > NUL 2>&1
REM reg add "HKLM\SOFTWARE\Classes\SystemFileAssociations\.%%g" /ve /t REG_SZ /d "!AppKey!.%%g" /f > NUL 2>&1
REM reg add "HKLM\SOFTWARE\Classes\SystemFileAssociations\!AppKey!.%%g\DefaultIcon" /ve /t REG_SZ /d "!AppIcon!" /f > NUL 2>&1
REM reg add "HKLM\SOFTWARE\Classes\SystemFileAssociations\!AppKey!.%%g\shell\open\command" /ve /t REG_SZ /d "\"!AppRoad!\" \"%%1\"" /f > NUL 2>&1

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Service_Admin
reg query "HKLM\SYSTEM\CurrentControlSet\Services\%~1" /v "Start" > NUL 2>&1
	if !errorlevel! EQU 0 (if %~2 EQU 0 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 0
										 Call :SC_Config %~1 Boot&Call :NET start %~1
										)
						   if %~2 EQU 1 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 1
										 Call :SC_Config %~1 System&Call :NET start %~1
										)
						   if %~2 EQU 2 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 2
										 Call :SC_Config %~1 Auto&Call :NET start %~1
										)
						   if %~2 EQU 3 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 3
										 Call :SC_Config %~1 Demand&Call :NET start %~1
										)
						   if %~2 EQU 4 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 4
										 Call :SC_Config %~1 Disable&Call :NET stop %~1
										)
						   if %~2 EQU 6 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 4
										 Call :NET stop %~1&Call :SC_Remove %~1
										)
)
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Service_Check
REM Hizmetleri kontrol eder
set X=NT
set XT=NT
set XS=NT
echo -------------------------------------------- >> %Konum%\Log\Services.txt
if %Win% EQU 11 (set Value_W=0 11)
if %Win% EQU 10 (set Value_W=0 10)
FOR %%g in (!Value_W!) do (
	FOR /F "delims=> tokens=2" %%h in ('Findstr /i "_%%g_%~1_" %Konum%\Bin\Extra\Data.cmd') do (
		reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%h" /v "Start" > NUL 2>&1
			if !errorlevel! EQU 0 (FOR /F "skip=2 delims=x tokens=2" %%j in ('reg query "HKLM\System\CurrentControlSet\Services\%%h" /v "Start" 2^>NUL') do (
																			  echo [%%h] ► [%%j] >> %Konum%\Log\Services.txt
																			  if %%j EQU 4 (if !X! EQU ON (set XS=Off&set Check=%R%[96m♦%R%[0m)
																							if !X! EQU NT (set XS=Off&set Check=%R%[90m█%R%[0m)
																						   )
																			  if %%j EQU 3 (if !XT! EQU Lost (if !XS! EQU Off (set Check=%R%[95m♦%R%[0m)
																											  if !XS! EQU NT (set Check=%R%[91m♦%R%[0m)
																											 )
																							if !XT! NEQ Lost (if !XS! EQU Off (set X=ON&set Check=%R%[96m♦%R%[0m)
																											  if !XS! EQU NT (set X=ON&set Check=%R%[92m♦%R%[0m)
																											 )
																						   )
																			  if %%j EQU 2 (if !XT! EQU Lost (if !XS! EQU Off (set Check=%R%[95m♦%R%[0m)
																											  if !XS! EQU NT (set Check=%R%[91m♦%R%[0m)
																											 )
																							if !XT! NEQ Lost (if !XS! EQU Off (set X=ON&set Check=%R%[96m♦%R%[0m)
																											  if !XS! EQU NT (set X=ON&set Check=%R%[92m♦%R%[0m)
																											 )
																						   )
																			  if %%j EQU 1 (if !XT! EQU Lost (if !XS! EQU Off (set Check=%R%[95m♦%R%[0m)
																											  if !XS! EQU NT (set Check=%R%[91m♦%R%[0m)
																											 )
																							if !XT! NEQ Lost (if !XS! EQU Off (set X=ON&set Check=%R%[96m♦%R%[0m)
																											  if !XS! EQU NT (set X=ON&set Check=%R%[92m♦%R%[0m)
																											 )
																						   )
																			  if %%j EQU 0 (if !XT! EQU Lost (if !XS! EQU Off (set Check=%R%[95m♦%R%[0m)
																											  if !XS! EQU NT (set Check=%R%[91m♦%R%[0m)
																											 )
																							if !XT! NEQ Lost (if !XS! EQU Off (set X=ON&set Check=%R%[96m♦%R%[0m)
																											  if !XS! EQU NT (set X=ON&set Check=%R%[92m♦%R%[0m)
																											 )
																						   )
																			)
								 )
			if !errorlevel! NEQ 0 (echo [%%h] ► [Not Found] >> %Konum%\Log\Services.txt
								   if !X! EQU ON (set XT=Lost&set Check=%R%[91m♦%R%[0m)
								   if !X! EQU NT (set XT=Lost&set Check=%R%[91m█%R%[0m)
								  )
	)
)
set X=
set XT=
set XS=
goto :eof

REM -------------------------------------------------------------
:Service_Management
if %Win% EQU 11 (set Value_W=0 11)
if %Win% EQU 10 (set Value_W=0 10)
if %~1 EQU E (set Value=E&Call :Dil B 2 T0001&goto :eof)
if %~1 EQU D (set Value=D&Call :Dil B 2 T0002&goto :eof)
Call :Dil A 2 SL_%~1_
echo %R%[96m "!LA2!" %R%[37m !LB2! %R%[0m
FOR %%j in (!Value_W!) do (
	FOR /F "delims=> tokens=2" %%g in ('Findstr /i "_%%j_%~1_" %Konum%\Bin\Extra\Data.cmd') do (
		reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%g" /v "Start" > NUL 2>&1
			if !errorlevel! EQU 0 (if !Value! EQU E (FOR /F "delims=> tokens=4" %%h in ('Findstr /i "%%g" %Konum%\Bin\Extra\Data.cmd') do (Call :Service_Admin "%%g" "%%h"))
								   if !Value! EQU D (Call :Service_Admin "%%g" "4")
		)
	)
)
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Read_Features
FOR /F "delims=> tokens=3" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (set Value_C=%%g)
goto :eof

REM -------------------------------------------------------------
:Check_Rename
REM Playbook bölümü için eklenmiştir.
REM Exe dosyasının adını değiştirerek devre dışı bıraktığım uygulamalar güncelleme sonrası yeniden yükleniyor.
REM Bunu önlemek için öncelikle adını değiştirdğim dosyayı kontrol ediyorum. Dosya var ise eski old isimli dosyayı silip yeni exe'ye old ekleyerek devre dışı bırakıyorum.
dir /b "%~1" > NUL 2>&1
	if "!errorlevel!" EQU "0" (%NSudo% DEL /F /Q /A "%~dp1%~n1_OLD%~x1")
goto :eof

REM -------------------------------------------------------------
:Check_Capability
set Check=%R%[90m█%R%[0m
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	Findstr /i "%%g" %Konum%\Log\C_Capabilities > NUL 2>&1
		if !errorlevel! EQU 0 (set Check=%R%[92m♦%R%[0m)
)
goto :eof

REM -------------------------------------------------------------
:Check_Package
set Check=%R%[90m█%R%[0m
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	Findstr /i "%%g" %Konum%\Log\C_Packages > NUL 2>&1
		if !errorlevel! EQU 0 (set Check=%R%[92m♦%R%[0m)
)
goto :eof

REM -------------------------------------------------------------
:Check_Component
set Check=%R%[90m█%R%[0m
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /f "%%g" > NUL 2>&1
		if !errorlevel! EQU 0 (set Check=%R%[92m♦%R%[0m)
)
goto :eof

REM -------------------------------------------------------------
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
			if !errorlevel! EQU 0 (Dism /Online /Remove-Package /PackageName:%%k /NoRestart > NUL 2>&1)
	)
)
goto :eof

REM -------------------------------------------------------------
:Remove_Capability
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	Findstr /i "%%g" %Konum%\Log\C_Capabilities > NUL 2>&1
		if !errorlevel! EQU 0 (FOR /F "tokens=1" %%k in ('Findstr /i "%%g" %Konum%\Log\C_Capabilities') do (Dism /Online /Remove-Capability /CapabilityName:%%k /NoRestart > NUL 2>&1))
)
goto :eof

REM -------------------------------------------------------------
:Remove_Package
FOR /F "delims=> tokens=2" %%g in ('Findstr /i "%~1" %Konum%\Bin\Extra\Data.cmd 2^>NUL') do (
	Findstr /i "%%g" %Konum%\Log\C_Packages > NUL 2>&1
		if !errorlevel! EQU 0 (FOR /F "tokens=1" %%k in ('Findstr /i "%%g" %Konum%\Log\C_Packages') do (Dism /Online /Remove-Package /PackageName:%%k /NoRestart > NUL 2>&1))
)
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Appx_Info
Call :Powershell "Get-AppxPackage -AllUsers | Select PackageFullName" > %Konum%\Log\Appx_Info1
Call :Powershell "Get-AppxPackage -AllUsers | Select PackageFamilyName" > %Konum%\Log\Appx_Info2
Call :Powershell "Get-AppxPackage -AllUsers | Select Name,PackageFamilyName" > %Konum%\Log\Appx_Info3
goto :eof

:NonRemoved
FOR /F "tokens=*" %%j in ('Findstr /i "%~1" %Konum%\Log\Appx_Info1') do (
	FOR /F "tokens=*" %%k in ('Findstr /i "%~1" %Konum%\Log\Appx_Info2') do (
		set NonRemove1=%%j
		set NonRemove2=%%k
		set NonRemove1=!NonRemove1: =!
		set NonRemove2=!NonRemove2: =!
		Call :RegKey "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%CUS%\!NonRemove1!"
		Call :RegKey "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\!NonRemove2!"
		Dism /Online /Set-NonRemovableapppolicy /Packagefamily:!NonRemove1! /Nonremovable:0 > NUL 2>&1
		"%Konum%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C "Remove-AppxPackage -Package '!NonRemove1!' -allusers"
		FOR /F "tokens=1" %%m in ('Findstr /i "!NonRemove2!" %Konum%\Log\Appx_Info3 2^>NUL') do (
			FOR /F "tokens=*" %%n in ('Dir /AD /B "%ProgramFiles%\WindowsApps\%%m*" 2^>NUL') do (
				echo Call :RD_Direct "%%ProgramFiles%%\WindowsApps\%%n" >> C:\Playbook.Reset.After.cmd
				%NSudo% RD /S /Q "%ProgramFiles%\WindowsApps\%%n"
			)
		)
		%NSudo% RD /S /Q "%Windir%\SystemApps\!NonRemove2!"
		echo Call :RD_Direct "%%Windir%%\SystemApps\!NonRemove2!" >> C:\Playbook.Reset.After.cmd
		set NonRemove1=
		set NonRemove2=
	)
)
FOR /F "tokens=*" %%v in ('dir /b "%Windir%\SystemApps\*%~1*" 2^>NUL') do (
	echo Call :RD_Direct "%%Windir%%\SystemApps\%%v" >> C:\Playbook.Reset.After.cmd
	%NSudo% RD /S /Q "%Windir%\SystemApps\%%v"
)
FOR /F "tokens=*" %%v in ('dir /b "%ProgramFiles%\WindowsApps\*%~1*" 2^>NUL') do (
	echo Call :RD_Direct "%%ProgramFiles%%\WindowsApps\%%v" >> C:\Playbook.Reset.After.cmd
	%NSudo% RD /S /Q "%ProgramFiles%\WindowsApps\%%v"
)
goto :eof
REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:RegKey
if !Show! EQU 1 (echo %R%[90mReg add%R%[33m "%~1"%R%[90m /f%R%[0m)
Reg add "%~1" /f > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /f)
goto :eof

REM -------------------------------------------------------------
:RegAdd
if !Show! EQU 1 (echo %R%[90mReg add%R%[33m "%~1"%R%[90m /f /v%R%[33m "%~2"%R%[90m /t%R%[33m %~3%R%[90m /d%R%[33m "%~4"%R%[0m)
Reg add "%~1" /f /v "%~2" /t %~3 /d "%~4" > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /f /v "%~2" /t %~3 /d "%~4")
goto :eof

REM -------------------------------------------------------------
:RegVeAdd
if !Show! EQU 1 (echo %R%[90mReg add%R%[33m "%~1"%R%[90m /f /ve /t%R%[33m %~2%R%[90m /d%R%[33m "%~3"%R%[0m)
Reg add "%~1" /ve /t %~2 /d "%~3" /f > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /f /ve /t %~2 /d "%~3")
goto :eof

REM -------------------------------------------------------------
:RegDel
if !Show! EQU 1 (echo %R%[90mReg delete%R%[33m %* %R%[90m /f%R%[0m)
Reg delete %* /f > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg delete %* /f)
goto :eof

REM -------------------------------------------------------------
:RegAdd_CCS
if !Show! EQU 1 (echo %R%[90mReg add%R%[33m "HKLM\SYSTEM\CurrentControlSet\%~1"%R%[90m /f /v%R%[33m "%~2"%R%[90m /t%R%[33m %~3%R%[90m /d%R%[33m "%~4" %R%[0m
				 echo %R%[90mReg add%R%[33m "HKLM\SYSTEM\ControlSet001\%~1"%R%[90m /f /v%R%[33m "%~2"%R%[90m /t%R%[33m %~3%R%[90m /d%R%[33m "%~4" %R%[0m
				 echo %R%[90mReg add%R%[33m "HKLM\SYSTEM\ControlSet002\%~1"%R%[90m /f /v%R%[33m "%~2"%R%[90m /t%R%[33m %~3%R%[90m /d%R%[33m "%~4" %R%[0m
)
Reg add "HKLM\SYSTEM\CurrentControlSet\%~1" /f /v "%~2" /t %~3 /d "%~4" > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "HKLM\SYSTEM\CurrentControlSet\%~1" /f /v "%~2" /t %~3 /d "%~4")
Reg add "HKLM\SYSTEM\ControlSet001\%~1" /f /v "%~2" /t %~3 /d "%~4" > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "HKLM\SYSTEM\ControlSet001\%~1" /f /v "%~2" /t %~3 /d "%~4")
Reg add "HKLM\SYSTEM\ControlSet002\%~1" /f /v "%~2" /t %~3 /d "%~4" > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% Reg add "HKLM\SYSTEM\ControlSet002\%~1" /f /v "%~2" /t %~3 /d "%~4")
goto :eof

REM -------------------------------------------------------------
:Reg_Hide
FOR /F "skip=2 tokens=3" %%x in ('Reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" 2^>NUL') do (set X_Value=%%x)
echo !X_Value! | Find "%~1" > NUL 2>&1
	if !errorlevel! EQU 0 (set X_Value=&goto :eof)
echo !X_Value! | Findstr /i "hide:" > NUL 2>&1
	if !errorlevel! EQU 0 (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "SettingsPageVisibility" REG_SZ "!X_Value!;%~1")
	if !errorlevel! NEQ 0 (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "SettingsPageVisibility" REG_SZ "hide:%~1")
set X_Value=
goto :eof

REM -------------------------------------------------------------
:SC_Config
REM %~1: Hizmet %~2: Hizmet çalışma değeri
sc config %~1 start= %~2 > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% sc config %~1 start= %~2)
goto :eof

REM -------------------------------------------------------------
:SC_Remove
REM %~1: Hizmet %~2: Hizmet çalışma değeri
sc delete %~1 > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% sc delete %~1)
goto :eof

REM -------------------------------------------------------------
:NET
REM %~1: start │ stop  %~2: Hizmet
net %~1 %~2 /y > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% net %~1 %~2 /y)
goto :eof

REM -------------------------------------------------------------
:Schtasks
schtasks /change /TN "%~2" /%~1 > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% schtasks /change /TN "%~2" /%~1)
goto :eof

REM -------------------------------------------------------------
:Schtasks-Remove
schtasks /Delete /TN "%~1" /F > NUL 2>&1
	if !errorlevel! NEQ 0 (%NSudo% schtasks /Delete /TN "%~1" /F)
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Playbook_Reader
Find "%~1" !PB! > NUL 2>&1
	if !errorlevel! NEQ 0 (set Playbook=0&goto :eof)
FOR /F "skip=2 tokens=2" %%p in ('Find "%~1" !PB! 2^>NUL') do (set Playbook=%%p)
echo [!Playbook!]-"%~1" >> %Konum%\Log\Playbook_Log.txt
goto :eof

REM -------------------------------------------------------------
:Playbook_Reader_2
Findstr /i "%~1" %PB% > NUL 2>&1
	if "!errorlevel!" EQU "0" (set Playbook=1)
	if "!errorlevel!" NEQ "0" (set Playbook=0)
goto :eof

REM -------------------------------------------------------------
:Playbook_Reader_Special
set PBSpecial=
FOR /F "skip=2 tokens=4" %%p in ('Find "%~1" !PB! 2^>NUL') do (set PBSpecial=%%p)
goto :eof

REM -------------------------------------------------------------
:Powershell_Playbook
REM chcp 65001 kullanıldığında Powershell komutları ekranı kompakt görünüme sokuyor. Bunu önlemek için bu bölümde uygun geçişi sağlıyorum.
chcp 437 > NUL 2>&1
Powershell %* > NUL 2>&1
chcp 65001 > NUL 2>&1
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Ram_Type
set Value_R=Unkown
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
if %~1 EQU 27 (set Value_R=DDR5)
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
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

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
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
REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Language_Select
cls
Call :DEL_Direct %Konum%\Log\Dil
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
	FOR /F "tokens=3" %%k in ('Findstr /i "Language_Pack" %Konum%\Settings.ini') do (
		set Dil=%Konum%\Bin\Language\%%g.cmd
		Call :Powershell "(Get-Content %Konum%\Settings.ini) | ForEach-Object { $_ -replace '%%k', '%%g' } | Set-Content '%Konum%\Settings.ini'"
	)
)
goto Main_Menu

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:___DEVELOPER__HANGAR___
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
REM ──────────────────────────────────────
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

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Playbook_Manager
cls
REM Winget sistemini kontrol eder
Call :Dil A 2 T0013&echo.&echo %R%[92m !LA2! %R%[0m
Winget show "Google.Chrome" --accept-source-agreements > NUL 2>&1
	if "!errorlevel!" NEQ "0" (Call :Dil A 2 Error_4_
							   Call :Dil B 2 Error_5_
							   echo.&echo %R%[31m !LA2! %R%[0m
							   echo.&echo %R%[31m !LB2! %R%[0m
							   Call :Bekle 10&goto Main_Menu
)
REM Playbook kütüphanesi kontrol edilir. Kalıp sayısına göre pencere ayarı yapılır. Yoksa ana menüye atar.
set Mode=8
set CTRL=0
dir /b "%Konum%\Bin\Playbook\*.ini" > NUL 2>&1
	if !errorlevel! EQU 0 (FOR /F "tokens=*" %%a in ('dir /b "%Konum%\Bin\Playbook\*.ini" 2^>NUL') do (
								set /a Mode+=1
								set /a CTRL+=1
								set PB=%Konum%\Bin\Playbook\%%a
						   )
						   mode con cols=110 lines=!Mode!
						  )
	if !errorlevel! NEQ 0 (Call :Dil A 2 Error_10_&echo %R%[91m !LA2! %R%[0m&Call :Bekle 7&goto Main_Menu)
REM -------------------------------------------------------------
REM Playbook dosyaları listelenir
Call :Dil A 2 B0008&cls&echo.&echo ►%R%[36m !LA2! %R%[0m
echo %R%[90m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬%R%[0m
Call :DEL_Direct "%Konum%\Log\Playbook"
Call :Dil A 2 T0006
if "!CTRL!" EQU "1" (set CTRL=&goto Pass_1)
set PB=
REM Kalıp dosyasından birden fazla dosya var ise burada listenecektir.
set Count=0
FOR /F "tokens=*" %%a in ('dir /b "%Konum%\Bin\Playbook\*.ini" 2^>NUL') do (
	set /a Count+=1
	echo PB_Index_!Count!_^>%Konum%\Bin\Playbook\%%a^> >> %Konum%\Log\Playbook
	if "!Count!" LEQ "9" (echo %R%[92m  !Count!%R%[90m-%R%[33m %%~na %R%[0m)
	if "!Count!" GTR "9" (echo %R%[92m !Count!%R%[90m-%R%[33m %%~na %R%[0m)
)
echo %R%[92m  X%R%[90m-%R%[37m !LA2! %R%[0m
echo %R%[90m▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬%R%[0m
set Version_K=
Call :Dil A 2 D0007&set /p Value_MM=►%R%[32m !LA2!: %R%[0m
Call :Upper !Value_MM! Value_MM
	if "!Value_MM!" EQU "X" (goto Main_Menu)
Findstr /i "PB_Index_!Value_MM!_" %Konum%\Log\Playbook > NUL 2>&1
	if !errorlevel! EQU 0 (FOR /F "delims=> tokens=2" %%a in ('Findstr /i "PB_Index_!Value_MM!_" %Konum%\Log\Playbook 2^>NUL') do (set PB=%%a))
Call :DEL_Direct "%Konum%\Log\Playbook"
REM -------------------------------------------------------------
:Pass_1
REM Uyarı ekranı
mode con cols=130 lines=35
Call :Dil A 2 B0008&echo.&echo %R%[36m► !LA2! %R%[0m
Call :Dil A 2 P4001&echo %R%[36m▼ !LA2! %R%[0m
Call :Dil A 2 P4002&echo.&echo  •%R%[33m !LA2! %R%[0m
Call :Dil A 2 P4003&echo  •%R%[33m !LA2! %R%[0m
Call :Dil A 2 P4004&echo  •%R%[33m !LA2! %R%[0m
echo.
Call :Dil A 2 P4005&echo  •%R%[33m !LA2! %R%[0m
Call :Dil A 2 P4006&echo  •%R%[33m !LA2! %R%[0m
Call :Powershell "Start-Process 'windowsdefender://ThreatSettings'" > NUL 2>&1
REM Boş tuşlama sonrası işleme devam etmemesi için
set Value_MM=N
Call :Dil A 2 P4007&echo.&set /p Value_MM=►%R%[32m !LA2!%R%[90m [%R%[36m Y%R%[90m │%R%[36m N%R%[90m ]: %R%[0m
Call :Upper !Value_MM! Value_MM
	if "!Value_MM!" EQU "N" (set Error=X&goto Main_Menu)
set Value_MM=
REM -------------------------------------------------------------
REM UAC kapatır
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "ConsentPromptBehaviorAdmin" REG_DWORD 0
REM Uygulama artıklarını silebilmek için WindowsApps klasürünün yetkisini alıyorum.
Call :Sahip "%ProgramFiles%\WindowsApps\*"
(
echo echo off
echo chcp 65001
echo setlocal enabledelayedexpansion
echo cls
echo title Temizlik işlemi yapılıyor. Lütfen bekleyin │ Cleaning is in progress. Please wait
echo.
echo reg query "HKU\S-1-5-19" ^> NUL 2^>^&1
echo    if %%errorlevel%% NEQ 0 ^(Call :Powershell "Start-Process '%%~f0' -Verb Runas"^&exit^)
echo.
echo set NSudo="%Konum%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c
echo.
echo goto Delete
echo.
echo :RD_Direct
echo echo [RD_Direct]-[%%~1]
echo %%NSudo%% RD /S /Q "%%~1"
echo goto :eof
echo.
echo :RD_Search
echo echo [RD_Search]-[%%~dp1%%%%g]
echo FOR /F "tokens=*" %%%%g in ^('Dir /AD /B "%%~1" 2^^^>NUL'^) do ^(
echo    echo [RD_Search]-[%%~dp1%%%%g]
echo    %%NSudo%% RD /S /Q "%%~dp1%%%%g"
echo ^)
echo goto :eof
echo.
echo :RD_Deep_Search
echo FOR /F "tokens=*" %%%%g in ^('Dir /AD /B /S "%%~1" 2^^^>NUL'^) do ^(
echo    echo [RD_Deep_Search]-[%%%%g]
echo    %%NSudo%% RD /S /Q "%%%%g"
echo ^)
echo goto :eof
echo.
echo :DEL_Direct
echo echo [DEL_Direct]-[%%~1]
echo %%NSudo%% DEL /F /Q /A "%%~1"
echo goto :eof
echo.
echo :DEL_Search
echo FOR /F "tokens=*" %%%%g in ^('Dir /A-D /B "%%~1" 2^^^>NUL'^) do ^(
echo    echo [DEL_Search]-[%%~dp1%%%%g]
echo    %%NSudo%% DEL /F /Q /A "%%~dp1%%%%g"
echo ^)
echo goto :eof
echo.
echo :DEL_Deep_Search
echo FOR /F "tokens=*" %%%%g in ^('Dir /A-D /B /S "%%~1" 2^^^>NUL'^) do ^(
echo    echo [DEL_Deep_Search]-[%%%%g]
echo    %%NSudo%% DEL /F /Q /A "%%%%g"
echo ^)
echo goto :eof
echo.
echo :Delete
) > C:\Playbook.Reset.After.cmd
REM -------------------------------------------------------------
cls&Call :Dil A 2 P1001&title OgnitorenKs Playbook │ 1/7 │ !LA2!
REM Bileşen kaldırma bölümü
REM Capabilities ve packages bileşenleri için Dism ile verileri alır.
Call :DEL_Direct "%Konum%\Log\C_Packages"
Call :DEL_Direct "%Konum%\Log\C_Capabilities"
DISM /Online /Get-Capabilities /format:table | Findstr /i "Installed" > %Konum%\Log\C_Capabilities
FOR /F "tokens=4" %%g in ('Dism /Online /Get-Packages ^| Findstr /i "Package Identity"') do echo %%g >> %Konum%\Log\C_Packages
Call :DEL_Direct "%Konum%\Log\COMPlaybook"
Call :DEL_Direct "%Konum%\Log\Playbook_Log.txt"
Call :Dil B 2 T0008
FOR /L %%a in (1,1,69) do (
	FOR /F "tokens=2" %%b in ('Findstr /i "COM_%%a_" %PB% 2^>NUL') do (
		if "%%b" EQU "1" (Call :Dil A 2 SR_%%a_&echo ►%R%[32m "!LA2!" %R%[37m !LB2! %R%[0m
						  Call :Read_Features COM_%%a_
						  Call :Remove_!Value_C! "COM_%%a_"
						  echo [%%b]-"COM_%%a_" >> %Konum%\Log\Playbook_Log.txt
						  if "%%a" EQU "12" (set Value=D&Call :SS_29)
						  if "%%a" EQU "21" (FOR %%x in (SharedRealitySvc VacSvc perceptionsimulation spectrum MixedRealityOpenXRSvc SpatialGraphFilter) do (Call :Service_Admin "%%x" 6))
						 )
	)
)
cls
REM -------------------------------------------------------------
REM Microsoft Defender kaldır
Call :Playbook_Reader Component_Setting_1_
	if "!Playbook!" EQU "1" (Call :Dil A 2 P2001&echo ►%R%[32m !LA2! %R%[0m
							 Call :Appx_Info
							 Call :NonRemoved "SecHealthUI"
							 Call :NonRemoved "Apprep.ChxApp"
							 Call :Read_Features "OGNI_2_"
							 Call :Remove_!Value_C! "OGNI_2_"
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
								echo Call :DEL_Direct %%a >> C:\Playbook.Reset.After.cmd
								%NSudo% DEL /F /Q /A %%a
							 )
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
							 ) do (
								echo Call :RD_Direct %%a >> C:\Playbook.Reset.After.cmd
								%NSudo% RD /S /Q %%a
							 )
							 FOR %%a in (
							 "%LocalAppData%\Packages\*.SecHealthUI_*"
							 ) do (
								echo Call :RD_Search "%%LocalAppData%%\Packages\%%a" >> C:\Playbook.Reset.After.cmd
								Call :RD_Search %%a
							 )
							 Call :DEL_Deep_Search "C:\*guard.wim"
							 Call :Defender_Regedit 6
							 Call :Reg_Hide "windowsdefender"
)
REM -------------------------------------------------------------
REM Microsoft Edge kaldır
Call :Playbook_Reader Component_Setting_2_
	if "!Playbook!" EQU "1" (Call :Dil A 2 P2002&echo ►%R%[32m !LA2! %R%[0m
							 Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v "NoRemove"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v "NoRemove"
							 Call :RegDel "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v "NoRemove"
							 Call :Appx_Info
							 Call :NonRemoved "Edge.Stable"
							 Call :NonRemoved "EdgeDevToolsClient"
							 %NSudo% Taskkill /f /im "msedge.exe"
							 %NSudo% Taskkill /f /im "Setup.exe"
							 %NSudo% Taskkill /f /im "CompactTelRunner.exe"
							 FOR %%a in ('Dir /AD /B "%programfiles(x86)%\Microsoft\Edge\Application\*" 2^>NUL') do (
								dir /b "%programfiles(x86)%\Microsoft\Edge\Application\%%a\Installer" > NUL 2>&1
									if !errorlevel! EQU 0 ("%programfiles(x86)%\Microsoft\Edge\Application\%%a\Installer\setup.exe" --uninstall --system-level --force-uninstall)
							 )
							 FOR /F "tokens=*" %%b in ('Dir /AD /B "%ProgramFiles(x86)%\Microsoft" 2^>NUL ^| Findstr /i /l /v /C:"WebView" 2^>NUL') do (
								Call :RD_Direct "%ProgramFiles(x86)%\Microsoft\%%b"
								echo Call :RD_Direct "%%ProgramFiles(x86)%%\Microsoft\%%b" >> C:\Playbook.Reset.After.cmd
							 )
							 FOR /F "delims=\ tokens=9" %%c in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree" /f "Edge" 2^>NUL') do (Call :Schtasks "Disable" "\%%c")
							 Call :DEL_Direct "C:\Users\%username%\Desktop\edge.lnk"
							 Call :DEL_Direct "C:\Users\Public\Desktop\Microsoft Edge.lnk"
							 Call :DEL_Direct "C:\Users\%username%\Desktop\Microsoft Edge.lnk"
							 Call :RD_Direct "%LocalAppData%\Microsoft\Edge"
							 Call :DEL_Deep_Search "%Windir%\*dge.wim"
							 Call :RD_Direct "C:\Users\OgnitorenKs\AppData\Local\Microsoft\Edge"
							 Call :RD_Direct "C:\Users\All Users\Microsoft\EdgeUpdate"
							 Call :DEL_Direct "%Windir%\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk"
							 echo Call :DEL_Direct "C:\Users\Public\Desktop\Microsoft Edge.lnk" >> C:\Playbook.Reset.After.cmd
							 echo Call :DEL_Direct "C:\Users\Public\Desktop\Microsoft Edge.lnk" >> C:\Playbook.Reset.After.cmd
							 echo Call :DEL_Direct "C:\Users\%username%\Desktop\Microsoft Edge.lnk" >> C:\Playbook.Reset.After.cmd
							 echo Call :RD_Search "%LocalAppData%\Microsoft\Edge" >> C:\Playbook.Reset.After.cmd
							 echo Call :DEL_Deep_Search "C:\Windows\*dge.wim" >> C:\Playbook.Reset.After.cmd
							 echo Call :RD_Direct "C:\Users\OgnitorenKs\AppData\Local\Microsoft\Edge" >> C:\Playbook.Reset.After.cmd
							 echo Call :DEL_Direct "%Windir%\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" >> C:\Playbook.Reset.After.cmd
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge" "PreventFirstRunPage" REG_DWORD 0
							 FOR /F "skip=2 tokens=1" %%b in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f "MicrosoftEdgeAutoLaunch" 2^>NUL') do (Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%b")
							 Call :Service_Admin "edgeupdate" 4
							 Call :Service_Admin "edgeupdatem" 4
)
pause
REM -------------------------------------------------------------
REM EdgeWebView2 kaldır
Call :Playbook_Reader Component_Setting_3_
	if "!Playbook!" EQU "1" (Call :Dil A 2 P2003&echo ►%R%[32m !LA2! %R%[0m
							 %NSudo% Taskkill /f /im "msedge.exe"
							 %NSudo% Taskkill /f /im "Setup.exe"
							 %NSudo% Taskkill /f /im "CompactTelRunner.exe"
							 FOR %%a in ('Dir /AD /B "%programfiles(x86)%\Microsoft\EdgeWebView\Application\*" 2^>NUL') do (
								dir /b "%programfiles(x86)%\Microsoft\EdgeWebView\Application\%%a\Installer" > NUL 2>&1
									if !errorlevel! EQU 0 ("%programfiles(x86)%\Microsoft\EdgeWebView\Application\%%a\Installer\setup.exe" --uninstall --msedgewebview --system-level --force-uninstall)
							 )
							 FOR /F "tokens=*" %%b in ('Dir /AD /B "%ProgramFiles(x86)%\Microsoft\*WebView*" 2^>NUL') do (
								Call :RD_Direct "%ProgramFiles(x86)%\Microsoft\%%b"
								echo Call :RD_Direct "%%ProgramFiles(x86)%%\Microsoft\%%b" >> C:\Playbook.Reset.After.cmd
							 )
							 Call :RD_Search "%Windir%\WinSxS\*-edge-webview_*"
							 Call :RD_Direct "%Windir%\System32\Microsoft-Edge-WebView"
							 echo Call :RD_Search "%%Windir%%\WinSxS\*microsoft-edge-webview*" >> C:\Playbook.Reset.After.cmd
							 echo Call :RD_Direct "%%Windir%%\System32\Microsoft-Edge-WebView" >> C:\Playbook.Reset.After.cmd
)
REM -------------------------------------------------------------
REM Onedrive kaldır
Call :Playbook_Reader Component_Setting_4_
	if "!Playbook!" EQU "1" (Call :Dil A 2 P2004&echo ►%R%[32m !LA2! %R%[0m
							 FOR %%a in (
							 "%Windir%\System32\OneDriveSetup.exe"
							 "%Windir%\SysWOW64\OneDriveSetup.exe"
							 ) do (
								%%a /uninstall > NUL 2>&1
							 )
							 Call :Read_Features "OGNI_1_"
							 Call :Remove_!Value_C! "OGNI_1_"
							 Call :RD_Deep_Search "C:\*onedrive*"
							 Call :DEL_Deep_Search "C:\*onedrive*"
							 Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive"
							 Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup"
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-280811Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-280810Enabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" REG_DWORD 1
							 Call :RegDel "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
							 Call :RegDel "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
)
REM -------------------------------------------------------------
REM Kurtarma alanını kaldır
Call :Playbook_Reader Component_Setting_5_
	if "!Playbook!" EQU "1" (Call :Dil A 2 P2005&echo ►%R%[32m !LA2! %R%[0m
							 Call :DEL_Deep_Search "%Windir%\*winre.wim"
)
REM -------------------------------------------------------------
cls
REM Windows defender devre dışı bırak
Call :Playbook_Reader Change_App_1_
	if "!Playbook!" EQU "1" (Call :Dil A 2 P2006&echo ►%R%[32m !LA2! %R%[0m
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" "Debugger" REG_SZ "%%%%windir%%%%\System32\taskkill.exe"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe" "Debugger" REG_SZ "%%%%windir%%%%\System32\taskkill.exe"
							 Call :Defender_Regedit 4
)
REM Görev çubuğu arama bileşenini devre dışı bırak
Call :Playbook_Reader Change_App_2_
	if "!Playbook!" EQU "1" (Call :Dil A 2 P2007&echo ►%R%[32m !LA2! %R%[0m
							 Call :Check_Rename "%Windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe"
							 Call :Check_Rename "%Windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\MiniSearchHost.exe"
							 Call :Check_Rename "%Windir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe"
							 %NSudo% taskkill /f /im "SearchHost.exe"
							 %NSudo% taskkill /f /im "MiniSearchHost.exe"
							 %NSudo% taskkill /f /im "SearchApp.exe"
							 %NSudo% rename "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe" "SearchHost_OLD.exe"
							 %NSudo% rename "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\MiniSearchHost.exe" "MiniSearchHost_OLD.exe"
							 %NSudo% rename "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe" "SearchApp_OLD.exe"
							 %NSudo% taskkill /f /im "SearchApp.exe"
							 %NSudo% taskkill /f /im "MiniSearchHost.exe"
							 %NSudo% taskkill /f /im "SearchHost.exe"
)
REM Windows 11 başlat menüsünü devre dışı bırak
Call :Playbook_Reader Change_App_3_
	if "!Playbook!" EQU "1" (Call :Dil A 2 P2008&echo ►%R%[32m !LA2! %R%[0m
							 Call :Check_Rename "%Windir%\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe"
							 %NSudo% taskkill /f /im "StartMenuExperienceHost.exe"
							 %NSudo% rename "C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" "StartMenuExperienceHost_OLD.exe"
							 %NSudo% taskkill /f /im "StartMenuExperienceHost.exe"
)
REM -------------------------------------------------------------
REM Uygulama kaldır
cls&Call :Dil A 2 P1002&title OgnitorenKs Playbook │ 2/7 │ !LA2!
Call :Appx_Info
Call :Dil B 2 T0008
FOR /F "tokens=4" %%a in ('Findstr /i "RemoveApp" %PB% 2^>NUL') do (
	FOR /F "skip=2 tokens=2" %%b in ('Find "► %%a ►" %PB% 2^>NUL') do (
		if "%%b" EQU "1" (echo ► %R%[92m "%%a"%R%[37m !LB2! %R%[0m
						  echo [%%b]-"%%a" >> %Konum%\Log\Playbook_Log.txt
						  Call :NonRemoved "%%a"
						 )
	)
)
REM -------------------------------------------------------------
REM Hizmet Yönetimi
cls&Call :Dil A 2 P1003&title OgnitorenKs Playbook │ 3/7 │ !LA2!
Call :Dil A 2 T0012
FOR /F "tokens=4" %%a in ('Findstr /i "Service_Manager" %PB%') do (
	FOR /F "skip=2 tokens=2" %%b in ('Find "► %%a ►" %PB%') do (
		if "%%b" NEQ "5" (echo ► %R%[92m "%%a"%R%[37m !LA2! %R%[0m
						  echo [%%b]-"%%a" >> %Konum%\Log\Playbook_Log.txt
						  Call :Service_Admin "%%a" "%%b"
						 )
	)
)
REM -------------------------------------------------------------
REM Uygulanan regedit ayarlarını gösterir
set Show=1
cls&Call :Dil A 2 P1004&title OgnitorenKs Playbook │ 4/7 │ !LA2!
REM Başlat menüsünde en son eklenenleri kaldır
Call :Playbook_Reader Taskbar_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "HideRecentlyAddedApps" REG_DWORD 1
)
REM Başlat menüsünde önerilenler bölümünü kaldır
Call :Playbook_Reader Taskbar_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_TrackProgs" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "HideRecommendedSection" REG_DWORD 1
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_Layout" REG_DWORD 1
							 Call :RegDel "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "HideRecommendedSection"
)
REM Başlat menüsünde en çok kullanılan uygulamaları kaldır
Call :Playbook_Reader Taskbar_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "ShowOrHideMostUsedApps" REG_DWORD 2
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "HideFrequentlyUsedApps" REG_DWORD 1
)
REM Başlat menüsü - Uygulama önerilerini kapat
Call :Playbook_Reader Taskbar_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Context\CloudExperienceHostIntent\Wireless" "ScoobeCheckCompleted" REG_DWORD 1
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" "ScoobeSystemSettingEnabled" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338388Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "ContentDeliveryAllowed" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "FeatureManagementEnabled" REG_DWORD 0 
)
REM Görev çubuğu kişiler simgesini gizle
Call :Playbook_Reader Taskbar_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" "PeopleBand" REG_DWORD 0
)
REM Görev çubuğu - arama simgesini gizle
Call :Playbook_Reader Taskbar_Setting_6_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SearchboxTaskbarMode" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" REG_DWORD 0
)
REM Görev çubuğu - hava durumunu gizle
Call :Playbook_Reader Taskbar_Setting_7_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" "ShellFeedsTaskbarViewMode" REG_DWORD 2
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" "value" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" "EnableFeeds" REG_DWORD 0
)
REM Görev çubuğu - widget simgesini gizle
Call :Playbook_Reader Taskbar_Setting_8_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" REG_DWORD 0
)
REM Görev çubuğu - Cortana simgesini gizle
Call :Playbook_Reader Taskbar_Setting_9_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowCortanaButton" REG_DWORD 0
)
REM Görev çubuğu - sohbet/anında toplantı simgesini gizle
Call :Playbook_Reader Taskbar_Setting_10_
	if "!Playbook!" EQU "1" (if %Win% EQU 10 (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "HideSCAMeetNow" REG_DWORD 1)
							 if %Win% EQU 11 (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" REG_DWORD 0)
)
REM Windows Ink[kalem] çalışma alanı kapat
Call :Playbook_Reader Taskbar_Setting_11_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-280813Enabled" REG_DWORD 0
)
REM Görev çubuğu - başlat simgesini sola hizala
Call :Playbook_Reader Taskbar_Setting_12_
	if "!Playbook!" EQU "1" (if %Win% EQU 11 (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarAl" REG_DWORD 0)
)
REM Görev görünümü simgesini gizle
Call :Playbook_Reader Taskbar_Setting_13_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" REG_DWORD 0
)
REM Başlat menüsü - Önerilenler bölümünü kaldır
Call :Playbook_Reader Taskbar_Setting_14_
	if "!Playbook!" EQU "1" (Call :RegDel "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "HideRecommendedSection"
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "HideRecommendedSection" REG_DWORD 1
)
REM Başlangıç menüsü - ipuçları, kısayollar, yeni uygulamalar ve daha fazlası için önerileri kapat
Call :Playbook_Reader Taskbar_Setting_15_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_IrisRecommendations" REG_DWORD 0
)
REM ContentDeliveryManager - Ayarlar uygulamasında önerilen içeriği kapat
Call :Playbook_Reader Privacy_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338393Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353694Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353696Enabled" REG_DWORD 0
)
REM ContentDeliveryManager - Windows karşılama deneyimini kapat
Call :Playbook_Reader Privacy_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-310093Enabled" REG_DWORD 0
)
REM ContentDeliveryManager - İstenmeyen uygulamaların yüklemesini kapat
Call :Playbook_Reader Privacy_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SilentInstalledAppsEnabled" REG_DWORD 0 
)
REM ContentDeliveryManager - Önerilen uygulamaların otomatik kurulmasını kapat
Call :Playbook_Reader Privacy_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-314563Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-280815Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-314559Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RemediationRequired" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "PreInstalledAppsEverEnabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "PreInstalledAppsEnabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "OemPreInstalledAppsEnabled" REG_DWORD 0 
)
REM ContentDeliveryManager - Sponsorlu uygulamaların otomatik kurulmasını engelle
Call :Playbook_Reader Privacy_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" REG_DWORD 1 
)
REM ContentDeliveryManager - Üçüncü taraf uygulama önerisini kapat
Call :Playbook_Reader Privacy_Setting_6_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableThirdPartySuggestions" REG_DWORD 1 
)
REM ContentDeliveryManager - Windows kullanırken öneri ve ipuçlarını kapat
Call :Playbook_Reader Privacy_Setting_7_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContentEnabled" REG_DWORD 0
)
REM ContentDeliveryManager - Zaman çizelgesi önerilerini kapat
Call :Playbook_Reader Privacy_Setting_8_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353698Enabled" REG_DWORD 0
)
REM ContentDeliveryManager - Kilit ekranı ipuçlarını kapat
Call :Playbook_Reader Privacy_Setting_9_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338387Enabled" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RotatingLockScreenOverlayEnabled" REG_DWORD 0
)
REM Harita uygulamasını yükleme
Call :Playbook_Reader Privacy_Setting_10_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338381Enabled" REG_DWORD 0
)
REM Windows'un etkinlikleri toplamasını engelle
Call :Playbook_Reader Privacy_Setting_11_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "UploadUserActivities" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" REG_DWORD 0
)
REM Hızlı erişimde sık kullanılan verileri kapat
Call :Playbook_Reader Privacy_Setting_12_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "ShowFrequent" REG_DWORD 0
)
REM Giriş verilerini Microsoft'a göndermeyi engelle
Call :Playbook_Reader Privacy_Setting_13_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" "AllowLinguisticDataCollection" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Personalization\Settings" "AcceptedPrivacyPolicy" REG_DWORD 0
)
REM Geri bildirim frekansını kapat
Call :Playbook_Reader Privacy_Setting_14_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Siuf\Rules" "NumberOfSIUFInPeriod" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "DoNotShowFeedbackNotifications" REG_DWORD 1
							 Call :RegDel "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Feedback\Siuf\DmClient"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
)
REM Yazma geliştirme için Microsoft'a veri göndermeyi engelle
Call :Playbook_Reader Privacy_Setting_15_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Input\TIPC" "Enabled" REG_DWORD 0
)
REM Microsoft deneylerini kapat
Call :Playbook_Reader Privacy_Setting_16_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" "AllowExperimentation" REG_DWORD 0
)
REM Nvidia deneyim geliştirme programını kapat
Call :Playbook_Reader Privacy_Setting_17_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" "OptInOrOutPreference" REG_DWORD 0
)
REM Göz atma verilerinin Microsoft'a gönderilmesini engelle
Call :Playbook_Reader Privacy_Setting_18_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Internet Explorer\FlipAhead" "FPEnabled" REG_DWORD 0
)
REM Web sitelerinin kullanıcı dil verisine erişimini engelle
Call :Playbook_Reader Privacy_Setting_19_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Control Panel\International\User Profile" "HttpAcceptLanguageOptOut" REG_DWORD 1
)
REM Uygulamaların reklam kimliği kullanmasını engelle
Call :Playbook_Reader Privacy_Setting_20_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" "DisabledByGroupPolicy" REG_DWORD 1
)
REM Uygulama envanterini toplamayı kapatın
Call :Playbook_Reader Privacy_Setting_21_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" "DisableInventory" REG_DWORD 1
)
REM Windows Media Player istatistiklerinin gönderilmesini engelle
Call :Playbook_Reader Privacy_Setting_22_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\MediaPlayer\Preferences" "UsageTracking" REG_DWORD 0 
)
REM Wifi sıcak nokta raporlamayı kapat
Call :Playbook_Reader Privacy_Setting_23_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Wifi\AllowWiFiHotSpotReporting" "value" REG_DWORD 0
)
REM Çevrimiçi konuşma tanıma kapat
Call :Playbook_Reader Privacy_Setting_24_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Microsoft\Speech\Preferences" "ModeForOff" REG_DWORD "1"
)
REM Microsoft'a tanılama verilerinin gönderilmesini engelle
Call :Playbook_Reader Privacy_Setting_25_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableTailoredExperiencesWithDiagnosticData" REG_DWORD 1
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" "TailoredExperiencesWithDiagnosticDataEnabled" REG_DWORD 0
)
REM Son kullanılan dosyaları hızlı erişimde gizle
Call :Playbook_Reader Privacy_Setting_26_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "ShowRecent" REG_DWORD 0
)
REM Skype'ın adres defterine erişimini engelle
Call :Playbook_Reader Privacy_Setting_27_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE\AppSettings" "Skype-UserConsentAccepted" REG_DWORD 0
)
REM Cihazlar arası deneyimi kapat
Call :Playbook_Reader Privacy_Setting_28_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" "NearShareChannelUserAuthzPolicy" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" "CdpSessionUserAuthzPolicy" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "EnableCdp" REG_DWORD 0
)
REM Yazı tanımayı kapat
Call :Playbook_Reader Privacy_Setting_29_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Input\Settings" "InsightsEnabled" REG_DWORD 0
)
REM Ücretli ağları tespit etmek için geçici erişim noktalarına bağlanmayı kapat
Call :Playbook_Reader Privacy_Setting_30_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" "PaidWifi" REG_DWORD 0
)
REM Önerilen açık sıcak Wifi noktalarına bağlanmayı kapat
Call :Playbook_Reader Privacy_Setting_31_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" "WiFiSenseOpen" REG_DWORD 0
)
REM Konuşma tanıma hizmetini kapat
Call :Playbook_Reader Privacy_Setting_32_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" "AllowInputPersonalization" REG_DWORD 0
)
REM Açılan belge izlemesini devre dışı bırak [Son açılan belge geçmişi]
Call :Playbook_Reader Privacy_Setting_33_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoRecentDocsHistory" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoRecentDocsHistory" REG_DWORD 1 
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_TrackDocs" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "HideAppList" REG_DWORD 3
)
REM Sık kullanılanları hızlı erişimden kaldır
Call :Playbook_Reader Privacy_Setting_34_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCR\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder" "Attributes" REG_DWORD 2696937728
							 Call :RegAdd "HKCR\WOW6432Node\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder" "Attributes" REG_DWORD 2696937728
)
REM Önceki oturumlar hakkında bilgi vermeyi kapat
Call :Playbook_Reader Privacy_Setting_35_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\KDC\Parameters" "EmitLILI" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "ReportBootOk" REG_SZ 0
)
REM Atlama listelerinde en son açılan öğeleri kaldır
Call :Playbook_Reader Privacy_Setting_36_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "HideRecentJumplists" REG_DWORD 1
)
REM Çevrimiçi ipuçlarını kapat
Call :Playbook_Reader Privacy_Setting_37_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "AllowOnlineTips" REG_DWORD 0
)
REM Cihaz sistem durumu raporlamasını kapat [Kurumsal]
Call :Playbook_Reader Privacy_Setting_38_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\DeviceHealthAttestationService" "EnableDeviceHealthAttestationService" REG_DWORD 0
)
REM Hotspot 2.0 devre dışı bırak
Call :Playbook_Reader Privacy_Setting_39_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WlanSvc\AnqpCache" "OsuRegistrationStatus" REG_DWORD 4 
)
REM Senkronizasyon sağlayıcı bildirimleri kapat
Call :Playbook_Reader Privacy_Setting_40_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSyncProviderNotifications" REG_DWORD 0
)
REM Bileşenlerin hizmet günlüğünü devre dışı bırak
Call :Playbook_Reader Privacy_Setting_41_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" "EnableLog" REG_DWORD 0
)
REM Delta Paket ayıklayıcı kapat
Call :Playbook_Reader Privacy_Setting_42_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" "EnableDpxLog" REG_DWORD 0
)
REM Bileşenlerin hizmet yedeğini devre dışı bırak
Call :Playbook_Reader Privacy_Setting_43_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" "DisableComponentBackups" REG_DWORD 1
)
REM WfpDiag.ETL günlük kaydını kapat
Call :Playbook_Reader Privacy_Setting_44_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Services\BFE\Parameters\Policy\Options" "CollectNetEvents" REG_DWORD 0
)
REM Yanlış yazılan sözcükleri otomatik düzelt kapat
Call :Playbook_Reader Privacy_Setting_45_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" "EnableAutocorrection" REG_DWORD 0
)
REM Yazım denetimi kapat
Call :Playbook_Reader Privacy_Setting_46_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" "EnableSpellchecking" REG_DWORD 0
)
REM Diğer cihazlardaki uygulamaların bu cihazdaki uygulamaları açmasını engelle
Call :Playbook_Reader Privacy_Setting_47_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" "UserAuthPolicy" REG_DWORD 0
)
REM Arama geçmişini kapat
Call :Playbook_Reader Privacy_Setting_48_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" "IsDeviceSearchHistoryEnabled" REG_DWORD 0
)
REM Yardım ve Destek ipuçlarını kapat
Call :Playbook_Reader Privacy_Setting_49_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" "DisableHelpSticker" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" "Headlines" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" "MicrosoftKBSearch" REG_DWORD 0
)
REM Yeni uygulama yüklendi uyarısını kapat
Call :Playbook_Reader Privacy_Setting_50_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "NoNewAppAlert" REG_DWORD 1
)
REM Mürekkep oluşturma ve yazma kişiselleştirmeyi kapat
Call :Playbook_Reader Privacy_Setting_51_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" "HarvestContacts" REG_DWORD 0
							 Call :RegAdd "HKCU\SOFTWARE\Policies\Microsoft\InputPersonalization" "RestrictImplicitInkCollection" REG_DWORD 1
							 Call :RegAdd "HKCU\SOFTWARE\Policies\Microsoft\InputPersonalization" "RestrictImplicitTextCollection" REG_DWORD 1
							 Call :RegAdd "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" "AcceptedPrivacyPolicy" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Personalization\Settings" "AcceptedPrivacyPolicy" REG_DWORD 0
)
REM Konum erişimini devre dışı bırak
Call :Playbook_Reader Privacy_Setting_52_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" "Value" REG_SZ "Deny"
							 Call :RegAdd_CCS "Services\lfsvc\Service\Configuration" "Status" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowSearchToUseLocation" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableLocation" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableLocationScripting" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableWindowsLocationProvider" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" "AllowLocation" REG_DWORD 0
)
REM Hesap bilgileri erişimini devre dışı bırak
Call :Playbook_Reader Privacy_Setting_53_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" "Value" REG_SZ "Deny"
)
REM Teslim en iyileştirme hizmeti yerine BITS hizmetini kullan
Call :Playbook_Reader Privacy_Setting_54_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" "DODownloadMode" REG_DWORD 100
)
REM Cihazımı bul devre dışı bırak
Call :Playbook_Reader Privacy_Setting_55_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\MdmCommon\SettingValues" "LocationSyncEnabled" REG_DWORD 0
)
REM Cihaz meta verisi toplamayı kapat
Call :Playbook_Reader Privacy_Setting_56_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" "DeviceMetadataServiceURL" REG_SZ 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" "PreventDeviceMetadataFromNetwork" REG_DWORD 1
)
REM Telemetri devre dışı bırak
Call :Playbook_Reader Privacy_Setting_57_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" REG_DWORD 0
							 Call :RegAdd "HKCU\Policies\Microsoft\Windows\CloudContent" "DisableTailoredExperiencesWithDiagnosticData" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" "AITEnable" REG_DWORD 0
							 Call :RegAdd_CCS "Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" "Start" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" REG_DWORD 0
							 Call :RegAdd_CCS "Control\CrashControl\StorageTelemetry" "DeviceDumpEnabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" REG_DWORD 0
							 Call :RegAdd_CCS "Control\WMI\Autologger\SQMLogger" "Start" REG_DWORD "0"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" "IsCensusDisabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" "DontRetryOnError" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" "TaskEnableRun" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\DataCollection" "AllowTelemetry" REG_DWORD 0
							 Call :RegAdd "HKCU\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" REG_DWORD 0
							 Call :RegAdd "HKCU\Policies\Microsoft\Assistance\Client\1.0" "NoExplicitFeedback" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry" "Enabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Compatibility-Assistant" "Enabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Compatibility-Troubleshooter" "Enabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Inventory" "Enabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry" "Enabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Steps-Recorder" "Enabled" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" "Debugger" REG_SZ "%%%%windir%%%%\System32\taskkill.exe"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" "Debugger" REG_SZ "%%%%windir%%%%\System32\taskkill.exe"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Application Experience\StartupAppTask"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
							 Call :Schtasks "Disable" "Microsoft\Windows\Application Experience\AitAgent"
							 Call :Schtasks "Disable" "Microsoft\Windows\Customer Experience Improvement Program\BthSQM"
							 Call :Schtasks "Disable" "Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
							 Call :Schtasks "Disable" "Microsoft\Windows\Customer Experience Improvement Program\TelTask"
							 Call :Schtasks "Disable" "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
							 Call :Schtasks "Disable" "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
							 Call :Schtasks "Disable" "Microsoft\Windows\Device Information\Device"
							 Call :Schtasks "Disable" "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
							 Call :Schtasks "Disable" "Microsoft\Windows\PI\Sqm-Tasks"
)
REM Windows Hata raporlamayı devre dışı bırak
Call :Playbook_Reader Privacy_Setting_58_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "Disabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "DontSendAdditionalData" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "DontShowUI" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "LoggingDisabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "MachineID" REG_SZ 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\WMR" "Disable" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" "DefaultConsent" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" "NewUserDefaultConsent" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "BypassNetworkCostThrottling" REG_DWORD 0 
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "BypassDataThrottling" REG_DWORD 0 
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" "AutoApproveOSDump" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" "IncludeKernelFaults" REG_DWORD 0 
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" "DoReport" REG_DWORD 0 
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" "DisableSendRequestAdditionalSoftwareToWER" REG_DWORD 1
							 Call :Schtasks "Disable" "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
)
REM Bluetooth loglamayı devre dışı bırak
Call :Playbook_Reader Privacy_Setting_59_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\WMI\Autologger\BluetoothSession" "Start" REG_DWORD 0
)
REM Windows deneyimleri, bulut tüketici hesap verilerini devre dışı bırak
Call :Playbook_Reader Privacy_Setting_60_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableConsumerAccountStateContent" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableCloudOptimizedContent" REG_DWORD 1 
)
REM Uygulama bildirimlerini devre dışı bırak
Call :Playbook_Reader Privacy_Setting_61_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" "ToastEnabled" REG_DWORD 0
)
REM Müşteri deneyimi geliştirme programı (CEIP) devre dışı bırak
Call :Playbook_Reader Privacy_Setting_62_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP" "CEIPEnable" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" "CEIPEnable" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Messenger\Client" "CEIP" REG_DWORD 2
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" "CEIPEnable" REG_DWORD 0
							 Call :Schtasks "Disable" "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Customer Experience Improvement Program\USBCeip"
)
REM Uzaktan yardım - Microsoft destek tanı aracı için ek araç kurulumunu devre dışı bırak
Call :Playbook_Reader Privacy_Setting_63_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46ac-8BEE-B1715EC634E5}" "DownloadToolsEnabled" REG_DWORD 0
)
REM Uzaktan yardım - Destek uzmanları tanı verilerini toplayamaz
Call :Playbook_Reader Privacy_Setting_64_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46ac-8BEE-B1715EC634E5}" "ScenarioExecutionEnabled" REG_DWORD 0
)
REM Uzaktan yardım - Windows Messenger'ı devre dışı bırak
Call :Playbook_Reader Privacy_Setting_65_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Messenger\Client" "PreventAutoRun" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Messenger\Client" "PreventRun" REG_DWORD 1
)
REM Windows Search - Cortana'nın cihaz geçmişini kullanmasını devre dışı bırak
Call :Playbook_Reader Privacy_Setting_66_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "DeviceHistoryEnabled" REG_DWORD "0"
							 Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "HistoryViewEnabled" REG_DWORD "0"
)
REM Dosya gezgini arama kutusu geçmişini görüntelemeyi devre dışı bırak
Call :Playbook_Reader Privacy_Setting_67_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Policies\Microsoft\Windows\Explorer" "DisableSearchBoxSuggestions" REG_DWORD 1
)
REM Program uyumluluk asistanını kapat
Call :Playbook_Reader Privacy_Setting_68_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Policies\Microsoft\Windows\AppCompat" "DisablePCA" REG_DWORD 1
)
REM Qos paket zamanlayıcı sınırını kaldır
Call :Playbook_Reader Internet_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" "NonBestEffortLimit" REG_DWORD "0"
)
REM Sınırlı ağ kontrol sınamasını kapat
Call :Playbook_Reader Internet_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" "NoActiveProbe" REG_DWORD 1
)
REM Nagle's algoritmasını kapat
Call :Playbook_Reader Internet_Setting_3_
	if "!Playbook!" EQU "1" (Call :Powershell "Get-CimInstance -ClassName Win32_NetworkAdapter | Select-Object GUID" > %Konum%\Log\Nagle.txt
							 FOR /F "tokens=*" %%a in ('Findstr /i "{" %Konum%\Log\Nagle.txt 2^>NUL') do (
								Call :RegAdd_CCS "Services\Tcpip\Parameters\Interfaces\%%a" "TcpAckFrequency" REG_DWORD 1
								Call :RegAdd_CCS "Services\Tcpip\Parameters\Interfaces\%%a" "TcpDelAckTicks" REG_DWORD 0
								Call :RegAdd_CCS "Services\Tcpip\Parameters\Interfaces\%%a" "TCPNoDelay" REG_DWORD 1
							 )
							 Call :DEL_Direct "%Konum%\Log\Nagle.txt"
)
REM Önbellekleme kapat - Prefetch
Call :Playbook_Reader Explorer_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\Session Manager\Memory Management\Prefetchparameters" "EnableBoottrace" REG_DWORD 0
							 Call :RegAdd_CCS "Control\Session Manager\Memory Management\Prefetchparameters" "EnablePrefetcher" REG_DWORD 0
							 Call :RegAdd_CCS "Control\Session Manager\Memory Management\Prefetchparameters" "EnableSuperfetch" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout" "EnableAutoLayout" REG_DWORD 0
)
REM 255 karakter sınırını kaldır
Call :Playbook_Reader Explorer_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\FileSystem" "LongPathsEnabled" REG_DWORD 1
)
REM Kısayol yazısını kaldır
Call :Playbook_Reader Explorer_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "Link" REG_BINARY "00000000"
)
REM Transparan özelliğini kapat
Call :Playbook_Reader Explorer_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" REG_DWORD 0
)
REM Birlikte aç bölümünden Market aramasını kaldır
Call :Playbook_Reader Explorer_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "NoUseStoreOpenWith" REG_DWORD 1
)
REM Birlikte aç bölümünden internet aramasını kaldır
Call :Playbook_Reader Explorer_Setting_6_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoInternetOpenWith" REG_DWORD 1 
)
REM Hızlı erişimden office.com kaldır
Call :Playbook_Reader Explorer_Setting_7_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "DisableGraphRecentItems" REG_DWORD 1
)
REM Sağ-Tık, Yeni kişi oluştur kaldır
Call :Playbook_Reader Explorer_Setting_8_
	if "!Playbook!" EQU "1" (Call :RegDel "HKCR\.contact\ShellNew"
)
REM Explorer'u Bu Bilgisayar'dan başlat
Call :Playbook_Reader Explorer_Setting_9_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" REG_DWORD 1
)
REM Dosya kopyalama ekranında daha fazla detay göster
Call :Playbook_Reader Explorer_Setting_10_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" "EnthusiastMode" REG_DWORD 1 
)
REM Dosya uzantılarını göster
Call :Playbook_Reader Explorer_Setting_11_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" REG_DWORD 0
)
REM Korunan işletim sistemi dosyalarını göster
Call :Playbook_Reader Explorer_Setting_12_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSuperHidden" REG_DWORD 1
)
REM Gizli dosyaları göster
Call :Playbook_Reader Explorer_Setting_13_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" REG_DWORD 1
)
REM Masaüstü simgelerini aktifleştir - Ağ hariç
Call :Playbook_Reader Explorer_Setting_14_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" REG_DWORD 0 
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" REG_DWORD 0
)
REM Windows açılış sesini kapat
Call :Playbook_Reader Explorer_Setting_15_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "DisableStartupSound" REG_DWORD 1
)
REM Eski ALT + TAB etkinleştir
Call :Playbook_Reader Explorer_Setting_16_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" "AltTabSettings" REG_DWORD 1
)
REM Bat/Cmd/Reg sağ-tık menüsünden yazdır kaldır
Call :Playbook_Reader Explorer_Setting_17_
	if "!Playbook!" EQU "1" (Call :RegDel "HKCR\cmdfile\shell\print"
							 Call :RegDel "HKCR\batfile\shell\print"
							 Call :RegDel "HKCR\regfile\shell\print"
)
REM Sağ-tık menüsünden 'Sık kullanılanlara ekle' kaldır
Call :Playbook_Reader Explorer_Setting_18_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCR\*\shell\pintohomefile" "ProgrammaticAccessOnly" REG_SZ ""
)
REM Sağ-Tık 'Sahiplik Al' ekle
Call :Playbook_Reader Explorer_Setting_19_
	if "!Playbook!" EQU "1" (Call :Default_System_Language
								if "!DefaultLang!" EQU "tr-TR" (set Value19=Sahipliği Al)
								if "!DefaultLang!" NEQ "tr-TR" (set Value19=Take Ownership)
							 Call :RegVeAdd "HKCR\*\shell\runas" REG_SZ "!Value19!"
							 Call :RegAdd "HKCR\*\shell\runas" "Icon" REG_SZ "imageres.dll,73"
							 Call :RegAdd "HKCR\*\shell\runas" "NoWorkingDirectory" REG_SZ ""
							 Call :RegVeAdd "HKCR\*\shell\runas\command" REG_SZ "cmd.exe /c takeown /f \"%%%%1\" && ica \"%%%%1\" /grant administrators:F"
							 Call :RegAdd "HKCR\*\shell\runas\command" "IsolatedCommand" REG_SZ "cmd.exe /c takeown /f \"%%%%1\" && ica \"%%%%1\" /grant administrators:F"
							 Call :RegVeAdd "HKCR\Directory\shell\runas" REG_SZ "!Value19!"
							 Call :RegAdd "HKCR\Directory\shell\runas" "Icon" REG_SZ "imageres.dll,73"
							 Call :RegAdd "HKCR\Directory\shell\runas" "NoWorkingDirectory" REG_SZ ""
							 Call :RegVeAdd "HKCR\Directory\shell\runas\command" REG_SZ "cmd.exe /c takeown /f \"%%%%1\" /r /d y && ica \"%%%%1\" /grant administrators:F /t"
							 Call :RegAdd "HKCR\Directory\shell\runas\command" "IsolatedCommand" REG_SZ "cmd.exe /c takeown /f \"%%%%1\" /r /d y && ica \"%%%%1\" /grant administrators:F /t"
							 set Value19=
)
REM Office dosyalarını dosya gezgininde gizle
Call :Playbook_Reader Explorer_Setting_20_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" "ShowCloudFilesInQuickAccess" REG_DWORD 0
)
REM Windows Tema ayarlarını değiştir [Siyah başlat menüsü, beyaz dosya gezgini]
Call :Playbook_Reader Explorer_Setting_21_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" REG_DWORD 1
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" REG_DWORD 0
)
REM Animasyonları kapat
Call :Playbook_Reader Explorer_Setting_22_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" REG_DWORD 3
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
)
REM Dosya gezgini kompakt mod aktifleştir
Call :Playbook_Reader Explorer_Setting_23_
	if "!Playbook!" EQU "1" (if "%Win%" EQU "11" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "UseCompactMode" REG_DWORD 1)
)
REM Klasik sağ-tık menüsünü aktfileştir [Windows11]
Call :Playbook_Reader Explorer_Setting_24_
	if "!Playbook!" EQU "1" (if "%Win%" EQU "11" (Call :RegKey "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32")
)
REM Anlık yardım [Snap Assist] [Windows11]
Call :Playbook_Reader Explorer_Setting_25_
	if "!Playbook!" EQU "1" (if "%Win%" EQU "11" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "EnableSnapAssistFlyout" REG_DWORD 0
											      Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SnapAssist" REG_DWORD 0)
)
REM Sağ-tık bölümünden Terminal kaldır [Windows11]
Call :Playbook_Reader Explorer_Setting_26_
	if "!Playbook!" EQU "1" (if "%Win%" EQU "11" (Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked")
)
REM Bu bilgisayara kullanıcı klasörlerini ekle [Windows11]
Call :Playbook_Reader Explorer_Setting_27_
	if "!Playbook!" EQU "1" (if "%Win%" EQU "11" (Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /v "HideIfEnabled"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /v "HideIfEnabled"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /v "HideIfEnabled"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /v "HideIfEnabled"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /v "HideIfEnabled"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /v "HideIfEnabled"
											     )
)
REM Bu bilgisayardaki kullanıcı dosyalarını kaldırın [Windows10]
Call :Playbook_Reader Explorer_Setting_28_
	if "!Playbook!" EQU "1" (if "%Win%" EQU "10" (Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}"
											      Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
											     )
)
REM Sağ-tık - Yeni bölümüne .bat dosya uzantısını ekle
Call :Playbook_Reader Explorer_Setting_29_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCR\.bat\ShellNew" "NullFile" REG_SZ ""
)
REM Modern beyaz fare simgesini yükle
Call :Playbook_Reader Explorer_Setting_30_
	if "!Playbook!" EQU "1" (Call :Powershell "Expand-Archive -Force '%Konum%\Bin\Mouse.zip' '%Temp%\Mouse_Playbook'"
							 RunDll32 advpack.dll,LaunchINFSection %Temp%\Mouse_Playbook\Mouse1\Install.inf,DefaultInstall
							 Call :RD_Direct "%Temp%\Mouse_Playbook"
)
REM Windows Tema ayarlarını değiştir [Koyu mod]
Call :Playbook_Reader Explorer_Setting_31_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" REG_DWORD 0
)
REM Windows Tema ayarlarını değiştir [Açık mod]
Call :Playbook_Reader Explorer_Setting_32_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" REG_DWORD 1
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" REG_DWORD 1
)
REM Başlangıç ve görev çubuğunda vurgu rengini göster
Call :Playbook_Reader Explorer_Setting_33_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" REG_DWORD 1
)
REM Modern siyah fare simgesini yükle
Call :Playbook_Reader Explorer_Setting_34_
	if "!Playbook!" EQU "1" (Call :Powershell "Expand-Archive -Force '%Konum%\Bin\Mouse.zip' '%Temp%\Mouse_Playbook'"
							 RunDll32 advpack.dll,LaunchINFSection %Temp%\Mouse_Playbook\Mouse2\Install.inf,DefaultInstall
							 Call :RD_Direct "%Temp%\Mouse_Playbook"
)
REM Windows Search - Şifrelenmiş dosyaların indekslenmesini devre dışı bırak
Call :Playbook_Reader Search_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowIndexingEncryptedStoresOrItems" REG_DWORD 0
)
REM Windows Search - Tarifeli bağlantılarda internet aramasını kapat
Call :Playbook_Reader Search_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "ConnectedSearchUseWebOverMeteredConnections" REG_DWORD 0
)
REM Windows Search - İnternet aramasında yetişkin içerikleri [+18] göstermeyi engelle
Call :Playbook_Reader Search_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" "SafeSearchMode" REG_DWORD 2
)
REM Windows Search - Bulut aramayı kapat
Call :Playbook_Reader Search_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCloudSearch" REG_DWORD 0
)
REM Windows Search - İnternet aramasını devre dışı bırak
Call :Playbook_Reader Search_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" REG_DWORD 0
)
REM Başlangıç ​​gecikmesini devre dışı bırak
Call :Playbook_Reader Optimization_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" "StartupDelayInMSec" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "DelayedDesktopSwitchTimeout" REG_DWORD 1
)
REM Oyun modunu kapat
Call :Playbook_Reader Optimization_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\GameBar" "AutoGameModeEnabled" REG_DWORD 0
)
REM Tam ekran optimizasyonlarını kapat
Call :Playbook_Reader Optimization_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\System\GameConfigStore" "GameDVR_FSEBehavior" REG_DWORD "2"
							 Call :RegAdd "HKCU\System\GameConfigStore" "GameDVR_FSEBehaviorMode" REG_DWORD "2"
							 Call :RegAdd "HKCU\System\GameConfigStore" "GameDVR_Enabled" REG_SZ "0"
)
REM Donanım hızlandırmalı GPU planlamasını aktifleştir
Call :Playbook_Reader Optimization_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\GraphicsDrivers" "HwSchMode" REG_DWORD 2
)
REM Uygulamaların arka planda çalışmasını engelle
Call :Playbook_Reader Optimization_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" "BackgroundAppGlobalToggle" REG_DWORD 0
							 Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" REG_DWORD 1
)
REM Otomatik bakım görevini devre dışı bırak
Call :Playbook_Reader Optimization_Setting_6_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" "EnabledExecution" REG_DWORD 0
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
							 Call :Schtasks "Disable" "\Microsoft\Windows\DiskCleanup\SilentCleanup"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
)
REM Güç azaltmayı kapat
Call :Playbook_Reader Optimization_Setting_7_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\Power\PowerThrottling" "PowerThrottlingOff" REG_DWORD 1 
)
REM Sessiz saatleri etkinleştir
Call :Playbook_Reader Optimization_Setting_8_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\QuietHours" "Enable" REG_DWORD 1
)
REM Ram sayfa birleşimini kapat [PageFile Combine]
Call :Playbook_Reader Optimization_Setting_9_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\Session Manager\Memory Management" "DisablePagingCombining" REG_DWORD "1"
)
REM Nihai performans ekle ve aktifleştir [Yalnızca Türkçe sistemlerde çalışır] [Sistemi tam güçte çalıştıracağı için ısı değerleri artacaktır.]
Call :Playbook_Reader Optimization_Setting_10_
	if "!Playbook!" EQU "1" (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 97777777-8777-7777-6777-577777777777 > NUL 2>&1
							 powercfg /SETACTIVE "97777777-8777-7777-6777-577777777777" > NUL 2>&1
)
REM İşlemci çekirdek uyku modunu kapat [Core parking] [İşlemci sıcaklık değerlerini yükseltecektir]
Call :Playbook_Reader Optimization_Setting_11_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMax" REG_DWORD 0
							 Call :RegAdd_CCS "Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" "ValueMin" REG_DWORD 0
							 Call :RegAdd_CCS "Control\Power" "CoreParkingDisabled" REG_DWORD 0
)
REM Kapanmayı engelleyen programlar hemen kapatılsın
Call :Playbook_Reader Optimization_Setting_12_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "AllowBlockingAppsAtShutdown" REG_DWORD 0
							 Call :RegAdd "HKCU\Control Panel\Desktop" "AutoEndTasks" REG_SZ 1 
							 Call :RegAdd "HKCU\Control Panel\Desktop" "HungAppTimeout" REG_SZ "3000"
							 Call :RegAdd "HKCU\Control Panel\Desktop" "WaitToKillAppTime" REG_SZ "1000"
							 Call :RegAdd "HKCU\Control Panel\Desktop" "LowLevelHooksTimeout" REG_SZ "4000"
							 Call :RegAdd_CCS "Control" "WaitToKillServiceTimeout" REG_SZ "2000"
)
REM SSD/HDD optimizasyon
Call :Playbook_Reader Optimization_Setting_13_
	if "!Playbook!" EQU "1" (Call :Powershell "Get-PhysicalDisk | Select-Object -Property MediaType| Format-Table" > %Konum%\Log\SSD
							 Findstr /i "SSD" %Konum%\Log\SSD > NUL 2>&1
								if !errorlevel! EQU 0 (Call :RegAdd_CCS "Control\Power" "HibernateEnabled" REG_DWORD 0
													   Call :RegAdd_CCS "Control\Power" "HibernateEnabledDefault" REG_DWORD 0
													   Call :RegAdd_CCS "Control\FileSystem" "NtfsDisableLastAccessUpdate" REG_DWORD 0x80000001
													   Call :RegAdd_CCS "Control\Power" "HiberbootEnabled" REG_DWORD 0
													   Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoThumbnailCache" REG_DWORD 0
													   Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "DisableThumbnailCache" REG_DWORD 0
													   Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "NoThumbnailCache" REG_DWORD 0
													   Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "DisableThumbnailCache" REG_DWORD 0
													   Call :RegAdd "HKCU\Software\Policies\Microsoft\Windows\Explorer" "DisableThumbsDBOnNetworkFolders" REG_DWORD 0
													   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "NoThumbnailCache" REG_DWORD 0
													   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "DisableThumbnailCache" REG_DWORD 0
													   Call :RegAdd_CCS "Control\Session Manager\Memory Management" "DisablePagingExecutive" REG_DWORD 1
													   Call :RegAdd_CCS "Control\Session Manager\Memory Management\PrefetchParameters" "EnablePrefetcher" REG_DWORD 0
													   Call :RegAdd_CCS "Control\Session Manager\Memory Management\PrefetchParameters" "EnableSuperFetch" REG_DWORD 0
													   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "Enable" REG_SZ N
													   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Wbem\CIMOM" "EnableEvents" REG_DWORD 0
													   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Wbem\CIMOM" "Logging" REG_SZ 0
													   Call :RegAdd_CCS "Control\FileSystem" "NtfsDisable8dot3NameCreation" REG_DWORD 1
													   Call :RegAdd_CCS "Policies" "DisableDeleteNotification" REG_DWORD 0
													   fsutil behavior set disabledeletenotify NTFS 0 > NUL 2>&1
													   Call :Service_Admin "FontCache" 4
													   Call :Service_Admin "FontCache3.0.0.0" 4
													   Call :Service_Admin "SysMain" 4
													   Call :Service_Admin "defragsvc" 2
													   Call :Service_Admin "WSearch" 4
													   powercfg /hibernate off > NUL 2>&1
													  )
								if !errorlevel! NEQ 0 (Call :RegAdd_CCS "Control\Power" "HibernateEnabled" REG_DWORD 1
													   Call :RegAdd_CCS "Control\Power" "HibernateEnabledDefault" REG_DWORD 1
													   Call :RegAdd_CCS "Control\Power" "HiberbootEnabled" REG_DWORD 1
													   Call :RegAdd_CCS "Control\Session Manager\Memory Management\PrefetchParameters" "EnablePrefetcher" REG_DWORD 1
													   Call :RegAdd_CCS "Control\Session Manager\Memory Management\PrefetchParameters" "EnableSuperFetch" REG_DWORD 1
													   Call :RegAdd "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "Enable" REG_SZ Y
													   fsutil behavior set disabledeletenotify NTFS 1 > NUL 2>&1
													   Call :Service_Admin "FontCache" 2
													   Call :Service_Admin "FontCache3.0.0.0" 3
													   Call :Service_Admin "SysMain" 2
													   powercfg /hibernate on > NUL 2>&1
													  )
)
Call :DEL_Direct "%Konum%\Log\SSD"
REM Sistem RAM miktarına göre Svchost işlemini optimize et [İşlemci işlem sayısında ciddi düşüş yapacaktır]
Call :Playbook_Reader Optimization_Setting_14_
	if "!Playbook!" EQU "1" (FOR /F "tokens=4" %%a in ('systeminfo ^| find "Total Physical Memory"') do (
								FOR /F "delims=. tokens=1" %%b in ('echo %%a') do (
									set /a RAM=%%b * 1024 * 1024 + 1024000
								)
							 )
							 Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control" "SvcHostSplitThresholdInKB" REG_DWORD "0x!RAM!"
)
REM Farklı işlemci markasına ait hizmetleri devre dışı bırak
Call :Playbook_Reader Optimization_Setting_15_
	if "!Playbook!" EQU "1" (Call :Powershell "Get-CimInstance -ClassName Win32_Processor | Select-Object -Property Name | format-list" > %Konum%\Log\Brand
							 FOR /F "tokens=3" %%a in ('Findstr /i "Name" %Konum%\Log\Brand') do (
								if "%%a" EQU "AMD" (FOR %%b in (intelpep Telemetry iai2c iaLPSS2i_I2C iaLPSS2i_I2C_BXT_P iaLPSS2i_I2C_CNL iaLPSS2i_I2C_GLK iaLPSS2i_GPIO2_GLK iaLPSS2i_GPIO2_CNL iaLPSS2i_GPIO2_BXT_P iaLPSS2i_GPIO2 iaLPSSi_GPIO intelpmax iagpio iaStorV intelppm) do (Call :Service_Admin "%%b" 4))
								if "%%a" NEQ "AMD" (FOR %%b in (amdgpio2 amdi2c AmdPPM AmdK8 amdsata amdsbs amdxata) do (Call :Service_Admin "%%b" 4))
							 )
							 Call :DEL_Direct "%Konum%\Log\Brand"
)
REM Yüksek hassasiyetli olay zamanlayıcısı [HPET] devre dışı bırak [BIOS üzerinde ayar mevcut ise kapatmayı unutmayın]
Call :Playbook_Reader Optimization_Setting_16_
	if "!Playbook!" EQU "1" (bcdedit /deletevalue useplatformclock > NUL 2>&1
							 bcdedit /set disabledynamictick yes > NUL 2>&1
							 "%Konum%\Bin\DevManView.exe" /disable "High Precision Event Timer"
)
REM Uyku modu sistem analizini devre dışı bırak
Call :Playbook_Reader Optimization_Setting_17_
	if "!Playbook!" EQU "1" (Call :Schtasks "Disable" "\Microsoft\Windows\Power efficiency diagnostics\Analyzesystem"
							 wevtutil set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:False > NUL 2>&1
							 wevtutil set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:False > NUL 2>&1
							 wevtutil set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:False > NUL 2>&1
)
REM NTFS sıkıştırmayı devre dışı bırak
Call :Playbook_Reader Optimization_Setting_18_
	if "!Playbook!" EQU "1" (fsutil behavior set disablecompression > NUL 2>&1
)
REM MSI mode
Call :Playbook_Reader Optimization_Setting_19_
	if "!Playbook!" EQU "1" (Call :DEL_Direct "%Konum%\Log\MSIMODE.txt"
							 Call :Powershell "Get-CimInstance -ClassName Win32_USBController | Select-Object PNPDeviceID" >> %Konum%\Log\MSIMODE.txt
							 Call :Powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object PNPDeviceID" >> %Konum%\Log\MSIMODE.txt
							 Call :Powershell "Get-CimInstance -ClassName Win32_NetworkAdapter | Select-Object PNPDeviceID" >> %Konum%\Log\MSIMODE.txt
							 FOR /F %%a in ('Findstr /i "PCI\VEN_" %Konum%\Log\MSIMODE.txt 2^>NUL') do (
								Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" "MSISupported" REG_DWORD 1
							 )
)
REM Cihaz önceliklerini kaldır
Call :Playbook_Reader Optimization_Setting_20_
	if "!Playbook!" EQU "1" (FOR /F "tokens=*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "Affinity Policy" ^| Findstr /l "PCI\VEN_"') do (
								Call :RegDel "%%a" /v "DevicePriority"
							)
)
REM Dosya Gezgini hafıza sorununu gider
Call :Playbook_Reader Fix_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell" "BagMRU Size" REG_DWORD "0x4e20"
)
REM Ses ayarları hafıza sorununu gider
Call :Playbook_Reader Fix_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegKey "HKCU\Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore"
)
REM Dosya gezgini fazla ram kullanma sorununu gider [Windows11]
Call :Playbook_Reader Fix_Setting_3_
	if "!Playbook!" EQU "1" (if "%Win%" EQU "11" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SeparateProcess" REG_DWORD 0)
)
REM Adobe Typer yazı tipi sürücüsünü devre dışı bırak
Call :Playbook_Reader Security_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" "DisableATMFD" REG_DWORD 1
)
REM LanmanServer hizmetinin güvenlik sorunlarını gider
Call :Playbook_Reader Security_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Services\LanmanServer\Parameters" "AutoShareWks" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" "AllowInsecureGuestAuth" REG_DWORD "0"
)
REM Otomatik oynatma devre dışı bırak
Call :Playbook_Reader Security_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" "DisableAutoplay" REG_DWORD 0
)
REM Uzak bağlantıyla komut dosyalı tanılamalıyı devre dışı bırak
Call :Playbook_Reader Security_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\ScriptedDiagnosticsProvider\Policy" "EnableQueryRemoteServer" REG_DWORD 0
)
REM Uzak bağlantıyla zamanlanmış tanılamalıyı devre dışı bırak
Call :Playbook_Reader Security_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" "EnabledExecution" REG_DWORD 0
)
REM SMB1 veri sızıntı sorununu gider
Call :Playbook_Reader Security_Setting_6_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\Lsa\MSV1_0" "RestrictReceivingNTLMTraffic" REG_DWORD 2
							 Call :RegAdd_CCS "Control\Lsa\MSV1_0" "RestrictSendingNTLMTraffic" REG_DWORD 2
							 Call :RegAdd_CCS "Services\LanmanServer\Parameters" "SMB1" REG_DWORD 0
)
REM Uzaktan yardımı devre dışı bırak
Call :Playbook_Reader Security_Setting_7_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\Remote Assistance" "fAllowToGetHelp" REG_DWORD 0
							 Call :RegAdd_CCS "Control\Remote Assistance" "fAllowFullControl" REG_DWORD 0
							 Call :Schtasks "Disable" "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
)
REM VPN kullanırken DNS sızıntılarını engelle
Call :Playbook_Reader Security_Setting_8_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" DisableSmartNameResolution REG_DWORD 1
							 Call :RegAdd_CCS "Services\Dnscache\Parameters" DisableParallelAandAAAA REG_DWORD 1
)
REM Yapışkan tuşları kapat
Call :Playbook_Reader Feature_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Control Panel\Accessibility\StickyKeys" "Flags" REG_SZ 506
							 Call :RegAdd "HKCU\Control Panel\Accessibility\ToggleKeys" "Flags" REG_SZ "58"
)
REM Filtre tuşları kapat
Call :Playbook_Reader Feature_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Control Panel\Accessibility\Keyboard Response" "Flags" REG_SZ "122"
)
REM Hazırda beklet - Hızlı başlat kapat
Call :Playbook_Reader Feature_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\Session Manager\Power" "HiberbootEnabled" REG_DWORD "0"
							 Call :RegAdd_CCS "Control\Power" "HibernateEnabled" REG_DWORD "0"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" "ShowHibernateOption" REG_DWORD 0
							 powercfg /h off > NUL 2>&1
							 Call :DEL_Direct "%SystemDrive%\hiberfil.sys"
							 echo Call :DEL_Direct "%%SystemDrive%%\hiberfil.sys" >> C:\Playbook.Reset.After.cmd
)
REM Windows fotoğraf görüntüleyicisini aktifleştir
Call :Playbook_Reader Feature_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegVeAdd "HKCU\SOFTWARE\Classes\.jxr" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.jpe" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.dib" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.jfif" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.wdp" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.tif" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.ico" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.tiff" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.bmp" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.png" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.jpeg" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegVeAdd "HKCU\SOFTWARE\Classes\.jpg" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".jxr" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".jpeg" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".jpe" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".bmp" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".png" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".dib" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".jfif" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".wdp" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".jpg" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".tiff" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" ".tif" REG_SZ "PhotoViewer.FileAssoc.Tiff"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" "ApplicationName" REG_SZ "@%%%%ProgramFiles%%%%\Windows Photo Viewer\photoviewer.dll,-3009"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" "ApplicationDescription" REG_SZ "@%%%%ProgramFiles%%%%\Windows Photo Viewer\photoviewer.dll,-3069"
)
REM Kullanıcı hesap denetimi [UAC] devre dışı bırak
Call :Playbook_Reader Feature_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "ConsentPromptBehaviorAdmin" REG_DWORD 0
)
REM Güvenli masaüstü bildirimini kapat
Call :Playbook_Reader Feature_Setting_6_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" "ModRiskFileTypes" REG_SZ ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "PromptOnSecureDesktop" REG_DWORD 0
)
REM Fare - İşaretçi hassasiyetini arttır kapat
Call :Playbook_Reader Feature_Setting_7_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKCU\Control Panel\Mouse" MouseThreshold2 REG_SZ 10
							 Call :RegAdd "HKCU\Control Panel\Mouse" MouseThreshold1 REG_SZ 6
							 Call :RegAdd "HKCU\Control Panel\Mouse" MouseSpeed REG_SZ 0
)
REM Mavi ekran sonrasında yeniden başlatmayı devre dışı bırak
Call :Playbook_Reader Feature_Setting_8_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\CrashControl" "AutoReboot" REG_DWORD 0
)
REM Beklenmeyen kapanmalar için yapılan zaman kontrollerini devre dışı bırak
Call :Playbook_Reader Feature_Setting_9_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" "TimeStampInterval" REG_DWORD 0
)
REM Xbox - Oyun kaydetme ve yayını kapat
Call :Playbook_Reader Feature_Setting_10_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowGameDVR" REG_DWORD 0
)
REM Sorun gidericileri devre dışı bırak
Call :Playbook_Reader Feature_Setting_11_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsMitigation" "UserPreference" REG_DWORD 1
)
REM Uzak masaüstü asistanını devre dışı bırak
Call :Playbook_Reader Feature_Setting_12_
	if "!Playbook!" EQU "1" (Call :RegAdd_CCS "Control\Remote Assistance" "fAllowToGetHelp" REG_DWORD 0
							 Call :RegAdd_CCS "Control\Remote Assistance" "fAllowFullControl" REG_DWORD 0
)
REM Sistem açılışında otomatik onarım modunu devre dışı bırak
Call :Playbook_Reader Feature_Setting_13_
	if "!Playbook!" EQU "1" (bcdedit /set {current} recoveryenabled no > NUL 2>&1
)
REM Ayrılmış depolama alanını kapat
Call :Playbook_Reader Update_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" "ShippedWithReserves" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" "PassedPolicy" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" "MiscPolicyInfo" REG_DWORD 2
)
REM Windows güncelleştirmelerini kapat ve 2099 ertele
Call :Playbook_Reader Update_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoUpdate" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseFeatureUpdatesStartTime" REG_SZ "2020-01-01T22:47:13Z"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseFeatureUpdatesEndTime" REG_SZ "2099-11-10T22:47:13Z"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseQualityUpdatesStartTime" REG_SZ "2020-01-01T22:47:13Z"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseQualityUpdatesEndTime" REG_SZ "2099-11-10T22:47:13Z"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseUpdatesStartTime" REG_SZ "2020-01-01T22:47:13Z"
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "PauseUpdatesExpiryTime" REG_SZ "2099-11-10T22:47:13Z"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_LicenseAccepted"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\Schedule Work"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work"
							 Call :Schtasks "Disable" "\Microsoft\Windows\UpdateOrchestrator\Report policies"
							 Call :Schtasks "Disable" "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
							 Call :Schtasks "Disable" "\Microsoft\Windows\WaaSMedic\PerformRemediation"
)
REM Sürücüleri otomatik güncellemeyi kapat
Call :Playbook_Reader Update_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" "SearchOrderConfig" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" "ExcludeWUDriversInQualityUpdate" REG_DWORD 1
)
REM Konuşma modellerinin otomatik güncellemesini kapat
Call :Playbook_Reader Update_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" "ModelDownloadAllowed" REG_DWORD 0 
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Speech" "AllowSpeechModelUpdate" REG_DWORD 0
							 Call :Schtasks "Disable" "\Microsoft\Windows\Speech\SpeechModelDownloadTask"
)
REM Microsoft Store otomatik güncelleştirmeleri kapat
Call :Playbook_Reader Update_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "AutoDownload" REG_DWORD 2
							 REM NTLite içinde manuel olarak ayarlanıyor. Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "AutoDownload" REG_DWORD 0
)
REM Disk hatası tahmin modeli güncelleştirmelerini kapat
Call :Playbook_Reader Update_Setting_6_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageHealth" "AllowDiskHealthModelUpdates" REG_DWORD 0
							 Call :Schtasks "Disable" "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
)
REM Özellik Güncelleştirmeleri için korumaları devre dışı bırak
Call :Playbook_Reader Update_Setting_7_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" "DisableWUfBSafeguards" REG_DWORD 1 
)
REM Haritaları otomatik güncelleştirmeyi kapat
Call :Playbook_Reader Update_Setting_8_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SYSTEM\Maps" "AutoUpdateEnabled" REG_DWORD 0
							 Call :Schtasks "Disable" "\Microsoft\Windows\Maps\MapsToastTask"
							 Call :Schtasks "Disable" "\Microsoft\Windows\Maps\MapsUpdateTask"
)
REM Küçük güncelleştirmeleri otomatik yüklemeyi devre dışı bırak
Call :Playbook_Reader Update_Setting_9_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "AutoInstallMinorUpdates" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "AutoInstallMinorUpdates" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "AutoInstallMinorUpdates" REG_DWORD 1
)
REM Windows'un zamanlanmış güncellemeleri yüklemek için sistemi uyandırmasına izin verme
Call :Playbook_Reader Update_Setting_10_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "AUPowerManagement" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "AUPowerManagement" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "AUPowerManagement" REG_DWORD 0
)
REM Tarifeli bağlantı üzerinden güncelleştirme indirmeyi devre dışı bırak
Call :Playbook_Reader Update_Setting_11_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "AllowAutoWindowsUpdateDownloadOverMeteredNetwork" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "AllowAutoWindowsUpdateDownloadOverMeteredNetwork" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "AllowAutoWindowsUpdateDownloadOverMeteredNetwork" REG_DWORD 0
)
REM Windows güncellemeleri yükseltme bildirimlerini devre dışı bırak
Call :Playbook_Reader Update_Setting_12_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "HideMCTLink" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "HideMCTLink" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "HideMCTLink" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" "DisableOSUpgrade" REG_DWORD 1
)
REM Güncelleme seçenekleriyle kapatmayı devre dışı bırak
Call :Playbook_Reader Update_Setting_13_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "NoAUAsDefaultShutdownOption" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAUAsDefaultShutdownOption" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "NoAUAsDefaultShutdownOption" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "NoAUShutdownOption" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAUShutdownOption" REG_DWORD 0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "NoAUShutdownOption" REG_DWORD 0
)
REM Güncelleme sonrası otomatik yeniden başlatmayı devre dışı bırak
Call :Playbook_Reader Update_Setting_14_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "NoAutoRebootWithLoggedOnUsers" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoRebootWithLoggedOnUsers" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "NoAutoRebootWithLoggedOnUsers" REG_DWORD 1
)
REM Güncelleme sonrası yeniden başlat bildirimlerini devre dışı bırak
Call :Playbook_Reader Update_Setting_15_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RebootRelaunchTimeout" REG_DWORD 0x5a0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "RebootRelaunchTimeout" REG_DWORD 0x5a0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "RebootRelaunchTimeout" REG_DWORD 0x5a0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RebootRelaunchTimeoutEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "RebootRelaunchTimeoutEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "RebootRelaunchTimeoutEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RebootWarningTimeout" REG_DWORD 0x5a0
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "RebootWarningTimeout" REG_DWORD 0x5a0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "RebootWarningTimeout" REG_DWORD 0x5a0
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RebootWarningTimeoutEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "RebootWarningTimeoutEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "RebootWarningTimeoutEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RescheduleWaitTime" REG_DWORD 0x14
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "RescheduleWaitTime" REG_DWORD 0x14
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "RescheduleWaitTime" REG_DWORD 0x14
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RescheduleWaitTimeEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "RescheduleWaitTimeEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "RescheduleWaitTimeEnabled" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RestartNotificationsAllowed" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "RestartNotificationsAllowed" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "RestartNotificationsAllowed" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "RestartNotificationsAllowed2" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "RestartNotificationsAllowed2" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "RestartNotificationsAllowed2" REG_DWORD 1
)
REM Windows aygıt meta verilerini internetten almayı devre dışı bırak
Call :Playbook_Reader Update_Setting_16_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" PreventDeviceMetadataFromNetwork REG_DWORD 0
)
REM Güncelleme bildirimlerini devre dışı bırak
Call :Playbook_Reader Update_Setting_17_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "SetUpdateNotificationLevel" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "SetUpdateNotificationLevel" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "SetUpdateNotificationLevel" REG_DWORD 1
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "UpdateNotificationLevel" REG_DWORD 2
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "UpdateNotificationLevel" REG_DWORD 2
							 Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" "UpdateNotificationLevel" REG_DWORD 2
							 Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" "DisableGwx" REG_DWORD 1
)
REM Beni güncel tut bildirimini kapat [Windows11]
Call :Playbook_Reader Update_Setting_18_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "IsExpedited" REG_DWORD 0
)
REM Windows Search - Arama yardımcısı içerik güncelleştirmelesini devre dışı bırak
Call :Playbook_Reader Update_Setting_19_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\SearchCompanion" "DisableContentFileUpdates" REG_DWORD 1
)
REM Windows'u güncelleştirdiğimde diğer Microsoft uygulamalarının güncelleştirmelerini devre dışı bırak
Call :Playbook_Reader Update_Setting_20_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\Pending\7971f918-a847-4430-9279-4a52d1efe18d" "RegisterWithAU" REG_DWORD 0
)
REM OOBE Uygulamaları Tarama Çalışmasını devre dışı bırak
Call :Playbook_Reader Update_Setting_21_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler" "OobeAppsScanRun" REG_DWORD 0
)
REM En son güncellemeleri hazır olur olmaz alın özelliğini devre dışı bırak
Call :Playbook_Reader Update_Setting_22_
	if "!Playbook!" EQU "1" (Call :RegAdd "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "IsContinuousInnovationOptedIn" REG_DWORD 0
)
REM DevHomeUpdate devre dışı bırak [Microsoft proje yönetim uygulamasının otomatik kurulmasını engeller]
Call :Playbook_Reader Taskschd_Update_Setting_1_
	if "!Playbook!" EQU "1" (Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\DevHomeUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\Settings" /v "OOBEEXPEDITEALLOWEDUPDATERS"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\USOShared\ScheduleTimeDump"
)
REM IA devre dışı bırak [Microsoft güncelleştirme kanalı üzerinden Market için kritik güncelleştirmeleri yapar]
Call :Playbook_Reader Taskschd_Update_Setting_2_
	if "!Playbook!" EQU "1" (Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\IA"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\IA"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\Settings" /v "OOBEEXPEDITEALLOWEDUPDATERS"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\USOShared\ScheduleTimeDump"
)
REM LXP devre dışı bırak [Yerel deneyim paketleri - Dil paket güncelleştirmelerini market güncelleştirme kanalından sunar]
Call :Playbook_Reader Taskschd_Update_Setting_3_
	if "!Playbook!" EQU "1" (Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\LXP"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\LXP"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\Settings" /v "OOBEEXPEDITEALLOWEDUPDATERS"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\USOShared\ScheduleTimeDump"
)
REM MACUpdate devre dışı bırak [Bu konuda bilgi bulamadım ancak tahminimce Windows yüklü MAC cihazlar için bir özellik güncelleştirmesi içeriyor]
Call :Playbook_Reader Taskschd_Update_Setting_4_
	if "!Playbook!" EQU "1" (Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\MACUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\MACUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\Settings" /v "OOBEEXPEDITEALLOWEDUPDATERS"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\USOShared\ScheduleTimeDump"
)
REM OutlookUpdate devre dışı bırak [Yeni Outlook uygulamasının otomatik kurulmasını engeller]
Call :Playbook_Reader Taskschd_Update_Setting_5_
	if "!Playbook!" EQU "1" (Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\OutlookUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\Settings" /v "OOBEEXPEDITEALLOWEDUPDATERS"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\USOShared\ScheduleTimeDump"
)
REM TFLUpdate devre dışı bırak [Londra şehrinin ulaşım hizmetleri hakkında bilgi veren Market tabanlı uygulamanın yüklenmesini sağlar. Bölgelese çalışdığını düşünüyorum ancak siz kapatmayı ihmal etmeyin. Microsoft bildiğimiz gibi :D]
Call :Playbook_Reader Taskschd_Update_Setting_6_
	if "!Playbook!" EQU "1" (Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\TFLUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\TFLUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\Settings" /v "OOBEEXPEDITEALLOWEDUPDATERS"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\USOShared\ScheduleTimeDump"
)
REM Edge otomatik yüklemeyi devre dışı bırakır.
Call :Playbook_Reader Taskschd_Update_Setting_7_
	if "!Playbook!" EQU "1" (Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\EdgeUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\EdgeUpdate"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\Settings" /v "OOBEEXPEDITEALLOWEDUPDATERS"
							 Call :RegDel "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\USOShared\ScheduleTimeDump"
)
REM Masaüstü duvar kağıdı görüntü kalitesini değiştir
Call :Playbook_Reader Special_Setting_1_
	if "!Playbook!" EQU "1" (Call :Playbook_Reader_Special Special_Setting_1_
							 Call :RegAdd "HKCU\Control Panel\Desktop" "JPEGImportQuality" REG_DWORD !PBSpecial!
)
REM Menü gösterim gecikme süresini düşür [Varsayılan değer= 400]
Call :Playbook_Reader Special_Setting_2_
	if "!Playbook!" EQU "1" (Call :Playbook_Reader_Special Special_Setting_2_
							 Call :RegAdd "HKCU\Control Panel\Desktop" "MenuShowDelay" REG_SZ !PBSpecial!
)
REM Fare ile bir öğenin üzerine gelindiğinde bilgi penceresi gösterim süresi [Varsayılan değer= 400]
Call :Playbook_Reader Special_Setting_3_
	if "!Playbook!" EQU "1" (Call :Playbook_Reader_Special Special_Setting_3_
							 Call :RegAdd "HKCU\Control Panel\Mouse" "MouseHoverTime" REG_SZ !PBSpecial!
)
REM -------------------------------------------------------------
cls&Call :Dil A 2 P1007&title OgnitorenKs Playbook │ 5/7 │ !LA2!
REM Regedit kayıtlarının çıktılarını gizlemek için
set Show=0
REM Playbook.ini CMD komutları uygulama bölümü
FOR /F "delims=► tokens=2" %%a in ('Findstr /i "CMD_Command" %PB% 2^>NUL') do (
	%%a > NUL 2>&1
		if !errorlevel! NEQ 0 (%NSudo% %%a)
)
REM -------------------------------------------------------------
REM Playbook.ini Powershell komutları uygulama bölümü
FOR /F "delims=► tokens=2" %%a in ('Findstr /i "Powershell_Command" %PB% 2^>NUL') do (
	Call :Powershell_Playbook %%a > NUL 2>&1
		if "!errorlevel!" NEQ "0" (%NSudo% Powershell %%a)
)
REM -------------------------------------------------------------
REM Ayarlardan gizlenecek bölümler yapılandırılıyor
REM İlgili ayar playbook bölümünde yer almıyorsa işlemi gerçekleştirmez
Call :Playbook_Reader_2 "Settings_Hide"
	if "!Playbook!" EQU "1" (FOR /F "delims=> tokens=2" %%a in ('Findstr /i "Settings_Hide" %PB%') do (Call :Reg_Hide "%%a")
)
REM -------------------------------------------------------------
REM Görev zamanlayıcısı ayarları yapılandırılıyor
Findstr /i "Task_Scheduler_Setting" %PB% > NUL 2>&1
	if "!errorlevel!" EQU "0" (FOR /F "delims=► tokens=2" %%a in ('Findstr /i "Task_Scheduler_Setting" %PB%') do (
								   FOR /F "tokens=2" %%b in ('Findstr /i "%%a" %PB%') do (
									   if "%%b" EQU "1" (Call :Schtasks "Disable" "%%a")
									   if "%%b" EQU "2" (Call :Schtasks-Remove "%%a")
								   )
							   )
)
REM -------------------------------------------------------------
REM Aygıt yöneticisi - Devmainview
FOR /F "delims=► tokens=2" %%a in ('Findstr /i "Devmainview_Setting" %PB%') do (
	FOR /F "skip=2 tokens=2" %%b in ('Find "%%a" %PB%') do (
		if "%%b" EQU "1" (%Konum%\Bin\DevManView.exe /disable "%%a" > NUL 2>&1)
	)
)
REM -------------------------------------------------------------
REM Sistem açılış ismi değiştir
Call :Playbook_Reader_2 "System_New_Name"
	if "!Playbook!" EQU "1" (FOR /F "delims='=' tokens=2" %%a in ('Findstr /i "System_New_Name" %PB%') do (bcdedit /set {current} description "%%a" > NUL 2>&1)
)

REM -------------------------------------------------------------
echo ►%R%[92m !LA2! %R%[0m
REM Özel güç ayarı ekleme bölümü
Call :Playbook_Reader_2 "Power_Link_"
	if "!Playbook!" EQU "1" (FOR /F "delims=► tokens=2" %%a in ('Findstr /i "Power_Link_" %PB%') do (
								FOR /F "delims=► tokens=3" %%b in ('Findstr /i "Power_Link_" %PB%') do (
									Call :Powershell "& { iwr '%%a' -OutFile '%Temp%\%%b' }"
									powercfg -import "%Temp%\%%b" 12345678-1234-1234-1234-123456789012 > NUL 2>&1
									powercfg /SETACTIVE "12345678-1234-1234-1234-123456789012" > NUL 2>&1
									Call :DEL_Direct "%Temp%\%%b"
								)
							)
)
REM Özel masaüstü resmi entegre etme
Call :Playbook_Reader_2 "Wallpaper_Link_"
	if "!Playbook!" EQU "1" (FOR /F "delims=► tokens=2" %%a in ('Findstr /i "Wallpaper_Link_" %PB%') do (
								FOR /F "delims=► tokens=3" %%b in ('Findstr /i "Wallpaper_Link_" %PB%') do (
									Call :Powershell "& { iwr '%%a' -OutFile 'C:\Users\%username%\Pictures\%%b' }"
									Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "Wallpaper" REG_SZ "C:\Users\%username%\Pictures\%%b"
									Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "WallpaperStyle" REG_SZ 4
								)
							)
)
REM -------------------------------------------------------------
Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\Subscriptions"
Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\SuggestedApps"
Call :DEL_Direct "%Konum%\Log\C_Packages"
Call :DEL_Direct "%Konum%\Log\C_Capabilities"
Call :DEL_Direct "%Konum%\Log\Capabilities"
Call :DEL_Direct "%Konum%\Log\Features"
REM -------------------------------------------------------------
REM Settings.ini dosyasından temizlik işleminin yapılıp yapılmayacağını kontrol eder
set Value_T=NT
FOR /F "tokens=2" %%a in ('Findstr /i "Process_Clear_" %PB% 2^>NUL') do (set Value_T=%%a)
	if "!Value_T!" EQU "0" (Call :DEL_Direct "C:\Playbook.Reset.After.cmd"
							goto Pass_2
)
REM -------------------------------------------------------------
cls&Call :Dil A 2 P1006&title OgnitorenKs Playbook │ 6/7 │ !LA2!
set Show=1
Call :Dil K 2 T0008
FOR %%a in (
"%windir%\*.log"
"%windir%\CbsTemp\*"
"%windir%\Logs\*"
"%Windir%\System32\LogFiles\WMI\*"
"%Windir%\System32\LogFiles\Scm\*"
) do (
	Call :DEL_Search %%a
)
REM -------------------------------------------------------------
FOR %%a in (
"%windir%\WinSxS\Temp"
"%windir%\WinSxS\Backup"
"%windir%\Containers"
"%Windir%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization"
"%ProgramData%\Package Cache"
) do (
	Call :RD_Direct %%a
)
REM Sistem geri yükleme kayıtlarını temizler
REM "%SystemDrive%\System Volume Information"
REM -------------------------------------------------------------
FOR %%a in (
"%Windir%\CbsTemp\*"
"%windir%\Logs\*"
"%Windir%\assembly\NativeImage*"
) do (
	Call :RD_Search %%a
)
REM -------------------------------------------------------------
FOR /F "tokens=*" %%a in ('dir /ad /b "%LocalAppData%\Packages\*" 2^>NUL') do (
	%NSudo% RD /S /Q "%LocalAppData%\Packages\%%a\AC\INetCache"
	%NSudo% RD /S /Q "%LocalAppData%\Packages\%%a\AC\Temp"
)
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\INetCache\IE"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\INetCache\Low"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\INetCache\Virtualized"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\IE"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\Low"
Call :RD_Direct "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\Virtualized"
Call :RD_Direct "%Windir%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\IE"

REM -------------------------------------------------------------
Call :RD_Direct "%ProgramData%\Microsoft\Windows\WER\ReportArchive"
Call :RD_Direct "%ProgramData%\Microsoft\Windows\WER\Temp"
Call :RD_Direct "%ProgramFiles%\$Recycle.Bin\!CUS!"
REM -------------------------------------------------------------
net stop wuauserv > NUL 2>&1
Call :RD_Direct "%windir%\SoftwareDistribution"
net start wuauserv > NUL 2>&1
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "OgnitorenKs_Playbook" REG_SZ "C:\Playbook.Reset.After.cmd"
set Show=0
Call :Dil A 2 P5001&echo %R%[33m !LA2! %R%[0m
(
echo ie4uinit.exe -show
echo ie4uinit.exe -ClearIconCache
echo taskkill /f /im explorer.exe ^> NUL 2^>^&1
echo Call :DEL_Direct "%%LocalAppData%%\IconCache.db"
echo Call :DEL_Search "%%LocalAppData%%\Microsoft\Windows\Explorer\*"
echo Call :DEL_Search "%%LocalAppData%%\Microsoft\Windows\Explorer\IconCacheToDelete\*"
echo Call :DEL_Search "%%LocalAppData%%\Microsoft\Windows\Explorer\NotifyIcon\*"
echo Call :DEL_Search "%%LocalAppData%%\Microsoft\Windows\Explorer\thumbcache_*.db"
echo Call :RD_Direct "%%LocalAppData%%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\AppIconCache"
echo MD "%%LocalAppData%%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\AppIconCache" ^> NUL 2^>^&1
echo Call :DEL_Search "%%LocalAppData%%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\TempState\*"
echo reg delete "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams /f ^> NUL 2^>^&1
echo reg delete "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream /f ^> NUL 2^>^&1
echo Call :Powershell "Start-Process '%%Windir%%\explorer.exe'"
echo Call :DEL_Search "%%Temp%%\*"
echo Call :RD_Search "%%temp%%\*"
echo Call :DEL_Search "%%Windir%%\Temp\*"
echo Call :RD_Search "%%Windir%%\Temp\*"
echo Call :DEL_Search "%%LocalAppData%%\Temp\*"
echo Call :RD_Search "%%LocalAppData%%\Temp\*"
echo Call :DEL_Search "%%Windir%%\System32\config\systemprofile\AppData\Local\*.tmp"
echo Call :DEL_Deep_Search "%%systemdrive%%\*log"
echo Call :DEL_Deep_Search "%%Windir%%\*etl"
echo Call :DEL_Deep_Search "%%LocalAppData%%\*etl"
echo FOR %%%%g in ^(msi msp^) do ^(Call :DEL_Deep_Search "%%Windir%%\Installer\*.%%%%g"^)
echo Call :DEL_Deep_Search "%%Windir%%\Installer\SourceHash*"
echo Call :RD_Search "%%Windir%%\Installer\$PatchCache$\Managed\*"
echo Call :RD_Search "%%Windir%%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*"
echo Call :DEL_Search "%%Windir%%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*"
echo Call :RD_Direct "%%Windir%%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache"
echo Call :DEL_Search "%%Windir%%\prefetch\*"
echo Call :DEL_Search "%%ProgramData%%\Microsoft\Diagnosis\ETLLogs\AutoLogger\*.etl"
echo Call :DEL_Search "%%LocalAppData%%\tw-*.tmp"
echo Call :DEL_Direct "%%SystemRoot%%\DtcInstall.log"
echo Call :DEL_Direct "%%SystemRoot%%\comsetup.log"
echo Call :DEL_Direct "%%SystemRoot%%\PFRO.log"
echo Call :DEL_Direct "%%SystemRoot%%\setupact.log"
echo Call :DEL_Direct "%%SystemRoot%%\setupapi.log"
echo Call :DEL_Direct "%%SystemRoot%%\Panther\*"
echo Call :DEL_Direct "%%SystemRoot%%\inf\setupapi.app.log"
echo Call :DEL_Direct "%%SystemRoot%%\inf\setupapi.dev.log"
echo Call :DEL_Direct "%%SystemRoot%%\inf\setupapi.offline.log"
echo Call :DEL_Direct "%%SystemRoot%%\Performance\WinSAT\winsat.log"
echo Call :DEL_Direct "%%SystemRoot%%\debug\PASSWD.LOG"
echo Call :DEL_Search "%%localappdata%%\Microsoft\Windows\WebCache\*.*"
echo Call :DEL_Search "%%SystemRoot%%\ServiceProfiles\LocalService\AppData\Local\Temp\*.*"
echo Call :DEL_Direct "%%SystemRoot%%\Logs\CBS\CBS.log"
echo Call :DEL_Direct "%%SystemRoot%%\Logs\DISM\DISM.log"
echo Call :DEL_Search "%%SystemRoot%%\Logs\SIH\*"
echo Call :DEL_Search "%%LocalAppData%%\Microsoft\CLR_v4.0\UsageTraces\*"
echo Call :DEL_Search "%%LocalAppData%%\Microsoft\CLR_v4.0_32\UsageTraces\*"
echo Call :DEL_Search "%%SystemRoot%%\Logs\NetSetup\*"
echo Call :DEL_Search "%%SystemRoot%%\System32\LogFiles\setupcln\*"
echo Call :DEL_Search "%%SystemRoot%%\Temp\CBS\*"
echo Call :DEL_Direct "%%SystemRoot%%\System32\catroot2\dberr.txt"
echo Call :DEL_Direct "%%SystemRoot%%\System32\catroot2.log"
echo Call :DEL_Direct "%%SystemRoot%%\System32\catroot2.jrs"
echo Call :DEL_Direct "%%SystemRoot%%\System32\catroot2.edb"
echo Call :DEL_Direct "%%SystemRoot%%\System32\catroot2.chk"
echo Call :DEL_Search "%%SystemRoot%%\Logs\SIH\*"
echo Call :DEL_Search "%%SystemRoot%%\Traces\WindowsUpdate\*"
echo Call :RD_Direct "%%SystemRoot%%\Logs\waasmedic"
echo Call :RD_Direct "%%ProgramData%%\Package Cache"
echo Call :RD_Direct "%%systemdrive%%\AMD"
echo Call :RD_Direct "%%systemdrive%%\NVIDIA"
echo Call :RD_Direct "%%systemdrive%%\INTEL"
echo Call :RD_Direct "%%systemdrive%%\$WinREAgent"
echo Call :RD_Direct "C:\$Recycle.Bin\!CUS!"
echo net stop wuauserv /y ^> NUL 2^>^&1
echo Call :RD_Direct "%%windir%%\SoftwareDistribution"
echo net start wuauserv /y ^> NUL 2^>^&1
echo Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
echo ipconfig /flushdns ^> NUL 2^>^&1
echo ipconfig /release ^> NUL 2^>^&1
echo ipconfig /renew ^> NUL 2^>^&1
echo FOR /F "tokens=*" %%%%g in ^('wevtutil.exe el'^) do ^(wevtutil.exe cl "%%%%g" ^> NUL 2^>^&1^)
echo Call :RD_Direct "%%windir%%\WinSxS\Temp"
echo Call :RD_Direct "%%windir%%\WinSxS\Backup"
echo Call :RD_Search "%%Windir%%\assembly\NativeImage*"
echo Call :DEL_Search "%%Windir%%\System32\LogFiles\WMI\*"
echo Call :DEL_Search "%%Windir%%\System32\LogFiles\Scm\*"
echo Call :RD_Direct "%%windir%%\Containers"
echo Call :DEL_Search "%%Windir%%\CbsTemp\*"
echo Call :DEL_Search "%%windir%%\Logs\*"
echo Call :RD_Search "%%windir%%\Logs\*"
echo Call :RD_Direct "%%ProgramData%%\Microsoft\Windows\WER\ReportArchive"
echo Call :RD_Direct "%%ProgramData%%\Microsoft\Windows\WER\Temp"
echo FOR /F "tokens=*" %%%%a in ^('dir /b "%%LocalAppData%%\Packages\*" 2^^^>NUL'^) do ^(
echo    Call :RD_Direct "%%LocalAppData%%\Packages\%%%%a\AC\INetCache"
echo    Call :RD_Direct "%%LocalAppData%%\Packages\%%%%a\AC\Temp"
echo ^)
echo Call :RD_Direct "%%LocalAppData%%\Microsoft\Windows\INetCache\IE"
echo Call :RD_Direct "%%LocalAppData%%\Microsoft\Windows\INetCache\Low"
echo Call :RD_Direct "%%LocalAppData%%\Microsoft\Windows\INetCache\Virtualized"
echo Call :RD_Direct "%%LocalAppData%%\Microsoft\Windows\Temporary Internet Files\IE"
echo Call :RD_Direct "%%LocalAppData%%\Microsoft\Windows\Temporary Internet Files\Low"
echo Call :RD_Direct "%%LocalAppData%%\Microsoft\Windows\Temporary Internet Files\Virtualized"
echo Call :RD_Direct "%%Windir%%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\IE"
echo chcp 437 ^> NUL
echo PowerShell -ExecutionPolicy Unrestricted -Command "$bin = (New-Object -ComObject Shell.Application).NameSpace(10); $bin.items() | ForEach {; Write-Host "^^^""Deleting $($_.Name) from Recycle Bin"^^^""; Remove-Item $_.Path -Recurse -Force; }"
echo chcp 65001 ^> NUL
echo.
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OgnitorenKs_Playbook" /f ^> NUL 2^>^&1
echo DEL /F /Q /A "C:\Playbook.Reset.After.cmd" ^> NUL 2^>^&1
echo exit
echo :Powershell
echo chcp 437 ^> NUL 2^>^&1
echo Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C %%*
echo chcp 65001 ^> NUL 2^>^&1
echo goto :eof
) >> C:\Playbook.Reset.After.cmd
REM Sistem geri yükleme bölümlerini temizler
REM echo Call :RD_Direct "%%SystemDrive%%\System Volume Information"
REM -------------------------------------------------------------
:Pass_2
REM Winget üzeri indirme linki alınır ve yükleme işlemi yapılır.
cls&Call :Dil A 2 P1005&title OgnitorenKs Playbook │ 7/7 │ !LA2!
Call :Dil B 2 T0011
Call :Playbook_Reader_2 "Download_Application"
	if "!Playbook!" EQU "1" (FOR /F "tokens=4" %%b in ('Findstr /i "Download_Application" %PB% 2^>NUL') do (
								FOR /F "tokens=2" %%c in ('Findstr /i "► %%b" %PB% 2^>NUL') do (
									if "%%c" EQU "1" (winget list "%%b" --accept-source-agreements > NUL 2>&1
														if "!errorlevel!" NEQ "0" (Call :Winget_Link "%%b"
																				   Call :Echo_Print ►%R%[33m !Setup!%R%[37m !LB2! %R%[0m
																				   Call :PSDownload "%Konum%\Log\!Setup!"
																				   "%Konum%\Log\!Setup!" !Silent!
																				   echo %%b | Findstr /i "Open-Shell" > NUL 2>&1
																						if "!errorlevel!" EQU "0" (Call :Openshell_Setting)
																				   Call :DEL_Direct "%Konum%\Log\!Setup!"
																				   )
			)
		)
	)
)
REM İşi biten değişkenleri sıfırlıyorum
FOR %%a in (Silent Setup Link) do (set %%a=)
REM -------------------------------------------------------------
REM Uygulama yükleyici
Call :Dil B 2 T0011
Call :Playbook_Reader_2 "Install_Application"
	if "!Playbook!" EQU "1" (FOR /F "tokens=4" %%a in ('Findstr /i "Install_Application" %PB%') do (
								FOR /F "skip=2 tokens=2" %%b in ('Find "► %%a" %PB%') do (
									if "%%b" EQU "1" (echo %%a | Findstr /i "sylikc.JPEGView" > NUL 2>&1
														if "!errorlevel!" EQU "0" (Call :Jpegview_Default)
													  echo %%a | Findstr /i "7zip.7zip" > NUL 2>&1
														if "!errorlevel!" EQU "0" (Call :7Zip_Default)
													  echo ► %R%[92m "%%a" %R%[37m !LB2! %R%[0m  
													  Call :Winget "%%a
													 )
		)
	)
)
REM -------------------------------------------------------------
REM İşlemler tamamlandı reset atıyoruz.
shutdown -r -f -t 5
goto Main_Menu

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:7Zip_Default
MD "%ProgramFiles%\7-Zip" > NUL 2>&1
Copy /y "%Konum%\Bin\Icon\7-zipp.ico" "%programfiles%\7-Zip" > NUL 2>&1
set AppRoad=%programfiles%\7-Zip\7zFM.exe
set AppIcon=%programfiles%\7-Zip\7-zipp.ico
set AppKey=7-Zip
set Default=001 7z apfs arj bz2 bzip2 cpio deb dmg esd fat gz gzip hfs lha lzh lzma ntfs rar rpm squashfs swm tar taz tbz tbz2 tgz tpz txz wim xar xz z zip
Call :Default_App
Call :RegAdd "HKCU\Software\7-Zip\Options" "ContextMenu" REG_DWORD 4390
Call :RegAdd "HKCU\Software\7-Zip\Options" "MenuIcons" REG_DWORD 1
goto :eof

:Jpegview_Default
set AppRoad=%programfiles%\JPEGView\JPEGView.exe
set AppIcon=%programfiles%\JPEGView\JPEGView.exe
set AppKey=JPEGView
set Default=bmp jpg jpeg png gif tiff webp tga jxl heif heic avif wdp hdp jxr dng crw cr2 nef nrw arw sr2 orf rw2 raf x3f pef mrw kdc dcr wic
Call :Default_App
MD "%AppData%\JPEGView" > NUL 2>&1
Copy /y "%Konum%\Bin\Icon\JPEGView.ini" "%AppData%\JPEGView" > NUL 2>&1
goto :eof

:Openshell_Setting
"C:\Program Files\Open-Shell\StartMenu.exe" -exit > NUL 2>&1
Taskkill /f im "StartMenu.exe" > NUL 2>&1
Call :RegAdd "HKLM\SOFTWARE\OpenShell\StartMenu" "MenuStyle_Default" REG_SZ "Win7"
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "GlassOverride" REG_DWORD 1
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "GlassColor" REG_DWORD 0
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "StartScreenShortcut" REG_DWORD 0
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "RecentMetroApps" REG_DWORD 1
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "SearchInternet" REG_DWORD 0
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "SkinW7" REG_SZ "Midnight"
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "ShiftWin" REG_SZ "Nothing"
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "ProgramsStyle" REG_SZ "Inline"
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "RecentPrograms" REG_SZ "None"
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "SearchBox" REG_SZ "Normal"
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "SkinVariationW7" REG_SZ ""
Call :RegAdd "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" "SkipMetro" REG_DWORD 1
reg add "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" /f /v "SkinOptionsW7" /t REG_MULTI_SZ /d "USER_IMAGE=1"\0"SMALL_ICONS=0"\0"LARGE_FONT=0"\0"DISABLE_MASK=1"\0"OPAQUE=0"\0"TRANSPARENT_LESS=1"\0"TRANSPARENT_MORE=0"\0"WHITE_SUBMENUS2=1" > NUL 2>&1
reg add "HKU\!CUS!\SOFTWARE\OpenShell\StartMenu\Settings" /f /v "MenuItems7" /t REG_MULTI_SZ /d "Item1.Command=user_files"\0"Item1.Settings=TRACK_RECENT"\0"Item2.Command=user_documents"\0"Item2.Settings=ITEM_DISABLED"\0"Item3.Command=user_pictures"\0"Item3.Settings=ITEM_DISABLED"\0"Item4.Command=user_music"\0"Item4.Settings=ITEM_DISABLED"\0"Item5.Command=user_videos"\0"Item5.Settings=ITEM_DISABLED"\0"Item6.Command=downloads"\0"Item6.Settings=ITEM_DISABLED"\0"Item7.Command=homegroup"\0"Item7.Settings=ITEM_DISABLED"\0"Item8.Command=separator"\0"Item9.Command=games"\0"Item9.Settings=TRACK_RECENT|NOEXPAND|ITEM_DISABLED"\0"Item10.Command=favorites"\0"Item10.Settings=ITEM_DISABLED"\0"Item11.Command=recent_documents"\0"Item11.Settings=ITEM_DISABLED"\0"Item12.Command=computer"\0"Item12.Settings=NOEXPAND"\0"Item13.Command=network"\0"Item13.Settings=ITEM_DISABLED"\0"Item14.Command=network_connections"\0"Item14.Settings=ITEM_DISABLED"\0"Item15.Command=separator"\0"Item15.Settings=ITEM_DISABLED"\0"Item16.Command=control_panel"\0"Item16.Settings=TRACK_RECENT"\0"Item17.Command=pc_settings"\0"Item17.Settings=TRACK_RECENT"\0"Item18.Command=admin"\0"Item18.Settings=TRACK_RECENT"\0"Item19.Command=devices"\0"Item19.Settings=ITEM_DISABLED"\0"Item20.Command=defaults"\0"Item20.Settings=ITEM_DISABLED"\0"Item21.Command=help"\0"Item21.Settings=ITEM_DISABLED"\0"Item22.Command=run"\0"Item22.Settings=ITEM_DISABLED"\0"Item23.Command=apps"\0"Item24.Command=windows_security"\0"Item24.Settings=ITEM_DISABLED"\0" > NUL 2>&1
Call :Powershell "Start-Process '%ProgramFiles%\Open-Shell\StartMenu.exe'"
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:Defender_Regedit
Call :Service_Admin SecurityHealthService %~1
Call :Service_Admin Sense %~1
Call :Service_Admin SgrmBroker %~1
Call :Service_Admin WdNisSvc %~1
Call :Service_Admin WinDefend %~1
Call :Service_Admin wscsvc %~1
Call :Service_Admin WdNisDrv %~1
Call :Service_Admin WdFilter %~1
Call :Service_Admin WdBoot %~1
Call :Service_Admin SgrmAgent %~1
Call :Service_Admin MsSecFlt %~1
Call :Service_Admin webthreatdefsvc 4
Call :Service_Admin webthreatdefusersvc 4
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
Call :RegAdd_CCS "Control\WMI\Autologger\DefenderApiLogger" "Start" REG_DWORD "0"
Call :RegAdd_CCS "Control\WMI\Autologger\DefenderAuditLogger" "Start" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "HidRAHealth" REG_DWORD "1"
Call :RegAdd_CCS "Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 0
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
Call :RegDel "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}"
Call :Schtasks "Disable" "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
Call :Schtasks "Disable" "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
Call :Schtasks "Disable" "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
Call :Schtasks "Disable" "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
goto :eof

REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:SS_16
if !Value! EQU E (set VR=1)
if !Value! EQU D (set VR=0)
Call :RegAdd_CCS "Control\Power" "HibernateEnabled" REG_DWORD !VR!
Call :RegAdd_CCS "Control\Session Manager\Power" "HiberbootEnabled" REG_DWORD !VR!
goto :eof

:SS_29
if !Value! EQU D (Call :RegDel "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\WOW6432Node\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegDel "HKCR\WOW6432Node\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\FileHistory" "Disabled" REG_DWORD 1
				  Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" "RPSessionInterval" REG_DWORD 0
				  FOR /F "tokens=1" %%g in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f "{" ^| Findstr /i "{" 2^>NUL') do (Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /v "%%g")
				  FOR /F "tokens=1" %%g in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Leases" /f "{" ^| Findstr /i "{" 2^>NUL') do (Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Lease" /v "%%g")
				  schtasks /change /TN "\Microsoft\Windows\SystemRestore\SR" /DISABLE > NUL 2>&1
				  Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" "DisableConfig" REG_DWORD "1"
				  Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" "DisableSR" REG_DWORD "1"
				  Call :RD_Direct "%SystemDrive%\System Volume Information"
)
if !Value! EQU E (Call :RegKey "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\WOW6432Node\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegKey "HKCR\WOW6432Node\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}"
				  Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\FileHistory" "Disabled" REG_DWORD 0
				  Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" "RPSessionInterval" REG_DWORD 1
				  schtasks /change /TN "\Microsoft\Windows\SystemRestore\SR" /ENABLE > NUL 2>&1
				  Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" "DisableConfig" REG_DWORD "0"
				  Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" "DisableSR" REG_DWORD "0"
)
goto :eof

:Developer
goto :eof