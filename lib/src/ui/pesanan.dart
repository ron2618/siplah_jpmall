import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:shimmer/shimmer.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/metodebayar.dart';
import 'package:siplah_jpmall/src/ui/pembayaran.dart';

class PesananState extends StatefulWidget {
  @override
  _PesananState createState() => _PesananState();
}

class _PesananState extends State<PesananState> {
  String nama;
  List data, datax;
  String trans;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/pesanan/tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
        });
    print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      //datax = convertDataToJson['Data'][0]['mitra'][0]['produk'];
      trans = data[0]['id'];
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

  int no = 0;

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Pesanan", style: TextStyle(color: Colors.white)),
      ),
      body: data == null
          ? Center(
            child: Shimmer.fromColors(
              child: Text("Loading...", style:TextStyle(fontSize: 15) ), 
              baseColor: Colors.white, 
              highlightColor: Colors.grey),
          )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, i) {
                int a = i;
                a = a + 1;
                return Container(
                    child: Column(children: <Widget>[
                  Card(
                    child: Row(
                      children: <Widget>[
                        // Align(
                        //     alignment: Alignment.bottomRight,
                           Container(
                                child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.eye_solid,
                                  color: Colors.red[400],
                                ),
                                onPressed: () {
                                  String iddetail;
                                  iddetail = data[i]['id'];
                                  data[i]['status_nama'] == 'Success'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DetailPesanan(
                                                    iddetail: iddetail),
                                          ))
                                      : data[i]['status_nama'] == 'Penyelesaian'
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          DetailPesanan(
                                                              iddetail:
                                                                  iddetail)))
                                          : //print(iddetail);
                                          trans == null
                                              ? print(trans)
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PembayaranState(
                                                            trans: int.parse(
                                                                trans)),
                                                  ));
                                },
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(a == null ? "kosong" : a.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(data[i]['order_id'] == null
                              ? "kosong"
                              : data[i]['order_id']),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(data[i]['total'] == null
                        //       ? "kosong"
                        //       : "( " + data[i]['total'] + " )"),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(data[i]['tanggal'] == null
                              ? "kosong"
                              : data[i]['tanggal']),
                        ),

                        Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: data[i]['status_nama'] == "Success"
                                ? Container(
                                  color: Colors.green,
                                  height: 20,
                                  width: 60,
                                    // decoration:
                                    //     BoxDecoration(color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        data[i]['status_nama'] == null
                                            ? "kosong"
                                            : data[i]['status_nama'],
                                        style: TextStyle(color: Colors.white, fontSize: 10),
                                      ),
                                    ))
                                : data[i]['status_nama'] == "Penyelesaian"
                                    ? Container(
                                       height: 20,
                                  width: 80,
                                      color: Colors.blue,
                                        // decoration:
                                        //     BoxDecoration(color: Colors.blue),
                                        child: Center(
                                          child: Text(
                                              data[i]['status_nama'] == null
                                                  ? "kosong"
                                                  : data[i]['status_nama'],
                                              style:
                                                  TextStyle(color: Colors.white, fontSize: 10)),
                                        ))
                                    : Container(
                                      color: Colors.red,
                                        // decoration:
                                        //     BoxDecoration(color: Colors.red),
                                        child: Center(
                                          child: Text(
                                              data[i]['status_nama'] == null
                                                  ? "kosong"
                                                  : data[i]['status_nama'],
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 10)),
                                        ))),
                      ],
                    ),
                  ),
                ]));
              },
            ),
    );
  }
}

class DetailPesanan extends StatefulWidget {
  const DetailPesanan(
      {Key key, this.iddetail, this.imagebank, this.datatype, this.databank})
      : super(key: key);

  final String databank;
  final String datatype;
  final String iddetail;
  final String imagebank;

  @override
  _DetailPesananState createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  List detailpem;
  final formatter = new NumberFormat("#,###");
  String idnego;
  List data, produk, mitra;
  //getdetailpem
  final myController = TextEditingController();

  String nama;
  List negosiasi;
  int no = 0;
//getjson
  int o;

  String produkid;

