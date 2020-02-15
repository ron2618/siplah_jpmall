import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/alamatpemesan.dart';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/ui/kurir.dart';
import 'package:siplah_jpmall/src/ui/marketing.dart';
import 'package:siplah_jpmall/src/ui/page_home.dart';
import 'package:siplah_jpmall/src/ui/pesanan.dart';

import 'mainpage.dart';
import 'metodebayar.dart';

class PembayaranState extends StatefulWidget {
  final String imagebank;
  final String datatype;
  final String databank;
  final int totalharga;
  final String namamar;
  final String imagekurir;
  final int cost;
  final String idmar;
  final String ketkur;
  final String namakur;
  final int idtrans;
  final int trans;
   final String service;
  final String deskkur;

  const PembayaranState({Key key, this.imagebank, this.datatype, this.databank, this.totalharga, this.namamar, this.imagekurir, this.cost, this.idmar, this.ketkur, this.namakur, this.idtrans, this.trans, this.service, this.deskkur}) : super(key: key);
 
  
  
  
  
  @override
  _PembayaranState createState() => _PembayaranState();
}

class _PembayaranState extends State<PembayaranState> {

  Future<http.Response> bayarapi(int idtr,String gettoken) async {
    var url = 'http://siplah.mascitra.co.id/api/sekolah/pembayaran/bayar';
    Map kurir ={
      'mitra_id':mitra,
      'kurir':""+widget.ketkur,
      'kurir_id':""+widget.namakur,
      "kurir_service":widget.service,
      "kurir_service_deskripsi":widget.deskkur,
      'ongkir':widget.cost
    };
    Map data = {
      'transaksi_id': idtr,
      'payment': {
      'type': ""+widget.datatype,
      'bank': ""+widget.databank,
      },
      'detail': {
      'total_ongkir': widget.cost,
      'sub_total': widget.totalharga==null?hargasub:widget.totalharga,
      'user_id': id,
      'token_id':""+ gettoken,
      },
      'marketing': widget.idmar,
      'kurir': kurir,
       
    };
    Map pay={
      'payment' : data
    };
    //print(_imageFile);
    //encode Map to JSON
    var body = json.encode(pay);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: body);
    // print("${response.statusCode}");

    //print("${response.body}");
    print(pay);
    Map<String, dynamic> map = jsonDecode(response.body);
    print(kurir);
    print(map);
    print(map['pesan_usr']);
    if (map["Error"] == true || map["Error"] == "true") {
     print("Jadi Draft");
    } else {
      _berhasil(context);
     print(pay);
      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PesananState(),
                            ));
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
              content: Text("Data berhasil dibeli"),
            ));
  }
  
  String getto;
 Future<String> getTokenid() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/midtrans/api/token'),
      // headers: {
      //   "Content-Type": "application/x-www-form-urlencoded",
      //   "API-App": "siplah_jpmall.id",
      //   "Api-Key": "4P1_7Pm411_51p114h",
      //   "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      // },
      // body: {
      //   'asal': kabupaten,
      //   'tujuan': tujuan,
      //   'berat': "100",
      //   'kurir': 'jne',
      // },
    );
     //print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      // var convertDataToJson = json.decode(response.body);
      // datajne = convertDataToJson['results'];
       Map<String, dynamic> map = json.decode(response.body);
       getto=map['token_id'];
    });

    return "Success";
  }

  List datajne;
  Future<String> getKurir_Jne() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/rajaongkir/ongkir/kurir'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        'asal': kabupaten,
        'tujuan': tujuan,
        'berat': "100",
        'kurir': 'jne',
      },
    );
    // print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datajne = convertDataToJson['results'];
    });

    return "Success";
  }

  String penjual = null;
  String tujuan = null;
  String nama;
  String namauser;
  String level_id;
  String foto;
  String kabupaten;
  String cihuy;
  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      namauser = pref.getString("username");
      nama = pref.getString("nama");
      level_id = pref.getString("level_id");
      foto = pref.getString("foto");
      id = pref.getString('id');
      
         getCartsData();
       getAlamatData();
    getTokenid();
    
    });
  }

  ScrollController _controllerProduk;
  @override
  void initState() {
    _controllerProduk = ScrollController();
    super.initState();
    getCredential();
   
  }
