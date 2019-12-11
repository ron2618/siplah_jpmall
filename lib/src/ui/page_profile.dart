import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/ui/alamatpemesan.dart';
import 'package:siplah_jpmall/src/ui/edit_profilSKLH.dart';
import 'package:siplah_jpmall/src/ui/edit_profile.dart';
import 'package:siplah_jpmall/src/ui/imagecabang.dart';
import 'package:siplah_jpmall/src/ui/rekomtoko.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController controller;
  ScrollController _controller;
  double position = 0;
  String namauser = null;
  String nama = null;
  String level_id = null;
  String foto = null;
  @override
  void initState() {
    getCredential();
    _controller = ScrollController();
    _controller.addListener(onScroll);
    controller = TabController(length: 1, vsync: this);
    super.initState();
  }

  onScroll() {
    setState(() {
      position = _controller.offset;
    });
//    print(position);
  }

  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      namauser = pref.getString("username");
      nama = pref.getString("nama");
      level_id = pref.getString("level_id");
      foto = pref.getString("foto");
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("level id = "+level_id);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(
          //       Icons.settings,
          //       color: Colors.white,
          //     ),
          //     onPressed: () => level_id == '3'
          //         ? Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (BuildContext context) => Editprofile(),
          //             ))
          //         : Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (BuildContext context) => EditprofileSKL(),
          //             ))),
          Container(
            padding: const EdgeInsets.all(5),
            child: Stack(children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: null),
              Positioned(
                left: 23,
                top: 5,
                child: CircleAvatar(
                  child: Center(
                      child: Text(
                    "3",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
                  backgroundColor: Colors.deepOrange,
                  radius: 8,
                ),
              )
            ]),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                child: Center(
                  child: Image.network(
                    foto != null
                        ? foto
                        : ('https://siplah.mascitra.co.id/assets/images/user.ico'),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                nama != null ? nama : "waiting...",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      body:
      ListView == null? "Waiting":
      
       ListView(
         
         //scrollDirection: Axis.vertical,
         children: <Widget>[
          Column(
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
               level_id == '3' ? CabangMitra() : RekomToko(),
                ]),
            ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
             children: <Widget>[
           PageBeli(),
             ]),
               ),
         ]),
         ]),
      //TabBarView(controller: controller, children: <Widget>[
       
         
        
          
      //]),
      drawer: Drawer(
        child: ListView(
         // padding: EdgeInsets.zero,
          children: <Widget>[
            level_id != '3'
                ? Column(children: <Widget>[ 
                    SizedBox(
                      width: 380,
                      
                   
                      child: DrawerHeader(
                         
                        decoration: BoxDecoration(
                        gradient: LinearGradient(
                            // Where the linear gradient begins and ends
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            // Add one stop for each color. Stops should increase from 0 to 1
                            //stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              // Colors are easy thanks to Flutter's Colors class.
                              Colors.deepPurple[800],
                              Colors.pink[700],
                              Colors.yellow[500],
                            ],
                          ),
                           image: new DecorationImage(image: new NetworkImage("http://siplah.jpmall.intern.mascitra.co.id/favicon.png"))
                        ),
                          
                      ),
                    ),
                    ListTile(
                      title: Text('Profil'),
                      onTap: ()async  {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => EditprofileSKL(),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Pesanan'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Alamat Pengiriman'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AlamatPemesan(),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Komplain'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Produk Favorit'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ])
                : Column(children: <Widget>[
                    SizedBox(
                      width: 380,
                      
                      child: DrawerHeader(
                        
                        decoration: BoxDecoration(
                        gradient: LinearGradient(
                            // Where the linear gradient begins and ends
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            // Add one stop for each color. Stops should increase from 0 to 1
                            //stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              // Colors are easy thanks to Flutter's Colors class.
                              Colors.deepPurple[800],
                              Colors.pink[700],
                              Colors.yellow[500],
                            ],
                          ),
                          image: new DecorationImage(image: new NetworkImage("http://siplah.jpmall.intern.mascitra.co.id/favicon.png"))
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Profil'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Editprofile(),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Pesanan'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Cabang Mitra'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Komplain'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Marketing'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Kurir'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ])
          ],
        ),
      ),
    );
  }
}



class PageBeli extends StatelessWidget {
  final List data;
  final List kategori;

