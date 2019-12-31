import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/ui/pembayaran.dart';

class Kurir extends StatefulWidget {
  final String kabu;
  final String tuju;
  final String imagebank;
  final String datatype;
  final String databank;
  final int totalharga;
  final String namamar;
  final String imagekurir;
  final int cost;
  final String idmar;

  const Kurir({Key key, this.kabu, this.tuju, this.imagebank, this.datatype, this.databank, this.totalharga, this.namamar, this.imagekurir, this.cost, this.idmar}) : super(key: key);

 
  @override
  _KurirState createState() => _KurirState();
}

class _KurirState extends State<Kurir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: new Text(
            "Pilih Kurir",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => KurirJNE(
                            kabu: widget.kabu,
                            tuju: widget.tuju,
                            totalharga: widget.totalharga,
                            imagebank: widget.imagebank,
                            imagekurir: widget.imagekurir,
                            namamar: widget.namamar,
                            databank: widget.databank,
                            datatype: widget.datatype,
                            cost: widget.cost,
                            idmar:widget.idmar),
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
                      "https://www.jne.co.id/frontend/images/material/logo.jpg",
                      fit: BoxFit.fill),
                ),
                title: Text("JNE Express"),
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => KurirJNT(
                            kabu: widget.kabu,
                            tuju: widget.tuju,
                            totalharga: widget.totalharga,
                            imagebank: widget.imagebank,
                            imagekurir: widget.imagekurir,
                            namamar: widget.namamar,
                            databank: widget.databank,
                            datatype: widget.datatype,
                            cost: widget.cost,
                            idmar:widget.idmar),
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
                      "http://www.jet.co.id/images/logo-red.png",
                      fit: BoxFit.fill),
                ),
                title: Text("J&T Express"),
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => KurirTIKI(
                                kabu: widget.kabu,
                                tuju: widget.tuju,
                                totalharga: widget.totalharga,
                                imagebank: widget.imagebank,
                                imagekurir: widget.imagekurir,
                                namamar: widget.namamar,
                                databank: widget.databank,
                                datatype: widget.datatype,
                                cost: widget.cost,
                                idmar:widget.idmar
                              )));
                },
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 64,
                    maxHeight: 120,
                  ),
                  child: Image.network("https://tiki.id/images/logo/nav.png",
                      fit: BoxFit.fill),
                ),
                title: Text("TIKI Express"),
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => KurirPos(
                            kabu: widget.kabu,
                            tuju: widget.tuju,
                            totalharga: widget.totalharga,
                            imagebank: widget.imagebank,
                            imagekurir: widget.imagekurir,
                            namamar: widget.namamar,
                            databank: widget.databank,
                            datatype: widget.datatype,
                            cost: widget.cost,
                            idmar:widget.idmar),
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
                      "https://www.posindonesia.co.id/img/logo-pos.svg",
                      fit: BoxFit.fill),
                ),
                title: Text("Pos Indonesia"),
              ),
            ],
          ),
        ));
  }
}

class KurirJNE extends StatefulWidget {
  final String kabu;
  final String tuju;
  final String imagebank;
  final String datatype;
  final String databank;
  final int totalharga;
  final String namamar;
  final String imagekurir;
  final int cost;
  final String idmar;

  const KurirJNE({Key key, this.kabu, this.tuju, this.imagebank, this.datatype, this.databank, this.totalharga, this.namamar, this.imagekurir, this.cost, this.idmar}) : super(key: key);

  
  @override
  _KurirJneState createState() => _KurirJneState();
}

