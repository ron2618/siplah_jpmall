import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/models/model_mitra.dart';

class RekomToko extends StatefulWidget {
  @override
  _RekomTokoState createState() => _RekomTokoState();
}

class _RekomTokoState extends State<RekomToko> {
String a = "no data";
String b,c,d;
Mitra mitra;
  _loop(){
    a="";
    Mitra.getMitra().then((mitras){
      for(int i = 0; i<mitras.length;i++)
     a = mitras[i].foto;  
     
    //  a=output.toString();
     setState(() {
            
                         });

                      });
     
    }
     _loop1(){
    Mitra.getMitra().then((mitras){
        for(int i = 1; i<=mitras.length;i++)
     b = mitras[i].foto; 
     
    //  a=output.toString();
     setState(() {
           
                         });

                      });
     
    }
  @override
  Widget build(BuildContext context) {
    _loop();
    _loop1();
    print(a);
    print(b);
    
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Mitra JPMALL", style: TextStyle(
                fontSize: 16
              ),),
              Text("Lihat Semua", style: TextStyle(
                fontSize: 16
              ),)
            ],
          )
        ),
        Container(
          height: 130,
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // physics: ScrollPhysics(),
            // shrinkWrap: true,
            itemCount: _listToko.length,
            itemBuilder: (context, i) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(_listToko[i].nama, fit: BoxFit.scaleDown,),
                  )),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TokoList {
  final int index;
  final String nama;
  final String lokasi;
  final Color color;

  TokoList({this.index, this.nama, this.lokasi, this.color});
}

List<TokoList> _listToko = <TokoList>[
  TokoList(
      index: 1, nama: "http://jpmall.intern.mascitra.co.id/assets/images/icon/logo_saja.png", lokasi: "Jakarta", color: Colors.amber),
  TokoList(
      index: 2, nama: "http://ecs7.tokopedia.net/img/cache/215-square/shops-1/2019/2/12/5394723/5394723_fdb8279a-a94d-4683-8de5-019aabd91f30.jpg", lokasi: "Semarang", color: Colors.lightGreen),
  TokoList(
      index: 3, nama: "http://jpmall.intern.mascitra.co.id/assets/images/icon/gramedia.jpg", lokasi: "Surabaya", color: Colors.lime),
  TokoList(
      index: 3, nama: "http://upload.wikimedia.org/wikipedia/id/5/5b/Esis.jpg", lokasi: "Surabaya", color: Colors.lime),
];
