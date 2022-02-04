import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/info.dart';
import 'package:medcurekelompok4uas/menu.dart';
import 'package:medcurekelompok4uas/menutips.dart';
import 'package:medcurekelompok4uas/ubahupdate.dart';
import 'package:medcurekelompok4uas/ubah.dart';
import 'package:medcurekelompok4uas/deskripsi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UtamaApp extends StatelessWidget {
  const UtamaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const TampilanApp());
  }
}

class TampilanApp extends StatelessWidget {
  const TampilanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const UtamaApp1(
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
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const MenuApp()));
          return Future.value(true);
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const UbahApp()));
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
              child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(
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
            // ignore: avoid_unnecessary_containers
            Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.only(left: 10, right: 10),
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
                              const SizedBox(
                                height: 10,
                              ),
                              // ignore: sized_box_for_whitespace
                              Container(
                                  height: 150,
                                  child: Image.network(
                                    snapshot.data!.docs[index].get('gambar'),
                                  )),
                              Text(
                                snapshot.data!.docs[index].get('nama'),
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text("Beli",
                                      style: TextStyle(color: Colors.green))),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DeskripsiApp1(
                                                strBarang: snapshot
                                                    .data!.docs[index]
                                                    .get('nama'))));
                                  },
                                  child: const Text(
                                    "Cek Info",
                                    style: TextStyle(color: Colors.green),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => UbahUpdateApp2(
                                                ubahbarang: snapshot
                                                    .data!.docs[index]
                                                    .get('nama'))));
                                  },
                                  child: const Text(
                                    "Ubah",
                                    style: TextStyle(color: Colors.green),
                                  )),
                              const SizedBox(
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
                                            // ignore: avoid_function_literals_in_foreach_calls
                                            value.docs.forEach((element) {
                                              FirebaseFirestore.instance
                                                  .collection('barang')
                                                  .doc(element.id)
                                                  .delete()
                                                  .then((value) => null);
                                            }));
                                  },
                                  child: const Text(
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
                padding: const EdgeInsets.only(left: 20),
                child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const MenuApp()));
                      },
                      icon: const Icon(Icons.arrow_back),
                    ))),
            title: Container(
                padding: const EdgeInsets.only(left: 40),
                height: 75,
                child: Image.asset("assets/medcurebanner.png")),
            actions: [
              Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: IconButton(
                        padding: const EdgeInsets.all(5),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const InfoApp()));
                        },
                        icon: const Icon(Icons.info),
                      )))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const MenuTips()));
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