class _KurirJneState extends State<KurirJNE> {
  List datajne, pnjngjne;
  Future<String> getKurirJne(String a, b) async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('https://siplah.mascitra.co.id/rajaongkir/ongkir/kurir'),
      headers: {
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "5001f5027fa23b07dc10b652c03dd11b8d8732e4"
      },
      body: {
        "asal": widget.kabu,
        "tujuan": widget.tuju,
        "berat": "100",
        "kurir": "jne",
      },
    );
    //print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datajne = convertDataToJson['results'];
      pnjngjne = convertDataToJson['results'][0]['costs'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    getKurirJne(widget.kabu, widget.tuju);

    return Scaffold(
      appBar: AppBar(
        title: Text("Kurir JNE"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: datajne == null
            ? Column(
                children: <Widget>[Center(child: CircularProgressIndicator())])
            : ListView.builder(
                scrollDirection: Axis.vertical,
                // physics: ScrollPhysics(),
                // shrinkWrap: true,
                itemCount: pnjngjne.length,
                itemBuilder: (context, i) {
                  //print(data[i]['is_utama']);
                  final x = datajne[i]['costs'];
                  final y = datajne[i]['costs'][0]['cost'];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: SizedBox(
                        height: 165,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: <Widget>[
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(datajne[i]['code']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(x[i]['description']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(y[i]['etd'],
                                                  textAlign: TextAlign.left),
                                            )
                                          ],
                                        ),
                                        Row(children: <Widget>[
                                          Flexible(
                                              fit: FlexFit.tight,
                                              child: SizedBox()),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.navigate_next,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              PembayaranState(
                                                            imagekurir:
                                                                "https://www.jne.co.id/frontend/images/material/logo.jpg",
                                                            cost: y[i]['value'],
                                                            totalharga: widget
                                                                .totalharga,
                                                            imagebank: widget
                                                                .imagebank,
                                                            namamar:
                                                                widget.namamar,
                                                            databank:
                                                                widget.databank,
                                                            datatype:
                                                                widget.datatype,
                                                                idmar: widget.idmar,
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              )),
                                        ]),
                                      ]),
                                ]))
                          ]),
                        )),
                  );
                },
              ),
      ),
    );
  }
}

class KurirJNT extends StatefulWidget {
  final String kabu;
  final String tuju;
  final String imagebank;
  final String datatype;
  final String databank;
  final int totalharga;
  final String namamar;
  final String imagekurir;
  final int cost;
  final String idmar;

  const KurirJNT({Key key, this.kabu, this.tuju, this.imagebank, this.datatype, this.databank, this.totalharga, this.namamar, this.imagekurir, this.cost, this.idmar}) : super(key: key);

  @override
  _KurirJntState createState() => _KurirJntState();
}

class _KurirJntState extends State<KurirJNT> {
  List datajnt, pnjngjnt;
  Future<String> getKurirJnt() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('https://siplah.mascitra.co.id/rajaongkir/ongkir/kurir'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        'asal': widget.kabu,
        'tujuan': widget.tuju,
        'berat': "100",
        'kurir': 'jnt',
      },
    );
    // print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datajnt = convertDataToJson['results'];
      pnjngjnt = convertDataToJson['results'][0]['costs'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    getKurirJnt();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kurir JNT"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: datajnt == null
            ? Column(
                children: <Widget>[Center(child: CircularProgressIndicator())])
            : ListView.builder(
                scrollDirection: Axis.vertical,
                // physics: ScrollPhysics(),
                // shrinkWrap: true,
                itemCount: pnjngjnt.length,
                itemBuilder: (context, i) {
                  //print(data[i]['is_utama']);
                  final x = datajnt[i]['costs'];
                  final y = datajnt[i]['costs'][0]['cost'];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: SizedBox(
                        height: 165,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: <Widget>[
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(datajnt[i]['code']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(x[i]['description']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(y[i]['etd'],
                                                  textAlign: TextAlign.left),
                                            )
                                          ],
                                        ),
                                        Row(children: <Widget>[
                                          Flexible(
                                              fit: FlexFit.tight,
                                              child: SizedBox()),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.navigate_next,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              PembayaranState(
                                                            imagekurir:
                                                                "http://www.jet.co.id/images/logo-red.png",
                                                            cost: y[i]['value'],
                                                            totalharga: widget
                                                                .totalharga,
                                                            imagebank: widget
                                                                .imagebank,
                                                            namamar:
                                                                widget.namamar,
                                                            databank:
                                                                widget.databank,
                                                            datatype:
                                                                widget.datatype,
                                                                idmar: widget.idmar,
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              )),
                                        ]),
                                      ]),
                                ]))
                          ]),
                        )),
                  );
                },
              ),
      ),
    );
  }
}

class KurirPos extends StatefulWidget {
  final String kabu;
  final String tuju;
  final String imagebank;
  final String datatype;
  final String databank;
  final int totalharga;
  final String namamar;
  final String imagekurir;
  final int cost;
  final String idmar;

  const KurirPos({Key key, this.kabu, this.tuju, this.imagebank, this.datatype, this.databank, this.totalharga, this.namamar, this.imagekurir, this.cost, this.idmar}) : super(key: key);

  @override
  _KurirPosState createState() => _KurirPosState();
}

