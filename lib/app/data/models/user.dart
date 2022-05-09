// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.foto,
    this.phone,
    this.email,
    this.roleId,
    this.cabangId,
    this.isActive,
  });

  int? id;
  String? name;
  String? foto;
  String? phone;
  String? email;
  int? roleId;
  int? cabangId;
  int? isActive;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        foto: json["foto"],
        phone: json["phone"],
        email: json["email"],
        roleId: json["role_id"],
        cabangId: json["cabang_id"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "foto": foto,
        "phone": phone,
        "email": email,
        "role_id": roleId,
        "cabang_id": cabangId,
        "is_active": isActive,
      };
}
