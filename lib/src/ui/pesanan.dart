import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
          "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
        },
        body: {
          "user_id": "" + nama,
        });
    print(response.body);
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
    });
    //print("id o= " + nama);
  }

  int no = 0;

  @override
  Widget build(BuildContext context) {
    getCredential();
    getJsonData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Pesanan", style: TextStyle(color: Colors.white)),
      ),
      body: data==null?Container():ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: Card(
                child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("No"),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Order ID"),
                ),
                SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Total"),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tanggal"),
                ),
                SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Status"),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Opsi"),
                )
              ],
            )),
          ),
          ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Container(
                    child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$i"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['order_id']),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['total']),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['tanggal']),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['status_nama']),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ));
              })
        ],
      ),
    );
  }
}
