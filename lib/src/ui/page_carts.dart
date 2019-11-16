import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartsPage extends StatefulWidget {
  @override
  _CartsPageState createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  var linkimage = "http://cahyamotor.co.id/images/empty-cart-icon.jpg";

  var item = false;

  ScrollController _controllerProduk;
  TextEditingController _qty;


  @override
  void initState() {
    _controllerProduk = ScrollController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(child: Text("hapus")),
          SizedBox(width: 10,)
        ],
        title: Text("Keranjang"),
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check_box, color: Colors.white),
                SizedBox(width: 5.0,),
                Text("Pilih Semua", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          preferredSize: Size(double.infinity, 50),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black12,
            offset: Offset(0, -3))
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: Main,
              children: <Widget>[
                Text("Total Harga"),
                Text("Rp. 50.000", style: TextStyle(fontSize: 14, color: Colors.cyan),)
              ],
            ),
            Container(
              height: 38,
              width: 100,
              color: Colors.cyan,
              child: Center(
                child: Text("Beli(3)", style: TextStyle(color: Colors.white),)
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.black12,
        child: _itemada(context),
        // child: ListView(
        //   children: <Widget>[
        //     // item == false
        //     // ?
        //     _itemkosong(context),
        //     // Divider()
        //     // : _itemada(),
        //     // _terakhirdilihat(),
        //     // _rekomendasi()
        //   ],
        // ),
      ),
    );
  }

  _itemada(BuildContext context) {
    return ListView.builder(
      // padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: _listk.length,
      itemBuilder: (context, i) {
        final x = _listk[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.0,),
                Row( // toko
                // mainAxisAlignment: MainAxis,
                  children: <Widget>[
                    Icon(Icons.check_box, color: Colors.cyan),
                    SizedBox(width: 10.0,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(x.toko.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                        SizedBox(height: 3.0,),
                        Text(x.toko.lokasi, style: TextStyle(color: Colors.black26),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Flexible( // produk
                  child: ListView.builder(
                    controller: _controllerProduk,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: x.produk.length,
                    itemBuilder: (context, i) {
                      final y = x.produk[i];
                      _qty = TextEditingController(text: y.qty.toString()); 
                      return Column(// produk
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row( // title
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.check_box, color: Colors.cyan),
                              Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(y.url)),
                              Column(
                                // mainAxisAlignment: ,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(width: 250, child: Text(y.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500,
                                  ),)),
                                  Container(child: Text(y.price.toString(), style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: Colors.cyan,)))
                                ],
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.black26,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(//favorite & qty
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 13,
                                        )
                                      ]),
                                  child:
                                      Center(child: Icon(Icons.favorite_border, size: 20,))),
                                      SizedBox(width: 15,),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all()
                                            ),
                                        child: Center(child: Icon(Icons.add))),
                                    Container(
                                      width: 50,
                                      height: 30,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: _qty,
                                      ),
                                    ),
                                    Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all()
                                            ),
                                        child: Center(
                                            child: Icon(Icons.remove))),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text("Tulis Catatan untuk Toko", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.w500),),
                          SizedBox(height: 15,),
                          // _controllerProduk.offset != _controllerProduk.position.maxScrollExtent ?  Container() :   Divider()
                        ],
                      );
                    },
                  ),
                ),
                // _listk.length <= 1 ? Container() : customDivider()
              ],
            ),
          ),
        );
      },
    );
  }

  customDivider(){
    return Container(
      height: 10,
      width: double.infinity,
      color: Colors.black12,
      // child: ,
    );
  }

  _itemkosong(BuildContext context) {
    return Container(
      // color:,
      // height: 200,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(height: 150, width: 230, child: Image.network(linkimage)),
          SizedBox(
            height: 10,
          ),
          Text("Keranjang Belanja Kosong",
              style: TextStyle(color: Colors.black26, fontSize: 13)),
          SizedBox(
            height: 10,
          ),
          // Text("Wujudkan Impian di Wishlist Kamu")
          Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.cyan,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 1))
                ]),
            child: Center(
              child: Text(
                "Belanja Sekarang",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class KeranjangModel {
  final int index;
  final TokoModel toko;
  final List<ProdukModel> produk;

  KeranjangModel({this.index, this.toko, this.produk});
}

class TokoModel {
  final String title;
  final String lokasi;
  final bool official;

  TokoModel(this.title, this.lokasi, this.official);
}

class ProdukModel {
  final int index;
  final String name;
  final int qty;
  final int price;
  final String url;
  final bool favorite;

  ProdukModel(
      this.index, this.name, this.qty, this.price, this.url, this.favorite);
}

List<KeranjangModel> _listk = <KeranjangModel>[
  KeranjangModel(
      index: 1,
      toko: TokoModel("@Kiosk", "Jakarta Barat", true),
      produk: [
        ProdukModel(
            1,
            "ADATA ED600 Eksternal Case HDD/SSD 2.5 Shock & Dust & Wtaer Proof",
            1,
            149000,
            "http://ecs7.tokopedia.net/img/cache/700/product-1/2018/11/29/8751793/8751793_ed567273-2a7c-413a-a1c5-bd05b87f84e0_425_425.jpg",
            false),
        ProdukModel(
            1,
            "ADATA ED600 Eksternal Case HDD/SSD 2.5 Shock & Dust & Wtaer Proof",
            1,
            149000,
            "http://ecs7.tokopedia.net/img/cache/700/product-1/2018/11/29/8751793/8751793_ed567273-2a7c-413a-a1c5-bd05b87f84e0_425_425.jpg",
            false),
      ]),
  KeranjangModel(
      index: 2,
      toko: TokoModel("Selalu Rame", "Jakarta Barat", false),
      produk: [
        ProdukModel(
            1,
            "ADATA ED600 Eksternal Case HDD/SSD 2.5 Shock & Dust & Wtaer Proof",
            1,
            149000,
            "http://ecs7.tokopedia.net/img/cache/700/product-1/2018/11/29/8751793/8751793_ed567273-2a7c-413a-a1c5-bd05b87f84e0_425_425.jpg",
            false),
      ])
];
