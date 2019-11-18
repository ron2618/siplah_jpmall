import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';
class User {
  Nontext api;
  String id;
  String user_foto;
  String produk;
  
  User({this.id,this.user_foto,this.produk,this.api});

  factory User.createUser(Map<String, dynamic> object)
  {
    return User(
      id: object['id'],
      user_foto: object['user_foto'],
      produk: object['produk']
    );
  }

  static Future<List<User>> getUsers(String id) async{

    String apiURL = "https://siplah.mascitra.co.id/api/home/list?id=" + id;

 
    
    var apiResult = await http.post(apiURL,headers: {
      "API-App":"siplah_jpmall.id",
      "API-Key":"4P1_7Pm411_51p114h",
      "API-Token":"$Token({this.apitoken})"
    });
    var jsonObject = json.decode(apiResult.body);
    Map<String, dynamic> map = jsonDecode(apiResult.body);
    var token = map["Data"][0]["produk"][0];
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['Data'];  

    List<User> users =[];
    for (int i = 0; i< 2; i++){ 
    users.add(User.createUser(listUser[0]["produk"][i]));
    return users;
    }
   
  }
  
}