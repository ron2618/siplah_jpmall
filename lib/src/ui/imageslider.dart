import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'dart:async';
import 'package:siplah_jpmall/src/ui/mainpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
// class ImageSlider extends StatefulWidget {
//   @override
//   _ImageSliderState createState() => _ImageSliderState();
// }

// class _ImageSliderState extends State<ImageSlider> {
//   PageController _pageController;
//   int currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//       initialPage: 1, keepPage: true, viewportFraction: 0.5
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: PageView.builder(
//         onPageChanged: (val){
//           setState((){
//             currentPage = val;
//           });
//         },
//         controller: _pageController,
//         itemBuilder: (context, i) => _animateItemBuilder(i),
//       ),
//     );
//   }
//   _animateItemBuilder(int index){
//     return AnimatedBuilder(
//       animation: _pageController,
//       builder: (context, child){
//         double value = 1;
//         if(_pageController.position.haveDimensions){
//           value = _pageController.page - index;
//           value = (1 - (value.abs() * 0.5)).clamp(0.0, 0.1);
//         }

//         return Center(
//           child: SizedBox(
//             height:  Curves.easeIn.transform(value) * 450,
//             width:  Curves.easeIn.transform(value) * 300,
//             child: child,
//           )
//         );
//       },
//       child: Container(
//         // margin: const EdgeInsets.all(10.0),
//         color: index % 2 == 0 ? Colors.greenAccent : Colors.cyanAccent,
//         child: FlutterLogo(),
//       ),
//     );
//   }
// }

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class ListItem {
  final Color color;
  final int index;
  final String name;
  final String link;

  ListItem({this.color, this.index, this.name, this.link});
}

List<ListItem> _itemList = <ListItem>[
  ListItem(
      color: Colors.red,
      index: 0,
      name: "Chizuru",
      link:
          "http://jpmall.intern.mascitra.co.id/assets/images/slide/slide-1.png"),
  ListItem(
      color: Colors.cyan,
      index: 1,
      name: "Shoko",
      link:
          "http://jpmall.intern.mascitra.co.id/assets/images/slide/slide-2.png"),
  ListItem(
      color: Colors.green,
      index: 2,
      name: "Mai",
      link:
          "http://jpmall.intern.mascitra.co.id/assets/images/slide/slide-3.png"),
];

class _ImageSliderState extends State<ImageSlider> {
  int loading = 0;
  int _current = 0;
  List data;
  Future<String> getJsonData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/admin/data_slide/list'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
    );
    // print(response.body);
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

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: Duration(seconds: 10),
            reverse: false,
            enableInfiniteScroll: true,
            initialPage: currentPage,
            aspectRatio: 16 / 9,
            items: [0, 1, 2].map((i) {
              return Builder(
                builder: (context) {
                  return Container(
                    // child:

                    padding: const EdgeInsets.only(top: 10, bottom: 10),

                    width: MediaQuery.of(context).size.width,

                    // height: 100,

                    margin: EdgeInsets.symmetric(horizontal: 5.0),

                    // child: ,

                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(loading == 1
                                ? data[i]['gambar']
                                : 'https://miro.medium.com/max/896/1*n3HjQJQ1pbWkavIttP69UQ.gif'),
                            fit: BoxFit.fill),
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(8.0)),
                  );
                },
              );
            }).toList(),
            height: Curves.easeIn.transform(1) * 100,
            enlargeCenterPage: true,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
          ),
          Positioned(
            // alignment: Alignment.bottomLeft,
            bottom: -5.0,
            right: 0.0,
            left: 0.0,

            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _itemList.map((f) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == f.index
                            ? Colors.red[400]
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                }).toList()),
          )
        ],
      ),
    );
  }
}
