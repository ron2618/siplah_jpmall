import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/kabupaten_bloc.dart';
import 'package:siplah_jpmall/src/bloc/kecamatan_bloc.dart';
import 'package:siplah_jpmall/src/bloc/provinsi_bloc.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/kabupaten_model.dart';
import 'package:siplah_jpmall/src/models/kecamatan_model.dart';
import 'package:siplah_jpmall/src/models/product_model.dart';
import 'package:siplah_jpmall/src/models/provinsi_model.dart';
import 'dart:async';
import 'package:siplah_jpmall/src/ui/mainpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/ui/page_home.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

final username = TextEditingController();
final password = TextEditingController();
SharedPreferences sharedPreferences;

class _WelcomePageState extends State<WelcomePage> {
  var token;
  PageController _pageController;
  bool lastPage = false;
  int initialPage = 0;
  String usernama = null;

  String foto, npsn, nama, email, alamat, kodepos, telepon;

  final page = <ListPage>[
    ListPage(0, PagePertama()),
    ListPage(1, PageKedua()),
    ListPage(2, PageKetiga()),
  ];

  Future<http.Response> postRequest() async {
    var url = 'http://siplah.mascitra.co.id/api/api/get_token';

    Map data = {'app': 'siplah_jpmall.id'};
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    // print("${response.statusCode}");

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    token = map["Data"][0]["api_token"];

    return response;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
    postRequest();
    getCredential();
  }

  getCredential() async {
    //print(username.text);
    final pref = await SharedPreferences.getInstance();
    setState(() {
      usernama = pref.getString("username");
      if (usernama != null) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => new MainPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: initialPage == page.length - 1
          ? Container(
              height: 0.0,
            )
          : Container(
              height: 58,
              child: Stack(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Color(0xFF6BB8E3),
                    actions: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease);
                        },
                        child: lastPage == true
                            ? Text("Register",
                                style: TextStyle(color: Colors.white))
                            : Text("Next",
                                style: TextStyle(color: Colors.white)),
                      )
                    ],
                    title: lastPage == true
                        ? Container()
                        : MaterialButton(
                            child: Text(
                              "Skip",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _pageController.jumpToPage(2);
                            },
                          ),
                  ),
                  _dot(context)
                ],
              ),
            ),
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (i) {
            setState(() {
              initialPage = i;
            });
          },
          pageSnapping: true,
          children: page.map((ListPage page) {
            return page.widget;
          }).toList()),
    );
  }

  _dot(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: page.map((ListPage page) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: page.index == initialPage ? Colors.red : Colors.grey,
                  shape: BoxShape.circle),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ListPage {
  final int index;
  final Widget widget;

  ListPage(this.index, this.widget);
}

class PagePertama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF6BB8E3),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "ALAT",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Tulis, Peraga &\nPraktik",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Container(
                    width: 230,
                    child: Text(
                      "Lengkap dan Dengan Kualitas Yang Baik",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 3,
              right: 10,
              child: Container(
                child: Image.asset(
                  'src/image/buku.png',
                  scale: 6,
                ),
              ),
            )
          ],
        ));
  }
}

