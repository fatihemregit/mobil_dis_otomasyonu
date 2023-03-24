import 'package:abi_project/HastaEkle.dart';
import 'package:abi_project/MainSayfa.dart';
import 'package:abi_project/TumHastalar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dentalist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  var sayfalar = [HastaEkle(),MainSayfa(),TumHastalar()];

  int sayfaIndeks = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfalar[sayfaIndeks],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one),
            label: "Hasta Ekle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "AnaSayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: "Tüm Hastalar",
          ),
        ],
        currentIndex: sayfaIndeks,
        onTap: (indeks){
          setState(() {
            sayfaIndeks = indeks;
          });
        },
      ),
    );
  }
}
