import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/ui/rekomtoko.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(onScroll);
    controller = TabController(length: 1, vsync: this);
    super.initState();
    getCredential();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings, color: Colors.white,), onPressed: null),
          Container(
            padding: const EdgeInsets.all(5),
            child: Stack(
                children: <Widget>[IconButton(icon: Icon(Icons.notifications, color: Colors.white,), onPressed: null),
                  Positioned(
                    left: 23,
                    top: 5,
                    child: CircleAvatar(
                      child: Center(child: Text("3", style: TextStyle(fontSize: 14, color: Colors.white),)),
                    backgroundColor: Colors.deepOrange,
                    radius: 8,
                ),
                  )]),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://static-2.gumroad.com/res/gumroad/1654647495106/asset_previews/df232360d4f186e2672d177431a77a68/retina/Animation_207.png"),
              ),
              SizedBox(width: 10,),
              Text(namauser != null ? namauser : "waiting...", style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      
      ),
        body: TabBarView(
            controller: controller,
            children: [
              PageBeli(),
            
            ])

        );
  }
}

class PageBeli extends StatelessWidget {
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
                        builder: (BuildContext context) => new LoginPage()),
                    (Route<dynamic> route) => false);

              },
              ),
            ],
          )
      );}
    return Container(
      color: Colors.grey[200],
      height:  MediaQuery.of(context).size.height,
      child: ListView(
        
        padding: const EdgeInsets.only(top:10),
        children: <Widget>[
          RekomToko(),
          Container(
            color: Colors.grey[200],
              padding: const EdgeInsets.only(top:10),
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
                      title: Text("Tentang Kami"),                 
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
                leading: Icon(Icons.signal_cellular_connected_no_internet_4_bar),
                    ),
                  ),
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
                      onTap: (){
                       _showAlert(context);
                      },
                      title: Column(
                        children: <Widget>[
                          Text("LOGOUT",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
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
              onTap: (){},
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
          Icon(Icons.shop_two, size: 150, color: Colors.cyan,),
          Text("Buat Toko anda sekarang", style: TextStyle(
            fontSize: 15,
            color: Colors.black45,
          ),),
          SizedBox(height: 15,),
          MaterialButton(
            color: Colors.cyan,
              child: Text("Buat Toko", style: TextStyle(color: Colors.white),) ,onPressed: (){})
        ],
      ),
    );
  }
}
