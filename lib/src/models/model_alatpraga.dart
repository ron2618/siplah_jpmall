import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';

class Praga {
  
  Nontext api;
  String id;
  String user_foto;
  String produk;
  
  Praga({this.id,this.user_foto,this.produk,this.api});

  factory Praga.createUser(Map<String, dynamic> object)
  {
    return Praga(
      id: object['id'],
      user_foto: object['user_foto'],
      produk: object['produk']
    );
  }

  static Future<List<Praga>> getUsers() async{

    String apiURL = "http://siplah.mascitra.co.id/api/home/list?id=7" ;

 
    
    var apiResult = await http.post(apiURL,headers: {
      "API-App":"siplah_jpmall.id",
      "API-Key":"4P1_7Pm411_51p114h",
      "API-Token":"575696f2ed816e00edbfa90f917c6f757e5ce05a"
    });
    var jsonObject = json.decode(apiResult.body);
    Map<String, dynamic> map = jsonDecode(apiResult.body);
    var token = map["Data"][0]["produk"][0];
    
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)["Data"];  
    
    List<Praga> pragas =[];
    
    for (int i = 0; i<listUser.length; i++)
  
    pragas.add(Praga.createUser(listUser[0]["produk"][i]));
    
  
    return pragas;
  }
  
}
