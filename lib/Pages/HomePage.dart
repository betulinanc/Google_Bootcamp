import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petguardian/Pages/AccountPage.dart';
import 'package:petguardian/Pages/NotificationPage.dart';
import 'package:petguardian/Pages/PetDetailPage.dart';
import 'package:petguardian/Pages/ShopPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ImageInfo> imageList = [];
  List<ImageInfo> filteredList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Firebase'i başlat
    Firebase.initializeApp().then((_) {
      // Firestore'dan verileri çek ve imageList'e ata
      fetchImageDataFromFirestore().then((data) {
        setState(() {
          imageList = data;
          filteredList = List.from(imageList);
        });
      });
    });
    searchController.addListener(filterImages);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterImages() {
    String searchTerm = searchController.text.toLowerCase();
    setState(() {
      filteredList = imageList.where((imageInfo) {
        return imageInfo.title.toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(width: 8),
            Icon(
              Icons.pets,
              color: Colors.pink,
            ),
            SizedBox(width: 12),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.pink,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Arama yapın',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: _buildImageRows(context),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomButton(
                context,
                'Ana Sayfa',
                Icons.home,
                Colors.pink,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              _buildBottomButton(
                context,
                'Market',
                Icons.shopping_cart,
                Colors.pink,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopPage()),
                  );
                },
              ),
              _buildBottomButton(
                context,
                'Hesap',
                Icons.person,
                Colors.pink,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildImageRows(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < filteredList.length; i += 3) {
      if (i + 3 <= filteredList.length) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImageBox(context, filteredList[i]),
              _buildImageBox(context, filteredList[i + 1]),
              _buildImageBox(context, filteredList[i + 2]),
            ],
          ),
        );
      } else {
        List<Widget> rowChildren = [];
        for (int j = i; j < filteredList.length; j++) {
          rowChildren.add(_buildImageBox(context, filteredList[j]));
        }
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowChildren,
          ),
        );
      }
      rows.add(SizedBox(height: 16));
    }
    return rows;
  }

  Widget _buildImageBox(BuildContext context, ImageInfo imageInfo) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Resme tıklandığında yapılacak işlemler
                print('Tapped on image: ${imageInfo.title}');
              },
              child: Container(
                width: double.infinity,
                height: 120,
                child: Image.network(
                  imageInfo.imagePath,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              imageInfo.title,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Bilgi al butonuna tıklandığında yapılacak işlemler
                print('Bilgi Al butonuna tıklandı: ${imageInfo.title}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetDetailPage(
                      title: imageInfo.title,
                    ),
                  ),
                );
              },
              child: Text('Bilgi Al'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(
      BuildContext context,
      String label,
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class ImageInfo {
  final String imagePath;
  final String title;

  ImageInfo(this.imagePath, this.title);
}

Future<List<ImageInfo>> fetchImageDataFromFirestore() async {
  List<ImageInfo> imageData = [];
  try {
    // Firestore'dan 'pets' koleksiyonundaki verileri çek
    var snapshot = await FirebaseFirestore.instance.collection('pets').get();
    for (var doc in snapshot.docs) {
      var data = doc.data();
      String imagePath = data['imagePath'];
      String title = data['title'];
      imageData.add(ImageInfo(imagePath, title));
    }
  } catch (e) {
    print('Resim verileri alınırken hata oluştu: $e');
  }
  return imageData;
}
