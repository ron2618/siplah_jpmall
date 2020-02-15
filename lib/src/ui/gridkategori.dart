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
    return widget.data==null?Container():Container(
      height: 160,
      
      child: Container( decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 5), blurRadius: 3), ]),child:ListView.builder(
            scrollDirection: Axis.horizontal,
            // physics: ScrollPhysics(),
            // shrinkWrap: true,
            itemCount: widget.data.length,
            itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: ()=> Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 350),
                  pageBuilder: (context, _, __) =>
                      Kategori(data: widget.data[i]['produk'],))),
                                      child: Container(
                     
                       decoration: BoxDecoration(
                         
                          // color: Colors.red[100],
                         borderRadius: BorderRadius.circular(10),
                       ),
            // height: 50,
            width: 100,
            child: Center(
              child: Container(
                height: 180,
               child: Image.network(widget.data[i]['gambar']!=null?widget.data[i]['gambar']:'http://siplah.mascitra.co.id/assets/images/no-image.png',),
              ),
            ),
          ),
                  ),
                );
       
            },
          ),
        )
        );  }
}

