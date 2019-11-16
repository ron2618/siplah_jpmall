import 'package:flutter/material.dart';

class GridKategori extends StatefulWidget {
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
            itemCount: _listcate.length,
            itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
            height: 40,
            width: 150,
            child: Container(
              child: Center(
                child: Text("  "+_listcate[i].title, style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black
                ),),
              ),
              decoration: BoxDecoration(
                  color: _listcate[i].color,
                  borderRadius: BorderRadius.circular(10.0)
              ),
            ),
          ),
                );
       
            },
          ),
        );  }
}

class CateList {
  final String title;
  final int index;
  final Color color;

  CateList({this.title, this.index, this.color});

}

List<CateList> _listcate = <CateList>[
  CateList(title: "Paket Utama K13", index: 1, color: Colors.blue[100]),
  CateList(title: "Non Text", index: 1, color: Colors.purple[100]),
  CateList(title: "Pendamping K13", index: 1, color: Colors.pink[100]),
  CateList(title: "Alat Peraga", index: 1, color: Colors.red[100]),
];