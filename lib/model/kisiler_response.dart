import 'kisi.dart';

class KisilerResponse {
  List<Kisi> kisiler;
  int success;

  KisilerResponse(this.kisiler, this.success);

  factory KisilerResponse.fromJson(Map<String, dynamic> json) {

    List<dynamic> jsonArray = json['kisiler'];
    List<Kisi> kisiler = jsonArray.map((item) => Kisi.fromJson(item)).toList();
    int success = json['success'] as int;

    return KisilerResponse(kisiler, success);
  }
}
