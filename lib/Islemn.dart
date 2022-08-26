import 'package:flutter/material.dart';

class Islemn extends StatefulWidget {

  late int Islemid;


  Islemn({ required this.Islemid});

  @override
  State<Islemn> createState() => _IslemnState();
}

class _IslemnState extends State<Islemn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İşlem ${widget.Islemid}"),
      ),
      body: Center(child: Text("İşlem ${widget.Islemid} Sayfasındasın."),),
    );
  }
}
