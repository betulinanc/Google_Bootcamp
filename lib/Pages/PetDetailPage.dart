import 'package:flutter/material.dart';

class PetDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;

  PetDetailPage({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Bilgisi'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imagePath,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            // Buraya hayvanın bilgilerini görüntüleyebileceğiniz diğer widgetları ekleyebilirsiniz
            // Örneğin yaş, cinsiyet, tür gibi bilgiler.
          ],
        ),
      ),
    );
  }
}
