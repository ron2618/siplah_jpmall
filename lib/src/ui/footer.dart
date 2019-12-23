import 'package:flutter/material.dart';
import 'page_profile.dart';
class Footer extends StatefulWidget {
  final List data;

  const Footer({Key key, this.data}) : super(key: key);
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
     
      width: MediaQuery.of(context).size.width-30,
      height: 65*widget.data.length.toDouble(),
     child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),       
       itemCount: widget.data.length,
       itemBuilder: (context, i){
         print(widget.data[i]['judul'],);
        return Column(
         children: <Widget>[
            
           GestureDetector(
             onTap: ()=> 
             Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 350),
                            pageBuilder: (context, _, __) => PagesiteA(
                              id: widget.data[i]['id'],
                            ))),
                        child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
        border: Border.all(width: 2,color: Colors.grey),
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              color: Colors.grey
          )
        ]
      ),
               child: ListTile
               (title: Text(widget.data[i]['judul'],
               
               ),
               ),
               
             ),
           ),
           Container(
             height: 5,
           )
          
         ],
       );
       }
     ),
    );
  }
}