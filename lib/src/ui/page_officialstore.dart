import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/ui/gridproduk.dart';
import 'package:siplah_jpmall/src/ui/myappbar.dart';

class OfficialStorePage extends StatefulWidget {
  @override
  _OfficialStorePageState createState() => _OfficialStorePageState();
}

class _OfficialStorePageState extends State<OfficialStorePage> {
  var imageList = [
    "http://ecs7.tokopedia.net/img/cache/1242/attachment/2019/6/26/26950746/26950746_bc1b75c7-9272-4bed-b512-449af802c65a.jpg",
    "http://ecs7.tokopedia.net/img/blog/promo/2019/06/Thumbnail-3.png",
    "http://ecs7.tokopedia.net/img/blog/promo/2018/04/Thumbnail-600x328-92.jpg"
  ];
  var imagePromo = [
    "http://ceraproduction.com/assets/media/product/images/1500449394.jpg",
    "http://ceraproduction.com/assets/media/product/images/1500449394.jpg",
    "http://ceraproduction.com/assets/media/product/images/1500449394.jpg",
  ];

  var imageBrand = [
    "http://kinshipdigital.com/wp-content/uploads/2016/08/samsung-logo.png",
    "http://kinshipdigital.com/wp-content/uploads/2016/08/samsung-logo.png",
    "http://kinshipdigital.com/wp-content/uploads/2016/08/samsung-logo.png",
    "http://kinshipdigital.com/wp-content/uploads/2016/08/samsung-logo.png",
    "http://kinshipdigital.com/wp-content/uploads/2016/08/samsung-logo.png",
    "http://kinshipdigital.com/wp-content/uploads/2016/08/samsung-logo.png",
    "http://kinshipdigital.com/wp-content/uploads/2016/08/samsung-logo.png",
    "http://kinshipdigital.com/wp-content/uploads/2016/08/samsung-logo.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Container(
              height: 66.0,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 3,
                      color: Colors.black12,
                      offset: Offset(0, 3))
                ],
                color: Color(0xFF6BB8E3),
              ),
              // padding: const EdgeInsets.only(),
              child: MyAppBarAbNormal()),
          Flexible(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    _sliderPromo(context), //slider
                    SizedBox(height: 5.0),
                    Container(
                      child: Text("Brand",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5.0),
                    _brand(context), //list
                    SizedBox(height: 5.0),
                    Container(
                      child: Text("Promo Minggu Ini",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5.0),
                    _promoHariIni(context), //list
                    SizedBox(height: 5.0),
                    Container(
                      child: Text("Produk Pilihan",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ]),
                ),
                SizedBox(height: 5.0),
                GridProduk()
                // _listProdukTokoOfficial(context), //gridview
              ],
            ),
          )
        ],
      ),
    ));
  }

  _sliderPromo(BuildContext context) {
    var index = 0;
    return Stack(
      children: <Widget>[
        Container(
          height: 140,

          width: double.infinity,

          child: CarouselSlider(
            initialPage: index,
            onPageChanged: (i) {
              setState(() {
                index = i;
              });
            },
            items: imageList.map((f) {
              return Container(
                height: 120,

                width: 310,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(f),
                      fit: BoxFit.fill,
                    )),

                // child:
              );
            }).toList(),
          ),

          // color: Colors.red,
        ),
        Positioned(
          top: 110,
          left: 50,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.map((f) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == f.indexOf(f)
                          ? Colors.red[400]
                          : Color.fromRGBO(0, 0, 0, 0.4)),
                );
              }).toList()),
        ),
      ],
    );
  }

  _brand(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageBrand.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: NetworkImage(imageBrand[i]), fit: BoxFit.cover)),
              ),
            ),
          );
        },
      ),
    );
  }

  _promoHariIni(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(

      // ),
      height: 230,
      padding: const EdgeInsets.all(7.0),
      width: double.infinity,
      child: Center(
        child: ListView.builder(
          itemCount: imagePromo.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                // padding: const EdgeInsets.all(3),
                height: 210,
                width: MediaQuery.of(context).size.width / 3.4,
                // child: ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage(imagePromo[i]), fit: BoxFit.fill),
                ),
              ),
            );
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