class PageKedua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF6BB8E3),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'src/image/buku_2.png',
                          scale: 5,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "BUKU",
                        style: TextStyle(
                            fontSize: 54,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Adalah\n            Jembatan",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "ILMU",
                        style: TextStyle(
                            fontSize: 54,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}

class PageKetiga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6BB8E3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage('src/image/project.png')),
          MaterialButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage())),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Start Now"),
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)))
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final List npsn;
  final List levelid;
  final List nama;
  final List foto;
  final List kabupaten;

  const LoginPage({Key key, this.npsn, this.levelid, this.nama, this.foto, this.kabupaten}) : super(key: key);
 
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String levelid, npsn,nama,foto,kabupaten;

  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    void savedata() async {
      sharedPreferences = await SharedPreferences.getInstance();

      setState(() {
        //  sharedPreferences.setString("foto",widget.data1[0]["foto"]);
        //  sharedPreferences.setString("npsn",widget.data1[0]["npsn"]);
        //  sharedPreferences.setString("nama",widget.data1[0]["nama"]);
        //  sharedPreferences.setString("email",widget.data1[0]["email"]);
        //  sharedPreferences.setString("alamat",widget.data1[0]["alamat"]);
        //  sharedPreferences.setString("kodepos",widget.data1[0]["kodepos"]);
        sharedPreferences.setString("foto", foto);
        sharedPreferences.setString("nama", nama);
        sharedPreferences.setString("id", npsn);
        sharedPreferences.setString("level_id", levelid);
        sharedPreferences.setString("username", username.text);
        sharedPreferences.setString('kabupaten_id', kabupaten);
        sharedPreferences.commit();

        //print("npsn berhasil = "+npsn);
        //print("level_id= "+levelid);
      });
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (BuildContext context) => new MainPage()),
          (Route<dynamic> route) => false);
    }

    void _showAlert(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Peringatan"),
                content: Text("Password atau Email Kamu Salah"),
              ));
    }

    Future<http.Response> login_api() async {
      var url = 'http://siplah.mascitra.co.id/api/user/login';

      Map data = {'email': username.text, 'password': password.text};
      
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "API-App": "siplah_jpmall.id",
            "Api-Key": "4P1_7Pm411_51p114h",
            "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
          },
          body: body);

      // var response1 = await http.post(
      //       //Encode the url
      //       Uri.encodeFull('http://siplah.mascitra.co.id/api/user/login'),
      //       headers: {"Content-Type": "application/x-www-form-urlencoded","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":$Token({this.apitoken})fd43a64c539788b356da4910e5e95fb573"},
      //       body:{
      //         "email":username.text,
      //         "password":password.text,
      //       }
      //       );

      //print("${response.statusCode}");

      Map<String, dynamic> map = jsonDecode(response.body);

      //var convertDataToJson = json.decode(response.body);
      foto = map['Data'][0]['foto'];
      nama = map['Data'][0]['nama'];
      npsn = map['Data'][0]['id'];
      levelid = map['Data'][0]['level_id'];
      kabupaten=map['Data'][0]['kecamatan_id'];
      //  nama = convertDataToJson["nama"];
      //  email = convertDataToJson["email"];
      //  alamat = convertDataToJson["alamat"];
      //  kodepos = convertDataToJson["kodepos"];
      //  telepon = convertDataToJson["telepon"];
//print("npsn = "+npsn);

      if (map["Error"] == true || map["Error"] == "true") {
        _showAlert(context);
      } else {
        savedata();
      }
      return response;
    }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF6BB8E3),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: MediaQuery.of(context).size.width / 5,
                        right: 10,
                        child: Container(
                          child: Image.asset(
                            'src/image/buku.png',
                            scale: 6,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 3),
                    width: MediaQuery.of(context).size.width - 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                               Container(
                                height: 80,
                                width: 20,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                        image:
                                            AssetImage("src/image/Icons_SIPLAH_JPSTORE_2020.png"),
                                        fit: BoxFit.fill)),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                
                                  TextSpan(
                                      text:
                                          "\nMasukkan Akun Kamu Disini",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12))
                                ]),
                              ), //text logo
                              SizedBox(height: 15),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)),
                                child: Center(
                                  child: TextField(
                                    controller: username,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(5.0),
                                        border: InputBorder.none,
                                        hintText: "Username"),
                                  ),
                                ),
                              ), //user
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)),
                                child: Center(
                                  child: TextField(
                                      controller: password,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(5.0),
                                          border: InputBorder.none,
                                          hintText: "Password"),
                                      obscureText: _obscureText),
                                ),
                              ),
