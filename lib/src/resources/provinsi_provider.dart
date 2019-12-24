import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:siplah_jpmall/src/models/provinsi_model.dart';

class ProvinceProvider{
  Client client = Client();
  final url = "https://siplah.jpstore.id/api/domisili/get_provinsi";
  Future<Province> province() async {
    final response = await client.post(url,
     headers: {"Content-Type": "application/json","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"5b4eefd43a64c539788b356da4910e5e95fb573"},
    );
    if(response.statusCode == 200){
      return compute(provinceFromJson, response.body);
    }else{
      throw Exception("Failed to Load");
    }
  }
}