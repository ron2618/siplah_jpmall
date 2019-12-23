// To parse this JSON data, do
//
//     final kabupaten = kabupatenFromJson(jsonString);

import 'dart:convert';

Kabupaten kabupatenFromJson(String str) => Kabupaten.fromJson(json.decode(str));

String kabupatenToJson(Kabupaten data) => json.encode(data.toJson());

class Kabupaten {
    bool error;
    dynamic pesanSys;
    dynamic pesanUsr;
    List<Datum> data;
    Paging paging;

    Kabupaten({
        this.error,
        this.pesanSys,
        this.pesanUsr,
        this.data,
        this.paging,
    });

    factory Kabupaten.fromJson(Map<String, dynamic> json) => Kabupaten(
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
    String type;
    String kodePos;

    Datum({
        this.id,
        this.nama,
        this.type,
        this.kodePos,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        type: json["type"],
        kodePos: json["kode_pos"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "type": type,
        "kode_pos": kodePos,
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
