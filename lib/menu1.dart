import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class MenuApp1 extends StatelessWidget {
  const MenuApp1({Key? key}) : super(key: key);

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
        home: TampilanApp1(
          title: '',
        ));
  }
}

class TampilanApp1 extends StatefulWidget {
  const TampilanApp1({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TampilanApp1> createState() => TampilanApp2();
}

class TampilanApp2 extends State<TampilanApp1> {
  TextEditingController daftarusernameController = TextEditingController();
  TextEditingController daftarpasswordController = TextEditingController();

  final CollectionReference _akun =
      FirebaseFirestore.instance.collection('akun');

  String Value = "Username belum ada";

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Maaf"),
      content: Text("Username sudah ada."),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog1(BuildContext context) {
    AlertDialog alert = AlertDialog(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[300],
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              padding: EdgeInsets.only(
                top: 50,
              ),
              child: Image.asset(
                'assets/medcurelogo.png',
                height: 200,
                width: 200,
              )),
          Container(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40),
            child: Text("Username"),
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              onChanged: (value) async {
                String uname = daftarusernameController.text;
                String pword = daftarpasswordController.text;
                final QuerySnapshot result = await FirebaseFirestore.instance
                    .collection('akun')
                    .where('username', isEqualTo: uname)
                    .get();
                if (result.docs.length > 0) {
                  value = ("Username sudah ada");
                  setState(() {
                    Value = value;
                  });
                } else {
                  value = ("Username belum ada");
                  setState(() {
                    Value = value;
                  });
                }
              },
              controller: daftarusernameController,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Text('$Value'),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Text("Password"),
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: TextField(controller: daftarpasswordController),
          ),
          Container(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: TextButton(
                  onPressed: () async {
                    if (Value == "Username sudah ada") {
                      showAlertDialog(context);
                    } else if (daftarusernameController.text == "" &&
                        daftarpasswordController.text == "") {
                      showAlertDialog1(context);
                    } else {
                      String id =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      String uname = daftarusernameController.text;
                      String pword = daftarpasswordController.text;
                      await _akun.add(
                          {"id": id, "username": uname, "password": pword});
                    }
                  },
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xFF2E7D32)),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ))),
          Container(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuApp()),
                    );
                  },
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xFF1B5E20)),
                  child: Text(
                    "Login ?",
                    style: TextStyle(color: Colors.white),
                  ))),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Text("Sign Up Page"),
          )
        ])));
  }
}
