import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/product_model.dart';
//import '';

class ProductProvider{
  Client client = Client();
  final url = "http://siplah.mascitra.co.id/siplah/api/home/list";
  Future<List<Products>> fetchProducts() async {
    final response = await client.get(url,headers: {"Content-Type": "application/x-www-form-urlencoded","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"575696f2ed816e00edbfa90f917c6f757e5ce05a"},);
    if(response.statusCode == 200){
      return compute(productsFromJson, response.body);
    }else{
      throw Exception("Failed to Load");
    }
  }
}