//                              new FlatButton(
//                                  onPressed: _toggle,
//                                  child: new Text(_obscureText ? "Show" : "Hide")),
                              SizedBox(height: 10),
                              MaterialButton(
                                onPressed: () {
                                  if(username.text==""&&password.text==""){
                                    _showAlert(context);
                                  }else{
                                  login_api();
                                  }
                                },
                                color: Color(0xFF3FCB9B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Login",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ), //Login
//                        SizedBox(height:),
                              
                              SizedBox(height: 10),
                              Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      child: Divider(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                    Text("atau"),
                                    SizedBox(width: 5.0),
                                    Container(
                                      width: 50,
                                      child: Divider(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ), //logo atau
                              SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black87),
                                    children: [
                                      TextSpan(text: "Belum memiliki akun? "),
                                      TextSpan(
                                          text: "Daftar disini.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Register()))),
                                    ]),
                              ) //logo daftar disini
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                       //Button Login Google
                         //Button Login facebook
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  var katPel = ['1', '2'];
  var codetlp = ['+62', '+81'];
  final nama = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final konfirmasi = TextEditingController();
  final telp = TextEditingController();
  String slctdKatPel, code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF6BB8E3),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Container(
                                height: 80,
                              width: 300,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                        image:
                                            AssetImage("src/image/Icons_SIPLAH_JPSTORE_2020.png"),
                                        fit: BoxFit.fill)),
                              ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Daftarkan Akunmu Disini",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTile(
                    "Kategori Pelanggan",
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          value: slctdKatPel,
                          items: List.generate(
                              katPel.length,
                              (i) => DropdownMenuItem<String>(
                                    child: Text(katPel[i]=='1'?"Berbadan Hukum":"Perseorangan"),
                                    value: katPel[i],
                                  )),
                          onChanged: (item) {
                            setState(() {
                              slctdKatPel = item;
                            });
                          }),
                    ),
                  ),
                  CustomTile(
                    "Nama",
                    child: TextField(
                      controller: nama,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  CustomTile(
                    "Email",
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  CustomTile(
                    "Password",
                    child: TextField(
                      obscureText: _obscureText,
                      controller: password,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  CustomTile(
                    "Konfirmasi Password",
                    child: TextField(
                      obscureText: _obscureText,
                      controller: konfirmasi,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomTile(
                    "Telp",
                    style: 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Colors.black54))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                isExpanded: true,
                                value: code,
                                items: List.generate(
                                    codetlp.length,
                                    (f) => DropdownMenuItem(
                                        child: Text(codetlp[f]))),
                                onChanged: (item) {
                                  setState(() {
                                    code = item;
                                  });
                                }),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 200,
                          child: TextField(
                            controller: telp,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5.0),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Register2(
                                  nama: nama.text,
                                  email: email.text,
                                  konfirmasi: konfirmasi.text,
                                  password: password.text,
                                  telp: telp.text,
                                  ketpel :slctdKatPel
                                )),
                        (_) => false),
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final Widget child;
  final int style; // 1 normal, 2 telp
  final bool enable;

  const CustomTile(this.title,
      {Key key, this.child, this.style = 1, this.enable = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (style) {
      case 1:
        return Container(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 50,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: enable == true ? Colors.white : Colors.grey,
                    border: Border.all(color: Colors.black54, width: 2.0)),
                child: child,
              )
            ],
          ),
        );
        break;
      case 2:
        return Container(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 3.0,
              ),
              Container(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                height: 50,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: enable == true ? Colors.white : Colors.grey,
                    border: Border.all(color: Colors.black54, width: 2.0)),
                child: child,
              ),
            ],
          ),
        );
        break;
      default:
    }
  }
}

class Register2 extends StatefulWidget {
  final String nama;
  final String email;
  final String password;
  final String konfirmasi;
  final String telp;
  final String ketpel;

