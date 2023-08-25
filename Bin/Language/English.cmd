::
:: ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ► ►
:: #########################################################################################################
:: Yönlendirme yapılır
Call %*
goto :eof
:: #########################################################################################################
:: ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄ ◄
:Menu_1
echo        %R%[90m┌────────────────────────────────────────┬───────────────────────────────────────────┐%R%[0m
echo        %R%[90m│%R%[32m 1%R%[90m-%R%[33m Application Installer %R%[90m[M]           │%R%[32m  8%R%[90m-%R%[33m Registered WiFi information           %R%[90m│%R%[0m
echo        %R%[90m│%R%[32m 2%R%[90m-%R%[33m Service management %R%[90m[M]              │%R%[32m  9%R%[90m-%R%[33m System cleaning                       %R%[90m│%R%[0m 
echo        %R%[90m│%R%[32m 3%R%[90m-%R%[33m Feature management %R%[90m[M]              │%R%[32m 10%R%[90m-%R%[33m Windows-Store Repair                  %R%[90m│%R%[0m
echo        %R%[90m│%R%[32m 4%R%[90m-%R%[33m PC timed shutdown %R%[90m                  │%R%[32m 11%R%[90m-%R%[33m System optimization [Playbook]        %R%[90m│%R%[0m
echo        %R%[90m│%R%[32m 5%R%[90m-%R%[33m Ping meter %R%[90m                         │%R%[32m  %R%[33m%R%[90m                                         │%R%[0m
echo        %R%[90m│%R%[32m 6%R%[90m-%R%[33m License-Account Management %R%[90m         │%R%[32m  Z%R%[90m-%R%[37m Language Setting                      %R%[90m│%R%[0m
echo        %R%[90m│%R%[32m 7%R%[90m-%R%[33m About the system %R%[90m                   │%R%[32m  X%R%[90m-%R%[37m Close                                 %R%[90m│%R%[0m
echo        %R%[90m└────────────────────────────────────────┴───────────────────────────────────────────┘%R%[0m
goto :eof

:Menu_2
set ogniogniogniogniognio=%R%[90m ▼
echo.
echo   %R%[90m Don't forget to update the 'App Installer' with the Microsoft Store%R%[0m
echo   %R%[90m┌──────────────────────────────┬──────────────────────────────┬──────────────────────────────┐%R%[0m
echo   %R%[90m│%R%[32m  1%R%[90m-%R%[33m All in One Runtimes      %R%[90m│%R%[32m 28%R%[90m-%R%[33m Shoutcut                 %R%[90m│%R%[32m 55%R%[90m-%R%[33m Git                      %R%[90m│%R%[0m
echo   %R%[90m│%ogniogniogniogniognio% Message                    %R%[90m│%R%[32m 39%R%[90m-%R%[33m Krita                    %R%[90m│%R%[32m 56%R%[90m-%R%[33m Node.JS                  %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  2%R%[90m-%R%[36m Discord                  %R%[90m│%R%[32m 30%R%[90m-%R%[33m Gimp                     %R%[90m│%R%[32m 57%R%[90m-%R%[33m Unity Hub                %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  3%R%[90m-%R%[36m Whatsapp                 %R%[90m│%R%[32m 31%R%[90m-%R%[33m Jpegview                 %R%[90m│%R%[32m 58%R%[90m-%R%[33m Blender                  %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  4%R%[90m-%R%[36m Signal                   %R%[90m│%R%[32m 32%R%[90m-%R%[33m OBS Studio               %R%[90m│%ogniogniogniogniognio% Remote Connection          %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  5%R%[90m-%R%[36m Telegram                 %R%[90m│%R%[32m 33%R%[90m-%R%[33m ShareX                   %R%[90m│%R%[32m 59%R%[90m-%R%[36m Teamviewer               %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  6%R%[90m-%R%[36m Zoom                     %R%[90m│%R%[32m 34%R%[90m-%R%[33m LightShot                %R%[90m│%R%[32m 60%R%[90m-%R%[36m AnyDesk                  %R%[90m│%R%[0m
echo   %R%[90m│%ogniogniogniogniognio% Game Library               %R%[90m│%R%[32m 35%R%[90m-%R%[33m Audacity                 %R%[90m│%ogniogniogniogniognio% Cleaning                   %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  7%R%[90m-%R%[33m Epic Games               %R%[90m│%R%[32m 36%R%[90m-%R%[33m HandBrake                %R%[90m│%R%[32m 61%R%[90m-%R%[33m Unlocker                 %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  8%R%[90m-%R%[33m Steam                    %R%[90m│%R%[32m 37%R%[90m-%R%[33m FileConverter            %R%[90m│%R%[32m 62%R%[90m-%R%[33m Revo Uninstaller         %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  9%R%[90m-%R%[33m GOG Galaxy               %R%[90m│%ogniogniogniogniognio% Video-Audio Player         %R%[90m│%ogniogniogniogniognio% Other                      %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 10%R%[90m-%R%[33m Ubisoft Connect          %R%[90m│%R%[32m 38%R%[90m-%R%[36m K-Lite Codec             %R%[90m│%R%[32m 63%R%[90m-%R%[36m 7-Zip                    %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 11%R%[90m-%R%[33m EA Games/Origin          %R%[90m│%R%[32m 39%R%[90m-%R%[36m VLC Media Player         %R%[90m│%R%[32m 64%R%[90m-%R%[36m OpenShell                %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 12%R%[90m-%R%[33m Playnite                 %R%[90m│%R%[32m 40%R%[90m-%R%[36m PotPlayer                %R%[90m│%R%[32m 65%R%[90m-%R%[36m Mem Reduct               %R%[90m│%R%[0m
echo   %R%[90m│%ogniogniogniogniognio% Browser                    %R%[90m│%R%[32m 41%R%[90m-%R%[36m Aimp                     %R%[90m│%R%[32m 66%R%[90m-%R%[36m MSI Afterburner          %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 13%R%[90m-%R%[36m Chromium [Sync]          %R%[90m│%R%[32m 42%R%[90m-%R%[36m Spotify                  %R%[90m│%R%[32m 67%R%[90m-%R%[36m Everything               %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 14%R%[90m-%R%[36m Chromium [UnSync]        %R%[90m│%ogniogniogniogniognio% Download Tools             %R%[90m│%R%[32m 68%R%[90m-%R%[36m Hamachi                  %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 15%R%[90m-%R%[36m Google Chrome            %R%[90m│%R%[32m 43%R%[90m-%R%[33m Free Download Manager    %R%[90m│%R%[32m 69%R%[90m-%R%[36m Glasswire                %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 16%R%[90m-%R%[36m Microsoft Edge           %R%[90m│%R%[32m 44%R%[90m-%R%[33m Xtreme Download Manager  %R%[90m│%R%[32m 70%R%[90m-%R%[36m PortMaster               %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 17%R%[90m-%R%[36m Brave                    %R%[90m│%R%[32m 45%R%[90m-%R%[33m JDownloader 2            %R%[90m│%R%[32m 71%R%[90m-%R%[36m Stremio                  %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 18%R%[90m-%R%[36m Cent                     %R%[90m│%R%[32m 46%R%[90m-%R%[33m Qbittorrent              %R%[90m│%R%[32m 72%R%[90m-%R%[36m Flow Launcher            %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 19%R%[90m-%R%[36m Vivaldi                  %R%[90m│%ogniogniogniogniognio% Documents                  %R%[90m│%R%[32m 73%R%[90m-%R%[36m CloudFlare WARP          %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 20%R%[90m-%R%[36m DuckDuckGo               %R%[90m│%R%[32m 47%R%[90m-%R%[36m Libre Office             %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 21%R%[90m-%R%[36m Opera                    %R%[90m│%R%[32m 48%R%[90m-%R%[36m Only Office              %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 22%R%[90m-%R%[36m Opera-GX                 %R%[90m│%R%[32m 49%R%[90m-%R%[36m Adobe Reader             %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 23%R%[90m-%R%[36m Mozilla Firefox          %R%[90m│%R%[32m 50%R%[90m-%R%[36m PDF X-Change Editor      %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 24%R%[90m-%R%[36m LibreWolf                %R%[90m│%R%[32m 51%R%[90m-%R%[36m Calibre                  %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 25%R%[90m-%R%[36m Tor                      %R%[90m│%ogniogniogniogniognio% Developer                  %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%ogniogniogniogniognio% Multimedia                 %R%[90m│%R%[32m 52%R%[90m-%R%[33m Notepad++                %R%[90m│%R%[32m 80%R%[90m-%R%[37m Microsoft Store Update   %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 26%R%[90m-%R%[33m Kdenlive                 %R%[90m│%R%[32m 53%R%[90m-%R%[33m Visual Studio Code       %R%[90m│%R%[32m 81%R%[90m-%R%[37m Update apps              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 27%R%[90m-%R%[33m Openshot                 %R%[90m│%R%[32m 54%R%[90m-%R%[33m Github                   %R%[90m│%R%[32m  X%R%[90m-%R%[37m Menu                     %R%[90m│%R%[0m
echo   %R%[90m└──────────────────────────────┴──────────────────────────────┴──────────────────────────────┘%R%[0m
set ogniogniogniogniognio=
goto :eof

::███████████████████████████████████████████████████████████████████
Error_0_>Warning>
Error_1_>ERROR! Turkish character detected in folder path>
Error_2_>ERROR! Space detected in folder path>
Error_3_>ERROR! Your system architecture is not x64>
Error_4_>ERRORROR! Chocolatey application not found>
Error_5_>Winget not found>
Error_6_>Microsoft Store not installed>
Error_7_>Toolbox works on Windows 10/11 systems>
Error_8_>Toolbox works on current versions of Windows>
::███████████████████████████████████████████████████████████████████
D0001>Process>
D0002>Multiprocessing>
D0003>Auto shutdown active, to turn off>to menu>
D0004>Enter the shutdown time in minutes>
D0005>User Name>
D0006>License>
::███████████████████████████████████████████████████████████████████
B0001>Service Management>
B0002>Feature Management>
B0003>Ping Meter>
B0004>About System>
B0005>Registered Wifi Information>
B0006>System cleaning>
B0007>Windows-Store Repair>
B0008>Windows Performance System Edit [Playbook]>
B0009>Change Language>
::███████████████████████████████████████████████████████████████████
T0001>opening>
T0002>shutting down>
T0003>Selected
T0004>Open>Close>
T0005>Example>
T0006>Main Menu>
T0007>Deletes only>
T0008>removing>
T0009>You can type the site address you want to measure ping>
T0010>>
T0011>>
T0012>>
T0013>>
T0014>>
T0015>Chocolatey loading>
T0016>Application installer not found. Please install the application from the pop-up screen.>
T0017>The application installer needs to be updated. Update apps from the market screen that opens.>
T0018>All in One Runtimes installing>
T0019>Net Framework 3.5 loading>
T0020>Net Framework 4.5+ loading>
T0021>DirectPlay loading>
T0022>Toolbox Update>
T0023>Current Version>
T0024>Updated Version>
T0025>'Feature management' allows you to delete components. You cannot reinstall them.>
T0026>Be careful when deleting components, there is no way back.>
T0027>Don't forget to restart the system after your actions.>
T0028>Press any key to go to the menu>
T0029>No Wifi information found>
T0030>Wait until transferred to menu>
T0031>Sfc /Scannow command running>
T0032>WinSxS Cleanup>
T0033>'DISM /Online /Cleanup-Image /RestoreHealth' command running>
T0034>General settings and repairing DLL files>
::██████████████████████████████████████████████████████████████████
SL_1_>Bluetooth> >
SL_2_>Phone>Need: Bluetooth>
SL_3_>Printer>Need: Printer-Print>
SL_4_>Scanner and Camera> >
SL_5_>Pen and Touch> >
SL_6_>Bitlocker Drive Encryption> >
SL_7_>Tariffed Networks>Quota manager for limited internet>
SL_8_>IP Assistant [IPV6]> >
SL_9_>Mobile Hotspot>Internet sharing>
SL_10_>Radio and Airplane Mode> >
SL_11_>Windows Connect Now [WPS]> >
SL_12_>Wifi> >
SL_13_>Location> >
SL_14_>Miracast>Wireless screen sharing │ Need: Settings ► Devices>
SL_15_>Flow>Network data sharing>
SL_16_>Fast Fetch-Start>Need: HDD>
SL_17_>Windows Search>Indexing service │ May be required for streaming service>
SL_18_>Quick User Switch>Need: Blizzard>
SL_19_>Type Cache>Need: HDD>
SL_20_>Windows Insider> >
SL_21_>Biometric>Need: Fingerprint │ HelloFace>
SL_22_>Disk Defragmentation>Need: SSD│HDD>
SL_23_>Router>Near devices>
SL_24_>Smart Card>Need: Chip card reader [not SD card]>
SL_25_>Enterprise application> >
SL_26_>Now Executing Session Manager>Need: Notification area media player>
SL_27_>Graphics performance monitoring>Need: Game mode>
SL_28_>Game DVR and Broadcast User>Need: Xbox screen recording>
::███████████████████████████████████████████████████████████████████
SR_1_>Fax> >
SR_2_>Wordpad>Windows built-in office application>
SR_3_>Notebook> >
SR_4_>Step Recorder>Records your actions with screenshots and actions>
SR_5_>Powershell-ISE>Powershell code editor>
SR_6_>Math expression recognizer>Need: TabletPC>
SR_7_>Infrastructure support for Linux> >
SR_8_>Quick support assistant> >
SR_9_>Hello Face>Face recognition system>
SR_10_>OpenSSH>Secure network protocol>
SR_11_>Predicted file system [ProjFS]>Enterprise feature>
SR_12_>System restore>Deletes connected components>
SR_13_>Work folders client>Enterprise │ Need: Printer sharing>
SR_14_>Windows Error Reporting> >
SR_15_>TFTP>Junk file transfer protocol>
SR_16_>Telnet>Device-to-device remote connection>
SR_17_>TCP/IP>Computer-to-computer data communication protocol>
SR_18_>TIFF IFilter>Tagged Image File Format>
SR_19_>System evaluation tool [WinSat]> >
SR_20_>RetailDemo>Retail demonstration │ Restricted mode used in display products>
SR_21_>Mixed Reality>Need: Virtual reality [VR]>
SR_22_>Customer experience improvement program [CEIP]>Telemetry
SR_23_>Device lockout>Logic similar to Deep Freeze program>
SR_24_>Multipoint Connector>Common PC usage
SR_25_>BranchCache>Caches on a shared network │ Need: Printer sharing>
SR_26_>Print as PDF>Need: Edge>
SR_27_>XPS document printer>Microsoft failed PDF alternative>
SR_28_>Network file system>Provides access to files on the computer>
SR_29_>Windows Photo viewer>Old viewer>
SR_30_>Remote assistance>Inter-device connection for troubleshooting>
SR_31_>SMB1>Need: Network media 'printer', 'file' sharing>
SR_32_>SMB Direct>Mimics remote file server connection to local storage>
SR_33_>Remote desktop>Inter-device connection>
SR_34_>Microsoft Message Queue [MSMQ]>Allows applications running on separate servers to establish secure connections>
SR_35_>3D screensaver>Animation on screen timers, XP users know>
SR_36_>MobilPC>Need: Brightness>
SR_37_>Camera user experience>Need: Camera>
SR_38_>Text prediction> >
SR_39_>Network connection assistant> >
SR_40_>Windows Identity Foundation>Identity-aware application development infrastructure>
SR_41_>Local group policy [gpedit.msc]>Allows you to edit the system in detail │ Does not work on Home editions>
SR_42_>Distance learning - Flipgrid>Need: Teams>
SR_43_>Data center bridging>Enterprise>
SR_44_>Active Directory Simple directory services>Enterprise>
SR_45_>Windows diagnostic engine>Need: Troubleshooting>
::███████████████████████████████████████████████████████████████████
SBB_1_>User Account Management>
SBB_2_>License Management>
SB_1_>Administrator activate>
SB_2_>Administrator close>
SB_3_>Add user to admin group>
SB_4_>Add New User>
SB_5_>Delete User>
SB_6_>Forgot password / change>
SB_7_>Show Existing Users>
SB_8_>Enter License [ipk]>
SB_9_>License Status [dli]>
SB_10_>License Status Detailed [dlv]>
SB_11_>Learn License Duration [xpr]>
SB_12_>Delete License [upk]>
SB_13_>License Duration Reset [rearm]>
::███████████████████████████████████████████████████████████████████
EE_1_>Computer>
EE_2_>User>
EE_3_>Format Date>
EE_4_>Installation Type>
EE_5_>Time Zone>
EE_6_>System>
EE_7_>Motherboard>
EE_8_>Brand>
EE_9_>Model>
EE_10_>Socket>
EE_11_>Bios>
EE_12_>Processor>
EE_13_>Core>
EE_14_>Virtual Core>
EE_15_>Operating Frequency>
EE_16_>Disks>
EE_17_>Capacity>
EE_18_>Ram>
EE_19_>Total>
EE_20_>Display Card>
EE_21_>Driver>
EE_22_>Date>
EE_23_>VRAM>
EE_24_>Monitor>
EE_25_>Resolution>
EE_26_>Refresh Rate>
::███████████████████████████████████████████████████████████████████
OG_1_>Removing components>
OG_2_>Services are being organized>
OG_3_>Uninstalling applications>
OG_4_>Editing regedit records>
OG_5_>Editing task scheduler>
OG_6_>Deleting unnecessary files>
OG_7_>Final adjustments being made>
WW_0_>Warnings and Guidance>
WW_1_>Disable antivirus program if installed>
WW_2_>On the screen that opens, turn off the defender protection settings>
WW_3_>Turn off the user account control [UAC] setting>
WW_4_>No errors or data loss were observed in the tests performed>
WW_5_>But problems may occur due to hardware differences>
WW_6_>Backup your important data before processing to avoid data loss>
WW_7_>The system will reboot after the process is finished>
WW_8_>Run Toolbox -'System cleanup' after system boot>
WW_9_>To continue processing>For main menu>