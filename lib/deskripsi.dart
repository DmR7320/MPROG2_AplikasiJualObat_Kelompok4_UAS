import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/utama.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeskripsiApp extends StatelessWidget {
  const DeskripsiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const DeskripsiApp1(
          strBarang: '',
        ));
  }
}

class DeskripsiApp1 extends StatefulWidget {
  const DeskripsiApp1({Key? key, required this.strBarang}) : super(key: key);
  final String strBarang;

  @override
  // ignore: no_logic_in_create_state
  State<DeskripsiApp1> createState() => DeskripsiApp2(strBarang);
}

class DeskripsiApp2 extends State<DeskripsiApp1> {
  DeskripsiApp2(this.data);
  String data;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UtamaApp()));
          return Future.value(true);
        },
        child: Scaffold(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const UtamaApp()));
                          },
                          icon: const Icon(Icons.arrow_back),
                        ))),
                title: Container(
                    padding: const EdgeInsets.only(left: 45),
                    height: 75,
                    child: Image.asset("assets/medcurebanner.png"))),
            body: SingleChildScrollView(
                child: Column(children: [
              // ignore: avoid_unnecessary_containers
              Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('barang')
                          .where('nama', isEqualTo: data)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(children: [
                                Container(
                                    height: 400,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Image.network(
                                      snapshot.data!.docs[index].get('gambar'),
                                    )),
                                const SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('nama'),
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Nama : " +
                                      snapshot.data!.docs[index].get('nama')),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Deskripsi : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('deskripsi'),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Komposisi : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('komposisi'),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Manfaat : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('manfaat'),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Dosis : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('dosis'),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Efek Samping : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index]
                                        .get('efeksamping'),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Penyajian : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('penyajian'),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Perhatian : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('perhatian'),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Pabrik : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('pabrik'),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ]);
                            });
                      }))
            ]))));
  }
}
