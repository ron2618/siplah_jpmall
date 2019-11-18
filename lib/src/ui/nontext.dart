import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/models/produk_sample.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/models/model_nontext.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
class Nontext extends StatefulWidget {
  final List<Produk> data;

  Nontext({Key key, this.data}) : super(key: key);
  
  @override
  _NontextState createState() => _NontextState();
}

class _NontextState extends State<Nontext> {
  String output="";
  Token tokens = null;
  User users= null;
  String api;
String b;
   var f = NumberFormat("#,##0", "en_US");

  _token(){
    api="";
    Token.getTokens("2").then((tokens){
for(int i = 0; i<tokens.length;i++)
     api = tokens[i].apitoken;

    //  a=output.toString();
     setState(() {
                        
                         });

                      });
  }
   
_loop(){
    User.getUsers().then((users){
      for(int i = 0; i<users.length;i++)
     output = users[i].produk;
     
    //  a=output.toString();
     setState(() {
                        
                         });

                      });
     
    }
//   _gambar(){
//     b="";
//      User.getUsers("").then((users){
//       for(int i = 0; i<users.length;i++)
//      b = users[i].user_foto;
     
//     //  a=output.toString();
//      setState(() {
                        
//                          });

//                       });
//   }
  @override
  Widget build(BuildContext context) {  
    _token();
_loop();
//_gambar();

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.purple[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
            
          )
        ]
      ),
     
      child: ListView(
         
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        
        children: <Widget>[
          
          Row(
            
            children: <Widget>[
              SizedBox(
                width: 8.0,
              
              ),
              
              _kiri(),
              SizedBox(
                width: 8.0,
              ),
              _kanan(),
              
            ],
          )
        ],
      ),
    );
  }

  _kiri() {
    return Container(
      child: SizedBox(
        height: 220,
        width: 150,
        child: Container(
//            color: Colors.brown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 15,),
            Text("NON TEXT \n", style: TextStyle(
              color: Colors.white,
              fontSize: 20
              
              ,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,),
            SizedBox(height: 10,),

            SizedBox(height: 20,),
            MaterialButton(onPressed: (){}, child: Text("Lihat Semua"), color: Colors.white,)
          ],
        ),),
      ),
    );
  }

  _kanan() {
   
    return Container(
      height: 230,
      child: ListView.builder(
      itemCount:4,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 350),
                      pageBuilder: (context, _, __) =>
                          DetailProduk2(produk: widget.data[i]))),
              child: Container(
                width: 130,
                height: 200,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Container(
     //edit gambar


                        child: Image.network(""),
                       // child: Image.network("http://www.bukubali.co.id/wp-content/uploads/cover_dak/ekatalog/spkn/17SPKN-00357.jpg", fit: BoxFit.cover,),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.black26,
                            blurRadius: 5.0
                            )
                          ]
                        ),
                      ),
                    ),
                    
                     Container(
                     
                      height: 50,
                      width: 110,
  //edit


                      child: Text(output,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 110,
                      child: Text(
                        "Rp " + f.format(6500),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 10,
                      width: 100,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 10,
                            width: i / 2 * 100,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(3)),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: 100,
                      child: Text("Tersisa ${(i)}"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
