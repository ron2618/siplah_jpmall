import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
// import 'package:share/share.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/main.dart';
import 'package:siplah_jpmall/src/bloc/state_bloc.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/produk_sample.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';
import 'package:siplah_jpmall/src/ui/star.dart';
// import 'package:siplah_jpmall/src/ui/star.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DetailProduk extends StatefulWidget {
  final String nama;
  final String harga;
  final String gambar;

  const DetailProduk({Key key, this.nama, this.harga, this.gambar}) : super(key: key);
  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk>
    with TickerProviderStateMixin {
  PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true,
      initialPage: currentPage,
    );
 
  }
//  share(BuildContext context) {
//   final RenderBox box = context.findRenderObject();

//   Share.share("http://www.google.com");
// }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(
              margin: EdgeInsets.only(left: 25),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              )),
          elevation: 0.0,
          actions: <Widget>[
            
            Container(
              margin: EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: () => print("lolo"),
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              ),
            )
          
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                        height: 300,
                        child: PageView(
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          controller: pageController,
                          children: List.generate(5, (f){
                            return Hero(
                              tag: widget.gambar,
                              child: Container(
                                height: 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.gambar))),
                              ),
                            );
                          })
                        ),
                      )
                    ),
                  ]),
                  Positioned(
                    top: 350,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      // width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(5, (i){
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Container(
                              height: 2,
                              width: 40,
                              color: currentPage == i ? Colors.cyan : Colors.grey,
                            ),
                          );
                        })
                      ),
                    ),
                  )
                ],
              ),
              // AppBar(
              //   backgroundColor: Colors.transparent,
              //   elevation: 0.0,
              // ),
           
            ],
          ),
        ));
  }
}

class DetailProduk2 extends StatefulWidget {
   final String nama;
  final String harga;
  final String gambar;
  final String level;
  final String id;
  final String produk_id;
  final String penjual_user_id;
  final String penjual_id;

  const DetailProduk2({Key key, this.nama, this.harga, this.gambar, this.level, this.id, this.produk_id, this.penjual_user_id, this.penjual_id}) : super(key: key);


 
  
  @override
  _DetailProduk2State createState() => _DetailProduk2State();
}

class _DetailProduk2State extends State<DetailProduk2>
    with TickerProviderStateMixin {
  PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true,
      initialPage: currentPage,
      
    );
   

  }
  
  Future<void> share() async {
    String a=widget.nama;
    await FlutterShare.share(
      title: widget.nama,
      text: widget.nama,
      linkUrl: "http://siplah.mascitra.co.id/search/?q="+widget.nama.replaceAll(" ", "+").replaceAll(",", "%2C").replaceAll(":", "%3A"),
      chooserTitle: widget.nama
      
    );
    
  }
  
   List data;
  List data2;
  List kategorilist;
  Future<String> getJsonData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/sekolah/keranjang/tambah'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        "user_id":widget.id,
        "penjual_id":widget.penjual_id,
        "produk_id":widget.produk_id,
        "penjual_user_id":widget.penjual_user_id,
        "jumlah":'3',

      },
    );
    
     //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
    });

    return "Success";
  }
   void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Yakin Mau Membeli"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("OK"),
                  onPressed:() {
                    Navigator.of(context).pop();
                    getJsonData();
                  }
                ),
              ],
            ));
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(
              margin: EdgeInsets.only(left: 25),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              )),
          elevation: 0.0,
          actions: <Widget>[
             Container(
              margin: EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: () => share(),
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          height: 300,
                          child: PageView(
                              onPageChanged: (index) {
                                setState(() {
                                  currentPage = index;
                                });
                              },
                              controller: pageController,
                              children: List.generate(2, (f){
                                return Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              widget.gambar))),
                                );
                              })
                          ),
                        )
                    ),
                  ]),
                  Positioned(
                    top: 350,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      // width: 150,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(2, (i){
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Container(
                                height: 2,
                                width: 40,
                                color: currentPage == i ? Colors.cyan : Colors.grey,
                              ),
                            );
                          })
                      ),
                    ),
                  )
                ],
              ),
              // AppBar(
              //   backgroundColor: Colors.transparent,
              //   elevation: 0.0,
              // ),
             CustomBottomSheet(
               nama: widget.nama,gambar: widget.gambar,harga: widget.harga == '0'?"Rp "+ widget.harga:"Rp "+widget.harga,penjual_user_id: widget.penjual_user_id,produk_id:widget.produk_id
             ),
            ],
          ),
          
        ),
       bottomNavigationBar:widget.level=='2'?Container(
         decoration: BoxDecoration(
           boxShadow: [
             BoxShadow(
               blurRadius: 4,
               color: Colors.grey
             )
           ],
           border: Border(
             top: BorderSide(width: 2,color: Colors.grey[100]),
           ),
         ),
         child: Row(
           children: <Widget>[
             GestureDetector(
             onTap: (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CartsPage(),
                            ));
             },
             child:Container(
               height: 60,
               width: MediaQuery.of(context).size.width/3,
               color: Colors.white,
               child: Center(child: IconButton(icon: Icon(Icons.shopping_cart,size: 30,)),),
             ),
             ),
             GestureDetector(
               onTap: (){
                  _showAlert(context);
                 
               },
                            child: Container(
                 height: 60,
                 width: MediaQuery.of(context).size.width/1.5,
                 color: Colors.pink,
                 child: Center(child: Text("Beli",style: TextStyle(fontSize: 20,     color: Colors.white),)),
               ),
             ),
            
           ],
         ),
       ):Container(
         decoration: BoxDecoration(
           boxShadow: [
             BoxShadow(
               blurRadius: 4,
               color: Colors.grey
             )
           ],
           border: Border(
             top: BorderSide(width: 2,color: Colors.grey[100]),
           ),
         ),
         child: Row(
           children: <Widget>[
             Container(
               height: 0,
               width: MediaQuery.of(context).size.width/5,
               color: Colors.white,
               child: Center(child: IconButton(icon: Icon(Icons.shopping_cart,size: 30,)),),
             ),
             Container(
               height: 0,
               width: MediaQuery.of(context).size.width/3.5,
               color: Colors.pink,
               child: Center(child: Text("Beli",style: TextStyle(fontSize: 20,     color: Colors.white),)),
             ),
              Expanded(
                            child: Container(
                 height: 0,
                 width: MediaQuery.of(context).size.width/2,
                 color: Colors.purple,
                   child: Center(child: Text("Negosiasi",style: TextStyle(fontSize: 20,     color: Colors.white),)),
             
             ),
              ),
           ],
         ),
       ),
        );
        
  }
}

