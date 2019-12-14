import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Penjualan extends StatefulWidget{
  @override
  _PenjualanState createState() =>_PenjualanState();

}
class _PenjualanState extends State<Penjualan>{

  String nama;
  List data,data2;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/api/mitra/penjualan/tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
        },
        body: {
          "user_id": "" + nama,
          //"id": "" + nama
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
    getCredential();
    getJsonData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
          title:
              Text("Penjualan", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, i){
          return Column(
            children:<Widget>[
          Card(
             
              
            child:Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data[i]['no_invoice']==null?"kosong":data[i]['no_invoice']),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data[i]['user_nama']==null?"kosong":"( "+data[i]['user_nama']+" )"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data[i]['tanggal']==null?"kosong":data[i]['tanggal']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data[i]['status_nama']==null?"kosong":data[i]['status_nama']),
            ),
            ],)
          
          ),
          Card(
          child:Row(
            children: <Widget>[
              //Text(data2[i]['id']==null?"kosong":data2[i]['id'])
            ],
          ))
            ]);
        }

      ),
    );
  }

}