import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/bloc/provinsi_bloc.dart';

import 'package:siplah_jpmall/src/bloc/kabupaten_bloc.dart';
import 'package:siplah_jpmall/src/bloc/kecamatan_bloc.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';

import 'package:siplah_jpmall/src/models/kabupaten_model.dart';
import 'package:siplah_jpmall/src/models/kecamatan_model.dart';
import 'package:siplah_jpmall/src/models/provinsi_model.dart';

import 'login.dart';

class TambahCabang extends StatefulWidget {
  @override
  _TambahCabangState createState() => _TambahCabangState();
}

class _TambahCabangState extends State<TambahCabang> {
  Future<http.Response> _delete(String id) async {
    //a=a+id;
    print(id);
    var url = 'http://siplah.mascitra.co.id/api/mitra/cabang/delete';

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

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
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
              content: Text("Data berhasil diubah"),
            ));
  }

  //end
//controller
  final namacab = TextEditingController();
  final namapenanggung = TextEditingController();
  final email = TextEditingController();
  final telpn = TextEditingController();
  final provinsi = TextEditingController();
  final kabupaten = TextEditingController();
  final alamatleng = TextEditingController();
  final password = TextEditingController();
  final konfirmasipass = TextEditingController();
  final logo = TextEditingController();
  //edit
  Future<http.Response> _edit(String idx,nama) async {
    
   provinceBloc.provinceFetchAll();
  
      var placeholder = ['Loading...', 'Loading...', 'Loading...'];
  String prop, kab, kec;
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

  Position _currentPosition;
  //getlocation
  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      //print(e);
    });
    }
      _getCurrentLocation();

  

  //
  
  Future<http.Response> daftar_api() async {
    
    var url = 'http://siplah.mascitra.co.id/api/mitra/cabang/update';

    Map data = {
      'id': idx,
      'user_id':nama,
      'nama': namacab.text,
      'nama_penanggung_jawab': namapenanggung.text,
      'telepon': telpn.text,
      'email': email.text,
      'password': password.text,
      'password_konfirmasi': konfirmasipass.text,
      'provinsi_id': prop,
      'kabupaten_id': kab,
      'kecamatan_id': kec,
      'alamat': alamatleng.text,
      'foto':
          _imageFile != null ? base64Encode(_imageFile.readAsBytesSync()) : '',
      'latitude': "${_currentPosition.latitude}",
      'longitude': "${_currentPosition.longitude}",
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
    print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
    }
    return response;
  }
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
              title: Text("Edit Cabang"),
              content: ListView(scrollDirection: Axis.vertical,
                children:<Widget>[
              Column(
                children:<Widget>[
              TextField(
                controller: namacab,
              decoration: InputDecoration(hintText: "Nama Cabang"),
              ),
               TextField(
                controller: namapenanggung,
              decoration: InputDecoration(hintText: "Nama Penanggung Jawab"),
              ),
               TextField(
                controller: telpn,
              decoration: InputDecoration(hintText: "No - Telepon"),
              ),
               TextField(
                controller: email,
              decoration: InputDecoration(hintText: "Email"),
              ),
               TextField(
                controller: password,
              decoration: InputDecoration(hintText: "Password"),
              ),
               TextField(
                controller: konfirmasipass,
              decoration: InputDecoration(hintText: "Konfirmasi Password"),
              ),
               CustomTile(
                "Provinsi",
                child: StreamBuilder<Province>(
                            stream: provinceBloc.allProvince,
                            builder: (context, snapshot) {
                              return DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                value: prop,
                                isExpanded: true,
                                items: List.generate(
                                    snapshot.hasData
                                        ? snapshot.data.data.length
                                        : placeholder.length,
                                    (i) => DropdownMenuItem(
                                          child: Text(snapshot.hasData
                                              ? snapshot.data.data[i].nama
                                              : placeholder[i]),
                                          value: snapshot.hasData
                                              ? snapshot.data.data[i].id
                                              : placeholder[i],
                                        )),
                                onChanged: (item) {
                                  setState(() {
                                    if (item == null) {
                                    } else {
                                      prop = item;
                                    }
                                  });
                                  kabupatenBloc.fetchKabupaten(prop);
                                },
                              ));
                            }),
                      ),
                     CustomTile(
                        "Kabupaten/Kota",
                        child: StreamBuilder<Kabupaten>(
                            stream: kabupatenBloc.allKabupaten,
                            builder: (context, snapshot) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: kab,
                                  isExpanded: true,
                                  items: List.generate(
                                      snapshot.hasData
                                          ? snapshot.data.data.length
                                          : placeholder.length,
                                      (i) => DropdownMenuItem(
                                            child: Text(snapshot.hasData
                                                ? snapshot.data.data[i].nama
                                                : placeholder[i]),
                                            value: snapshot.hasData
                                                ? snapshot.data.data[i].id
                                                : placeholder[i],
                                          )),
                                  onChanged: (item) {
                                    setState(() {
                                      kab = item;
                                    });
                                    kecamatanBloc.fetchKecamatan(kab);
                                  },
                                ),
                              );
                            }),
                      ),
                                      CustomTile(
                      "Kecamatan",
                      child: StreamBuilder<Kecamatan>(
                          stream: kecamatanBloc.allKecamatan,
                          builder: (context, snapshot) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: kec,
                                isExpanded: true,
                                items: List.generate(
                                    snapshot.hasData
                                        ? snapshot.data.data.length
                                        : placeholder.length,
                                    (i) => DropdownMenuItem(
                                          child: Text(snapshot.hasData
                                              ? snapshot.data.data[i].nama
                                              : placeholder[i]),
                                          value: snapshot.hasData
                                              ? snapshot.data.data[i].id
                                              : placeholder[i],
                                        )),
                                onChanged: (item) {
                                  setState(() {
                                    kec = item;
                                  });
                                },
                              ),
                            );
                          }),
                    ),
                    TextField(
      controller: alamatleng,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Alamat Lengkap Penerima",
      ),
    ),
                ])]),
                actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                 daftar_api();
                },
              ),
              RaisedButton(
      onPressed: () {
        _showAlertupload(context);
      },
      child: Text(
        "Choose Picture".toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
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

        Uri.encodeFull('http://siplah.mascitra.co.id/api/mitra/cabang/list'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
          //"id": "" + nama
        });
    print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
       namacab.text= data[0]['nama'];
      namapenanggung.text=data[0]['nama_penanggung_jawab'];
 email.text=data[0]['email'];
 telpn.text=data[0]['telepon'];
  alamatleng.text=data[0]['alamat'];
  

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
 
    //print(data);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add_box,
                color: Colors.white,
              ),
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CabangADD(),
                        )),
                  }),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Cabang Mitra", style: TextStyle(color: Colors.white)),
      ),
      body: 

          data==null?Container():Container(
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
                  height: 150,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(data[i]['nama']),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          data[i]['nama_penanggung_jawab']),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(data[i]['telepon'],
                                          textAlign: TextAlign.left),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(data[i]['nama_provinsi']),
                                    )
                                  ],
                                ),
                                //Text(data[i]['kecamatan_nama']),
                                // Column(
                                //   children: <Widget>[
                                //     Align(
                                //       alignment: Alignment.topLeft,
                                //       child: Text(data[i]['kode_pos']),
                                //     )
                                //   ],
                                // )
                              ]),
                          Row(children: <Widget>[
                            Flexible(fit: FlexFit.tight, child: SizedBox()),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      _delete(data[i]['id']);
                                    },
                                  ),
                                )),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      _edit(data[i]['id'],nama);
                                    },
                                  ),
                                )),
                          ]),
                        ]),
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

