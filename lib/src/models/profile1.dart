import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';


class Profile1 {
  String id;
  String judul;

  Profile1({this.id,this.judul});

  factory Profile1.createProfile1(Map<String, dynamic> object)
  {
    return Profile1(
      id: object['id'],
        judul: object['judul']
    );
  }

  static Future<List<Profile1>>getProfile1() async{

    String apiURL = "https://siplah.mascitra.co.id/api/blog/tampil";



    var apiResult = await http.post(apiURL,headers: {
      "API-App":"siplah_jpmall.id",
      "API-Key":"4P1_7Pm411_51p114h",
      "API-Token":"$Token({this.apitoken})"
    },body: {
      "id":"1"
    });
    var jsonObject = json.decode(apiResult.body);
    // Map<String, dynamic> map = jsonDecode(apiResult.body);
    // var token = map["Data"];
    List<dynamic> listProfile1 = (jsonObject as Map<String, dynamic>)["Data"];

    List<Profile1> profiles =[];

    for (int i = 0; i<listProfile1.length; i++)

      profiles.add(Profile1.createProfile1(listProfile1[i]));

    // print(listProfile1);
    return profiles;
  }

}
