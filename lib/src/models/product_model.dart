import 'dart:convert';

List<Products> productsFromJson(String str) => new List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  int index;
  String title;
  String kodeProduk;
  List<Spesifikasi> spesifikasi;
  String deskripsi;
  int harga;
  int discount;
  Rating rating;
  Toko toko;
  List<Gambar> gambar;
  int stock;
  List<Kategori> kategori;

  Products({
    this.index,
    this.title,
    this.kodeProduk,
    this.spesifikasi,
    this.deskripsi,
    this.harga,
    this.discount,
    this.rating,
    this.toko,
    this.gambar,
    this.stock,
    this.kategori,
  });

  factory Products.fromJson(Map<String, dynamic> json) => new Products(
    index: json["index"] == null ? null : json["index"],
    title: json["title"] == null ? null : json["title"],
    kodeProduk: json["kode_produk"] == null ? null : json["kode_produk"],
    spesifikasi: json["spesifikasi"] == null ? null : new List<Spesifikasi>.from(json["spesifikasi"].map((x) => Spesifikasi.fromJson(x))),
    deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
    harga: json["harga"] == null ? null : json["harga"],
    discount: json["discount"] == null ? null : json["discount"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
    toko: json["toko"] == null ? null : Toko.fromJson(json["toko"]),
    gambar: json["gambar"] == null ? null : new List<Gambar>.from(json["gambar"].map((x) => Gambar.fromJson(x))),
    stock: json["stock"] == null ? null : json["stock"],
    kategori: json["kategori"] == null ? null : new List<Kategori>.from(json["kategori"].map((x) => Kategori.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "index": index == null ? null : index,
    "title": title == null ? null : title,
    "kode_produk": kodeProduk == null ? null : kodeProduk,
    "spesifikasi": spesifikasi == null ? null : new List<dynamic>.from(spesifikasi.map((x) => x.toJson())),
    "deskripsi": deskripsi == null ? null : deskripsi,
    "harga": harga == null ? null : harga,
    "discount": discount == null ? null : discount,
    "rating": rating == null ? null : rating.toJson(),
    "toko": toko == null ? null : toko.toJson(),
    "gambar": gambar == null ? null : new List<dynamic>.from(gambar.map((x) => x.toJson())),
    "stock": stock == null ? null : stock,
    "kategori": kategori == null ? null : new List<dynamic>.from(kategori.map((x) => x.toJson())),
  };
}

class Gambar {
  String url;

  Gambar({
    this.url,
  });

  factory Gambar.fromJson(Map<String, dynamic> json) => new Gambar(
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
  };
}

class Kategori {
  int index;
  int sub;
  String nama;

  Kategori({
    this.index,
    this.sub,
    this.nama,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => new Kategori(
    index: json["index"] == null ? null : json["index"],
    sub: json["sub"] == null ? null : json["sub"],
    nama: json["nama"] == null ? null : json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "index": index == null ? null : index,
    "sub": sub == null ? null : sub,
    "nama": nama == null ? null : nama,
  };
}

class Rating {
  int jumlahStar;
  int jumlahVote;

  Rating({
    this.jumlahStar,
    this.jumlahVote,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => new Rating(
    jumlahStar: json["jumlah_star"] == null ? null : json["jumlah_star"],
    jumlahVote: json["jumlah_vote"] == null ? null : json["jumlah_vote"],
  );

  Map<String, dynamic> toJson() => {
    "jumlah_star": jumlahStar == null ? null : jumlahStar,
    "jumlah_vote": jumlahVote == null ? null : jumlahVote,
  };
}

class Spesifikasi {
  String title;
  String value;

  Spesifikasi({
    this.title,
    this.value,
  });

  factory Spesifikasi.fromJson(Map<String, dynamic> json) => new Spesifikasi(
    title: json["title"] == null ? null : json["title"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "value": value == null ? null : value,
  };
}

class Toko {
  int index;
  String nama;
  String lokasi;
  String alamat;
  bool official;
  Rating rating;

  Toko({
    this.index,
    this.nama,
    this.lokasi,
    this.alamat,
    this.official,
    this.rating,
  });

  factory Toko.fromJson(Map<String, dynamic> json) => new Toko(
    index: json["index"] == null ? null : json["index"],
    nama: json["nama"] == null ? null : json["nama"],
    lokasi: json["lokasi"] == null ? null : json["lokasi"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    official: json["official"] == null ? null : json["official"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "index": index == null ? null : index,
    "nama": nama == null ? null : nama,
    "lokasi": lokasi == null ? null : lokasi,
    "alamat": alamat == null ? null : alamat,
    "official": official == null ? null : official,
    "rating": rating == null ? null : rating.toJson(),
  };
}