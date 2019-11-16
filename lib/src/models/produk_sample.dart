class Produk {
  final int index;
  final String title;
  final String kodeProduk;
  final Spesifikasi spek;
  final double price;
  final double discount;
  final Star star;
  final Toko toko;
  final List<Gambar> gambar;
  final bool loved;
  final int stok;
  final List<Kategori> kategori;

  Produk({
    this.index,
    this.title,
    this.spek,
    this.kodeProduk,
    this.price,
    this.discount,
    this.star,
    this.toko,
    this.gambar,
    this.loved,
    this.stok,
    this.kategori,
  });
}

class Kategori {
  final int index;
  final int subKategori;
  final String nama;

  Kategori(this.index, this.subKategori, this.nama);
}

class Star {
  final double jumlahStar;
  final double jumlahUser;

  Star({this.jumlahStar, this.jumlahUser});
}

class Toko {
  final int index;
  final String namaToko;
  final String lokasi;
  final bool official;
  final StarToko starToko;

  Toko(this.index, {this.namaToko, this.lokasi, this.official, this.starToko});
}

class StarToko {
  final double jumlahStar;
  final double jumlahUser;

  StarToko({this.jumlahStar, this.jumlahUser});
}

class Gambar {
  final String link;

  Gambar({this.link});
}

class Spesifikasi {
  final double berat;
  final String deskripsi;
  final Dimensi dimen;

  Spesifikasi(this.berat, this.deskripsi, this.dimen);
}

class Dimensi {
  final double p;
  final double l;
  final double t;

  Dimensi(this.p, this.l, this.t);
}

