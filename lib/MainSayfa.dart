import 'package:flutter/material.dart';

class MainSayfa extends StatefulWidget {
  const MainSayfa({Key? key}) : super(key: key);

  @override
  State<MainSayfa> createState() => _MainSayfaState();
}

class _MainSayfaState extends State<MainSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Hoşgeldin"),),
      ),
      body: Center(child: Text("Lütfen Aşağıdan İşleminizi Seçin",style: TextStyle(fontSize: 30),),),
    );
  }
}
