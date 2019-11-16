import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/models/produk_sample.dart';
import 'package:siplah_jpmall/src/ui/flashdeal.dart';
import 'package:siplah_jpmall/src/ui/nontext.dart';
import 'package:siplah_jpmall/src/ui/alatperaga.dart';
import 'package:siplah_jpmall/src/ui/Pendamping.dart';
import 'package:siplah_jpmall/src/ui/gridkategori.dart';
import 'package:siplah_jpmall/src/ui/gridproduk.dart';
import 'package:siplah_jpmall/src/ui/imageslider.dart';
import 'package:siplah_jpmall/src/ui/myappbar.dart';
import 'package:siplah_jpmall/src/ui/myflexspace.dart';
import 'package:siplah_jpmall/src/ui/pendamping.dart' as prefix0;
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/ui/rekomtoko.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double posisi = 0.0;
  int currentPage = 0;
  ScrollController _controller;
  _scrollListener() {
//     if (_controller.offset >= _controller.position.maxScrollExtent &&
//         !_controller.position.outOfRange) {
//       setState(() {
//         message = "reach the bottom";
//       });
//         // print("reach the bottom");
//     }
//     if (_controller.offset <= _controller.position.minScrollExtent &&
//         !_controller.position.outOfRange) {
//       setState(() {
//         message = "reach the top";
//       });
//         // print("reach the top");
//     }
    setState(() {
      posisi = _controller.offset;
    });
  }

  @override
  void initState() {
    super.initState();
//    print("Aspect Ratio : "+MediaQuery.of(context).size.aspectRatio.toString());
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (context, inner) {
            return [
              SliverAppBar(
                title: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    firstChild: MyAppBarNormal(),
                    secondChild: MyAppBarAbNormal(),
                    crossFadeState: posisi <= 27
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstCurve: Curves.bounceIn,
                    secondCurve: Curves.bounceInOut),
                // title: AnimatedContainer(
                //   duration: Duration(seconds: 3),
                //   curve: Curves.decelerate,
                //   child: _controller.offset <= 27 ? MyAppBarNormal() : MyAppBarAbNormal()
                // ),
                // title: Transform.scale(
                //   scale: 12.0,
                //   child: posisi >= 27 ? MyAppBarNormal() : MyAppBarAbNormal()),
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  background: MyFlexSpace(),
                ),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ImageSlider(),
                SizedBox(
                  height: 10,
                ),
                FlashDeal(data: _listProduk),
                SizedBox(
                  height: 10,
                ),
                Nontext(data: _listProduk),
                SizedBox(
                  height: 10,
                ),
                Pendamping(data: _listProduk),
                SizedBox(
                  height: 10,
                ),
                Alatperaga(data: _listProduk),
                SizedBox(
                  height: 10,
                ),
                GridKategori(),
                RekomToko(),
                SizedBox(height: 10.0,),
              
                // Column(
                //   children: List.generate(50, (p) {
                //     return ListTile(
                //       title: Text("Item Count $p"),
                //     );
                //   }),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
              ]),
            ],
          )),
    );
  }
}
class Cat1 extends StatelessWidget {
  var f = NumberFormat("#,##0", "en_US");
  var list = _listProduk;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(list.length, (i) => Container(
          padding: const EdgeInsets.all(8.0),
          height: 180,
          width: 120,
          child: GestureDetector(
            onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 350),
                pageBuilder: (context, _, __) =>
                    DetailProduk2(produk: _listProduk[i]))),
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(list[i].gambar[0].link))
                  ),),
                SizedBox(height: 5.0),
                Container(
                  height: 40,
                  child: Text(list[i].title,textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                  ), maxLines: 2, overflow: TextOverflow.ellipsis,),
                ),
                SizedBox(height:5.0),
                Text("Rp ${f.format(list[i].price)}",style: TextStyle(
                    fontSize: 14,
                ),),
                SizedBox(height:5.0),
                Text(list[i].toko.lokasi, style: TextStyle(
                  fontSize: 12
                ),)
              ],
            ),
          ),
        )),
      ),
    );
  }
}

List<Produk> _listProduk = <Produk>[
  Produk(
    index: 0,
    title: "Panduan Praktis Pengembangan Aplikasi berbasis Mobile",
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
          "http://ecs7.tokopedia.net/img/cache/700/product-1/2018/12/27/44760629/44760629_ab85161d-287f-48cb-8d73-0ceac2ba64d3_370_543.jpg"),
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
    title: "Belajar Berbahagia",
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
          "http://ecs7.tokopedia.net/img/cache/200-square/product-1/2019/2/11/4648816/4648816_14718806-cfcf-41f3-85ba-cc783a80a7a3_393_393.jpg"),
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
