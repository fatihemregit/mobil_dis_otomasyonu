import 'package:abi_project/Islemn.dart';
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
        title: Text("Hoşgeldin"),
      ),
      body: Center(child: Text("Lütfen Aşağıdan İşleminizi Seçin",style: TextStyle(fontSize: 30),),),
      //Center(child: Text("Lütfen Aşağıdan İşleminizi Seçin",style: TextStyle(fontSize: 30),),),
      drawer: Drawer(
        child: Container(
          color: Color(0xff51d5d5),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  child: Text("İşlem Seçiniz"),
              ),
              ListTile(
                title: Text("İşlem 1"),
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Islemn(Islemid: 1)));
                  });
                },
              ),
              ListTile(
                title: Text("İşlem 2"),
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Islemn(Islemid: 2)));
                  });
                },
              ),
              ListTile(
                title: Text("İşlem 3"),
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Islemn(Islemid: 3)));
                  });
                },
              ),
              ListTile(
                title: Text("İşlem 4"),
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Islemn(Islemid: 4)));
                  });
                },
              ),
              ListTile(
                title: Text("İşlem 5"),
                onTap: (){
                  setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Islemn(Islemid: 5)));
                  });
                },
              ),
              ListTile(
                title: Text("İşlem 6"),
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Islemn(Islemid: 6)));
                  });
                },
              ),
              ListTile(
                title: Text("İşlem 7"),
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Islemn(Islemid: 7)));
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
