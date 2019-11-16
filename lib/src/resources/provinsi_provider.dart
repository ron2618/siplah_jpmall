import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:siplah_jpmall/src/models/provinsi_model.dart';

class ProvinceProvider{
  Client client = Client();
  final url = "https://api.jpmall.intern.mascitra.co.id/index.php/api/provinsi";
  Future<Province> province() async {
    final response = await client.post(url,
 
     body: {
      "key":"cdd89a55ccf8fcdc11b3eabb09299e0d"
    });
    if(response.statusCode == 200){
      return compute(provinceFromJson, response.body);
    }else{
      throw Exception("Failed to Load");
    }
  }
}