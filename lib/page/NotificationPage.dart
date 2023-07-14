import 'package:petguardian/Pages//HomePage.dart';
import 'package:flutter/material.dart';



class Notificationpage extends StatefulWidget {
  const Notificationpage({super.key});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {


  void mesajgonderildi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PetGuardian'),
          content: Text('Mesajınız bize ulaşmıştır. En kısa zamanda size geri dönüş sağlanılacaktır.'),

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
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pets,
                      color: Colors.pink,
                      size: 24,
                    ),
                    Text(
                      'PetGuardian',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Icon(
                      Icons.pets,
                      color: Colors.pink,
                      size: 24,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black ),
                    label: Text("Geri Dön",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.mail,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'BİLDİRİMLER',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Container(
                  width: 250,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(

                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Mesajınızı yazın...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: null,
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: mesajgonderildi,
                          child: Text('Gönder'),
                        ),
                      ],
                    ),

                  ),
                ),
                SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
