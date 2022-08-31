import 'package:abi_project/Hasta.dart';
import 'package:abi_project/VeritabaniYardimcisi.dart';
import 'package:abi_project/Yislem.dart';

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
    await db.delete("Yislem",where: "hasta_id = ?",whereArgs: [hasta_id]);//bu kısım hastaya işlem ekleme sistemi çalıştığında açılacak
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
  Future<void> islemKayit(int hasta_id ,String yapilanIslem) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();

    bilgiler["hasta_id"] = hasta_id;

    bilgiler["yapilan_islem"] = yapilanIslem;

    await db.insert("yislem",bilgiler);
  }
  Future<List<Yislem>> hastaIslemleriniGetir(int hasta_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM yislem WHERE hasta_id=$hasta_id");

    return List.generate(maps.length, (i){
      var satir = maps[i];

      //return Hasta(satir["hasta_id"],satir["tam_ad"],satir["tc"],satir["hasta_no"],satir["islem_tur"]);
      return Yislem(satir["islem_id"],satir["hasta_id"],satir["yapilan_islem"]);
    });

  }
  Future<void> islemSil(String yapilan_islem) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    // İşlemler VeriTabanından hasta ile alakalı işlemleri silme
    //await db.delete("yislem",where: "islem_id = ?",whereArgs: [islem_id]);
    await db.delete("yislem",where: "yapilan_islem = ?",whereArgs: [yapilan_islem]);
  }
  Future<int> islemidOgren(String islem_ismi) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM yislem WHERE yapilan_islem='$islem_ismi' ");
    var satir = maps[0];
    return int.parse(satir["islem_id"]);
  }
  Future<List<Hasta>> tumHastalarislemn(int islem_tur) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM Hastalar WHERE islem_tur = $islem_tur");

    return List.generate(maps.length, (i){
      var satir = maps[i];

      return Hasta(satir["hasta_id"],satir["tam_ad"],satir["tc"],satir["hasta_no"],satir["islem_tur"]);

    });
  }

}