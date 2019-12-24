import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Kurir extends StatefulWidget {
  @override
  _KurirState createState() => _KurirState();
}

class _KurirState extends State<Kurir> {
    String nama;
  List data;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull(
            'https://siplah.mascitra.co.id/rajaongkir/ongkir/kurir'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "5b4eefd43a64c539788b356da4910e5e95fb573"
        },
        body: {
          "user_id": "" + nama,
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
    });
    //print("id o= " + nama);
  }

  //end

  int _rgProgramming = -1;
  String _selectedValue;

  final List<RadioGroup> _programmingList = [
    RadioGroup(index: 1, text: "Kotlin"),
    // RadioGroup(index: 2, text: "Swift"),
    // RadioGroup(index: 3, text: "Flutter"),
    // RadioGroup(index: 4, text: "Java"),
    // RadioGroup(index: 5, text: "React Native"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: new Text(
          "Pilih Kurir",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Card(
              margin: new EdgeInsets.only(top: 8.0, bottom: 5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 4.0,
              child: Container(
                height: 400,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _programmingList
                                .map((programming) => RadioListTile(
                                      title: Text(programming.text),
                                      value: programming.index,
                                      groupValue: _rgProgramming,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      dense: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _rgProgramming = value;
                                          _selectedValue = programming.text;
                                        });
                                      },
                                    )
                                    )
                                .toList(),
                          )
                          // Center(
                          //   child: Text(
                          //     _selectedValue == null
                          //         ? "Belum memilih"
                          //         : _selectedValue,
                          //     style: TextStyle(
                          //         fontSize: 20.0,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildRadioButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _programmingList
          .map((programming) => RadioListTile(
                title: Text(programming.text),
                value: programming.index,
                groupValue: _rgProgramming,
                controlAffinity: ListTileControlAffinity.trailing,
                dense: true,
                onChanged: (value) {
                  setState(() {
                    _rgProgramming = value;
                    _selectedValue = programming.text;
                  });
                },
              ))
          .toList(),
    );
  }
}

class RadioGroup {
  final int index;
  final String text;
  RadioGroup({this.index, this.text});
}
