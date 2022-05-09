import 'package:get/get.dart';

import '../controllers/barcode_controller.dart';

class BarcodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeController>(
      () => BarcodeController(),
    );
  }
}
