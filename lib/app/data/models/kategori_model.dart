import 'dart:convert';

KategoriModel kategoriModelFromJson(String str) =>
    KategoriModel.fromJson(json.decode(str));

String kategoriModelToJson(KategoriModel data) => json.encode(data.toJson());

class KategoriModel {
  KategoriModel({
    this.id,
    this.code,
    this.name,
  });

  int? id;
  String? code;
  String? name;

  factory KategoriModel.fromJson(Map<String, dynamic> json) => KategoriModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
      };
}
