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
echo        %R%[90m│%R%[32m 1%R%[90m-%R%[33m Uygulama Yükleyici %R%[90m[M]              │%R%[32m  8%R%[90m-%R%[33m Kayıtlı WiFi bilgileri                %R%[90m│%R%[0m
echo        %R%[90m│%R%[32m 2%R%[90m-%R%[33m Hizmet yönetimi %R%[90m[M]                 │%R%[32m  9%R%[90m-%R%[33m Sistem temizliği                      %R%[90m│%R%[0m 
echo        %R%[90m│%R%[32m 3%R%[90m-%R%[33m Özellik Yönetimi %R%[90m[M]                │%R%[32m 10%R%[90m-%R%[33m Windows-Market Onar                   %R%[90m│%R%[0m
echo        %R%[90m│%R%[32m 4%R%[90m-%R%[33m PC zaman ayarlı kapat %R%[90m              │%R%[32m 11%R%[90m-%R%[33m Sistem optimizasyonu [Playbook]       %R%[90m│%R%[0m
echo        %R%[90m│%R%[32m 5%R%[90m-%R%[33m Ping ölçer %R%[90m                         │%R%[32m  %R%[33m%R%[90m                                         │%R%[0m
echo        %R%[90m│%R%[32m 6%R%[90m-%R%[33m Lisans-Hesap Yönetimi %R%[90m              │%R%[32m  Z%R%[90m-%R%[37m Dil ayarı                             %R%[90m│%R%[0m
echo        %R%[90m│%R%[32m 7%R%[90m-%R%[33m Sistem hakkında %R%[90m                    │%R%[32m  X%R%[90m-%R%[37m Kapat                                 %R%[90m│%R%[0m
echo        %R%[90m└────────────────────────────────────────┴───────────────────────────────────────────┘%R%[0m
goto :eof

:Menu_2
set ogniogniogniogniognio=%R%[90m ▼
echo.
echo   %R%[90m Microsoft Store ile 'Uygulama Yükleyici'yi güncellemeyi unutmayın%R%[0m
echo   %R%[90m┌──────────────────────────────┬──────────────────────────────┬──────────────────────────────┐%R%[0m
echo   %R%[90m│%R%[32m  1%R%[90m-%R%[33m All in One Runtimes      %R%[90m│%R%[32m 28%R%[90m-%R%[33m Shoutcut                 %R%[90m│%R%[32m 55%R%[90m-%R%[33m Git                      %R%[90m│%R%[0m
echo   %R%[90m│%ogniogniogniogniognio% Mesaj                      %R%[90m│%R%[32m 39%R%[90m-%R%[33m Krita                    %R%[90m│%R%[32m 56%R%[90m-%R%[33m Node.JS                  %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  2%R%[90m-%R%[36m Discord                  %R%[90m│%R%[32m 30%R%[90m-%R%[33m Gimp                     %R%[90m│%R%[32m 57%R%[90m-%R%[33m Unity Hub                %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  3%R%[90m-%R%[36m Whatsapp                 %R%[90m│%R%[32m 31%R%[90m-%R%[33m Jpegview                 %R%[90m│%R%[32m 58%R%[90m-%R%[33m Blender                  %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  4%R%[90m-%R%[36m Signal                   %R%[90m│%R%[32m 32%R%[90m-%R%[33m OBS Studio               %R%[90m│%ogniogniogniogniognio% Uzak Bağlantı              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  5%R%[90m-%R%[36m Telegram                 %R%[90m│%R%[32m 33%R%[90m-%R%[33m ShareX                   %R%[90m│%R%[32m 59%R%[90m-%R%[36m Teamviewer               %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  6%R%[90m-%R%[36m Zoom                     %R%[90m│%R%[32m 34%R%[90m-%R%[33m LightShot                %R%[90m│%R%[32m 60%R%[90m-%R%[36m AnyDesk                  %R%[90m│%R%[0m
echo   %R%[90m│%ogniogniogniogniognio% Oyun Kütüphane             %R%[90m│%R%[32m 35%R%[90m-%R%[33m Audacity                 %R%[90m│%ogniogniogniogniognio% Temizlik                   %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  7%R%[90m-%R%[33m Epic Games               %R%[90m│%R%[32m 36%R%[90m-%R%[33m HandBrake                %R%[90m│%R%[32m 61%R%[90m-%R%[33m Unlocker                 %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  8%R%[90m-%R%[33m Steam                    %R%[90m│%R%[32m 37%R%[90m-%R%[33m FileConverter            %R%[90m│%R%[32m 62%R%[90m-%R%[33m Revo Uninstaller         %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m  9%R%[90m-%R%[33m GOG Galaxy               %R%[90m│%ogniogniogniogniognio% Video-Ses Oynatıcı         %R%[90m│%ogniogniogniogniognio% Diğer                      %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 10%R%[90m-%R%[33m Ubisoft Connect          %R%[90m│%R%[32m 38%R%[90m-%R%[36m K-Lite Codec             %R%[90m│%R%[32m 63%R%[90m-%R%[36m 7-Zip                    %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 11%R%[90m-%R%[33m EA Games/Origin          %R%[90m│%R%[32m 39%R%[90m-%R%[36m VLC Media Player         %R%[90m│%R%[32m 64%R%[90m-%R%[36m OpenShell                %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 12%R%[90m-%R%[33m Playnite                 %R%[90m│%R%[32m 40%R%[90m-%R%[36m PotPlayer                %R%[90m│%R%[32m 65%R%[90m-%R%[36m Mem Reduct               %R%[90m│%R%[0m
echo   %R%[90m│%ogniogniogniogniognio% Tarayıcı                   %R%[90m│%R%[32m 41%R%[90m-%R%[36m Aimp                     %R%[90m│%R%[32m 66%R%[90m-%R%[36m MSI Afterburner          %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 13%R%[90m-%R%[36m Chromium [Sync]          %R%[90m│%R%[32m 42%R%[90m-%R%[36m Spotify                  %R%[90m│%R%[32m 67%R%[90m-%R%[36m Everything               %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 14%R%[90m-%R%[36m Chromium [UnSync]        %R%[90m│%ogniogniogniogniognio% İndirme Araçları           %R%[90m│%R%[32m 68%R%[90m-%R%[36m Hamachi                  %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 15%R%[90m-%R%[36m Google Chrome            %R%[90m│%R%[32m 43%R%[90m-%R%[33m Free Download Manager    %R%[90m│%R%[32m 69%R%[90m-%R%[36m Glasswire                %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 16%R%[90m-%R%[36m Microsoft Edge           %R%[90m│%R%[32m 44%R%[90m-%R%[33m Xtreme Download Manager  %R%[90m│%R%[32m 70%R%[90m-%R%[36m PortMaster               %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 17%R%[90m-%R%[36m Brave                    %R%[90m│%R%[32m 45%R%[90m-%R%[33m JDownloader 2            %R%[90m│%R%[32m 71%R%[90m-%R%[36m Stremio                  %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 18%R%[90m-%R%[36m Cent                     %R%[90m│%R%[32m 46%R%[90m-%R%[33m Qbittorrent              %R%[90m│%R%[32m 72%R%[90m-%R%[36m Flow Launcher            %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 19%R%[90m-%R%[36m Vivaldi                  %R%[90m│%ogniogniogniogniognio% Belgeler                   %R%[90m│%R%[32m 73%R%[90m-%R%[36m CloudFlare WARP          %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 20%R%[90m-%R%[36m DuckDuckGo               %R%[90m│%R%[32m 47%R%[90m-%R%[36m Libre Office             %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 21%R%[90m-%R%[36m Opera                    %R%[90m│%R%[32m 48%R%[90m-%R%[36m Only Office              %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 22%R%[90m-%R%[36m Opera-GX                 %R%[90m│%R%[32m 49%R%[90m-%R%[36m Adobe Reader             %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 23%R%[90m-%R%[36m Mozilla Firefox          %R%[90m│%R%[32m 50%R%[90m-%R%[36m PDF X-Change Editor      %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 24%R%[90m-%R%[36m LibreWolf                %R%[90m│%R%[32m 51%R%[90m-%R%[36m Calibre                  %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 25%R%[90m-%R%[36m Tor                      %R%[90m│%ogniogniogniogniognio% Geliştirme                 %R%[90m│%R%[32m%R%[32m%R%[37m                              %R%[90m│%R%[0m
echo   %R%[90m│%ogniogniogniogniognio% Multimedya                 %R%[90m│%R%[32m 52%R%[90m-%R%[33m Notepad++                %R%[90m│%R%[32m 80%R%[90m-%R%[37m Microsoft Store güncelle %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 26%R%[90m-%R%[33m Kdenlive                 %R%[90m│%R%[32m 53%R%[90m-%R%[33m Visual Studio Code       %R%[90m│%R%[32m 81%R%[90m-%R%[37m Uygulamaları güncelle    %R%[90m│%R%[0m
echo   %R%[90m│%R%[32m 27%R%[90m-%R%[33m Openshot                 %R%[90m│%R%[32m 54%R%[90m-%R%[33m Github                   %R%[90m│%R%[32m  X%R%[90m-%R%[37m Menu                     %R%[90m│%R%[0m
echo   %R%[90m└──────────────────────────────┴──────────────────────────────┴──────────────────────────────┘%R%[0m
set ogniogniogniogniognio=
goto :eof

::███████████████████████████████████████████████████████████████████
Error_0_>UYARI>
Error_1_>HATA! Klasör yolunda Türkçe karakter tespit edildi>
Error_2_>HATA! Klasör yolunda boşluk tespit edildi>
Error_3_>HATA! Sistem mimariniz x64 değil>
Error_4_>HATA! Chocolatey uygulaması bulunamadı>
Error_5_>Winget bulunamadı>
Error_6_>Microsoft Store yüklü değil>
Error_7_>Toolbox, Windows 10/11 sistemlerde çalışmaktadır>
Error_8_>Toolbox, Windows güncel sürümlerinde çalışmaktadır>
Error_9_>İnternet bağlantısı olmadan uygulama yükleyiciyi kullanamazsınız>
::███████████████████████████████████████████████████████████████████
D0001>İşlem>
D0002>Çoklu işlem>
D0003>Otomatik kapatma aktif, kapatmak için>menü için>
D0004>Dakika cinsinden kapanma süresini giriniz>
D0005>Kullanıcı Adı>
D0006>Lisans>
::███████████████████████████████████████████████████████████████████
B0001>Hizmet Yönetimi>
B0002>Özellik Yönetimi>
B0003>Ping Ölçer>
B0004>Sistem Hakkında>
B0005>Kayıtlı Wifi Bilgileri>
B0006>Sistem temizleniyor>
B0007>Windows - Market bileşenleri onarılıyor>
B0008>Windows Performans Sistem Düzenlemesi [Playbook]>
B0009>Dil Değiştirme>
::███████████████████████████████████████████████████████████████████
T0001>açılıyor>
T0002>kapatılıyor>
T0003>Seçilenler>
T0004>Aç>Kapat>
T0005>Örnek>
T0006>Ana Menü>
T0007>Yalnızca silme işlemi yapar>
T0008>kaldırılıyor>
T0009>Ping ölçümü yapmak istediğiniz site adresini yazabilirsiniz>
T0010>>
T0011>>
T0012>>
T0013>>
T0014>>
T0015>Chocolatey yükleniyor>
T0016>Uygulama yükleyicisi bulunamadı. Lütfen uygulamayı açılan ekran üzerinden yükleyiniz.>
T0017>Uygulama yükleyicisinin güncellenmesi gerekiyor. Açılan market ekranından uygulamaları güncelleyin.>
T0018>All in One Runtimes yükleniyor>
T0019>Net Framework 3.5 yükleniyor>
T0020>Net Framework 4.5+ yükleniyor>
T0021>DirectPlay yükleniyor>
T0022>Toolbox Güncelleme>
T0023>Mevcut Sürüm>
T0024>Güncel Sürüm>
T0025>'Özellik yönetimi' bileşenleri silmenizi sağlar. Yeniden yükleme işlemi yapamazsınız.>
T0026>Bileşen silerken dikkatli olun, yapacağınız işlemin geri dönüşü yoktur.>
T0027>Yaptığınız işlemlerden sonra sistemi yeniden başlatmayı unutmayınız.>
T0028>Menüye gitmek için herhangi bir tuşa basınız>
T0029>Kayıtlı Wifi bilgisi bulunamadı>
T0030>Menüye aktarılana kadar bekleyiniz>
T0031>Sfc /Scannow komutu çalışıyor>
T0032>WinSxS Temizleniyor>
T0033>'DISM /Online /Cleanup-Image /RestoreHealth' komutu çalışıyor>
T0034>Genel ayarlar ve DLL dosyaları onarılıyor>
T0035>WMI ile alınan sistem verilerinde hata payı olabilir>
::██████████████████████████████████████████████████████████████████
SL_1_>Bluetooth> >
SL_2_>Telefon>İhtiyaç: Bluetooth>
SL_3_>Yazıcı>İhtiyaç: Yazıcı-Baskı>
SL_4_>Tarayıcı ve Kamera> >
SL_5_>Kalem ve Dokunmatik> >
SL_6_>Bitlocker Sürücü Şifreleme> >
SL_7_>Tarifeli Ağlar>Sınırlı internetler için kota yönetici>
SL_8_>IP Yardımcısı [IPV6]> >
SL_9_>Mobil Etkin Nokta>İnternet paylaşımı │ İhtiyaç: Miracast>
SL_10_>Radyo ve Uçak Modu> >
SL_11_>Windows Şimdi Bağlan [WPS]>İhtiyaç: WiFi>
SL_12_>Wifi> >
SL_13_>Konum> >
SL_14_>Miracast>Kablosuz ekran paylaşımı │ İhtiyaç: Ayarlar ► Cihazlar>
SL_15_>Akış>Ağ üzeri veri paylaşımı>
SL_16_>Hızlı Getir-Başlat>İhtiyaç: HDD>
SL_17_>Windows Search>İndeksleme hizmeti │ Akış hizmeti için gerekli olabilir>
SL_18_>Hızlı Kullanıcı Değiştir>İhtiyaç: Blizzard>
SL_19_>Yazı Tipi Önbelliği>İhtiyaç: HDD>
SL_20_>Windows Insider> >
SL_21_>Biyometrik>İhtiyaç: Parmak izi │ HelloFace>
SL_22_>Disk Birleştirme>İhtiyaç: SSD│HDD>
SL_23_>Yönlendirici>Yakındaki cihazlar>
SL_24_>Akıllı Kart>İhtiyaç: Çipli kart okuyucu [SDkart değil]>
SL_25_>Kurumsal uygulama> >
SL_26_>Şimdi Yürütülüyor Oturum Yöneticisi>İhtiyaç: Bildirim alanı medya oynatıcı>
SL_27_>Grafik perfromansı izleme>İhtiyaç: Oyun modu>
SL_28_>Oyun DVR ve Yayın Kullanıcı>İhtiyaç: Xbox ekran kayıt>
::███████████████████████████████████████████████████████████████████
SR_1_>Fax> >
SR_2_>Wordpad>Windows yerleşik office uygulaması>
SR_3_>Not Defteri> >
SR_4_>Adım Kaydedici>Yaptığınız işlemleri ekran görüntüleri ve işlemlerle kayıt eder>
SR_5_>Powershell-ISE>Powershell kod editörü>
SR_6_>Matematik ifade tanıyıcı>İhtiyaç: TabletPC>
SR_7_>Linux için altyapı desteği> >
SR_8_>Hızlı destek asistanı> >
SR_9_>Hello Face>Yüz tanıma sistemi>
SR_10_>OpenSSH>Güvenli ağ protokolü>
SR_11_>Öngörülen dosya sistemi [ProjFS]>Kurumsal özellik>
SR_12_>Sistem geri yükleme>Bağlı bileşenleride siler>
SR_13_>Çalışma klasörleri istemcisi>Kurumsal │ İhtiyaç: Yazıcı paylaşımı>
SR_14_>Windows Hata Raporlama> >
SR_15_>TFTP>Önemsiz dosya aktarım protokolü>
SR_16_>Telnet>Cihazlar arası uzak bağlantı>
SR_17_>TCP/IP>Bilgisayarlar arası veri iletişim protokolü>
SR_18_>TIFF IFilter>Etiketli Görüntü Dosyası Biçimi>
SR_19_>Sistem değerlendirme aracı [WinSat]> >
SR_20_>RetailDemo>Perakende gösteri │ Teşhir ürünlerde kullanılan kısıtlı mod>
SR_21_>Karma Gerçeklik>İhtiyaç: Sanal gerçeklik [VR]>
SR_22_>Müşteri deneyimi geliştirme programı [CEIP]>Telemetri>
SR_23_>Cihaz kilitleme>Deep Freeze programına benzer mantığı var>
SR_24_>Çok Noktalı Bağlayıcı>Ortak PC kullanımı>
SR_25_>BranchCache>Ortak ağda önbellekleme yapar │ İhtiyaç: Yazıcı paylaşımı>
SR_26_>PDF olarak yazdır>İhtiyaç: Edge>
SR_27_>XPS belge yazıcı>Microsoft'un başarısız PDF alternatifi>
SR_28_>Ağ dosya sistemi>Bilgisayardaki dosyalara erişilmesini sağlar>
SR_29_>Windows Fotoğraf görüntüleyici>Eski görüntüleyici>
SR_30_>Uzaktan yardım>Sorun tespit için cihazlar arası bağlantı>
SR_31_>SMB1>İhtiyaç: Ağ ortamı 'yazıcı', 'dosya' paylaşımı>
SR_32_>SMB Direct>Uzak dosya sunucu bağlantısını yerel depolamaya benzetir>
SR_33_>Uzak masaüstü>Cihazlar arası bağlantı>
SR_34_>Microsoft Mesaj Kuyruğu [MSMQ]>Ayrı sunucularda çalışan uygulamaların güvenli bağlantı kurmasını sağlar>
SR_35_>3D ekran koruyucu>Ekran zamanaşımlarında çıkan animasyon, XP kullananlar bilir>
SR_36_>MobilPC>İhtiyaç: Parlaklık>
SR_37_>Kamera kullanıcı deneyimi>İhtiyaç: Kamera>
SR_38_>Metin tahmini> >
SR_39_>Ağ bağlantı yardımcısı> >
SR_40_>Windows Identity Foundation>Kimliğe duyarlı uygulama geliştirme altyapısı>
SR_41_>Yerel grup ilkesi [gpedit.msc]>Sistem üzerinde detaylı düzenleme yapmanızı sağlar │ Home sürümlerinde çalışmaz>
SR_42_>Uzaktan eğitim - Flipgrid>İhtiyaç: Teams>
SR_43_>Veri merkezi köprü oluşturma>Kurumsal>
SR_44_>Active Directory Basit dizin hizmetleri>Kurumsal>
SR_45_>Windows tanılama altyapısı>İhtiyaç: Sorun giderme>
::███████████████████████████████████████████████████████████████████
SBB_1_>Kullanıcı Hesap Yönetimi>
SBB_2_>Lisans Yönetimi>
SB_1_>Administrator aktifleştir>
SB_2_>Administrator kapat>
SB_3_>Admin grubuna kullanıcı ekle>
SB_4_>Yeni Kullanıcı Ekle>
SB_5_>Kullanıcı Sil>
SB_6_>Şifremi unuttum / değiştir>
SB_7_>Mevcut Kullanıcıları Göster>
SB_8_>Lisans Gir [ipk]>
SB_9_>Lisans Durumu [dli] >
SB_10_>Lisans Durumu Detaylı [dlv]>
SB_11_>Lisans Süresini Öğren [xpr]>
SB_12_>Lisans Sil [upk]>
SB_13_>Lisans Süre Sıfırla [rearm]>
::███████████████████████████████████████████████████████████████████
EE_1_>Bilgisayar>
EE_2_>Kullanıcı>
EE_3_>Format Tarihi>
EE_4_>Kurulum Türü>
EE_5_>Saat Dilimi>
EE_6_>Sistem>
EE_7_>Anakart>
EE_8_>Marka>
EE_9_>Model>
EE_10_>Soket>
EE_11_>Bios>
EE_12_>İşlemci>
EE_13_>Çekirdek>
EE_14_>Sanal Çekirdek>
EE_15_>Çalışma Frekansı>
EE_16_>Diskler>
EE_17_>Kapasite>
EE_18_>Ram>
EE_19_>Toplam>
EE_20_>Ekran Kartı>
EE_21_>Sürücü>
EE_22_>Tarihi>
EE_23_>VRAM>
EE_24_>Monitör>
EE_25_>Çözünürlük>
EE_26_>Tazeleme Hızı>
::███████████████████████████████████████████████████████████████████
OG_1_>Bileşenler kaldırılıyor>
OG_2_>Hizmetler düzenleniyor>
OG_3_>Uygulamalar kaldırılıyor>
OG_4_>Regedit kayıtları düzenleniyor>
OG_5_>Görev zamanlayıcısı düzenleniyor>
OG_6_>Gereksiz dosyalar siliniyor>
OG_7_>Son ayarlar yapılıyor>
OG_8_>Microsoft Defender kaldırılıyor>
OG_9_>Microsoft Edge kaldırılıyor>
OG_10_>Özel ayarlar yapılandırılıyor>
WW_0_>Uyarılar ve Yönlendirmeler>
WW_1_>Antivirüs programı yüklü ise devre dışı bırakınız>
WW_2_>Açılan ekrandan defender koruma ayarlarını kapalı hale getirin>
WW_3_>Veri kaybı yaşamamak için işlem öncesi önemli verilerinizi yedekleyin>
WW_4_>Sistem üzerinde birçok bileşen kaldırılıp ayarlar değiştirilecektir>
WW_5_>Detaylar için>https://ognitorenks.blogspot.com/2023/08/windows-10-11-performans-duzenlemesi.html>
WW_6_>İşlem bittikten sonra sistem yeniden başlatılacak>
WW_7_>Sistem açıldıktan sonra Toolbox -'Sistem temizliği' bölümünü çalıştırın>
WW_8_>İşlemleri özelleştirmek için aşağıdaki dosya yoluna ulaşıp düzenlemeniz gerekmektedir>
WW_9_>İşleme devam etmek istiyor musunuz?>
WW_10_>İşleme devam etmek istediğinize emin misiniz?>