// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';
// import 'package:jpmall_1_02june2019/src/ui/star.dart';

// class GridProduk extends StatefulWidget {
//   @override
//   _GridProdukState createState() => _GridProdukState();
// }

// class _GridProdukState extends State<GridProduk> {
//   var f = NumberFormat("#,##0", "en_US");
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(8.0),
//       scrollDirection: Axis.vertical,
//       itemBuilder: (context, i) {
//         return Card(
//           elevation: 2,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//             height: 100,
//             width: 100,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(image: NetworkImage(_listPro[i].link)),
//                       // color: _listPro[i].color,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10))),
//                   child: Stack(
//                     children: <Widget>[
//                       Positioned(
//                         right: 10,
//                         top: 10,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.grey,
//                           child: Icon(
//                             Icons.favorite_border,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Container(
//                   width: 150,
//                   height: 50,
//                   // color: Colors.black,
//                   child: Text(
//                     _listPro[i].name,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Container(
//                   width: 150,
//                   // color: Colors.black,
//                   child: Text(
//                     "Rp " + f.format(_listPro[i].price),
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 8.0,
//                 ),
//                 Container(
//                   width: 150,
//                   height: 20,
//                   child: Row(
//                     children: <Widget>[
//                       _listPro[i].official == true
//                           ? CircleAvatar(
//                               child: Icon(
//                                 Icons.store,
//                                 size: 22,
//                                 color: Colors.red,
//                               ),
//                               minRadius: 13,
//                               backgroundColor: Colors.amber,
//                               foregroundColor: Colors.red,
//                             )
//                           : Container(),
//                       SizedBox(width: _listPro[i].official == true ? 5.0 : 0),
//                       Text(_listPro[i].country)
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 Container(
//                     width: 150,
//                     child: StarDisplay(
//                       value: _listPro[i].index,
//                     ))
//               ],
//             ),
//           ),
//         );
//       },
//       itemCount: _listPro.length,
//       shrinkWrap: true,
//       physics: ScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 2.0,
//           mainAxisSpacing: 2.0,
//           childAspectRatio: 0.55),
//     );
//   }
// }

// class ProList {
//   final Color color;
//   final int index;
//   final String name;
//   final String link;
//   final int price;
//   final double qty;
//   final double boughted;
//   final String country;
//   final bool official;

//   ProList(
//       {this.color,
//       this.index,
//       this.name,
//       this.link,
//       this.price,
//       this.qty,
//       this.official,
//       this.boughted,
//       this.country});
// }

// List<ProList> _listPro = <ProList>[
//   ProList(
//       color: Colors.red,
//       index: 1,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Ichinose Chizuru Makinohara Shoko 12",
//       price: 150000,
//       qty: 1,
//       country: "Jakarta",
//       official: true,
//       boughted: 0),
//   ProList(
//       color: Colors.cyan,
//       index: 2,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-sd-panduan-praktis-pengembangan-karakter-dan-budaya-bangsa.jpg",
//       name: "Makinohara Shoko",
//       price: 60000,
//       qty: 3,
//       country: "Lumajang",
//       official: false,
//       boughted: 2),
//   ProList(
//       color: Colors.green,
//       index: 3,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-buku-harian-kirana-tentang-sahabatku-dan-indonesiaku.jpg",
//       name: "Sakurajima Mai",
//       price: 105000,
//       qty: 5,
//       country: "Surabaya",
//       official: true,
//       boughted: 3),
//   ProList(
//       color: Colors.lime,
//       index: 4,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-belajar-berbahagia.jpg",
//       name: "Yuki Setsuna",
//       price: 1150000,
//       qty: 10,
//       country: "Kalimantan",
//       official: false,
//       boughted: 5),
//   ProList(
//       color: Colors.blue,
//       index: 5,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Aragaki Ayase",
//       price: 5000,
//       qty: 4,
//       country: "Malang",
//       official: false,
//       boughted: 2),
//   ProList(
//       color: Colors.red,
//       index: 1,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Ichinose Chizuru",
//       price: 150000,
//       qty: 1,
//       country: "Yogyakarta",
//       official: false,
//       boughted: 0),
//   ProList(
//       color: Colors.cyan,
//       index: 2,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Makinohara Shoko",
//       price: 60000,
//       qty: 3,
//       country: "Bogor",
//       official: false,
//       boughted: 2),
//   ProList(
//       color: Colors.green,
//       index: 3,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Sakurajima Mai",
//       price: 105000,
//       qty: 5,
//       country: "Depok",
//       official: false,
//       boughted: 3),
//   ProList(
//       color: Colors.lime,
//       index: 4,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Yuki Setsuna",
//       price: 1150000,
//       qty: 10,
//       country: "Lampung",
//       official: true,
//       boughted: 5),
//   ProList(
//       color: Colors.blue,
//       index: 5,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Aragaki Ayase",
//       price: 5000,
//       qty: 4,
//       country: "Sumatera Utara",
//       official: true,
//       boughted: 2),
//   ProList(
//       color: Colors.red,
//       index: 1,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Ichinose Chizuru",
//       price: 150000,
//       qty: 1,
//       country: "Bandung",
//       official: false,
//       boughted: 0),
//   ProList(
//       color: Colors.cyan,
//       index: 2,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Makinohara Shoko",
//       price: 60000,
//       qty: 3,
//       country: "Jakarta Utara",
//       official: false,
//       boughted: 2),
//   ProList(
//       color: Colors.green,
//       index: 3,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Sakurajima Mai",
//       price: 105000,
//       qty: 5,
//       country: "Maluku",
//       official: true,
//       boughted: 3),
//   ProList(
//       color: Colors.lime,
//       index: 4,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Yuki Setsuna",
//       price: 1150000,
//       qty: 10,
//       country: "Bali",
//       official: true,
//       boughted: 5),
//   ProList(
//       color: Colors.blue,
//       index: 5,
//       link: "http://mascitra.co.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg",
//       name: "Aragaki Ayase",
//       price: 5000,
//       qty: 4,
//       country: "Banyuwangi",
//       official: true,
//       boughted: 2),
// ];
