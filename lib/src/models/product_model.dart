// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => new List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));
String productsToJson(Products data) => json.encode(data.toJson());

class Products {
    bool error;
    dynamic pesanSys;
    dynamic pesanUsr;
    List<Datum> data;
    Paging paging;

    Products({
        this.error,
        this.pesanSys,
        this.pesanUsr,
        this.data,
        this.paging,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        error: json["Error"],
        pesanSys: json["Pesan_sys"],
        pesanUsr: json["Pesan_usr"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        paging: Paging.fromJson(json["Paging"]),
    );

    Map<String, dynamic> toJson() => {
        "Error": error,
        "Pesan_sys": pesanSys,
        "Pesan_usr": pesanUsr,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Paging": paging.toJson(),
    };
}

class Datum {
    String id;
    String gambar;
    String nama;
    DateTime createdAt;
    DateTime updatedAt;
    List<Produk> produk;

    Datum({
        this.id,
        this.gambar,
        this.nama,
        this.createdAt,
        this.updatedAt,
        this.produk,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        gambar: json["gambar"],
        nama: json["nama"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        produk: List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "gambar": gambar,
        "nama": nama,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "produk": List<dynamic>.from(produk.map((x) => x.toJson())),
    };
}

class Produk {
    String id;
    List<Foto> foto;
    String produk;
    String harga;
    String userId;
    String userFoto;
    String userNama;
    String kabupatenId;
    String kabupatenNama;

    Produk({
        this.id,
        this.foto,
        this.produk,
        this.harga,
        this.userId,
        this.userFoto,
        this.userNama,
        this.kabupatenId,
        this.kabupatenNama,
    });

    factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json["id"],
        foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
        produk: json["produk"],
        harga: json["harga"],
        userId: json["user_id"],
        userFoto: json["user_foto"],
        userNama: json["user_nama"],
        kabupatenId: json["kabupaten_id"],
        kabupatenNama: json["kabupaten_nama"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "foto": foto == null ? null : List<dynamic>.from(foto.map((x) => x.toJson())),
        "produk": produk,
        "harga": harga,
        "user_id": userId,
        "user_foto": userFoto,
        "user_nama": userNama,
        "kabupaten_id": kabupatenId,
        "kabupaten_nama": kabupatenNama,
    };
}

class Foto {
    String id;
    String foto;
    DateTime createdAt;
    DateTime updatedAt;

    Foto({
        this.id,
        this.foto,
        this.createdAt,
        this.updatedAt,
    });

    factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        id: json["id"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "foto": foto,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Paging {
    bool pagination;

    Paging({
        this.pagination,
    });

    factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        pagination: json["Pagination"],
    );

    Map<String, dynamic> toJson() => {
        "Pagination": pagination,
    };
}
