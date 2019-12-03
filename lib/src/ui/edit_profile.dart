
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/bloc/kabupaten_bloc.dart';
import 'package:siplah_jpmall/src/bloc/kecamatan_bloc.dart';
import 'package:siplah_jpmall/src/bloc/provinsi_bloc.dart';
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
class _Editprofile extends State<Editprofile>{
   String foto,npsn,nama,email,alamat,kodepos,telepon;
List data;
   @override
  void initState() {
   
   
  }
  
   Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url
        Uri.encodeFull('https://siplah.mascitra.co.id/api/admin/data_mitra/list'),
        headers: {"Content-Type": "application/x-www-form-urlencoded","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"5b4eefd43a64c539788b356da4910e5e95fb573"},
        body: {"id":""+nama});
   // print(response.body);
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
          // foto = pref.getString("foto");
          // email = pref.getString("alamat");
          // alamat = pref.getString("telepon");
          // kodepos = pref.getString("kodepos");
          // telepon = pref.getString("telepon");
          });
   print("id profile = "+nama);
  }
  @override
  Widget build(BuildContext context) {
     getCredential();
     getJsonData();
     
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
        body:  ListView(
         
           padding: const EdgeInsets.all(0),
          children: <Widget>[
             Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(data[0]["rekening_nama_pemilik"]!=null?"Nama Pemilik Rekening : "+data[0]["rekening_nama_pemilik"]:"Kosong"), 
               SizedBox(
                  height: 10,
                ),
              // Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: <Widget>[
                Text(data[0]["rekening_no"]!=null?"No. Rekening : "+data[0]["rekening_no"]:"kosong"), 
          //     ])
          // ]
          //    ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
            SizedBox(
                  height: 10,
                ),
                Text(data[0]["bank"]!=null?"Bank : "+data[0]["bank"]:"kosong"), 
             
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
              SizedBox(
                  height: 10,
                ),
                Text(data[0]["nama"]!=null?"Nama : "+data[0]["nama"]:"kosong"), 
                SizedBox(
                  height: 10,
                ),

                Text(data[0]["npwp"]!=null?"NPWP : "+data[0]["npwp"]:"kosong"),
                SizedBox(
                  height: 10,
                ),

                Text(data[0]["telepon"]!=null?"Telepon : "+data[0]["telepon"]:"kosong"),
             
              //  Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(data[0]["alamat"]!=null?"Alamat : "+data[0]["alamat"]:"kosong"), 
                SizedBox(
                  height: 10,
                ),
                Text(data[0]["provinsi_nama"]!=null?"Provinsi : "+data[0]["provinsi_nama"]:"kosong"), 
                SizedBox(
                  height: 10,
                ),

                Text(data[0]["nama_kabupaten"]!=null?"Kabupaten : "+data[0]["nama_kabupaten"]:"kosong"), 
                SizedBox(
                  height: 10,
                ),

                Text(data[0]["kecamatan_nama"]!=null?"Kecamatan : "+data[0]["kecamatan_nama"]:"kosong"),
                SizedBox(
                  height: 10,
                ),
                
                Text(data[0]["kode_pos"]!=null?"Kode Pos : "+data[0]["kode_pos"]:"kosong"),
                SizedBox(
                  height: 10,
                ),

                Text(data[0]["email"]!=null?"Email : "+data[0]["email"]:"kosong"),
                SizedBox(
                  height: 10,
                ),

                
                Text(data[0]["penanda_tangan"]!=null?"Penanda Tangan : "+data[0]["penanda_tangan"]:"kosong"),
                SizedBox(
                  height: 10,
                ),

                Text(data[0]["penanda_tangan_posisi"]!=null?"Posisi Penanda Tanganan : "+data[0]["penanda_tangan_posisi"]:"kosong"),
                ]
            )
                
            ]
            
            ),
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
                    builder: (BuildContext context) => FormEdit(),
                  ));
        // Add your onPressed code here!
      },
      child: Icon(Icons.edit),
      backgroundColor: Colors.green,
            )
        );
      	//AKHIR CODE
      
    
  }
}
class FormEdit extends StatefulWidget{
   @override
  _FormEdit createState() => _FormEdit();
}
class _FormEdit extends State<FormEdit>{
  List data;
  String id;
  Position _currentPosition;

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

Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url
        Uri.encodeFull('https://siplah.mascitra.co.id/api/admin/data_mitra/list'),
        headers: {"Content-Type": "application/x-www-form-urlencoded","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"5b4eefd43a64c539788b356da4910e5e95fb573"},
        body: {"id":""+id});
   // print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
    
     
    });
    }

    bool _isLoading = false;
 
  bool _isFieldNameValid;
  bool _isFieldEmailValid;
  bool _isFieldAgeValid;
  
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
          // foto = pref.getString("foto");
          // email = pref.getString("alamat");
          // alamat = pref.getString("telepon");
          // kodepos = pref.getString("kodepos");
          // telepon = pref.getString("telepon");
          });
   //print("id profile = "+id);
  }
