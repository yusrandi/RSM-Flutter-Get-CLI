import 'dart:convert';

import 'package:get/get.dart';
import '../../../cores/core_colors.dart';
import '../../../data/config/api.dart';
import '../../../data/models/user.dart';
import 'authentication_manager.dart';
import 'cache_manager.dart';
import 'package:http/http.dart' as http;

enum Status { none, running, stopped, paused }

class AuthController extends GetxController with CacheManager {
  final count = 0.obs;
  Rx<Status> status = Status.none.obs;
  RxBool passwordVisible = false.obs;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<String> loginUser(String phone, String password) async {
    status.value = Status.running;
    var _response = await http.post(Uri.parse(Api().loginUser), body: {
      "phone": phone,
      "password": password,
    });

    print("url ${Api().loginUser}");

    status.value = Status.none;

    print(_response.body);
    var data = json.decode(_response.body);
    if (data['responsecode'] == '1') {
      User user = User.fromJson(json.decode(_response.body)['user']);

      // login(user.id.toString());
      _authManager.login(user.id.toString());

      // await Get.offAndToNamed(Routes.HOME);
    }

    Get.snackbar("RSM", "${data['responsemsg']}",
        backgroundColor: CoreColor.whiteSoft, duration: Duration(seconds: 2));
    return _response.body;
  }
}
