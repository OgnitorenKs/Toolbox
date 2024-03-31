#  Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
###  İletişim;
-   Discord: https://discord.gg/7hbzSGTYeZ
-   Mail: ognitorenks@gmail.com
-   Site: [https://ognitorenks.blospot.com](https://ognitorenks.blospot.com)

<details><B><summary> Versiyon 4.2.7 ►  31.03.2024</B></summary>

	▼ Playbook bölümünde yapılan değişiklikler;
		• "Optimization_Setting_15_" bölümündeki başlık hatası giderildi.
		• Kalıpta liste başında yer alan kişisel ayarlara alt bölümde kalan bazı ayarlar taşındı. Uygulama kaldırma ayarı gizlilik ayarlarının üzerine eklendi.
		• Temizlik komutlarında yapılan işlemleri göstermesi için echo komutları eklendi.
	▼ Uygulama yükleyici bölümünde yapılan değişiklikler;
		• "Aimp" uygulaması kaldırıldı. Resmi sitesine Türkiye'den ulaşılamıyor. VPN ile girilebiliyor. Sorun uzun zamandır devam ettiği için kaldırıldı.
		• "CloudFlare WARP" yükleme sorunlarından dolayı kaldırıldı.
		• "Diğer" bölümünde program listesi değiştirildi.
		• "JDownloader 2" kurulum sorunlarından dolayı listeden kaldırıldı.
	▼ Genel değişiklikler;
		• Winget kontrol sistemindeki hata mesajına yeni bilgi mesajı eklendi.
		• Varsayılan uygulama düzenleme bölümündeki kodlar düzenlendi. Bir kaç yol hatası giderildi.
		• "Sistem temizliği" bölümündeki işlemler görünür hale getirildi ve bilgilendirici mesajlar eklendi.
		• "Sistem temizliği" bölümünde dosya gezgini yeniden başlatılması gerektiği yerde kullanıcıdan onay alacak şekilde ayarlama yapıldı.

</details><details><B><summary> Versiyon 4.2.6 ►  29.03.2024 - Playbook</B></summary>

	▼ Playbook bölümü değişiklikler;
		• Sistem geri yükleme ve bileşenleri playbook kalıbından kaldırıldı. Artık varsayılan olarak bırakılacak. Dileyenler "hizmetleri yönet" bölümünden kapatabilir.
		• Temizlik bölümünden sistem geri yükleme noktalarını silen komutlar kaldırıldı.
		• Edge ve edgewebview2'nin otomatik yüklenmesini engellemek için eklenen güvenlik duvarı engelleme komutu iptal edildi.
		• Playbook içerisindeki bazı özel ayarların yönetimi daha rahat olması için liste başında toplandı.
		• Playbook sonrası temizlik işlemini atlama ayarı Settings.ini içerisinden, playbook kalıbına eklendi.

</details><details><B><summary> Versiyon 4.2.5 ►  28.03.2024 - Playbook</B></summary>

	• Playbook bölümü internet kontrol komutları kaldırıldı.
	• Internet kontrol bölümüne www.google.com ve github.com adresleri eklendi.
	• Uygulama yükleyici bölümünden internet kontrol komutları kaldırıldı.

</details><details><B><summary> Versiyon 4.2.4 ►  28.03.2024 - Playbook</B></summary>
	
	▼ Playbook bölümünde yapılan değişiklikler;
		• Playbook kalıp güncelleme sistemi kaldırıldı. Ana güncellemeye bağlı olarak kalıplar güncellenecek.
		• UpdateAfter seçeneği iptal edildi. Artık yalnızca playbook olarak uygulanacak.
		• Delipedro ve Speyda'nın playbook kalıpları kaldırıldı. Tek bir kalıp bırakıldı.
		• Uyarı ekranında yer alan bilgiler daha anlaşılır hale getirildi.
		• Kalıp klasöründe tek bir kalıp var ise doğrudan uyarılar ekranına geçecek şekilde ayarlama yapıldı. Birden fazla dosya var ise seçim yapma menüsünü gösterir.
		• Bazı powershell komutlarına tek tırnak işareti eklendi. Kullanıcı adında boşluk olunca sorunlara neden olduığu içindir.
		• Bir kaç bölümde yer alan " işareti hataları giderildi.
		• "\Windows\Installer" klasör içeriğini silmesi sonucu oluşan simge hatalarını önlemek için silme işlemi .msi .msp dosyalarına ve SourceHash klasörüne odaklandırıldı.
		• Edge kaldırma bölümündeki güvenlik duvarından engelleme komutu ve regedit temizleme komutları kaldırıldı. Detaylı temizlik yapmak isteyenler Playbook sonrası Hibit Uninstaller programıyla kapsamlı temizlik yapabilir.
		• Winget'in olası çökme, takılma gibi sorunlarında sistemi yeniden başlatıp işlemleri hızlıca tamamlamak için "Uygulama yükleme" bölümü son işlem olarak düzenlendi.
		• "Change_App_1_" ayarı defender'ı silmeden devre dışı bırakmayı sağlar. (Windows Update yaparken sorun çıkmaması için oluşturuldu)
		• "Change_App_2_" ayarı görev çubuğu arama bileşenini silmeden devre dışı bırakmayı sağlar.
		• "Change_App_3_" ayarı başlat menüsünü silmeden devre dışı bırakmayı sağlar.
		• Onedrive komutlarına yeni regedit kaydı eklendi
		• "Uyarılar ve yönlendirmeler" bölümünde UAC kapatma işlemi onay verdikten sonra yapacak şekilde ayarlandı.
		• "Optimization_Setting_16_" ayarındaki HPET komutu düzenlendi.
		• "Explorer_Setting_19_" ayarı varsayılan dili Türkçe olan sistemlerde uygulanıyordu. Artık tüm dillerde bu ayar eklenebilecek. Türkçe dışında ismi "Take Ownership" olacaktır.
		• Settings.ini içerisinde yer alan winget uygulama yükleme bölümüyle ilgili ayar kaldırıldı.
		• Uygulama kurma bölümü kaldırıldı. Openshell başlat menüsü ve arama işlevi için yüklenecek.
		• Winget kontrol komutları revize edildi. Artık uygulama yükleyici güncellenmeden playbook bölümü kullanılamayacak.
		• Net framework 3.5/4.5/DirectPlay bileşen yükleme işlemi kaldırıldı.
		• Uygulama yükleme işlemleri için komutlar duruyor ancak kalıplardan kaldırıldı.
		• İşlem sıraları değiştirildi.
	▼ Uygulama yükleyici bölümünden yapılan değişiklikler;
		• Teamviewer programı kaldırıldı. Sebeplerine gelecek olursak;
			• İşlevsellikten uzak olması. Çünkü bağlantı kurmak için üye olmak gibi saçma bir politikası var.
			• Ücretsiz sürümünün kısıtlı olması.
		• Uzak bağlantı menüsü kaldırıldı. AnyDesk programı Diğer kategorisine alındı.
		• All in One Runtimes bölümünden ".Net Desktop Runtime 7.0" sürümü kaldırıldı. Artık yalnızca güncel sürüm yüklenecek.
		• DuckduckgoBrowser kaldırıldı yerine MaxthonBrowser eklendi. Duckduckgo programının setup dosyası çok büyük olduğu için kaldırdım.
		• Uygulama yüklemeden önce yüklü olup olmadığını kontrol edecek. Bu kontrol ile olası kurulum hataları önlenmiş oldu.
		• Winget kontrol komutları revize edildi. Artık uygulama yükleyici güncellenmeden bu bölüm kullanılamayacak.
	▼ Hizmet yönetimi bölümünde yapılan değişiklikler;
		• Eklenen yeni hizmet grupları;
			• Karma gerçeklik
			• Xbox
			• Teslim en iyileştirme
			• Uzak masaüstü
			• Ekran yakalama hizmeti
			• Ebeveyn denetimleri
			• Atanmış erişim
			• Perakende gösteri [RetailDemo]
			• Kişiler
			• Telemetri
			• Sorun giderme
	▼ Genel değişiklikler;
		• Toolbox yalnızca 10 ve 11 sistemlerde çalışacağı için sistem kontrol komutlarını kaldırdım. Çünkü Toolbox 8.1 sistemlerde açılmayacaktır.
		• Ana menüye ve toolbox başlığına simgeler eklendi.
		• Hizmet silme komutunda yer alan ufak bir eksiklik giderildi.
			• SC başlığı SC_Config olarak düzenlendi.
		• Ping ölçer bölümünde DNS adresleri belirtildi.
		• Sistem temizliği bölümündeki kodlar düzenlendi. Hızlı erişim sabitlenmiş pinleri silme sorunu giderildi.
		
</details><details><B><summary> Versiyon 4.2.3 ►  28.02.2024 - Playbook</B></summary>
	
	• Playbook bölümünde yapılan değişiklikler;
		• "Special_Setting_1_" ayarı masaüstü arkaplan resminin görüntü kalitesini ayarlamak için eklendi.
		• Playbook kalıp güncelleme ayarındaki döngü hatası giderildi.
		• "Explorer_Setting_29_" ayarı "Sağ-tık - Yeni bölümüne .bat dosya uzantısını ekle" olarak değiştirildi.
		• "Special_Setting_2_" ayarı "Explorer_Setting_29_" buraya aktarılmıştır. Reg değerini değiştirebilecek şekilde düzenlenmiştir.
		• "Feature_Setting_7_" ayarında yer alan regedit kayıtları yeniden düzenlendi.
		• "Special_Setting_3_" ayarı fare işaretçi hızı bölümünden çıkartılıp özel ayar olarak eklendi. İçeriği farklı olduğu ayrı olması daha sağlıklı.
		
</details><details><B><summary> Versiyon 4.2.2 ►  27.02.2024 - Playbook</B></summary>

	• Playbook bölümünde yapılan değişiklikler;
		• Uygulama kaldırma bölümü;
			• PLog değişkeni kaldırıldı.
			• "%Windir\SystemApps" klasöründeki artık klasörleri silmek için yeni komutlar eklendi.
			• Bir önceki güncellemede yaptığım kaldırılmış uygulamaları
		• Edge kaldırma bölümüne görev zamanlayıcısı ve regedit bölümlerine eklemeler yapıldı.
		• Defender kaldırma bölümündeki appx kaldırma komutları düzenlendi.
		• "Privacy_Setting_52_" konum hizmetini kapatması için yeni regedit kayıtları eklendi.
		• "Privacy_Setting_68_" ayarı program uyumluluk asistanı kapatmak için eklendi.
		• "Taskbar_Setting_14_" ayarı başlat menüsünden önerilenleri kaldırmak için eklendi. Microsoft sürüm bazında kısıtlama yaptığı için her sürümde çalışmayabilir.
		• "Taskbar_Setting_15_" ayarı başlat menüsü - ipuçları, kısayollar, yeni uygulamalar ve daha fazlası için önerileri kapatması için eklendi.
		• "Update_Setting_20_" ayarı Windows'u güncelleştirdiğimde diğer Microsoft uygulamalarının güncelleştirmelerini devre dışı bırakması için eklendi.
		• "Optimization_Setting_19_" ayarı MSI modu aktifleştirmek için eklendi.
		• "Optimization_Setting_20_" ayarı cihaz önceliklerini kaldırmak için eklendi.
		• "Internet_Setting_3_" ayarı Nagle's algoritmasını kapatmak için eklendi.
		• Winre.wim bölümündeki tarama işlemini hızlandırmak için yolu Windows dizinine göre ayarlandı.
		• Playbook ayarı seçilip uygulama yükletmeden işlem yapılması için "Settings.ini" dosyasına ayarlar eklendi. Settings.ini başlığında detaylarını yazacağım.
		• Windows güncelleştirme bileşeni usoclient.exe üzerinden her açılışta kontrol edilip otomatik yüklemeyle alakalı bölümleri devre dışı bırakmayı sağlayan komutlar eklendi.
			• Taskschd_Update_Setting_1-6 ayarları eklendi. Açıklamaları kalıplar içinde yer almaktadır.
		• Özelleştirilmiş yüklemeler için Winget üzerinde setup dosyasını indirip katılımsız komutlarla özel kurulum yapılmasını sağlayacak eklemeler yapıldı.
			• Bu tarz bir ekleme yapmamın nedeni başlat menüsünü kaldırıp yerine alternatif program yüklemek isteyenler için >
			• çünkü winget ile Openshell kurulduğunda yanında diğer bileşenleri de yükleniyordu. Bunu engellemek ve daha özelleştirilmiş bir Openshell kurulumu için eklendi >
			• Ancak içeriği tüm programları yükletebilmesini sağlayacak şekilde geniş tutuldu.
		• Varsayılan program yapılandırma bölümündeki regedit komutları düzenlendi. Kullanıcı seçimlerinin engel olduğu varsayılan olarak ayarlayamama sorunu giderildi.
		• Uygulama kaldırma bölümüne eklenenler;
			• DevHome
			• New outlook
	• Settings.ini bölümünde yapılan değişiklikler;
		• Anlaşılır olması için düzenleme yapıldı.
		• "Setting_1_" Toolbox güncelleştirme işlemi içindir.
		• "Setting_2_" Playbook kalıbı seçilip uygulama yüklemeyi atlatmak isteyenler için eklendi.
		• Bu bölümdeki değişikliklere bağlı olarak dil ile alakalı komutlar düzenlendi.
	• "Sistem temizliği" bölümünde; Bu bölüm değişiklikleri ayrıca Playbook işlemi sonrası sistem yeniden başladıktan sonra açılan temizlik dosyasına da uygulanmıştır.
		• "\Windows\Installer" silme işlemi hedef dosyalara yönelecek şekilde ayarlandı.
		• "Dism /Online /Cleanup-Image /SPSuperseded" yeni sürüm Windows'larda işlevsiz olduğu için kaldırıldı.
	

</details><details><B><summary> Versiyon 4.2.1 ►  23.01.2024 - Playbook</B></summary>

	• Playbook bölümünde yapılan değişiklikler;
		• Kodlarda genel iyileştirme yapıldı.
		• Edge bölümündeki derin tarama komutları işlemleri hızlandırmak adına kaldırıldı.
		• Kalıp seçme bölümü değiştirildi.
			• Playbook ve UpdateAfter olarak ayırdığım kalıpları tek bir kalıp haline getirdim.
			• Kalıp tercihinizi yaptıktan sonra size Playbook/UpdateAfter seçimini yapmanızı isteyecek.
			• Kalıp versiyonları eklendi.
		• "Bileşen kaldırma"; "Sistem geri yükleme" kaldırma işlemine regedit komutları eklendi.
		• Kaldırımış uygulamaların işlemler sırasında görüntülenmesi engellendi.
	• Hizmet yönetimi bölümündeki değişiklikler;
		• Sistem geri yükleme bölümüne hizmet artıklarını silecek şekilde ekleme yapıldı.

</details><details><B><summary> Versiyon 4.2.0 ►  12.01.2024 - Playbook</B></summary>

	• Playbook bölümünde yapılan değişiklikler;
		• Playbook sistem temizliği komutlarına eklemeler yapıldı. Dizin hataları giderildi
		• Edge bölümüne temizlik işlemi için yeni komutlar eklendi.
		• Winget ile uygulama yükleme komutlarındaki varsayılan uygulama komutları düzenlendi.
	• Dosya ve klasör silme komutları düzenlendi.

</details><details><B><summary> Versiyon 4.1.9 ►  10.01.2024 - Playbook</B></summary>
	
	• Playbook bölümünde yapılan değişiklikler;
		• "Optimization_Setting_13_" bölümüne hızlı başlatmayı kapatması için powercfg komutu eklendi.
		• "Explorer_Setting_31_" ayarı eklendi. Bu ayar ile temayı koyu moda alabileceksiniz.
		• "Explorer_Setting_32_" ayarı eklendi. Bu ayar ile temayı açık moda alabileceksiniz.
		• "Explorer_Setting_33_" ayarı eklendi. Başlangıç ve görev çubuğunda vurgu rengini göster ayarını aktifleştirir.
		• "Explorer_Setting_21_" bölümündeki gereksiz regedit kayıtları kaldırıldı.
		• "Performance_Edit" başlığı "Playbook_Manager" olarak değiştirildi.
		• Uygulama kaldırma komutlarına tüm kullanıcıladan sil parametresi eklendi.
		• Sistem adı değiştirme seçeneği eklendi.
		• Devmainview ile aygıt yöneticisi üzerinden düzenleme yapma seçeneği eklendi.
		• Onedrive bölümüne yeni reg kayıtları eklendi.
		• Özel güç ayarı ve duvar kağıdı değiştirme bölümü eklendi.
		• Sistem bileşeni olarak düzenlenmiş uygulamaları kaldırma seçeneği eklendi. [Uzman kullanıcılar için]
		• Edge silme komutlarında edgewebview2 silen komutlar kaldırıldı. İki bölüm tamamen ayrıldı.
		• Playbook işlemi sonrası ilk yeniden başlatmada yapılması gereken sistem temizleme işlemi otomatik hale getirildi.
		• Playbook kalıp okuma bölümü optimize edildi. Hatalar giderildi.
	• Toolbox güncelleme sisteminde yapılan değişiklikler;
		• Playbook kalıpları için harici bir güncelleme sistemi oluşturuldu.
	• "Uygulama yükleyici" bölümünde yapılan değişiklikler;
		• "All in One Runtimes" bölümünde Desktop Runtime 6.0 sürümü çıkarıldı. 8.0 sürümü eklendi.
			• Bundan sonra güncel sürüm ve bir alt sürümü yüklenecektir. Şuan 8/7 sürümleri yüklenmektedir.


</details><details><B><summary> Versiyon 4.1.8 ►  27.12.2023 - Playbook [QuickFix]</B></summary>

	• Playbook "Uyarılar ve yönlendirmeler" bölümünde işlemi kabul etmediğinizde devam etmesine neden olan sorgulama hatası giderildi. Ek önlemler eklendi

</details><details><B><summary> Versiyon 4.1.7 ►  27.12.2023 - Playbook</B></summary>

	• Playbook kalıp seçme bölümü ekran genişliği azaltıldı.
	• Deli_Petro06 ve Speyda_readyOS kalıpları entegre edildi.

</details><details><B><summary> Versiyon 4.1.6 ►  27.12.2023 - Playbook</B></summary>

	• "Sistem optimizasyonu [Playbook]" bölümündeki değişiklikler;
		• Taskbar_Settings_10/11 bölümündeki veri karışıklığı hatası giderildi.
		• Edge kaldırma komutuna yeni reg kaydı eklendi.
		• Uygulama kaldırma bölümündeki powershell optimizasyon komutlarında yaşanan sorun giderildi.

</details><details><B><summary> Versiyon 4.1.5 ►  26.12.2023 - Playbook</B></summary>

	• "Sistem optimizasyonu [Playbook]" bölümündeki değişiklikler;
		• Regedit komutları optimize edildi. 
		• Kalıp seçme bölümünde ana menüye dönüş seçeneği eklendi.
		• Svchost optimizasyon hatası giderildi.
		• Uygulama kaldırma hatası giderildi.
		• Kalıp okuma bölümündeki ön kontrol komutu kaldırıldı.
		• Edge kaldırma komutlarına yeni komutlar eklendi.
		• Bileşen yükleme bölümü ilk işlem olarak düzenlendi.
		• Görev çubuğu arama simgesini gizleme bölümü güncel sürümlere göre düzenlendi.
		• Uygulama kaldırma bölümündeki kodlar optimize edildi.
		• Bileşen silme bölümündeki kısmi çalışma sorunu giderildi.

</details><details><B><summary> Versiyon 4.1.4 ►  23.12.2023 - Playbook</B></summary>

	• "Sistem optimizasyonu [Playbook]" bölümündeki değişiklikler;
		• Tüm ayarlar yönetilebilir hale getirildi.
		• Ayarlar çeşitlendirildi.
		• Kalıp seçme ayarı eklendi.
	• Servis açma/kapatma komutları düzenlendi. Daha düzenli hale getirildi.
	• Winget indirme sistemindeki varsa eski sürümleri kaldırıp yükle parametresi kaldırıldı. Programların altyapıları genel olarak uymadığı için sorun çıkarabiliyor.
	• "___HANGAR___" başlığı altındaki yer alan işlevsel başlıklar düzenli hale getirildi. Yorum satırları arttırıldı.
		

</details><details><B><summary> Versiyon 4.1.3 ►  26.11.2023</B></summary>

	• "Hizmet Yönetimi" bölümündeki değişiklikler;
		• Wifi hizmet grubu çalışma değerleri güncellendi.
		• Hizmetleri aç/kapat yapmayı sağlayan kodlar optimize edildi. Döngü hatası giderildi.
			• Sc config komutlarına ek olarak regedit üzerinden açıp kapatmayı sağlayacak komutlar eklendi.
	• "Sistem optimizasyonu [Playbook]" bölümündeki değişiklikler;
		• Yeni mouse simgesini yükleme opsiyonel hale getirildi. Playbook.ini dosyası üzerinden kullanıcı yükleyip yüklememe durumunu ayarlayabilecek.
	• "Sistem Hakkında" bölümündeki değişiklikler;
		• DDR5 ram tip numarası eklendi.
	
</details><details><B><summary> Versiyon 4.1.2 ►  23.11.2023</B></summary>

	• "Sistem temizliği" bölümüne '%LocalAppData%' dizininde yer alan 'tw-' isimli boş klasörleri silme komutu eklendi.
	• "Hizmet Yönetimi" bölümü kontrol kodları revize edildi.
		• Hizmet gruplarını; (Kaldırılmış: Kırmızı renk █) │ (Açık: Yeşil renk♦) │ (Kapalı: Gri renk █ │ (Kısmen açık/kapalı hizmet var= Açık Mavi renk ♦) │ (Kısmen Açık/Eksik hizmet var= Kırmızı renk ♦) │ (Kısmen Açık/Eksik ve Kapalı hizmet var= Mor Renk ♦)
		• Sistem geri yükleme hizmet olarak kapatma bölümü eklendi.
	• İnternet kontrol adresleri azaltıldı.
	• İngilizce dil bölümünde iyileştirmeler yapıldı. 
	

</details><details><B><summary> Versiyon 4.1.1 ►  04.10.2023</B></summary>

	• Sistem optimizasyonu [Playbook] bölümünde düzenlemeler yapıldı. 

</details><details><B><summary> Versiyon 4.1.0 ►  01.10.2023</B></summary>

	• 'Hizmetleri Yönet' bölümüne yeni açıklayıcı bilgiler eklendi.
	• "Sistem optimizasyonu [Playbook]" bölümüne seçmeli ayarlar eklendi. Artık işlem öncesi belli başlı ayarları seçip işleme devam edebilirsiniz.
		• Ayrıca bazı hatalar giderildi. Birkaç basit ekleme ile optimizasyon arttırıldı.
	• "Uygulama yükleyici" bölümünde Winget ile uygulamaları toplu güncelleme komutunda eski sürümleri sil parametresi kaldırıldı. Uygulamaların altyapısı bu parametreye uygun değil.
	

</details><details><B><summary> Versiyon 4.0.9 ►  21.09.2023</B></summary>

	• İngilizce dil dosyasında iyileştirmeler yapıldı.
	• "Windows-Market onar" bölümünde düzenleme yapıldı.
	• "Sistem optimizasyonu [Playbook]" bölümünde düzenlemeler yapıldı.
		• Market uygulamalarını kaldırırken temel programları silmeyecek şekilde düzenlendi.
		• Uyarı ekranı sadeleştirildi. Sistem düzenlemesi hakkında bilgilendirme ve yönlendirmeler eklendi.
		• İlk onaydan sonra ikinci bir uyarı ekranı daha eklendi. Uyarı ekranını mutlaka okuyun. 
		• Sistem üzerinde yapılan değişikliklerde düzenleme yapıldı. Güncelleme bölümü optimize edildi. Hatalı komutlar düzeltildi.
	
</details><details><B><summary> Versiyon 4.0.8 ►  04.09.2023</B></summary>

	• Uygulama yükleyici bölümündeki internet kontrol bölümüne bilgi mesajı eklendi. Artık internet bağlantısı olmadığı durumlar için bilgi mesajı verip ana menüye dönecek.
	• Playbook bölümündeki bazı regedit komutları düzenlendi. 
	• Toolbox artık Win10-11 tüm sürümlerde çalışabilecek. Sınırlamalar kaldırıldı.

</details><details><B><summary> Versiyon 4.0.7 ►  27.08.2023</B></summary>

	• "Uygulama yükleyici" bölümünde çoklu seçimde "All in One Runtimes" seçiminden sonra oluşan bilgilendirme mesajındaki hata giderildi.
	• "Sistem hakkında" bölümüne Windows yönetim araçlarından alınan verilerden hata payı olabileğiyle ilgili bilgilendirici metin eklendi.
		• "Sistem hakkında" bölümünden ana menüye dönüşte silinen log kayıtlarından kaynaklı hatalı bilgilendirme mesaj sorunu giderildi.

</details><details><B><summary> Versiyon 4.0.6 ►  27.08.2023</B></summary>

	• Sistem temizleyici bölümüne olay günlüğü temizleme komutları eklendi.
	• İlk açılıştaki komut ekranında boş siyah ekran görünmemesi için OgnitorenKs Toolbox yazısı eklendi.

</details><details><B><summary> Versiyon 4.0.5 ►  26.08.2023</B></summary>

	• 7-Zip kurulum hatası giderildi. (Yapımcısı Winget sistemine eklediği kurulum setupta programfiles içine 7-Zip klasörü açamıyormuş)
	• Uygulama yükleyici bölümüne Microsoft Store ile Uygulama yükleyiciyi güncelleyin uyarısı ekledim. Ayrıca 80 numaralı işlem ile Microsoft Store'un güncelleme ekranını açmasını sağladım.
	• Varsayılan uygulama ekleme bölümündeki eksik kod hatası giderildi.
	• Uygulama yükleyici bölümüne 'PortMaster' uygulaması eklendi.

</details><details><B><summary> Versiyon 4.0.4 ►  19.08.2023</B></summary>

	• "Lisans-Kullanıcı yönetimi" bölümü ana menüye dönüşteki işlem başarılı mesajının çıkması engellendi.
	• 22H2 altı sürümlerde Toolbox'ın açılma sorunu giderildi.

</details><details><B><summary> Versiyon 4.0.3 ►  19.08.2023</B></summary>

	• Ana menü içinde yer alan X işlemli kapatma işlevi aktifleştirildi.
	• İngilizce dil desteği yeniden eklendi.
	• Sistem varsayılan dilinden toolbox dili otomatik seçilecek şekilde düzenlendi. 
	• Dil seçeneğini manuel değiştirmek için Ana menüye "Dil değiştirme" bölümü eklendi.

</details><details><B><summary> Versiyon 4.0.2 ►  18.08.2023</B></summary>

	• "Sistem hakkında" bölümünde yer alan Monitör bilgileri kaldırılmıştır. Hatalar giderildikten sonra yeniden eklenecektir.

</details><details><B><summary> Versiyon 4.0.1 ►  18.08.2023</B></summary>

	• "Sistem optimizasyonu" bölümüne Edge silme işlemi için yeni komutlar eklendi.
	• Hizmet yönetimi bölümündeki kod hatası giderildi.

</details><details><B><summary> Versiyon 4.0 ►  18.08.2023 - Return</B></summary>

	• Toolbox tamamen yeniden yazıldı. Bütün bölümleri optimize edildi.
	• Uygulama indirme listesi güncellendi. Uygulamaları tek tıkla güncelleme işlemi eklendi.
	• Hizmetleri yönet bölümünden hizmetler dışında işlemler kaldırıldı.
	• Kaldırılan bileşenler bölümü "Özellik yönetimi" bölümünde yalnızca silme komutu uygulayacak şekilde düzenlendi.
	• "PC zaman ayarları kapat" bölümü basitleştirildi.
	• "Appx - Güncelleme yükleyici" bölümü işlevselliğini kaybettiği için kaldırıldı.
	• SHA-256 karşılaştırıcı kaldırıldı. Blogspot sayfasında gelişmiş farklı bir uygulama olarak yeniden paylaşılacak.
	• "Fat32 to NTFS" bölümü çok kullanışlı olmadığı için kaldırıldı. Blogspot sayfasında konusu ve basit bir aracı paylaşılacak.
	• "Sistem hakkında" bölümü daha okunaklı ve derli toplu hale getirildi.
	• "Kayıtlı WiFi bilgileri" bölümüne bilgi bulunamadı mesajı eklendi.
	• Ping ölçer bölümüne yeni DNS adresleri eklendi.
	• İnternet kontrol komutları yeniden eklendi. Artık hata vermeyecek şekilde düzenlendi.
	• Son zamanlarda popüler olan Playbook trendini kaçırmamak için "Güncelleme sonrası temizlik" bölümü kurulu Stock Win10/11 sistemi OgnitorenKs Performans sistem yapmak için geliştirildi ve düzenlendi.
	• "Windows - Market onar" bölümüne eklemeler yapıldı.
	• "Genel temizlik" bölümü "Sistem temizliği" olarak yeniden adlandırılıp içeriği geliştirildi.
	• "Görev çubuğu özelleştirme" bölümü kaldırıldı. Hatalara neden oluyordu. Çok kullanışlı değildi.
	• "İşlem önceliği" bölümü kaldırıldı. Fazla etkili bir ayar değildi. Blogspot üzerinden ayrı bir konu ve aracı paylaşılacak.
	• Chocolatey indirme sisteminden kaldırıldı. Artık yalnızca Winget indirme sistemi kullanılacak.
	• Win10/11 22H2 sistemlerde çalışacak şekilde düzenlendi.
	• Türkçe karakter tespit kodları optimize edildi.
	• "Temizle ve kapat" bölümü yalnızca "Kapat" olarak yeniden adlandırıldı.
	• Yönetici yetkisi almak için artık Powershell kullanılacak. NSudo yalnızca TrustedInstaller ve yönetici yetkisi olmadan işlem yapılması gereken yerlerde kullanılacak.
	• Güncelleme komutları optimize edildi. Günlük 1 güncelleme sınırı kaldırıldı.
	• "All in One Runtimes" bölümü optimize edilip güncellendi.
	• 7-zip ve Jpegview gibi programlar kurulurken varsayılan olarak ayarlanacak şekilde düzenlendi.

</details><details><B><summary> Versiyon 3.9 ►  09.03.2023 - DEV</B></summary>

	• Toolbox yeniden yazılmaya başlandı.
	• Detaylı hizmet yönetimi bölümü oluşturuldu.
	• İndirme işlemleri ağırlıklı olarak Chocolatey'e üzerine aktarıldı.

</details><details><B><summary> Versiyon 3.8.1 ►  08.12.2022 - THE END</B></summary>

	• Genel olarak son düzenlemeler yapılıp, bir kaç bug giderildi.

</details><details><B><summary> Versiyon 3.8 ►  29.11.2022 - THE END</B></summary>

	• Çoklu dil desteği için altyapı oluşturuldu.
		• Dil seçimini sistem açılışınd otomatik yapmaktadır. Açıldıktan sonra bu "Dil ayarları" bölümünden değiştirilebilir.
	• Araçlar katılımsız bölümü kaldırıldı.
	• Online katılımsız bölümünden oyunlar kaldırıldı. Yeni programlar eklenerek daha düzenli hale getirildi.
	• İndirme sistemi Winget ve Chocolatey olarak düzenlendi. İndirme sistemleri arasında geçiş kaldırıldı.
		• Sistem içinde Microsoft Store ve Uygulama yükleyici (DesktopAppInstaller) olmadığında indirme bölümü çalışmayacak.
	• Toolbox loglama özelliği kaldırıldı.
	• Windows Editör bölümü kaldırıldı. Builder aracıyla farklı bir çalışma olarak düzenlenecek.
	• İnternet kontrol bölümleri kaldırıldı. Bazı sistemlerde anlamsız hatalara neden oluyordu.
	• Klasör yolunda Türkçe karakter ve boşluk tespiti için komutlar eklendi.
	• Güncellemeler artık Toolbox'ı attığınız dizin içinde yapılacak.
	• Simge hatalarını onar bölümü "Windows - Market onar" bölümüne eklendi.
	• Kaldırılamayan uygulamalar bölümü kaldırıldı. Yalnızca Win10'da çalışıyordu.
	• Toolbox ayarları bölümü kaldırıdlı.
	• Güncelleme sonrası temizlik bölümü düzenlendi.
	• Hizmet yönetimi bölümündeki kontrol komutları düzenlendi. Olası hata mesajları önlendi. Hatasız içerik kontrol ayarları yapıldı.
	• Hizmet yönetimi bölümüne ilk açılışta yedekleme komutları eklendi.

</details><details><B><summary> Versiyon 3.7.1 ►  06.10.2022</B></summary>

	• Kaldırılamayan uygulamalar bölümünde Python komutları düzenlendi.
	• Katılımsız program / ayar ekle > klavye - mouse optimizasyonu bölümündeki kod hatası giderildi.

</details><details><B><summary> Versiyon 3.7 ►  01.10.2022</B></summary>

	• x64 sistem uyarısı eklendi.
	• Yönetici yetki uyarısı kaldırıldı. Düzenlenen komutlar ile doğrudan yönetici yetkisi alınacak.
	• Dağınık tarih verileri optimize edildi.
	• Zip dosyalarını ayıklamak için 7-zip eklendi. Yer yer Powershell ile çıkarma komutları uygulanmakta.
	• Dosya kontrol sistemi geliştirildi.
	• Toolbox oto güncelleme komutları optimize edildi.
	• Ana menü içindeki gereksiz yönlendirme mesajları kaldırıldı.
	• Lisans yönetimi bölümünde 'slmgr /ipk' komutları düzenlendi. Ana menü yönlendirme bölümüne alındı. Ayrı başlık silindi.
	• Hizmet yönetimi bölümü kodları toparlandı. Karmaşık durduğu için okunaklığını azaltmaktaydı.
	• Internet kontrol adresi Links.txt dosyası içine eklendi. Olası internet yok sorununa hızlı çözüm üretmek için bu şekilde düzenledim.
	• SHA 256 Hash karşılaştırıcı bölümünde büyük küçük harflerden kaynaklı oluşan uyumsuzluk sorunu giderildi.
	• Kullanıcı hesap yönetimi bölümündeki komutlar toparlandı.
	• Hizmet Yönetimi > Akış hizmeti bölümüne 'Kaliteli Windows Ses Deneyimi hizmeti' eklendi.
	• Hizmet Yönetimi bölümü yeniden düzenlendi. Menü genişletildi.
		• Disk birleştirme hizmeti eklendi.
		• Optimizasyon bölümü buraya eklendi.
			• Oyun Modu eklendi.
		• Özellikler bölümü eklendi
			• Paint
			• Wordpad
			• Notepad
			• Adım Kaydedici
			• Powershell-ISE
			• Matematik ifade tanıyıcı
			• Windows Media Player
			• Internet Explorer
			• Linux için altyapı
			• Net Framework 3.5
			• Net Framework 4.5
			• DirectPlay
			• CompactOs ►"Windows 10/11 Edit bölümünden taşındı"
			• Eski Fotoğraf Görüntüleyici ► "Windows 10/11 Edit bölümünden taşındı"
			• Eski Alt + Tab ► "Windows 10/11 Edit bölümünden taşındı"
			• Güncellemeleri 2050'ye ertele ► "Windows 10/11 Edit bölümünden taşındı"
		• Sağ-tık Yönetici bölümü eklendi. ► "Windows 10/11 Edit bölümündeki ilgili ayarlar buraya eklendi"
			• Sahiplik Al
			• Yönet
			• Çalıştırma Seçenekleri
			• Terminal (Win11)
			• Eski Menü (Win11)
	• PC Temizle bölümünde System32 Temp klasörü içinde '.tmp' isimli boş klasörleri silme komutu eklendi.
	• Güncelleme sonrası temizlik bölümünde Python yüklenmeme hatası giderildi.
	• 'PC Temizle' bölümü 'Genel Temizlik' olarak değiştirildi.
	• 'İnternet önbelliğini temizle', 'Genel Temizlik' bölümüne eklendi.
	• Optimizasyon bölümünde yer alan 'İşlem Önceliği' ana menüye alındı.
	• 'Kullanıcı Hesap Yönetimi' ve 'Lisans Yönetimi' tek bir başlıkta toplandı: 'Hesap ve Lisans Yönetimi'
	• Windows 10/11 Edit bölümünlerinde yer alan içeriklerin büyük kısmı 'Hizmet yönetimi' bölümüne aktarıldı.
		• Windows 10/11 Edit alanı 'Görev çubuğu yöneticisi' olarak değiştirildi.
		• Simge değiştir bölümü stabil bir çalışma düzeni göstermediği için kaldırıldı.
		• Windows 11 Edit > Taskbar Boyut ve Taskbar Konumu 22H2'de çalışmadığı için kaldırıldı.
	• Güncelleme sonrası temizlik bölümünde uygulanan regedit kayıtlarına yedekleme sistemi getirildi.
	• Renklendirme komutu tek parça haline getirildi.
	• 'Windows Editör' dosya kontrol sistemi konu başından alındı ve ilgili başlıklara eklendi.
		• 'Hyper-V / gpedit.msc ekle' bölümleri kaldırıldı.
		• İmaj topla bölümündeki Mount yol hatası giderildi.
	• Kullanıcı değişken atama bölümlerindeki kod karmaşıklığını önlemek için 'MobileValue' fonksiyonu oluşturuldu.
	• 'Windows Editör' > İmaj toplama bölümüne Powershell ve Dism ile toplama seçenekleri eklendi. 
		•Settings.ini üzerinden düzenlenecek şekilde ayarlama yapıldı.
	• Extra\UpdateAfter.bat dosyası içindeki komutları OgnitorenKs.Toolbox.bat 'UpdateAfter' bölümüne eklendi.

</details><details><B><summary> Versiyon 3.6.1 ►  04.09.2022</B></summary>

	• Performans Optimizasyonu > Nihai Performans güç seçeneği bölümünün durumunu gösteren komutdaki hata giderildi.
	• Windows Edit > Katılımsız Program / Ayar Ekle > Masaüstüne dosya ekle bölümüne dosyalarınızı ekleyeceğiniz klasör dizini açılacak şekilde ayarlandı.
		• Dosyalarınızı açılan klasör penceresinin içine attıktan sonra herhangi bir tuşlama yaparak işleme devam edecebileceksiniz.
	• Windows Edit > Katılımsız Program / Ayar Ekle > Katılmsız dosya içine sonradan chocolatey sisteminden ve offline programların nasıl ekleneceğine dair bilgi mesajları eklendi.
		• Görev Zamanlayıcı optimizasyonu
		• Animasyon efektlerini kapat
		• Yeni mouse simgesi
		• Klavye-Mouse Optimizasyonu eklendi.
	• Performans Optimizasyonu > İnternet optimizasyon, AMD - Nvidia ekran kartı optimizasyonu, Genel optimizasyon bölümleri kaldırıldı.
		• Tam olarak istenileni veremediği için bu bölümleri kaldırdım. Genel optimizasyon bölümü 'Güncelleme sonrası Temizlik' ile benzer olduğu için kaldırıldı.
	• Temizle ve kapat bölümündeki komut hatası giderildi.
	• Kaldırılamayan uygulamalar bölümünde Python Chocolatey sisteminden yüklenecek şekilde düzenlendi.
	• Uygulama ve Araç indirme bölümleri aktif indirme sistemini göstermesi için eklemeler yapıldı.
		• Hızlı değişim için Toolbox Ayarlarına yönlendirme bölümü eklendi.
	• Araç yükleme > Geforce Experience eklendi
	• Hizmetleri Yönet > Tanı ilkesi hizmeti eklendi. İçerisinde program uyumluluk hizmeti de bulunmaktadır.
	• Hizmetleri Yönet > Hızlı kullanıcı değiştir bölümüne döngü komutunda eksik parametre eklendi.
	• Windows 10/11 Edit > Gpedit.msc bölümündeki gereksiz komutlar kaldırıldı.
	• Chocolatey yedek indirme sistemi olarak ayarlandı.
	• Windows Edit > Katılımsız Program / Ayar Ekle > 'Katılımsız dosyası oluştur' bölümünde 'Start.bat' kaldırıldı.
		• Katilimsiz.bat yönetici yetki alma komutları değiştirildi.
		• Daha önceden bu bölümde katılmsız hazırlayıcı yapıp yedekleyenler yeniden düzenleme yapmalıdır.
	• "Toolbox Ayarları" bölümü "Toolbox Ayarları - İletişim" olarak düzenlendi.
		• Menü içinde iletişim ve site bölümleri sade hale getirildi.
	• Windows 10 Edit > Simge değiştir bölümünde bazı durumlarda değiştirme işleminin yapılamadığı uyarı yapıldı.
		• Bu tarz bir sorunda manuel olarak bu dosyaları değiştirmek isterseniz "Simge değiştirme konusu" eklendi.
	• Windows 10 Edit > Gpedit.msc bölümü kaldırıldı. Son güncellemelerde yükleme işleme rağmen aktif olmuyordu.
	• Kullanım deneyimini arttırmak için Sağ üstten kapatılacak şekilde düzenlenmiş bölümlere X tuşu kapat olarak eklendi.
	
</details><details><B><summary> Versiyon 3.6 ►  26.08.2022</B></summary>

	• Windows Düzenleme > 'Katılımsız Program / Ayar Ekle' bölümü eklendi.
		• Düzenleme yapacağınız imajların ilk açılış ekranına katılımsız kurulum ekleyebileceksiniz.
		• İçerisindeki programlar temel olarak ihtiyaç duyulabilecek programlardan seçilmiştir.
		• Toolbox ekle bu bölüme eklendi. Hatalar giderildi.
	• Performans Optimizasyonu > Ognitorenks Güç seçeneği kaldırıldı. 
		• Yerine Nihai performans ekle getirildi.
	• Windows Düzenleme > Menülere uyarı mesajları eklendi.
	
</details><details><B><summary> Versiyon 3.5.3 ►  20.08.2022</B></summary>

	• Toolbox, internet kontrol durumunu kapatacak ayarlama yapıldı.
		• Bazı durumlarda internet olmasına rağmen bağlantı olmadığına dair uyarı verdiği için eklendi.
	• Chocolatey ana indirme sistemi olarak tanımlandı. İlk açılışta yüklü değilse kurulum işlemini gerçekleştirecektir.
		• Chocolatey'i doğrudan varsayılan indirici olarak seçmemin sebebi olası indirme hatalarını en aza indirmektir.
		• Benim hazırladığım indirme sistemini kullanmak isteyenler toolbox ayarlarından değiştirebilir.
		• Chocolatey indirme sistemine dahil olmayan uygulamaları belirtmek için menü de yanlarına 'ø' sembolü eklendi.
	• 'Uygulama İndir' bölümüne eklenler;
		• Node.JS
		• Unity.Hub
	• Windows Düzenleme > 'OgnitorenKs Toolbox ekle' bölümü eklendi. İmaja toolbox'ı zahmetsiz bir şekilde entegre edebilirsiniz.
	• Windows Düzenleme > Program çakışmalarını önlemek için bazı işlemlerde uyarı mesajı eklendi.
	
</details><details><B><summary> Versiyon 3.5.2 ►  18.08.2022</B></summary>

	• Hizmetleri Yönet > Windows Search bölümüne yeni paramatre eklendi.
		• Ayarlar > Gelişmiş arama dizin oluşturma hatası giderildi.
	• Windows Editör bölümünün açıldığı gibi kapanmasına neden olan hata giderildi.
	• Ana menüye tarih bilgisi eklendi.
	• Discord sessiz kurulum sonrası uygulamanın açılmama hatası giderildi.
	
</details><details><B><summary> Versiyon 3.5.1 ►  03.08.2022 - QuickFix</B></summary>

	• Uygulama indir bölümündeki kapanma sorunu giderildi.
	
</details><details><B><summary> Versiyon 3.5   ►  03.08.2022</B></summary>

	• Güncelleme sonrası temizlik bölümüne yeni parametreler eklendi. EdgeWebView2 engelleme parametresi kaldırıldı.
	• PowerChoice (Güç Seçenekleri) kaldırıldı.
	• Hizmetleri Yönet > Çoklu seçim özelliği eklendi.
	• Hizmetleri Yönet > Xbox bölümünde Teslimat optimizasyonu hizmetinin kapanmama sorunu giderildi.
	• Hizmetleri Yönet > Hyper-V hizmeti kaaptılmasına rağmen açık görünmesine neden olan hata giderildi.
	• Hizmetleri Yönet > Uçak modu hizmetinin Windows 11 ile alakalı kontrol komutları optimize edildi.
	• Hizmetleri Yönet > Uzak masaüstü/Akış/Ağ hizmetleri ayrı işlemler haline getirildi.
	• Hizmetleri Yönet > Miracast hizmeti bölümüne Ayarlar/Cihazlar kısmıyla ilgili uyarı mesajı eklendi.
	• Sistem tespitiyle alakalı komutlar optimize edildi.
	• Optimizasyon bölümündeki yönlendirme hatası giderildi.
	• Windows 10/11 Edit > Alt + Tab [Eski/Yeni] bölümü eklendi.
	• Windows 10/11 Edit > Eski Windows Fotoğraf Görüntüleyici [Ekle/Kaldır] bölümü eklendi.
	• Windows 10/11 Edit > Sağ-Tık Yönet bölümü eklendi
	• Windows 11 Edit > 'Taskbar Boyut' ve 'Taskbar Konumu' bölümlerine 22H2 sistemle ilgili uyarı mesajları eklendi.
	• Windows 10 Edit > Microsoft Store Kaldır bölümünden Runtime Broker hizmeti kaldırıldı. Başlat menüsü ve ayarlarda sorun çıkarıyordu.
	• Performans Optimizasyonu > OgnitorenKs Güç seçeneği bölümü eklendi.
	• Uygulama Yükleyici > All In One Runtimes bölümüne tekli yüklemeler için menü bölümü oluşturuldu.
		• 1M tuşlayarak bu menüye ulabilirsiniz. 1M ile yapacağınız işlemde diğer çoklu seçmeler iptal olur.
		• All In One Runtimes bölümünü toplu kurmak istiyorsanız yalnızca 1 tuşlamanız gerekmektedir.

</details><details><B><summary> Versiyon 3.4.2 ►  14.07.2022</B></summary>

	• Kaldırılamayan Uygulamalar bölümü Windows 11'de çalışmadığı için uyarı mesajı eklendi.
		• İşlem yapılamayacağı için Windows 11'de Python kurulması engellendi.
	• Güncelleme sonrası bölümde de 'Kaldırılamayan Uygulamalar' bölümüyle ilgili parametler Windows 10'a özel hale getirildi.
	• Windows Edit > Setup Edit bölümünde ilk girişte loglama kaydında oluşan hata parametresi kaldırıldı.
	• Windows Edit > Setup Edit bölümünde regedit kayıtları düzenlendi.
	• Windows Edit > Çoklu Seçimlerde kapanma sorunu giderildi.
	• Hizmetleri Yönet > Sistem geri yükleme bölümünde volsnap hizmeti kaldırıldı.
	• Hizmetleri Yönet > Bitlocker hizmeti bölümünden fvevol hizmeti kaldırıldı.

</details><details><B><summary> Versiyon 3.4.1 ►  08.07.2022</B></summary>

	• Windows 10/11 Edit > Telemetri/Reklam engelli hosts ekle bölümünde veri kaybını önlemek için mevcut dosya hosts.bak olarak değiştirilmesi için komutlar eklendi.
		• [quanqx]'a geri bildirimi için teşekkür ederim.
	• Araç Yükleyici > GPU-Z indirme hatası giderildi.
	• Araç Yükleyici > FurMark indirme hatası giderildi.
	• Araç Yükleyici > NVCleanstall indirme hatası giderildi.
	• Uygulama Yükleyici > Gimp indirme hatası giderildi.

</details><details><B><summary> Versiyon 3.4   ►  06.07.2022</B></summary>

	• Araç Yükleyici > Snappy Driver Installer eklendi
	• Araç Yükleyici > Spotify Adblocker eklendi.
	• Araç Yükleyici > NTLite katılımsız kurulum parametresindeki komut hatası giderildi.
	• Araç Yükleyici > VMWare sanal makine programı kurulum sorunlarından dolayı kaldırıldı.
	• Kaldırılamayan Uygulamalar > Kamera Barkod Tarayıcı durumunu gösteren bölümdeki komut hatası giderildi.
	• Kaldırılamayan Uygulamalar > Microsoft Edge kaldırıldı. Silinince bağlı market uygulamaları sorun çıkarıyor. Örnek; Instagram.
	• Zaman Ayarlı PC Kapat bölümünde 'İptal Et' bölümü otomatik kapatma işlemi var veya uygulanırsa çıkacak şekilde düzenlendi.
	• Microsoft Store kaldırma bölümüne Runtime Broken hizmetini kapatma parametreleri eklendi.
	• Hizmetleri Yönet > Fax hizmetini aç/kapat bölümü eklendi.
	• Hizmetleri Yönet > Yazı Tipi Önbellek hizmetini aç/kapat bölümü eklendi.
	• Hizmetleri Yönet > Hızlı Kullanıcı Değiştirme hizmetini aç/kapat bölümü eklendi.
	• Hizmetleri Yönet > Sistem Geri Yükleme hizmetindeki komut hatası giderildi.
	• Windows 10/11 Edit > Telemetri/Reklam engelli hosts dosyası ekle bölümü getirildi.

</details><details><B><summary> Versiyon 3.3   ►  01.07.2022</B></summary>

	• Chocolatey indirme sistemi alternatif olarak eklendi.
	  • Varsayılan olarak kapalı gelir. Toolbox ayarlarından açılıp, kapatılabilir.
	  • İndirme işlemlerinin hangi istemci üzerinden yapıldığının anlaşılması için [Chocolatey] / [Wget] yazısı yerleştirildi.
	  • All in One Runtimes | Wemod | ISLC | ByClickDownloader | Hibit Uninstaller | Wise Care 365 | Oyunlar | Spotify işlemleri Chocolatey seçilse dahi Wget üzerinden yapılacaktır.
	• NSudo kontrol bölümünde indirme komutu düzenlendi.
	• Internet bağlantı kontrol komutları düzenlendi.
	  • 'www.bing.com' adresi yerine 'google.com' kullanıldı.
	• All in One Runtimes bölümünde '.Net Desktop Runtime 5' sürümü yerine 6 sürümü eklendi.
	• Windows Edit > Regedit Yükle bölümündeki kayıtların isimleri değiştirildi. Detaylar Github Proje sayfasında
	• Windows Edit > ESD to WIM bölümündeki komut hatası giderildi. 
	• Optimizer bölümünde sorun yaratacak bölümlere uyarı mesajları eklendi.
	• Optimizer bölümünde İşlemci Optimizasyonu bölümü kaldırıldı.
	• Optimizer bölümüne Aygıt Optimizasyonu eklendi.
	• Hizmet Yönetimi > Sistem Geri Yükleme bölümüne ekleme yapıldı.
	• Optimizer bölümünde işlem ve yönlendirmelerin daha rahat anlaşılması için yorum satırları eklendi.
	• Optimizer bölümünde Oyun İşlem Önceliği kaldırıldı.
	• Optimizer bölümüne 'Uygulama İşlem Önceliği Düzenleme' bölümü eklendi.
	• Hizmet Yönetimi > Uzak masaüstü, Akış ve ağ bölümüne yeni eklemeler yapıldı.
	• PC yönetimi için gerekli araçlar 'Araç Yükleyici' bölümü oluşturulup eklendi.
	  • Eklenen programlar;
	    • NTLite
	    • Dism++
	    • Rufus
	    • Aida64
	    • CPU-Z
	    • GPU-Z
	    • HW Info
	    • CrystalDiskInfo
	    • HD Sentinel
	    • Core Temp
	    • CrystalDiskMark
	    • Prime95
	    • OCCT
	    • FurMark
	    • Virtual Box
	    • VMWare
	    • GreenFish
	    • Thumbico
	    • Quick Any 2 Ico
	    • Resource Hacker
	    • NSudo
	    • Explorer++
	    • Display Driver Uninstaller
	    • Nvidia Profile Inspector
	    • RadeonMod
	    • Radeon Software Slimmer
	    • NVCleanstall

</details><details><B><summary> Versiyon 3.2.2 ►  12.06.2022</B></summary>

	• Hizmet Yönetimi > Xbox hizmeti için üst düzey yetki kaldırıldı.
	• Hizmet Yönetimi > Hyper-V'nin Home sürümlerine kurulmasını sağlayan komutlar kaldırıldı. 
	  • Pro sürüm için aç/kapat olacak şekilde düzenlendi.
	• Windows 10 Edit > Simge değiştir bölümündeki komut hatası giderildi.
	• Desktop Runtime 6 sürümü AIO bölümünden kaldırıldı.

</details><details><B><summary> Versiyon 3.2.1 ►  10.06.2022</B></summary>

	• Hizmet Yönetimi > Xbox hizmeti için üst düzey yetki verildi.
	
</details><details><B><summary> Versiyon 3.2   ►  08.06.2022</B></summary>

	• Online Katılımsız bölümündeki değişiklikler;
	  • Recuva kaldırıldı
	  • AOEMI Partition kaldırıldı
	  • Folder2ISO kaldırıldı
	  • SSDBooster kaldırıldı
	  • Stremio kaldırıldı [Yükleme işlemi gerçekleşmiyordu]
	  • Stellarium kaldırıldı 
	  • ProcessHacker2 kaldırıldı
	  • Cheat Engine kaldırıldı [Yükleme işleminde birden fazla programı izin almadan kurduğu için]
	  • Phycharm kaldırıldı 
	  • HandBrake eklendi
	  • Spotify eklendi
	  • Diğer bölümündeki bazı programlar gruplandırıldı.
	• Setup bölümünde Windows 10 ve 11 dosyaları birleştirildi.
	  • İşlem sonunda driver ve imaj toplanmasıyla ilgili kullanıcı yönlendirme soruları eklendi.
	• Hizmet Yönetimi > Wifi hizmeti bölümündeki komut hatası giderildi. 
	• Log kayıtları düzenlendi.
	• İnternet önbelliği temizle bölümü eklendi.
	• İndirme bölümünde indirilen programların isimlerini göstermesi için düzenleme yapıldı.
	• Gimp indirme linkindeki sorun giderildi.
	• Windows Editör > Hyper-V bölümündeki yönlendirme hatası giderildi.
	• Windows Editör > Katılımsız Program/Ayar Ekle kaldırıldı.
	  • Güncelleme, hata giderme durumlarını sürekli takip edemediğim için kaldırdım.

</details><details><B><summary> Versiyon 3.1.2 ►  29.05.2022</B></summary>

	• Optimizasyon aracındaki NVIDA ekran kartı bölümündeki yedekleme hatası giderildi.
 	• Kaldırılamayan uygulamalar bölümünde Python yükleme ekranı düzeltildi.

</details><details><B><summary> Versiyon 3.1.1 ►  29.05.2022</B></summary>

	• Güncelleme sonrası bölümündeki bazı uygulama kaldırma komutları iptal edildi.

</details><details><B><summary> Versiyon 3.1   ►  28.05.2022</B></summary>

	• Windows Store Onar bölümüne yeni paremetreler eklendi.
	• Windows Editör > Setup düzenleme > Setup dosyaları yenilendi. 
	• 10 ve 11 sistemler için özel düzenlemeler yapıldı.
	• İndirme bölümünde 45 - 46 numaralı işlem hataları giderildi.
	• JpegView uygulaması indirme bölümüne eklendi.
	• Revo Uninstaller indirme bölümüne eklendi.
	• Hash-256 kontrol aracı eklendi.
	• Kaldırılamayan Uygulamalar bölümü eklendi.
	• Microsoft'un kaldırılasını engellendiği bazı uygulamaları silmenizi sağlar.
	• Performans Optimizasyonu bölümü eklendi.
	• Benim ve büyük çoğunluğuyla Denizlili'nin hazırladığı optimizasyon araçları düzenlenerek hazırlandı.
	• Ayarlar değiştirilmeden önce regedit kayıtları yedeklenir. Yapılan işlemi varsayılan haline getirebilirsiniz.
	• Güncelleme sonrası temizlik bölümünde kaldırılmayan uygulamaları silmesi için komutlar eklendi.
	• Bu bölümün sorunsuz çalışması için sisteme Python kurulması gerekmektedir. Yüklü değil ise katılımsız yükleyecektir.
	• Bazı regedit kayıtları düzenlendi.

</details><details><B><summary> Versiyon 3.0.2 ►  11.05.2022</B></summary>

	• Simge hatalarını onar bölümü yeniden eklendi. [Legnica'nın isteğiyle]

</details><details><B><summary> Versiyon 3.0.1 ►  10.05.2022</B></summary>

	• Windows Editör > Setup Edit bölümündeki hata giderildi.
	• Windows Editör > Regedit Topla bölümündeki komut hatası giderildi.
	• PC Temizle bölümü yeniden eklendi. [Joker'in isteğiyle yeniden eklendi.]
	• Temizle ve Kapat bölümündeki hata giderildi. [CadyMeow'a geri bildirimi için teşekkür ederim]

</details><details><B><summary> Versiyon 3.0   ►  10.05.2022</B></summary>

	• 'Update.ini' dosyası 'Settings.ini' olarak değiştirildi.
	•  Admin yetkili girişi manuel ve otomatik olarak ayarlanması için Settings.ini dosyasına yönetim bölümü eklendi.
	• 'Logss' fonksiyonu 'LogSave' olarak değiştirildi.
	•  Gereksiz komutlar ayıklandı.
	•  Toolbox karekter takımı 'UTF-8' ile yeniden düzenlendi.
	•  İndirme komutları optimize edildi.
	•  'Icon Fix' ve 'PC Temizle' seçenekleri kaldırıldı.
		•  İçerisinde yer alan sistem onarma komutları 'Windows - Market onar' bölümüne ilave edildi.
	•  PotPlayer indirme bölümüne eklendi.
	•  EagleGet indirme bölümüne yeniden eklendi.
	•  Google Chrome / Brave / Edge tarayıcı eklentileri Settings.ini dosyasına eklendi. 
		•  Bu bölüme ekleme yapıp çıkarabilirsiniz. Dilerseniz eklentilerin yüklenmesini devre dışı bırakabilirsiniz.
	•  İnternet kontrolü için yönlendirme sitesi www.bing.com olarak ayarlandı.
	•  İndirme bölümü ayrı bir menü haline getirilip, programlar gruplandırıldı.
	•  Ana menü tasarımı tamamen değiştirildi.
	•  Windows Editör bölümünden Appx ve Dism Update seçenekleri birleştirilerek ana menüye eklendi.
	•  PowerChoice Toolbox içine 'Güç Seçenekleri' olarak eklendi. Dileyenler masaüstündeki kısayolunu silebilir.
	•  AIO runtimes Net Framework 3.5 / 4.5 ve DirectPlay kontrol bölümündeki kod hatası düzeltildi.
	•  Toolbox Ayarlar bölümü oluşturuldu. Buradan Toolbox üzerinde bazı özellikleri değiştirebilirsiniz.
	•  Log kayıt sistemi geliştirildi. Mevcut hatalar giderildi.
	•  PowerRun yazılımı yerine NSudo eklendi.
	•  İşlem tamamlandı ekranı oluşturuldu. [Archley'e desteği için teşekkür ederim.]
	•  Otomatik güncelleme sistemi yeni güncellemeyi tespit ettiğinde sürümler hakkında bilgi vererek işleme devam edecek şekilde düzenlendi.
	•  OgnitorenKs Toolbox kısayol simgesi yönetici çalışacak şekilde ayarlandı. [Finch'e desteği için teşekkür ederim]
	•  Windows Editör > Genel bir optimizasyon çalışması yapıldı. Gereksiz komutlar kaldırılıp daha düzenli hale getirildi.
	•  Windows Editör > İmaj toplama bölümündeki Dism komutu Powershell komutuyla değiştirildi.
	•  Windows Editör > ESD dosyasından dolayı işlem hatalarını önlemek için uyarı sistemi eklendi.
	•  Windows Editör > ISO hazırlama bölümüne oscdimg.exe dosya kontrolü eklendi.
	•  Windows Update dosyası güncellemelerde oluşan sorunları önleme için güncelleme öncesi indirilecek şekilde düzenlendi. Extra klasöründen silindi.
	•  Tüm çalışmalar üzerinden yapılan düzenlemelerden sonra Toolbox içerisinden 1000 civarında satır gereksiz komut silinmiştir.

</details><details><B><summary> Versiyon 2.9   ►  26.04.2022</B></summary>

	• Hizmetler Yönetimi > Dokunmatik servis bölümünde Windows 10 / 11 için ayrı servis bölümleri oluşturuldu.
	• Hizmetler Yönetimi > Hizmetlerin durumu hakkında bilgi alırken olası hata mesajlarının engellenmesi için yeni parametreler eklendi.
	• Simge önbelleğini temizle bölümünde hatalı komutlar düzeltildi.
	• Otomatik güncelleme sistemi düzenlendi. Güncelleştirme işlemi gün içinde tek bir kez kontrol edilecek şekilde düzenlendi.
	• Any Video Converter yazılımı kaldırıldı.
  		 	  • [YMuratK] tavsiyesiyle FileConverter programı eklendi.
	• Toolbox İngilizce > Hizmetleri yönet bölümündeki dil hatası giderildi.
	
</details><details><B><summary> Versiyon 2.8   ►  21.04.2022</B></summary>

	• Icon fix bölümüne yeni parametreler eklendi.
	• Icon fix bölümü "Simge Önbelleğini Temizle" olarak değiştirildi.
	• Hizmet Yönetimi > Hizmetlerin durumunu gösteren paneldeki komutlar yenilendi. Tek bir servisin açık kalması halinde ayar
 	• Hizmet Yönetimi > Bellek sıkıştma hizmetindeki komutlar düzenlendi.
 	• Hizmet Yönetimi > Hizmet kontrol bölümüdeki komutlar yenilendi. Kapsamlı şekilde hizmetleri tarayıp durumunu yansıtacak şekilde ayarlamalar yapıldı.
 	• OperaGX indirme bölümüne eklendi. 
 	• AnyDesk uygulaması, Teamviewer altına alındı.
 	• Windows Editör > Dism Update Online bölümünde güncelleme yükleme sonrası gelen restart sorgusu kaldırıldı.

</details><details><B><summary> Versiyon 2.7.1 ►  18.04.2022</B></summary>

	• Icon Fix bölümüne Search App önbelliğini temizleyen komutlar eklendi. Bu komut ile arama bölümünde oluşan simge hataları giderilebilecek
	• Bu konuda tüm çözüm önerilerini deneyip çözümü bulan; "Legnica" ya teşekkür ederim.
	• Ayrıca; Yağız Murat Köse | Kaan Beyhan | Uğur 'a teşekkür ederim. 
 	• AnyDesk uygulaması toolbox'a eklendi.
	• Windows Editör > Dism Update Online bölümünde güncelleme sonrası restart sorgusunu iptal etmek için parametre eklendi.
	
</details><details><B><summary> Versiyon 2.7   ►  18.04.2022</B></summary>

	• Hizmetleri Yönet > Windows Media Player yaşanan sorunlardan dolayı kaldırıldı.
	• Toolbox oto güncelleme sistemi getirildi. Bu özelliği OgnitorenKs.Toolbox klasörü içinde yer alan Update.ini'den kapatabilirsiniz.
	• Links.bat dosyası Links.txt olarak değiştirildi. Güncelleme işlemini hızlıca gerçekleştirmek için.
	• PowerChoice simgesi değiştirildi.

</details><details><B><summary> Versiyon 2.6.3 ►  16.04.2022</B></summary>

	• Windows Editör > 24 - Katılımsız Program/Ayar ekle [Offline] bölümü kaldırıldı.
	• [Online] bölümü içindeki tüm komutlar yenilendi. Toolbox içindeki tüm programlar eklendi.
 	• Masaüstüne dosya ekle bölümünü çalıştırdığınızda klasör penceresi otomatik açılacak şekilde ayarlandı.
 	• Bilgilendirici mesajlar katılımsız aracın her bölümüne yerleştirildi.
 	• Performans ile alakalı ayarlar tek bir bölümde toplandı.
	• Link sistemindeki bazı isimlerde değişiklik yapıldı. Bundan dolayı sorun yaşamamak için mutlaka toolbox'ı güncelleyin.
	• Wget yazılmı güncellendi.
	• Toolbox İngilizce ve 8.1 sürümlerine yeni toolbox simgesi eklendi.
	• Güncelleme sonrası temizlik bölümünden teslimat optimizasyonuyla alakalı bölüm çıkarıldı. Hataya sebep oluyordu.
	• Windows App Boss uygulaması kaldırıldı. Program çok uzun zamandır güncelleme almıyordu. Bu uygulama yerine Hibit Uninstaller kullanabilirsiniz.
	• Reiconcache yazılımı toolbox'tan kaldırıldı.
	• ISLC yazılımı indir - kur şeklinde düzenlendi.
	• Hizmet Yönetimi > Xbox bölümüne kısayol engelleyici parametre eklendi.
	• Hizmet Yönetimi > Windows Media player bölümüne yeni parametre eklendi.

</details><details><B><summary> Versiyon 2.6.2 ►  13.04.2022</B></summary>

	• Güncelleme sonrası temizlik bölümündeki hata giderildi.
	• Toolbox İngilizce sürümü Türkçe sürümü ile senkronize gelişecek şekilde yeniden düzenlendi.
	• Windows 8.1 Toolbox sürümü için Güncelleme ve katılımsız kurulum araçları eklendi.
	• Github'daki proje tek bir bölümde toplandı. TR / ENG / 8.1 sürüm dosya ve katılımsız araçları tek bir yerden sunulanacak.
	• İniglizce Toolbox hakkında detayları öğrenmek için "Google Translate" kullanılması gerekmektedir.
	• Güncelleştirme sonrası temizlik bölümündeki hizmetler "Extra\Update.After.bat" dosyasından toplandı.
	• PowerRun yazılımıyla tek bir işlem yapmak için tek bir .bat dosyasında topladım. 

</details><details><B><summary> Versiyon 2.6.1 ►  12.04.2022</B></summary>

	• Hizmetleri Yönet > Hizmetlerin açık veya kapalı olma durumları menü içinde belirtildi.
	• Hizmetleri Yönet > Baskı hizmetini aç kapat kaldırıldı.
	• Hizmetleri Yönet > Ip yardımcı bölümündeki yönlendirme hatası giderildi. 
	• Hizmetleri Yönet > Radyo ve uçak modu hizmeti bölümünde Windows 10 sistemlerdeki kapanma hatası giderildi.
	• Hizmetleri Yönet > Windows Search yönlendirme hatası giderildi.
	• Hizmetleri Yönet > Hyper - V kapat bölümündeki komut hatası giderildi.
	• PowerRun yazılımının yeninden indirme bölümünde yer alan komut hatası giderildi.
	• Hizmetleri Yönet bölümünde fazla işlem yapılınca antivirüs programı PowerRun yazılımdan huylanabiliyor.

</details><details><B><summary> Versiyon 2.6   ►  10.04.2022</B></summary>

	• Ana menüde ve bazı iç bölümlerde farklı bölümlere açılan kısımlar için ifadeler yerleştirildi.
	• Menü bölümlerine [M] / Uygulama olarak açılan bölüme [APP] / ayrı pencere olarak açılacak bölüme [*] işareti bıraktım
		• "quanqx"a önerisi için teşekkür ediyorum.
	• Toolbox'ın bazı bölümlerinde yer alan linkler karmaşıklığı azaltmak için Links.bat dosyasına eklendi.
		• Links.bat / Setup.zip / ICO.zip dosyalarını drive linkleridir.
	• Güncelleme sonrası temizlik bölümnde Defender klasör artıklarını silme komutlarındaki parametre hatası giderildi.
	• "Hizmetleri yönet" > "GPU optimizasyon" bölümü kaldırıldı.
		• Bu tarz optimizasyonların GPU uygulamaları üzerinden kullanıcının kendi isteklerine göre düzenlemesini daha sağlıklı bulduğum için kaldırdım.
	• All in One Runtimes bölümündeki eski sürümleri kaldırmaya yarayan komutlar kaldırıldı. Yeniden yüklemelerde hataya sebep oluyordu.
		• Net Framework 3.5 / 4.5 / DirectPlay bölümleri önce kontrol edilip, yüklü olmaması durumunda komutlar çalışıp yükleme işlemini gerçekleştirecek.
		• All in One Runtimes yükleme bölümü arayüzü düzenlendi.
	• Toolbox simgesi değiştirildi.
	• Windows 10 Edit > Microsoft Store kaldırma bölümüne uyarı mesajı eklendi.
	• Hizmet yönetimi > "Radyo ve Uçak modu hizmeti" bölümü için Windows 11 kısıtlaması getirildi.
		• Bu servis kapatılınca ağ simgesi kaybolduğu için kısıtlama getirildi.
	• Sistem hakkında > Tarih ve saat bilgisi eklendi. (Archley'e katkısından ötürü teşekkür ederim.)
	• Hizmetleri Yönet > Telefon hizmeti bölümünde kapanma durumunda bluetooth hizmetlerinin kapatılması engellendi.
	• Hizmetleri Yönet > Hyper-V bölümünün işlem öncelikleri değiştirildi. Hyper-V bölümündeki bazı Dism komutları iptal edildi.
	• Windows Editör > Yeni Simgeleri yükle bölümündeki yol hatası giderildi.
	• Pc Temizle bölümündeki komutlar yenilendi. Başlık bölümü eklendi.
	• Windows / Store onar bölümüne başlık bölümü eklendi.
	• Windows Editör > Katılımsız Program/Ayar ekle [Online] - [Offline] bölümünde Nihai performans kısmında kod hatası giderildi.
	• Microsoft Teams indirme linklerinde yaşanan sorundan dolayı toolbox'tan kaldırıldı.
		• Katılımsız bölümünden de kaldırıldı.
	• Windows 10 Edit > Simge değiştir bölümündeki simge değişmeme sorunu tamamen çözüldü.
	• Windows / Market onar bölümündeki dll kayıt bölümündeki komutların okunması kolaylaştırıldı. For döngüsü içine alındı.
		• İşlem sonunda reset seçeneği bırakıldı.
	• Ping Ölçer bölümünün teması düzenlendi. Değişken bölümüne bilgilendirici metinler bırakıldı.
		• Yeni site ve dns adressleri eklendi.

</details><details><B><summary> Versiyon 2.5.2 ►  03.04.2022</B></summary>

	• Hizmetleri Yönet > Uzak Masaüstü/Akış/Ağ hizmetleri bölümüne Windows Search hizmetini açmak için parametre eklendi.
	• Hizmetleri Yönet > Windows Search hizmetini açıp kapatmaya yarayacak bölüm eklendi.
	• "Güncelleme Sonrası Temizlik" bölümünde düzenlemeler yapıldı. "Hizmetleri Yönet" bölümünde açılacak hizmetleri tekrar kapatmaması için düzenlendi.

</details><details><B><summary> Versiyon 2.5.1 ►  01.04.2022</B></summary>

	• Toolbox içindeki regedit komutlarında düzenleme yapıldı.
	• Blitz uygulaması kurulum sorunlarından dolayı kaldırıldı.
	• Hizmetleri Yönet > Hyper-V bölümünde bilgi ekranındaki değişken hatası giderildi. Yeni parametre eklendi.
	• Taraycı eklentileri bölümündeki kod hatası giderildi.

</details><details><B><summary> Versiyon 2.5   ►  30.03.2022</B></summary>

	• Güncelleme sonrası temizlik bölümündeki regedit kayıtları düzenlendi. 
	• Kilitlenme sorununa neden olan regedit kayıtları kaldırıldı.
	• Hizmetleri Yönet > Bellek sıkıştırma aç-kapat bölümü eklendi.
	• Hizmetleri Yönet > Hyper-V bölümündeki komutlar düzenlendi.
	• Hata düzenlemesiyle ilgili düzenlemeyi paylaşan "maskem76"a teşekkür ederim.
	• Hizmetleri Yönet > Driver güncelleme aç-kapat bölümü eklendi.
	• Hizmetleri Yönet > İşlemci çekirdek park hizmeti aç-kapat bölümü eklendi. (Core Parking)
	• Hizmetleri Yönet > Tarayıcı ve Kamera hizmetleri bölümü birleştirildi.
	• Hizmetleri Yönet > GPU optimizasyon bölümü eklendi.
	• Microsoft Edge bölümüne reklam engelleyiciler engellendi.
	• "Windows 10-11 Edit" bölümünde yer alan yönlendirme hatası giderildi.
	• "Windows 10-11 Edit" bölümüne "Güncelleştirmeleri 2050 yılına kadar ertele" bölümü eklendi.

</details><details><B><summary> Versiyon 2.4   ►  19.03.2022</B></summary>

	• Zaman ayarlı PC kapat bölümü eklendi.
	• Windows düzenleme bölümünden kaldırılanlar.
	• Silinmesi gerekenler
	• Windows 10 Hazır Regedit kayıtları
	• Windows 11 Hazır Regedit kayıtları 
	• Utorrent programı kaldırıldı. 
	• Yerine Qbittorrent programı eklendi.
	• Ana menü, alt bölümünde tasarım değişikliği yapıldı.
	• İngilizce dil destekli toolbox hazırlandı.
	• Windows 8.1 sürümü için toolbox hazırlandı.
	• Renk kodları basitleştirildi. Gereksiz kodlar kaldırıldı.
	• %konum% değişkeni %Location%, %deger% değişkeni %value% olarak değiştirildi.
	• Ekler klasörünün ismi Extra olarka değiştirildi.
	• Çoklu seçim yapılacak bölümler belirtildi.
	• Toolbox'ın her açılışta sürüm ve donanım bilgisi hakkında Log kaydı oluşturma sorunu giderildi.
	• Yapılan düzenleme ile sürüm farkı oluştuktan sonra yeni bir log kaydı tutulacak.
	• Powerchoice.bat, Extra klasörüne taşındı.
	• Process Hacker 2 sisteme eklendi.
	• Windows 10 Edit > Simge değiştir bölümündeki hata giderildi. Simgeler sorunsuz bir şekilde değiştirilebiliyor.
	• Komutlar optimize edildi. Değişim esnasında bekleme süresi azaltıldı.
	• Fat32 to NTFS bölümünde, X tuşu geri dönüş olarak belirtildi.

</details><details><B><summary> Versiyon 2.3   ►  08.02.2022</B></summary>

	• İndirme linkleriyle ilgili bilgi güncellemesi artık yapılmayacaktır. Linkler düzenli olarak güncellenecektir.
	• Windows Düzenleme > ISO oluşturma bölümünde komutlar düzenlendi. Sanal makinalarda oluşan hata giderildi.
	• Windows Düzenleme > Katılımsız program ve ayar ekle > Bcdedit bölümüne Aygıt yöneticisinden "Yüksek duyarlılıklı olay süre ölçeri" kapatan parametre eklendi.
	• Windows Düzenleme > Regedit kayıt bölümlerine eklemeler yapıldı.
	• All in One Runtimes bölümüne yükleme işlemi öncesi eski sürümleri silme işlemi eklendi. 
	• All in One Runtimes bölümüne Net Framework 3.5/4.8/DirectPlay hizmetlerini aktifleştirmesi için komutlar eklendi.
	• Windows Düzenleme > Katılımsız program ve ayar ekle [Online] bölümündeki komut hatası giderildi.

</details><details><B><summary> Versiyon 2.2   ►  26.01.2022</B></summary>

	• Windows Düzenleme > Setup düzenleme bölümünde Windows 11 Bypass aracında bilgi vermeden kapanma sorunu giderildi.
	• ISLC bölümündeki yol hatası giderildi. [Kick Furkanowski'e geri bildirimi için teşekkür ederim]
	• Signal indirme linki yenilendi. (5.28.0 > 5.29.0)
	• 7-Zip indirme linki yenilendi. (21.06 > 21.07)
	• Notepad++ indirme linki yenilendi. (8.2 > 8.2.1)
	• Mem Reduct indirme linki yenilendi. (3.3.5 > 3.4)
	• Hibit Uninstaller indirme linki yenilendi. (2.7.40 > 2.7.45)
	• İndirme bölümüne Blender uygulaması eklendi.
	• İndirme bölümüne Shotcut uygulaması eklendi.
	• İndirme bölümüne Openshot uygulaması eklendi.

</details><details><B><summary> Versiyon 2.1   ►  21.01.2022</B></summary>

	• "Kapatılan Servisleri Yönet" bölümünde değişiklikler yapıldı.
	• Kod okunaklığını arttırmak için yorum satırları eklendi.
	• Sistem geri yükleme bölümüne bazı bağlı servisler eklendi.
	• Hyper-V hizmetini [Aç/Kapat] eklendi. 
	• Bu bölüm ile Home ve Home Single Language sistemlerde Hyper-V açmanız mümkün olacak.
	• Xbox hizmeti [Aç/Kapat] eklendi.
	• Bitlocker Sürücü şifreleme hizmeti [Aç/Kapat] eklendi.
	• Karma Gerçeklik hizmeti (VR) [Aç/Kapat] eklendi.
	• Windows Düzenleme > "Hyper-V ekle [Offline]" bölümü eklendi. 
	• Home ve Home Single Language sürümlerine Hyper-V ekleyebilirsiniz.
	• Windows 10 Edit > "Taskbar Hava Durumu [Aç/Kapat]" eklendi.
	• Windows 10 Edit > "Market [Yükle/Sil]" bölümünde düzenlemeler yapıldı.
	• "Güncelleme sonrası temizlik" bölümünde yorum satırları arttırıldı. Bazı eklemeler yapıldı.
	• Yeni simge dosyaları güncellendi. Windows 11 sürümü içindeki dosyalar alındı.

</details><details><B><summary> Versiyon 2.0   ►  18.01.2022</B></summary>

	• Windows Düzenleme > "Yeni simgeleri yükle" bölümündeki yol hatası giderildi. 
	• Windows Düzenkene > "Katılımsız program ve ayar ekle [Online/Offline]" > Simge önbelleğini temizle seçeneği eklendi.
 	 	• Simge değişikliği sonrası olası sorunlar için
	• OSU oyunu indirme bölümüne eklendi.
	• "Kapatılan Servisleri Yönet" bölümü düzenlendi.
 	 	• Tüm servislere Aç / Kapat seçeneği eklendi.
 	 	• İşlem yapmak için "1a" "3k" "4A" "10K" gibi yazmanız gerekmektedir. Tırnak işaretleri dahil değil
	• Hibit Uninstaller indirme linki yenilendi. (2.7.35 > 2.7.40)
	• Signal indirme linki yenilendi. (5.27.1 > 5.28.0) 
	• Python indirme linki yenilendi. (3.10.1 > 3.10.2)

</details><details><B><summary> Versiyon 1.9   ►  11.01.2022</B></summary>

	• Gpedit.msc bölümündeki kod hatası giderildi. (Archley'e geri bildirimi için teşekkür ederim.)
	• Çoklu seçme bölümlerindeki kod hatası giderildi. (Geri dönüş kodları toolbox'ın kapanmasına neden oluyordu)
 	 	• Windows Düzenleme > AIO bölümüne "X" geri çıkış tuşu yeniden eklendi.
 	 	• Windows Düzenleme > ESD to WIM bölümüne "X" geri çıkış tuşu yeniden eklendi.
	• Desktop Runtime indirme linki yenilendi. (5.0.12 > 5.0.13)
	• Windows düzenleme > Windows 11 Edit > Sağ-tık Terminal bölümüne explorer reset komutu eklendi. 
	• Windows / Market Onar kodları düzenlendi.
	• Kapatılan servisler bölümünde değişiklikle yapıldı.
 	 	• Uzak masaüstü ve akış bölümü birleştirildi. İki ayrı bölüm olunca sorunlar yaşanıyordu. 
 	 	• Baskı hizmetlerini aç bölümü eklendi.
	• Güncelleştirme sonrası temizlik bölümünde düzenlemeler yapıldı.
	• All in One Runtimes bölümünde C++ linkleri yenilendi.
	• Microsoft Office bölümünde yaşanan sorundan dolayı Office uygulaması kaldırıldı. 
 	 	• Adobe Reader yazılımı tekrar eklendi.

</details><details><B><summary> Versiyon 1.8   ►  08.01.2022</B></summary>

	• Wifi Crack bölümü eklendi.
 	 	• Bu bölümde sisteme girdiğiniz Wifi liste ve şifrelerini görebilirsiniz.
 	 	• Çalışmasını toolbox'a eklediği için [Archley]'e teşekkür ederim.
	• Simge hatasını düzelt bölümüne yeni parametre eklendi.
	• Explorer Resetten sonra Explorer'ın açılmama hatası giderildi.
	• FAT32 to NTFS bölümü ana ekrandan ayrıldı. Yeni bölümde artık diskleri ve isimlerini görerek rahat bir şekilde işlem yapabilirsiniz.
	• Sistem hakkında bölümünün tüm komutları yenilendi. Eklenenler;
 	 	• Windows 11 beta sürümlerinde Microsoft tarafından wmic uygulaması kaldırılmasından dolayı oluşan hata düzeltildi.
 	 	• Saat dilimi 
 	 	• HDD/SSD disk bilgisi
	• Kullanıcı Hesap Yönetimi bölümünde 7 numaralı bölümün kodları yenilendi.
	• "Çoklu indirme" bölümü "Listeyi Genişlet >>>" olarak değiştirildi. 52 işlem numarası "Z" olarak değiştirildi.
 	 	• Liste genişletildiğinde Bonus bölümünde de programlar göreceksiniz. Bu bölümde zamanla yapılacak eklemeler için boş alanlar bıraktım.
 	 	• Liste genişlet seçildiğinde artık çoklu seçim yapacaksanız. İki işlevi bir arada sundum.
	• Online katılımsız bölümündeki program listesi güncellendi. 
 	 	• Mem Reduct yazılımı eklendi. Sessiz kurulum için Autoit ile script hazırladım.
 	 	• Python / Microsoft Office 2019 / Stellarium / Recuva;
 	 	• AOEMI Partition Assistans / Python / PhyCharm;
 	 	• Visual Studio Code / Github / Git / İnternet Download Manager
 	 	• World Of Tanks / Genshin Impact / Valorant oyunları eklendi.
 	 	• TaskbarX bölümündeki kod hatası giderildi.
	• Signal indirme linki yenilendi. (5.26.1 > 5.27.1)
	• Steam indirme linki yenilendi.
	• Edge indirme linki yenilendi. (v96 > v97)
	• Libre Office indirme linki yenilendi. (7.2.4 > 7.2.5)
	• Krita indirme linki yenilendi. (5.0.0 > 5.0.2)
	• ShareX indirme linki yenilendi. (13.6.1 > 13.7.0)
	• K-Lite indirme linki yenilendi. (16.6.5 > 16.7.0)
	• Hibit Uninstaller indirme linki yenilendi. (2.7.15 > 2.7.35)

</details><details><B><summary> Versiyon 1.7   ►  01.01.2022</B></summary>

	• Toolbox Kullanım.md dosyası hazırlandı. (Toolbox'ın kullanımıyla ilgili tüm detaylar içinde yer almaktadır.)
	• Tekli bilgi mesajları menüden görüntelenecek şekilde düzenlendi.
	• Ana menüdeki geri dönüş sonrası yaşanan sorun düzeltildi.
	• Regedit yükleme bölümüne dosya kontrol sistemi getirildi.
	• Windows Düzenleme > "Setup Düzenleme" bölümündeki kodlar düzenlendi.
	• Windows Düzenleme > "Hızlı başlatma" bölümündeki kod hatası giderildi.
	• Lisans Yönetimi bölümündeki hatalar giderildi.
	• Bazı bölümlerdeki log oluşturamama sorunu giderildi.
	• Windows 10/11 Edit bölümünde bazı bölümlerden geri döndükten sonra işletim sistemi bilgisinin bozulma sorunu giderildi.
	• Windows Düzenleme > WIM Mount, Remount, Unmount, Setup Düzenleme, bölümlerindeki işlemleri Dism ile uygulanacak şekilde düzenlendi. İmagex komutları kaldırıldı.
	• Windows Düzenleme > "WIM Unmount" bölümüne bilgi ekranı eklendi.
	• Windows Düzenleme > AIO Windows Hazırla, ESD to WIM bölümlerinde "X" tuşu ile geri çıkma işlemi iptal edildi. Bazı durumlarda hataya neden oluyordu.
	• Kapatılan Servisler bölümü > Media player yönlendirme hatası giderildi.
	• Notepad++ indirme linki yenilendi. (8.1.9.3 > 8.2)
	• TaskbarX indirme linki yenilendi. (1.7.4.0 > 1.7.6.0)

</details><details><B><summary> Versiyon 1.6   ►  29.12.2021</B></summary>

	• Windows Düzenleme > "Wim /Delete" çoklu seçme özelliği kaldırıldı. (İndex numaraları kaydığı için ilk silme işleminden sonra hatalı işlem yapıyordu)
	• Windows Düzenleme > Yol tanımlama bölümlerinde gereksiz komutlar kaldırıldı.
	• Windows Düzenleme > "AIO Windows Hazırla" çoklu seçme özelliğindeki hata giderildi.
	• Windows Düzenleme > Tüm bölümlerde "X" tuşu geri dönüş tuşu olarak ayarlandı.
	• Windows Düzenleme > "AIO Windows Hazırla" birleştirme bölümündeki eski tema sorunu giderildi.
	• Windows Düzenleme > "Telemetry engelle (Hosts)" bölümündeki yönlendirme hatası giderildi."
	• Sistem Hakkında > Sistem format tarihi eklendi. [Eray Türkay'a verdiği bilgi için teşekkür ederim]
	• Olası sorunlarda hızlı hata tespiti için log sistemi eklendi.
	• İndirme işlemlerinde internet durum kontrolü eklendi.
	• Toolbox.bat içinde yorum satırları arttırıldı. 

</details><details><B><summary> Versiyon 1.5   ►  27.12.2021</B></summary>

	• Windows Düzenleme > ISO hazırlama bölümüne etiket ve ISO isim verme özelliği eklendi.
	• Setup düzenleme bölümünde duraklamaya neden olan komut kaldırıldı.
	• WIM Mount bölümüne boot.wim çıkarma desteği eklendi. 
	• Kullanıcı hesap yönetimi bölümünde iç bölümlere X tuşu menüye dönüş olarak ayarlandı.
	• Sistem hakkında bölümünde Ram kısmına Soket yapısı eklendi. [Eray Türkay'a verdiği bilgi için teşekkür ederim]
	• İndirme işlemlerinde ilerleme çubuğu eklendi. [KaanBeyhan'a (DOGGEST) verdiği bilgi için teşekkür ederim]
	• TaskbarX indirme linki yenilendi. (1.7.3.0 > 1.7.4.0)

</details><details><B><summary> Versiyon 1.4   ►  23.12.2021</B></summary>

	• OgnitorenKs Toolbox Update aracına internet ve toolbox dosya kontrol sistemi getitirildi.
	• Windows edit bölümünde bazı bölümlerde yer alan buglar giderildi.
	• Katılımsız kurulum dosya hazırlama bölümünde düzenlemeler yapıldı. 
 	 	• Online bölümüne internet bağlantı kontrol bölümü eklendi.
	• Windows 10 Edit bölümüne "Eski ve Yeni simgelere geçiş bölümü eklendi"
	• Signal indirme linki yenilendi. (5.26.0 > 5.26.1)
	• Kdenlive indirme linki yenilendi. (21.08.3 > 21.12.0)
	• Krita indirme linki yenilendi. (4.4.8 > 5.0.0)
	• Gimp indirme linki yenilendi. (2.10.28 > 2.10.30)
	• Audacity indirme linki yenilendi. (3.1.2 > 3.1.3)

</details><details><B><summary> Versiyon 1.3   ►  22.12.2021</B></summary>

	• İndirmeye devam et özelliği eklendi.
 	 	• Bu özellik ile indirilmiş olan dosyalar tekrar indirilmeyecek. 
 	 	• Herhangi bir sebepten ötürü Toolbox kapanırsa işlem tekrar edildiğin kaldığı yerden indirmeye devam edecektir.
	• Windows 10-11 Edit bölümleri işletim sistemine göre gösterilecektir. Windows 10'da 11'i | Windows 11'de 10 için ayrılan bölüm görünmeyecektir.
 	 	• Home ve Home Single Language sistemlerde Gpedit.msc aktifleştirmek için ayar eklendi.
	• Terminal bölümündeki yönlendirme hatası giderildi.
	• Tema değiştirildi.
	• Sistem hakkında bölümünde Disk yapısını hatalı gösteren komut hatası giderildi.
	• Sistem - Market onar bölümünde düzenlemeler yapıldı. 
	• Ana ekran bilgi ekranına ve Sistem Hakkında bölümüne derleme numarası dahil edilmiştir. 
 	 	• Derleme numarası (10.0.19043. ► 1348 ◄) Ok işaretleriyle gösterdiğim kısımdır. 
	• Katılımsız güncelleştirme aracının komutlarında düzenleme yapıldı.
	• Cheat Engine / Origin / Chrome bölümündeki kod hatası giderildi.
	• Toolbox içindeki tüm linkler "Ekler" klasöründe Links.bat içinde toplanmıştır.
	• Format Factory uygulaması sessiz kurulum işlemine imkan vermediği için kaldırıldı.
 	 	• Any Video Converter uygulaması eklendi.
	• LightShoot uygulaması kaldırıldı. Offical sitesine Captcha doğrulaması geldiği için indirme yapılamıyor.
	• ShareX yazılımı eklendi. Her açıdan LightShoot uygulamasından çok daha iyi.	
	• Eagle Get uygulaması kaldırıldı. Program yapımcıları resmi siteyi kapatıp. Programı güncellemeyi bıraktılar.
	• OpenShell indirme linki güncellendi.
	• Edge indirme linki güncellendi.
	• ISLC programı eklendi.
	• Everything indirme linki yenilendi. (1.4.1.1009 > 1.4.1.1015)
	• Cheat Engine indirme linki yenilendi. (7.2 > 7.3)
	• Hibit Uninstaller indirme linki yenilendi. (2.7.10 > 2.7.15)
	• K-Lite Codec indirme linki yenilendi. (16.6.0 > 16.6.5)
	• 7 - Zip indirme linki yenilendi. (7.21.3 > 7.21.6)
	• Notepad++ indirme linki yenilendi. (8.1.9.2 > 8.1.9.3)
	• Libre Office indirme linki yenilendi. (7.2.2 > 7.2.4)
	• Signal indirme linki yenilendi. (5.25.0 > 5.26.0)
	• Windows 10 Market yükle bölümündeki kod hatası giderildi.
	• Kapatılan servisleri yönet bölümü eklendi.
	• Adobe Reader yazılımı yerine PDF-XChange Editör yazılımı eklenmiştir. Ücretsiz ve daha faydalı bulduğum için değiştirdim.  
	• Windows Edition bölümü eklendi. İçerisinde;
 	 	• WIM / ESD Okuyucu eklendi 
 	 	• AIO Windows Hazırla eklendi.
 	 	• ISO Hazırla eklendi.
 	 	• ESD to WIM / Çıkart eklendi.
 	 	• WIM /Delete eklendi.
 	 	• WIM [Yükle] eklendi.
 	 	• WIM [Topla] eklendi.
 	 	• Regedit [Yükle] eklendi.
 	 	• Regedit [Topla] eklendi.
 	 	• Dism Update [Online] eklendi.
 	 	• Dism Update [Offline] eklendi.
 	 	• Appx yükleyici [Offline] eklendi.
 	 	• Appx yükleyici [Online] eklendi.
 	 	• Driver Yedekle [Online] eklendi.
 	 	• Driver yükle [Offline] eklendi.
 	 	• Setup Düzenle [Offline] eklendi.
 	 	• Yeni Simgeleri yükle[Offline] eklendi.
 	 	• ISLC Ekle[Offline] eklendi.
 	 	• Masaüstüne dosya ekle[Offline] eklendi.
 	 	• OgnitorenKs.Toolbox ekle[Offline] eklendi.
	• Windows Düzenle bölümüne eklediğim aşağıdaki 2 bölüm ile sisteme katılımsız şekilde Toolbox'taki programlar dahil edilebilecek.
	• Online bölümündeki linkler oto link güncelleme sistemiyle sürekli güncel kalması için düzenleme yapılmıştır. 
	• Katılımsız program ve ayar ekle[Offline] eklendi.
	• Katılımsız program ve ayar ekle[Online] eklendi.

</details><details><B><summary> Versiyon 1.2   ►  03.12.2021</B></summary>

	• "Sahiplik al" ekleme bölümündeki kod hatası giderildi.
	• Hibit Uninstaller indirme linki yenilendi. (2.6.25 > 2.7.10)
	• Signal indirme linki yenilendi. (5.24.0 > 5.25.0)
	• Kdenlive indirme linki yenilendi. (21.08.2 > 21.08.3)
	• K-Lite Codec indirme linki yenilendi. (16.5.3 > 16.6.0)
	• NET Desktop Runtime indirme linki yenilendi. (5.0.11 > 5.0.12)
	• "Kapatılan Servisler Yönetim" bölümünde düzenlemeler yapıldı.
	• Fat32toNTFS bölümü işlemleri ana ekrandan yürütülecek şekilde düzenlendi.
	• Format Factory kurulum hatası giderildi.
	• Katılımsız güncelleştirme sistemi eklenmiştir.
 	 	• OgnitorenKs.Toolbox klasörü içerisinde yer alan Toolbox.Update.bat dosyasını çalıştırarak güncelleme işlemini yapabilirsiniz.

</details><details><B><summary> Versiyon 1.1   ►  26.11.2021</B></summary>

	• Sunduğum diğer sistemlerde kapattığım bazı hizmetlerin yeniden açılması için Windows 10 ve Windows 11 edit bölümlerine eklemeler yaptım.
 	 	• Bu bölüm ilk sürümde yer alan "Laptop hizmetlerini aç" "Yazıcı aktifleştir" bölümlerini de kapsamaktadır.
 	 	• Servisleri toplu olarak açmak yerine ihtiyaç durumuna göre tek tek açılması üzerine düzenledim.
	• Olası ICO sorunu için hazırladığım IcoFix Toolbox'a entegre edildi.  
	• Skype kurulumunda x64 hatası verdiği için kaldırıldı.
 	 	• Skype uygulamasının yerine Zoom uygulaması eklenmiştir. 
	• Blitz uygulamasındaki kurulum hatası giderildi.
	• Signal indirme linki güncellendi.(5.20 ► 5.24)
	• Audacity indirme linki güncellendi. (3.0.5 ► 3.1.2)
	• K-Lite Codec indirme linki güncellendi. (16.5.0 ► 16.5.3)
	• Format Factory indirme linki güncellendi. (5.8.1 ► 5.9.0)
 	 	• Format Factory katılımsız kurulmamaktadır. Kurulum işlemlerinin manuel ilerletilmesi gerekmektedir.
 	 	• Kurulumda dikkat edin farklı programlar kurdurmaya çalışmakta o seçenekleri kabul etmeyin.
	• TaskbarX indirme linki güncllendi. (1.7.2.0 ► 1.7.3.0)
	• SSDFresh uygulaması sistemsel bir arızaya neden olduğu için kaldırıldı
 	 	• Alternatif olarak SSDBooster yazılımı eklendi. Portable bir yazılımdır ve masaüstüne indirilmektedir.
	• Sürüm notları Toolbox içine kısayol olarak eklendi.
 
</details><details><B><summary> Versiyon 1.0   ►  23.11.2021</B></summary>
</details>


<details><B><summary> Versiyon 1.4 ► 28.02.2024</B></summary>

	• OgnitorenKs_Lite kalıbındaki all in one runtimes yüklemeleri varsayılan olarak kapalı unutmuştum. Yüklenecek şekilde düzenlendi.

</details><details><B><summary> Versiyon 1.3 ► 28.02.2024</B></summary>

	• Deli_Petro06_Performance kalıbına sistem değişikliği ve duvar kağıdı değiştirme seçenekleri eklendi.
	• OgnitorenKs_Performance bölümündeki All in one Runtimes ve 7-Zip dışındaki programların yükleme işlemi iptal edildi.
	• 4.2.3 güncellemesi ile eklenen ayarlar kalıplara entegre edildi.

</details><details><B><summary> Versiyon 1.2 ► 27.02.2024</B></summary>

	• OgnitorenKs;
	_	• Lite kalıbı eklendi.
			• Performans kalıptan farklı bazı işlemler yapar. Başlat menüsü ve arama hizmetini siler.
		• Performans ve lite kalıplarına masaüstü arka planını özelleştirmesi için ekleme yapıldı. İşlemler sırasında Github deposundan indirilip uygulanır.
	• Kalıplara yeni ayarlar eklendi. Appx silme bölümündeki tanımlamalar yeniden düzenlendi ve hatalar giderildi.

</details><details><B><summary> Versiyon 1.1 ► 11.01.2024</B></summary>

	• Playbook ve UpdateAfter kalıplarındaki farklılıklar giderildi.

</details><details><B><summary> Versiyon 1.0 ► 10.01.2024</B></summary>

	• Deli_Petro06, OgnitorenKs, Spydea[readyOS] kalıpları güncellendi.

</details>