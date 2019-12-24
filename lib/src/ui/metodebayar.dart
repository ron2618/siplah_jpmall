import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/ui/pembayaran.dart';
class Metode extends StatefulWidget {
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
              onTap: (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => PembayaranState(imagebank: "https://siplah.jpstore.id/assets/images/payment/bca.png",
                          datatype: "bca_klikbca",databank: "",
                          ),
                        ));
              },
                  leading:ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 44,
    minHeight: 44,
    maxWidth: 64,
    maxHeight: 120,
  ),
  child: Image.network("https://siplah.jpstore.id/assets/images/payment/bca.png", fit: BoxFit.fill),
),
              title: Text("Bank BCA"),
            ),
              Divider(
              height: 3,
              color: Colors.grey,
            ),
             ListTile(
                   leading:ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 44,
    minHeight: 44,
    maxWidth: 64,
    maxHeight: 120,
  ),
  child: Image.network("https://siplah.jpstore.id/assets/images/payment/mandiri.png", fit: BoxFit.fill),
),
              title: Text("Bank Mandiri"),
            ),
                    Divider(
              height: 3,
              color: Colors.grey,
            ),
               ListTile(
                     leading:ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 44,
    minHeight: 44,
    maxWidth: 64,
    maxHeight: 120,
  ),
  child: Image.network("https://siplah.jpstore.id/assets/images/payment/bni.png", fit: BoxFit.fill),
),
              title: Text("Bank Bni"),
            ),
                    Divider(
              height: 3,
              color: Colors.grey,
            ),
             
             ListTile(
                   leading:ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 44,
    minHeight: 44,
    maxWidth: 64,
    maxHeight: 120,
  ),
  child: Image.network("https://siplah.jpstore.id/assets/images/payment/bca_klikpay.jpeg.png", fit: BoxFit.fill),
),
              title: Text("BCA KlikPay"),
            ),
                    Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
                  leading:ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 44,
    minHeight: 44,
    maxWidth: 64,
    maxHeight: 120,
  ),
  child: Image.network("https://siplah.jpstore.id/assets/images/payment/klik_bca.png", fit: BoxFit.fill),
),
              title: Text("Klik BCA"),
            ),
                    Divider(
              height: 3,
              color: Colors.grey,
            ),
               ListTile(
                  leading:ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 44,
    minHeight: 44,
    maxWidth: 64,
    maxHeight: 120,
  ),
  child: Image.network("https://siplah.jpstore.id/assets/images/payment/mandiri_clickpay.png", fit: BoxFit.fill),
),
              title: Text("Mandiri clickpay"),
            ),
                    Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
                 leading:ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 44,
    minHeight: 44,
    maxWidth: 64,
    maxHeight: 120,
  ),
  child: Image.network("https://siplah.jpstore.id/assets/images/payment/indomaret.jpg", fit: BoxFit.fill),
),
              title: Text("Indomaret"),
            ),
                    Divider(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              leading:ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 44,
    minHeight: 44,
    maxWidth: 64,
    maxHeight: 120,
  ),
  child: Image.network("https://siplah.jpstore.id/assets/images/payment/alfamart.png", fit: BoxFit.fill),
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