class SheetContainer extends StatelessWidget {
  final String nama;
  final String harga;
  final String gambar;
  final String penjual_user_id;
  final String produk_id;

  const SheetContainer({Key key, this.nama, this.harga, this.gambar, this.penjual_user_id, this.produk_id}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    // double sheetItemHeight = 110;
    //print(nama);
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          color: Color(0xfff1f1f1)),
      child: Column(
        children: <Widget>[
          drawerHandle(),
          Expanded(
              flex: 1,
              child: SheetItems(
                nama: nama,gambar: gambar,harga: harga,penjual_user_id: penjual_user_id,produk_id:produk_id )
          )],
      ),
    );
  }

  drawerHandle() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 3,
      width: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xffd9dbdb)),
    );
  }
}

// Center(
//           child: GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Sidekick(
//               tag: widget.produk.title,
//               child: Image.network(widget.produk.gambar[1].link)
//             ),
//           ),
//         )
class CustomBottomSheet extends StatefulWidget {
   final String nama;
  final String harga;
  final String gambar;
  final String penjual_user_id;
  final String produk_id;

  const CustomBottomSheet({Key key, this.nama, this.harga, this.gambar, this.penjual_user_id, this.produk_id}) : super(key: key);

  
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop = 380;
  double minSheetTop = 20;

  Animation<double> animation;
  AnimationController controller;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
//    scrollController = ScrollController();
//    scrollController.addListener(onScroll());
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });
  }

//  onScroll(){
//    if(scrollController.offset > scrollController.position.minScrollExtent){
//
//    }else if(scrollController.offset == scrollController.position.minScrollExtent){
//
//    }
//  }

  forwardAnimation() {
    controller.forward();
    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    controller.reverse();
    stateBloc.toggleAnimation();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        // onTap: () {
        //   controller.isCompleted ? reverseAnimation() : forwardAnimation();
        // },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          //upward drag
          if (dragEndDetails.primaryVelocity < 0.0) {
            forwardAnimation();
            controller.forward();
          } else if (dragEndDetails.primaryVelocity > 0.0) {
            //downward drag
            reverseAnimation();
          } else {
            return;
          }
        },
        child: SheetContainer(nama: widget.nama,gambar: widget.gambar,harga: widget.harga,penjual_user_id: widget.penjual_user_id,produk_id:widget.produk_id),
      ),
    );
  }
}

class SheetItems extends StatefulWidget {
   final String nama;
  final String harga;
  final String gambar;  
  final String penjual_user_id;
  final String produk_id;

  const SheetItems({Key key, this.nama, this.harga, this.gambar, this.penjual_user_id, this.produk_id}) : super(key: key);

 
 
  

