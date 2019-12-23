import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

// class MyAppBar extends StatelessWidget {
//   // final String hello;
//   // final double appBarHeight = 66.0;

//   const MyAppBar();
//   @override
//   Widget build(BuildContext context) {

    
//   }
// }

class MyAppBarNormal extends StatefulWidget {
  @override
  _MyAppBarNormalState createState() => _MyAppBarNormalState();
}

class _MyAppBarNormalState extends State<MyAppBarNormal> {
  final double appBarHeight = 66.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         Container(
            height: 40,
            width: 140,
            decoration: new BoxDecoration(
          image: new DecorationImage(image: AssetImage("src/image/Icons_SIPLAH_JPSTORE_2020.png"),
          fit: BoxFit.scaleDown),
            ),
         ),
              ],
      )
    );
  }
}

class MyAppBarAbNormal extends StatefulWidget {
  @override
  _MyAppBarAbNormalState createState() => _MyAppBarAbNormalState();
}

class _MyAppBarAbNormalState extends State<MyAppBarAbNormal> {
  final double appBarHeight = 66.0;
  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double widthSearchBar = screenwidth - 150;

    return Container(
      height: appBarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 50,
            width: 100,
            decoration: new BoxDecoration(
          image: new DecorationImage(image: AssetImage("src/image/Icons_SIPLAH_JPSTORE_2020.png"),
          fit: BoxFit.fill)
        ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
          height: 40,
          width: widthSearchBar,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Cari Produk",
                prefixIcon: Icon(Icons.search)),
          ),
        )
        ],
      )
    );
  }
}