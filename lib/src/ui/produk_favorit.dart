import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';


class ProdukFavorit extends StatefulWidget{
  @override
  _ProdukFavoritState createState() => _ProdukFavoritState();

}
class _ProdukFavoritState extends State<ProdukFavorit>{
  Future<http.Response> _delete(String id) async {
    //a=a+id;
    print(id);
    var url =
        'http://siplah.mascitra.co.id/api/sekolah/produk_favorit/hapus';

    Map data = {'user_id': "" + nama, 'id': id};
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

     //print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    //print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _berhasil(context);
      ProdukFavorit();
    } else {
      // savedata();
     _showAlert(context);
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
              content: Text("Buku telah dihapus dari daftar favorit"),
            ));
            
  }
   String nama;
  List data, data2;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/produk_favorit/tampil'),
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
      data2 = convertDataToJson['Data'][0]['foto'];
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
  @override
  Widget build(BuildContext context) {
    double cwidth1= MediaQuery.of(context).size.width/3.5 ;
    double cwidth = MediaQuery.of(context).size.width/10 ;
      double c_width = MediaQuery.of(context).size.width * 0.2;
       double c_width2 = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(color: Colors.white),
        title: Text("Produk Favorit", style: TextStyle(color: Colors.white)),
      ),
      body: data==null?Container():data2==null?Container():ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i){
          int a;
          a=i+1;
          return Container(

            child: Column(children: <Widget>[
               Card(
                          child: Row(children: <Widget>[
                            Container(
                              width: cwidth,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("NO"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("$a"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(""),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "Gambar Produk",
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6.0),
                                  width: c_width,
                                  child: Image.network(data2[0]['foto']==null?'http://siplah.mascitra.co.id/assets/images/no-image.png':data2[0]['foto'])                                ),
                        
                        
                              ])),
                        ),
                        Container(
                           width: cwidth1,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("Nama Produk"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                  child:Container(
                                  padding: const EdgeInsets.all(6.0),
                                  width: c_width2,
                                  child: Text(data[i]['nama'] == null
                                    ? ""
                                    : data[i]['nama'])),
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
                                padding: const EdgeInsets.all(40.0),
                                child: Text(""),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(""),
                              ),
                              )
                            ],
                          ),
                        ),
                        Align(
                                              alignment: Alignment.centerRight,
                                              child:Container(
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
                                    Icons.delete,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    _delete(data[i]['id']);
                                  },
                                ),
                              )
                            ],
                          ),
                        )),
                      ])),
            ],),
          );
        }
      ),
    );
  }

} 