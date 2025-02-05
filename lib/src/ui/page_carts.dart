import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/ui/pembayaran.dart';


class CartsPage extends StatefulWidget {
  @override
  _CartsPageState createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
int totalharga = 0;


 Future<http.Response> _delete(String idx) async {
    //a=a+id;
    //print(id);
    var url = 'https://siplah.mascitra.co.id/api/sekolah/keranjang/delete';

    Map data = {'user_id': "" + id, 'id': idx};
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
        },
        body: body);
    // print("${response.statusCode}");

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
    }
    return response;
  }
  
       
  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("maaf gagal edit"),
            ));
  }

  void _berhasil(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Data berhasil diubah"),
            ));
  }

   Future<http.Response> qtyjson(String id_produk,String jumlah_produk) async {
    //a=a+id;
    //print(id);
    var url = 'https://siplah.mascitra.co.id/api/sekolah/keranjang/tambah_stok';

   
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
        },
        body: {
          "id" : id_produk,
          "jumlah": jumlah_produk,
        }
        
        );
    // print("${response.statusCode}");

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      getJsonData();
    }
    return response;
  }
  

  var linkimage = "http://cahyamotor.co.id/images/empty-cart-icon.jpg";

  var item = false;
  ScrollController _controllerProduk;
  TextEditingController _qty;
  

  @override
  void initState() {
    _controllerProduk = ScrollController();
    super.initState();
   
    getCredential();
  }
    
  List data;
  List data2;

   Future<String> getJsonData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('https://siplah.mascitra.co.id/api/sekolah/keranjang/isi'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
      },
      body: {
        "user_id": id,
      },
    );
    // print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      data2 = convertDataToJson['Data'][0]['Produk'];
    });

    return "Success";
  }
void _showAlert1(BuildContext context,String idx) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Yakin Mau Menghapus"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("OK"),
                  onPressed:() {
                    Navigator.of(context).pop();
                   _delete(idx);
                  }
                ),
              ],
            ));
  }

    String nama;
  String namauser;
  String level_id;
  String foto;
  String id;
getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      namauser = pref.getString("username");
      nama = pref.getString("nama");
      level_id = pref.getString("level_id");
      foto = pref.getString("foto");
      id = pref.getString('id');
    });
    getJsonData();
  }
   var qtyjumlah = 0;
  
  @override
  Widget build(BuildContext context) {
    //print(data);
         
    return Container(
    
      child: Scaffold(
        
        appBar: AppBar(
          flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.yellow]))),
          actions: <Widget>[
            Center(child: Text("hapus"),),
            SizedBox(width: 10,)
          ],
           automaticallyImplyLeading: false,
          title: Text("Keranjang",style: TextStyle(color: Colors.white),),
          bottom: PreferredSize(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.check_box, color: Colors.white),
                  SizedBox(width: 5.0,),
                  Text("Pilih Semua", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            preferredSize: Size(double.infinity, 50),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black12,
              offset: Offset(0, -3))
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: Main,
                children: <Widget>[
                  Text("Total Harga"),

                  totalharga == 0 ? CircularProgressIndicator():  Text(totalharga.toString(), style: TextStyle(fontSize: 14, color: Colors.cyan),)
                ],
              ),
              GestureDetector(
               onTap: (){
                 Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PembayaranState(),
                            ));
                 
               },
              child:Container(
                
                height: 38,
                width: 100,
                color: Colors.cyan,
                child: Center(
                  child: Text("Beli", style: TextStyle(color: Colors.white),)
                ),
              )),
            ],
          ),
        ),
        body: Container(
          color: Colors.black12,
          child: data != null ?_itemada(context) : Container(),
          // child: ListView(
          //   children: <Widget>[
          //     // item == false
          //     // ?
          //     _itemkosong(context),
          //     // Divider()
          //     // : _itemada(),
          //     // _terakhirdilihat(),
          //     // _rekomendasi()
          //   ],
          // ),
        ),
      ),
    );
  }

  _itemada(BuildContext context) {
   
    return ListView.builder(
      // padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: 1,
      itemBuilder: (context, i) {
        
        final x = data[i]['Produk'];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.0,),
                Row( // toko
                // mainAxisAlignment: MainAxis,
                  children: <Widget>[
                    Icon(Icons.check_box, color: Colors.cyan),
                    SizedBox(width: 10.0,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(x[0]['penjual_nama'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                        SizedBox(height: 3.0,),
                        Text(x[0]['penjual_kabupaten_nama'], style: TextStyle(color: Colors.black26),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Flexible( // produk
                  child: ListView.builder(
                    controller: _controllerProduk,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data2.length,
                    itemBuilder: (context, i) {
                      // final y = x.produk[i];
                      
       
                            final x = data[0]['Produk'];
                      String a = 'aku'; 
                      int totalqty  = int.parse(x[i]['jumlah']);
                      String harga = x[i]['produk_harga'].replaceAll('.', '');
                      var harga2 = int.parse(harga);
                      qtyjumlah = int.parse(x[i]["jumlah"]);
                      int harga3 = harga2 * qtyjumlah;
                        totalharga = totalharga + harga3;
                        
                       _qty = TextEditingController(text: totalqty.toString());
                      return Column(// produk
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row( // title
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.check_box, color: Colors.cyan),
                              Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(x[i]['produk_foto']!=null ? x[i]['produk_foto'][0]['foto']:'https://siplah.mascitra.co.id/assets/images/no-image.png')),
                              Column(
                                // mainAxisAlignment: ,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(width: 250, child: Text(x[i]['produk_nama'], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500,
                                  ),)),
                                  Container(child: Text(x[i]['produk_harga'], style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: Colors.cyan,)))
                                ],
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                      _showAlert1(context,x[i]['id']);
                                    
                                  },
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(//favorite & qty
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 13,
                                        )
                                      ]),
                                  child:
                                      Center(child: Icon(Icons.favorite_border, size: 20,))),
                                      SizedBox(width: 15,),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                        var counteree = int.parse(_qty.text);
                                        int add = counteree + 1;
                                        
                                        
                                       qtyjson(x[i]['id'], add.toString());
                                      },
                                                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all()
                                              ),
                                          child: Center(child: Icon(Icons.add))),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 30,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: _qty,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                       var counteree = int.parse(_qty.text);
                                        int add = counteree - 1;
                                        
                                        
                                       qtyjson(x[i]['id'], add.toString());
                                      },
                                                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all()
                                              ),
                                          child: Center(
                                              child: Icon(Icons.remove))),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text("Tulis Catatan untuk Toko", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.w500),),
                          SizedBox(height: 15,),
                          // _controllerProduk.offset != _controllerProduk.position.maxScrollExtent ?  Container() :   Divider()
                        ],
                      );
                    },
                  ),
                ),
                // _listk.length <= 1 ? Container() : customDivider()
              ],
            ),
          ),
        );
      },
    );
  }

  customDivider(){
    return Container(
      height: 10,
      width: double.infinity,
      color: Colors.black12,
      // child: ,
    );
  }

  _itemkosong(BuildContext context) {
    return Container(
      // color:,
      // height: 200,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(height: 150, width: 230, child: Image.network(linkimage)),
          SizedBox(
            height: 10,
          ),
          Text("Keranjang Belanja Kosong",
              style: TextStyle(color: Colors.black26, fontSize: 13)),
          SizedBox(
            height: 10,
          ),
          // Text("Wujudkan Impian di Wishlist Kamu")
          Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.cyan,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 1))
                ]),
            child: Center(
              child: Text(
                "Belanja Sekarang",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}