  File _imageFile;

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  //start class upload
  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  _pilihKamera() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1920.0,
      maxWidth: 1080.0,
    );
    setState(() {
      _imageFile = image;
    });
  }

  void _showAlertuploadphoto(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Upload Photo"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Galery"),
                  onPressed: () {
                    _pilihGallery();
                  },
                ),
                new FlatButton(
                  child: new Text("Take A Picture"),
                  onPressed: () async {
                    _pilihKamera();
                  },
                ),
              ],
            ));
  }

  void _showAlertuploadbast(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Upload Photo"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Galery"),
                  onPressed: () {
                    _pilihGallery();
                  },
                ),
                new FlatButton(
                  child: new Text("Take A Picture"),
                  onPressed: () async {
                    _pilihKamera();
                  },
                ),
              ],
            ));
  }

  Future<String> getDetailpem(String order) async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/pesanan/status'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
          "order_id": order
        });
    //print(response.body);

    //map1['va_number'][0]['va_number']==0?virtualacount = null:virtualacount = map1['va_number'][0]['va_number'];

    setState(() {
      // ignore: deprecated_member_use
      // var convertDataToJson = json.decode(response.body);
      // detail = convertDataToJson;

      String virtualacount;
      String payment_code;
      String store;
      String transaction_time;
      String gross_amount;
      String currency;
      String order_id;
      String payment_type;
      String signature_key;
      String status_code;
      String transaction_id;
      String transaction_status;
      String status_message;
      String merchant_id;
      String bill_key;
      String biller_code;
      String fraud_status;
      String approvalcode;
      String maskedcard;
      Map<String, dynamic> map1 = json.decode(response.body);
      //String virtualacount = map1['va_number'][0]['va_number'];
      _bcabni() {
        virtualacount = map1['va_numbers'][0]['va_number'];
        payment_code = map1['payment_code'];
        store = map1['store'];
        transaction_time = map1['transaction_time'];
        gross_amount = map1['gross_amount'];
        currency = map1['currency'];
        order_id = map1['order_id'];
        payment_type = map1['payment_type'];
        signature_key = map1['signature_key'];
        status_code = map1['status_code'];
        transaction_id = map1['transaction_id'];
        transaction_status = map1['transaction_status'];
        status_message = map1['status_message'];
        merchant_id = map1['merchant_id'];
        bill_key = map1['bill_key'];
        biller_code = map1['biller_code'];
        fraud_status = map1['fraud_status'];
        approvalcode = map1['approval_code'];
        maskedcard = map1['masked_card'];
        _showAlertupload(
            context,
            approvalcode,
            maskedcard,
            virtualacount,
            payment_code,
            store,
            transaction_time,
            gross_amount,
            currency,
            order_id,
            payment_type,
            signature_key,
            status_code,
            transaction_id,
            transaction_status,
            status_message,
            merchant_id,
            bill_key,
            biller_code,
            fraud_status);
      }

      _klas() {
        payment_code = map1['payment_code'];
        store = map1['store'];
        transaction_time = map1['transaction_time'];
        gross_amount = map1['gross_amount'];
        currency = map1['currency'];
        order_id = map1['order_id'];
        payment_type = map1['payment_type'];
        signature_key = map1['signature_key'];
        status_code = map1['status_code'];
        transaction_id = map1['transaction_id'];
        transaction_status = map1['transaction_status'];
        status_message = map1['status_message'];
        merchant_id = map1['merchant_id'];
        bill_key = map1['bill_key'];
        biller_code = map1['biller_code'];
        fraud_status = map1['fraud_status'];
        approvalcode = map1['approval_code'];
        maskedcard = map1['masked_card'];
        _showAlertupload(
            context,
            approvalcode,
            maskedcard,
            virtualacount,
            payment_code,
            store,
            transaction_time,
            gross_amount,
            currency,
            order_id,
            payment_type,
            signature_key,
            status_code,
            transaction_id,
            transaction_status,
            status_message,
            merchant_id,
            bill_key,
            biller_code,
            fraud_status);
      }

      mitra[0]['pembayaran_melalui'] == "bca"
          ? _bcabni()
          : mitra[0]['pembayaran_melalui'] == "bni" ? _bcabni() : _klas();
    });
  }

  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/pesanan/tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
          "id": "" + widget.iddetail
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      mitra = convertDataToJson['Data'][0]['mitra'];
      produk = convertDataToJson['Data'][0]['mitra'][0]['produk'];
      produkid = produk[0]['id'];
      o = produk.length.toInt();

      getNego();
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

  void shownego() {
    // flutter defined function

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
                      tambahnego();
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

  //detailpesanan
  void _showAlertupload(
      BuildContext context,
      String approvalcode,
      String maskedcard,
      String virtualacount,
      String payment_code,
      String store,
      String transaction_time,
      String gross_amount,
      String currency,
      String order_id,
      String payment_type,
      String signature_key,
      String status_code,
      String transaction_id,
      String transaction_status,
      String status_message,
      String merchant_id,
      String bill_key,
      String biller_code,
      String fraud_status) {
    store == "Indomaret"
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: Text("Detail Pemesanan"),
                    content: Container(
                        height: 600,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(scrollDirection: Axis.vertical, children: <
                            Widget>[
                          Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Payment Code : " + payment_code),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Store : " + store),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Transaction Time : " + transaction_time),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Transaction Status : " +
                                      transaction_status),
                                )
                              ],
                            ),
                          ])
                        ])),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Back"),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    ]))
        : payment_type == "echannel"
            ? showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        title: Text("Detail Pemesanan"),
                        content: Container(
                            height: 600,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                                scrollDirection: Axis.vertical,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Payment Type : Mandiri"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Bill Key : " + bill_key),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "Biller Code : " + biller_code),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Transaction Time : " +
                                              transaction_time),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Transaction Status : " +
                                              transaction_status),
                                        )
                                      ],
                                    ),
                                  ])
                                ])),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Back"),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ]))
            : mitra[0]['pembayaran_melalui'] == "bca"
                ? virtualacount == null
                    ? showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text("Detail Pemesanan"),
                                content: Container(
                                    height: 600,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                        scrollDirection: Axis.vertical,
                                        children: <Widget>[
                                          Column(children: <Widget>[
                                            // Row(
                                            //   children: <Widget>[
                                            //     Padding(
                                            //       padding: const EdgeInsets.all(8.0),
                                            //       child: Text("Virtual Account : " + virtualacount),
                                            //     ),
                                            //   ],
                                            // ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Bank : BCA"),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaction Time : " +
                                                          transaction_time),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaction Status : " +
                                                          transaction_status),
                                                )
                                              ],
                                            ),
                                          ])
                                        ])),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Back"),
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                ]))
                    : showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text("Detail Pemesanan"),
                                content: Container(
                                    height: 600,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                        scrollDirection: Axis.vertical,
                                        children: <Widget>[
                                          Column(children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Virtual Account : " +
                                                          virtualacount),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Bank : BCA"),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaction Time : " +
                                                          transaction_time),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaction Status : " +
                                                          transaction_status),
                                                )
                                              ],
                                            ),
                                          ])
                                        ])),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Back"),
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                ]))
                : store == "bni"
                    ? showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text("Detail Pemesanan"),
                                content: Container(
                                    height: 600,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                        scrollDirection: Axis.vertical,
                                        children: <Widget>[
                                          Column(children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Virtual Account : " +
                                                          virtualacount),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Store : BNI"),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaction Time : " +
                                                          transaction_time),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaction Status : " +
                                                          transaction_status),
                                                )
                                              ],
                                            ),
                                          ])
                                        ])),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Back"),
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                ]))
                    : store == "bca_klikpay"
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text("Detail Pemesanan"),
                                    content: Container(
                                        height: 600,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child:
                                            ListView(scrollDirection: Axis.vertical, children: <
                                                Widget>[
                                          Column(children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Type : BCA Klikpay"),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Order Id : " + order_id),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Order Id : " + order_id),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaksi Id : " +
                                                          transaction_id),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaction Time : " +
                                                          transaction_time),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Transaction Status : " +
                                                          transaction_status),
                                                )
                                              ],
                                            ),
                                          ])
                                        ])),
                                    actions: <Widget>[
                                      new FlatButton(
                                        child: new Text("Back"),
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                    ]))
                        : store == "bca_klikbca"
                            ? showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title: Text("Detail Pemesanan"),
                                        content: Container(
                                            height: 600,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child:
                                                ListView(scrollDirection: Axis.vertical, children: <
                                                    Widget>[
                                              Column(children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "Type : Klik BCA"),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "Order Id : " +
                                                              order_id),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "Transaksi ID : " +
                                                              transaction_id),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "Transaction Time : " +
                                                              transaction_time),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "Transaction Status : " +
                                                              transaction_status),
                                                    )
                                                  ],
                                                ),
                                              ])
                                            ])),
                                        actions: <Widget>[
                                          new FlatButton(
                                            child: new Text("Back"),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                        ]))
                            : store == "mandiri_clikpay"
                                ? showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text("Detail Pemesanan"),
                                            content: Container(
                                                height: 600,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView(
                                                    scrollDirection: Axis.vertical,
                                                    children: <Widget>[
                                                      Column(children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "Order ID : " +
                                                                      order_id),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "Transaksi ID : " +
                                                                      transaction_id),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "Approval Code : " +
                                                                      approvalcode),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "Masked Card: " +
                                                                      maskedcard),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "Transaction Time : " +
                                                                      transaction_time),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "Transaction Status : " +
                                                                      transaction_status),
                                                            )
                                                          ],
                                                        ),
                                                      ])
                                                    ])),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Back"),
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                              ),
                                            ]))
                                : showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text("Detail Pemesanan"),
                                            content: Container(
                                                height: 600,
                                                width: MediaQuery.of(context).size.width,
                                                child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
                                                  Column(children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Payment Code : " +
                                                                  payment_code),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Store : " +
                                                                  store),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Transaction Time : " +
                                                                  transaction_time),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Transaction Status : " +
                                                                  transaction_status),
                                                        )
                                                      ],
                                                    ),
                                                  ])
                                                ])),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Back"),
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                              ),
                                            ]));
  }

