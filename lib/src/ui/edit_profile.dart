import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:siplah_jpmall/src/ui/page_profile.dart';
import 'package:http/http.dart' as http;

class Editprofile extends StatefulWidget {
  @override
  _Editprofile createState() => _Editprofile();
}

class _Editprofile extends State<Editprofile> {
  String foto, npsn, nama, email, alamat, kodepos, telepon;
  List data;

  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url
        Uri.encodeFull('http://siplah.mascitra.co.id/api/admin/data_mitra/list'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "id": "" + nama
        });

    print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
      //print(response.body);
    });
  }

  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString("id");
      getJsonData();
    });
    //("id profile = " + nama);
  }

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width / 3;
    double cwidth = MediaQuery.of(context).size.width;
    //print(data);
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
            : Container(
                width: cwidth,
                child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: <Widget>[
                      Column(children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.5,
                              ),
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(data[0]['foto'] !=
                                        null
                                    ? data[0]['foto']
                                    : ('http://siplah.mascitra.co.id/assets/images/no-image.png')),
                                //   child:Center(
                                //     child:
                                //   Image.network(
                                //      data[0]['foto'] != null
                                //           ? data[0]['foto']
                                //           : ('http://siplah.mascitra.co.id/assets/images/no-image.png'),
                                // ),
                                //   ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 40,
                      ),
                      //set awal
                      Text(
                        " Nama Pemilik Rekening",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["rekening_nama_pemilik"] != null
                          ? " " + data[0]["rekening_nama_pemilik"]
                          : "Kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " No. Rekening",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["rekening_no"] != null
                          ? " " + data[0]["rekening_no"]
                          : "kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Bank",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["bank"] != null
                          ? " " + data[0]["bank"]
                          : "kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Nama",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["nama"] != null
                          ? " " + data[0]["nama"]
                          : "kosong"),
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
                      Text(data[0]["npwp"] != null
                          ? " " + data[0]["npwp"]
                          : "kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Telepon",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["telepon"] != null
                          ? " " + data[0]["telepon"]
                          : "kosong"),
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
                      Text(data[0]["alamat"] != null
                          ? " " + data[0]["alamat"]
                          : "kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Provinsi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["provinsi_nama"] != null
                          ? " " + data[0]["provinsi_nama"]
                          : "kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Kabupaten",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["nama_kabupaten"] != null
                          ? " " + data[0]["nama_kabupaten"]
                          : "kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Kecamatan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["kecamatan_nama"] != null
                          ? " " + data[0]["kecamatan_nama"]
                          : "kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Kode Pos",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["kode_pos"] != null
                          ? " " + data[0]["kode_pos"]
                          : "kosong"),
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
                        " Penanda Tangan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["penanda_tangan"] != null
                          ? " " + data[0]["penanda_tangan"]
                          : "kosong"),
                      Divider(
                        height: 4,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Posis Penanda Tangan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(data[0]["penanda_tangan_posisi"] != null
                          ? " " + data[0]["penanda_tangan_posisi"]
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
                      //     Row(children: <Widget>[
                      //       Text("Nama Pemilik Rekening")
                      //     ],),
                      //     SizedBox(
                      //       width: 33,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["rekening_nama_pemilik"] != null
                      //         ? ": " +
                      //             data[0]["rekening_nama_pemilik"]
                      //         : "Kosong"),
                      //     ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("No. Rekening")
                      //     ],),
                      //     SizedBox(
                      //       width: 97,
                      //     ),
                      //     Row(
                      //       children: <Widget>[
                      //         Text(data[0]["rekening_no"] != null
                      //         ? ": " + data[0]["rekening_no"]
                      //         : "kosong"),
                      //       ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Bank")
                      //     ]),
                      //     SizedBox(
                      //       width: 148,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["bank"] != null
                      //         ? ": " + data[0]["bank"]
                      //         : "kosong"),
                      //     ]),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Nama")
                      //     ],),
                      //     SizedBox(
                      //       width: 143,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["nama"] != null
                      //         ? ": " + data[0]["nama"]
                      //         : "kosong"),

                      //     ],),
                      //                   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("NPWP")
                      //     ],),
                      //     SizedBox(
                      //       width: 140,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["npwp"] != null
                      //         ? ": " + data[0]["npwp"]
                      //         : "kosong"),

                      //     ],),
                      //                   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Telepon")
                      //     ]),
                      //     SizedBox(
                      //       width: 130,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["telepon"] != null
                      //         ? ": " + data[0]["telepon"]
                      //         : "kosong"),
                      //     ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: <Widget>[
                      //       Row(children: <Widget>[
                      //         Text("Alamat")
                      //       ]),
                      //     SizedBox(
                      //       width: 120,
                      //     ),
                      //     Container(
                      //         padding: const EdgeInsets.all(16.0),
                      //         width: c_width,
                      //         child: new Column(children: <Widget>[
                      //           Column(
                      //             children:<Widget>[
                      //            Text(data[0]["alamat"] != null
                      //         ? ": " + data[0]["alamat"]
                      //         : "kosong"),
                      //             ])
                      //         ])),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Provinsi")
                      //     ],),
                      //     SizedBox(
                      //       width: 128,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["provinsi_nama"] != null
                      //         ? ": " + data[0]["provinsi_nama"]
                      //         : "kosong"),
                      //     ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Kabupaten")
                      //     ],),
                      //     SizedBox(
                      //       width: 110,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["nama_kabupaten"] != null
                      //         ? ": " + data[0]["nama_kabupaten"]
                      //         : "kosong"),
                      //     ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(
                      //       children: <Widget>[
                      //         Text("Kecamatan")
                      //       ],
                      //     ),
                      //     SizedBox(
                      //       width: 105,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["kecamatan_nama"] != null
                      //         ? ": " + data[0]["kecamatan_nama"]
                      //         : "kosong"),
                      //     ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Kode Pos")
                      //     ],),
                      //     SizedBox(
                      //       width: 115,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["kode_pos"] != null
                      //         ? ": " + data[0]["kode_pos"]
                      //         : "kosong"),
                      //     ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Email")
                      //     ],),
                      //     SizedBox(
                      //       width: 138,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["email"] != null
                      //         ? ": " + data[0]["email"]
                      //         : "kosong"),
                      //     ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Penanda Tangan")
                      //     ],),
                      //     SizedBox(
                      //       width: 68,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["penanda_tangan"] != null
                      //         ? ": " + data[0]["penanda_tangan"]
                      //         : "kosong"),
                      //     ],),

                      //   ]),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(children: <Widget>[
                      //     Row(children: <Widget>[
                      //       Text("Posis Penanda Tangan")
                      //     ],),
                      //     SizedBox(
                      //       width: 30,
                      //     ),
                      //     Row(children: <Widget>[
                      //       Text(data[0]["penanda_tangan_posisi"] != null
                      //         ? ": " +
                      //             data[0]["penanda_tangan_posisi"]
                      //         : "kosong"),

                      //     ],),
                      //                   ]),
                      // ),
                    ])),
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
                  builder: (BuildContext context) => FormEdit(
                    rekeningnama: data[0]['rekening_nama_pemilik'],
                    rekeningno: data[0]['rekening_no'],
                    bank: data[0]['bank'],
                    nama: data[0]['nama'],
                    npwp: data[0]['npwp'],
                    telepon: data[0]['telepon'],
                    alamat: data[0]['alamat'],
                    provinsi: data[0]['provinsi_nama'],
                    kabupaten: data[0]['nama_kabupaten'],
                    kecamatan: data[0]['kecamatan_nama'],
                    kodepos: data[0]['kode_pos'],
                    email: data[0]['email'],
                    penandatangan: data[0]['penanda_tangan'],
                    posisipendatangan: data[0]['penanda_tangan_posisi'],
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

class FormEdit extends StatefulWidget {
  final String rekeningnama;
  final String rekeningno;
  final String bank;
  final String nama;
  final String npwp;
  final String telepon;
  final String alamat;
  final String provinsi;
  final String kabupaten;
  final String kecamatan;
  final String kodepos;
  final String email;
  final String penandatangan;
  final String posisipendatangan;

  const FormEdit(
      {Key key,
      this.rekeningnama,
      this.rekeningno,
      this.bank,
      this.nama,
      this.npwp,
      this.telepon,
      this.alamat,
      this.provinsi,
      this.kabupaten,
      this.kecamatan,
      this.kodepos,
      this.email,
      this.penandatangan,
      this.posisipendatangan})
      : super(key: key);

  @override
  _FormEdit createState() => _FormEdit();
}

class _FormEdit extends State<FormEdit> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
      //print(e);
    });
  }

  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url
        Uri.encodeFull('http://siplah.mascitra.co.id/api/admin/data_mitra/list'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "id": "" + id
        });
    // print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
    });
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
//end class upload

  bool _isLoading = false;

  bool _isFieldNamapemilik;
  bool _isFieldNorekening;
  bool _isFieldNpwp;
  bool _isFieldNamabank;
  bool _isFieldNamaperusahaan;
  bool _isFieldPenandatangan;
  bool _isFieldPospenanda;
  bool _isFieldEmailValid;
  bool _isFieldprop;
  bool _isFieldkab;
  bool _isFieldkec;
  bool _isFieldAgeValid;
  bool _isFieldAlamat;
  bool _isFieldTelepon;
  bool _isFieldPass;
  bool _isFieldConfrmpass;
  bool _isFieldLimit;
  bool _isFieldDesc;
  bool _isFieldPos;

  final nama = TextEditingController();
  final email = TextEditingController();
  final namapemilik = TextEditingController();
  final norekening = TextEditingController();
  final namabank = TextEditingController();
  final namaperusahaan = TextEditingController();
  final npwp = TextEditingController();
  final telepon = TextEditingController();
  final alamat = TextEditingController();
  final provinsi = TextEditingController();
  final kabupaten = TextEditingController();
  final kodepos = TextEditingController();
  final penandatangan = TextEditingController();
  final pospenanda = TextEditingController();
  final password = TextEditingController();
  final konfirmasi = TextEditingController();
  final limitasi = TextEditingController();
  final deskripsi = TextEditingController();
  final fotopemilik = TextEditingController();

  var placeholder = ['Loading...', 'Loading...', 'Loading...'];
  String prop, kab, kec;
  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      getJsonData();
      _getCurrentLocation();
    });
    //print("id profile = "+id);
  }

  @override
  void initState() {
    nama.text = widget.nama;
    email.text = widget.email;
    namapemilik.text = widget.rekeningnama;
    norekening.text = widget.rekeningno;
    namabank.text = widget.bank;
    npwp.text = widget.npwp;
    telepon.text = widget.telepon;
    alamat.text = widget.alamat;
    provinsi.text = widget.provinsi;
    kabupaten.text = widget.kabupaten;
    penandatangan.text = widget.penandatangan;
    pospenanda.text = widget.posisipendatangan;
    kodepos.text = widget.kodepos;

    super.initState();
    provinceBloc.provinceFetchAll();
    getCredential();
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
    var url = 'http://siplah.mascitra.co.id/api/mitra/user/profil_update';

    Map data = {
      'user_id': id,
      'nama_pemeilik_rekening': namapemilik.text,
      'no_rekening': norekening.text,
      'limitasi_minimum': limitasi.text,
      'deskripsi': deskripsi.text,
      'npwp': npwp.text,
      'bank': namabank.text,
      'nama': namaperusahaan.text,
      'penanda_tangan': penandatangan.text,
      'posisi_penanda_tangan': pospenanda.text,
      'email': email.text,
      'password_baru': password.text,
      'password_baru_konfirmasi': konfirmasi.text,
      'provinsi_id': prop,
      'kabupaten_id': kab,
      'kecamatan_id': kec,
      'alamat': alamat.text,
      'kode_pos': kodepos.text,
      'telepon': telepon.text,
      'latitude': "${_currentPosition.latitude}",
      'longitude': "${_currentPosition.longitude}",
      'foto':
          _imageFile != null ? base64Encode(_imageFile.readAsBytesSync()) : '',
    };
    //print(_imageFile);
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
                _buildTextFieldNamaPemilik(),
                _buildTextFieldPassword(),
                _buildTextFieldKonfirmasi(),
                _buildTextFieldEmail(),
                _buildTextFieldNoRekening(),
                _buildTextFieldNamaBank(),
                _buildTextFieldlimitasi(),
                _buildTextFielddeskripsi(),
                _buildTextFieldNama(),
                _buildTextFieldNPWP(),
                _buildTextFieldTelepon(),
                _buildTextFieldAlamat(),
                _buildTextFieldProvinsi(),
                _buildTextFieldKabupaten(),
                _buildTextFieldKecamatan(),
                _buildTextFieldKodepos(),
                _buildTextFieldPenandaTangan(),
                _buildTextFieldPosPenandaTangan(),
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
    // return Container(
    //         width: double.infinity,
    //         height: 150.0,
    //         child: InkWell(
    //           onTap: () {
    //            _showAlertupload(context);
    //           },
    //           child: _imageFile == null
    //               ? placeholder
    //               : Image.file(
    //                   _imageFile,
    //                   fit: BoxFit.fill,
    //                 ),
    //         ),
    //  );
  }

  Widget _buildTextFieldNamaPemilik() {
    return TextField(
      controller: namapemilik,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Pemilik Rekening",
        errorText: _isFieldNamapemilik == null || _isFieldNamapemilik
            ? null
            : "Nama Pemilik Rekening harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamapemilik) {
          setState(() => _isFieldNamapemilik = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return TextField(
      controller: password,
      obscureText: _obscureText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: _isFieldPass == null || _isFieldPass
            ? null
            : "Password harus diisi",
      ),
    );
  }

  Widget _buildTextFieldKonfirmasi() {
    return TextField(
      controller: konfirmasi,
      obscureText: _obscureText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Konfirmasi Password",
        errorText: _isFieldConfrmpass == null || _isFieldConfrmpass
            ? null
            : "Konfirmasi Password harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldNameValid) {
      //     setState(() => _isFieldNameValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldNoRekening() {
    return TextField(
      controller: norekening,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "No. Rekening",
        errorText: _isFieldNorekening == null || _isFieldNorekening
            ? null
            : "No. Rekening harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNorekening) {
          setState(() => _isFieldNorekening = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNamaBank() {
    return TextField(
      controller: namabank,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Bank ",
        errorText: _isFieldNamabank == null || _isFieldNamabank
            ? null
            : "Nama Bank harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamabank) {
          setState(() => _isFieldNamabank = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldlimitasi() {
    return TextField(
      controller: limitasi,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Limitasi",
        errorText: _isFieldLimit == null || _isFieldLimit
            ? null
            : "Limitasi harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLimit) {
          setState(() => _isFieldLimit = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFielddeskripsi() {
    return TextField(
      controller: deskripsi,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Deskripsi",
        errorText: _isFieldDesc == null || _isFieldDesc
            ? null
            : "Deskripsi harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldNameValid) {
      //     setState(() => _isFieldNameValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldNama() {
    return TextField(
      controller: namaperusahaan,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Perusahaan",
        errorText: _isFieldNamaperusahaan == null || _isFieldNamaperusahaan
            ? null
            : "Nama Perusahaan harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaperusahaan) {
          setState(() => _isFieldNamaperusahaan = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNPWP() {
    return TextField(
      controller: npwp,
      keyboardType: TextInputType.phone,
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

  Widget _buildTextFieldTelepon() {
    return TextField(
      controller: telepon,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Telepon",
        errorText: _isFieldTelepon == null || _isFieldTelepon
            ? null
            : "Nomor Telepon harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTelepon) {
          setState(() => _isFieldTelepon = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAlamat() {
    return TextField(
      controller: alamat,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Alamat",
        errorText: _isFieldAlamat == null || _isFieldAlamat
            ? null
            : "Alamat harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAlamat) {
          setState(() => _isFieldAlamat = isFieldValid);
        }
      },
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
        errorText:
            _isFieldPos == null || _isFieldPos ? null : "Kode Pos harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPos) {
          setState(() => _isFieldPos = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
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

  Widget _buildTextFieldPenandaTangan() {
    return TextField(
      controller: penandatangan,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Penanda Tangan",
        errorText: _isFieldPenandatangan == null || _isFieldPenandatangan
            ? null
            : "Form Penanda Tangan harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPenandatangan) {
          setState(() => _isFieldPenandatangan = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPosPenandaTangan() {
    return TextField(
      controller: pospenanda,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Posisi Penanda Tangan",
        errorText: _isFieldPospenanda == null || _isFieldPospenanda
            ? null
            : "Form Posisi Penanda Tangan harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPospenanda) {
          setState(() => _isFieldPospenanda = isFieldValid);
        }
      },
    );
  }
}