  @override
  _SheetItemsState createState() => _SheetItemsState();
}

class _SheetItemsState extends State<SheetItems> with TickerProviderStateMixin {
  var f = NumberFormat("#,##0", "en_US");
  double sheetTop = 400;
  double minSheetTop = 30;

  Animation<double> animation;
  AnimationController controller;
  String nama,level_id;
getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString("id");
       level_id = pref.getString("level_id");
     getJsonData();
    });
    //print("id profile sklh= " + nama);
   
  }
  @override
  void initState() {
    getCredential();
    
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });
  }

  bool isExpanded = false;

 Future<http.Response> _setfavorit(String id) async {
    //a=a+id;
    //print(id);
  
    var url =
        'http://siplah.mascitra.co.id/api/sekolah/produk_favorit/tambah';

    Map data = {'user_id': "" + nama, 'produk_id':id, };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: body);
    // print("${response.statusCode}");

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    //print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
    }
    return response;
  }
  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("maaf gagal edit"),
            ));
  }

  void _berhasil(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Buku Telah Masuk Dalam Menu Favorit"),
            ));
  }
 List data6;
  Future<String> getJsonData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/home/list'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        'user_id':nama,
        'id':'7'
      }
    );
    //print(response.body);
    //print(data6[0]['foto']);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      
      data6 = convertDataToJson['Data'];
     
    });
  }
  @override
  Widget build(BuildContext context) {
  
   
    var price  = widget.harga;
    return ListView(
      children: <Widget>[
        
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            // boxShadow: <BoxShadow>[BoxShadow(blurRadius: 5)]
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 80,
                    child: Text(
                      widget.nama,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  //edit
                 
                          level_id == '2' ? 
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey,
                    child: true == true
                        ?     IconButton(
                    icon: Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ),
                    onPressed: () => {
                          _setfavorit(widget.produk_id)
                        })
                        : Icon(
                            Icons.favorite_border,
                          ),
                  ):Container()


                ],
              ),
              Container(
                width: double.infinity,
                child: Text(price,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black26,
              ),
              // Container(
              //     height: 20,
              //     // color: Colors.red,
              //     child: Row(
              //       children: <Widget>[
              //         Text(
              //           "Stok Terbatas! ",
              //           style: TextStyle(
              //               fontSize: 12, fontWeight: FontWeight.w500),
              //         ),
              //         20 > 50
              //             ? Text(
              //                 "Tersedia > 50",
              //                 style: TextStyle(
              //                   fontSize: 12,
              //                 ),
              //               )
              //             : Text(
              //                 "Tersedia < 50",
              //                 style: TextStyle(
              //                   fontSize: 12,
              //                 ),
              //               ),
              //       ],
              //     )),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: <Widget>[
                    
              //       _diskusi(12),
              //       _pengiriman()
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              // Container(
              //   height: 60,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: Colors.black12),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     // crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       _dilihat(200),
              //       _transaksi(90, 100),
              //       _wishlist(200)
              //     ],
              //   ),
              // )
            ]),
          ),
        ),
        _customDivider(),
        Container(
            width: double.infinity,
            color: Colors.white,
            child: _informasiProduk()),
        _customDivider(),
     
        _customDivider(),
       
        _customDivider(),
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 8.0),
          width: double.infinity,
          color: Colors.white,
          child: 
              Text(
                "Produk Lainnya",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
         
        ),
        
        // Container(
        //   height: 200,
        //   child: prefix0.Kategori(data: data6[i]['produk'],)
        //   // ListView.builder(itemCount: 2,
        //   // scrollDirection: Axis.horizontal,
        //   // itemBuilder: (context,i){
        //   //   return Row(children: <Widget>[
        //   //     Text(data6[i]['foto'])
        //   //   ],);
        //   // }),
        // ),
   
      Container(
                            height:data6 == null ? 0 : 100 * data6.length.toDouble(),
                            child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        data6 == null ? 0 : 1,
                                    itemBuilder: (context, i) {
                                      return Container(
                                          child: Column(
                                        children: <Widget>[
                                          data6 != null
                                              ? Nontextbaru(
                                                
                                                level: level_id,
                                                id:nama,
                                                  data: data6[i]['produk'],
                                                  
                                                )
                                              : CircularProgressIndicator(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //Pendamping(data: data2,kategori: kategorilist,),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ));
                                    },
                                  ),
                          ),
      

        //  Container(
        //     padding: const EdgeInsets.only(left: 20),
        //     width: double.infinity,
        //     color: Colors.white,
        //     child: _otherProduk()
        //     )
             
 
         
      
        // Container(
        //   height: 100,
        // ),
        // Column(
        //   children: List.generate(100, (p) {
        //     return ListTile(
        //       title: Text("hello world ${p.toString()}"),
        //     );
        //   }),
        // ),
      ],
    );
  }


