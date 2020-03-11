import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siplah_jpmall/src/bloc/kabupaten_bloc.dart';
import 'package:siplah_jpmall/src/bloc/kecamatan_bloc.dart';
import 'package:siplah_jpmall/src/bloc/provinsi_bloc.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/kabupaten_model.dart';
import 'package:siplah_jpmall/src/models/kecamatan_model.dart';
import 'package:siplah_jpmall/src/models/provinsi_model.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'login.dart';

class AlamatPemesan extends StatefulWidget {
  @override
  _AlamatPemesan createState() => _AlamatPemesan();
}

class _AlamatPemesan extends State<AlamatPemesan> {
  //edit
   final namaket = TextEditingController();
    final namapenerima = TextEditingController();
    final telppenerima = TextEditingController();
    final kodepospenerima = TextEditingController();
    final provinsi = TextEditingController();
    final kabupaten = TextEditingController();
    final alamatleng = TextEditingController();

  Future<http.Response> _edit(String idx, nama) async {
    provinceBloc.provinceFetchAll();

    var placeholder = ['Loading...', 'Loading...', 'Loading...'];
    String prop, kab, kec;

    //controller
   
    //

    Future<http.Response> update_api() async {
      var url =
          'http://siplah.mascitra.co.id/api/sekolah/alamat_pengiriman/update';

      Map data = {
        'id': idx,
        'user_id': nama,
        'nama': namaket.text,
        'nama_penerima': namapenerima.text,
        'no_hp_penerima': telppenerima.text,
        'kode_pos': kodepospenerima.text,
        'provinsi_id': prop,
        'kabupaten_id': kab,
        'kecamatan_id': kec,
        'alamat': alamatleng.text
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

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Edit Alamat Pemesanan"),
              content: Column(children: <Widget>[
                TextField(
                  controller: namaket,
                  decoration: InputDecoration(hintText: "Nama Keterangan"),
                ),
                TextField(
                  controller: namapenerima,
                  decoration: InputDecoration(hintText: "Nama Penerima"),
                ),
                TextField(
                  controller: kodepospenerima,
                  decoration: InputDecoration(hintText: "Kode Pos"),
                ),
                TextField(
                  controller: telppenerima,
                  decoration: InputDecoration(hintText: "Nomer Telpon "),
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
                    update_api();
                  },
                ),
              ],
            ));
  }

  //end
  String foto, npsn, nama;
  List data;
  //String id=null;

  Future<http.Response> _delete(String id) async {
    //a=a+id;
    print(id);
    var url =
        'http://siplah.mascitra.co.id/api/sekolah/alamat_pengiriman/delete';

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
      getJsonData();
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

  void _berhasil(BuildContext context,) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Data berhasil diubah"),
            ));
  }
   void _berhasil1(BuildContext context,z) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text(""+z),
            ));
  }
