import 'package:flutter/material.dart';
import 'SigninPage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isTermsAccepted = false;

  void _toggleTermsAccepted(bool value) {
    setState(() {
      _isTermsAccepted = value;
    });
  }

  void _navigateToTermsPage(BuildContext context) {
    // Kullanıcı Şart ve Koşulları sayfasına yönlendirme işlemleri burada gerçekleştirilebilir.
    // Örneğin:
    // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsPage()));
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
  }

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
                Icon(Icons.pets, color: Colors.pink),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  onChanged: (value) => _toggleTermsAccepted(value!),
                ),
                GestureDetector(
                  onTap: () => _navigateToTermsPage(context),
                  child: Text(
                    'Kullanıcı Şart ve Koşullarını okudum ve onaylıyorum',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToRegister(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                  child: Text(
                    'GERİ DÖN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isTermsAccepted ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                  child: Text(
                    'KAYDOL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
