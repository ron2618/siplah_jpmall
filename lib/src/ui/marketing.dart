import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
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
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:siplah_jpmall/src/ui/pembayaran.dart';

import 'login.dart';

class Marketing extends StatefulWidget {
  @override
  _MarketingState createState() => _MarketingState();
}

class _MarketingState extends State<Marketing> {
  //edit
  
    //controller
    final namamarketing = TextEditingController();
    final npwp = TextEditingController();
    final email = TextEditingController();
    final telpn = TextEditingController();
    final provinsi = TextEditingController();
    final kabupaten = TextEditingController();
    final alamatleng = TextEditingController();
    final jeniskel = TextEditingController();
    final logo = TextEditingController();
    final kategori = TextEditingController();

  Future<http.Response> _edit(String idx, nama) async {
    provinceBloc.provinceFetchAll();
    
    var katPel = ['1', '2'];
    var jeKel = ['1', '2'];
    String slctdKatPel, slctdjeKel;
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
 
    //

    Future<http.Response> daftar_api() async {
      var url = 'http://siplah.mascitra.co.id/api/mitra/marketing/edit';

      Map data = {
        'id': idx,
        'user_id': nama,
        'nama': namamarketing.text,
        'npwp': npwp.text,
        'no_telepon': telpn.text,
        'email': email.text,
        'jenis_kelamin': slctdjeKel,
        'kategori': slctdKatPel,
        'provinsi_id': prop,
        'kabupaten_id': kab,
        'kecamatan_id': kec,
        'alamat': alamatleng.text,
        'foto': _imageFile != null
            ? base64Encode(_imageFile.readAsBytesSync())
            : '',
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
              title: Text("Edit Marketing"),
              content: Column(children: <Widget>[
                // telpn.text=telepon,
                // email.text=emailmar,
                // npwp.text=npwpmar,
                // alamatleng.text=alamat,
                // namamarketing.text=namamarket,
                CustomTile(
                  "Kategori Marketing",
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        isExpanded: true,
                        value: slctdKatPel,
                        items: List.generate(
                            katPel.length,
                            (i) => DropdownMenuItem<String>(
                                  child: Text(katPel[i] == '1'
                                      ? "Internal"
                                      : "Eksternal"),
                                  value: katPel[i],
                                )),
                        onChanged: (item) {
                          setState(() {
                            slctdKatPel = item;
                          });
                        }),
                  ),
                ),
                TextField(
                  controller: namamarketing,
                  decoration: InputDecoration(hintText: "Nama Marketing"),
                ),
                TextField(
                  controller: npwp,
                  decoration: InputDecoration(hintText: "NPWP"),
                ),
                TextField(
                  controller: telpn,
                  decoration: InputDecoration(hintText: "No - Telepon"),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                CustomTile(
                  "Kategori Marketing",
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        isExpanded: true,
                        value: slctdjeKel,
                        items: List.generate(
                            jeKel.length,
                            (i) => DropdownMenuItem<String>(
                                  child: Text(jeKel[i] == '1'
                                      ? "Laki - laki"
                                      : "Perempuan"),
                                  value: jeKel[i],
                                )),
                        onChanged: (item) {
                          setState(() {
                            slctdjeKel = item;
                          });
                        }),
                  ),
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
              ]),
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
            ));
  }

  //end
  Future<http.Response> _delete(String id) async {
    //a=a+id;
    print(id);
    var url = 'http://siplah.mascitra.co.id/api/mitra/marketing/hapus';

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

  String nama;
  List data;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull('http://siplah.mascitra.co.id/api/mitra/marketing/tampil'),
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
 namamarketing.text=data[0]['nama'];
 npwp.text=data[0]['npwp'];
 email.text =data[0]['email'];
     telpn.text = data[0]['no_telepon'];
     alamatleng.text = data[0]['alamat'];
     jeniskel.text   = data[0]['jenis_kelamin'];
    kategori.text = data[0]['kategori'];

    });
  }

  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString("id");
    });
    getJsonData();
  }

  //refreshcontroller
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
                          builder: (BuildContext context) => TambahMarketing(),
                        )),
                  }),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Marketing", style: TextStyle(color: Colors.white)),
      ),
      //body: Text(data[0]["kode"]),
      body: data == null
          ? Container()
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemExtent: 165,
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, int i) => Card(
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
                                          child: Text(
                                              "Kode                    : " +
                                                  data[i]['kode']),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              "Nama                  : " +
                                                  data[i]['nama']),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              "Nomor Telepon : " +
                                                  data[i]['no_telepon'],
                                              textAlign: TextAlign.left),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(data[i]['kategori'] == '1'
                                              ? "Kategori              : Internal"
                                              : "Kategori              : Eksternal"),
                                        )
                                      ],
                                    ),
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
                                          _edit(data[i]['id'], nama);
                                        },
                                      ),
                                    )),
                              ]),
                            ]),
                          )
                        ]),
                      )),
                ),
              ),
            ),
    );
  }
}

class TambahMarketing extends StatefulWidget {
  @override
  _TambahMarketingState createState() => _TambahMarketingState();
}

class _TambahMarketingState extends State<TambahMarketing> {
  var katPel = ['1', '2'];
  var jeKel = ['1', '2'];
  String id, slctdKatPel, slctdjeKel;
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

