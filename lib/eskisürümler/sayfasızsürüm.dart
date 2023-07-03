import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mağaza Uygulaması',
      theme: ThemeData(
        brightness: Brightness.light, // Light theme
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  List<ImageInfo> imageList = [
    ImageInfo('images/image1.jpg', 'JapanseSpani'),
    ImageInfo('images/image2.jpg', 'DOGO'),
    ImageInfo('images/image3.jpg', 'Beyaz'),
    ImageInfo('images/image4.jpg', 'Başlık4'),
    ImageInfo('images/image5.jpg', 'Başlık5'),
    ImageInfo('images/image6.jpg', 'Başlık6'),
    ImageInfo('images/image7.jpg', 'Başlık7'),
    ImageInfo('images/image8.jpg', 'Başlık8'),
    ImageInfo('images/image9.jpg', 'Başlık9'),
    ImageInfo('images/image10.jpg', 'Başlık10'),
    ImageInfo('images/image11.jpg', 'Başlık11'),
    ImageInfo('images/image12.jpg', 'Başlık12'),
  ];

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
                  // Ana Sayfa butonuna tıklandığında yapılacak işlemler
                },
              ),
              _buildBottomButton(
                context,
                'Market',
                Icons.shopping_cart,
                Colors.pink,
                    () {
                  // Market butonuna tıklandığında yapılacak işlemler

                },
              ),
              _buildBottomButton(
                context,
                'Hesap',
                Icons.person,
                Colors.pink,
                    () {
                  // Hesap butonuna tıklandığında yapılacak işlemler

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
    for (int i = 0; i < imageList.length; i += 3) {
      if (i + 3 <= imageList.length) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImageBox(context, imageList[i]),
              _buildImageBox(context, imageList[i + 1]),
              _buildImageBox(context, imageList[i + 2]),
            ],
          ),
        );
      } else {
        List<Widget> rowChildren = [];
        for (int j = i; j < imageList.length; j++) {
          rowChildren.add(_buildImageBox(context, imageList[j]));
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
        padding: EdgeInsets.all(8), // Adjust the spacing as needed
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
                child: Image.asset(
                  imageInfo.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8), // Spacing between image and title
            Text(
              imageInfo.title,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 8), // Spacing between title and button
            ElevatedButton(
              onPressed: () {
                // Bilgi al butonuna tıklandığında yapılacak işlemler
                print('Bilgi Al button pressed for image: ${imageInfo.title}');
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