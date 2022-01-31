import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/menu1.dart';
import 'package:medcurekelompok4uas/utama.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class MenuApp extends StatelessWidget {
  const MenuApp({Key? key}) : super(key: key);

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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Maaf"),
      content: Text("Username / Password anda tidak cocok atau salah."),
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
            padding: EdgeInsets.only(left: 40, right: 40, top: 10),
            child: TextField(
              controller: daftarusernameController,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Text("Password"),
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40, top: 10),
            child: TextField(
              controller: daftarpasswordController,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 40, right: 40, top: 40),
              child: TextButton(
                  onPressed: () async {
                    String uname = daftarusernameController.text;
                    String pword = daftarpasswordController.text;
                    final QuerySnapshot result = await FirebaseFirestore
                        .instance
                        .collection('akun')
                        .where('username', isEqualTo: uname)
                        .where('password', isEqualTo: pword)
                        .get();
                    var list = result.docs;
                    print(list);
                    if (result.docs.length > 0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UtamaApp()));
                    } else {
                      showAlertDialog(context);
                    }
                  },
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xFF2E7D32)),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ))),
          Container(
              padding: EdgeInsets.only(left: 40, right: 40, top: 40),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuApp1()),
                    );
                  },
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xFF1B5E20)),
                  child: Text(
                    "Sign Up ?",
                    style: TextStyle(color: Colors.white),
                  ))),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Text("Login Page"),
          )
        ])));
  }
}
