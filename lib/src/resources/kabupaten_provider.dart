import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:siplah_jpmall/src/models/kabupaten_model.dart';

class KabupatenProvider{
  Client client = Client();
  final url = "https://api.jpmall.intern.mascitra.co.id/index.php/api/provinsi/kabupaten";
  Future<Kabupaten> kabupaten(provId) async {
    final response = await client.post(url, 
    body: {
     "key":"cdd89a55ccf8fcdc11b3eabb09299e0d",
       "id":provId
    });
    if(response.statusCode == 200){
      return compute(kabupatenFromJson, response.body);
    }else{
      throw Exception("Failed to Loaad");
    }
  }
}