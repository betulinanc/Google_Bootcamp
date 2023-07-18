import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;

  PetDetailPage({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('pets').doc(title).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Pet Bilgisi'),
              centerTitle: true,
              backgroundColor: Colors.pink,
              elevation: 0,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.data() == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Pet Bilgisi'),
              centerTitle: true,
              backgroundColor: Colors.pink,
              elevation: 0,
            ),
            body: Center(
              child: Text('Hayvan bilgisi bulunamadı.'),
            ),
          );
        } else {
          var data = snapshot.data!.data()!;
          String age = data['age']?.toString() ?? 'Bilgi yok';
          String gender = data['gender']?.toString() ?? 'Bilgi yok';
          String type = data['type']?.toString() ?? 'Bilgi yok';
          String fullName = data['email']?.toString() ?? 'Bilgi yok';
          String phone = data['phone']?.toString() ?? 'Bilgi yok'; // Telefon numarasını alın

          return Scaffold(
            appBar: AppBar(
              title: Text('Pet Bilgisi'),
              centerTitle: true,
              backgroundColor: Colors.pink,
              elevation: 0,
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.pink[100],
                      ),
                      child: Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    _buildInfoItem('Yaş', age),
                    _buildInfoItem('Cinsiyet', gender),
                    _buildInfoItem('Tür', type),
                    _buildInfoItem('Hayvan Sahibi', fullName), // Telefon numarasını göster
                    _buildInfoItem('Telefon Numarası', phone), // Telefon numarasını göster

                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => _callPetOwner(context, phone), // Telefon numarasını ara
                      icon: Icon(Icons.call),
                      label: Text('Ara'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label + ':',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Telefon numarasını arayan fonksiyon
  void _callPetOwner(BuildContext context, String phone) async {
    String url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Telefon uygulamasını başlatma hatası
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Telefon uygulamasını başlatmak için uygun bir uygulama bulunamadı.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }
}
