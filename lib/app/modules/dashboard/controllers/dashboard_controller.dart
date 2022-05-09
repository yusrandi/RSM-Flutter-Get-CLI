import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/config/api.dart';
import '../../../data/models/cabang-product.dart';

class DashboardController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
}
