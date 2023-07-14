import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';





class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage> {
  bool _SozlesmeAccepted = false;
  bool _KayitOlButtonEnabled = false;
  bool ButonAccepted = false;

  final formkey = GlobalKey<FormState>();
  final firebaseAuth  = FirebaseAuth.instance;
  late String username;
  late String password;
  late String email;


  void _onaylandi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kişisel Verilerin İşlenmesine İlişkin Aydınlatma Metni'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text('\n    Veri Sorumlusu D-Market Elektronik Hizmetler ve Ticaret Anonim Şirketi (“PetGuardian” veya “Şirket”)'
                    '\n PetGuardian olarak 6698 sayılı Kişisel Verilerin Korunması Kanunu (“KVKK”) ile ilgili mevzuat ve yasal düzenlemelerden kaynaklanan faaliyetlerimiz çerçevesinde kişisel verilerinizin işlenmesi, saklanması ve aktarılmasına ilişkin veri sahibi ilgili kişileri aydınlatmak amacıyla işbu Kişisel Verilerin İşlenmesi Aydınlatma Metni’ni (“Aydınlatma Metni”) hazırladık.'
                    '\n\n  Bunlara ek olarak internet sitemizi, mobil sitemizi ve/veya mobil uygulamamızı ziyaret etmeniz durumunda kullanılan çerez ve SDK’lar hakkında ayrıntılı bilgiler Çerez Politikası’nda yer almaktadır. Bunlar aracılığıyla işlenen kişisel veriler ise bu Aydınlatma Metni’nde açıklanmaktadır.'
                    '\n\n  Aydınlatma Metni, PetGuardian tarafından yayımlandığı tarih itibariyle geçerli olacaktır. PetGuardian, Aydınlatma Metni’nde gerekli olduğu takdirde her zaman değişiklik yapabilir. Yapılacak değişiklikler, Aydınlatma Metni’nin https://www.PetGuardian.com/kisisel-verilerin-korunmasi adresinde yayımlanmasıyla birlikte derhal geçerlilik kazanır.'
                    '\n\n   Kişisel Verilerin Saklanması, Haklarınız ve Başvuru'
                    '\n Saklama ve İmha'
                    '\n Şirketimiz kişisel verileri saklama ve silme işlemleri için bir Saklama ve İmha Politikası oluşturmuştur. Kişisel verilerinize ilişkin saklama ve imha işlemleri bu politika kapsamında gerçekleştirilmektedir. Buna göre KVKK’da veya ilgili kanunlar ile sair ilgili mevzuatta verinin saklanması için bir süre belirlenmişse, söz konusu veri en az bu süre kadar saklanmak zorundadır'
                    '\n\n   Olası bir mahkeme talebinin veya kanunla yetkili kılınmış bir idari merciinin ilgili veriye ilişkin talebinin tarafımıza geç ulaşması veya tarafı olabileceğimiz bir ihtilafın meydana gelmesi gibi ihtimaller gözetilerek, verilerinizin saklanması için mevzuatta öngörülen sürelere 6 ay ila 1 yıl arası bir süre eklenerek verilerin saklama süresi belirlenmekte ve belirlenen sürenin sonunda söz konusu veriler silinmekte, yok edilmekte veya anonimleştirilmektedir.'
                    '\n\n   Mevzuatta işlediğimiz verinin saklanma süresine yönelik bir süre öngörülmemiş ise aramızdaki ilişkinin gereği olarak olası uyuşmazlıklar da göz önüne alınarak hukuki ilişkimizin sona ermesinden itibaren 10 yıllık dava zamanaşımı süresinin geçmesiyle verileriniz herhangi bir talebinize gerek olmadan silinir, yok edilir veya anonim hale getirilir.'
                    '\n\n   Kişisel verilerin işleme şartlarının tamamı ortadan kalkmış ya da tarafımızca beyan edilen veya mevzuat kapsamında belirlenen saklama süresi dolmuş ise verileriniz, ilk periyodik imha tarihinde veya en geç 6 ay içerisinde re’sen silinir, yok edilir veya anonim hale getirilir. Geçerli bir sebep ile verilerinizin silinmesine dair talepte bulunmanız halinde ise verileriniz yasal olarak mümkün olduğu nispette en geç 30 gün içerisinde silinir. Saklama süresi mevzuatta belirlenmiş verilerinizin öngörülen sürelerden önce silinmesini veya imha edilmesini talep etmeniz halinde söz konusu talebiniz gerçekleştirilemeyecektir'
                    '\n\n   Haklarınız'
                    '\n KVKK ve ilgili mevzuat kapsamında kişisel verilerinize ilişkin olarak;'
                    '\n Kişisel verilerinizin işlenip işlenmediğini öğrenme,'
                    '\n Kişisel verileriniz işlenmişse buna ilişkin bilgi talep etme,'
                    '\n Kişisel verilerin işlenme amacını ve bunların amacına uygun kullanılıp kullanılmadığını öğrenme,'
                    '\n Kişisel verilerinizin aktarıldığı üçüncü kişileri bilme,'
                    '\n Kişisel verilerinizin eksik veya yanlış işlenmiş olması halinde bunların düzeltilmesini isteme,'
                    '\n KVKK mevzuatında öngörülen şartlar çerçevesinde kişisel verilerinizin silinmesini veya yok edilmesini isteme,'
                    '\n Eksik veya yanlış verilerin düzeltilmesi ile kişisel verilerinizin silinmesi veya yok edilmesini talep ettiğinizde, bu durumun kişisel verilerinizi aktardığımız üçüncü kişilere bildirilmesini isteme,'
                    '\n İşlenen verilerin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle kişinin kendisi aleyhine bir sonucun ortaya çıkmasına itiraz etme ve'
                    '\n Kişisel verilerin kanuna aykırı olarak işlenmesi sebebiyle zarara uğramanız halinde bu zararın giderilmesini talep etme'
                    ' haklarına sahipsiniz'
                    '\n\n   Başvuru'
                    '\n Kişisel verileriniz ile ilgili başvuru ve taleplerinizi dilerseniz İlgili Kişi Başvuru Formu’nu kullanarak;'
                    '\n Geçerli bir kimlik belgesi ile birlikte Şirketimize bizzat başvurarak,'
                    '\n Şirketimize daha önce bildirilen ve sistemimizde kayıtlı bulunan elektronik posta adresinizden kvk@PetGuardian.com adresimize göndererek, '
                    '\n PetGuardian’ya iletebilirsiniz.'
                    '\n\n   Veri Sorumlusuna Başvuru Usul ve Esasları Hakkında Tebliğ uyarınca ilgili kişilerin bu başvurularında ad – soyad, başvuru yazılı ise imza, T.C. kimlik numarası (başvuruda bulunan kişinin yabancı olması halinde pasaport numarası), tebligata esas yerleşim yeri veya iş yeri adresi, varsa bildirime esas elektronik posta adresi, telefon numarası ve faks numarası ile talep konusuna dair bilgilerin bulunması zorunludur.'
                    '\n\n   Veri sahibi ilgili kişi, yukarıda belirtilen hakları kullanmak için yapacağı ve kullanmayı talep ettiği hakka ilişkin açıklamaları içeren başvuruda talep edilen hususu açık ve anlaşılır şekilde belirtilmelidir. Başvuruya ilişkin bilgi ve belgelerin başvuruya eklenmesi gerekmektedir.'
                    '\n\n   Talep konusunun başvuranın şahsı ile ilgili olması gerekmekle birlikte, başkası adına hareket ediliyor ise başvuruyu yapanın bu konuda özel olarak yetkili olması ve bu yetkinin belgelendirilmesi (özel vekâletname) gerekmektedir. Ayrıca başvurunun kimlik ve adres bilgilerini içermesi ve başvuruya kimliği doğrulayıcı belgelerin eklenmesi gerekmektedir.'
                    '\n\n   Yetkisiz üçüncü kişilerin başkası adına yaptığı talepler değerlendirmeye alınmayacaktır.'
                    '\n\n   Kişisel verilerinize ilişkin hak talepleriniz değerlendirilerek, Şirketimize ulaştığı tarihten itibaren en geç 30 gün içerisinde cevaplanır. Başvurunuzun olumsuz değerlendirilmesi halinde, gerekçeli ret sebepleri başvuruda belirttiğiniz adrese elektronik posta veya posta yolu başta olmak üzere eğer mümkünse talebin yapıldığı usul vasıtasıyla size iletilir.'
                ),

              ],
            ),
          ),

          actions: <Widget>[
            TextButton(
              child: Text(' Okudum, onaylıyorum.'),
              onPressed: () {
                Navigator.of(context).pop();

                setState(() {
                  ButonAccepted = true;
                  _SozlesmeAccepted = ButonAccepted;
                  _KayitOlButtonEnabled = _SozlesmeAccepted;
                });
              },

            ),
          ],

        );
      },

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formkey,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'E-posta boş bırakılamaz.';
                    }
                    return null;
                  },
                  onSaved: (value) {

                    email = value!;

                  },
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kullanıcı adı boş bırakılamaz.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    username=value!;
                  },
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Şifre boş bırakılamaz.';
                    }
                    return null;
                  },
                  onSaved: (value) {

                    password = value!;

                  },
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
                onPressed:_KayitOlButtonEnabled ?() async {
                  if (formkey.currentState!.validate()){
                    formkey.currentState!.save();
                    try{
                      var userKaydet = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);
                      formkey.currentState!.reset();
                      print(userKaydet.user!.uid);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      print('Giriş yapıldı. Kullanıcı adı: $username');
                    }catch(e){
                      print('Kayıt işlemi gerçekleşemedi: $e');
                    }



                  }else{}


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
                    value: _SozlesmeAccepted,
                    onChanged: (value) {
                      setState(() {
                        _SozlesmeAccepted =  false;

                      });
                    },
                  ),
                  TextButton(
                    onPressed: _onaylandi,

                    child: Text('Sözleşmeyi okuyup, Kabul ediniz.'),
                  ),
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
      ),
    );
  }
}


