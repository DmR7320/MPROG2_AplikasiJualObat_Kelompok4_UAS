import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medcurekelompok4uas/menu.dart';
import 'package:medcurekelompok4uas/utama.dart';

class MenuTips extends StatelessWidget {
  const MenuTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const MenuTips1());
  }
}

class MenuTips1 extends StatelessWidget {
  const MenuTips1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        )),
        home: const MenuTips2(
          title: '',
        ));
  }
}

class MenuTips2 extends StatefulWidget {
  const MenuTips2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MenuTips2> createState() => MenuTips3();
}

class MenuTips3 extends State<MenuTips2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MenuApp()));
          return Future.value(true);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  title: Text(
                    "Bagaimana cara menambahkan data obat?",
                    style: TextStyle(color: Colors.green[900]),
                  ),
                  children: const <Widget>[
                    ListTile(
                      title: Text(
                          "Di menu 'Barang' klik tombol ➕, lalu akan muncul menu yang bisa diisi."),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  title: Text(
                    "Apa fungsi aplikasi ini?",
                    style: TextStyle(color: Colors.green[900]),
                  ),
                  children: const <Widget>[
                    ListTile(
                      title: Text(
                          "Membuat database list obat yang bisa diubah sesuai keinginan"),
                    )
                  ],
                ),
              ],
            ),
          ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MenuApp()));
                        },
                        icon: const Icon(Icons.arrow_back),
                      ))),
              title: Container(
                  padding: const EdgeInsets.only(left: 45),
                  height: 75,
                  child: Image.asset("assets/medcurebanner.png"))),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const UtamaApp()));
            },
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            selectedFontSize: 15,
            currentIndex: 1,
            iconSize: 30,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services),
                label: 'Barang',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'FAQ')
            ],
            showSelectedLabels: true,
            showUnselectedLabels: false,
          ),
        ));
  }
}
