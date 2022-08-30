import 'package:abi_project/Hasta.dart';
import 'package:abi_project/VeritabaniYardimcisi.dart';

class HastaDao{
  //veritabanıyla alaklı tüm metotlar buraya yazılacak
  Future<List<Hasta>> tumHastalar() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM Hastalar");

    return List.generate(maps.length, (i){
      var satir = maps[i];

      return Hasta(satir["hasta_id"],satir["tam_ad"],satir["tc"],satir["hasta_no"],satir["islem_tur"]);

    });
  }//tumHastalar function
  Future<void> hastaKayit(String tam_ad,String tc,int hasta_no,int islem_tur) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();

    bilgiler["tam_ad"] = tam_ad;

    bilgiler["tc"] = tc;

    bilgiler["hasta_no"] = hasta_no;

    bilgiler["islem_tur"] = islem_tur;

    await db.insert("Hastalar",bilgiler);
  }//hastaKayit function
  Future<void> hastaSil(int hasta_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    //Hastalar VeriTabanından hastanın satırını silme
    await db.delete("Hastalar",where: "hasta_id = ?",whereArgs: [hasta_id]);
    //İşlemler VeriTabanından hasta ile alakalı işlemleri silme
    //await db.delete("Yislem",where: "hasta_id = ?",whereArgs: [hasta_id]);//bu kısım hastaya işlem ekleme sistemi çalıştığında açılacak
  }
  Future<Hasta> birHastaGetir(int hasta_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM Hastalar WHERE hasta_id=$hasta_id");
    var satir = maps[0];
    return Hasta(satir["hasta_id"],satir["tam_ad"],satir["tc"],satir["hasta_no"],satir["islem_tur"]);
  }
  Future<void> hastaGuncelle(int hasta_id,String tam_ad,String tc,int hasta_no,int islem_tur) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();

    bilgiler["tam_ad"] = tam_ad;

    bilgiler["tc"] = tc;

    bilgiler["hasta_no"] = hasta_no;

    bilgiler["islem_tur"] = islem_tur;

    await db.update("Hastalar",bilgiler,where: "hasta_id=?",whereArgs: [hasta_id]);
  }
}