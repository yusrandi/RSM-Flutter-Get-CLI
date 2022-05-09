import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rsm_flutter_get_cli/app/data/config/api.dart';
import 'dart:convert';

import '../../../data/models/user.dart';

class SettingController extends GetxController {
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

  Future<User> getUser(String id) async {
    Uri url = Uri.parse(Api().getUser + "/" + id);
    var res = await http.get(url);
    User data = User.fromJson(json.decode(res.body)['data']);
    print(data.toJson());

    return data;
  }
}