@override
  void initState() {
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
          )
      );}
      void _berhasil(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Peringatan"),
            content: Text("Data berhasil diubah"),
          )
      );}
     Future<http.Response> daftar_api () async {
  var url ='https://siplah.mascitra.co.id/api/mitra/user/profil_update';

  Map data = {
    'user_id':id,
    'nama_pemeilik_rekening': namapemilik.text,
    'no_rekening':norekening.text,
    'limitasi_minimum':limitasi.text,
    'deskripsi':deskripsi.text,
    'npwp':npwp.text,
    'bank':namabank.text,
    'nama':namaperusahaan.text,
    'penanda_tangan':penandatangan.text,
    'posisi_penanda_tangan':pospenanda.text,
    'email': email.text,
    'password_baru': password.text,
    'password_baru_konfirmasi': konfirmasi.text,
     'provinsi_id': prop,
     'kabupaten_id': kab,
     'kecamatan_id':kec,
     'alamat':alamat.text,
     'kode_pos': kodepos.text,
      'telepon':telepon.text,
      'latitude':"${_currentPosition.latitude}",
      'longitude':"${_currentPosition.longitude}",
     
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"5b4eefd43a64c539788b356da4910e5e95fb573"},
      body: body
  );
  // print("${response.statusCode}");
  
  // print("${response.body}");
  Map<String, dynamic> map = jsonDecode(response.body);
  print(map);
  if(map["Error"] == true || map["Error"] == "true"){
     _showAlert(context);
  }else{
   // savedata();
  _berhasil(context);  
  }
  return response;
}

  @override
  Widget build(BuildContext context) {
    getJsonData();
      _getCurrentLocation();
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

  Widget _buildTextFieldFotoUpload() {
    return TextField(
      controller: fotopemilik,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Pemilik Rekening",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Pemilik Rekening harus diisi",
      ),

    );
  }


  Widget _buildTextFieldNamaPemilik() {
    return TextField(
      controller: namapemilik,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Pemilik Rekening",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Pemilik Rekening harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldNameValid) {
      //     setState(() => _isFieldNameValid = isFieldValid);
      //   }
      // },
    );
  }