//   _otherProduk() {
// getJsonData();
// data6==null?Container(child: Text("data"),):
// new ListView.builder(
//   scrollDirection: Axis.horizontal,
//   itemCount: data6.length,
//   itemBuilder: (context,i){
//     return Container(
//       height: 300,
//       width: double.infinity,
//       child: Row(
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.only(left: 5),
//             height: 260,
//             width: 150,
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10.0)),
//                 height: 100,
//                 width: 120,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Stack(
//                       children: <Widget>[
//                         Container(
//                             height: 120,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10))),
//                             child: Image.network(data6[i]['foto']==null?'http://siplah.mascitra.co.id/assets/images/no-image.png':data6[i]['foto'],
//                               fit: BoxFit.fill,
//                             )),
//                         Positioned(
//                           right: 10,
//                           top: 10,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             foregroundColor: Colors.grey,
//                             child: Icon(
//                               Icons.favorite_border,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 8.0),
//                     Container(
//                       width: 100,
//                       height: 50,
//                       // color: Colors.black,
//                       child: Text(
//                         "Belajar Berbahagia",
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.w600),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Container(
//                       width: 100,
//                       // color: Colors.black,
//                       child: Text(
//                         "Rp " + f.format(140000),
//                         style: TextStyle(
//                           fontSize: 15,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8.0,
//                     ),
//                     Container(
//                       width: 100,
//                       height: 20,
//                       child: Row(
//                         children: <Widget>[
//                           CircleAvatar(
//                             child: Icon(
//                               Icons.store,
//                               size: 15,
//                               color: Colors.red,
//                             ),
//                             minRadius: 10,
//                             backgroundColor: Colors.amber,
//                             foregroundColor: Colors.red,
//                           ),
//                           SizedBox(width: 5.0),
//                           Text(
//                             "Sumatera",
//                             style: TextStyle(
//                               fontSize: 11,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5.0,
//                     ),
//                     Container(
//                         width: 100,
//                         child: StarDisplay(
//                           size: 10,
//                           value: 4,
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//     }
// );
//   }

 _otherProduk() {
  //  getJsonData();
  //  ListView.builder(itemCount: data6.length,
  //  itemBuilder: (context,i){
     
   
    return Container(
      height: 300,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 5),
            height: 260,
            width: 150,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                height: 100,
                width: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Image.network(
                               "https://ecs7.tokopedia.net/img/cache/700/product-1/2019/5/3/370667535/370667535_e643982c-71ee-49f4-99a6-8e96f30f5038_1080_1080.jpg",
                              fit: BoxFit.fill,
                            )),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: 100,
                      height: 50,
                      // color: Colors.black,
                      child: Text(
                        "Belajar Berbahagia",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 100,
                      // color: Colors.black,
                      child: Text(
                        "Rp " + f.format(140000),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: 100,
                      height: 20,
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(
                              Icons.store,
                              size: 15,
                              color: Colors.red,
                            ),
                            minRadius: 10,
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.red,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            "Sumatera",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                        width: 100,
                        child: StarDisplay(
                          size: 10,
                          value: 4,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
   // });
  }

 
  _informasiProduk() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
        
          SizedBox(
            height: 10,
          ),
         
          Container(
            width: double.infinity,
            child: Text(
              "Deskripsi Produk",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            width: double.infinity,
            child: Text(
           widget.nama,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
        
        ],
      ),
    );
  }

  _rowku(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[Text(title), Text(value)],
    );
  }

  _customDivider() {
    return Container(
      height: 5.0,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(blurRadius: 2, color: Colors.black12)
      ]),
    );
  }

  _dilihat(int total) {
    var jumlah = total / 1000;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Icon(Icons.remove_red_eye, color: Colors.)
        Text("Dilihat"),
        Text(jumlah.toInt().toString() + "rb")
      ],
    );
  }

  _transaksi(double persentase, double total) {
    // var jumlah = total.bitLength > 3 && total.bitLength < 6 ? total.toDouble() / 1000 : total;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Icon(Icons.remove_red_eye, color: Colors.)
        Text("Transaksi Berhasil"),
        Text(
            "${persentase.toInt().toString()}%(${total.toInt().toString()} produk)")
      ],
    );
  }

  _wishlist(int total) {
    // var jumlah = total.bitLength > 3 && total.bitLength < 6 ? total.toDouble() / 1000 : total;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Icon(Icons.remove_red_eye, color: Colors.)
        Text("Wishlist"),
        Text(total.toString())
      ],
    );
  }

  //
  _ulasan(Star star) {
    var rating = (star.jumlahStar / star.jumlahUser);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              rating.toInt().toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 20,
            ),
            Text(
              "/${star.jumlahUser.toInt().toString()}",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "3 Ulasan",
          style: TextStyle(color: Colors.cyan, fontSize: 12),
        )
      ],
    );
  }

  _diskusi(int jumlah) {
    return Column(
      children: <Widget>[
        Icon(Icons.feedback, color: Colors.cyan),
        SizedBox(
          height: 5,
        ),
        Text(
          "${jumlah.toString()} Diskusi",
          style: TextStyle(color: Colors.cyan, fontSize: 12),
        )
      ],
    );
  }

  _pengiriman() {
    return Column(
      children: <Widget>[
        Icon(Icons.local_shipping, color: Colors.cyan),
        SizedBox(
          height: 5,
        ),
        Text(
          "Pengiriman",
          style: TextStyle(color: Colors.cyan, fontSize: 12),
        )
      ],
    );
  }
}

