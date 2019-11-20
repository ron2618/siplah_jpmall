import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';

class Profile1 {

  Nontext api;
  String id;
  String produk;
  String judul;

  Profile1({this.id,this.produk,this.api,this.judul});

  factory Profile1.createProfile1(Map<String, dynamic> object)
  {
    return Profile1(
        id: object['id'],
        produk: object['produk'],
        judul: object['judul']
    );
  }

  static Future<List<Profile1>>getProfile1() async{

    String apiURL = "https://siplah.mascitra.co.id/api/home/list?id=7" ;



    var apiResult = await http.post(apiURL,headers: {
      "API-App":"siplah_jpmall.id",
      "API-Key":"4P1_7Pm411_51p114h",
      "API-Token":"$Token({this.apitoken})"
    });
    var jsonObject = json.decode(apiResult.body);
    Map<String, dynamic> map = jsonDecode(apiResult.body);
    var token = map["Data"][0]["produk"][0];

    List<dynamic> listProfile1 = (jsonObject as Map<String, dynamic>)["Data"];

    List<Profile1> profiles =[];

    for (int i = 0; i<listProfile1.length; i++)

      profiles.add(Profile1.createProfile1(listProfile1[0]["judul"][i]));


    return profiles;
  }

}