//tambahnego
  Future<String> tambahnego() async {
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
          "transaksi_produk_id": produkid,
          "harga_nego": myController.text,
          "user_id": nama,
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      getNego();
    });
  }

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

  Future<String> getNego() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/pesanan/nego_tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "transaksi_produk_id": produkid,
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      negosiasi = convertDataToJson['Data'];
    });
  }

  //bayar akhir
  Future<http.Response> bayarapi() async {
    var url = 'http://siplah.mascitra.co.id/api/sekolah/pesanan/bayar';

    Map data = {
      'user_id': nama,
      'id': widget.iddetail,
      'pembayaran_type': "" + widget.datatype,
      'pembayaran_melalui': "" + widget.databank,
      'transaksi_pembelian_id': widget.iddetail
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

    print("${response.body}");
    print(response.body);

    Map<String, dynamic> map = jsonDecode(response.body);

    print(data);
    //print(map['pesan_usr']);
    if (map["Error"] == true || map["Error"] == "true") {
      print("Jadi Draft");
    } else {
      _akhir(context);
    }
    return response;
  }

  void _akhir(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Barang berhasil dibayar"),
            ));
  }

  _loop() {
    return Column(
      children: <Widget>[
        Container(
          height: 70,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, i) {
                final y = data[i]['mitra'];
                return Row(
                  children: <Widget>[
                    //high
                    Container(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              y[i]['foto'] != null
                                  ? y[i]['foto']
                                  : 'http://siplah.mascitra.co.id/assets/images/user.ico',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(y[i]['nama']),
                                  ),
                                ]),
                                Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(y[i]['kabupaten_nama']),
                                  ),
                                ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //low
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
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, i) {
                final y = data[i]['mitra'];

                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(y[i]['no_invoice'] == null
                            ? "No. Invoice :"
                            : "No. Invoice : " + y[i]['no_invoice']),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(y[i]['purchase_order'] == null
                            ? "Purchase Order :"
                            : "Purchase Order : " + y[i]['purchase_order']),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(y[i]['marketing_kode'] == null
                            ? "Kode Marketing :"
                            : "Kode Marketing : " + y[i]['marketing_kode']),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(y[i]['marketing_nama'] == null
                            ? "Nama Marketing : "
                            : "Nama Marketing : " + y[i]['marketing_nama']),
                      ],
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
        // Container(
        //   height: 50,
        //   width: MediaQuery.of(context).size.width,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: <Widget>[
        //       SizedBox(
        //         width: 2,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text("No."),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text("Foto"),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text("Nama"),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text("Deskripsi"),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text("Jumlah"),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text("Harga"),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: Text("Nego"),
        //       ),
        //       Container(
        //         width: MediaQuery.of(context).size.width / 5,
        //         child: Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: Text("Sub. Total Bayar"),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black12)),
        ),
        Container(
          height: 300 * o.toDouble(),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: produk.length,
              itemBuilder: (context, i) {
                int a = i;
                a++;
                int jumlah = int.parse(produk[i]['jumlah']);
                int harga = int.parse(produk[i]['harga']);

                int sub = jumlah * harga;
                return Card(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Text(a.toString())),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 40,
                            height: 40,
                            child: Image.network(produk[i]['foto'] != null
                                ? produk[i]['foto']
                                : 'http://siplah.mascitra.co.id/assets/images/user.ico')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 13,
                            child: Text(produk[i]['nama'])),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 7,
                            child: Html(
                              data: produk[i]['deskripsi'],
                              //Optional parameters:
                              onLinkTap: (url) {
                                print("Opening $url...");
                              },
                              customRender: (node, children) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "custom_tag":
                                      return Column(children: children);
                                  }
                                }
                              },
                            ), //Text(produk[i]['deskripsi'])),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 20,
                            child: Text(produk[i]['jumlah'])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 10,
                            child: Text(produk[i]['harga'])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 7,
                            child: produk[i]['nego'] != '1'
                                ? RaisedButton(
                                    color: Colors.blueGrey,
                                    onPressed: () {},
                                    child: Text(
                                      "NEGO",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  )
                                : RaisedButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      shownego();
                                    },
                                    child: Text("NEGO",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10)),
                                  )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 10,
                            child: Text(sub.toString())),
                      )
                    ],
                  ),
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
          height: 100,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return Row(
                  children: <Widget>[
                    Text(
                        mitra[0]['kurir_kode'] == null
                            ? "Ongkir (Internal)"
                            : "Ongkir (" + mitra[0]['kurir_kode'] + ")",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))
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
          height: 300,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                int total = int.parse(data[0]['total']);
                int kurir = int.parse(mitra[0]['kurir_ongkir']);
                int bayar = total - kurir;
                return Column(
                  children: <Widget>[
                    Container(
                        child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.location_on, color: Colors.black87),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                mitra[0]['alamat_pengiriman_alamat'] == null
                                    ? ""
                                    : mitra[0]['alamat_pengiriman_alamat']),
                          ),
                        )
                      ],
                    )),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Container(
                          child: Column(children: <Widget>[
                            Text("Harga Asli: "),
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text("Rp " +
                                            formatter.format(int.parse(
                                                mitra[0]['kurir_ongkir']))),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Container(
                          child: Column(children: <Widget>[
                            Text("Jumlah Harga: "),
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text("Rp " + formatter.format(bayar)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text("Status"),
                        Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: mitra[i]['status_nama'] == "Selesai"
                                ? Container(
                                  color: Colors.green,
                                  height: 40,
                                  width: 20,
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    child: Center(
                                      
                                      child: Text(
                                        mitra[i]['status_nama'] == null
                                            ? "kosong"
                                            : mitra[i]['status_nama'],
                                        style: TextStyle(
                                            
                                            color: Colors.white),
                                      ),
                                    ))
                                : mitra[i]['status_nama'] == "Diproses"
                                    ? Container(
                                      height: 40,
                                  width: 20,
                                  color: Colors.blue,
                                        decoration:
                                            BoxDecoration(color: Colors.blue),
                                        child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'],
                                            style: TextStyle(
                                                
                                                color: Colors.white)))
                                    : mitra[i]['status_nama'] == "Dikirim"
                                        ? Container(
                                          height: 40,
                                  width: 20,
                                  color: Colors.yellowAccent,
                                            decoration: BoxDecoration(
                                                color: Colors.yellowAccent),
                                            child: Text(
                                                mitra[i]['status_nama'] == null
                                                    ? "kosong"
                                                    : mitra[i]['status_nama'],
                                                style: TextStyle(
                                                    
                                                    color: Colors.white)))
                                        : mitra[i]['status_nama'] == "Diterima"
                                            ? Container(
                                              height: 40,
                                  width: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.green[300]),
                                                child: Text(
                                                    mitra[i]['status_nama'] == null
                                                        ? "kosong"
                                                        : mitra[i]['status_nama'],
                                                    style: TextStyle( color: Colors.white)))
                                            : Container(height: 50,
                                  width: 80,
                                  color: Colors.red,
                                  decoration: BoxDecoration(color: Colors.red), child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            height: 25, child: Text(mitra[0]['updated_at']))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        mitra[i]['status_nama'] == "Ditolak"
                            ? Container()
                            : mitra[i]['status_nama'] == "Dikirim"
                                ? Container(
                                    child: Row(
                                      children: <Widget>[
                                        RaisedButton(
                                          color: Colors.blue,
                                          onPressed: () {
                                            _showAlertuploadbast(context);
                                          },
                                          child: Text("Upload Bukti Bast"),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                        SizedBox(
                                          width: 10,
                                        ),
                                        // RaisedButton(
                                        //     color: Colors.yellow,
                                        //   onPressed: () {},
                                        //   child: Text("Purchase Order"),
                                        // ),
                                      ],
                                    ),
                                  )
                                : mitra[i]['status_nama'] ==
                                        "Menunggu diprosess"
                                    ? Container()
                                    : Container(
                                        child: Row(
                                          children: <Widget>[
                                            RaisedButton(
                                              color: Colors.blue,
                                              onPressed: () {
                                                _showAlertuploadphoto(context);
                                              },
                                              child: Text(
                                                  "Upload Bukti Pembayaran"),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            widget.databank == null
                                                ? RaisedButton(
                                                    color: Colors.green,
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                MetodeNew(
                                                              iddetail: widget
                                                                  .iddetail,
                                                            ),
                                                          ));
                                                    },
                                                    child: Text("Bayar"),
                                                  )
                                                : RaisedButton(
                                                    color: Colors.green,
                                                    onPressed: () {
                                                      print(nama);
                                                      bayarapi();
                                                    },
                                                    child: Text("Bayar"),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      )
                      ],
                    )
                  ],
                );
              }),
        )
      ],
    );
  }

