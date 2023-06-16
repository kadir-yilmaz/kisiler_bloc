class Kisi {
  String kisi_id;
  String kisi_ad;
  String kisi_tel;

  Kisi({required this.kisi_id, required this.kisi_ad, required this.kisi_tel});

  factory Kisi.fromJson(Map<String, dynamic> json) {
    return Kisi(
      kisi_id: json["kisi_id"] as String,
      kisi_ad: json["kisi_ad"] as String,
      kisi_tel: json["kisi_tel"] as String,
    );
  }
}
