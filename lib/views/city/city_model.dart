import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String ilAdi;
  List<Ilceler> ilceler;

  Welcome({
    required this.ilAdi,
    required this.ilceler,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        ilAdi: json["il_adi"],
        ilceler:
            List<Ilceler>.from(json["ilceler"].map((x) => Ilceler.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "il_adi": ilAdi,
        "ilceler": List<dynamic>.from(ilceler.map((x) => x.toJson())),
      };
}

class Ilceler {
  String ilceAdi;

  Ilceler({
    required this.ilceAdi,
  });

  factory Ilceler.fromJson(Map<String, dynamic> json) => Ilceler(
        ilceAdi: json["ilce_adi"],
      );

  Map<String, dynamic> toJson() => {
        "ilce_adi": ilceAdi,
      };
}
