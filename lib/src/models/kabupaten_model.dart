import 'dart:convert';

Kabupaten kabupatenFromJson(String str) => Kabupaten.fromJson(json.decode(str));

String kabupatenToJson(Kabupaten data) => json.encode(data.toJson());

class Kabupaten {
  bool status;
  String message;
  List<Result> results;

  Kabupaten({
    this.status,
    this.message,
    this.results,
  });

  factory Kabupaten.fromJson(Map<String, dynamic> json) => new Kabupaten(
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
  String kabupatenId;
  String provinsiId;
  String namaKabupaten;

  Result({
    this.kabupatenId,
    this.provinsiId,
    this.namaKabupaten,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    kabupatenId: json["kabupaten_id"],
    provinsiId: json["provinsi_id"],
    namaKabupaten: json["nama_kabupaten"],
  );

  Map<String, dynamic> toJson() => {
    "kabupaten_id": kabupatenId,
    "provinsi_id": provinsiId,
    "nama_kabupaten": namaKabupaten,
  };
}
