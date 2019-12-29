import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'kategori.dart';

class GridKategori extends StatefulWidget {
  final List data;
  final List dataproduk;

  const GridKategori({Key key, this.data, this.dataproduk}) : super(key: key);



  @override
  _GridKategoriState createState() => _GridKategoriState();
}

class _GridKategoriState extends State<GridKategori> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // physics: ScrollPhysics(),
            // shrinkWrap: true,
            itemCount: widget.data.length,
            itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: ()=> Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 350),
                  pageBuilder: (context, _, __) =>
                      Kategori(data: widget.data[i]['produk'],))),
                                      child: Container(
                     
                       decoration: BoxDecoration(
                           color: Colors.red[100],
                         borderRadius: BorderRadius.circular(10),
                       ),
            height: 100,
            width: 110,
            child: Center(
              child: Container(
                height: 120,
               child: Image.network(widget.data[i]['gambar']!=null?widget.data[i]['gambar']:'https://siplah.jpstore.id/assets/images/no-image.png',),
              ),
            ),
          ),
                  ),
                );
       
            },
          ),
        );  }
}

