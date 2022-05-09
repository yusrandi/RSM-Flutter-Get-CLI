// import 'package:equatable/equatable.dart';

import 'cabang-product.dart';

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
}
