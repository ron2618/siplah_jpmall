import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';

class ModeProd {
  
  Nontext api;
  String id;
  String nama;
  String gambar;
  
  ModeProd({this.id,this.nama,this.gambar,this.api});

  factory ModeProd.createmodprod(Map<String, dynamic> object)
  {
    return ModeProd(
      id: object['id'],
      nama: object['nama'],
      gambar: object['gambar']
    );
  }

  static Future<List<ModeProd>> getmodprod() async{

    String apiURL = "https://siplah.mascitra.co.id/api/home/list?id=7" ;

 
    
    var apiResult = await http.post(apiURL,headers: {
      "API-App":"siplah_jpmall.id",
      "API-Key":"4P1_7Pm411_51p114h",
      "API-Token":"$Token({this.apitoken})"
    });
    var jsonObject = json.decode(apiResult.body);
    Map<String, dynamic> map = jsonDecode(apiResult.body);
    var token = map["Data"][0]["nama"][0];
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)["Data"];  
    
    List<ModeProd> prods =[];
    for (int i = 0; i<listUser.length; i = i+1){
   
    prods.add(ModeProd.createmodprod(listUser[i]));
    
     return prods;
    }
  }
  
}
