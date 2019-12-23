import 'dart:convert';



List<Blog> blogsFromJson(String str) => new List<Blog>.from(json.decode(str).map((x) => Blog.fromJson(x)));
String blogsToJson(Blog data) => json.encode(data.toJson());
class Blog {
    bool error;
    dynamic pesanSys;
    dynamic pesanUsr;
    List<Datum> data;

    Blog({
        this.error,
        this.pesanSys,
        this.pesanUsr,
        this.data,
    });

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        error: json["Error"],
        pesanSys: json["Pesan_sys"],
        pesanUsr: json["Pesan_usr"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Error": error,
        "Pesan_sys": pesanSys,
        "Pesan_usr": pesanUsr,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String nama;
    List<Page> page;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        this.id,
        this.nama,
        this.page,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        page: List<Page>.from(json["page"].map((x) => Page.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "page": List<dynamic>.from(page.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Page {
    String id;
    String judul;
    DateTime createdAt;
    DateTime updatedAt;

    Page({
        this.id,
        this.judul,
        this.createdAt,
        this.updatedAt,
    });

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"],
        judul: json["judul"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