// List datatrans;
//   int idtrans;
//     Future<http.Response> daftartransaksi(keranjang) async {
//     var response = await http.post(
//       //Encode the url
//       Uri.encodeFull('http://siplah.mascitra.co.id/api/sekolah/pembayaran/tambah'),
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded",
//         "API-App": "siplah_jpmall.id",
//         "Api-Key": "4P1_7Pm411_51p114h",
//         "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
//       },
//       body: {
//         "user_id": id,
//         "keranjang_id":keranjang
//       },
//     );
//     // print("${response.statusCode}");

//     //print("${response.body}");
//     Map<String, dynamic> map = jsonDecode(response.body);
//     //print(map['Data']['transaksi_id']);
//     if (map["Error"] == true || map["Error"] == "true") {
//       _showAlert(context);
//     } else {
//         setState(() {
//           Map<String, dynamic> map1 = jsonDecode(response.body);
//      int payment_code =map1['Data']['transaksi_id'];
//       idtrans=payment_code;
       
//  idtrans==null?print(idtrans):
//               bayarapi(idtrans,getto);
     

     
//       });
//     }
//     return response;
//   }
  String keranjang;
  String id;
  List datax, data2;
  String mitra;
  int berat;
  String hargasub;
  Future<String> getCartsData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/sekolah/pembayaran/tampil'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        "transaksi_id":  widget.idtrans.toString()!=null?widget.idtrans.toString():widget.trans.toString()!=null?widget.trans.toString():widget.idtrans.toString()
      },
    );
     //print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datax = convertDataToJson['Data'];
     tujuan = datax[0]['tujuan_kecamatan_id'];
    berat = datax[0]['total_berat'];
    mitra = datax[0]['id'];
    hargasub = datax[0]['sub_total_produk'];
    kabupaten =datax[0]['kecamatan_id'];
   print(tujuan);
   print("ner="+berat.toString());
    });
    
    keranjang = data2[0]['id'];
    
  
   
    return "Success";
  }

  List data;
  Future<String> getAlamatData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/alamat_pengiriman/list'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + id,
          //"id": "" + nama
        });
    //print(response.body);`
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    
    print(kabupaten.toString()+" 312 "+tujuan.toString());
    print("los="+widget.idtrans.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed:(){
           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MainPage(),
                            ));
        } ,),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: new Text(
          "Pembayaran",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AlamatPemesan(),
                    ));
              },
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: data == null
                      ? Column(
                children: <Widget>[Center(child: CircularProgressIndicator())])
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: <Widget>[
                                
                                data[i]['is_utama'] == '2'
                                
                                    ? Card()
                                    : Container(
                                        child: Column(
                                          children: <Widget>[
                                             Container(
                                      color: Colors.white,
                                      child: ListTile(
                                        leading: Icon(Icons.home,color:Colors.orange,),
                                        title: Text('Alamat Pengiriman'),
                                      ),
                                    ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(children: <Widget>[
                                         
                                              Container(
                                                height: 2,
                                                color: Colors.grey,
                                              ),
                                       
                                              
                                           
                                              Row(
                                                children: <Widget>[
                                                  Text(data[i]['nama']),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(data[i]['penerima_nama']),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(data[i]['penerima_no_hp']),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                          width: MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                            70,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Text(data[i]['alamat']),
                                                                Text(data[i]['kabupaten_nama']),
                                                                 Text(data[i]['provinsi_nama']),
                                                            ],
                                                          )),
                                                          Container(
                                                    child: IconButton(
                                                      onPressed: (){},
                                                      icon: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.blue,
                                                       
                                                      ),
                                                    ),
                                                  )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                             
                                              Row(
                                                children: <Widget>[
                                                  Text(data[i]['kode_pos']),
                                                ],
                                              ),
                                       
                                      ]),
                                            ),
                                          ],
                                        )),
                              ],
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
         
          SizedBox(
            height: 5,
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 2,
              color: Colors.grey,
            ),
          ),
          
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MarketingPem(
                        idmar:widget.idmar,
                        totalharga: widget.totalharga,
                        imagebank: widget.imagebank,
                        imagekurir: widget.imagekurir,
                        namamar: widget.namamar,
                        databank: widget.databank,
                        datatype: widget.datatype,
                        cost: widget.cost,
                        penjual: penjual,
                        ketkur:widget.ketkur,
                        namakur:widget.namakur,
                        idtrans:widget.idtrans==null?widget.trans:widget.idtrans,
                            service:widget.service,
                            deskkur:widget.deskkur),
                  ));
            },
            child: 
            
            Container(
              height: 70,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "  Pilih Marketing",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  widget.namamar == null
                      ? Container(
                          width: 100,
                          height: 50,
                          
                        )
                      : Container(
                          width: 100,
                          height: 50,
                          child: Text(widget.namamar),
                        ),
                  
                  Container(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                    ),

                  ),
                  Container(
                      width: 22,
                  ),
                ],
              ),
            ),
          ),

          Container(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Kurir(
                            mitra:mitra,
                            berat:berat,
                              kabu: kabupaten,
                              tuju: tujuan,
                              totalharga: widget.totalharga,
                              imagebank: widget.imagebank,
                              imagekurir: widget.imagekurir,
                              namamar: widget.namamar,
                              databank: widget.databank,
                              datatype: widget.datatype,
                              cost: widget.cost,
                              idmar:widget.idmar,
                              ketkur:widget.ketkur,
                              idtrans: widget.idtrans==null?widget.trans:widget.idtrans,
                                  service:widget.service,
                            deskkur:widget.deskkur),
                        ));
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 20,
                        ),
                        Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width:  MediaQuery.of(context).size.width/1.15,
                              color: Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.payment),
                                title: Text('Kurir'),
                              ),
                            ),
                            
                                      Container(
                                        color: Colors.white,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              )
                          ],
                        ),
                        Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        Container(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
                            widget.imagekurir == null
                                    ? Container(
                              
                              )
                                    :Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Column(children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                               widget.imagekurir=="http://siplah.mascitra.co.id/assets/images/user.ico"?Container():
                                              Container(
                                                width: 100,
                                                height: 50,
                                                child: Image.network(
                                                    widget.imagekurir),
                                              ),
                                              Container(
                                                child: Text(
                                                  "Ongkir : "+widget.cost.toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(width: 30,),
                                              widget.imagekurir=="http://siplah.mascitra.co.id/assets/images/user.ico"?
                                               Container(
                                                child: Text(
                                                  "Kurir : Internal",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ):Container()
                                            ],
                                          ),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ))
                                        ]))
                          ],
                        )
                      ],
                    ),
                  ))),
          Container(
            height: 2,
            color: Colors.grey,
          ),
          Container(
            height: 10,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Metode(
                        totalharga: widget.totalharga,
                        imagebank: widget.imagebank,
                        imagekurir: widget.imagekurir,
                        namamar: widget.namamar,
                        databank: widget.databank,
                        datatype: widget.datatype,
                        cost: widget.cost,
                        idmar:widget.idmar,
                        ketkur:widget.ketkur,
                        namakur:widget.namakur,
                        idtrans: widget.idtrans==null?widget.trans:widget.idtrans,
                            service:widget.service,
                            deskkur:widget.deskkur
                        ),
                  ));
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Text(
                      "  Metode Pembayaran",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  widget.imagebank == null
                      ? Container(
                          width: 100,
                          height: 50,
                          child: Image.network(
                              "http://siplah.mascitra.co.id/assets/images/payment/bca.png"),
                        )
                      : Container(
                          width: 100,
                          height: 50,
                          child: Image.network(widget.imagebank),
                        ),
                  Container(
                    width: 10,
                  ),
                  Container(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.white,
          ),
          Container(
            height: 2,
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 5,
                ),
                Container(
                  height: 2,
                  color: Colors.grey,
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Jumlah Pembelian'),
                  ),
                ),
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
                // Row(
                //   children: <Widget>[
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(widget.totalharga.toString() == null
                //           ? "Total Harga = Rp." + hargasub.toString()
                //           : "Total Harga = Rp." + widget.totalharga.toString()),
                //     )
                //   ],
                // ),
             
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            blurRadius: 2,
            color: Colors.grey,
          )]
        ),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            GestureDetector(onTap: (){
             bayarapi(widget.idtrans, getto);
              
               
                HomePage();
            }, child:Container(
              width:  MediaQuery.of(context).size.width/2,
              color: Colors.blueAccent,
              child: Center(child: Text("Bayar",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
            )),
            Container(
              color: Colors.white,
              width:  MediaQuery.of(context).size.width/2,
              
              child: Center(child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 2,
                  ),
                  Text("Total Pembayaran"),
                
                  Text(widget.totalharga==null?hargasub.toString():widget.totalharga.toString()),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
