import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/ui/star.dart';
import 'package:siplah_jpmall/src/models/produk_sample.dart';

import 'package:flutter_sidekick/flutter_sidekick.dart';

class GridProduk extends StatefulWidget {
  @override
  _GridProdukState createState() => _GridProdukState();
}

class _GridProdukState extends State<GridProduk> with TickerProviderStateMixin {
  var f = NumberFormat("#,##0", "en_US");
  SidekickController controller;
  var liked = false;

  @override
  void initState() {
    super.initState();
    print(_listProduk.length.toString());
    controller =
        SidekickController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double ratio =
        MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, i) {
        var star =
            _listProduk[i].star.jumlahStar / _listProduk[i].star.jumlahUser;
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 350),
                  pageBuilder: (context, _, __) =>
                      DetailProduk(produk: _listProduk[i]))),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              height: 100,
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: 'image-${_listProduk[i].title}',
                        child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width /2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        _listProduk[i].gambar[1].link)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)))),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              setState(() {});
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: liked == true ? Colors.red : null,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: 150,
                    height: 50,
                    // color: Colors.black,
                    child: Text(
                      _listProduk[i].title,
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 150,
                    // color: Colors.black,
                    child: Text(
                      "Rp " + f.format(_listProduk[i].price),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: 150,
                    height: 20,
                    child: Row(
                      children: <Widget>[
                        _listProduk[i].toko.official == true
                            ? CircleAvatar(
                                child: Icon(
                                  Icons.store,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                minRadius: 13,
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.red,
                              )
                            : Container(),
                        SizedBox(
                            width:
                                _listProduk[i].toko.official == true ? 5.0 : 0),
                        Text(_listProduk[i].toko.lokasi)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Container(
                      width: 150,
                      child: StarDisplay(
                        value: star.toInt(),
                      )
          )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: _listProduk.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
//      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: MediaQuery.of(context).size.height /2.5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: ratio <= 2 ? 0.55 : 0.65),
    );
  }
}

//gridView(AsyncSnapshot<List<Products>> snapshot){

//}

List<Produk> _listProduk = <Produk>[
  Produk(
    index: 0,
    title: "Panduan Praktis Pengembangan Karakter dan Budaya Bangsa",
    kodeProduk: "051.UM.P00198",
    spek: Spesifikasi(
        190,
        "Pendidikan berbasis karakter menjadi tanggung jawab bersama untuk mengatasi persoalan bangsa. Sekolah, orang tua, dan masyarakat bersinergi mengembangkan program yang telah dicanangkan oleh pemerintah. Program ini menjadi keniscayaan dan perlu segera dilaksanakan.",
        Dimensi(210, 148, 1)),
    price: 140000,
    discount: 0,
    star: Star(jumlahStar: 18, jumlahUser: 4),
    toko: Toko(1,
        lokasi: "Semarang",
        namaToko: "Toko Buku Cerah Media",
        official: false,
        starToko: StarToko(jumlahStar: 19, jumlahUser: 4)),
    gambar: [
      Gambar(
          link:
              "http://jpstore.online/files/product/2019/buku-nonteks-sd-panduan-praktis-pengembangan-karakter-dan-budaya-bangsa.jpg"),
      Gambar(
          link:
              "http://jpstore.online/files/product/2019/buku-nonteks-sd-panduan-praktis-pengembangan-karakter-dan-budaya-bangsa.jpg"),
      Gambar(
          link:
              "http://jpstore.online/files/product/2019/buku-nonteks-sd-panduan-praktis-pengembangan-karakter-dan-budaya-bangsa.jpg"),
    ],
    loved: false,
    kategori: [
      Kategori(1, null, "BUKU NONTEKS SD"),
      Kategori(2, null, "BUKU NONTEKS SMP"),
      Kategori(3, null, "BUKU NONTEKS SMA"),
    ],
    stok: 100,
  ),
  Produk(
    //2
    index: 1,
    title: "Belajar Berbahagia sda",
    kodeProduk: "052.PY.B00208",
    spek: Spesifikasi(
        190,
        "Kebahagiaan seringkali menjadi tujuan hidup manusia. Tetapi untuk mencapainya tidak semudah membalikkan telapak tangan. Banyak masalah yang muncul sehubungan dengan hal tersebut. Di dalam buku ini, disajikan berbagai persoalan yang diangkat dari kisah keseharian remaja mencapai kebahagiaan. Masalah yang bisa saja terjadi pada kita semua. Permasalahan yang terjadi tersebut dilengkapi dengan dilema moral dari sudut pandang tokoh-tokohnya; alternatif solusi masalah yang bisa dipilih oleh pembaca beserta konsekuensi dari pilihannya; juga pojok teori yang berisi teori dan idealisme untuk belajar berbahagia. Semoga kita dapat memperoleh kebahagiaan yang hakiki.",
        Dimensi(210, 148, 1)),
    price: 140000,
    discount: 0,
    star: Star(jumlahStar: 18, jumlahUser: 4),
    toko: Toko(1,
        lokasi: "Jakarta Utara",
        namaToko: "Toko Buku Sumber Ilmu",
        official: true,
        starToko: StarToko(jumlahStar: 20, jumlahUser: 5)),
    gambar: [
      Gambar(
          link:
              "http://jpstore.online/files/product/2019/buku-nonteks-smp-belajar-berbahagia.jpg"),
      Gambar(
          link:
              "http://jpstore.online/files/product/2019/buku-nonteks-smp-belajar-berbahagia.jpg"),
      Gambar(
          link:
              "http://jpstore.online/files/product/2019/buku-nonteks-smp-belajar-berbahagia.jpg"),
    ],
    loved: true,
    kategori: [
      // Kategori(1, null, "BUKU NONTEKS SD"),
      Kategori(2, null, "BUKU NONTEKS SMP"),
      // Kategori(3, null, "BUKU NONTEKS SMA"),
    ],
    stok: 100,
  ),
  Produk(
    index: 2,
    title: "Buku Tulis",
    kodeProduk: "054.PY.B20398",
    spek: Spesifikasi(
        110,
        "Buku Tulis Biasa",
        Dimensi(210, 148, 1)),
    price: 3000,
    discount: 0,
    star: Star(jumlahStar: 2, jumlahUser: 2),
    toko: Toko(4,
        lokasi: "Malang",
        namaToko: "Toko Buku ",
        official: false,
        starToko: StarToko(jumlahStar: 2, jumlahUser: 2)),
    gambar: [
      Gambar(
          link:
              "http://jpstore.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg"),
      Gambar(
          link:
              "http://jpstore.online/files/product/2019/buku-nonteks-smp-budidaya-pisang.jpg"),
    ],
    loved: false,
    kategori: [
      // Kategori(1, null, "BUKU NONTEKS SD"),
      Kategori(4, null, "BUKU TULIS"),
      // Kategori(3, null, "BUKU NONTEKS SMA"),
    ],
    stok: 100,
  ),
  Produk(
    index: 3,
    title: "Buku Harian Kirana Tentang Sahabatku dan Indonesiaku",
    kodeProduk: "052.PY.B00398",
    spek: Spesifikasi(
        110,
        "Namaku kirana, aku bersekolah di SMP Bintang. Disekolah itulah aku memulai meretas mimpi mimpi dan cita citaku untuk mengikuti olimpiade matematika. Simak coretan diaryku menuju olimpiade dan kisah sahabatku, Maya dalam Diary Kirana",
        Dimensi(210, 148, 1)),
    price: 140000,
    discount: 0,
    star: Star(jumlahStar: 30, jumlahUser: 6),
    toko: Toko(1,
        lokasi: "Surabaya",
        namaToko: "Toko Hilir",
        official: false,
        starToko: StarToko(jumlahStar: 15, jumlahUser: 3)),
    gambar: [
      Gambar(
          link:
          "http://jpstore.online/files/product/2019/buku-nonteks-smp-buku-harian-kirana-tentang-sahabatku-dan-indonesiaku.jpg"),
      Gambar(
          link:
          "http://jpstore.online/files/product/2019/buku-nonteks-smp-buku-harian-kirana-tentang-sahabatku-dan-indonesiaku.jpg"),
      Gambar(
          link:
          "http://jpstore.online/files/product/2019/buku-nonteks-smp-buku-harian-kirana-tentang-sahabatku-dan-indonesiaku.jpg"),
      Gambar(
          link:
          "http://jpstore.online/files/product/2019/buku-nonteks-smp-buku-harian-kirana-tentang-sahabatku-dan-indonesiaku.jpg"),
    ],
    loved: false,
    kategori: [
      // Kategori(1, null, "BUKU NONTEKS SD"),
      Kategori(2, null, "BUKU NONTEKS SMP"),
      // Kategori(3, null, "BUKU NONTEKS SMA"),
    ],
    stok: 100,
  ),
];
