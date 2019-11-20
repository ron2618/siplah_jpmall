import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';

class User {
  
  Nontext api;
  String id;
  String user_foto;
  String produk;
  
  User({this.id,this.user_foto,this.produk,this.api});

  factory User.createUser(Map<String, dynamic> object)
  {
    return User(
      id: object['id'],
      user_foto: object['user_foto'],
      produk: object['produk']
    );
  }

  static Future<List<User>> getUsers() async{

    String apiURL = "https://siplah.mascitra.co.id/api/home/list?id=7" ;

 
    
    var apiResult = await http.post(apiURL,headers: {
      "API-App":"siplah_jpmall.id",
      "API-Key":"4P1_7Pm411_51p114h",
      "API-Token":"$Token({this.apitoken})"
    });
    var jsonObject = json.decode(apiResult.body);
    Map<String, dynamic> map = jsonDecode(apiResult.body);
    var token = map["Data"][0]["produk"][0];
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)["Data"];  
    
    List<User> users =[];
    for (int i = 0; i<listUser.length; i++)
    users.add(User.createUser(listUser[0]["produk"][i]));

    
    return users;
  }
  
}

// class User {
//     bool error;
//     dynamic pesanSys;
//     dynamic pesanUsr;
//     List<Datum> data;
//     Paging paging;

//     User({
//         this.error,
//         this.pesanSys,
//         this.pesanUsr,
//         this.data,
//         this.paging,
//     });

//     factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         error: json["Error"],
//         pesanSys: json["Pesan_sys"],
//         pesanUsr: json["Pesan_usr"],
//         data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
//         paging: Paging.fromJson(json["Paging"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "Error": error,
//         "Pesan_sys": pesanSys,
//         "Pesan_usr": pesanUsr,
//         "Data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "Paging": paging.toJson(),
//     };
// }

// class Datum {
//     String id;
//     String gambar;
//     String nama;
//     DateTime createdAt;
//     DateTime updatedAt;
//     List<Produk> produk;

//     Datum({
//         this.id,
//         this.gambar,
//         this.nama,
//         this.createdAt,
//         this.updatedAt,
//         this.produk,
//     });

//     factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         gambar: json["gambar"],
//         nama: json["nama"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         produk: List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "gambar": gambar,
//         "nama": nama,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "produk": List<dynamic>.from(produk.map((x) => x.toJson())),
//     };
// }

// class Produk {
//     String id;
//     List<Foto> foto;
//     String produk;
//     String harga;
//     String userId;
//     String userFoto;
//     String userNama;
//     String kabupatenId;
//     String kabupatenNama;

//     Produk({
//         this.id,
//         this.foto,
//         this.produk,
//         this.harga,
//         this.userId,
//         this.userFoto,
//         this.userNama,
//         this.kabupatenId,
//         this.kabupatenNama,
//     });

//     factory Produk.fromRawJson(String str) => Produk.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Produk.fromJson(Map<String, dynamic> json) => Produk(
//         id: json["id"],
//         foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
//         produk: json["produk"],
//         harga: json["harga"],
//         userId: json["user_id"],
//         userFoto: json["user_foto"],
//         userNama: json["user_nama"],
//         kabupatenId: json["kabupaten_id"],
//         kabupatenNama: json["kabupaten_nama"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "foto": foto == null ? null : List<dynamic>.from(foto.map((x) => x.toJson())),
//         "produk": produk,
//         "harga": harga,
//         "user_id": userId,
//         "user_foto": userFoto,
//         "user_nama": userNama,
//         "kabupaten_id": kabupatenId,
//         "kabupaten_nama": kabupatenNama,
//     };
// }

// class Foto {
//     String id;
//     String foto;
//     DateTime createdAt;
//     DateTime updatedAt;

//     Foto({
//         this.id,
//         this.foto,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory Foto.fromRawJson(String str) => Foto.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Foto.fromJson(Map<String, dynamic> json) => Foto(
//         id: json["id"],
//         foto: json["foto"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "foto": foto,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }

// class Paging {
//     bool pagination;

//     Paging({
//         this.pagination,
//     });

//     factory Paging.fromRawJson(String str) => Paging.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Paging.fromJson(Map<String, dynamic> json) => Paging(
//         pagination: json["Pagination"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Pagination": pagination,
//     };

//     List<User> _list = [];
//   var loading = false;
//   Future<Null> _fetchData() async {

//     final response =
//         await http.get("https://jsonplaceholder.typicode.com/users");
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       for (Map i in data) {
//           _list.add(User.fromJson(i));
//         }
   
//     }
// }
// }