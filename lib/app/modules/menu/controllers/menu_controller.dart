import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/data/config/api.dart';
import 'package:rsm_flutter_get_cli/app/data/models/cabang-product.dart';

import 'package:http/http.dart' as http;
import 'package:rsm_flutter_get_cli/app/data/models/kategori_model.dart';
import 'dart:convert';

import 'package:rsm_flutter_get_cli/app/data/services/kategori_services.dart';

import '../../auth/controllers/authentication_manager.dart';

class MenuController extends GetxController {
  final count = 0.obs;

  // Rx<List<CabangProduct>> dataList = Rx<List<CabangProduct>>([]);
  RxList<CabangProduct> dataList = (List<CabangProduct>.of([])).obs;
  final AuthenticationManager _authManager = Get.find();

  @override
  void onInit() async {
    super.onInit();

    dataList.value = await getAllProductById(_authManager.getToken()!);
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<List<KategoriModel>> getAllKategoris() async {
    List<KategoriModel> listResult = ([]);

    listResult.add(KategoriModel(id: 0, code: "", name: "Semua"));

    listResult.addAll(await KategoriService().fetchKategoris());

    return listResult;
  }

  Future<List<CabangProduct>> getAllProductById(String id) async {
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
    print("keyword $keyword");
    List<CabangProduct> results = [];
    if (keyword.isEmpty || keyword == "0") {
      print("true");
      var list = await getAllProductById(_authManager.getToken()!);
      results = list;
      print(list);
    } else {
      print("false");
      results = dataList
          .where((element) =>
              element.product!.productName!
                  .toString()
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) |
              element.product!.productBarcode!
                  .toString()
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) |
              element.product!.kategoriId!
                  .toString()
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
          .toList();
    }
    dataList.value = results;
  }

  runFilterKategori(int kategoriId) async {
    List<CabangProduct> results = [];
    dataList.value = await getAllProductById(_authManager.getToken()!);

    if (kategoriId == 0) {
      print("true");
      var list = await getAllProductById(_authManager.getToken()!);
      results = list;
      print(list);
    } else {
      print("false");
      results = dataList
          .where((element) => element.product!.kategoriId! == kategoriId)
          .toList();
    }
    print(dataList.length);
    print(results.length);

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
