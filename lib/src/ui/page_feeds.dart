import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/ui/myappbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedsPage extends StatefulWidget {
  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  
  @override
  void initState() {
    super.initState();
getJsonData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 24,
            color: Colors.cyan,
          ),
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
              child: ListView(padding: const EdgeInsets.all(0.0), children: <
                  Widget>[
            Column(children: <Widget>[
              
            ]),
            _feeds(context)
          ]))
        ],
      ),
    );
  }

  _promoted(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listpromoted.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: SizedBox(
                // padding: const EdgeInsets.all(10),
                height: 150,
                width: 200,
                // color: Colors.white,
                child: Container(

                    // color: Colors.white,
                    child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                              color: Colors.blue,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(_listpromoted[i].bg))),
                          // child: Image.network(
                          //   _listpromoted[i].bg,
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.cyan,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Follow",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 4.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      _listpromoted[i].official == true
                                          ? Icon(
                                              Icons.store,
                                              color: Colors.amber,
                                              size: 15,
                                            )
                                          : Container(),
                                      Container(
                                          width: 95,
                                          child: Text(
                                            _listpromoted[i].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Container(
                                    width: 100,
                                    child: Text(
                                      _listpromoted[i].subtitle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 12),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 42,
                      left: 18,
                      child: CircleAvatar(
                        // child: ,
                        maxRadius: 25,
                        backgroundImage:
                            NetworkImage(_listpromoted[i].imageProfile),
                        // child:
                      ),
                    )
                  ],
                )),
                // color: Colors.blue,
              ),
            ),
          );
        },
      ),
    );
  }
String nama;
  List data;
  Future<String> getJsonData() async {
    var response = await http.post(
        //Encode the url

        Uri.encodeFull('http://siplah.mascitra.co.id/api/admin/data_mitra/list'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: {
          "status":"1"
        });
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
    });
  }
  _feeds(BuildContext context) {
  
    return data==null?Column(
                children: <Widget>[Center(child: CircularProgressIndicator())]):ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0, bottom: 8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      // width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.amber,
                            maxRadius: 20,
                            backgroundImage: NetworkImage(data[i]['foto']==null?"":data[i]['foto']) ,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                width: 200,
                                child: Text(
                                  data[i]['nama'],
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  data[i]['alamat']==null?"Alamat :":"Alamat : "+data[i]['alamat'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black26
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
             
                    // Container(
                    //   height: 30,
                    //   width: 70,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(5),
                    //     color: Colors.cyan,
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       "Follow",
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                          height: 2,
                          color: Colors.grey[300],
                        ),
             ],
             
          ),
          
        );
        
      },
    );
  }
}

class TokoPromoted {
  final int index;
  final String title;
  final String subtitle;
  final bool official;
  final String imageProfile;
  final String bg;

  TokoPromoted(
      {this.index,
      this.title,
      this.subtitle,
      this.official,
      this.imageProfile,
      this.bg});
}

List<TokoPromoted> _listpromoted = <TokoPromoted>[
  TokoPromoted(
      index: 1,
      title: "Toko Simple",
      subtitle: "We sell Premium Cuallity",
      official: true,
      imageProfile:
          "http://s1.bukalapak.com/uploads/logos/6813/w-160/bukamall-logo-new.jpg.webp",
      bg: "http://ecs7.tokopedia.net/img/blog/promo/2019/05/Feature-940x339-3.jpg"),
  TokoPromoted(
      index: 2,
      title: "Toko Serba Ada",
      subtitle:
          "Material icons are delightful, beautifully crafted symbols for common actions and items.",
      official: false,
      imageProfile:
          "http://s1.bukalapak.com/uploads/logos/6813/w-160/bukamall-logo-new.jpg.webp",
      bg: "http://ecs7.tokopedia.net/img/blog/promo/2019/05/Feature-940x339-3.jpg"),
  TokoPromoted(
      index: 3,
      title: "Toko Bisa jadi",
      subtitle:
          "Download on desktop to use them in your digital products for Android, iOS, and web.",
      official: false,
      imageProfile:
          "http://s1.bukalapak.com/uploads/logos/6813/w-160/bukamall-logo-new.jpg.webp",
      bg: "http://ecs7.tokopedia.net/img/blog/promo/2019/05/Feature-940x339-3.jpg"),
];

class FeedsToko {
  final int index;
  final String date;
  final String title;
  final String description;
  final DataProduk produk;

  FeedsToko({this.index, this.date, this.title, this.description, this.produk});
}

class DataProduk {
  final int index;
  final String url;
  final int liked;
  final int comment;
  final int price;

  DataProduk(this.index, this.url, this.liked, this.comment, this.price);
}

List<FeedsToko> _listfeeds = <FeedsToko>[
  FeedsToko(
      title: "Kebayakartini",
      date: "baru saja",
      description: "Menambah 1 Produk Buku",
      produk: DataProduk(
          1,
          "http://ecs7.tokopedia.net/img/cache/700/product-1/2018/9/22/963365/963365_63f77e51-89b0-425d-818e-2f7d3cbb6963_711_711.jpg",
          20,
          12,
          140000)),
  FeedsToko(
      title: "Ronald Robi",
      date: "12:14, 24 Jun 2019",
      description: "Menambah 1 Produk Buku",
      produk: DataProduk(
          1,
          "http://ecs7.tokopedia.net/img/cache/700/product-1/2018/9/22/963365/963365_63f77e51-89b0-425d-818e-2f7d3cbb6963_711_711.jpg",
          0,
          0,
          140000)),
];
