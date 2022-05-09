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

  final List<Map<String, dynamic>> allPlayers = [
    {"name": "Rohit Sharma", "country": "India"},
    {"name": "Virat Kohli ", "country": "India"},
    {"name": "Glenn Maxwell", "country": "Australia"},
    {"name": "Aaron Finch", "country": "Australia"},
    {"name": "Martin Guptill", "country": "New Zealand"},
    {"name": "Trent Boult", "country": "New Zealand"},
    {"name": "David Miller", "country": "South Africa"},
    {"name": "Kagiso Rabada", "country": "South Africa"},
    {"name": "Chris Gayle", "country": "West Indies"},
    {"name": "Jason Holder", "country": "West Indies"},
  ];

  Rx<List<Map<String, dynamic>>> foundPlayers =
      Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() async {
    super.onInit();

    foundPlayers.value = allPlayers;

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

  void filterPlayer(String playerName) {
    List<Map<String, dynamic>> results = [];
    if (playerName.isEmpty) {
      results = allPlayers;
    } else {
      results = allPlayers
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    foundPlayers.value = results;
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
