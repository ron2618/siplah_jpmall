import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
  bool status;
  String message;
  List<Result> results;

  Province({
    this.status,
    this.message,
    this.results,
  });

  factory Province.fromJson(Map<String, dynamic> json) => new Province(
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
  String provinsiId;
  String namaProvinsi;

  Result({
    this.provinsiId,
    this.namaProvinsi,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    provinsiId: json["provinsi_id"],
    namaProvinsi: json["nama_provinsi"],
  );

  Map<String, dynamic> toJson() => {
    "provinsi_id": provinsiId,
    "nama_provinsi": namaProvinsi,
  };
}
