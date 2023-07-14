
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Pages/HomePage.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;

  bool gizliPassword = true;

  final formkey = GlobalKey<FormState>();
  final firebaseAuth  = FirebaseAuth.instance;




  void sifremiunuttummesaj() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          content: Text('Tekrar giriş yapabilmek için e-mail adresinizde mail kutunuzu kontrol ediniz.'),

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 55.0, right: 50.0),
        child: Form(
          key: formkey,
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
              TextFormField (
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Email Adresi",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_rounded, color: Colors.grey),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email Adresinizi Giriniz!";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(

                obscureText: gizliPassword,
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
                        gizliPassword = !gizliPassword;
                      });
                    },
                    child: Icon(
                      gizliPassword ? Icons.visibility_off : Icons.visibility,
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
              SizedBox(height: 5),

              Row(
                children: [TextButton(onPressed: sifremiunuttummesaj, child: Text("Şifremi Unuttum",style: TextStyle(color: Colors.red)))],
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
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                      ),
                      child: Text("GİRİŞ YAP"),
                      onPressed: () async {
                        if (formkey.currentState!.validate()){
                          formkey.currentState!.save();
                          try {
                            final userKaydet = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
                            print(userKaydet.user!.email);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          }catch(e){
                            print(e.toString());

                          }
                        }else{}



                      },
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                      ),
                      child: Text("KAYDOL"),
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    ),
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}
