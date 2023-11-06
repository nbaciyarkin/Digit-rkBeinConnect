# Digit-rkBeinConnect
DigitürkBeinConnect - iOS

Proje 2 farklı şekilde size gönderilmiştir.

<h1>Mail Zip </h1>   
1- mail yoluyla gönderdilen zip dosyası.
Eğer projeyi'yı unzip yaptıktan sonra projeyi ayağa kaldırırken 

"Command PhaseScriptExecution failed with a nonzero exit code" 
Hatası ile karşılaşırsanız
 -
Proje dizinine giderek terminal'de 

pod deintegrate; pod install
-
run ederek hatayı çözebilirsiniz.


<h1>Github Repository</h1>   
2- Bu repository'nin linki paylaşılmıştır.
İlk önce Terminal -> $ Pod dosyaları için pod install  

  Uygulamayı  Ayağa kaldırın ->  Digiturk.xcworkspace 
 -
  # BeinConnect Uygulaması ekran kaydı private olarak  YouTube'a eklenmiştir.
<h2>Video Link</h2>   
   -Link :  https://youtu.be/wHe3ByK8VqE
![beinConnect_Home3]()

 # BeinConnect - SCENES
<h2>Home Screen</h2>
<img src="https://github.com/nbaciyarkin/Digit-rkBeinConnect/assets/60100510/0f8871a1-86f4-4c54-a170-88a1b788bdf6.png" alt="Swagger" width="200" height="400"/>
<img src="https://github.com/nbaciyarkin/Digit-rkBeinConnect/assets/60100510/a7ca538e-59e6-4c5d-9ee3-05657c0534be.png" alt="Swagger" width="200" height="400"/>
<img src="https://github.com/nbaciyarkin/Digit-rkBeinConnect/assets/60100510/06114d63-e19d-44db-9c9b-14e6d93d6c1b.png" alt="Swagger" width="200" height="400"/>

  - UITabelView aşağı doğru scroll edilirken en yukarıda ki view rengini değiştirmektedir.
  - Başlangıçta view'ın arka planı şeffaftır. TabelView scroll.Y değeri (70) ve (180 aralığında arkaplan rengi transparence özelliği 0.5 deperinde siyah olarak belirlenir. Eğer scroll.Y 180 değerinden büyük ise arkaplan rengi siyah olarak belirlenmiştir.

<h2>Genre Detail</h2>
<img src="https://github.com/nbaciyarkin/Digit-rkBeinConnect/assets/60100510/1270c3ba-4185-446f-b4fb-bfb8ef0f6bb4" alt="Swagger" width="200" height="400"/>

<h2>Custom Video Player</h2>
<img src="https://github.com/nbaciyarkin/Digit-rkBeinConnect/assets/60100510/f5856c18-63dd-41d9-b5f2-3beb706487d2.png" alt="Swagger" width="200" height="400"/>

<img src="https://github.com/nbaciyarkin/Digit-rkBeinConnect/assets/60100510/0faaf428-3c62-4330-9282-943eb338cc7a.png" alt="Swagger" width="200" height="400"/>

 -<h2>Package Management</h2> 
  - CocoaPods
   - 3rd Part Libraries:
     - Alamofire -> HTTP isteklerini yönetebilmek adına kullanmayı tercih ediyorumç. Generic olarak rahat metodlar çıkarabildiğim için tercihim Alamofire.
     - SnapKit -> Eğer programattically UI kullanıyorsak Constraintleri verirken default olarak  NSLayoutAnchor'ları kullanabiliriz. Fakat SnapKit kolay kullanımıyla ve okuması daha rahat olduğu için tercih ettiğim bir kütüphanedir.
     - SDWebImage -> Web servislerinden gelen resimlere asenkron şekilde caching işlemi yapabilmek için terchi ettiğim kütüphane.
     - IGListKit -> Bu proje için kullanmadım fakat varlığından haberim olduğunu gösterebilmek için pod olarak eklediğim bu kütüphane arka tarafta modelde değişen herhangi bir değişiklik olduğunu diffing algoritmaları ile kontrol ederek değişiklik olan modelde update işlemi uygulayarak performansı arttırır. Normal yaklaşımda UTtableView ve ya UIcollectionView'a reload atarak tekrar delegate ve dataSource metodlaranı ayağa kaldırarak performansı düşürdüğü durumlar mevcuttur. IGListKit büyük projelerde tercih edilmelidir.
