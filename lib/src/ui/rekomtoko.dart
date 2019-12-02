import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/models/model_mitra.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class RekomToko extends StatefulWidget {
  @override
  _RekomTokoState createState() => _RekomTokoState();
}

class _RekomTokoState extends State<RekomToko> {
 int loading = 0; 
  int _current = 0;
     List data;
   Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url
        Uri.encodeFull('https://siplah.mascitra.co.id/api/admin/data_mitra/list'),
        headers: {"Content-Type": "application/x-www-form-urlencoded","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"5b4eefd43a64c539788b356da4910e5e95fb573"},);
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      loading = 1;
    });
    }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJsonData();
  }
  @override
  Widget build(BuildContext context) {
  
    num currentPage = 0;
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Mitra JPMALL", style: TextStyle(
                fontSize: 16
              ),),
              Text("Lihat Semua", style: TextStyle(
                fontSize: 16
              ),)
            ],
          )
        ),
        Container(
          height: 130,
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // physics: ScrollPhysics(),
            // shrinkWrap: true,
            itemCount:_listToko.length,
            itemBuilder: (context, i) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                   
                    child: Image.network(loading == 1 && data[i]['foto']!=null ? data[i]['foto'] : ('https://siplah.mascitra.co.id/assets/images/no-image.png')),
                   
                  )),
              );
            },
          ),
        ),
  //   Container(
  //     height: 100,
  //     width: MediaQuery.of(context).size.width,
  //     child: Stack(
  //       children: <Widget>[
  //         CarouselSlider(
  //           autoPlay: true,
  //  autoPlayInterval: Duration(seconds: 3),
  //  autoPlayAnimationDuration: Duration(milliseconds: 800),
  //  pauseAutoPlayOnTouch: Duration(seconds: 10),

  //           reverse: false,
  //           enableInfiniteScroll: true,
  //           initialPage: currentPage,
  //           aspectRatio: 16 / 9,
  //             items: [0,1,2].map((i) {
              
  //             return Builder(
  //               builder: (context) {
  //                 return Container(
  //                   // child:

  //                   padding: const EdgeInsets.only(top: 10, bottom: 10),

  //                   width: MediaQuery.of(context).size.width,

  //                   // height: 100,

  //                   margin: EdgeInsets.symmetric(horizontal: 5.0),

  //                   // child: ,

  //                   decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                           image: NetworkImage(loading == 1 ? data[i]['foto'] : 'https://miro.medium.com/max/896/1*n3HjQJQ1pbWkavIttP69UQ.gif'), fit: BoxFit.fill),
  //                       color: Colors.yellow,
  //                       borderRadius: BorderRadius.circular(8.0)),
  //                 );
                     
  //               },
  //             );
  //           }).toList(),
  //           height: Curves.easeIn.transform(1) * 100,
           
  //           enlargeCenterPage: true,
  //           onPageChanged: (index) {
  //             setState(() {
  //               _current = index;
  //             });
          
  //           },
  //         ),
  //         Positioned(
  //           // alignment: Alignment.bottomLeft,
  //           bottom: -5.0,
  //           right: 0.0,
  //           left: 0.0,

  //           child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: _listToko.map((f) {
  //                 return Container(
  //                   width: 8.0,
  //                   height: 8.0,
  //                   margin:
  //                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
  //                   decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       color: _current == f.index
  //                           ? Colors.red[400]
  //                           : Color.fromRGBO(0, 0, 0, 0.4)),
  //                 );
  //               }).toList()),
  //         )
  //       ],
  //     ),
  //   ),
      ],
    );
  }
}

class TokoList {
  final int index;
  final String nama;
  final String lokasi;
  final Color color;

  TokoList({this.index, this.nama, this.lokasi, this.color});
}

List<TokoList> _listToko = <TokoList>[
  TokoList(
      index: 1, nama: "http://jpmall.intern.mascitra.co.id/assets/images/icon/logo_saja.png", lokasi: "Jakarta", color: Colors.amber),
  TokoList(
      index: 2, nama: "http://ecs7.tokopedia.net/img/cache/215-square/shops-1/2019/2/12/5394723/5394723_fdb8279a-a94d-4683-8de5-019aabd91f30.jpg", lokasi: "Semarang", color: Colors.lightGreen),
  TokoList(
      index: 3, nama: "http://jpmall.intern.mascitra.co.id/assets/images/icon/gramedia.jpg", lokasi: "Surabaya", color: Colors.lime),
  TokoList(
      index: 3, nama: "http://upload.wikimedia.org/wikipedia/id/5/5b/Esis.jpg", lokasi: "Surabaya", color: Colors.lime),
];
