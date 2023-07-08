import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LoginPage.dart';


class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late String username;
  late String password;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 55.0, right: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pets, color: Colors.black),
                SizedBox(width: 10.0),
                Text(
                  'PetGuardian',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(width: 10.0),
                Icon(Icons.pets, color: Colors.black),
              ],
            ),
            SizedBox(height: 100.0),
            Text(
              'HOŞGELDİNİZ',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Kullanıcı Adı",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person, color: Colors.grey),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Kullanıcı Adını Giriniz!";
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                username = value!;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              obscureText: obscurePassword,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Şifre",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  child: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Şifrenizi Giriniz!";
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                password = value!;
              },
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    child: Text("GİRİŞ YAP"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      },
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    child: Text("KAYDOL"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
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
