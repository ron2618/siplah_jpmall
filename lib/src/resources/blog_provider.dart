import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';
import 'package:siplah_jpmall/src/models/Blog.dart';
//import '';

class BlogProvider{
  Client client = Client();
  final url = "https://siplah.jpstore.id/api/blog/blog_footer";
  Future<List<Blog>> fetchBlog() async {
    final response = await client.get(url,headers: {"Content-Type": "application/x-www-form-urlencoded","API-App":"siplah_jpmall.id","Api-Key":"4P1_7Pm411_51p114h","API-Token":"5b4eefd43a64c539788b356da4910e5e95fb573"},);
    
    //print(response.body);
    if(response.statusCode == 200){
      return compute(blogsFromJson, response.body);
    }else{
      throw Exception("Failed to Load");
    }
  }
}