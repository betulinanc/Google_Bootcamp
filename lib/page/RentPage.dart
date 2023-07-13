
import 'package:flutter/material.dart';
import 'package:HomePage/page/HomePage.dart';
import 'package:HomePage/page/ShopPage.dart';
import 'package:HomePage/page/AccountPage.dart';


class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}
class _RentPageState extends State<RentPage> {


  @override
  bool isBireyselSelected = false;
  bool isBarinakSelected = true;
  List<Map<String, dynamic>>  BireyselList = [
    {'Image': 'images/animal_shelter/image3.jpg','ad soyad': '', 'konum': '', 'yaş':''},
    {'Image': 'images/animal_shelter/image1.jpg','ad soyad': '', 'konum': '', 'yaş':''},
    {'Image': 'images/animal_shelter/image2.jpg','ad soyad': '', 'konum': '', 'yaş':''},
    {'Image': 'images/animal_shelter/image4.jpg','ad soyad': '', 'konum': '', 'yaş':''},
  ];
  List<Map<String, dynamic>> BarinakList = [
    {'Image': 'images/animal_shelter/yedikule.jpg','ad':'\nYedikule Hayvan Barınağı', 'yer': 'İstanbul'},
    {'Image': 'images/animal_shelter/kırık-kuyruk.jpg','ad':'\nKirikkuyruk.com: Sokak Hayvanları Portalı', 'yer': 'İstanbul'},
    {'Image': 'images/animal_shelter/haydos.png','ad':'\nHayvan Dostları Derneği', 'yer': 'Muğla'},
    {'Image': 'images/animal_shelter/dohayder.jpg','ad':'\nDOHAYDER İzmir Şopengazi Barınağı', 'yer': 'İzmir'},


  ];
  void _kiralandi() {

    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bakıcı Kiralama İşlemi'),
          content: Text('Kiralama işlemini tamamladınız! \nİlgili kişiler sizinle email yoluyla iletişim kuracaktır.'),

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


  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore;
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(

              children: [
                Row(
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
                SizedBox(height: 20),
                Text(
                  'Bakıcı Kiralama için Seçiniz',
                  style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isBireyselSelected,
                      onChanged: (value) {
                        setState(() {
                          isBireyselSelected = value!;
                          isBarinakSelected = false;
                        });
                      },
                    ),
                    Text('Bireysel'),
                    SizedBox(width: 20),
                    Checkbox(
                      value: isBarinakSelected,
                      onChanged: (value) {
                        setState(() {
                          isBarinakSelected = value!;
                          isBireyselSelected = false;
                        });
                      },
                    ),
                    Text('Barınak'),
                  ],
                ),

                SizedBox(height: 20),
                if (isBireyselSelected )
                  Column(
                    children: [
                      for (var bireysel in BireyselList)
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(bireysel['Image'],height:110,width: 100,),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Adı Soyadı: ${bireysel['ad soyad']}'),
                                    Text('Konum: ${bireysel['konum']}'),
                                    Text('Yaşı: ${bireysel['yaş']}'),
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





