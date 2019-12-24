import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/ui/alamatpemesan.dart';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/ui/kurir.dart';

class PembayaranState extends StatefulWidget {
  @override
  _PembayaranState createState() => _PembayaranState();
}

class _PembayaranState extends State<PembayaranState> {
  List datajne;
  Future<String> getKurir_Jne() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('https://siplah.jpstore.id/rajaongkir/ongkir/kurir'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
      },
      body: {
        'asal': kabupaten,
        'tujuan': test,
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

  String test;
  String nama;
  String namauser;
  String level_id;
  String foto;
  String kabupaten;
  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      namauser = pref.getString("username");
      nama = pref.getString("nama");
      level_id = pref.getString("level_id");
      foto = pref.getString("foto");
      id = pref.getString('id');
      kabupaten = pref.getString('kabupaten_id');
    });
    getCartsData();
  }

  ScrollController _controllerProduk;
  @override
  void initState() {
    _controllerProduk = ScrollController();
    super.initState();
    getCredential();
  }

  String id;
  List datax, data2;
  Future<String> getCartsData() async {
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
      datax = convertDataToJson['Data'];
      data2 = convertDataToJson['Data'][0]['Produk'];
    });
    test = data2[0]['penjual_kabupaten_id'];
    return "Success";
  }

  List data;
  Future<String> getAlamatData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/api/sekolah/alamat_pengiriman/list'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
        },
        body: {
          "user_id": "" + id,
          //"id": "" + nama
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
    });
  }

  String _selectedValue;
  int _rgProgramming = -1;
  @override
  Widget build(BuildContext context) {
    getCredential();
    getAlamatData();
    getKurir_Jne();
    return Scaffold(
      appBar: AppBar(
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
                child: data == null
                    ? Container()
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return data[i]['is_utama'] == '2'
                              ? Card()
                              : Card(
                                  child: Column(children: <Widget>[
                                  Column(children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Alamat Pengiriman",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
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
                                        Text(data[i]['alamat']),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(data[i]['kabupaten_nama']),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(data[i]['provinsi_nama']),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(data[i]['kode_pos']),
                                      ],
                                    )
                                  ]),
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
                                ]));
                        },
                      ),
              ),
            ),
          ),
          // Container(
          //   child: Column(children: <Widget>[
          //     Row(
          //       children: <Widget>[
          //         Padding(
          //           padding: const EdgeInsets.only(left: 7.0),
          //           child: Text(
          //             "Daftar Belanja",
          //             style:
          //                 TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          //           ),
          //         )
          //       ],
          //     ),
          //     SizedBox(
          //       height: 10,
          //     ),
          //     Column(
          //       children: <Widget>[
          //         Container(
          //           height: 400,
          //           child: datax == null
          //               ? Container()
          //               : ListView.builder(
          //                   itemCount: datax.length,
          //                   itemBuilder: (context, i) {
          //                     final x = datax[i]['Produk'];
          //                     return Padding(
          //                       padding: const EdgeInsets.only(left: 4.0),
          //                       child: Column(
          //                         children: <Widget>[
          //                           Row(
          //                             children: <Widget>[
          //                               IconButton(
          //                                 icon: Icon(Icons.home),
          //                               ),
          //                               Text(
          //                                 x[0]['penjual_nama'],
          //                                 style: TextStyle(
          //                                     fontSize: 14,
          //                                     fontWeight: FontWeight.bold),
          //                               ),
          //                             ],
          //                           ),
          //                           Column(
          //                             children: <Widget>[
          //                               data2 == null
          //                                   ? Container()
          //                                   : ListView.builder(
          //                                       controller: _controllerProduk,
          //                                       shrinkWrap: true,
          //                                       physics:
          //                                           NeverScrollableScrollPhysics(),
          //                                       itemCount: data2.length,
          //                                       itemBuilder: (context, i) {
          //                                         final x = datax[0]['Produk'];
          //                                         return Card(
          //                                           child: Column(
          //                                             // mainAxisAlignment: ,
          //                                             crossAxisAlignment:
          //                                                 CrossAxisAlignment
          //                                                     .start,
          //                                             children: <Widget>[
          //                                               Image.network(
          //                                                 x[i]['produk_foto'] !=
          //                                                         null
          //                                                     ? x[i]['produk_foto']
          //                                                         [0]['foto']
          //                                                     : 'https://siplah.mascitra.co.id/assets/images/no-image.png',
          //                                                 scale: 4,
          //                                               ),
          //                                               SizedBox(
          //                                                 height: 10,
          //                                               ),
          //                                               Container(
          //                                                   width: 250,
          //                                                   child: Text(
          //                                                     x[i][
          //                                                         'produk_nama'],
          //                                                     maxLines: 2,
          //                                                     overflow:
          //                                                         TextOverflow
          //                                                             .ellipsis,
          //                                                     style: TextStyle(
          //                                                       fontSize: 14,
          //                                                       fontWeight:
          //                                                           FontWeight
          //                                                               .w500,
          //                                                     ),
          //                                                   )),
          //                                               Container(
          //                                                   child: Text(
          //                                                       x[i][
          //                                                           'produk_harga'],
          //                                                       style:
          //                                                           TextStyle(
          //                                                         fontSize:
          //                                                             13.5,
          //                                                         fontWeight:
          //                                                             FontWeight
          //                                                                 .w500,
          //                                                         color: Colors
          //                                                             .cyan,
          //                                                       ))),
          //                                               SizedBox(
          //                                                 height: 10,
          //                                               )
          //                                             ],
          //                                           ),
          //                                         );
          //                                       })
          //                             ],
          //                           ),
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 ),
          //         ),
          //       ],
          //     )
          //   ]),
          // ),
          Container(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Kurir(),
                        ));
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.local_shipping),
                            ),
                            Text("Kurir"),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              height: 800,
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, i) {
                                  final List<RadioGroup> _programmingList = [
                                    RadioGroup(index: 1, text: "Kotlin"),
                                    // RadioGroup(index: 2, text: "Swift"),
                                    // RadioGroup(index: 3, text: "Flutter"),
                                    // RadioGroup(index: 4, text: "Java"),
                                    // RadioGroup(index: 5, text: "React Native"),
                                  ];
                                  
                                  return Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Column(
                                        children: _programmingList
                                            .map((programming) => RadioListTile(
                                                  title: Text(programming.text),
                                                  value: programming.index,
                                                  groupValue: _rgProgramming,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .trailing,
                                                  dense: true,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _rgProgramming = value;
                                                      _selectedValue =
                                                          programming.text;
                                                    });
                                                  },
                                                ))
                                            .toList(),
                                        // <Widget>[
                                        //   Column(
                                        //     children: <Widget>[
                                        //       RadioListTile(
                                        //         title: Text("Number $i"),
                                        //         value: i,
                                        //         groupValue: value,
                                        //         onChanged: (ind) =>
                                        //             setState(() => value = ind),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ]
                                      ));
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
