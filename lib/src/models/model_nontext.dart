import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';
class User {
  Nontext api;
  String id;
  String gambar;
  String nama;
  
  User({this.id,this.gambar,this.nama,this.api});

  factory User.createUser(Map<String, dynamic> object)
  {
    return User(
      id: object['id'],
      gambar: object['gambar'],
      nama: object['nama']
    );
  }

  static Future<List<User>> getUsers(String id) async{
    String apiURL = "https://siplah.mascitra.co.id/api/home/list?id=7" + id;
    
    var apiResult = await http.post(apiURL,headers: {
      "API-App":"siplah_jpmall.id",
      "API-Key":"4P1_7Pm411_51p114h",
      "API-Token":"$Token({this.apitoken})"
    });
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['Data'];  

    List<User> users =[];
    for (int i = 0; i< listUser.length; i++)
    users.add(User.createUser(listUser[i]));

    return users;  
  }
}