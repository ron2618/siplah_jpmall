import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:siplah_jpmall/src/models/get_token.dart';

class PesananState extends StatefulWidget {
  @override
  _PesananState createState() => _PesananState();
}

class _PesananState extends State<PesananState> {
  String nama;
  List data;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/api/sekolah/pesanan/tampil'),
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
          ? Column(
              children: <Widget>[Center(child: CircularProgressIndicator())])
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
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: IconButton(
                                icon: Icon(
                                  
                                  Icons.remove_red_eye,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  String iddetail;
                                  iddetail=data[i]['id'];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            DetailPesanan(iddetail:iddetail),
                                      ));
                                },
                              ),
                            ))),
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
                          child: Text(data[i]['status_nama'] == null
                              ? "kosong"
                              : data[i]['status_nama']),
                        ),
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
  final String iddetail;

  const DetailPesanan({Key key, this.iddetail}) : super(key: key);
  @override
  _DetailPesananState createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
     //getdetailpem
     
  final myController = TextEditingController();
  Future<String> getDetailpem(String order) async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/api/sekolah/pesanan/status'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
          "order_id":order
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      // var convertDataToJson = json.decode(response.body);
      // detail = convertDataToJson;
     Map<String, dynamic> map1 = json.decode(response.body);
     String payment_code =map1['payment_code'];
String store =map1['store'];
String transaction_time = map1['transaction_time'];
String gross_amount = map1['gross_amount'];
String currency = map1['currency'];
String order_id = map1['order_id'];
String payment_type = map1['payment_type'];
String signature_key = map1['signature_key'];
String status_code = map1['status_code'];
String transaction_id = map1['transaction_id'];
String transaction_status = map1['transaction_status'];
String status_message = map1['status_message'];
String merchant_id = map1['merchant_id'];
      _showAlertupload(context,payment_code,store,transaction_time,gross_amount,currency,order_id,payment_type,signature_key,status_code,transaction_id,transaction_status,status_message,merchant_id
);
   });
 
  }
//getjson
Future<String> tambahnego() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/api/sekolah/pesanan/nego_tambah'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "transaksi_produk_id": "9",
           "harga_nego" : myController.text,
           "user_id" : "1",
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      getNego();
    });
  }
  String idnego;
Future<String> setujui(String idvoid) async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/api/mitra/penjualan/nego_setuju'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
         
           "nego_id" :  idvoid,
           "user_id" : "4",
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
     
    });
  }
List negosiasi;
 Future<String> getNego() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/api/sekolah/pesanan/nego_tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "transaksi_produk_id": "9",
    
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      negosiasi = convertDataToJson['Data'];
   

    });
  }