  //controller
  final namamarketing = TextEditingController();
  final npwp = TextEditingController();
  final email = TextEditingController();
  final telpn = TextEditingController();
  final provinsi = TextEditingController();
  final kabupaten = TextEditingController();
  final alamatleng = TextEditingController();
  final jeniskel = TextEditingController();
  final logo = TextEditingController();
  final kategori = TextEditingController();

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
  }

  Future<http.Response> daftar_api() async {
    var url = 'http://siplah.mascitra.co.id/api/mitra/marketing/tambah';

    Map data = {
      'user_id': id,
      'nama': namamarketing.text,
      'npwp': npwp.text,
      'no_telepon': telpn.text,
      'email': email.text,
      'jenis_kelamin': slctdjeKel,
      'kategori': slctdKatPel,
      'provinsi_id': prop,
      'kabupaten_id': kab,
      'kecamatan_id': kec,
      'alamat': alamatleng.text,
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
              content: Text("Marketing telah berhasil ditambahkan"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Tambah Marketing", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextKategori(),
                  _buildTextNamaMarketing(),
                  _buildTextNpwp(),
                  _buildTextNomorTelpon(),
                  _buildTextEmail(),
                  _buildTextJekel(),
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

  Widget _buildTextNamaMarketing() {
    return TextField(
      controller: namamarketing,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Marketing",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Marketing harus diisi",
      ),
    );
  }

  Widget _buildTextNpwp() {
    return TextField(
      controller: npwp,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NPWP",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "NPWP harus diisi",
      ),
    );
  }

  Widget _buildTextKategori() {
    return CustomTile(
      "Kategori Marketing",
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            value: slctdKatPel,
            items: List.generate(
                katPel.length,
                (i) => DropdownMenuItem<String>(
                      child: Text(katPel[i] == '1' ? "Internal" : "Eksternal"),
                      value: katPel[i],
                    )),
            onChanged: (item) {
              setState(() {
                slctdKatPel = item;
              });
            }),
      ),
    );
  }

  Widget _buildTextJekel() {
    return CustomTile(
      "Kategori Marketing",
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            value: slctdjeKel,
            items: List.generate(
                jeKel.length,
                (i) => DropdownMenuItem<String>(
                      child:
                          Text(jeKel[i] == '1' ? "Laki - laki" : "Perempuan"),
                      value: jeKel[i],
                    )),
            onChanged: (item) {
              setState(() {
                slctdjeKel = item;
              });
            }),
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

class MarketingPem extends StatefulWidget {
  final String penjual;
  final String imagebank;
  final String datatype;
  final String databank;
  final int totalharga;
  final String namamar;
  final String imagekurir;
  final int cost;
  final String idmar;
  final String ketkur;
  final String namakur;
  final int idtrans;
   final String service;
  final String deskkur;

  const MarketingPem({Key key, this.penjual, this.imagebank, this.datatype, this.databank, this.totalharga, this.namamar, this.imagekurir, this.cost, this.idmar, this.ketkur, this.namakur, this.idtrans, this.service, this.deskkur}) : super(key: key);
  
  @override
  _MarketingPemState createState() => _MarketingPemState();
}

class _MarketingPemState extends State<MarketingPem> {
  String nama;
  List data;
  Future<String> getdatamar() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull('http://siplah.mascitra.co.id/api/mitra/marketing/tampil'),
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
    });
  }
  
  List datax;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull('http://siplah.mascitra.co.id/api/sekolah/pembayaran/tampil'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "transaksi_id": widget.idtrans.toString(),
        });
    print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datax = convertDataToJson['Data'];
      nama=datax[0]['mitra_id'];
     getdatamar();
    });
  }
  void initState() {
    getJsonData();
    getdatamar();
    super.initState();

  }
  //refreshcontroller
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    getdatamar();
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
print("mar="+widget.idtrans.toString());
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Marketing", style: TextStyle(color: Colors.white)),
      ),
      //body: Text(data[0]["kode"]),
      body: data == null
          ? Container()
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                  itemExtent: 165,
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, int i) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Kode                    : " +
                                                      data[i]['kode']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Nama                  : " +
                                                      data[i]['nama']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Nomor Telepon : " +
                                                      data[i]['no_telepon'],
                                                  textAlign: TextAlign.left),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(data[i]['kategori'] ==
                                                      '1'
                                                  ? "Kategori              : Internal"
                                                  : "Kategori              : Eksternal"),
                                            )
                                          ],
                                        ),
                                      ]),
                                  Row(children: <Widget>[
                                    Flexible(
                                        fit: FlexFit.tight, child: SizedBox()),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.navigate_next,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PembayaranState(
                                                          idmar:data[i]['id'],
                                                            totalharga: widget
                                                                .totalharga,
                                                            imagebank:
                                                                widget
                                                                    .imagebank,
                                                            imagekurir:
                                                                widget
                                                                    .imagekurir,
                                                            databank:
                                                                widget.databank,
                                                            datatype:
                                                                widget.datatype,
                                                            cost: widget.cost,
                                                            namamar: data[i]
                                                                ['nama'],
                                                                idtrans: widget.idtrans,
                                                                    service:widget.service,
                            deskkur:widget.deskkur),
                                                  ));
                                            },
                                          ),
                                        )),
                                  ]),
                                ]),
                              )
                            ]),
                          )),
                    );
                  }),
            ),
    );
  }
}
