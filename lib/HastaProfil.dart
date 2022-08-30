import 'package:abi_project/Hasta.dart';
import 'package:abi_project/HastaDao.dart';
import 'package:flutter/material.dart';
import 'package:abi_project/Yislem.dart';


/*
appbar a pop up menü ekle 2 tane seçenek olsun bunlar bilgileri düzenle ve yapılan işlemleri görüntüle olsun
buradan gerekli menüye yönlendir
 */


//hasta profil menüsü
class HastaProfil extends StatefulWidget {
  late Hasta gelenHasta;


  HastaProfil(this.gelenHasta);

  @override
  State<HastaProfil> createState() => _HastaProfilState();
}

class _HastaProfilState extends State<HastaProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("${widget.gelenHasta.tam_ad} Adlı Hastanın Profil Menüsü"),),
        actions: [
          PopupMenuButton(
            child: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Düzenle"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("İşlemleri Görüntüle"),
              ),
            ],
            onSelected: (menuItemValue){
              if(menuItemValue == 1){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HastaProfilDuzenle(widget.gelenHasta)));
              }
              if(menuItemValue == 2){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HastaProfilIslemleriGoruntule(widget.gelenHasta)));
              }
            },
          ),
        ],
      ),
      body: Center(child: Text(" Yukarıdan yapılacak işlemi seç"),),
    );
  }
}
//hasta profil düzenleme menüsü
class HastaProfilDuzenle extends StatefulWidget {

  late Hasta gelenHasta;


  HastaProfilDuzenle(this.gelenHasta);

  @override
  State<HastaProfilDuzenle> createState() => _HastaProfilDuzenleState();
}

class _HastaProfilDuzenleState extends State<HastaProfilDuzenle> {
  //tf controller tanımlaması
  var tfIsim = TextEditingController();
  var tfTc = TextEditingController();
  var tfHastaNumarasi = TextEditingController();

  //veritabanından gelen verileri texfieldleri girme
  void getir(){
    tfIsim.text = "${widget.gelenHasta.tam_ad}";
    tfTc.text = "${widget.gelenHasta.tc}";
    tfHastaNumarasi.text = "${widget.gelenHasta.hasta_no}";
  }
  @override
  void initState() {
    super.initState();
    getir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("${widget.gelenHasta.tam_ad} Adlı Hastanın profilini düzenliyorsunuz"),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Hasta isim Textfield
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tfIsim,
                decoration: InputDecoration(
                  label: Text("Hasta İsim Soyisim"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
            //Hasta Tc textfield
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tfTc,
                decoration: InputDecoration(
                  label: Text("Hasta Tc"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
            //Hasta No textfield
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tfHastaNumarasi,
                decoration: InputDecoration(
                  label: Text("Hasta No"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text("Hastayı Güncelle"),
              onPressed: (){
                HastaDao().hastaGuncelle(widget.gelenHasta.hasta_id, tfIsim.text, tfTc.text, int.parse(tfHastaNumarasi.text),widget.gelenHasta.islem_tur);
              },
            ),
          ],
        ),
      ),
    );
  }
}

//hastaya yapılan işlemleri görüntüleme menüsü
class HastaProfilIslemleriGoruntule extends StatefulWidget {
  late Hasta gelenHasta;

  HastaProfilIslemleriGoruntule(this.gelenHasta);

  @override
  State<HastaProfilIslemleriGoruntule> createState() => _HastaProfilIslemleriGoruntuleState();
}

class _HastaProfilIslemleriGoruntuleState extends State<HastaProfilIslemleriGoruntule> {

  var tfAlert = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("${widget.gelenHasta.tam_ad}Adlı Hastaya Yapılan İşlemler"),),
        actions: [
          TextButton(
            child: Text("Ekle",style: TextStyle(color: Colors.black),),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("${widget.gelenHasta.tam_ad} Adlı Hastaya işlem ekleniyor"),
                    content: SizedBox(
                      height: 80,
                      child: TextField(
                        controller: tfAlert,
                        decoration: InputDecoration(
                          hintText: "yapılan işlemi yazınız",
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("İptal"),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),//iptal Butonu
                      TextButton(
                        child: Text("Kaydet"),
                        onPressed: (){
                          HastaDao().islemKayit(widget.gelenHasta.hasta_id, tfAlert.text);
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),//kayıt Butonu
                    ],
                  );
                }
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Yislem>>(
        future: HastaDao().hastaIslemleriniGetir(widget.gelenHasta.hasta_id),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var gelenveri = snapshot.data;
            return ListView.builder(
              itemCount: gelenveri!.length,
              itemBuilder: (context,indeks){
                return Card(
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Text(gelenveri[indeks].yapilan_islem),
                        Spacer(),
                        ElevatedButton(
                          child: Text("SİL"),
                          onPressed: () async {

                            HastaDao().islemSil(indeks + 1);
                            setState(() {
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );



          }else{
            return Center(child: Text("Veritabanında Hastaya Yapılmış Işlem Bulunamadı"),);
          }
        },
      ),
    );
  }
}
