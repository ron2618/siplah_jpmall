import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/bloc/kabupaten_bloc.dart';
import 'package:siplah_jpmall/src/bloc/kecamatan_bloc.dart';
import 'package:siplah_jpmall/src/bloc/provinsi_bloc.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/kabupaten_model.dart';
import 'package:siplah_jpmall/src/models/kecamatan_model.dart';
import 'package:siplah_jpmall/src/models/provinsi_model.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class EditprofileSKL extends StatefulWidget {
  @override
  _EditprofileSKL createState() => _EditprofileSKL();
}

class _EditprofileSKL extends State<EditprofileSKL> {
  String foto, npsn, nama;
  List data;

  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull('http://siplah.mascitra.co.id/api/sekolah/profil/get'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "user_id": "" + nama,
          "id": "" + nama
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
      // foto = pref.getString("foto");
      // email = pref.getString("alamat");
      // alamat = pref.getString("telepon");
      // kodepos = pref.getString("kodepos");
      // telepon = pref.getString("telepon");
    });
    //print("id profile sklh= " + nama);
  }

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width / 2;

    //print(data);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),

        //CODE BARU YANG DITAMBAHKAN
        body: data == null
            ? Container()
            : ListView(padding: const EdgeInsets.all(0), children: <Widget>[
                Column(children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2.5,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(data[0]['logo_sekolah'] !=
                                null
                            ? data[0]['logo_sekolah']
                            : ('http://siplah.mascitra.co.id/assets/images/no-image.png')),
                        radius: 50,
                        // child: Center(
                        //   child: ,
                        //   child: Image.network(
                        //     data[0]['logo_sekolah'] != null
                        //         ? data[0]['logo_sekolah']
                        //         : ('http://siplah.mascitra.co.id/assets/images/no-image.png'),scale: 8,
                        //   ),
                        // ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ]),
                //set tambah
                Text(
                  " Nama Sekolah",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["nama_sekolah"] != null
                    ? " " + data[0]["nama_sekolah"]
                    : "Kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  " Alamat",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["alamat_sekolah"] != null
                    ? " " + data[0]["alamat_sekolah"]
                    : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  " NSPN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                    data[0]["npsn"] != null ? " " + data[0]["npsn"] : "kosong"),

                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  " NPWP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                    data[0]["npwp"] != null ? " " + data[0]["npwp"] : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  " Email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["email"] != null
                    ? " " + data[0]["email"]
                    : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  " Telepon Kantor",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["no_hp"] != null
                    ? " " + data[0]["no_hp"]
                    : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  " Nomor Hp",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["no_hp"] != null
                    ? " " + data[0]["no_hp"]
                    : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  " Nama Kepala Sekolah",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["kepala_sekolah_nama"] != null
                    ? " " + data[0]["kepala_sekolah_nama"]
                    : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  " NIP Kepala Sekolah",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["kepala_sekolah_nip"] != null
                    ? " " + data[0]["kepala_sekolah_nip"]
                    : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  " Nama Bendahara",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["bendahara_nama"] != null
                    ? " " + data[0]["bendahara_nama"]
                    : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  " NIP Bendahara",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(data[0]["bendahara_nip"] != null
                    ? " " + data[0]["bendahara_nip"]
                    : "kosong"),
                Divider(
                  height: 4,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),

                //set akhir

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(
                //       children: <Widget>[Text("Nama Sekolah",style: TextStyle(fontWeight: FontWeight.bold), )],
                //     ),
                //     SizedBox(
                //       width: 50,
                //     ),
                //     Row(
                //       children: <Widget>[
                //         Text(data[0]["nama_sekolah"] != null
                //             ? ": " + data[0]["nama_sekolah"]
                //             : "Kosong"),
                //       ],
                //     ),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(
                //       children: <Widget>[Text("Alamat",style: TextStyle(fontWeight: FontWeight.bold),)],
                //     ),
                //     SizedBox(
                //       width: 80,
                //     ),
                //     Container(
                //         padding: const EdgeInsets.all(8.0),
                //         width: c_width,
                //         child: new Column(children: <Widget>[
                //           Column(
                //             children:<Widget>[
                //           Text(data[0]["alamat_sekolah"] != null
                //               ? ": " + data[0]["alamat_sekolah"]
                //               : "kosong"),
                //             ])
                //         ])),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(children: <Widget>[Text("NSPN",style: TextStyle(fontWeight: FontWeight.bold),)]),
                //     SizedBox(
                //       width: 105,
                //     ),
                //     Row(
                //       children: <Widget>[
                //         Text(data[0]["npsn"] != null
                //             ? ": " + data[0]["npsn"]
                //             : "kosong"),
                //       ],
                //     ),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(children: <Widget>[Text("NPWP",style: TextStyle(fontWeight: FontWeight.bold),)]),
                //     SizedBox(
                //       width: 103,
                //     ),
                //     Row(children: <Widget>[
                //       Text(data[0]["npwp"] != null
                //           ? ": " + data[0]["npwp"]
                //           : "kosong"),
                //     ]),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(children: <Widget>[Text("Email",style: TextStyle(fontWeight: FontWeight.bold),)]),
                //     SizedBox(
                //       width: 108,
                //     ),
                //     Row(children: <Widget>[
                //       Text(data[0]["email"] != null
                //           ? ": " + data[0]["email"]
                //           : "kosong"),
                //     ]),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(children: <Widget>[Text("Telepon Kantor",style: TextStyle(fontWeight: FontWeight.bold),)]),
                //     SizedBox(
                //       width: 47,
                //     ),
                //     Row(children: <Widget>[
                //       Text(data[0]["telepon"] != null
                //           ? ": " + data[0]["telepon"]
                //           : "kosong"),
                //     ]),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(
                //       children: <Widget>[Text("Nomor Hp",style: TextStyle(fontWeight: FontWeight.bold),)],
                //     ),
                //     SizedBox(
                //       width: 80,
                //     ),
                //     Row(children: <Widget>[
                //       Text(data[0]["no_hp"] != null
                //           ? ": " + data[0]["no_hp"]
                //           : "kosong"),
                //     ]),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(
                //       children: <Widget>[Text("Nama Kepala Sekolah",style: TextStyle(fontWeight: FontWeight.bold),)],
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Row(
                //       children: <Widget>[
                //         Text(data[0]["kepala_sekolah_nama"] != null
                //             ? ": " + data[0]["kepala_sekolah_nama"]
                //             : "kosong"),
                //       ],
                //     ),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(children: <Widget>[Text("NIP Kepala Seklah",style: TextStyle(fontWeight: FontWeight.bold),)]),
                //     SizedBox(
                //       width: 28,
                //     ),
                //     Row(
                //       children: <Widget>[
                //         Text(data[0]["kepala_sekolah_nip"] != null
                //             ? ": " + data[0]["kepala_sekolah_nip"]
                //             : "kosong"),
                //       ],
                //     ),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(
                //       children: <Widget>[Text("Nama Bendahara",style: TextStyle(fontWeight: FontWeight.bold),)],
                //     ),
                //     SizedBox(
                //       width: 35,
                //     ),
                //     Row(
                //       children: <Widget>[
                //         Text(data[0]["bendahara_nama"] != null
                //             ? ": " + data[0]["bendahara_nama"]
                //             : "kosong"),
                //       ],
                //     ),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(children: <Widget>[
                //     Row(children: <Widget>[Text("NIP Bendahara",style: TextStyle(fontWeight: FontWeight.bold),)]),
                //     SizedBox(
                //       width: 50,
                //     ),
                //     Row(children: <Widget>[
                //       Text(data[0]["bendahara_nip"] != null
                //           ? ": " + data[0]["bendahara_nip"]
                //           : "kosong"),
                //     ]),
                //   ]),
                // ),
              ]),

        // ]),
        // ]
        // ),
        // ]
        // ),
        // ]
        // )
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => FormEdit2(
                    namasekolah: data[0]['nama_sekolah'],
                    alamat: data[0]['alamat_sekolah'],
                    npsn: data[0]['npsn'],
                    npwp: data[0]['npwp'],
                    email: data[0]['email'],
                    telepon: data[0]['telepon'],
                    no_hp: data[0]['no_hp'],
                    kepalasekolah: data[0]['kepala_sekolah_nama'],
                    kepalasekolahnip: data[0]['kepala_sekolah_nip'],
                    bendaharanama: data[0]['bendahara_nama'],
                    bendaharanip: data[0]['bendahara_nip'],
                  ),
                ));
            // Add your onPressed code here!
          },
          child: Icon(Icons.edit),
          backgroundColor: Colors.green,
        ));
    //AKHIR CODE
  }
}