class CabangADD extends StatefulWidget {
  @override
  _CabangADD createState() => _CabangADD();
}

class _CabangADD extends State<CabangADD> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String id;
  bool _isFieldNameValid;
  var placeholder = ['Loading...', 'Loading...', 'Loading...'];
  String prop, kab, kec;
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
//end class upload

//alert upload
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

  Position _currentPosition;
  //getlocation
  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      //print(e);
    });
  }

  //controller
  final namacab = TextEditingController();
  final namapenanggung = TextEditingController();
  final email = TextEditingController();
  final telpn = TextEditingController();
  final provinsi = TextEditingController();
  final kabupaten = TextEditingController();
  final alamatleng = TextEditingController();
  final password = TextEditingController();
  final konfirmasipass = TextEditingController();
  final logo = TextEditingController();
  final kodepos = TextEditingController();

  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
    });
    //print("id profile = "+id);
  }

  @override
  void initState() {
    super.initState();
    getCredential();
    provinceBloc.provinceFetchAll(); 
    _getCurrentLocation();
  }

  Future<http.Response> daftar_api() async {
    var url = 'http://siplah.mascitra.co.id/api/mitra/cabang/add';

    Map data = {
      'cabang_user_id': id,
      'user_id': id,
      'nama': namacab.text,
      'nama_penanggung_jawab': namapenanggung.text,
      'telepon': telpn.text,
      'email': email.text,
      'password': password.text,
      'kodepos': kodepos.text,
      'password_konfirmasi': konfirmasipass.text,
      'provinsi_id': prop,
      'kabupaten_id': kab,
      'kecamatan_id': kec,
      'alamat': alamatleng.text,
      'foto':
          _imageFile != null ? base64Encode(_imageFile.readAsBytesSync()) : '',
      'latitude': "${_currentPosition.latitude}",
      'longitude': "${_currentPosition.longitude}",
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
    print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
    }
    return response;
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Maaf anda gagal"),
            ));
  }

  void _berhasil(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Success"),
              content: Text("Cabang telah berhasil ditambahkan"),
            ));
  }

  @override
  Widget build(BuildContext context) {
   
    //print("id= "+id);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Tambah Cabang", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextNamaCab(),
                  _buildTextNamaPenn(),
                  _buildTextNomorTelpon(),
                  _buildTextEmail(),
                  _buildTextKodePos(),
                  _buildTextPassword(),
                  _buildTextKonfirmasi(),
                  _buildTextFieldProvinsi(),
                  _buildTextFieldKabupaten(),
                  _buildTextFieldKecamatan(),
                  _buildTextAlamat(),
                  _buildTextFieldFotoChoose(),
                  _buildBtnSubmit(),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldFotoChoose() {
    return RaisedButton(
      onPressed: () {
        _showAlertupload(context);
      },
      child: Text(
        "Choose Picture".toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTextNamaCab() {
    return TextField(
      controller: namacab,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Cabang",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Cabang harus diisi",
      ),
    );
  }

  Widget _buildTextKodePos() {
    return TextField(
      controller: kodepos,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Kode Pos",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Kode Pos harus diisi",
      ),
    );
  }

  Widget _buildTextNamaPenn() {
    return TextField(
      controller: namapenanggung,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Penanggung Jawab",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Penanggung Jawab harus diisi",
      ),
    );
  }

  Widget _buildTextNomorTelpon() {
    return TextField(
      controller: telpn,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Nomor Telpon Penanggung Jawab",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nomor Telepon Penanggung Jawab harus diisi",
      ),
    );
  }

  Widget _buildTextEmail() {
    return TextField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Email harus diisi",
      ),
    );
  }

  Widget _buildTextPassword() {
    return TextField(
      controller: password,
      keyboardType: TextInputType.emailAddress,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Password harus diisi",
      ),
    );
  }

  Widget _buildTextKonfirmasi() {
    return TextField(
      controller: konfirmasipass,
      keyboardType: TextInputType.emailAddress,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: "Konfirmasi Password",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Konfirmasi Password harus diisi",
      ),
    );
  }

  Widget _buildTextFieldProvinsi() {
    SizedBox(
      height: 10,
    );
    return CustomTile(
      "Provinsi",
      child: StreamBuilder<Province>(
          stream: provinceBloc.allProvince,
          builder: (context, snapshot) {
            return DropdownButtonHideUnderline(
                child: DropdownButton(
              value: prop,
              isExpanded: true,
              items: List.generate(
                  snapshot.hasData
                      ? snapshot.data.data.length
                      : placeholder.length,
                  (i) => DropdownMenuItem(
                        child: Text(snapshot.hasData
                            ? snapshot.data.data[i].nama
                            : placeholder[i]),
                        value: snapshot.hasData
                            ? snapshot.data.data[i].id
                            : placeholder[i],
                      )),
              onChanged: (item) {
                setState(() {
                  if (item == null) {
                  } else {
                    prop = item;
                  }
                });
                kabupatenBloc.fetchKabupaten(prop);
              },
            ));
          }),
    );
  }

  Widget _buildTextFieldKabupaten() {
    return CustomTile(
      "Kabupaten/Kota",
      child: StreamBuilder<Kabupaten>(
          stream: kabupatenBloc.allKabupaten,
          builder: (context, snapshot) {
            return DropdownButtonHideUnderline(
              child: DropdownButton(
                value: kab,
                isExpanded: true,
                items: List.generate(
                    snapshot.hasData
                        ? snapshot.data.data.length
                        : placeholder.length,
                    (i) => DropdownMenuItem(
                          child: Text(snapshot.hasData
                              ? snapshot.data.data[i].nama
                              : placeholder[i]),
                          value: snapshot.hasData
                              ? snapshot.data.data[i].id
                              : placeholder[i],
                        )),
                onChanged: (item) {
                  setState(() {
                    kab = item;
                  });
                  kecamatanBloc.fetchKecamatan(kab);
                },
              ),
            );
          }),
    );
  }

  Widget _buildTextFieldKecamatan() {
    return CustomTile(
      "Kecamatan",
      child: StreamBuilder<Kecamatan>(
          stream: kecamatanBloc.allKecamatan,
          builder: (context, snapshot) {
            return DropdownButtonHideUnderline(
              child: DropdownButton(
                value: kec,
                isExpanded: true,
                items: List.generate(
                    snapshot.hasData
                        ? snapshot.data.data.length
                        : placeholder.length,
                    (i) => DropdownMenuItem(
                          child: Text(snapshot.hasData
                              ? snapshot.data.data[i].nama
                              : placeholder[i]),
                          value: snapshot.hasData
                              ? snapshot.data.data[i].id
                              : placeholder[i],
                        )),
                onChanged: (item) {
                  setState(() {
                    kec = item;
                  });
                },
              ),
            );
          }),
    );
  }

  Widget _buildTextAlamat() {
    return TextField(
      controller: alamatleng,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Alamat Lengkap Penerima",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Alamat Lengkap Penerima harus diisi",
      ),
    );
  }

  Widget _buildBtnSubmit() {
    return RaisedButton(
      onPressed: () {
        daftar_api();
      },
      child: Text("Submit".toUpperCase()),
      color: Colors.blue,
    );
  }
}
