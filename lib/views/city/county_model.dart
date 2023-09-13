import 'dart:convert';

class Il {
  String ilAdi;
  List<String> ilceler;

  Il({
    required this.ilAdi,
    required this.ilceler,
  });

  factory Il.fromJson(Map<String, dynamic> json) {
    return Il(
      ilAdi: json["il_adi"],
      ilceler: List<String>.from(json["ilceler"].map((x) => x)),
    );
  }
}

class Ilce {
  String ilceAdi;

  Ilce({
    required this.ilceAdi,
  });

  factory Ilce.fromJson(Map<String, dynamic> json) {
    return Ilce(
      ilceAdi: json["ilce_adi"],
    );
  }
}

void main() {
  // JSON verisi
  String jsonVeri = '''
  {
    "il_adi": "Ankara",
    "ilceler": ["Çankaya", "Keçiören", "Yenimahalle"]
  }
  ''';

  // JSON verisini Il nesnesine dönüştürme
  Il il = Il.fromJson(json.decode(jsonVeri));

  // Il nesnesini kullanma
  print("Seçilen İl: ${il.ilAdi}");
  print("İlçeler:");
  il.ilceler.forEach((ilce) {
    print(ilce);
  });
}
