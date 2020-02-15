import 'dart:convert';

import 'package:http/http.dart' as http;

class Token {
  String id;
  String apitoken;
  

  Token({this.id,this.apitoken});

  factory Token.createToken(Map<String, dynamic> object)
  {
    return Token(
      id: object['id'],
      apitoken: object['api_token']
    
    );
  }

  static Future<List<Token>> getTokens(String id) async{
    String apiURL = "http://siplah.mascitra.co.id/api/api/get_token?id=" + id;
    
    var apiResult = await http.post(apiURL,body: {
      "app":"siplah_jpmall.id"
    });
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listToken = (jsonObject as Map<String, dynamic>)['Data'];  

    List<Token> tokens =[];
    for (int i = 0; i< listToken.length; i++)
    tokens.add(Token.createToken(listToken[i]));

    return tokens;  
  }
}