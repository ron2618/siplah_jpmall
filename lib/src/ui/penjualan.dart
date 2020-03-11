import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';

class Penjualan extends StatefulWidget {
  @override
  _PenjualanState createState() => _PenjualanState();
}

class _PenjualanState extends State<Penjualan> {
  String nama;
  List data, data2;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull('http://siplah.mascitra.co.id/api/mitra/penjualan/tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      data2 = convertDataToJson['Data'][0]['produk'];
    });
  }

String z;
  Future<http.Response> _setproses(String id) async {

    var url =
        'http://siplah.mascitra.co.id/api/mitra/penjualan/prosess';

    Map data = {'user_id': "" + nama, 'transaksi_id': id};
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
    //print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
     z=map["Pesan_sys"]; 
      // savedata();
      getJsonData();
      _berhasil1(context,z);
    }
    return response;
  }
   void _berhasil1(BuildContext context,z) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text(""+z),
            ));
  }
  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("maaf gagal edit"),
            ));
  }
  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString("id");
      getJsonData();
    });
    //print("id o= " + nama);
  }

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  String x;
  Future<http.Response> _settolak(String id) async {
    
    var url =
        'http://siplah.mascitra.co.id/api/mitra/penjualan/tolak';

    Map data = {'user_id': "" + nama, 'transaksi_id': id, 'alasan':myController.text};
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
    //print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
     x=map["Pesan_sys"]; 
      // savedata();
      getJsonData();
      _berhasil1(context,x);
    }
    return response;
  }
   final myController = TextEditingController();
   
  void _tolak(String id){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                  
           Row(
             children: <Widget>[
               Container(
                 width: 150,
                 child: new TextFormField(
                   controller: myController,
                      keyboardType: TextInputType.number, // Use email input type for emails.
                      decoration: new InputDecoration(
                        hintText: 'Contoh : Stok Kosong',
                        labelText: 'Alasan'
                      ),),
               ),
               
                 SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    _settolak(id);
                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    child: Center(child: Text("Simpan",style: TextStyle(color: Colors.white),)),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                  ),
                )
             ],
           ),
            ]
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width / 3;
    double cwidth = MediaQuery.of(context).size.width;
    String b = null;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Penjualan", style: TextStyle(color: Colors.white)),
        ),
        body: data == null
            ? Container()
            : data2 == null
                ? Container()
                : Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          // var a=int.parse(data2[i]['harga']);
                          // var b=int.parse(data2[i]['jumlah']);
                          //  var c=int.parse(data[i]['kurir_ongkir']);
                          //  int jumlah = a*b+c;

                          //  print(value);

                          return Container(
                              child: Column(children: <Widget>[
                            Card(
                              child: Container(
                                  width: cwidth,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            data[i]['no_invoice'] == null
                                                ? "kosong"
                                                : data[i]['no_invoice']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(data[i]['user_nama'] == null
                                            ? "kosong"
                                            : "( " +
                                                data[i]['user_nama'] +
                                                " )"),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Text(data[i]['tanggal'] == null
                                      //       ? "kosong"
                                      //       : data[i]['tanggal']),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            data[i]['status_nama'] == null
                                                ? "kosong"
                                                : data[i]['status_nama']),
                                      ),
                                    ],
                                  )),
                            ),
                            Card(
                                child: Row(children: <Widget>[
                              Container(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          "Alamat Pengiriman",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(data[i][
                                                    'data_alamat_pengiriman_penerima_nama'] ==
                                                null
                                            ? "kosong"
                                            : data[i][
                                                'data_alamat_pengiriman_penerima_nama']),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(6.0),
                                          width: c_width,
                                          child: new Column(children: <Widget>[
                                            Column(children: <Widget>[
                                              Text(data[0][
                                                          "data_alamat_pengiriman_alamat"] !=
                                                      null
                                                  ? data[0][
                                                      "data_alamat_pengiriman_alamat"]
                                                  : "kosong"),
                                            ])
                                          ])),

                                      //Text(data[i]['data_alamat_pengiriman_alamat']==null?"kosong":data[i]['data_alamat_pengiriman_alamat']),
                                    ])),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("Kurir"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(data[i]['kurir_kode'] == null
                                          ? ""
                                          : data[i]['kurir_kode']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(""),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("Total Harga"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(data[i]["kurir_ongkir"]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(""),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(""),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(""),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          DetailPenjualan(id:int.parse(data[i]['id']))));
                                        },
                                      ),
                                    ),
                                    data[i]['status_nama'] == 'Selesai'
                                        ? Container()
                                        : Container(
                                            child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: RaisedButton(
                                                  color: Colors.green,
                                                  child: Text("Terima Pesanan"),
                                                  onPressed: () {
                                                    _setproses(data[i]['id']);
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: RaisedButton(
                                                  color: Colors.red,
                                                  child: Text("Tolak"),
                                                  onPressed: () {
                                                    _tolak(data[i]['id']);
                                                  },
                                                ),
                                              )
                                            ],
                                          ))
                                  ],
                                ),
                              )
                            ])),
                          ]));
                        }),
                  ));
  }
}

class DetailPenjualan extends StatefulWidget {
  final int id;

  const DetailPenjualan({Key key, this.id}) : super(key: key);
  @override
  _DetailPenjualanState createState() => _DetailPenjualanState();
}

