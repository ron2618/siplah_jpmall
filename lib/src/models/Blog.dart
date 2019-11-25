import 'dart:convert';



List<Blog> blogsFromJson(String str) => new List<Blog>.from(json.decode(str).map((x) => Blog.fromJson(x)));
String blogsToJson(Blog data) => json.encode(data.toJson());
class Blog {
  bool error;
  Null pesanSys;
  Null pesanUsr;
  List<Data> data;

  Blog({this.error, this.pesanSys, this.pesanUsr, this.data});

  Blog.fromJson(Map<String, dynamic> json) {
    error = json['Error'];
    pesanSys = json['Pesan_sys'];
    pesanUsr = json['Pesan_usr'];
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Error'] = this.error;
    data['Pesan_sys'] = this.pesanSys;
    data['Pesan_usr'] = this.pesanUsr;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String nama;
  List<Page> page;
  String createdAt;
  String updatedAt;

  Data({this.id, this.nama, this.page, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    if (json['page'] != null) {
      page = new List<Page>();
      json['page'].forEach((v) {
        page.add(new Page.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    if (this.page != null) {
      data['page'] = this.page.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Page {
  String id;
  String judul;
  String createdAt;
  String updatedAt;

  Page({this.id, this.judul, this.createdAt, this.updatedAt});

  Page.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}