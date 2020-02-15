import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/produk_sample.dart';
import 'package:siplah_jpmall/src/ui/flashdeal.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';
import 'package:siplah_jpmall/src/ui/alatperaga.dart';
import 'package:siplah_jpmall/src/ui/gridkategori.dart';
import 'package:siplah_jpmall/src/ui/gridproduk.dart';
import 'package:siplah_jpmall/src/ui/imageslider.dart';
import 'package:siplah_jpmall/src/ui/myappbar.dart';
import 'package:siplah_jpmall/src/ui/myflexspace.dart';
import 'package:siplah_jpmall/src/ui/pendamping.dart' as prefix0;
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/ui/rekomtoko.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Kategori extends StatefulWidget {
  final List data;

  const Kategori({Key key, this.data}) : super(key: key);
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
   List data;
  List data2;
  List kategorilist;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url
        Uri.encodeFull('http://siplah.mascitra.co.id/api/home/list'),
        headers: {"Content-Type": "application/x-www-form-urlencoded","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"575696f2ed816e00edbfa90f917c6f757e5ce05a"},);
    print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'][0]['produk'];
      data2 = convertDataToJson['Data'][1]['produk'];
      kategorilist = convertDataToJson['Data'];
    });

    return "Success";
  }
  double posisi = 0.0;
  int currentPage = 0;
  ScrollController _controller;
  _scrollListener() {
//     if (_controller.offset >= _controller.position.maxScrollExtent &&
//         !_controller.position.outOfRange) {
//       setState(() {
//         message = "reach the bottom";
//       });
//         // print("reach the bottom");
//     }
//     if (_controller.offset <= _controller.position.minScrollExtent &&
//         !_controller.position.outOfRange) {
//       setState(() {
//         message = "reach the top";
//       });
//         // print("reach the top");
//     }
    setState(() {
      posisi = _controller.offset;
    });
  }

  @override
  void initState() {
    super.initState();
//    print("Aspect Ratio : "+MediaQuery.of(context).size.aspectRatio.toString());
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    // getJsonData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (context, inner) {
            return [
              SliverAppBar(

                automaticallyImplyLeading: false,
                title: AnimatedCrossFade(
                  
                    duration: const Duration(milliseconds: 200),
                    firstChild: MyAppBarNormal(),
                    secondChild: MyAppBarAbNormal(),
                    crossFadeState: posisi <= 27
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstCurve: Curves.bounceIn,
                    secondCurve: Curves.bounceInOut),
                // title: AnimatedContainer(
                //   duration: Duration(seconds: 3),
                //   curve: Curves.decelerate,
                //   child: _controller.offset <= 27 ? MyAppBarNormal() : MyAppBarAbNormal()
                // ),
                // title: Transform.scale(
                //   scale: 12.0,
                //   child: posisi >= 27 ? MyAppBarNormal() : MyAppBarAbNormal()),
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
          color: Colors.blueAccent),
                  child: FlexibleSpaceBar(
                    background: MyFlexSpace(),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                
               GridProduk(data: widget.data,),
                
              ]),
            ],
          )),
    );
  }
}
