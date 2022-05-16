import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/data/config/api.dart';
import 'package:rsm_flutter_get_cli/app/data/models/cabang-product.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuController extends GetxController {
  final count = 0.obs;

  Rx<List<CabangProduct>> dataList = Rx<List<CabangProduct>>([]);

  @override
  void onInit() async {
    super.onInit();

    var list = await getAllProductById(1);
    dataList.value = list;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<List<CabangProduct>> getAllProductById(int id) async {
    Uri url = Uri.parse(Api().getCabangProducts + '/' + id.toString());
    var res = await http.get(url);
    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    print(data);

    if (data.isEmpty) {
      return [];
    } else {
      return data.map((e) => CabangProduct.fromJson(e)).toList();
    }
  }

  runFilter(String keyword) async {
    List<CabangProduct> results = [];
    if (keyword.isEmpty) {
      var list = await getAllProductById(1);
      results = list;
    } else {
      results = dataList.value
          .where((element) =>
              element.product!.productName!
                  .toString()
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) |
              element.product!.productBarcode!
                  .toString()
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
          .toList();
    }
    dataList.value = results;
  }

  Future scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      runFilter(barcodeScanRes);
      print('tes $barcodeScanRes');
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
