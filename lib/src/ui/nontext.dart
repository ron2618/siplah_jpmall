import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/models/produk_sample.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class Nontext extends StatefulWidget {
//   @override
//   _NontextState createState() => _NontextState();
// }

// class _NontextState extends State<Nontext> {
//   var v = NumberFormat("en_US", "#,##0");
//   ScrollController controller;

//   double posisi = 0;

//   @override
//   void initState() {
//     super.initState();
//     controller = ScrollController();
//     controller.addListener(onScroll);
//   }

//   onScroll() {
//     setState(() {
//       posisi = controller.offset;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 320,
//       child: Stack(
//         children: <Widget>[
//           bawah(),
//           posisi >= 150 ? atas() : Container(),
//         ],
//       ),
//     );
//   }

//   atas() {
//     return Container(
//       child: Positioned(
//         top: 10,
//         left: 10,
//         child: Text(
//           "Nontext " +
//               DateTime.now().hour.toString() +
//               " : " +
//               DateTime.now().minute.toString() +
//               " : " +
//               DateTime.now().second.toString(),
//           style: TextStyle(
//               color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }

//   bawah() {
//     return Container(
//       height: 320,
//       color: Colors.redAccent,
//       padding: const EdgeInsets.only(top: 30, left: 8.0, bottom: 8.0, right: 8),
//       child: ListView(
//         physics: ScrollPhysics(),
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         controller: controller,
//         children: <Widget>[
//           Row(children: <Widget>[
//             SizedBox(
//               width: 18,
//             ),
//             _barkiri(),
//             SizedBox(
//               width: 18,
//             ),
//             _listproduk(),
//           ]),
//         ],
//       ),
//     );
//   }

//   _barkiri() {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.brown, borderRadius: BorderRadius.circular(20)),
//       child: Stack(
//         children: <Widget>[
//           Align(
//             alignment: Alignment.topCenter,
//             // heightFactor: 10,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: Container(
//                 height: 65,
//                 width: 65,
//                 decoration:
//                     BoxDecoration(shape: BoxShape.circle, color: Colors.white),
//                 child: Center(
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 40,
//             left: 10,
//             child: Container(
//               child: Text(
//                 "Nontext",
//                 style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 10,
//             child: Container(
//               child: Text(
//                 DateTime.now().hour.toString() +
//                     " : " +
//                     DateTime.now().minute.toString() +
//                     " : " +
//                     DateTime.now().second.toString(),
//                 style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//       height: 180,
//       width: 120,
//     );
//   }

//   _listproduk() {
//     return Container(
//         height: 250,
//         child: ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, i) {
//             return Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//               child: Container(
//                 // height: 180,
//                 width: 150,
//                 color: Colors.white,
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       height: 110,
//                       width: 120,
//                       decoration: BoxDecoration(
//                           color: _hitemleis[i].color,
//                           borderRadius: BorderRadius.circular(10.0)),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Container(
//                       width: 120,
//                       child: Text(_hitemleis[i].name, style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w600
//                       ),),
//                     ),
//                     Container(
//                       width: 120,
//                       child: Text("Rp "+v.format(_hitemleis[i].price), style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w600
//                       ),),
//                     ),

//                   ],
//                 ),
//               ),
//             );
//           },
//           itemCount: _hitemleis.length,
//         ));
//   }
// }

class Nontext extends StatefulWidget {
  final List data;
  final String kategori;
  final String level;
  final String id;

  const Nontext({Key key, this.data, this.kategori, this.level, this.id}) : super(key: key);  



  @override
  _NontextState createState() => _NontextState();
}

class _NontextState extends State<Nontext> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     changeIndex();

  }
  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }
 List colors = [Colors.white, Colors.white, Colors.white];
  Random random = new Random();
  var f = NumberFormat("#,##0", "en_US");
  List<String> satu = [
    "Buku Guru Pendidikan Jasmani Olahraga dan Kesehatan Kelas VII",
    "",
    "Third",
    "4"
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
   
    return Container(
      height: 225,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: colors[index], boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3)
      ]),
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 8.0,
              ),
              widget.kategori != null
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          image: DecorationImage(
                              image:
                                  NetworkImage(widget.kategori!=null?widget.kategori:'http://siplah.mascitra.co.id/assets/images/no-image.png'))),
                      child: SizedBox(
                        height: 220,
                        width: 150,
                        child: Container(
//            color: Colors.brown,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              // Text(widget.kategori != null ?widget.kategori[0]['nama'] : 'loading....', style: TextStyle(
                              //   color: Colors.white,
                              //   fontSize: 20

                              //   ,
                              //   fontWeight: FontWeight.w500
                              // ),
                              // textAlign: TextAlign.center,),
                              SizedBox(
                                height: 120,
                              ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                Container(
//                  height: 30,
//                  width: 30,
//                  child: Center(
//                    child: Text("00"),
//                  ),
//                  decoration: BoxDecoration(
//                      color: Colors.orange,
//                      borderRadius: BorderRadius.circular(8.0)
//                  ),
//                ),
//                Text(" : ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
//                Container(
//                  height: 30,
//                  width: 30,
//                  child: Center(
//                    child: Text("00"),
//                  ),
//                  decoration: BoxDecoration(
//                      color: Colors.orange,
//                      borderRadius: BorderRadius.circular(8.0)
//                  ),
//                ),
//                Text(" : ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
//                Container(
//                  height: 30,
//                  width: 30,
//                  child: Center(
//                    child: Text("00"),
//                  ),
//                  decoration: BoxDecoration(
//                      color: Colors.orange,
//                      borderRadius: BorderRadius.circular(8.0)
//                  ),
//                ),
//              ],
//            ),
            SizedBox(height: 20,),
            
          ],
        ),),
      ),
    ):Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          image: DecorationImage(
                              image:
                                  NetworkImage('http://siplah.mascitra.co.id/assets/images/no-image.png'))),
                      child: SizedBox(
                        height: 220,
                        width: 150,
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                        
                              SizedBox(
                                height: 120,
                              ),
            SizedBox(height: 20,),
            
          ],
        ),),
      )
    ),

    //end
              SizedBox(
                width: 8.0,
              ),
              Container(
                height: 180,
                decoration: BoxDecoration(
                    color: colors[index],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 3),
                          blurRadius: 3)
                    ]),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: widget.data == null ? 0 : widget.data.length,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                     
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 350),
                                  pageBuilder: (context, _, __) => DetailProduk2(
                                    penjual_id:widget.data[index]['user_id'],
                                    penjual_user_id:widget.data[index]['user_id'],
                                    produk_id:widget.data[index]['id'],
                                    id: widget.id,
                                    level: widget.level,
                                      nama: widget.data[index]['produk'],
                                      gambar: widget.data[index]['foto'] != null
                                          ? widget.data[index]['foto'][0]
                                              ['foto']
                                          : 'http://siplah.mascitra.co.id/assets/images/no-image.png',
                                      harga: widget.data[index]['harga']))),
                                    
                          child: Container(
                            width: 130,
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 8.0,
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Container(
                                    child: Image.network(
                                      widget.data[index]['foto'] !=
                                              null
                                          ? widget.data[index]['foto'][0]
                                              ['foto']
                                          : 'http://siplah.mascitra.co.id/assets/images/no-image.png',
                                      fit: BoxFit.cover,
                                    ),
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 5.0)
                                        ]),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 110,
                                  child: Text(
                                    widget.data[index]['produk'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Text(
                                     widget.data[index]['harga'] != '0'
                                        ?"Rp " + widget.data[index]['harga']
                                        : "harga zona",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//nontext baru

class Nontextbaru extends StatefulWidget {
  final List data;
  final String kategori;
  final String level;
  final String id;

  const Nontextbaru({Key key, this.data, this.kategori, this.level, this.id}) : super(key: key);  



  @override
  _NontextStatebaru createState() => _NontextStatebaru();
}

class _NontextStatebaru extends State<Nontextbaru> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     changeIndex();

  }
  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }
 List colors = [Colors.white, Colors.white, Colors.white];
  Random random = new Random();
  var f = NumberFormat("#,##0", "en_US");
  List<String> satu = [
    "Buku Guru Pendidikan Jasmani Olahraga dan Kesehatan Kelas VII",
    "",
    "Third",
    "4"
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
   
    return Container(
      height: 225,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: colors[index], boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3)
      ]),
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 8.0,
              ),


    //end
              SizedBox(
                width: 8.0,
              ),
              Container(
                height: 180,
                decoration: BoxDecoration(
                    color: colors[index],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 3),
                          blurRadius: 3)
                    ]),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: widget.data == null ? 0 : 5,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                     
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 350),
                                  pageBuilder: (context, _, __) => DetailProduk2(
                                    penjual_id:widget.data[index]['user_id'],
                                    penjual_user_id:widget.data[index]['user_id'],
                                    produk_id:widget.data[index]['id'],
                                    id: widget.id,
                                    level: widget.level,
                                      nama: widget.data[index]['produk'],
                                      gambar: widget.data[index]['foto'] != null
                                          ? widget.data[index]['foto'][0]
                                              ['foto']
                                          : 'http://siplah.mascitra.co.id/assets/images/no-image.png',
                                      harga: widget.data[index]['harga']))),
                                    
                          child: Container(
                            width: 130,
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 8.0,
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Container(
                                    child: Image.network(
                                      widget.data[index]['foto'] !=
                                              null
                                          ? widget.data[index]['foto'][0]
                                              ['foto']
                                          : 'http://siplah.mascitra.co.id/assets/images/no-image.png',
                                      fit: BoxFit.cover,
                                    ),
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 5.0)
                                        ]),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 110,
                                  child: Text(
                                    widget.data[index]['produk'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Text(
                                     widget.data[index]['harga'] != '0'
                                        ?"Rp " + widget.data[index]['harga']
                                        : "harga zona",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}