class _KurirPosState extends State<KurirPos> {
  List datapos, pnjngpos;
  Future<String> getKurirPos() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('https://siplah.mascitra.co.id/rajaongkir/ongkir/kurir'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        'asal': widget.kabu,
        'tujuan': widget.tuju,
        'berat': "100",
        'kurir': 'pos',
      },
    );
    // print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datapos = convertDataToJson['results'];
      pnjngpos = convertDataToJson['results']['costs'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    getKurirPos();
    print(datapos);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurir POS"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: datapos == null
            ? Column(
                children: <Widget>[Center(child: CircularProgressIndicator())])
            : ListView.builder(
                scrollDirection: Axis.vertical,
                // physics: ScrollPhysics(),
                // shrinkWrap: true,
                itemCount: datapos.length,
                itemBuilder: (context, i) {
                  //print(data[i]['is_utama']);
                  final x = datapos[i]['costs'];
                  final y = datapos[i]['costs'][0]['cost'];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: SizedBox(
                        height: 165,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: <Widget>[
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(x[i]['service']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(x[i]['description']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(y[i]['etd'],
                                                  textAlign: TextAlign.left),
                                            )
                                          ],
                                        ),
                                        Row(children: <Widget>[
                                          Flexible(
                                              fit: FlexFit.tight,
                                              child: SizedBox()),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.navigate_next,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              PembayaranState(
                                                            imagebank:
                                                                "https://www.posindonesia.co.id/img/logo-pos.svg",
                                                            cost: y[i]['value'],
                                                            totalharga: widget
                                                                .totalharga,
                                                            imagekurir: widget
                                                                .imagekurir,
                                                            namamar:
                                                                widget.namamar,
                                                            databank:
                                                                widget.databank,
                                                            datatype:
                                                                widget.datatype,
                                                                idmar: widget.idmar,
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              )),
                                        ]),
                                      ]),
                                ]))
                          ]),
                        )),
                  );
                },
              ),
      ),
    );
  }
}

class KurirTIKI extends StatefulWidget {
  final String kabu;
  final String tuju;
  final String imagebank;
  final String datatype;
  final String databank;
  final int totalharga;
  final String namamar;
  final String imagekurir;
  final int cost;
  final String idmar;

  const KurirTIKI({Key key, this.kabu, this.tuju, this.imagebank, this.datatype, this.databank, this.totalharga, this.namamar, this.imagekurir, this.cost, this.idmar}) : super(key: key);

  @override
  _KurirTikiState createState() => _KurirTikiState();
}

class _KurirTikiState extends State<KurirTIKI> {
  List datatiki, pnjngtiki;
  Future<String> getKurirTiki() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('https://siplah.mascitra.co.id/rajaongkir/ongkir/kurir'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        'asal': widget.kabu,
        'tujuan': widget.tuju,
        'berat': "100",
        'kurir': 'tiki',
      },
    );
    // print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datatiki = convertDataToJson['results'];
      pnjngtiki = convertDataToJson['results'][0]['costs'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    getKurirTiki();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kurir Tiki"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: datatiki == null
            ? Column(
                children: <Widget>[Center(child: CircularProgressIndicator())])
            : ListView.builder(
                scrollDirection: Axis.vertical,
                // physics: ScrollPhysics(),
                // shrinkWrap: true,
                itemCount: pnjngtiki.length,
                itemBuilder: (context, i) {
                  //print(data[i]['is_utama']);
                  final x = datatiki[i]['costs'];
                  final y = datatiki[i]['costs'][0]['cost'];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: SizedBox(
                        height: 165,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: <Widget>[
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(datatiki[i]['code']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(x[i]['description']),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(y[i]['etd'],
                                                  textAlign: TextAlign.left),
                                            )
                                          ],
                                        ),
                                        Row(children: <Widget>[
                                          Flexible(
                                              fit: FlexFit.tight,
                                              child: SizedBox()),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.navigate_next,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              PembayaranState(
                                                            imagekurir:
                                                                "https://tiki.id/images/logo/nav.png",
                                                            cost: y[i]['value'],
                                                            totalharga: widget
                                                                .totalharga,
                                                            imagebank: widget
                                                                .imagebank,
                                                            namamar:
                                                                widget.namamar,
                                                            databank:
                                                                widget.databank,
                                                            datatype:
                                                                widget.datatype,
                                                                idmar: widget.idmar,
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              )),
                                        ]),
                                      ]),
                                ]))
                          ]),
                        )),
                  );
                },
              ),
      ),
    );
  }
}
