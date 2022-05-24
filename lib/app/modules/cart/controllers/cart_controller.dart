import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../../cores/core_colors.dart';
import '../../../data/config/api.dart';
import '../../../data/models/cabang-product.dart';
import '../../../data/models/cart.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  final cart = Cart().obs;

  var cartItems = <Cart>[].obs;
  int get count => cartItems.length;
  var count2 = 0.0;
  var qtys = "";
  double get totalPrice => cartItems.fold(
      0, (sum, item) => sum + int.parse(item.cabangProduct!.harga!) * item.qty);

  void addToCart(CabangProduct cabangProduct) {
    try {
      if (isAlredyAdded(cabangProduct)) {
        Get.snackbar("cek your cart",
            "${cabangProduct.product!.productName!} is alredy added",
            backgroundColor: CoreColor.whiteSoft,
            duration: Duration(seconds: 1));
        print('udah di added');
      } else {
        var uuid = Uuid();
        String itemId = uuid.v4();
        cartItems.add(Cart(
          id: itemId,
          cabangProduct: cabangProduct,
          qty: 1,
        ));
        getTotalsMount();
        update();

        Get.snackbar(
            "cek your cart", "${cabangProduct.product!.productName!}  added",
            backgroundColor: CoreColor.whiteSoft,
            duration: Duration(seconds: 1));
      }
    } catch (e) {}
  }

  bool isAlredyAdded(CabangProduct cabangProduct) => cartItems
      .where((item) => item.cabangProduct!.id! == cabangProduct.id)
      .isNotEmpty;

  void decreasqty({
    required Cart cart,
  }) {
    if (cart.qty == 1) {
      removeCart(cart);

      Get.snackbar("berhasil", "item berhasil terhapus",
          backgroundColor: CoreColor.whiteSoft, duration: Duration(seconds: 1));
    } else {
      int index = cartItems.indexWhere((e) => e.id == cart.id);
      cartItems[index].qty = --cart.qty;
      getTotalsMount();
      update();
    }
  }

  void increasQty(Cart cart) {
    if (cart.qty >= 1) {
      cart.toggleDone();
      getTotalsMount();
      update();
    }
  }

  void removeCart(Cart cart) {
    cartItems.remove(cart);
    getTotalsMount();
    update();
  }

  void getTotalsMount() {
    double totalamount = cartItems.fold(0,
        (sum, item) => sum + int.parse(item.cabangProduct!.harga!) * item.qty);
    count2 = totalamount;

    String qtyss =
        cartItems.fold("", (sum, item) => sum + "," + item.qty.toString());
    qtys = qtyss;
  }

  Future<String> transaksiStore(String amount, String cabang_produk_ids,
      String qtys, String userId) async {
    var _response = await http.post(Uri.parse(Api().sale), body: {
      "user_id": userId,
      "amount": amount,
      "qtys": qtys,
      "cabang_produk_ids": cabang_produk_ids,
    });

    print(_response.body);

    Get.snackbar("berhasil", "Transaksi Berhasil",
        backgroundColor: CoreColor.whiteSoft, duration: Duration(seconds: 1));
    Get.offAndToNamed(Routes.HOME);

    cartItems.clear();
    return _response.body;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
