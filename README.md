# Digit-rkBeinConnect
DigitürkBeinConnect - iOS

Proje 2 farklı şekilde size gönderilmiştir.

1- mail yoluyla gönderdilen zip dosyası.
Eğer projeyi'yı unzip yaptıktan sonra projeyi ayağa kaldırırken 

"Command PhaseScriptExecution failed with a nonzero exit code" 
Hatası ile karşılaşırsanız
 -
Proje dizinine giderek terminal'de 

pod deintegrate; pod install
-
run ederek hatayı çözebilirsiniz.



2- Bu repository'nin linki paylaşılmıştır.
İlk önce Terminal -> $ Pod dosyaları için pod install  
 -![beinConnect_Home2])

  Uygulamayı  Ayağa kaldırın ->  Digiturk.xcworkspace 
 -

 # BeinConnect - SCENES

<h2>Home Screen</h2>
 <img src="https://github.com/nbaciyarkin/Digit-rkBeinConnect/assets/60100510/851e260d-8c90-434f-9696-aa389533b43c.png" alt="Swagger" width="200" height="400"/>

  <img src="https://github.com/nbaciyarkin/Digit-rkBeinConnect/assets/60100510/f4133ac2-f35e-4fdd-bc52-dff2cc29171bc.png" alt="Swagger" width="200" height="400"/>

 -<h2>Package Management</h2> 
  - CocoaPods
   - 3rd Part Libraries:
     - Alamofire -> HTTP isteklerini yönetebilmek adına kullanmayı tercih ediyorumç. Generic olarak rahat metodlar çıkarabildiğim için tercihim Alamofire.
     - SnapKit -> Eğer programattically UI kullanıyorsak Constraintleri verirken default olarak  NSLayoutAnchor'ları kullanabiliriz. Fakat SnapKit kolay kullanımıyla ve okuması daha rahat olduğu için tercih ettiğim bir kütüphanedir.
     - SDWebImage -> Web servislerinden gelen resimlere asenkron şekilde caching işlemi yapabilmek için terchi ettiğim kütüphane.
     - IGListKit -> Bu proje için kullanmadım fakat varlığından haberim olduğunu gösterebilmek için pod olarak eklediğim bu kütüphane arka tarafta modelde değişen herhangi bir değişiklik olduğunu diffing algoritmaları ile kontrol ederek değişiklik olan modelde update işlemi uygulayarak performansı arttırır. Normal yaklaşımda UTtableView ve ya UIcollectionView'a reload atarak tekrar delegate ve dataSource metodlaranı ayağa kaldırarak performansı düşürdüğü durumlar mevcuttur. IGListKit büyük projelerde tercih edilmelidir.
