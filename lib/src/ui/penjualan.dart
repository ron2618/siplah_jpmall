import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

        Uri.encodeFull(
            'https://siplah.jpstore.id/api/mitra/penjualan/tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
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

  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString("id");
    });
    //print("id o= " + nama);
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;
    getCredential();
    getJsonData();
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
              : ListView.builder(
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
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i]['no_invoice'] == null
                                  ? "kosong"
                                  : data[i]['no_invoice']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i]['user_nama'] == null
                                  ? "kosong"
                                  : "( " + data[i]['user_nama'] + " )"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i]['tanggal'] == null
                                  ? "kosong"
                                  : data[i]['tanggal']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i]['status_nama'] == null
                                  ? "kosong"
                                  : data[i]['status_nama']),
                            ),
                          ],
                        ),
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
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        )
                      ])),
                    ]));
                  }),
    );
  }
}
