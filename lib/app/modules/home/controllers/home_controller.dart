import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt count = 1.obs;

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

  void setIndex(index) => count.value = index;
}
