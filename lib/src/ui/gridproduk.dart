import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/ui/star.dart';
import 'package:siplah_jpmall/src/models/produk_sample.dart';

import 'package:flutter_sidekick/flutter_sidekick.dart';

class GridProduk extends StatefulWidget {
  final List data;

  const GridProduk({Key key, this.data}) : super(key: key);

  @override
  _GridProdukState createState() => _GridProdukState();
}

class _GridProdukState extends State<GridProduk> with TickerProviderStateMixin {
  var f = NumberFormat("#,##0", "en_US");
  SidekickController controller;
  var liked = false;

  @override
  void initState() {
    super.initState();
  print(widget.data.length);
    controller =
        SidekickController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double ratio =
        MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, i) {
        var star =
            5;
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 350),
                  pageBuilder: (context, _, __) =>
                       DetailProduk2(nama: widget.data[i]['produk'], gambar: widget.data[i]['foto'] != null ? widget.data[i]['foto'][0]['foto']: 'https://siplah.mascitra.co.id/assets/images/no-image.png',harga: widget.data[i]['harga'],))),
           
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              height: 100,
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: 'image-${widget.data[i]['produk']}',
                        child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width /2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        widget.data[i]['foto'] != null ?widget.data[i]['foto'][0]['foto'] : 'https://siplah.mascitra.co.id/assets/images/no-image.png' 
                                       
                                        )),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)))),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              setState(() {});
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: liked == true ? Colors.red : null,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: 150,
                    height: 50,
                    // color: Colors.black,
                    child: Text(
                      widget.data[i]['produk'],
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 150,
                    // color: Colors.black,
                    child: Text(
                      "Rp " + widget.data[i]['harga'],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: 150,
                    height: 20,
                    child: Row(
                      children: <Widget>[
                        
                      
                        Text(widget.data[i]['kabupaten_nama'])
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Container(
                      width: 150,
                      child: StarDisplay(
                        value: 5,
                      )
          )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: widget.data.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
//      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: MediaQuery.of(context).size.height /2.5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: ratio <= 2 ? 0.55 : 0.65),
    );
  }
}

//gridView(AsyncSnapshot<List<Products>> snapshot){

//}