  const Register2({Key key, this.nama, this.email, this.password, this.konfirmasi, this.telp, this.ketpel}) : super(key: key);

  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  var placeholder = ['Loading...', 'Loading...', 'Loading...'];
  String prop, kab, kec;
  final alamat = TextEditingController();
  final kodepos = TextEditingController();
  @override
  void initState() {
    super.initState();
    provinceBloc.provinceFetchAll();
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("maaf gagal mendaftar"),
            ));
  }

  void _berhasil(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Password atau Email Kamu Salah"),
            ));
  }

  Future<http.Response> daftar_api() async {
    var url = 'http://siplah.mascitra.co.id/api/user/daftar';

    Map data = {
      'nama': widget.nama,
      'email': widget.email,
      'password': widget.password,
      'password_konfirmasi': widget.konfirmasi,
      'provinsi_id': prop,
      'kabupaten_id': kab,
      'kecamatan_id': kec,
      'alamat': alamat.text,
      'kode_pos': kodepos.text,
      'telepon': widget.telp,
      'kategori_pelanggan': 3,
      'type': widget.ketpel
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: body);
    // print("${response.statusCode}");

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Color(0xFF6BB8E3),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Register SIPLAH",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTile(
                        "Provinsi",
                        child: StreamBuilder<Province>(
                            stream: provinceBloc.allProvince,
                            builder: (context, snapshot) {
                              return DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                value: prop,
                                isExpanded: true,
                                items: List.generate(
                                    snapshot.hasData
                                        ? snapshot.data.data.length
                                        : placeholder.length,
                                    (i) => DropdownMenuItem(
                                          child: Text(snapshot.hasData
                                              ? snapshot.data.data[i].nama
                                              : placeholder[i]),
                                          value: snapshot.hasData
                                              ? snapshot.data.data[i].id
                                              : placeholder[i],
                                        )),
                                onChanged: (item) {
                                  setState(() {
                                    if (item == null) {
                                    } else {
                                      prop = item;
                                    }
                                  });
                                  kabupatenBloc.fetchKabupaten(prop);
                                },
                              ));
                            }),
                      ),
                      CustomTile(
                        "Kabupaten/Kota",
                        child: StreamBuilder<Kabupaten>(
                            stream: kabupatenBloc.allKabupaten,
                            builder: (context, snapshot) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: kab,
                                  isExpanded: true,
                                  items: List.generate(
                                      snapshot.hasData
                                          ? snapshot.data.data.length
                                          : placeholder.length,
                                      (i) => DropdownMenuItem(
                                            child: Text(snapshot.hasData
                                                ? snapshot.data.data[i].nama
                                                : placeholder[i]),
                                            value: snapshot.hasData
                                                ? snapshot.data.data[i].id
                                                : placeholder[i],
                                          )),
                                  onChanged: (item) {
                                    setState(() {
                                      kab = item;
                                    });
                                    kecamatanBloc.fetchKecamatan(kab);
                                  },
                                ),
                              );
                            }),
                      ),
                      CustomTile(
                        "Kecamatan",
                        child: StreamBuilder<Kecamatan>(
                            stream: kecamatanBloc.allKecamatan,
                            builder: (context, snapshot) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: kec,
                                  isExpanded: true,
                                  items: List.generate(
                                      snapshot.hasData
                                          ? snapshot.data.data.length
                                          : placeholder.length,
                                      (i) => DropdownMenuItem(
                                            child: Text(snapshot.hasData
                                                ? snapshot.data.data[i].nama
                                                : placeholder[i]),
                                            value: snapshot.hasData
                                                ? snapshot.data.data[i].id
                                                : placeholder[i],
                                          )),
                                  onChanged: (item) {
                                    setState(() {
                                      kec = item;
                                    });
                                  },
                                ),
                              );
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Alamat Lengkap",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
//                          height: 50,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black54, width: 2.0)),
                              child: TextField(
                                controller: alamat,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomTile(
                        "Kode Pos",
                        style: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          child: TextField(
                            controller: kodepos,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Text(
                            "1",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 1,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black12,
                          child: Text(
                            "2",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                            (_) => false),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          daftar_api();
                        },
                        child: Text(
                          "Selesai",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text("Apakah Anda ingin membatalkan Registrasi ?"),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No"),
                ),
                MaterialButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (_) => false),
                  child: Text("Yes"),
                )
              ],
            ));
  }
}

class Data {
  final String api_token;

  Data({this.api_token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return new Data(
      api_token: json['api_token'],
    );
  }
}

class Par {
  final String api_token;

  Par({this.api_token});

  factory Par.fromJson(Map<String, dynamic> json) {
    return new Par(
      api_token: json['api_token'],
    );
  }
}
