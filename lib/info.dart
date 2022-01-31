import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/utama.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: const Color(0xFFFFFFFF),
        )),
        home: InfoApp1());
  }
}

class InfoApp1 extends StatelessWidget {
  const InfoApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: const Color(0xFFFFFFFF),
        )),
        home: InfoApp2(
          title: '',
        ));
  }
}

class InfoApp2 extends StatefulWidget {
  const InfoApp2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<InfoApp2> createState() => InfoApp3();
}

class InfoApp3 extends State<InfoApp2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UtamaApp()));
          return Future.value(true);
        },
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
          child: Column(children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 40, left: 20),
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
            Container(
              child: Image.asset("assets/medcurelogo.png"),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Deskjob",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Dwiki Maula Rahman",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Code, Database",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Helena Meilina",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Code, Layout",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Mila Meliana Pitri",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Code, Layout",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Muhammad Dika Fadhlan",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Code, Design",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Rahma Salsa Bilah",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "Code, Design",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ]),
        ))));
  }
}