class FormEdit2 extends StatefulWidget {
  final String namasekolah;
  final String alamat;
  final String npsn;
  final String npwp;
  final String email;
  final String telepon;
  final String no_hp;
  final String kepalasekolah;
  final String kepalasekolahnip;
  final String bendaharanama;
  final String bendaharanip;

  const FormEdit2(
      {Key key,
      this.namasekolah,
      this.alamat,
      this.npsn,
      this.npwp,
      this.email,
      this.telepon,
      this.no_hp,
      this.kepalasekolah,
      this.kepalasekolahnip,
      this.bendaharanama,
      this.bendaharanip})
      : super(key: key);

  @override
  _FormEdit2 createState() => _FormEdit2();
}

class _FormEdit2 extends State<FormEdit2> {
  List data;
  String id;
  Position _currentPosition;
  File _imageFile;
  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

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

  // Future<String> getJsonData() async {
  //   var response = await http.post(
  //       //Encode the url
  //       Uri.encodeFull('http://siplah.mascitra.co.id/api/sekolah/profil/get'),
  //       headers: {
  //         "Content-Type": "application/x-www-form-urlencoded",
  //         "API-App": "siplah_jpmall.id",
  //         "Api-Key": "4P1_7Pm411_51p114h",
  //         "API-Token": $Token({this.apitoken})fd43a64c539788b356da4910e5e95fb573"
  //       },
  //       body: {
  //         "id": "" + id
  //       });
  //   // print(response.body);
  //   setState(() {
  //     // ignore: deprecated_member_use
  //     var convertDataToJson = json.decode(response.body);
  //     data = convertDataToJson['Data'];
  //   });
  // }

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

