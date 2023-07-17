import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petguardian/LoginPage.dart';
import 'package:petguardian/Pages/AddPetPage.dart';
import 'package:petguardian/Pages/HomePage.dart';
import 'package:petguardian/Pages/ShopPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool _isLoggingOut = false;
  File? _image;
  String? _imageUrl;

  static const _imageKey = 'profil_resmi'; // Key definition

  @override
  void initState() {
    super.initState();
    _profilResminiYukle();
  }

  Future<void> _profilResminiYukle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? resimYolu = prefs.getString(_imageKey);
    if (resimYolu != null) {
      setState(() {
        _image = File(resimYolu);
      });
    }

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userSnapshot.exists) {
        // Check if the 'photoURL' field exists in the document
        Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('photoURL')) {
          String? photoURL = userData['photoURL'];
          if (photoURL != null && photoURL.isNotEmpty) {
            setState(() {
              _imageUrl = photoURL;
            });
          }
        }
      }
    } catch (e) {
      print("Profil resmi yüklenirken hata oluştu: $e");
    }
  }

  Future<void> _pickAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      try {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('profile_images/$uid.jpg');
        await ref.putFile(_image!);

        // Get the URL of the uploaded image
        String downloadURL = await ref.getDownloadURL();

        // Update the 'photoURL' field in Firestore document
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
        await userDocRef.set(
          {'photoURL': downloadURL},
          SetOptions(
              merge: true), // Use merge to update only the 'photoURL' field
        );

        // Save the image path to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(_imageKey, _image!.path);

        // Set the _imageUrl to the updated URL
        setState(() {
          _imageUrl = downloadURL;
        });
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }


  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      // Upload the image to Firebase Storage
      try {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        Reference ref = FirebaseStorage.instance.ref().child(
            'profile_images/$uid.jpg');
        await ref.putFile(_image!);

        // Get the URL of the uploaded image
        String downloadURL = await ref.getDownloadURL();
        setState(() {
          _imageUrl = downloadURL; // Update profile image URL state
        });

        // Update the 'photoURL' field in Firestore document
        DocumentReference userDocRef = FirebaseFirestore.instance.collection(
            'users').doc(uid);
        await userDocRef.set(
            {'photoURL': downloadURL}, SetOptions(merge: true));

        // Save the image path to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(_imageKey, _image!.path);
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }

  void _signOut() async {
    setState(() {
      _isLoggingOut = true;
    });

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Kullanıcının uid değerini sıfırla.
    await prefs.remove('uid');

    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print("Çıkış yaparken hata oluştu: $e");
    }

    setState(() {
      _isLoggingOut = false;
    });
  }

  void _changePassword() async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword("NEW_PASSWORD");
      // Şifre başarıyla değiştirildi, kullanıcıyı bilgilendirin
    } catch (e) {
      print("Şifre değiştirirken hata oluştu: $e");
      // Hata durumunda kullanıcıya bilgi verin
    }
  }

  void _updateEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.updateEmail("NEW_EMAIL");
      // E-posta başarıyla güncellendi, kullanıcıyı bilgilendirin
    } catch (e) {
      print("E-posta güncellenirken hata oluştu: $e");
      // Hata durumunda kullanıcıya bilgi verin
    }
  }

  void _updateUserProfile(String newName, String newPhoneNumber) async {
    try {
      // Firestore'da kullanıcı dökümanına erişin ve bilgileri güncelleyin
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef = FirebaseFirestore.instance.collection(
          'users').doc(uid);

      await userDocRef.update({
        'displayName': newName,
        'phoneNumber': newPhoneNumber,
      });

      // Bilgiler başarıyla güncellendi, kullanıcıyı bilgilendirin
    } catch (e) {
      print("Kullanıcı bilgilerini güncellerken hata oluştu: $e");
      // Hata durumunda kullanıcıya bilgi verin
    }
  }

  void _addFavoritePet(String petName) async {
    try {
      // Firestore'da kullanıcının favori evcil hayvanları koleksiyonuna ekleyin
      String uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference favoritePetsColRef = FirebaseFirestore.instance
          .collection('users').doc(uid).collection('favorite_pets');

      await favoritePetsColRef.add({
        'petName': petName,
      });

      // Evcil hayvan başarıyla favorilere eklendi, kullanıcıyı bilgilendirin
    } catch (e) {
      print("Evcil hayvan favorilere eklenirken hata oluştu: $e");
      // Hata durumunda kullanıcıya bilgi verin
    }
  }

  void _addPet() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPetPage()),
    );
  }

  void _deletePet(String petId) async {
    try {
      // Firestore'da kullanıcının evcil hayvanlarını koleksiyonundan silin
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference petDocRef = FirebaseFirestore.instance.collection(
          'users').doc(uid).collection('pets').doc(petId);

      await petDocRef.delete();

      // Evcil hayvan başarıyla silindi, kullanıcıyı bilgilendirin
    } catch (e) {
      print("Evcil hayvan silinirken hata oluştu: $e");
      // Hata durumunda kullanıcıya bilgi verin
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PetGuardian',
          style: TextStyle(color: Colors.pink),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundImage: _getImageProvider(),
                radius: 50,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: _pickImage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              user?.displayName ?? 'FullName',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              user?.email ?? 'E-posta Adresi',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoggingOut ? null : _signOut,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: _isLoggingOut
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Çıkış Yapılıyor'),
                ],
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 5),
                  Text('Çıkış Yap'),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _changePassword(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Text('Şifreyi Değiştir'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _updateEmail(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Text('E-postayı Güncelle'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  _updateUserProfile('YENI_ADI', 'YENI_TELEFON_NO'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Text('Profil Bilgilerini Güncelle'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _addFavoritePet('FAVORI_EVCI_HAYVAN_ADI'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Text('Favori Evcil Hayvan Ekle'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addPet, // Butona basıldığında AddPetPage sayfasına yönlendirilecek
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Text('Evcil Hayvan Ekle'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _deletePet('SILINECEK_EVCI_HAYVAN_ID'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: Text('Evcil Hayvan Sil'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
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
      ),
    );
  }

  ImageProvider _getImageProvider() {
    if (_image != null) {
      return FileImage(_image!);
    } else if (_imageUrl != null && _imageUrl!.isNotEmpty) {
      return NetworkImage(_imageUrl!);
    } else {
      return NetworkImage(
          user?.photoURL ?? ''); // Default image from Firebase Auth
    }
  }
}