class Ulasan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // flex: 1,
      height: 390,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: _item.length,
        itemBuilder: (context, i) {
          final ulasan = _item[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(ulasan.nama),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        ulasan.tgl,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  StarDisplay(
                    size: 15,
                    value: ulasan.rating,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ulasan.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: Text(
                            ulasan.subtitle,
                            textAlign: TextAlign.left,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: _imagelist(ulasan.image),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _imagelist(List<UlasanImage> img) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: img.length,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          padding: EdgeInsets.only(left: 5),
          height: 50,
          width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
          child: Image.network(img[i].link),
        );
      },
    );
  }
}

class DiskusiContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _dis.map((f) {
          return ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(f.uraian),
            subtitle:
                Text("oleh ${f.pengirim}, ${f.hari}, ${f.tgl} ${f.waktu}"),
          );
        }).toList(),
      ),
    );
  }
}

class UlasanItem {
  final String nama;
  final String tgl;
  final int rating;
  final String title;
  final String subtitle;
  final List<UlasanImage> image;

  UlasanItem(
      {this.nama,
      this.tgl,
      this.rating,
      this.title,
      this.subtitle,
      this.image});
}

class UlasanImage {
  final int index;
  final String link;

  UlasanImage(this.index, this.link);
}

List<UlasanItem> _item = <UlasanItem>[
  UlasanItem(
      nama: "guntur widianto",
      tgl: "21 Jun 2019",
      rating: 5,
      title: "Barang bagus",
      subtitle: "Bagus sesuai deskripsi, cuma box nya ga sesuai",
      image: [
        UlasanImage(0,
            "http://ecs7.tokopedia.net/img/cache/700/product-1/2019/5/3/370667535/370667535_3ec73fa2-43e5-487d-8ff6-d25d9ce610cf_2048_2048.jpg"),
        UlasanImage(1,
            "http://ecs7.tokopedia.net/img/cache/700/product-1/2019/5/3/370667535/370667535_4cad02b0-2f39-4691-97a4-317a805c0457_2048_2048.jpg"),
      ]),
  UlasanItem(
      nama: "Septian Iqbal",
      tgl: "1 Mar 2019",
      rating: 4,
      title: "Barang Siip",
      subtitle: "Sampai dengan selamat dan sesuai deskripsi.",
      image: [
        UlasanImage(0,
            "http://ecs7.tokopedia.net/img/cache/700/product-1/2019/5/3/370667535/370667535_7d5afb9d-da49-4355-8d15-324575bdb622_2048_2048.jpg"),
        UlasanImage(1,
            "http://ecs7.tokopedia.net/img/cache/700/product-1/2019/5/3/370667535/370667535_e643982c-71ee-49f4-99a6-8e96f30f5038_1080_1080.jpg"),
      ]),
];

class Diskusi {
  final String uraian;
  final String pengirim;
  final String hari;
  final String tgl;
  final String waktu;

  Diskusi({this.uraian, this.pengirim, this.hari, this.tgl, this.waktu});
}

List<Diskusi> _dis = <Diskusi>[
  Diskusi(
      uraian: "Selain buku dpt apa lagi gan ?",
      pengirim: "teguh",
      hari: "jumat",
      tgl: "21 Jun 2019",
      waktu: "15:05"),
  Diskusi(
      uraian: "Ready Gan ?",
      pengirim: "Bima",
      hari: "kamis",
      tgl: "20 Jun 2019",
      waktu: "21:05")
];
