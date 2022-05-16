import 'dart:async';

import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  RxDouble progressValue = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<void> initializeSettings() async {
    //Simulate other services for 3 seconds
    await Future.delayed(Duration(seconds: 3));
    Get.toNamed(Routes.HOME);
  }
}
