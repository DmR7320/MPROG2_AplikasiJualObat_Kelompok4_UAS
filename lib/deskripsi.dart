import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/menu1.dart';
import 'package:medcurekelompok4uas/menu.dart';
import 'package:medcurekelompok4uas/menutips.dart';
import 'package:medcurekelompok4uas/ubah.dart';
import 'package:medcurekelompok4uas/utama.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class DeskripsiApp extends StatelessWidget {
  const DeskripsiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: const Color(0xFFFFFFFF),
        )),
        home: DeskripsiApp1(
          strBarang: '',
        ));
  }
}

class DeskripsiApp1 extends StatefulWidget {
  const DeskripsiApp1({Key? key, required this.strBarang}) : super(key: key);
  final String strBarang;

  @override
  State<DeskripsiApp1> createState() => DeskripsiApp2(strBarang);
}

class DeskripsiApp2 extends State<DeskripsiApp1> {
  DeskripsiApp2(this.data);
  String data;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UtamaApp()));
          return Future.value(true);
        },
        child: Scaffold(
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
                                MaterialPageRoute(builder: (_) => UtamaApp()));
                          },
                          icon: Icon(Icons.arrow_back),
                        ))),
                title: Container(
                    padding: EdgeInsets.only(left: 45),
                    height: 75,
                    child: Image.asset("assets/medcurebanner.png"))),
            body: SingleChildScrollView(
                child: Column(children: [
              Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('barang')
                          .where('nama', isEqualTo: data)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(children: [
                                Container(
                                    height: 400,
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Image.network(
                                      snapshot.data!.docs[index].get('gambar'),
                                    )),
                                SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('nama'),
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Nama : " +
                                      snapshot.data!.docs[index].get('nama')),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Deskripsi : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('deskripsi'),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Komposisi : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('komposisi'),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Manfaat : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('manfaat'),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Dosis : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('dosis'),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Efek Samping : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index]
                                        .get('efeksamping'),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Penyajian : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('penyajian'),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Perhatian : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('perhatian'),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Pabrik : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.docs[index].get('pabrik'),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ]);
                            });
                      }))
            ]))));
  }
}
