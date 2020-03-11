import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';

class  KomplainSekolah extends StatefulWidget{
  @override
  _KomplainState createState() => _KomplainState();
  
  
}

class _KomplainState extends State<KomplainSekolah>{
  
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
              content: Text("Data berhasil diubah"),
            ));
  }


  //edit
  Future<http.Response> _edit(String idx,nama,mitra,po,no) async {

  //beginkoment
  List datakomen;
  Future<String> getKomendata() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/komplain/pesan'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          'transaksi_id': idx,
      'user_id':nama,
      'mitra_id': mitra,
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datakomen = convertDataToJson['Data'];
    });
  }
  getKomendata();
  //end
  
    
  List data2;
  
  

  File _imageFile;
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

  //controller
  final pesan = TextEditingController();

  final logo = TextEditingController();
  

  //
  
  Future<http.Response> daftar_api() async {
    
    var url = 'http://siplah.mascitra.co.id/api/sekolah/komplain/tambah';

    Map data = {
      'transaksi_id': idx,
      'user_id':nama,
      'mitra_id': mitra,
      'pesan': pesan.text,
     
      'foto':
          _imageFile != null ? base64Encode(_imageFile.readAsBytesSync()) : '',
      
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

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    //print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
    }
    return response;
  }
  //   Future<String> getJsonData() async {
  //   var response = await http.post(
  //     //Encode the url
  //     Uri.encodeFull('http://siplah.mascitra.co.id/api/mitra/cabang/list'),
  //     headers: {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       "API-App": "siplah_jpmall.id",
  //       "Api-Key": "4P1_7Pm411_51p114h",
  //       "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
  //     },
  //     body: {
  //       "user_id": "" + iduser,
  //     },
  //   );
  //   //print(response.body);
  //   setState(() {
  //     // ignore: deprecated_member_use
  //     var convertDataToJson = json.decode(response.body);
  //     data = convertDataToJson['data'];
  //     loading = 1;
  //     //print(data.length);
  //   });
  // }
 void _showAlertupload(BuildContext context) {
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
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Komplain"),
              content: Container(
                height: 400,
                
                child: Column(
                   
                  children:<Widget>[
                TextField(

                decoration: InputDecoration(hintText: ""+no==null?"No. Invoice : -":"No. Invoice : "+no),
                enabled: false,
                ),
                 TextField(
                decoration: InputDecoration(hintText: ""+po==null?"Purchase Order : -":"Purchase Order : "+po),
                enabled: false,
                ),
                // ListView.builder(
                //   itemCount: 2,
                //   itemBuilder: (context,i){
                //     return Container(
                //       child:Column(children: <Widget>[

                //       ],)
                //     );
                //   }
                // ),
                 TextField(
                  controller: pesan,
                decoration: InputDecoration(hintText: "Pesan"),
                ),
             
                  ]),
              ),
                actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                 daftar_api();
                },
              ),
             new  FlatButton(
      onPressed: () {
        _showAlertupload(context);
      },
      child: new Text(
        "Choose Picture".toUpperCase(),
        
        
      ),
    ),
            ],
                )
                );
  }


  //end
    String nama;
  List data;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/komplain/transaksi'),
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
      data = convertDataToJson['data'];
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

    RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
   @override
  void initState() {
    super.initState();  
    getCredential();
    
  }
  @override
  Widget build(BuildContext context) {
  
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Komplain", style: TextStyle(color: Colors.white)),
      ),  
      body:data==null?
      Center(child: Shimmer.fromColors(child: Text("Loading...", style: TextStyle(fontSize: 15),), baseColor: Colors.white, highlightColor: Colors.grey))
      : SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              // physics: ScrollPhysics(),
              // shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, i) {
                //print(data[0]['nama']);

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: SizedBox(
                      height: 107,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(children: <Widget>[
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data[i]['komplain_id']==null?"":data[i]['komplain_id']),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("No Invoice:           "+data[i]['no_invoice']),
                                        )
                                      ],
                                    ),
                                   
                                    Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child:
                                              Text(data[i]['purchase_order']),
                                        )
                                      ],
                                    ),
                                      
                                    
                              Row(children: <Widget>[
                                Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      child: IconButton(
                                        icon: Icon(
                                          CupertinoIcons.eye_solid,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          _edit(data[i]['id'],nama,data[i]['mitra_id'],data[i]['purchase_order'],data[i]['no_invoice']);
                                          print(data[i]['id']);
                                        },
                                      ),
                                    )),
                                
                              ]),
                            ]),
                            ])
                        )])
                      )),
                );
              },
            ),
          ),
        ));
    
  }

}