int o;
 String nama;
  List data,produk,mitra;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/api/sekolah/pesanan/tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
          "id":""+widget.iddetail
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      mitra = convertDataToJson['Data'][0]['mitra'];
      produk = convertDataToJson['Data'][0]['mitra'][0]['produk'];
  o=produk.length.toInt();
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

  int no = 0;

  @override
  void initState() {
    super.initState();
    getCredential();
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
                width:  MediaQuery.of(context).size.width,
                child: ListView.builder(
                
                  itemCount: negosiasi.length,
                  itemBuilder: (context, i) {
                    int a = i+1;
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
                            Text(a.toString()+"."),
                            SizedBox(width: 10,),
                            Container(child: Text(negosiasi[i]['nego'] +" ") ),
                            SizedBox(width: 50,),
                           Column(
                              children: <Widget>[
                              negosiasi[i]['user_setuju'] == "1"  ?   Container(
                                  height: 30,
                                  width: 150,
                                  child: Center(child: Text("sekolah : Setuju",style: TextStyle(color: Colors.white),)),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                ):Container(
                                  height: 30,
                                  width: 150,
                                  child: Center(child: Text("sekolah : -",style: TextStyle(color: Colors.white),)),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                ),
                                SizedBox(height: 2,),
                                   negosiasi[i]['mitra_setuju'] == "1"  ? Container(
                                  height: 30,
                                  width: 150,
                                  child: Center(child: Text("mitra : setuju",style: TextStyle(color: Colors.white),)),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                ): GestureDetector( 
                                  onTap: (){
                                   
                                    setujui( negosiasi[i]['id']);
                                  },
                                      child:Container(
                                  height: 30,
                                  width: 150,
                                  child: Center(child: Text("mitra : -",style: TextStyle(color: Colors.white),)),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                ),)
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
                      keyboardType: TextInputType.number, // Use email input type for emails.
                      decoration: new InputDecoration(
                        hintText: '100000',
                        labelText: 'Nego Berapa'
                      ),),
               ),
                 SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
       tambahnego();
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
  void _showAlertupload(BuildContext context,String payment_code,String store,String transaction_time,String gross_amount,String currency,String order_id,String payment_type,String signature_key,String status_code,String transaction_id,String transaction_status,String status_message,String merchant_id
) {
  
   
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("Detail Pemesanan"),
                content: Container(
                    height: 600,
                    width: 600,
                    child: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Payment Code : "+payment_code),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Store : "+store),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Transaction Time : "+transaction_time),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Gross Amount : "+gross_amount),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Currency : "+currency),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Order Id : "+order_id),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Payment Type : "+payment_type),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width:  MediaQuery.of(context).size.width / 2,
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Signature key : "+signature_key),
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Status Code : "+status_code),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Transaction Id : "+transaction_id),
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Transaction Status : "+transaction_status),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Status Message : "+status_message),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Merchant Id : "+merchant_id),
                          )
                        ],
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Detail Pesanan", style: TextStyle(color: Colors.white)),
      ),
      body: data == null
          ? Column(
              children: <Widget>[Center(child: CircularProgressIndicator())])
          :produk==null?Column(
              children: <Widget>[Center(child: CircularProgressIndicator())]): ListView(
        children: <Widget>[
          
          Container(
            height: 100,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Row(
                    
                    children: <Widget>[
                      Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.10),
                          child: Text("Order Id"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data[i]['order_id']),
                        )
                      ]),
                      Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.15),
                          child: Text("Total Pembayaran"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data[i]['total']),
                        )
                      ]),
                      Row(children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            getDetailpem(data[i]['order_id']);
                            //_showAlertupload(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.15),
                            child: Text(
                              "Detail Pembayaran",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                    ],
                  );
                }),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
          ),
          SizedBox(
            height: 10,
          ),
          
          Container(
            height: 70,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final y=data[i]['mitra'];
                  return Row(
                    children: <Widget>[
                      //high
                      Container(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              child: Center(
                                child: Image.network(y[i]['foto']!=null?y[i]['foto']:
                                  'https://siplah.mascitra.co.id/assets/images/user.ico',
                                ),
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
                  final y=data[i]['mitra'];
                 
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("No. Invoice : "+y[i]['no_invoice']),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Purchase Order : "+y[i]['purchase_order']),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Kode Marketing : "+y[i]['marketing_kode']),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Nama Marketing : "+y[i]['marketing_nama']),
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
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("No."),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Foto"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Nama"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Deskripsi"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Jumlah"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Harga"),
                ),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Text("Nego"),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text("Sub. Total Bayar"),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12)),
          ),
          Container(
            height: 300*o.toDouble(),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: produk.length,
                itemBuilder: (context, i) {
                 
                  int a=i;
                  a++;
                   int jumlah=int.parse(produk[i]['jumlah']);
                  int harga=int.parse(produk[i]['harga']);
                
                  int sub = jumlah*harga;
                   return Container(
                     height: 100,
                     width: MediaQuery.of(context).size.width,
                     child: Card(
                       
                      child: ListView(
                        scrollDirection: Axis.horizontal,
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
                                child: Image.network(produk[i]['foto']!=null?produk[i]['foto']:
                                    'https://siplah.mascitra.co.id/assets/images/user.ico')),
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
          ),//Text(produk[i]['deskripsi'])),
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
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: (){
shownego();
                            },
                                                      child: Container(
                              width: 100,
                            
                              color: Colors.blueAccent,
                              child: Center(child: Text("NEGO",style: TextStyle(color: Colors.white),)),
                            ),
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width / 7,
                                child: Text(sub.toString())),
                          )
                        ],
                      ),
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
            height: 50,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Row(
                    children: <Widget>[Text("Ongkir ("+mitra[0]['kurir_kode']!=null?"":mitra[0]['kurir_kode'].toString()+")",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))],
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
                   int total=int.parse(data[0]['total']);
                  int kurir=int.parse(mitra[0]['kurir_ongkir']);
                  int bayar = total-kurir;
                  return Column(
                    children: <Widget>[
                      Container(
                          child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Icon(Icons.location_on, color: Colors.black87),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(mitra[0]['alamat_pengiriman_alamat']==null?"":mitra[0]['alamat_pengiriman_alamat']),
                          )
                        ],
                      )),
                      Row(
                        children: <Widget>[
                          Container(
                              child: Container(
                            child: Column(children: <Widget>[
                              Text("Harga Asli"),
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
                                          Text("Rp "+mitra[0]['kurir_ongkir']),
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
                              Text("Jumlah Harga"),
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
                                          Text("Rp "+bayar.toString()),
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
                              height: 25, child: Text(mitra[0]['status_nama']))
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
                      Row(children: <Widget>[
                        Container(child: Row(children: <Widget>[
                           RaisedButton(
                               color: Colors.blue,
                                onPressed: () {},
                                child: Text("BAST"),
                              ),
                              SizedBox(width: 10,),
                              RaisedButton(
                                  color: Colors.green,
                                onPressed: () {},
                                child: Text("Invoice"),
                              ),
                              SizedBox(width: 10,),
                              RaisedButton(
                                  color: Colors.yellow,
                                onPressed: () {},
                                child: Text("Purchase Order"),
                              ),
                        ],) ,)
                      ],)
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
