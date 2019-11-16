import 'dart:convert';

Kecamatan kecamatanFromJson(String str) => Kecamatan.fromJson(json.decode(str));

String kecamatanToJson(Kecamatan data) => json.encode(data.toJson());

class Kecamatan {
  bool status;
  String message;
  List<Result> results;

  Kecamatan({
    this.status,
    this.message,
    this.results,
  });

  factory Kecamatan.fromJson(Map<String, dynamic> json) => new Kecamatan(
    status: json["status"],
    message: json["message"],
    results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "results": new List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String kecamatanId;
  String kabupatenId;
  String namaKecamatan;

  Result({
    this.kecamatanId,
    this.kabupatenId,
    this.namaKecamatan,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    kecamatanId: json["kecamatan_id"],
    kabupatenId: json["kabupaten_id"],
    namaKecamatan: json["nama_kecamatan"],
  );

  Map<String, dynamic> toJson() => {
    "kecamatan_id": kecamatanId,
    "kabupaten_id": kabupatenId,
    "nama_kecamatan": namaKecamatan,
  };
}
