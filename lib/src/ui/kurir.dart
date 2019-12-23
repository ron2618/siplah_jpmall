import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Kurir extends StatefulWidget {
  @override
  _KurirState createState() => _KurirState();
}

class _KurirState extends State<Kurir> {
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
