import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/model_mitra.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CabangMitra extends StatefulWidget {
  @override
  _CabangMitraState createState() => _CabangMitraState();
}

class _CabangMitraState extends State<CabangMitra> {
  int loading = 0;
  int _current = 0;
  List data;
  String id_user = null;
  Future<String> getJsonData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/mitra/cabang/list'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {"user_id": id_user},
    );
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
      loading = 1;
    });
  }

  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      id_user = pref.getString("id");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
      
      getCredential();
        getJsonData();
    
    //print('id user' + id_user);
    num currentPage = 0;
    return data==null?Container():Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Cabang Mitra",
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LihatCabang(),
                        )),
                  },
                  child: Container(
                    child: Text(
                      'Lihat Cabang',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            )),
        data==null?Container(): Container(
          height: 130,
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // physics: ScrollPhysics(),
            // shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, i) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(loading == 1 &&
                              data[i]['foto'] != null
                          ? data[i]['foto']
                          : ('http://siplah.mascitra.co.id/assets/images/no-image.png')),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LihatCabang extends StatefulWidget {
  @override
  _LihatCabang createState() => _LihatCabang();
}

class _LihatCabang extends State<LihatCabang> {
  int loading = 0;
  int _current = 0;
  List data;
  String iduser = null;
  Future<String> getJsonData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/mitra/cabang/list'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        "user_id": "" + iduser,
      },
    );
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
      loading = 1;
      //print(data.length);
    });
  }

  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      iduser = pref.getString("id");
       getJsonData();
      //print('iddalem=' + iduser);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredential();
   
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "List Cabang Mitra",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: data==null?Container():Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          // physics: ScrollPhysics(),
          // shrinkWrap: true,
          itemCount: data.length==null?0:data.length,
          itemBuilder: (context, i) {
            //print(data[0]['nama']);
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      CircleAvatar(
                        radius: 35,
                        child: Image.network(loading == 1 &&
                                data[i]['foto'] != null
                            ? data[i]['foto']
                            : ('http://siplah.mascitra.co.id/assets/images/user.ico')),
                      ),
                      //

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(data[i]['nama'])),
                      )
                    ]),
                  )),
            );
          },
        ),
      ),
    );
  }
}

class TokoList {
  final int index;
  final String nama;
  final String lokasi;
  final Color color;

  TokoList({this.index, this.nama, this.lokasi, this.color});
}

List<TokoList> _listToko = <TokoList>[
  TokoList(
      index: 1,
      nama:
          "http://jpmall.intern.mascitra.co.id/assets/images/icon/logo_saja.png",
      lokasi: "Jakarta",
      color: Colors.amber),
  TokoList(
      index: 2,
      nama:
          "http://ecs7.tokopedia.net/img/cache/215-square/shops-1/2019/2/12/5394723/5394723_fdb8279a-a94d-4683-8de5-019aabd91f30.jpg",
      lokasi: "Semarang",
      color: Colors.lightGreen),
  TokoList(
      index: 3,
      nama:
          "http://jpmall.intern.mascitra.co.id/assets/images/icon/gramedia.jpg",
      lokasi: "Surabaya",
      color: Colors.lime),
  TokoList(
      index: 3,
      nama: "http://upload.wikimedia.org/wikipedia/id/5/5b/Esis.jpg",
      lokasi: "Surabaya",
      color: Colors.lime),
];
