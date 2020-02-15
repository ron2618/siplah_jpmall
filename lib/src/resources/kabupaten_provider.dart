import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/kabupaten_model.dart';

class KabupatenProvider{
  Client client = Client();
  final url = "http://siplah.mascitra.co.id/api/domisili/get_kabupaten";
  Future<Kabupaten> kabupaten(provId) async {
    final response = await client.post(url, 
      headers: {"Content-Type": "application/x-www-form-urlencoded","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"575696f2ed816e00edbfa90f917c6f757e5ce05a"},
    body: {
    
       "provinsi_id":provId
    });
    if(response.statusCode == 200){
      return compute(kabupatenFromJson, response.body);
    }else{
      throw Exception("Failed to Loaad");
    }
  }
}