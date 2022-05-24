import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/modules/menu/controllers/menu_controller.dart';

import '../../../data/models/cabang-product.dart';
import '../../../routes/app_pages.dart';
import '../../auth/controllers/authentication_manager.dart';

class BarcodeController extends GetxController {
  MenuController _menuController = Get.put(MenuController());

  final count = 0.obs;
  Rx<List<CabangProduct>> dataList = Rx<List<CabangProduct>>([]);
  final AuthenticationManager _authManager = Get.find();

  @override
  void onInit() async {
    super.onInit();
    dataList.value =
        await _menuController.getAllProductById(_authManager.getToken()!);
    print("BarcodeController, ${dataList.value}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print('tes $barcodeScanRes');
      filterProduk(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  filterProduk(String keyword) {
    print("Keyword $keyword");
    try {
      CabangProduct cabangProduct = dataList.value
          .singleWhere((element) => element.product!.productBarcode == keyword);

      print("filterProduk $cabangProduct");
      Get.toNamed(Routes.DETAIL, arguments: cabangProduct);
    } catch (e) {}
  }
}
