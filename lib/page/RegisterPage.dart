import 'package:flutter/material.dart';
import 'package:HomePage/page/HomePage.dart';
import 'package:HomePage/page/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isContractAccepted = false;
  bool _KayitOlButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pets, color: Colors.pink),
                Text(
                  'PetGuardian',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                Icon(Icons.pets, color: Colors.pink)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pets, color: Colors.black),
                Text(
                  'BİLGİLERİNİZİ GİRİNİZ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.pets, color: Colors.black),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-posta',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Parola',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
            ),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed:_KayitOlButtonEnabled ?() {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: Text(
                'KAYIT OL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,

                ),
              ),
            ),
            SizedBox( width: 50),
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Checkbox(
                  value: _isContractAccepted,
                  onChanged: (value) {
                    setState(() {
                      _isContractAccepted = value ?? false;
                      _KayitOlButtonEnabled = _isContractAccepted;
                    });
                  },
                ),
                Text('Sözleşmeyi kabul edin'),
                SizedBox(height: 20),

              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
              ),

              child: Text(
                'Giriş Sayfasına Geri Dön',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
      ],
      ),
        ),
       );
  }
}


