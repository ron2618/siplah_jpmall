import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';

class Mitra {
  String id;
  String foto;
  

  Mitra({this.id,this.foto});

  factory Mitra.createMitra(Map<String, dynamic> object)
  {
    return Mitra(
      id: object['id'],
      foto: object['foto']
    
    );
  }

  static Future<List<Mitra>> getMitra() async{
    String apiURL = "http://siplah.mascitra.co.id/api/admin/data_mitra/list";
    
    var apiResult = await http.post(apiURL,headers: {
       "API-App":"siplah_jpmall.id",
      "API-Key":"4P1_7Pm411_51p114h",
      "API-Token":"575696f2ed816e00edbfa90f917c6f757e5ce05a"
    });
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listMitra = (jsonObject as Map<String, dynamic>)['Data'];  

    List<Mitra> mitras =[];
    for (int i = 0; i< listMitra.length; i++)
    mitras.add(Mitra.createMitra(listMitra[i]));
    //print(listMitra);
    return mitras;  
  }
}