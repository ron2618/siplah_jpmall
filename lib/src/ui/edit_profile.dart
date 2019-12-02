
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    getCredential();
   
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
    bool _isLoading = false;
 
  bool _isFieldNameValid;
  bool _isFieldEmailValid;
  bool _isFieldAgeValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                _buildTextFieldEmail(),
                _buildTextFieldNoRekening(),
                _buildTextFieldNamaBank(),
                _buildTextFieldNama(),
                _buildTextFieldNPWP(),
                _buildTextFieldTelepon(),
                _buildTextFieldAlamat(),
                _buildTextFieldProvinsi(),
                _buildTextFieldKabupaten(),
                _buildTextFieldKodepos(),
                _buildTextFieldPenandaTangan(),
                _buildTextFieldPosPenandaTangan(),
                
                

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
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

  Widget _buildTextFieldNamaPemilik() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Pemilik Rekening",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Pemilik Rekening harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNoRekening() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "No. Rekening",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "No. Rekening harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNamaBank() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Bank ",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Bank harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNama() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Perusahaan",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Nama Perusahaan harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNPWP() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "NPWP",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "NPWP harus diisi",
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
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Telepon",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Nomor Telepon harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAlamat() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Alamat",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Alamat harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldProvinsi() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Provinsi",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Provinsi harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldKabupaten() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Kabupaten",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Kabupaten harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldKodepos() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Kode Pos",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Kode Pos harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }


  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _controllerEmail,
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
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Penanda Tangan",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Form Penanda Tangan harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPosPenandaTangan() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Posisi Penanda Tangan",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Form Posisi Penanda Tangan harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }
  
}