class _DetailPenjualanState extends State<DetailPenjualan> {
  String nama;
  List data, data2;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull('https://siplah.mascitra.co.id/api/mitra/penjualan/tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
          "id":widget.id.toString()
        });
    print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      data2 = convertDataToJson['Data'][0]['produk'];
    });
  }
  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString("id");
      getJsonData();
    });
    //print("id o= " + nama);
  }

  @override
  void initState() {
    super.initState();
    getCredential();
  }
    String produkid;
//tambahnego
  Future<String> tambahnego(String id) async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/pesanan/nego_tambah'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "transaksi_produk_id": id,
          "harga_nego": myController.text,
          "user_id": nama,
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      getNego(id);
    });
  }

  final myController = TextEditingController();
  String idnego;
  Future<String> setujui(String idvoid) async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/pesanan/nego_setuju'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "nego_id": idvoid,
          "user_id": nama,
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
    });
  }

  List negosiasi;
  Future<String> getNego(String id) async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/mitra/penjualan/nego_tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "transaksi_produk_id": id,
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      negosiasi = convertDataToJson['Data'];
    });
  }
  
  void shownego(id) {
     Future<String> getNego(String id) async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/mitra/penjualan/nego_tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "transaksi_produk_id": id,
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      negosiasi = convertDataToJson['Data'];
    });
  }
  print(negosiasi.length.toString());
    // flutter defined function
 getNego(id);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Negosiasi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: negosiasi.length,
                    itemBuilder: (context, i) {
                      int a = i + 1;
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey,
                            height: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(a.toString() + "."),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  child: Text(negosiasi[i]['nego'] + " ")),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: <Widget>[
                                  negosiasi[i]['user_setuju'] == "1"
                                      ? Container(
                                          height: 30,
                                          width: 150,
                                          child: Center(
                                              child: Text(
                                            "sekolah : Setuju",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        )
                                      : Container(
                                          height: 30,
                                          width: 150,
                                          child: Center(
                                              child: Text(
                                            "sekolah : -",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                          decoration: BoxDecoration(
                                              color: Colors.lightBlue,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  negosiasi[i]['mitra_setuju'] == "1"
                                      ? Container(
                                          height: 30,
                                          width: 150,
                                          child: Center(
                                              child: Text(
                                            "mitra : setuju",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setujui(negosiasi[i]['id']);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 150,
                                            child: Center(
                                                child: Text(
                                              "mitra : -",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            decoration: BoxDecoration(
                                                color: Colors.lightBlue,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 150,
                    child: new TextFormField(
                      controller: myController,
                      keyboardType: TextInputType
                          .number, // Use email input type for emails.
                      decoration: new InputDecoration(
                          hintText: '100000', labelText: 'Nego Berapa'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      tambahnego(id);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                          child: Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Detail Penjualan", style: TextStyle(color: Colors.white)),
      ),
      body: data==null?Container():data2==null?Container():ListView(
        children: <Widget>[
          Container(
            height: 100,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                 
                  return Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("PO"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i]['purchase_order']==null?"":data[i]['purchase_order']),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("No. Invoice"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data[i]['no_invoice']==null?"":data[i]['no_invoice'],
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("No. Resi"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i]['no_resi']==null?"":data[i]['no_resi'],
                                  style: TextStyle(fontSize: 12)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Total Pembayaran"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Rp 77.000",
                                  style: TextStyle(fontSize: 12)),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100*data2.length.toDouble(),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                itemCount: data2.length,
                itemBuilder: (context, i) {
                  return Card(
                      child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              height: 40,
                              child: Image.network(
                                  data2[i]['foto']==null?"":data2[i]['foto'])),
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data2[i]['nama']==null?"":data2[i]['nama'],maxLines: 4,),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("Jumlah"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(data2[i]['jumlah']==null?"":data2[i]['jumlah']),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("Harga Barang"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(data2[i]['harga']==null?"":data2[i]['harga']),
                          ),
                        ],
                      ),
                    
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("Total"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("Rp. 70000"),
                          ),
                        ],
                      ),
                      SizedBox(width: 5,),
                     Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                7,
                                        child: data2[i]['nego'] != '1'
                                            ? RaisedButton(
                                                color: Colors.blueGrey,
                                                onPressed: () {},
                                                child: Text(
                                                  "NEGO",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              )
                                            : RaisedButton(
                                                color: Colors.blue,
                                                onPressed: () {
                                                  getNego(data2[i]['id']);
                                                  shownego(data2[i]['id']);
                                                },
                                                child: Text("NEGO",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              )),
                                  ),
                    ],
                  ));
                }),
          ),
           Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12)),
          ),
          SizedBox(
            height: 10,
          ),

          Container(height: 600,
          width: MediaQuery.of(context).size.width, child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 1,
            itemBuilder: (context,i){
              return Container(
                child: Column(children: <Widget>[
                  Container( child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['data_alamat_pengiriman_penerima_nama']==null?"":data[i]['data_alamat_pengiriman_penerima_nama']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['data_alamat_pengiriman_alamat']==null?"":data[i]['data_alamat_pengiriman_alamat']),
                    )
                  ],),),
                  Container(child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Kurir"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['data_kurir_nama']==null?"":data[i]['data_kurir_nama']),
                    )
                  ],),),
                    Container(child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Ongkos Kirim"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['kurir_ongkir']==null?"":data[i]['kurir_ongkir']),
                    )
                  ],),),
                    Container(child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Kode Marketing"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['marketing_kode']==null?"":data[i]['marketing_kode']),
                    )
                  ],),),
                    Container(child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Nama Marketing"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['marketing_nama']==null?"":data[i]['marketing_nama']),
                    )
                  ],),),
                    

                ],),
              );
            }
          ),)
        ],
      ),
    );
  }
}
