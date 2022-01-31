import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/menu1.dart';
import 'package:medcurekelompok4uas/info.dart';
import 'package:medcurekelompok4uas/menu.dart';
import 'package:medcurekelompok4uas/menutips.dart';
import 'package:medcurekelompok4uas/ubahupdate.dart';
import 'package:medcurekelompok4uas/ubah.dart';
import 'package:medcurekelompok4uas/deskripsi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medcurekelompok4uas/ubahupdate.dart';

class UtamaApp extends StatelessWidget {
  const UtamaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: const Color(0xFFFFFFFF),
        )),
        home: TampilanApp());
  }
}

class TampilanApp extends StatelessWidget {
  const TampilanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: const Color(0xFFFFFFFF),
        )),
        home: UtamaApp1(
          title: '',
        ));
  }
}

class UtamaApp1 extends StatefulWidget {
  const UtamaApp1({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UtamaApp1> createState() => UtamaApp2();
}

class UtamaApp2 extends State<UtamaApp1> {
  String urllink = "";
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("barang").snapshots();
  String term = "";
  TextEditingController cari = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MenuApp()));
          return Future.value(true);
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => UbahApp()));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
              child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                controller: cari,
                onChanged: (String value) {
                  setState(() {
                    if (value != "") {
                      stream = FirebaseFirestore.instance
                          .collection('barang')
                          .where("nama", isEqualTo: value)
                          .snapshots();
                    } else {
                      stream = FirebaseFirestore.instance
                          .collection('barang')
                          .snapshots();
                    }
                  });
                },
              ),
            ),
            Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return GridView.builder(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 450),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.green,
                            child: Column(children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 150,
                                  child: Image.network(
                                    snapshot.data!.docs[index].get('gambar'),
                                  )),
                              Text(
                                snapshot.data!.docs[index].get('nama'),
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: Text("Beli",
                                      style: TextStyle(color: Colors.green))),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DeskripsiApp1(
                                                strBarang: snapshot
                                                    .data!.docs[index]
                                                    .get('nama'))));
                                  },
                                  child: Text(
                                    "Cek Info",
                                    style: TextStyle(color: Colors.green),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => UbahUpdateApp2(
                                                ubahbarang: snapshot
                                                    .data!.docs[index]
                                                    .get('nama'))));
                                  },
                                  child: Text(
                                    "Ubah",
                                    style: TextStyle(color: Colors.green),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () async {
                                    urllink = snapshot.data!.docs[index]
                                        .get('gambar');
                                    FirebaseStorage.instance
                                        .refFromURL(urllink)
                                        .delete();
                                    await FirebaseFirestore.instance
                                        .collection('barang')
                                        .where('gambar', isEqualTo: urllink)
                                        .get()
                                        .then((value) =>
                                            value.docs.forEach((element) {
                                              FirebaseFirestore.instance
                                                  .collection('barang')
                                                  .doc(element.id)
                                                  .delete()
                                                  .then((value) => null);
                                            }));
                                  },
                                  child: Text(
                                    "Hapus",
                                    style: TextStyle(color: Colors.green),
                                  )),
                            ]),
                          );
                        },
                      );
                    }))
          ])),
          appBar: AppBar(
            toolbarHeight: 100,
            leading: Container(
                padding: EdgeInsets.only(left: 20),
                child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                      padding: EdgeInsets.all(5),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MenuApp()));
                      },
                      icon: Icon(Icons.arrow_back),
                    ))),
            title: Container(
                padding: EdgeInsets.only(left: 40),
                height: 75,
                child: Image.asset("assets/medcurebanner.png")),
            actions: [
              Container(
                  padding: EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: IconButton(
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => InfoApp()));
                        },
                        icon: Icon(Icons.info),
                      )))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MenuTips()));
            },
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            selectedFontSize: 15,
            currentIndex: 0,
            iconSize: 30,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services),
                label: 'Barang',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb), label: 'Tips')
            ],
            showSelectedLabels: true,
            showUnselectedLabels: false,
          ),
        ));
  }
}
