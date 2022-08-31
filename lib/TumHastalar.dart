import 'package:abi_project/HastaDao.dart';
import 'package:abi_project/HastaProfil.dart';
import 'package:flutter/material.dart';
import 'package:abi_project/Hasta.dart';

class TumHastalar extends StatefulWidget {
  const TumHastalar({Key? key}) : super(key: key);

  @override
  State<TumHastalar> createState() => _TumHastalarState();
}

class _TumHastalarState extends State<TumHastalar> {

  bool aramadurumu = false ;


  String aranilacakMetin = "";


  @override
  void initState() {
    super.initState();
    setState(() {
    });
  }

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
            :Center(child: Text("Tüm Hastaları Görüntüleme Menüsü"),),
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
        future: aramadurumu ? HastaDao().tumHastalarArama(aranilacakMetin):HastaDao().tumHastalar(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var elemanlar = snapshot.data;
            return ListView.builder(
              itemCount: elemanlar!.length,
              itemBuilder: (context,indeks){
                // listviewdeki elementlerin tasarımı
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HastaProfil(elemanlar[indeks])));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Text(elemanlar[indeks].tam_ad),
                          Spacer(),
                          ElevatedButton(
                            child: Text("SİL"),
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Hastayı Siliyorsun!"),
                                    content: Text(" ${elemanlar[indeks].tc} tc li ${elemanlar[indeks].tam_ad} adlı  ${elemanlar[indeks].hasta_no} no lu hastayı siliyorsun! Emin misin?"),
                                    actions: [
                                      TextButton(
                                        child: Text("Evet"),
                                        onPressed: (){
                                          HastaDao().hastaSil(elemanlar[indeks].hasta_id);
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
            return Center(child: Text("Kayıtlı Hasta Yok"),);
          }
        },
      ),
    );
  }
}
