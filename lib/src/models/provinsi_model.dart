import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
    bool error;
    dynamic pesanSys;
    dynamic pesanUsr;
    List<Data> data;
    Paging paging;

    Province({
        this.error,
        this.pesanSys,
        this.pesanUsr,
        this.data,
        this.paging,
    });

    factory Province.fromJson(Map<String, dynamic> json) => Province(
        error: json["Error"],
        pesanSys: json["Pesan_sys"],
        pesanUsr: json["Pesan_usr"],
        data: List<Data>.from(json["Data"].map((x) => Data.fromJson(x))),
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

class Data {
    String id;
    String nama;

    Data({
        this.id,
        this.nama,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
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
