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
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const InfoApp1());
  }
}

class InfoApp1 extends StatelessWidget {
  const InfoApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const InfoApp2(
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
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UtamaApp()));
          return Future.value(true);
        },
        child: Scaffold(
            body: SingleChildScrollView(
                // ignore: avoid_unnecessary_containers
                child: Container(
          child: Column(children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 40, left: 20),
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
                                builder: (_) => const UtamaApp()));
                      },
                      icon: const Icon(Icons.arrow_back),
                    ))),
            // ignore: avoid_unnecessary_containers
            Container(
              child: Image.asset(
                "assets/medcurelogo.png",
                width: 200,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Deskjob",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Dwiki Maula Rahman",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Code, Database",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Helena Meilina",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Code, Layout",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Mila Meliana Pitri",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Code, Layout",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Muhammad Dika Fadhlan",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Code, Design",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Rahma Salsa Bilah",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: const Text(
                "Code, Design",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ]),
        ))));
  }
}
