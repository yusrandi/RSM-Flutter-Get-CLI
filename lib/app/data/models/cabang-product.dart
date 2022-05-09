import 'dart:convert';

CabangProduct cabangProductFromJson(String str) =>
    CabangProduct.fromJson(json.decode(str));

String cabangProductToJson(CabangProduct data) => json.encode(data.toJson());

class CabangProduct {
  CabangProduct({
    this.id,
    this.tanggal,
    this.harga,
    this.qty,
    this.cabangId,
    this.productId,
    this.userId,
    this.cabang,
    this.product,
  });

  int? id;
  String? tanggal;
  String? harga;
  String? qty;
  int? cabangId;
  int? productId;
  int? userId;
  Cabang? cabang;
  Product? product;

  factory CabangProduct.fromJson(Map<String, dynamic> json) => CabangProduct(
        id: json["id"],
        tanggal: json["tanggal"],
        harga: json["harga"],
        qty: json["qty"],
        cabangId: json["cabang_id"],
        productId: json["product_id"],
        userId: json["user_id"],
        cabang: Cabang.fromJson(json["cabang"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "harga": harga,
        "qty": qty,
        "cabang_id": cabangId,
        "product_id": productId,
        "user_id": userId,
        "cabang": cabang?.toJson(),
        "product": product?.toJson(),
      };
}

class Cabang {
  Cabang({
    this.id,
    this.cabangName,
    this.cabangPhone,
    this.cabangAddress,
  });

  int? id;
  String? cabangName;
  String? cabangPhone;
  String? cabangAddress;

  factory Cabang.fromJson(Map<String, dynamic> json) => Cabang(
        id: json["id"],
        cabangName: json["cabang_name"],
        cabangPhone: json["cabang_phone"],
        cabangAddress: json["cabang_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cabang_name": cabangName,
        "cabang_phone": cabangPhone,
        "cabang_address": cabangAddress,
      };
}

class Product {
  Product({
    this.id,
    this.kategoriId,
    this.unitId,
    this.userId,
    this.productBarcode,
    this.productName,
    this.productMerk,
    this.productMaterial,
    this.productCost,
    this.productPrice,
    this.productQty,
    this.productNote,
    this.productImage,
    this.unit,
  });

  int? id;
  int? kategoriId;
  int? unitId;
  int? userId;
  String? productBarcode;
  String? productName;
  String? productMerk;
  String? productMaterial;
  String? productCost;
  String? productPrice;
  String? productQty;
  String? productNote;
  String? productImage;
  Unit? unit;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        kategoriId: json["kategori_id"],
        unitId: json["unit_id"],
        userId: json["user_id"],
        productBarcode: json["product_barcode"],
        productName: json["product_name"],
        productMerk: json["product_merk"],
        productMaterial: json["product_material"],
        productCost: json["product_cost"],
        productPrice: json["product_price"],
        productQty: json["product_qty"],
        productNote: json["product_note"],
        productImage: json["product_image"],
        unit: Unit.fromJson(json["unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kategori_id": kategoriId,
        "unit_id": unitId,
        "user_id": userId,
        "product_barcode": productBarcode,
        "product_name": productName,
        "product_merk": productMerk,
        "product_material": productMaterial,
        "product_cost": productCost,
        "product_price": productPrice,
        "product_qty": productQty,
        "product_note": productNote,
        "product_image": productImage,
        "unit": unit?.toJson(),
      };
}

class Unit {
  Unit({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
