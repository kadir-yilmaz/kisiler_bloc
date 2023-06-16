import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kisiler_bloc/model/kisiler_response.dart';

import '../model/kisi.dart';

class KisilerDaoRepository {

  List<Kisi> parseKisilerCevap(String cevap) {
    return KisilerResponse.fromJson(json.decode(cevap)).kisiler;
  }

  Future<void> kisiKayit(String kisi_ad, String kisi_tel) async {
    var url = "https://kadiryilmazhatay.000webhostapp.com/kisilerWebService/insert_kisiler.php";
    var veri = {"kisi_ad":kisi_ad, "kisi_tel":kisi_tel};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Kaydetme işlemi: ${cevap.data.toString()}");
  }

  Future<void> kisiGuncelle(int kisi_id, String kisi_ad, String kisi_tel) async {
    var url = "https://kadiryilmazhatay.000webhostapp.com/kisilerWebService/update_kisiler.php";
    var veri = {"kisi_id":kisi_id, "kisi_ad":kisi_ad, "kisi_tel":kisi_tel};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Güncelleme işlemi: ${cevap.data.toString()}");
  }

  Future<List<Kisi>> tumKisileriAl() async {

    var url = "https://kadiryilmazhatay.000webhostapp.com/kisilerWebService/tum_kisiler.php";
    var cevap = await Dio().get(url);
    return parseKisilerCevap(cevap.data.toString());
  }

  Future<List<Kisi>> kisiAra(String aramaKelimesi) async {

    var url = "https://kadiryilmazhatay.000webhostapp.com/kisilerWebService/kisi_ara.php";
    var veri = {"kisi_ad":aramaKelimesi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseKisilerCevap(cevap.data.toString());

  }

  Future<void> kisiSil(int kisi_id) async {
    var url = "https://kadiryilmazhatay.000webhostapp.com/kisilerWebService/delete_kisiler.php";
    var veri = {"kisi_id":kisi_id};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Silme işlemi: ${cevap.data.toString()}");
  }
}