Widget _buildTextFieldPassword() {
    return TextField(
      controller: password,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Password harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldNameValid) {
      //     setState(() => _isFieldNameValid = isFieldValid);
      //   }
      // },
    );
  }
  Widget _buildTextFieldKonfirmasi() {
    return TextField(
      controller: konfirmasi,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Konfirmasi Password",
        errorText: _isFieldNameValid == null || _isFieldNameValid
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
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "No. Rekening harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldNameValid) {
      //     setState(() => _isFieldNameValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldNamaBank() {
    return TextField(
      controller: namabank,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Bank ",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Bank harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldNameValid) {
      //     setState(() => _isFieldNameValid = isFieldValid);
      //   }
      // },
    );
  }
Widget _buildTextFieldlimitasi() {
    return TextField(
      controller: limitasi,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Limitasi",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Limitasi harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldNameValid) {
      //     setState(() => _isFieldNameValid = isFieldValid);
      //   }
      // },
    );
  }
  Widget _buildTextFielddeskripsi() {
    return TextField(
      controller: deskripsi,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Deskripsi",
        errorText: _isFieldNameValid == null || _isFieldNameValid
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
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Perusahaan harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldNameValid) {
      //     setState(() => _isFieldNameValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldNPWP() {
    return TextField(
      controller: npwp,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "NPWP",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "NPWP harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldEmailValid) {
      //     setState(() => _isFieldEmailValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldTelepon() {
    return TextField(
      controller: telepon,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Telepon",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Nomor Telepon harus diisi",
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
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldEmailValid) {
      //     setState(() => _isFieldEmailValid = isFieldValid);
      //   }
      // },
    );
  }
  

  Widget _buildTextFieldProvinsi() {
    SizedBox(
                  height: 10,
                );
  return CustomTile("Provinsi", child: StreamBuilder<Province>(
                    stream: provinceBloc.allProvince,
                    builder: (context, snapshot) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                        value: prop,
                        isExpanded: true,
                        items: List.generate(snapshot.hasData ? snapshot.data.data.length : placeholder.length, (i) => DropdownMenuItem(
                          child: Text(snapshot.hasData ? snapshot.data.data[i].nama : placeholder[i]), value: snapshot.hasData ? snapshot.data.data[i].id : placeholder[i], )),
                        onChanged: (item){
                          setState(() {
                            if(item == null){
                            
                            }else{
                              prop = item;
                            }
                          });
                          kabupatenBloc.fetchKabupaten(prop);
                        },
                      )
                      );
                    }
                  ),);
  }

  Widget _buildTextFieldKabupaten() {
   return CustomTile("Kabupaten/Kota", child: StreamBuilder<Kabupaten>(
                    stream: kabupatenBloc.allKabupaten,
                    builder: (context, snapshot) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: kab,
                          isExpanded: true,
                          items: List.generate(snapshot.hasData ? snapshot.data.data.length : placeholder.length, (i) => DropdownMenuItem(
                            child: Text(snapshot.hasData ? snapshot.data.data[i].nama : placeholder[i]), value: snapshot.hasData ? snapshot.data.data[i].id : placeholder[i],)),
                          onChanged: (item){
                            setState(() {
                            
                              kab = item;
                            
                            });
                            kecamatanBloc.fetchKecamatan(kab);
                          },
                        ),
                      );
                    }
                  ),);
  }

Widget _buildTextFieldKecamatan() {
   return CustomTile("Kecamatan", child: StreamBuilder<Kecamatan>(
                    stream: kecamatanBloc.allKecamatan,
                    builder: (context, snapshot) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: kec,
                          isExpanded: true,
                          items: List.generate(snapshot.hasData ? snapshot.data.data.length : placeholder.length, (i) => DropdownMenuItem(
                            child: Text(snapshot.hasData ? snapshot.data.data[i].nama  : placeholder[i]), value: snapshot.hasData ? snapshot.data.data[i].id : placeholder[i],)),
                          onChanged: (item){
                            setState(() {
                              kec = item;
                            });
                          },
                        ),
                      );
                    }
                  ),);
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
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldEmailValid) {
      //     setState(() => _isFieldEmailValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldPenandaTangan() {
    return TextField(
      controller: penandatangan,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Penanda Tangan",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Form Penanda Tangan harus diisi",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldEmailValid) {
      //     setState(() => _isFieldEmailValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldPosPenandaTangan() {
    return TextField(
      controller: pospenanda,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Posisi Penanda Tangan",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Form Posisi Penanda Tangan harus diisi",
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

