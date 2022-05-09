// import 'package:equatable/equatable.dart';

import 'dart:convert';

import 'cabang-product.dart';

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  String? id;
  CabangProduct? cabangProduct;
  int qty = 1;

  Cart({this.id = "", this.cabangProduct, this.qty = 1});

  Cart copyWith({
    String? id,
    required CabangProduct cabangProduct,
    int? qty,
  }) =>
      Cart(
          id: id ?? this.id,
          cabangProduct: cabangProduct,
          qty: qty ?? this.qty);

  // @override
  // List<Object> get props => [id, qty, product];

  void toggleDone() {
    qty++;
  }

  void decreaseDown() {
    qty--;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cabang-product": CabangProduct,
        "qty": qty,
      };
}
