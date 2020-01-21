import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/ui/pembayaran.dart';

class Metode extends StatefulWidget {
  final String imagebank;
  final String datatype;
  final String databank;
  final int totalharga;
  final String namamar;
  final String imagekurir;
  final int cost;
  final String idmar;
  final String ketkur;
  final String namakur;
  final int idtrans;

  const Metode({Key key, this.imagebank, this.datatype, this.databank, this.totalharga, this.namamar, this.imagekurir, this.cost, this.idmar, this.ketkur, this.namakur, this.idtrans}) : super(key: key);
  

  @override
  _MetodeState createState() => _MetodeState();
}

class _MetodeState extends State<Metode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Metode Pembayaran"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Divider(
              height: 2,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PembayaranState(
                          imagebank:
                              "https://siplah.mascitra.co.id/assets/images/payment/bca.png",
                          datatype: "bank_tranfer",
                          databank: "bca",
                          totalharga: widget.totalharga,
                          imagekurir: widget.imagekurir,
                          namamar: widget.namamar,
                          cost: widget.cost,
                          idmar: widget.idmar,
                          ketkur: widget.ketkur,
                          namakur: widget.namakur,
                          idtrans: widget.idtrans)
                    ));
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 120,
                ),
                child: Image.network(
                    "https://siplah.mascitra.co.id/assets/images/payment/bca.png",
                    fit: BoxFit.fill),
              ),
              title: Text("Bank BCA"),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PembayaranState(
                          imagebank:
                              "https://siplah.mascitra.co.id/assets/images/payment/mandiri.png",
                          datatype: "bank_transfer",
                          databank: "mandiri",
                          totalharga: widget.totalharga,
                          imagekurir: widget.imagekurir,
                          namamar: widget.namamar,
                          cost: widget.cost,
                          idmar: widget.idmar,
                          ketkur: widget.ketkur,
                          namakur: widget.namakur,
                          idtrans: widget.idtrans),
                    ));
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 120,
                ),
                child: Image.network(
                    "https://siplah.mascitra.co.id/assets/images/payment/mandiri.png",
                    fit: BoxFit.fill),
              ),
              title: Text("Bank Mandiri"),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PembayaranState(
                          imagebank:
                              "https://siplah.mascitra.co.id/assets/images/payment/bni.png",
                          datatype: "bank_transfer",
                          databank: "bni",
                          totalharga: widget.totalharga,
                          imagekurir: widget.imagekurir,
                          namamar: widget.namamar,
                          cost: widget.cost,
                          idmar: widget.idmar,
                          ketkur: widget.ketkur,
                          namakur: widget.namakur,
                          idtrans: widget.idtrans),
                    ));
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 120,
                ),
                child: Image.network(
                    "https://siplah.mascitra.co.id/assets/images/payment/bni.png",
                    fit: BoxFit.fill),
              ),
              title: Text("Bank Bni"),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PembayaranState(
                          imagebank:
                              "https://siplah.mascitra.co.id/assets/images/payment/bca_klikpay.jpeg.png",
                          datatype: "internet_banking",
                          databank: "bca_klikpay",
                          totalharga: widget.totalharga,
                          imagekurir: widget.imagekurir,
                          namamar: widget.namamar,
                          cost: widget.cost,
                          idmar: widget.idmar,
                          ketkur: widget.ketkur,
                          namakur: widget.namakur,
                          idtrans: widget.idtrans),
                    ));
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 120,
                ),
                child: Image.network(
                    "https://siplah.mascitra.co.id/assets/images/payment/bca_klikpay.jpeg.png",
                    fit: BoxFit.fill),
              ),
              title: Text("BCA KlikPay"),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PembayaranState(
                          imagebank:
                              "https://siplah.mascitra.co.id/assets/images/payment/klik_bca.png",
                          datatype: "internet_banking",
                          databank: "bca_klikbca",
                          totalharga: widget.totalharga,
                          imagekurir: widget.imagekurir,
                          namamar: widget.namamar,
                          cost: widget.cost,
                          idmar: widget.idmar,
                          ketkur: widget.ketkur,
                          namakur: widget.namakur,
                          idtrans: widget.idtrans),
                    ));
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 120,
                ),
                child: Image.network(
                    "https://siplah.mascitra.co.id/assets/images/payment/klik_bca.png",
                    fit: BoxFit.fill),
              ),
              title: Text("Klik BCA"),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PembayaranState(
                          imagebank:
                              "https://siplah.mascitra.co.id/assets/images/payment/mandiri_clickpay.png",
                          datatype: "internet_banking",
                          databank: "mandiri_clickpay",
                          totalharga: widget.totalharga,
                          imagekurir: widget.imagekurir,
                          namamar: widget.namamar,
                          cost: widget.cost,
                          idmar: widget.idmar,
                          ketkur: widget.ketkur,
                          namakur: widget.namakur,
                          idtrans: widget.idtrans),
                    ));
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 120,
                ),
                child: Image.network(
                    "https://siplah.mascitra.co.id/assets/images/payment/mandiri_clickpay.png",
                    fit: BoxFit.fill),
              ),
              title: Text("Mandiri clickpay"),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PembayaranState(
                          imagebank:
                              "https://siplah.mascitra.co.id/assets/images/payment/indomaret.jpg",
                          datatype: "cstore",
                          databank: "Indomaret",
                          totalharga: widget.totalharga,
                          imagekurir: widget.imagekurir,
                          namamar: widget.namamar,
                          cost: widget.cost,
                          idmar: widget.idmar,
                          ketkur: widget.ketkur,
                          namakur: widget.namakur,
                          idtrans: widget.idtrans),
                    ));
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 120,
                ),
                child: Image.network(
                    "https://siplah.mascitra.co.id/assets/images/payment/indomaret.jpg",
                    fit: BoxFit.fill),
              ),
              title: Text("Indomaret"),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PembayaranState(
                          imagebank:
                              "https://siplah.mascitra.co.id/assets/images/payment/alfamart.png",
                          datatype: "cstore",
                          databank: "alfamart",
                          totalharga: widget.totalharga,
                          imagekurir: widget.imagekurir,
                          namamar: widget.namamar,
                          cost: widget.cost,
                          idmar: widget.idmar,
                          ketkur: widget.ketkur,
                          namakur: widget.namakur,
                          idtrans: widget.idtrans),
                    ));
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 120,
                ),
                child: Image.network(
                    "https://siplah.mascitra.co.id/assets/images/payment/alfamart.png",
                    fit: BoxFit.fill),
              ),
              title: Text("Alfamart"),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
