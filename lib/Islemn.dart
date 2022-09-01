import 'package:abi_project/Hasta.dart';
import 'package:abi_project/HastaDao.dart';
import 'package:flutter/material.dart';

import 'HastaProfil.dart';

class Islemn extends StatefulWidget {

  late int Islemid;


  Islemn({ required this.Islemid});

  @override
  State<Islemn> createState() => _IslemnState();
}
//Text("İşlem ${widget.Islemid}")
class _IslemnState extends State<Islemn> {

  bool aramadurumu = false ;


  String aranilacakMetin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramadurumu ?
        TextField(
          decoration: InputDecoration(hintText: "Aramak için birşey yazın"),
          onChanged: (sonuc){
            setState(() {
              aranilacakMetin = sonuc;
            });
          },
        )
            :Text("İşlem ${widget.Islemid}"),
        actions: [
          aramadurumu ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: (){
              setState(() {
                aramadurumu = false;
              });
            },
          ):IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                aramadurumu = true;
              });
            },
          )
          ,

        ],
      ),
      body: FutureBuilder<List<Hasta>>(
        future: aramadurumu ?  HastaDao().tumHastalarislemnarama(widget.Islemid, aranilacakMetin):HastaDao().tumHastalarislemn(widget.Islemid),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var gelenVeri = snapshot.data;
            return ListView.builder(
              itemCount: gelenVeri!.length,
              itemBuilder: (context,indeks){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HastaProfil(gelenVeri[indeks])));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Text(gelenVeri[indeks].tam_ad),
                          Spacer(),
                          ElevatedButton(
                            child: Text("SİL"),
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text("Hastayı Siliyorsun!"),
                                      content: Text(" ${gelenVeri[indeks].tc} tc li ${gelenVeri[indeks].tam_ad} adlı  ${gelenVeri[indeks].hasta_no} no lu hastayı siliyorsun! Emin misin?"),
                                      actions: [
                                        TextButton(
                                          child: Text("Evet"),
                                          onPressed: (){
                                            HastaDao().hastaSil(gelenVeri[indeks].hasta_id);
                                            setState(() {
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),//evet Butonu
                                        TextButton(
                                          child: Text("Hayır"),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center(child: Text("Bu işleme Kaydedilmiş Hasta Bulunamadı"),);
          }
        },
      ),
    );
  }
}