String z;
  Future<http.Response> _setlocation(String id, a) async {
    //a=a+id;
    //print(id);
    print(a);
    var url =
        'http://siplah.mascitra.co.id/api/sekolah/alamat_pengiriman/set_utama';

    Map data = {'user_id': "" + nama, 'id': id, 'is_utama': a};
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
     z=map["Pesan_sys"]; 
      // savedata();
      getJsonData();
      _berhasil1(context,z);
    }
    return response;
  }

  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'http://siplah.mascitra.co.id/api/sekolah/alamat_pengiriman/list'),
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
       namaket.text=data[0]['nama'];
       namapenerima.text=data[0]['penerima_nama'];
       kodepospenerima.text=data[0]['kode_pos'];
       telppenerima.text=data[0]['penerima_no_hp'];
       alamatleng.text=data[0]['alamat'];

    });
  }

  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString("id");
      getJsonData();
    });
    //print("id profile sklh= " + nama);
  }

  //refresh controler
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
      // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
      getJsonData();// if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
  @override
  void initState() {
    super.initState();  
    getCredential();
    
  }

  @override
  Widget build(BuildContext context) {
   double c_width = MediaQuery.of(context).size.width/2;
    //print(data.length);
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
                                builder: (BuildContext context) =>
                                    Tambahalamat(),
                              )),
                        }),
              ],
              iconTheme: IconThemeData(color: Colors.white),
              title: Text("Alamat Pemesanan",
                  style: TextStyle(color: Colors.white)),
            ),
            body: data == null
                      ?
                      Center(
                        child: Shimmer.fromColors(
                          child: Text("Loading...", style: TextStyle(fontSize: 15),),
                          baseColor: Colors.white,
                          highlightColor: Colors.grey),
                      )
                //       Column(
                // children: <Widget>[Center(child: CircularProgressIndicator())])
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
                         //print(data[i]['is_utama']);

                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: SizedBox(
                                height: c_width,
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child:
                                                        Text(data[i]['nama']),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(data[i]
                                                        ['penerima_nama']),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        data[i]['alamat'],
                                                        textAlign:
                                                            TextAlign.left),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(data[i]
                                                        ['kabupaten_nama']),
                                                  )
                                                ],
                                              ),
                                              //Text(data[i]['kecamatan_nama']),
                                              Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        data[i]['kode_pos']),
                                                  )
                                                ],
                                              )
                                            ]),
                                        Row(children: <Widget>[
                                          Flexible(
                                              fit: FlexFit.tight,
                                              child: SizedBox()),
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
                                            
                                               data[i]['is_utama']== '1'?
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child:
                                               Container(
                                               
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.check_box,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    String a;
                                                    data[i]['is_utama'] == '2'
                                                        ? a = '1'
                                                        : a = '2';
                                                    _setlocation(
                                                        data[i]['id'], a);
                                                  },
                                                ),
                                              )
                                              ):
                                              Align(
                                              alignment: Alignment.centerRight,
                                              child:
                                               Container(
                                               
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.check_box_outline_blank,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    String a;
                                                    data[i]['is_utama'] == '1'
                                                        ? a = '1'
                                                        : a = '2';
                                                    _setlocation(
                                                        data[i]['id'], a);
                                                  },
                                                ),
                                              )
                                              )
                                        ]),
                                      ]),
                                    )
                                  ]),
                                )),
                          );
                        },
                      ),
                    ),
                  ));
  }
}

class Tambahalamat extends StatefulWidget {
  @override
  _Tambahalamat createState() => _Tambahalamat();
}

class _Tambahalamat extends State<Tambahalamat> {
  String id;
  bool _isFieldNameValid;
  var placeholder = ['Loading...', 'Loading...', 'Loading...'];
  String prop, kab, kec;
  //controller
  final namaket = TextEditingController();
  final namapenerima = TextEditingController();
  final telppenerima = TextEditingController();
  final kodepospenerima = TextEditingController();
  final provinsi = TextEditingController();
  final kabupaten = TextEditingController();
  final alamatleng = TextEditingController();
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
    var url = 'http://siplah.mascitra.co.id/api/sekolah/alamat_pengiriman/add';

    Map data = {
      'user_id': id,
      'nama': namaket.text,
      'nama_penerima': namapenerima.text,
      'no_hp_penerima': telppenerima.text,
      'kode_pos': kodepospenerima.text,
      'provinsi_id': prop,
      'kabupaten_id': kab,
      'kecamatan_id': kec,
      'alamat': alamatleng.text
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
              content: Text("Alamat berhasil ditambahkan"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Tambah Alamat", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextKetAlamat(),
                  _buildTextNamaPenerima(),
                  _buildTextNomorTelpon(),
                  _buildTextKodePos(),
                  _buildTextFieldProvinsi(),
                  _buildTextFieldKabupaten(),
                  _buildTextFieldKecamatan(),
                  _buildTextAlamat(),
                  _buildBtnSubmit()
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTextKetAlamat() {
    return TextField(
      controller: namaket,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Alamat",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Alamat harus diisi",
      ),
    );
  }

  Widget _buildTextNamaPenerima() {
    return TextField(
      controller: namapenerima,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Penerima",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Penerima harus diisi",
      ),
    );
  }

  Widget _buildTextNomorTelpon() {
    return TextField(
      controller: telppenerima,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Nomor Telpon Penerima",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nomor Telepon Penerima harus diisi",
      ),
    );
  }

  Widget _buildTextKodePos() {
    return TextField(
      controller: kodepospenerima,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Kode Pos Penerima",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Kode Pos Penerima harus diisi",
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
