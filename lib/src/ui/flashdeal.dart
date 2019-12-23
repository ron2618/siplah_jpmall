import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/models/produk_sample.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';

// class FlashDeal extends StatefulWidget {
//   @override
//   _FlashDealState createState() => _FlashDealState();
// }

// class _FlashDealState extends State<FlashDeal> {
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
//           "FlashDeal " +
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
//                 "FlashDeal",
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

class FlashDeal extends StatefulWidget {
  final List<Produk> data;

  const FlashDeal({Key key, this.data}) : super(key: key);
  @override
  _FlashDealState createState() => _FlashDealState();
}

class _FlashDealState extends State<FlashDeal> {
  var f = NumberFormat("#,##0", "en_US");
  List<String> satu = ["Buku Guru Pendidikan Jasmani Olahraga dan Kesehatan Kelas VII","","Third","4"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.blue[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3
          )
        ]
      ),
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
              _kiri(),
              SizedBox(
                width: 8.0,
              ),
              _kanan(),
            ],
          )
        ],
      ),
    );
  }

  _kiri() {
    return Container(
      child: SizedBox(
        height: 220,
        width: 150,
        child: Container(
//            color: Colors.brown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 15,),
            Text("Paket Utama K13", style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,),
            SizedBox(height: 10,),
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
            MaterialButton(onPressed: (){}, child: Text("Lihat Semua"), color: Colors.white,)
          ],
        ),),
      ),
    );
  }

  _kanan() {
    return Container(
      height: 230,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 350),
                      pageBuilder: (context, _, __) =>
                          DetailProduk2())),
              child: Container(
                width: 130,
                height: 200,
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
                        child: Image.network("http://siplah.blanja.com/public/products/502/6104/gm0709-bg-pjok-.1563508279.jpg", fit: BoxFit.cover,),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.black26,
                            blurRadius: 5.0
                            )
                          ]
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 110,
                      child: Text(
                        "Buku Guru Pendidikan Jasmani Olahraga dan Kesehatan Kelas VII  ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 110,
                      child: Text(
                        "Rp " + f.format(27000),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 10,
                      width: 100,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 10,
                            width: i / 2 * 100,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(3)),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: 100,
                      child: Text("Tersisa ${(i)}"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

