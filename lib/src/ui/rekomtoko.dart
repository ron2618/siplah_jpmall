 import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
// import 'package:siplah_jpmall/src/models/model_mitra.dart';
// import 'package:http/http.dart' as http;
import 'dart:async';

// class RekomToko extends StatefulWidget {
//   @override
//   _RekomTokoState createState() => _RekomTokoState();
// }

// class _RekomTokoState extends State<RekomToko> {
//   int loading = 0;
//   int _current = 0;
//   List data;
//   Future<String> getJsonData() async {
//     var response = await http.post(
//       //Encode the url
//       Uri.encodeFull('http://siplah.mascitra.co.id/api/admin/data_mitra/list'),
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded",
//         "API-App": "siplah_jpmall.id",
//         "Api-Key": "4P1_7Pm411_51p114h",
//         "API-Token": $Token({this.apitoken})fd43a64c539788b356da4910e5e95fb573"
//       },
//     );
//     //print(response.body);
//     setState(() {
//       // ignore: deprecated_member_use
//       var convertDataToJson = json.decode(response.body);
//       data = convertDataToJson['Data'];
//       loading = 1;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
   
//   }

//   @override
//   Widget build(BuildContext context) {
//      getJsonData();
//     num currentPage = 0;
//     return Column(
//       children: <Widget>[
//         Container(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   "Mitra JPMALL",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 InkWell(
//                   onTap: () => {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (BuildContext context) => LihatMitra(),
//                         )),
//                   },
//                   child: Container(
//                     child: Text(
//                       'Lihat Mitra',
//                       style: TextStyle(fontSize: 16),
//                       textAlign: TextAlign.right,
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//         Container(
//           height: 130,
//           padding: const EdgeInsets.all(8.0),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             // physics: ScrollPhysics(),
//             // shrinkWrap: true,
//             itemCount: data.length,
//             itemBuilder: (context, i) {
//               return Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0)),
//                 child: SizedBox(
//                     height: 100,
//                     width: 100,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.network(loading == 1 &&
//                               data[i]['foto'] != null
//                           ? data[i]['foto']
//                           : ('http://siplah.mascitra.co.id/assets/images/no-image.png')),
//                     )),
//               );
//             },
//           ),
//         ),
    
//       ],
//     );
//   }
// }

// class LihatMitra extends StatefulWidget {
//   @override
//   _LihatMitra createState() => _LihatMitra();
// }

// class _LihatMitra extends State<LihatMitra> {
//   int loading = 0;
//   int _current = 0;
//   List data;
//   Future<String> getJsonData() async {
//     var response = await http.post(
//       //Encode the url
//       Uri.encodeFull('http://siplah.mascitra.co.id/api/admin/data_mitra/list'),
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded",
//         "API-App": "siplah_jpmall.id",
//         "Api-Key": "4P1_7Pm411_51p114h",
//         "API-Token": $Token({this.apitoken})fd43a64c539788b356da4910e5e95fb573"
//       },
//     );
//     //print(response.body);
//     setState(() {
//       // ignore: deprecated_member_use
//       var convertDataToJson = json.decode(response.body);
//       data = convertDataToJson['Data'];
//       loading = 1;
//       print(data.length);
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     getJsonData();
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text(
//           "List Mitra",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Container(
//         child: ListView.builder(
//           scrollDirection: Axis.vertical,
//           // physics: ScrollPhysics(),
//           // shrinkWrap: true,
//           itemCount: data.length,
//           itemBuilder: (context, i) {
//             return Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0)),
//               child: SizedBox(
//                   height: 100,
//                   width: 100,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.network(loading == 1 && data[i]['foto'] != null
//                         ? data[i]['foto']
//                         : ('http://siplah.mascitra.co.id/assets/images/no-image.png')),
//                   )),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class TokoList {
//   final int index;
//   final String nama;
//   final String lokasi;
//   final Color color;

//   TokoList({this.index, this.nama, this.lokasi, this.color});
// }

// List<TokoList> _listToko = <TokoList>[
//   TokoList(
//       index: 1,
//       nama:
//           "http://jpmall.intern.mascitra.co.id/assets/images/icon/logo_saja.png",
//       lokasi: "Jakarta",
//       color: Colors.amber),
//   TokoList(
//       index: 2,
//       nama:
//           "http://ecs7.tokopedia.net/img/cache/215-square/shops-1/2019/2/12/5394723/5394723_fdb8279a-a94d-4683-8de5-019aabd91f30.jpg",
//       lokasi: "Semarang",
//       color: Colors.lightGreen),
//   TokoList(
//       index: 3,
//       nama:
//           "http://jpmall.intern.mascitra.co.id/assets/images/icon/gramedia.jpg",
//       lokasi: "Surabaya",
//       color: Colors.lime),
//   TokoList(
//       index: 3,
//       nama: "http://upload.wikimedia.org/wikipedia/id/5/5b/Esis.jpg",
//       lokasi: "Surabaya",
//       color: Colors.lime),
// ];
class RekomToko extends StatefulWidget {
   @override
   _RekomTokoState createState() => _RekomTokoState();
 }

 class _RekomTokoState extends State<RekomToko> {

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Column(
     children: <Widget>[
       //Text('Tidak Tersedia')
     ],
      
    );
  }
}
