// To parse this JSON data, do
//
//     final kecamatan = kecamatanFromJson(jsonString);

import 'dart:convert';

Kecamatan kecamatanFromJson(String str) => Kecamatan.fromJson(json.decode(str));

String kecamatanToJson(Kecamatan data) => json.encode(data.toJson());

class Kecamatan {
    bool error;
    dynamic pesanSys;
    dynamic pesanUsr;
    List<Datum> data;
    Paging paging;

    Kecamatan({
        this.error,
        this.pesanSys,
        this.pesanUsr,
        this.data,
        this.paging,
    });

    factory Kecamatan.fromJson(Map<String, dynamic> json) => Kecamatan(
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
    String nama;

    Datum({
        this.id,
        this.nama,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