  bool _isLoading = false;

  bool _isFieldNameValid;
  bool _isFieldEmailValid;
  bool _isFieldKepalaSekolah;
  bool _isFieldKepalaSekolahnip;
  bool _isFieldNamaBendahara;
  bool _isFieldNohp;
  bool _isFieldNpwp;
  bool _isFieldTelepon;
  bool _isFieldAlamat;
  bool _isFieldProvinsi;
  bool _isFieldKabupaten;
  bool _isFieldKodepos;
  bool _isFieldBendaharanip;
  bool _isFieldAlamatsekolah;
  bool _isFieldNamaPenanggung;
  bool _isFieldNpsn;

  final nama = TextEditingController();
  final emailsekolah = TextEditingController();
  final nohp = TextEditingController();
  final kepalasekolah = TextEditingController();
  final kepalasekolahnip = TextEditingController();
  final namabendahara = TextEditingController();
  final npwp = TextEditingController();
  final telepon = TextEditingController();
  final alamat = TextEditingController();
  final provinsi = TextEditingController();
  final kabupaten = TextEditingController();
  final kodepos = TextEditingController();
  final bendaharanip = TextEditingController();
  final alamatsekolah = TextEditingController();
  final namapenanggung = TextEditingController();
  final npsn = TextEditingController();
  final fotopemilik = TextEditingController();
  final email = TextEditingController();

