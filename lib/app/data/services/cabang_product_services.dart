import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/api.dart';
import '../models/cabang-product.dart';

class CabangProductService extends GetConnect {
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
