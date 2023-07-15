import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ShopPage.dart';
import 'AccountPage.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}
class _RentPageState extends State<RentPage> {

  bool isBarinakSelected = true;
  bool isVeterinerSelected=false;
  bool isBilgiSelected = false;
  List<Map<String, dynamic>> BarinakList = [
    {'Image': 'images/animal_shelter/yedikule.jpg','ad':'\nYedikule Hayvan Barınağı', 'yer': 'İstanbul'},
    {'Image': 'images/animal_shelter/kadıköybarınak.jpg','ad':'\nKadıköy Belediyesi Geçici Hayvan Bakımevi', 'yer': 'İstanbul'},
    {'Image': 'images/animal_shelter/kırık-kuyruk.jpg','ad':'\nKirikkuyruk.com: Sokak Hayvanları Portalı', 'yer': 'İstanbul'},
    {'Image': 'images/animal_shelter/haydos.png','ad':'\nHayvan Dostları Derneği', 'yer': 'Muğla'},
    {'Image': 'images/animal_shelter/şişlirehabilitasyon.jpg','ad':'\nŞişli Belediyesi Hayvan Kısırlaştırma ve Rehabilitasyon Merkezi', 'yer': 'İstanbul'},

  ];
  List<Map<String, dynamic>> VeterinerList = [

    {'Image': 'images/animal_shelter/firuzköy.jpg','ad':' Firuzköy Veteriner Kliniği', 'yer': 'İstanbul/Avcılar','adres':'Hasan Önel Cad. No:57','num':'0212 690 30 84'},
    {'Image': 'images/animal_shelter/greenpet.jpg','ad':' Greenpet Veteriner Kliniği', 'yer': 'İstanbul/Bakırköy','adres':'Halkalı Cad. No:50 Yeşilköy','num':'0212 662 22 92'},
    {'Image': 'images/animal_shelter/vetplus.jpg','ad':' Vet Plus Veteriner Kliniği', 'yer': 'İstanbul/Beşiktaş','adres':'Barboros Bulvarı İ.B.A. Blokları No: 24/1A Balmumcu','num':'0212 216 45 46'},
    {'Image': 'images/animal_shelter/patipata.jpg','ad':' Pati-Pata Veteriner Kliniği', 'yer': 'İstanbul/Beşiktaş','adres':'Etiler, Nispetiye Yıldız Çiçeği','num':'0212 257 00 41'},
    {'Image': 'images/animal_shelter/kanlica.png','ad':' Kanlıca Veteriner Kliniği', 'yer': 'İstanbul/Beykoz','adres':'Kanlıca Mah. Çubuklu Cad. No:28','num':'0216 413 18 82'},
    {'Image': 'images/animal_shelter/animalist.jpg','ad':' Animalist Veteriner Kliniği	', 'yer': 'İstanbul/Ataşehir','adres':'36. Ada Revaklı Çarşı Dükkan No:10	','num':'0216 456 74 52'},
    {'Image': 'images/animal_shelter/dragos.jpg','ad':' Dragos Veteriner Kliniği', 'yer': 'İstanbul/Kartal','adres':'Cevizli Orhantepe Orhangazi No:1','num':'0216 305 60 68'},


  ];
  void _kiralandi() {

    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bakıcı Kiralama İşlemi'),
          content: Text('Kiralama işlemini tamamladınız! \nİlgili kişiler sizinle mail yoluyla iletişim kuracaktır.'),

          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },

              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
  void _bireyselsecimi() {

    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bireysel Evcil Hayvan Bakıcılığı'),
          content: Text('Evcil hayvan bakıcılığı için başvuru bulunmamaktadır.  \nYapılan başvuruların kontrolleri yapıldıktan sonra Bireysel kategorisine eklenecektir.'),

          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },

              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }


  void sendFormData() async {
    const url = 'https://docs.google.com/forms/d/e/1FAIpQLSeoetiYW4oPs4BeMFK347i-6GdioJzmRQBt4sto2ZxRllSKGw/viewform?usp=sf_link';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Google Form bağlantı adresinde hatadan kaynaklı açılamadı: $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pets,
              color: Colors.pink,
            ),
            SizedBox(width: 8),
            Text(
              'PetGuardian',
              style: TextStyle(color: Colors.pink),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.pets,
              color: Colors.pink,
            ),
          ],
        ),


      ),

      drawer: Drawer(
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[

            Container(
              height: 120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home_filled,color: Colors.pinkAccent),
              title: Text('Barınak',style: TextStyle(fontSize: 17,color: Colors.grey )),
              onTap: () {
                setState(() {
                  isBarinakSelected = true;
                  isVeterinerSelected = false;
                  isBilgiSelected = false;


                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person,color: Colors.pinkAccent),
              title: Text('Bireysel',style: TextStyle(fontSize: 17,color: Colors.grey )),
              onTap: () {
                _bireyselsecimi();

              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined,color: Colors.pinkAccent,),
              title: Text('Bakıcı ol',style: TextStyle(fontSize: 17,color: Colors.grey )),
              onTap: () {
                sendFormData();
              },
            ),
            ListTile(
              leading: Icon(Icons.info,color: Colors.pinkAccent),
              title: Text('Bilgi',style: TextStyle(fontSize: 17,color: Colors.grey )),
              onTap: () {
                setState(() {
                  isBilgiSelected = true;
                  isVeterinerSelected = false;
                  isBarinakSelected = false;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.healing,color: Colors.pinkAccent),
              title: Text('Veteriner',style: TextStyle(fontSize: 17,color: Colors.grey )),
              onTap: () {
                setState(() {
                  isVeterinerSelected = true;
                  isBilgiSelected = false;
                  isBarinakSelected = false;

                });
                Navigator.pop(context);
              },

            ),

          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(

              children: [
                if (isBarinakSelected )
                  Column(
                    children: [
                      for (var barinak in BarinakList)
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(barinak['Image'],height:110,width: 100),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Barınak Adı: ${barinak['ad']}'),
                                    Text('Konumu: ${barinak['yer']}'),
                                    SizedBox(width: 20),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_sharp, color: Colors.red),
                                      onPressed: _kiralandi,
                                    ),
                                    SizedBox(height: 5),

                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                if (isVeterinerSelected )
                  Column(
                    children: [
                      for (var veteriner in VeterinerList)
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(veteriner['Image'],height:110,width: 100),

                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Veteriner Adı: ${veteriner['ad']}'),

                                    Text('Konumu: ${veteriner['yer']}'),
                                    Text('Açık Adres: ${veteriner['adres']}'),


                                    SizedBox(width: 8),
                                    Text('Telefon Numarası: ${veteriner['num']}'),
                                    Icon(Icons.call,color: Colors.red),

                                    SizedBox(height: 20,),

                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                if (isBilgiSelected )
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Image.asset('images/animal_shelter/catdog.png',height:320,width: 300),
                      Text('      PetGuardian, hayvanların sağlık ve bakımını takip etmek, sahiplendirme sürecini kolaylaştırmak ve hayvan severlerin ihtiyaçlarını karşılamak için geliştirilen kapsamlı bir uygulamadır. \n Hayvanların benzersiz kimlik numaraları ve profilleri ile birlikte, hayvan barınaklarının ve sahiplenen kişilerin ihtiyaçlarını karşılamak için özel olarak tasarlanmış bir platformdur.'),


                    ],
                  ),

              ],

            ),

          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 8),
                  Text('Ana Sayfa'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 8),
                  Text('Market'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('Hesap'),
                ],
              ),
            ),
          ],
        ),
      ),



    );
  }
}