//test

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Detail Pesanan", style: TextStyle(color: Colors.white)),
        ),
        body: data == null
            ? Center(
                child: Shimmer.fromColors(
                    child: Text("Loading..."),
                    baseColor: Colors.white,
                    highlightColor: Colors.grey),
              )
            : produk == null
                ? Center(
                    child: Shimmer.fromColors(
                        child: Text("Loading..."),
                        baseColor: Colors.white,
                        highlightColor: Colors.grey),
                  )
                : ListView(children: <Widget>[
                    Container(
                      height: 40,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text("Total Pembayaran"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Rp." +
                                    formatter
                                        .format(int.parse(data[i]['total']))),
                              )
                            ]);
                            // Row(
                            //   children: <Widget>[
                            //     // Column(children: <Widget>[
                            //     //   Padding(
                            //     //     padding: const EdgeInsets.all(10.10),
                            //     //     child: Text("Order Id"),
                            //     //   ),
                            //     //   Padding(
                            //     //     padding: const EdgeInsets.all(8.0),
                            //     //     child: Text(data[i]['order_id']),
                            //     //   )
                            //     // ]),
                            //     Row(children: <Widget>[
                            //       Padding(
                            //         padding: const EdgeInsets.only(left:8),
                            //         child: Text("Total Pembayaran"),
                            //       ),
                            //       Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Text(formatter
                            //             .format(int.parse(data[i]['total']))),
                            //       )
                            //     ]),
                            //     // Row(children: <Widget>[
                            //     //   GestureDetector(
                            //     //     onTap: () {
                            //     //       getJsonData();
                            //     //       print(nama);
                            //     //       print(mitra[i]['order_id']);
                            //     //       getDetailpem(mitra[i]['order_id']);

                            //     //       //_showAlertupload(context);
                            //     //     },
                            //     //     child: Padding(
                            //     //       padding: const EdgeInsets.all(10.15),
                            //     //       child: Text(
                            //     //         "Detail Pembayaran",
                            //     //         style: TextStyle(
                            //     //             color: Colors.blue,
                            //     //             fontSize: 15,
                            //     //             fontWeight: FontWeight.bold),
                            //     //       ),
                            //     //     ),
                            //     //   )
                            //     // ]),
                            //   ],
                            // );
                          }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey)),
                    ),
                    
                    new Row(children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: new ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new Row(
                                children: <Widget>[
                                  //test
                                  Container(
                                    height: 1000,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: mitra.length,
                                        itemBuilder: (context, i) {
                                          final y = mitra;
                                          return Column(
                                            children: <Widget>[
                                              //high
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          y[i]['foto'] != null
                                                              ? y[i]['foto']
                                                              : 'http://siplah.mascitra.co.id/assets/images/user.ico',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Column(children: <
                                                                Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(y[i]
                                                                    ['nama']),
                                                              ),
                                                            ]),
                                                            Column(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(y[
                                                                            i][
                                                                        'kabupaten_nama']),
                                                                  ),
                                                                ])
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              //low
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black12)),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(y[i]['no_invoice'] ==
                                                                  null
                                                              ? "No. Invoice :"
                                                              : "No. Invoice : " +
                                                                  y[i][
                                                                      'no_invoice']),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(y[i]['purchase_order'] ==
                                                                  null
                                                              ? "Purchase Order :"
                                                              : "Purchase Order : " +
                                                                  y[i][
                                                                      'purchase_order']),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(y[i]['marketing_kode'] ==
                                                                  null
                                                              ? "Kode Marketing :"
                                                              : "Kode Marketing : " +
                                                                  y[i][
                                                                      'marketing_kode']),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(y[i]['marketing_nama'] ==
                                                                  null
                                                              ? "Nama Marketing : "
                                                              : "Nama Marketing : " +
                                                                  y[i][
                                                                      'marketing_nama']),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //            Container(
                                              //   decoration: BoxDecoration(
                                              //       border: Border.all(width: 1, color: Colors.black12)),
                                              // ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // Container(
                                              //   height: 50,
                                              //   width: MediaQuery.of(context).size.width,
                                              //   child: ListView(
                                              //     scrollDirection: Axis.horizontal,
                                              //     children: <Widget>[
                                              //       SizedBox(
                                              //         width: 2,
                                              //       ),
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(8.0),
                                              //         child: Text("No."),
                                              //       ),
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(8.0),
                                              //         child: Text("Foto"),
                                              //       ),
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(8.0),
                                              //         child: Text("Nama"),
                                              //       ),
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(8.0),
                                              //         child: Text("Deskripsi"),
                                              //       ),
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(8.0),
                                              //         child: Text("Jumlah"),
                                              //       ),
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(8.0),
                                              //         child: Text("Harga"),
                                              //       ),
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(10.0),
                                              //         child: Text("Nego"),
                                              //       ),
                                              //       Container(
                                              //         width: MediaQuery.of(context).size.width / 5,
                                              //         child: Padding(
                                              //           padding: const EdgeInsets.all(10.0),
                                              //           child: Text("Sub. Total Bayar"),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black12)),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black12)),
                                              ),
                                              Container(
                                                height: 300 * o.toDouble(),
                                                child: ListView.builder(
                                                    // physics: NeverScrollableScrollPhysics(),
                                                    itemCount: produk.length,
                                                    itemBuilder: (context, i) {
                                                      final k = mitra;
                                                      int a = i;
                                                      a++;
                                                      int jumlah = int.parse(
                                                          produk[i]['jumlah']);
                                                      int harga = int.parse(
                                                          produk[i]['harga']);

                                                      int sub = jumlah * harga;
                                                      return Card(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Container(
                                                                      child: Text(
                                                                          a.toString())),
                                                                ),
                                                                Container(
                                                                    width: 70,
                                                                    height: 70,
                                                                    child: Image.network(produk[i]['foto'] !=
                                                                            null
                                                                        ? produk[i]
                                                                            [
                                                                            'foto']
                                                                        : 'http://siplah.mascitra.co.id/assets/images/user.ico')),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 2,
                                                                      bottom:
                                                                          2),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    produk[i][
                                                                        'nama'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    "Deskripsi produk: "),
                                                                // Padding(
                                                                // padding: const EdgeInsets.only(left: 5),
                                                                // child: Html(
                                                                //   renderNewlines: true,
                                                                //     data: produk[i]['deskripsi'],
                                                                //     //Optional parameters:
                                                                //     onLinkTap: (url) {
                                                                //       print("Opening $url...");
                                                                //     },
                                                                //     customRender: (node, children) {
                                                                //       if (node is dom.Element) {
                                                                //         switch (node.localName) {
                                                                //           case "custom_tag":
                                                                //             return Column(
                                                                //                 children: children);
                                                                //         }
                                                                //       }
                                                                //     },
                                                                //   ),
                                                                // // Container(
                                                                // //   // width:
                                                                // //   //     MediaQuery.of(context).size.width /
                                                                // //   //         7,
                                                                // //   child: Html(
                                                                // //     data: produk[i]['deskripsi'],
                                                                // //     //Optional parameters:
                                                                // //     onLinkTap: (url) {
                                                                // //       print("Opening $url...");
                                                                // //     },
                                                                // //     customRender: (node, children) {
                                                                // //       if (node is dom.Element) {
                                                                // //         switch (node.localName) {
                                                                // //           case "custom_tag":
                                                                // //             return Column(
                                                                // //                 children: children);
                                                                // //         }
                                                                // //       }
                                                                // //     },
                                                                // //   ), //Text(produk[i]['deskripsi'])),
                                                                // // )
                                                                // ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 2),
                                                              child: Row(
                                                                // width:
                                                                //     MediaQuery.of(context).size.width /
                                                                //         20,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      "Jumlah produk: "),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Text(
                                                                        produk[i]
                                                                            [
                                                                            'jumlah']),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 2),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      "Harga produk: "),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Text("Rp. " +
                                                                        produk[i]
                                                                            [
                                                                            'harga']),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8),
                                                              child: Row(
                                                                // width:
                                                                //     MediaQuery.of(context).size.width /
                                                                //         10,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    "Jumlah total: ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17),
                                                                  ),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              8.0),
                                                                      child: Text(
                                                                          "Rp. " +
                                                                              sub.toString()))
                                                                ],
                                                              ),
                                                            )
                                                            // Padding(
                                                            //   padding: const EdgeInsets.only(top:2.0),
                                                            //   child: Container(
                                                            //       // width:
                                                            //       //     MediaQuery.of(context).size.width /
                                                            //       //         10,
                                                            //       child: Text(sub.toString())),
                                                            // )
                                                          ],
                                                        ),
                                                      )
                                                          // Column(
                                                          //   // mainAxisAlignment: MainAxisAlignment.start,
                                                          //   children: <Widget>[
                                                          // Padding(
                                                          //   padding: const EdgeInsets.all(8.0),
                                                          //   child: Container(child: Text(a.toString())),
                                                          // ),
                                                          //     Padding(
                                                          //       padding: const EdgeInsets.all(8.0),
                                                          //   child: Container(
                                                          //       width: 40,
                                                          //       height: 40,
                                                          //       child: Image.network(produk[i]
                                                          //                   ['foto'] !=
                                                          //               null
                                                          //           ? produk[i]['foto']
                                                          //           : 'http://siplah.mascitra.co.id/assets/images/user.ico')),
                                                          // ),
                                                          //     Padding(
                                                          //       padding: const EdgeInsets.all(8.0),
                                                          //       child: Container(
                                                          //           // width:
                                                          //           //     MediaQuery.of(context).size.width /
                                                          //           //         13,
                                                          //           child: Text(produk[i]['nama'])),
                                                          //     ),
                                                          // Padding(
                                                          //     padding: const EdgeInsets.all(8.0),
                                                          //     child: Container(
                                                          //       // width:
                                                          //       //     MediaQuery.of(context).size.width /
                                                          //       //         7,
                                                          //       child: Html(
                                                          //         data: produk[i]['deskripsi'],
                                                          //         //Optional parameters:
                                                          //         onLinkTap: (url) {
                                                          //           print("Opening $url...");
                                                          //         },
                                                          //         customRender: (node, children) {
                                                          //           if (node is dom.Element) {
                                                          //             switch (node.localName) {
                                                          //               case "custom_tag":
                                                          //                 return Column(
                                                          //                     children: children);
                                                          //             }
                                                          //           }
                                                          //         },
                                                          //       ), //Text(produk[i]['deskripsi'])),
                                                          //     )),
                                                          // Padding(
                                                          //   padding: const EdgeInsets.all(8.0),
                                                          //   child: Container(
                                                          //       // width:
                                                          //       //     MediaQuery.of(context).size.width /
                                                          //       //         20,
                                                          //       child: Text(produk[i]['jumlah'])),
                                                          // ),
                                                          //     Padding(
                                                          //       padding: const EdgeInsets.all(8.0),
                                                          //       child: Container(
                                                          //           // width:
                                                          //           //     MediaQuery.of(context).size.width /
                                                          //           //         10,
                                                          // child: Text(produk[i]['harga'])),
                                                          //     ),
                                                          //     Padding(
                                                          //       padding: const EdgeInsets.all(8.0),
                                                          //       child: Container(
                                                          //           // width:
                                                          //           //     MediaQuery.of(context).size.width /
                                                          //           //         7,
                                                          //           child: produk[i]['nego'] != '1'
                                                          //               ? RaisedButton(
                                                          //                   color: Colors.blueGrey,
                                                          //                   onPressed: () {},
                                                          //                   child: Text(
                                                          //                     "NEGO",
                                                          //                     style: TextStyle(
                                                          //                         color: Colors.white,
                                                          //                         fontSize: 10),
                                                          //                   ),
                                                          //                 )
                                                          //               : RaisedButton(
                                                          //                   color: Colors.blue,
                                                          //                   onPressed: () {
                                                          //                     shownego();
                                                          //                   },
                                                          //                   child: Text("NEGO",
                                                          //                       style: TextStyle(
                                                          //                           color: Colors.white,
                                                          //                           fontSize: 10)),
                                                          //                 )),
                                                          //     ),
                                                          // Padding(
                                                          //   padding: const EdgeInsets.all(8.0),
                                                          //   child: Container(
                                                          //       // width:
                                                          //       //     MediaQuery.of(context).size.width /
                                                          //       //         10,
                                                          //       child: Text(sub.toString())),
                                                          // )
                                                          //   ],
                                                          // ),
                                                          );
                                                    }),
                                              ),

                                              //       Container(
                                              //   decoration: BoxDecoration(
                                              //       border: Border.all(width: 1, color: Colors.black12)),
                                              // ),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              Container(
                                                height: 40,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: 1,
                                                    itemBuilder: (context, i) {
                                                      return Card(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  mitra[0]['kurir_kode'] ==
                                                                          null
                                                                      ? "Ongkir (Internal)"
                                                                      : "Ongkir (" +
                                                                          mitra[0]
                                                                              [
                                                                              'kurir_kode'] +
                                                                          ")",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black12)),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  height: 300,
                                                  child: ListView.builder(
                                                      // physics: NeverScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (context, i) {
                                                        int total = int.parse(
                                                            data[0]['total']);
                                                        int kurir = int.parse(
                                                            mitra[0][
                                                                'kurir_ongkir']);
                                                        int bayar =
                                                            total - kurir;
                                                        return Card(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Icon(
                                                                          Icons
                                                                              .location_on,
                                                                          color:
                                                                              Colors.black87),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.5,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(mitra[0]['alamat_pengiriman_alamat'] ==
                                                                                null
                                                                            ? ""
                                                                            : mitra[0]['alamat_pengiriman_alamat']),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        child:
                                                                            Container(
                                                                      child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Text("Harga Asli"),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 8),
                                                                              child: Text("Rp " + formatter.format(int.parse(mitra[0]['kurir_ongkir']))),
                                                                            )
                                                                            // Column(
                                                                            //   children: <Widget>[
                                                                            //     Container(
                                                                            //       height: 40,
                                                                            //       decoration: BoxDecoration(
                                                                            //           border: Border.all(
                                                                            //               width: 1,
                                                                            //               color: Colors.black12)),
                                                                            //       child: Padding(
                                                                            //         padding:
                                                                            //             const EdgeInsets.all(8.0),
                                                                            //         child: Column(
                                                                            //           children: <Widget>[
                                                                            //             Text("Rp " +
                                                                            //                   formatter.format(
                                                                            //                       int.parse(mitra[0][
                                                                            //                           'kurir_ongkir']))),
                                                                            //           ],
                                                                            //         ),
                                                                            //       ),
                                                                            //     ),
                                                                            //   ],
                                                                            // )
                                                                          ]),
                                                                    )),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        child:
                                                                            Container(
                                                                      child: Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Text("Jumlah Harga"),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 8.0),
                                                                              child: Text("Rp " + formatter.format(bayar)),
                                                                            )
                                                                            // Column(
                                                                            //   children: <Widget>[
                                                                            //     Container(
                                                                            //       height: 40,
                                                                            //       decoration: BoxDecoration(
                                                                            //           border: Border.all(
                                                                            //               width: 1,
                                                                            //               color: Colors.black12)),
                                                                            //       child: Padding(
                                                                            //         padding:
                                                                            //             const EdgeInsets.all(8.0),
                                                                            //         child: Column(
                                                                            //           children: <Widget>[
                                                                            //             Text("Rp " +
                                                                            //                   formatter
                                                                            //                       .format(bayar)),
                                                                            //           ],
                                                                            //         ),
                                                                            //       ),
                                                                            //     ),
                                                                            //   ],
                                                                            // )
                                                                          ]),
                                                                    )),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                2.0),
                                                                        child: mitra[i]['status_nama'] ==
                                                                                "Selesai"
                                                                            ? Container(
                                                                              width: 100,
                                                                              height: 50,
                                                                              color: Colors.green,
                                                                                // decoration: BoxDecoration(color: Colors.green),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'],
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                                                  ),
                                                                                ))
                                                                            : mitra[i]['status_nama'] == "Diproses" ? 
                                                                            Container(color: Colors.blue,
                                                                             width: 100,
                                                                              height: 50,
                                                                            // decoration: BoxDecoration(color: Colors.blue), 
                                                                            child: Center(child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10)))) : mitra[i]['status_nama'] == "Dikirim" 
                                                                            ? Container(
                                                                               width: 100,
                                                                              height: 50,
                                                                              color: Colors.yellow[700],
                                                                              // decoration: BoxDecoration(color: Colors.yellowAccent), 
                                                                              child: Center(child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12)))) : mitra[i]['status_nama'] == "Diterima" ? 
                                                                              Container(
                                                                                 width: 100,
                                                                              height: 50,
                                                                                color: Colors.green[300],
                                                                                // decoration: BoxDecoration(color: Colors.green[300]), 
                                                                                child: Center(child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10)))) : 
                                                                                Container(
                                                                                   width: 150,
                                                                              height: 50,
                                                                                  color: Colors.red,
                                                                                  // decoration: BoxDecoration(color: Colors.red), 
                                                                                  child: Center(child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12))))),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        height:
                                                                            25,
                                                                        child: Text(mitra[0]
                                                                            [
                                                                            'updated_at']))
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    mitra[i]['status_nama'] ==
                                                                            "Ditolak"
                                                                        ? Container()
                                                                        : mitra[i]['status_nama'] ==
                                                                                "Dikirim"
                                                                            ? Container(
                                                                                child: Row(
                                                                                  children: <Widget>[
                                                                                    RaisedButton(
                                                                                      color: Colors.blue,
                                                                                      onPressed: () {
                                                                                        _showAlertuploadbast(context);
                                                                                      },
                                                                                      child: Text("Upload Bukti Bast"),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),

                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    // RaisedButton(
                                                                                    //     color: Colors.yellow,
                                                                                    //   onPressed: () {},
                                                                                    //   child: Text("Purchase Order"),
                                                                                    // ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : mitra[i]['status_nama'] == "Menunggu diprosess"
                                                                                ? Container()
                                                                                : Container(
                                                                                    child: Row(
                                                                                      children: <Widget>[
                                                                                        RaisedButton(
                                                                                          color: Colors.blue,
                                                                                          onPressed: () {
                                                                                            _showAlertuploadphoto(context);
                                                                                          },
                                                                                          child: Text("Upload Bukti Pembayaran"),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        widget.databank == null
                                                                                            ? RaisedButton(
                                                                                                color: Colors.green,
                                                                                                onPressed: () {
                                                                                                  Navigator.push(
                                                                                                      context,
                                                                                                      MaterialPageRoute(
                                                                                                        builder: (BuildContext context) => MetodeNew(
                                                                                                          iddetail: widget.iddetail,
                                                                                                        ),
                                                                                                      ));
                                                                                                },
                                                                                                child: Text("Bayar"),
                                                                                              )
                                                                                            : RaisedButton(
                                                                                                color: Colors.green,
                                                                                                onPressed: () {
                                                                                                  print(nama);
                                                                                                  bayarapi();
                                                                                                },
                                                                                                child: Text("Bayar"),
                                                                                              ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }))
                                              //gkhapusend
                                            ],
                                          );
                                        }),
                                  ),
                                  //end
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ]),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       border: Border.all(width: 2, color: Colors.grey)),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),

                    // _loop()

                    //    Column(children: <Widget>[
                    //     Container(
                    //       height: 70,
                    //       child: ListView.builder(
                    //           physics: NeverScrollableScrollPhysics(),
                    //           itemCount: data.length,
                    //           itemBuilder: (context, i) {
                    //             final y = data[i]['mitra'];
                    //             return Row(
                    //               children: <Widget>[
                    //                 //high
                    //                 Container(
                    //                   child: Row(
                    //                     children: <Widget>[
                    //                       CircleAvatar(
                    //                         radius: 30,
                    //                         child: Center(
                    //                           child: Image.network(
                    //                             y[i]['foto'] != null
                    //                                 ? y[i]['foto']
                    //                                 : 'http://siplah.mascitra.co.id/assets/images/user.ico',
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       Container(
                    //                         child: Column(
                    //                           children: <Widget>[
                    //                             Column(children: <Widget>[
                    //                               Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.all(4.0),
                    //                                 child: Text(y[i]['nama']),
                    //                               ),
                    //                             ]),
                    //                             Column(children: <Widget>[
                    //                               Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.all(4.0),
                    //                                 child: Text(
                    //                                     y[i]['kabupaten_nama']),
                    //                               ),
                    //                             ])
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 //low
                    //               ],
                    //             );
                    //           }),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           border: Border.all(width: 1, color: Colors.black12)),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     Container(
                    //       height: 80,
                    //       width: MediaQuery.of(context).size.width,
                    //       child: ListView.builder(
                    //           physics: NeverScrollableScrollPhysics(),
                    //           itemCount: data.length,
                    //           itemBuilder: (context, i) {
                    //             final y = data[i]['mitra'];

                    //             return Column(
                    //               children: <Widget>[
                    //                 Row(
                    //                   children: <Widget>[
                    //                     Text(y[i]['no_invoice'] == null
                    //                         ? "No. Invoice :"
                    //                         : "No. Invoice : " +
                    //                             y[i]['no_invoice']),
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   children: <Widget>[
                    //                     Text(y[i]['purchase_order'] == null
                    //                         ? "Purchase Order :"
                    //                         : "Purchase Order : " +
                    //                             y[i]['purchase_order']),
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   children: <Widget>[
                    //                     Text(y[i]['marketing_kode'] == null
                    //                         ? "Kode Marketing :"
                    //                         : "Kode Marketing : " +
                    //                             y[i]['marketing_kode']),
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   children: <Widget>[
                    //                     Text(y[i]['marketing_nama'] == null
                    //                         ? "Nama Marketing : "
                    //                         : "Nama Marketing : " +
                    //                             y[i]['marketing_nama']),
                    //                   ],
                    //                 ),
                    //               ],
                    //             );
                    //           }),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           border: Border.all(width: 1, color: Colors.black12)),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     Container(
                    //       height: 50,
                    //       width: MediaQuery.of(context).size.width,
                    //       child: ListView(
                    //         scrollDirection: Axis.horizontal,
                    //         children: <Widget>[
                    //           SizedBox(
                    //             width: 2,
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text("No."),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text("Foto"),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text("Nama"),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text("Deskripsi"),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text("Jumlah"),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text("Harga"),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(10.0),
                    //             child: Text("Nego"),
                    //           ),
                    //           Container(
                    //             width: MediaQuery.of(context).size.width / 5,
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(10.0),
                    //               child: Text("Sub. Total Bayar"),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           border: Border.all(width: 1, color: Colors.black12)),
                    //     ),
                    //     Container(
                    //       height: 300 * o.toDouble(),
                    //       child: ListView.builder(
                    //           physics: NeverScrollableScrollPhysics(),
                    //           itemCount: produk.length,
                    //           itemBuilder: (context, i) {
                    //             int a = i;
                    //             a++;
                    //             int jumlah = int.parse(produk[i]['jumlah']);
                    //             int harga = int.parse(produk[i]['harga']);

                    //             int sub = jumlah * harga;
                    //             return Card(
                    //               child: Row(
                    //                 children: <Widget>[
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(child: Text(a.toString())),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                         width: 40,
                    //                         height: 40,
                    //                         child: Image.network(produk[i]
                    //                                     ['foto'] !=
                    //                                 null
                    //                             ? produk[i]['foto']
                    //                             : 'http://siplah.mascitra.co.id/assets/images/user.ico')),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                         width:
                    //                             MediaQuery.of(context).size.width /
                    //                                 13,
                    //                         child: Text(produk[i]['nama'])),
                    //                   ),
                    //                   Padding(
                    //                       padding: const EdgeInsets.all(8.0),
                    //                       child: Container(
                    //                         width:
                    //                             MediaQuery.of(context).size.width /
                    //                                 7,
                    //                         child: Html(
                    //                           data: produk[i]['deskripsi'],
                    //                           //Optional parameters:
                    //                           onLinkTap: (url) {
                    //                             print("Opening $url...");
                    //                           },
                    //                           customRender: (node, children) {
                    //                             if (node is dom.Element) {
                    //                               switch (node.localName) {
                    //                                 case "custom_tag":
                    //                                   return Column(
                    //                                       children: children);
                    //                               }
                    //                             }
                    //                           },
                    //                         ), //Text(produk[i]['deskripsi'])),
                    //                       )),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                         width:
                    //                             MediaQuery.of(context).size.width /
                    //                                 20,
                    //                         child: Text(produk[i]['jumlah'])),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                         width:
                    //                             MediaQuery.of(context).size.width /
                    //                                 10,
                    //                         child: Text(produk[i]['harga'])),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                         width:
                    //                             MediaQuery.of(context).size.width /
                    //                                 7,
                    //                         child: produk[i]['nego'] != '1'
                    //                             ? RaisedButton(
                    //                                 color: Colors.blueGrey,
                    //                                 onPressed: () {},
                    //                                 child: Text(
                    //                                   "NEGO",
                    //                                   style: TextStyle(
                    //                                       color: Colors.white,
                    //                                       fontSize: 10),
                    //                                 ),
                    //                               )
                    //                             : RaisedButton(
                    //                                 color: Colors.blue,
                    //                                 onPressed: () {
                    //                                   shownego();
                    //                                 },
                    //                                 child: Text("NEGO",
                    //                                     style: TextStyle(
                    //                                         color: Colors.white,
                    //                                         fontSize: 10)),
                    //                               )),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                         width:
                    //                             MediaQuery.of(context).size.width /
                    //                                 10,
                    //                         child: Text(sub.toString())),
                    //                   )
                    //                 ],
                    //               ),
                    //             );

                    //           }),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           border: Border.all(width: 1, color: Colors.black12)),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     Container(
                    //       height: 50,
                    //       child: ListView.builder(
                    //           physics: NeverScrollableScrollPhysics(),
                    //           itemCount: 1,
                    //           itemBuilder: (context, i) {
                    //             return Row(
                    //               children: <Widget>[
                    //                 Text(
                    //                     mitra[0]['kurir_kode'] == null
                    //                         ? "Ongkir (Internal)"
                    //                         : "Ongkir (" +
                    //                             mitra[0]['kurir_kode'] +
                    //                             ")",
                    //                     style: TextStyle(
                    //                         color: Colors.red,
                    //                         fontWeight: FontWeight.bold))
                    //               ],
                    //             );
                    //           }),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           border: Border.all(width: 1, color: Colors.black12)),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     Container(
                    //       height: 300,
                    //       child: ListView.builder(
                    //           physics: NeverScrollableScrollPhysics(),
                    //           itemCount: 1,
                    //           itemBuilder: (context, i) {
                    //             int total = int.parse(data[0]['total']);
                    //             int kurir = int.parse(mitra[0]['kurir_ongkir']);
                    //             int bayar = total - kurir;
                    //             return Column(
                    //               children: <Widget>[
                    //                 Container(
                    //                     child: Row(
                    //                   children: <Widget>[
                    //                     Padding(
                    //                       padding: const EdgeInsets.all(8.0),
                    //                       child: Icon(Icons.location_on,
                    //                           color: Colors.black87),
                    //                     ),
                    //                     Container(
                    //                       width: MediaQuery.of(context).size.width /
                    //                           1.5,
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.all(8.0),
                    //                         child: Text(mitra[0][
                    //                                     'alamat_pengiriman_alamat'] ==
                    //                                 null
                    //                             ? ""
                    //                             : mitra[0]
                    //                                 ['alamat_pengiriman_alamat']),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 )),
                    //                 Row(
                    //                   children: <Widget>[
                    //                     Container(
                    //                         child: Container(
                    //                       child: Column(children: <Widget>[
                    //                         Text("Harga Asli"),
                    //                         Column(
                    //                           children: <Widget>[
                    //                             Container(
                    //                               height: 40,
                    //                               decoration: BoxDecoration(
                    //                                   border: Border.all(
                    //                                       width: 1,
                    //                                       color: Colors.black12)),
                    //                               child: Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.all(8.0),
                    //                                 child: Column(
                    //                                   children: <Widget>[
                    //                                     Text("Rp " +
                    //                                         formatter.format(
                    //                                             int.parse(mitra[0][
                    //                                                 'kurir_ongkir']))),
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         )
                    //                       ]),
                    //                     )),
                    //                   ],
                    //                 ),
                    //                 SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 Row(
                    //                   children: <Widget>[
                    //                     Container(
                    //                         child: Container(
                    //                       child: Column(children: <Widget>[
                    //                         Text("Jumlah Harga"),
                    //                         Column(
                    //                           children: <Widget>[
                    //                             Container(
                    //                               height: 40,
                    //                               decoration: BoxDecoration(
                    //                                   border: Border.all(
                    //                                       width: 1,
                    //                                       color: Colors.black12)),
                    //                               child: Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.all(8.0),
                    //                                 child: Column(
                    //                                   children: <Widget>[
                    //                                     Text("Rp " +
                    //                                         formatter
                    //                                             .format(bayar)),
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         )
                    //                       ]),
                    //                     )),
                    //                   ],
                    //                 ),
                    //                 SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 Row(
                    //                   children: <Widget>[
                    //                     Padding(
                    //                         padding: const EdgeInsets.all(2.0),
                    //                         child: mitra[i]['status_nama'] ==
                    //                                 "Selesai"
                    //                             ? Container(
                    //                                 decoration: BoxDecoration(
                    //                                     color: Colors.green),
                    //                                 child: Text(
                    //                                   mitra[i]['status_nama'] ==
                    //                                           null
                    //                                       ? "kosong"
                    //                                       : mitra[i]['status_nama'],
                    //                                   style: TextStyle(
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       color: Colors.white),
                    //                                 ))
                    //                             : mitra[i]['status_nama'] == "Diproses"
                    //                                 ? Container(
                    //                                     decoration: BoxDecoration(
                    //                                         color: Colors.blue),
                    //                                     child: Text(
                    //                                         mitra[i]['status_nama'] == null
                    //                                             ? "kosong"
                    //                                             : mitra[i]
                    //                                                 ['status_nama'],
                    //                                         style: TextStyle(
                    //                                             fontWeight:
                    //                                                 FontWeight.bold,
                    //                                             color:
                    //                                                 Colors.white)))
                    //                                 : mitra[i]['status_nama'] == "Dikirim"
                    //                                     ? Container(
                    //                                         decoration:
                    //                                             BoxDecoration(color: Colors.yellowAccent),
                    //                                         child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)))
                    //                                     : mitra[i]['status_nama'] == "Diterima" ? Container(decoration: BoxDecoration(color: Colors.green[300]), child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))) : Container(decoration: BoxDecoration(color: Colors.red), child: Text(mitra[i]['status_nama'] == null ? "kosong" : mitra[i]['status_nama'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                    //                   ],
                    //                 ),
                    //                 SizedBox(
                    //                   height: 5,
                    //                 ),
                    //                 Row(
                    //                   children: <Widget>[
                    //                     Container(
                    //                         height: 25,
                    //                         child: Text(mitra[0]['updated_at']))
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   children: <Widget>[
                    //                     mitra[i]['status_nama'] == "Ditolak"
                    //                         ? Container()
                    //                         : mitra[i]['status_nama'] == "Dikirim"
                    //                             ? Container(
                    //                                 child: Row(
                    //                                   children: <Widget>[
                    //                                     RaisedButton(
                    //                                       color: Colors.blue,
                    //                                       onPressed: () {
                    //                                         _showAlertuploadbast(
                    //                                             context);
                    //                                       },
                    //                                       child: Text(
                    //                                           "Upload Bukti Bast"),
                    //                                     ),
                    //                                     SizedBox(
                    //                                       width: 10,
                    //                                     ),

                    //                                     SizedBox(
                    //                                       width: 10,
                    //                                     ),
                    //                                     // RaisedButton(
                    //                                     //     color: Colors.yellow,
                    //                                     //   onPressed: () {},
                    //                                     //   child: Text("Purchase Order"),
                    //                                     // ),
                    //                                   ],
                    //                                 ),
                    //                               )
                    //                             : mitra[i]['status_nama'] ==
                    //                                     "Menunggu diprosess"
                    //                                 ? Container()
                    //                                 : Container(
                    //                                     child: Row(
                    //                                       children: <Widget>[
                    //                                         RaisedButton(
                    //                                           color: Colors.blue,
                    //                                           onPressed: () {
                    //                                             _showAlertuploadphoto(
                    //                                                 context);
                    //                                           },
                    //                                           child: Text(
                    //                                               "Upload Bukti Pembayaran"),
                    //                                         ),
                    //                                         SizedBox(
                    //                                           width: 10,
                    //                                         ),
                    //                                         widget.databank==null?
                    //                                         RaisedButton(
                    //                                           color: Colors.green,
                    //                                           onPressed: (){
                    //                                             Navigator.push(
                    //                                                 context,
                    //                                                 MaterialPageRoute(
                    //                                                   builder: (BuildContext
                    //                                                           context) =>
                    //                                                       MetodeNew(iddetail: widget.iddetail,),
                    //                                                 ));
                    //                                           },
                    //                                           child: Text("Bayar"),
                    //                                         ):
                    //                                         RaisedButton(
                    //                                           color: Colors.green,
                    //                                           onPressed: (){
                    //                                             print(nama);
                    //                                             bayarapi();
                    //                                           },
                    //                                           child: Text("Bayar"),
                    //                                         ),

                    //                                         SizedBox(
                    //                                           width: 10,
                    //                                         ),

                    //                                       ],
                    //                                     ),
                    //                                   )
                    //                   ],
                    //                 )
                    //               ],
                    //             );
                    //           }),
                    //     )
                    //   ],
                    // )
                  ]));
  }
}
