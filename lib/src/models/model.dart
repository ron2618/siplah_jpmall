class UsersDetail {
  final Data data;

  UsersDetail(
      {this.data,
     });

  factory UsersDetail.fromJson(Map<String, dynamic> json) {
    return new UsersDetail(
      
        data: Data.fromJson(json['Data']));
  }
}

class Data {
  final String api_token;
  
  Data({this.api_token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return new Data(
      api_token: json['api_token'],
     
    );
  }
}