  var placeholder = ['Loading...', 'Loading...', 'Loading...'];
  String prop, kab, kec;
  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      // foto = pref.getString("foto");
      // email = pref.getString("alamat");
      // alamat = pref.getString("telepon");
      // kodepos = pref.getString("kodepos");
      // telepon = pref.getString("telepon");
      _getCurrentLocation();
    });
    //print("id profile = "+id);
  }

  @override
  void initState() {
    nama.text = widget.namasekolah;
    emailsekolah.text = widget.email;
    nohp.text = widget.no_hp;
    kepalasekolah.text = widget.kepalasekolah;
    kepalasekolahnip.text = widget.kepalasekolahnip;
    namabendahara.text = widget.bendaharanama;
    npwp.text = widget.npwp;
    npsn.text = widget.npsn;
    telepon.text = widget.telepon;
    alamatsekolah.text = widget.alamat;
    bendaharanip.text = widget.bendaharanip;

    super.initState();
    provinceBloc.provinceFetchAll();
    getCredential();
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

  Future<http.Response> daftar_api() async {
    var url = 'http://siplah.mascitra.co.id/api/sekolah/profil/edit';

    Map data = {
      'user_id': id,
      'logo':
          _imageFile != null ? base64Encode(_imageFile.readAsBytesSync()) : '',
      'npsn': npsn.text,
      'npwp': npwp.text,
      'email_sekolah': emailsekolah.text,
      'telepon': telepon.text,
      'no_hp': nohp.text,
      'kepala_sekolah_nama': kepalasekolah.text,
      'kepala_sekolah_nip': kepalasekolahnip.text,
      'bendahara_nama': namabendahara.text,
      'bendahara_nip': bendaharanip.text,
      'nama': namapenanggung.text,
      'alamat': alamat.text,
      'provinsi_id': prop,
      'kabupaten_id': kab,
      'kecamatan_id': kec,
      'alamat_sekolah': alamatsekolah.text,
      'kode_pos': kodepos.text,
      'email': email.text,
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
    //print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    //  getJsonData();

    //print(_currentPosition.latitude);
    // print("id profil edit ="+id);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldNPSN(),
                _buildTextFieldNPWP(),
                _buildTextFieldEmail(),
                _buildTextFieldNohp(),
                _buildTextFieldKepalaSekolahnama(),
                _buildTextFieldKepalaSekolahnip(),
                _buildTextFieldNamabendahara(),
                _buildTextFieldBendaharaNIP(),
                _buildTextFieldAlamatSekolah(),
                _buildTextFieldNamaPenanggungjawab(),
                _buildTextFieldTelepon(),
                _buildTextFieldAlamat(),
                _buildTextFieldEmailpenanggung(),
                _buildTextFieldProvinsi(),
                _buildTextFieldKabupaten(),
                _buildTextFieldKecamatan(),
                _buildTextFieldKodepos(),
                _buildTextFieldFotoChoose(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      daftar_api();
                    },
                    child: Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
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

  Widget _buildTextFieldNPSN() {
    return TextField(
      controller: npsn,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NPSN",
        errorText:
            _isFieldNpsn == null || _isFieldNpsn ? null : "NPSN  harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNpsn) {
          setState(() => _isFieldNpsn = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNPWP() {
    return TextField(
      controller: npwp,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NPWP",
        errorText:
            _isFieldNpwp == null || _isFieldNpwp ? null : "NPWP harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNpwp) {
          setState(() => _isFieldNpwp = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: emailsekolah,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email Sekolah",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Email harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldTelepon() {
    return TextField(
      controller: telepon,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Telepon",
        errorText: _isFieldTelepon == null || _isFieldTelepon
            ? null
            : "Telepon harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTelepon) {
          setState(() => _isFieldTelepon = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNohp() {
    return TextField(
      controller: nohp,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Nomer Hp / Whatsapp ",
        errorText: _isFieldNohp == null || _isFieldNohp
            ? null
            : "Nomer Hp / Whatsapp harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNohp) {
          setState(() => _isFieldNohp = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldKepalaSekolahnama() {
    return TextField(
      controller: kepalasekolah,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Kepala Sekolah",
        errorText: _isFieldKepalaSekolah == null || _isFieldKepalaSekolah
            ? null
            : "Nama Kepala Sekolah harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldKepalaSekolah) {
          setState(() => _isFieldKepalaSekolah = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldKepalaSekolahnip() {
    return TextField(
      controller: kepalasekolahnip,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NIP Kepala Sekolah",
        errorText: _isFieldKepalaSekolahnip == null || _isFieldKepalaSekolahnip
            ? null
            : "NIP Kepala Sekolah harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldKepalaSekolahnip) {
          setState(() => _isFieldKepalaSekolahnip = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNamabendahara() {
    return TextField(
      controller: namabendahara,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Bendahara",
        errorText: _isFieldNamaBendahara == null || _isFieldNamaBendahara
            ? null
            : "Nama Bendahara harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaBendahara) {
          setState(() => _isFieldNamaBendahara = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldBendaharaNIP() {
    return TextField(
      controller: bendaharanip,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NIP Bendahara",
        errorText: _isFieldBendaharanip == null || _isFieldBendaharanip
            ? null
            : "NPWP harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldBendaharanip) {
          setState(() => _isFieldBendaharanip = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAlamatSekolah() {
    return TextField(
      controller: alamatsekolah,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Alamat Sekolah",
        errorText: _isFieldAlamatsekolah == null || _isFieldAlamatsekolah
            ? null
            : "Alamat Sekolah harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAlamatsekolah) {
          setState(() => _isFieldAlamatsekolah = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNamaPenanggungjawab() {
    return TextField(
      controller: namapenanggung,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Penanggung Jawab",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Nama Penanggung Jawab harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldEmailValid) {
      //     setState(() => _isFieldEmailValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldAlamat() {
    return TextField(
      controller: alamat,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Alamat",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Alamat harus diisi",
      ),
    );
  }

  Widget _buildTextFieldEmailpenanggung() {
    return TextField(
      controller: email,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Email",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Email harus diisi",
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

  Widget _buildTextFieldKodepos() {
    return TextField(
      controller: kodepos,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Kode Pos",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Kode Pos harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldEmailValid) {
      //     setState(() => _isFieldEmailValid = isFieldValid);
      //   }
      // },
    );
  }
}
