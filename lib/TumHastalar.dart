import 'package:flutter/material.dart';


class TumHastalar extends StatefulWidget {
  const TumHastalar({Key? key}) : super(key: key);

  @override
  State<TumHastalar> createState() => _TumHastalarState();
}

class _TumHastalarState extends State<TumHastalar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Tüm Hastaları Görüntüleme Menüsü"),),
      ),
      body: Center(child: Text("Tüm Hastaları Görüntüleme Sayfası"),),
    );
  }
}
