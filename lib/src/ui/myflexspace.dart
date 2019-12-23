import 'package:flutter/material.dart';

class MyFlexSpace extends StatelessWidget {
  final double appbarHeight = 66.0;

  const MyFlexSpace();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenwidth = MediaQuery.of(context).size.width;
    final double widthSearchBar = screenwidth - 40;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: statusBarHeight),
          height: statusBarHeight + appbarHeight,
          // child:
        ),
        Container(
          height: 40,
          width: widthSearchBar,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Cari Produk",
                prefixIcon: Icon(Icons.search)),
          ),
        )
      ],
    );
  }
}
