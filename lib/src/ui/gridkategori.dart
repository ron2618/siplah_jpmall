import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridKategori extends StatefulWidget {
  final List data;

  const GridKategori({Key key, this.data}) : super(key: key);

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
               child: Image.network(widget.data[i]['gambar'],),
              ),
            ),
          ),
                );
       
            },
          ),
        );  }
}

