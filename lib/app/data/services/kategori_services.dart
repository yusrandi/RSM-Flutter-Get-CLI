import 'dart:convert';

import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/data/models/kategori_model.dart';
import 'package:http/http.dart' as http;

import '../config/api.dart';

class KategoriService extends GetConnect {
  Future<List<KategoriModel>> fetchKategoris() async {
    final response = await http.get(Uri.parse(Api.instance.kategoriUrl));

    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];

    if (data.isEmpty) {
      return [];
    } else {
      return data.map((e) => KategoriModel.fromJson(e)).toList();
    }
  }
}