  const PageBeli({Key key, this.data, this.kategori}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    
    
   
    
    void _showAlert(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Peringatan"),
                content: Text("Yakin Mau Keluar"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () async {
                      final pref = await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new LoginPage()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ));
    }

    return Container(
      color: Colors.grey[200],
      height: MediaQuery.of(context).size.height,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(top: 10),
        children: <Widget>[
          Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: Colors.grey[200],
                    height: 1,
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("10 Kata Bijak"),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SecondScreen(),
                          )),
                      leading: Icon(Icons.people),
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 1,
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Cara Belanja"),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Pagekedua(),
                          )),
                      leading: Icon(Icons.shopping_basket),
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 1,
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Cara Berjualan Online"),
                      leading: Icon(
                          Icons.signal_cellular_connected_no_internet_4_bar),
                    ),
                  ),

                  //batas bawah

                  Container(
                    color: Colors.grey[200],
                    height: 50,
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Pusat Bantuan"),
                      leading: Icon(Icons.person_pin_circle),
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 1,
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Mitra Sipplah"),
                      leading: Icon(Icons.public),
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 1,
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Syarat Dan Ketentuan"),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Pageketiga(),
                          )),
                      leading: Icon(Icons.book),
                    ),
                  ),

                  Container(
                    color: Colors.grey[200],
                    height: 59,
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        _showAlert(context);
                      },
                      title: Column(
                        children: <Widget>[
                          Text(
                            "LOGOUT",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  _bantuan(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Transaksi",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Pusat Bantuan",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              Text(
                "Lihat solusi terbaik atau hubungi kami",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45),
              ),
            ],
          ),
        )
      ],
    );
  }

  _transaksi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Transaksi",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _listTr.map((f) {
            return InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      f.title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      f.sub,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 4,
        ),
        _daftarTransaksi(context),
      ],
    );
  }

  _daftarTransaksi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Daftar Transaksi",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.shop,
                    size: 50,
                    color: Colors.cyan,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Belanja",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.shop,
                    size: 50,
                    color: Colors.cyan,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Belanja",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.shop,
                    size: 50,
                    color: Colors.cyan,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Belanja",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.shop,
                    size: 50,
                    color: Colors.cyan,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Belanja",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ])
      ],
    );
  }

  _favoriteSaya(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Favorit Saya",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _listFav.map((f) {
            return Container(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    f.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    f.sub,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
//        _raihCashBack(context)
      ],
    );
  }
//  _raihCashBack()
}

class Tr {
  final int index;
  final String title;
  final String sub;

  Tr(this.index, this.title, this.sub);
}

class Fav {
  final int index;
  final String title;
  final String sub;

  Fav(this.index, this.title, this.sub);
}

List<Tr> _listTr = <Tr>[
  Tr(0, "Menunggu Pembayaran", "Semua Transaksi yang belum dibayar"),
  Tr(1, "Ulasan", "Berikan penilaian dan ulasan Produk"),
  Tr(2, "Komplain Sebagain Pembeli", "Lihat Status komplain"),
];
List<Fav> _listFav = <Fav>[
  Fav(0, "Topik Favorit", "Atur Topik favorit anda"),
  Fav(1, "Terakhir Dilihat", "Cek Produk yang dilihat"),
  Fav(2, "Wishlist", "Lihat Produk yang sudah anda wishlist"),
  Fav(3, "Toko Favorit", "Lihat Toko yang sudah anda favoritkan"),
  Fav(4, "Langganan", "Atur dan bayar tagihan dalam satu tempat"),
];

class PageJual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.shop_two,
            size: 150,
            color: Colors.cyan,
          ),
          Text(
            "Buat Toko anda sekarang",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black45,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          MaterialButton(
              color: Colors.cyan,
              child: Text(
                "Buat Toko",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}

class Pagekedua extends StatefulWidget {
  @override
  _Pagekedua createState() => _Pagekedua();
}

class _Pagekedua extends State<Pagekedua> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Cara Menjadi Web Developer",
            style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
      url: "https://siplah.mascitra.co.id/blog/page/2",
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("10 Kata Bijak",
            style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
      url: "https://siplah.mascitra.co.id/blog/page/1",
    );
  }
}

class Pageketiga extends StatefulWidget {
  @override
  _Pageketiga createState() => _Pageketiga();
}

class _Pageketiga extends State<Pageketiga> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Syarat dan Ketentuan",
            style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
      url: "https://siplah.mascitra.co.id/blog/page/2",
    );
  }
}
