import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/utama.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UbahUpdateApp extends StatelessWidget {
  const UbahUpdateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const UbahUpdateApp1());
  }
}

class UbahUpdateApp1 extends StatelessWidget {
  const UbahUpdateApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const UbahUpdateApp2(
          ubahbarang: '',
        ));
  }
}

class UbahUpdateApp2 extends StatefulWidget {
  const UbahUpdateApp2({Key? key, required this.ubahbarang}) : super(key: key);
  final String ubahbarang;

  @override
  // ignore: no_logic_in_create_state
  State<UbahUpdateApp2> createState() => UbahUpdateApp3(ubahbarang);
}

class UbahUpdateApp3 extends State<UbahUpdateApp2> {
  UbahUpdateApp3(this.data);
  String data;
  TextEditingController namaController = TextEditingController();
  TextEditingController komposisiController = TextEditingController();
  TextEditingController manfaatController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController pabrikController = TextEditingController();
  TextEditingController efeksampingController = TextEditingController();
  TextEditingController dosisController = TextEditingController();
  TextEditingController perhatianController = TextEditingController();
  TextEditingController penyajianController = TextEditingController();
  String imgFileasset = ("assets/logogaleri.png");
  File? imgFile;
  // ignore: prefer_typing_uninitialized_variables
  var lokal;
  // ignore: prefer_typing_uninitialized_variables
  var link;
  String template =
      ("https://firebasestorage.googleapis.com/v0/b/medcurekelompok4uas.appspot.com/o/logogaleri.png?alt=media&token=e2905a8b-41ad-461d-9ad2-35fd8d49fb8f");

  // ignore: non_constant_identifier_names
  String Value = "Nama belum ada";

  showAlertDialog1(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      title: Text("Maaf"),
      content: Text("Semua harus diisi."),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog2(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      title: Text("Maaf"),
      content: Text("Nama sudah ada."),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (link == null) {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const UtamaApp()));
          } else {
            FirebaseStorage.instance.refFromURL(link).delete();
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const UtamaApp()));
          }
          return Future.value(true);
        },
        child: Scaffold(
            backgroundColor: Colors.green,
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            padding: const EdgeInsets.all(5),
                            color: Colors.green,
                            onPressed: () {
                              if (link == null) {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const UtamaApp()));
                              } else {
                                FirebaseStorage.instance
                                    .refFromURL(link)
                                    .delete();
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const UtamaApp()));
                              }
                            },
                            icon: const Icon(Icons.arrow_back),
                          ))),
                  StreamBuilder<QuerySnapshot>(
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
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: const Text("Foto / Gambar",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                    color: Colors.green[300],
                                    height: 200,
                                    width: 200,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                      left: 40,
                                      right: 40,
                                      top: 20,
                                    ),
                                    child: GestureDetector(
                                      // ignore: avoid_unnecessary_containers
                                      child: Container(
                                          child: Image.network(
                                        template = snapshot.data!.docs[index]
                                            .get('gambar'),
                                      )),
                                      onTap: () async {
                                        XFile? imgPicker =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        setState(() {
                                          if (imgPicker != null) {
                                            imgFile = File(imgPicker.path);
                                            lokal = imgPicker.path;
                                          }
                                        });
                                        if (imgPicker != null) {
                                          FirebaseStorage storage =
                                              FirebaseStorage.instance;
                                          Reference ref = storage.ref().child(
                                              "image1" +
                                                  DateTime.now().toString());
                                          UploadTask uploadTask =
                                              ref.putFile(imgFile!);
                                          var imageUrl =
                                              await (await uploadTask)
                                                  .ref
                                                  .getDownloadURL();
                                          setState(() {
                                            link = imageUrl.toString();
                                            template = link;
                                          });
                                        }
                                      },
                                    )),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text("Nama Obat",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    onChanged: (value) async {
                                      String namaobat = namaController.text;
                                      final QuerySnapshot result =
                                          await FirebaseFirestore.instance
                                              .collection('barang')
                                              .where('nama',
                                                  isEqualTo: namaobat)
                                              .get();
                                      if (result.docs.isNotEmpty) {
                                        value = ("Nama sudah ada");
                                        setState(() {
                                          Value = value;
                                        });
                                      } else {
                                        value = ("Nama belum ada");
                                        setState(() {
                                          Value = value;
                                        });
                                      }
                                    },
                                    controller: namaController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('nama')),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text("Deskripsi",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    controller: deskripsiController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('deskripsi')),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: const Text("Komposisi",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    controller: komposisiController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('komposisi')),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: const Text("Manfaat",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    controller: manfaatController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('manfaat')),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: const Text("Dosis",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    controller: dosisController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('dosis')),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: const Text("Efek Samping",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    controller: efeksampingController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('efeksamping')),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: const Text("Penyajian",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    controller: penyajianController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('penyajian')),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: const Text("Perhatian",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    controller: perhatianController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('perhatian')),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: const Text("Pabrik",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: TextField(
                                    controller: pabrikController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.docs[index]
                                            .get('pabrik')),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        top: 40, bottom: 40),
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        String nama = namaController.text;
                                        String deskripsi =
                                            deskripsiController.text;
                                        String komposisi =
                                            komposisiController.text;
                                        String manfaat = manfaatController.text;
                                        String dosis = dosisController.text;
                                        String efeksamping =
                                            efeksampingController.text;
                                        String penyajian =
                                            penyajianController.text;
                                        String perhatian =
                                            perhatianController.text;
                                        String pabrik = pabrikController.text;

                                        if (namaController.text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (deskripsiController
                                            .text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (komposisiController
                                            .text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (manfaatController
                                            .text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (dosisController
                                            .text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (efeksampingController
                                            .text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (penyajianController
                                            .text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (perhatianController
                                            .text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (pabrikController
                                            .text.isEmpty) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (link == null) {
                                          showAlertDialog1(context);
                                          return;
                                        } else if (Value == "Nama sudah ada") {
                                          showAlertDialog2(context);
                                        } else {
                                          await FirebaseFirestore.instance
                                              .collection("barang")
                                              .doc(snapshot.data!.docs[index]
                                                  .get('id'))
                                              .update({
                                            "nama": nama,
                                            "deskripsi": deskripsi,
                                            "komposisi": komposisi,
                                            "manfaat": manfaat,
                                            "dosis": dosis,
                                            "efeksamping": efeksamping,
                                            "penyajian": penyajian,
                                            "perhatian": perhatian,
                                            "pabrik": pabrik,
                                            "gambar": link
                                          });
                                        }
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const UtamaApp()));
                                      },
                                      child: const Icon(Icons.add),
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.green,
                                    ))
                              ]);
                            });
                      })
                ]))));
  }
}
