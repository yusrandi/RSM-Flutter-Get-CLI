import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AbsensiController extends GetxController {
  RxInt count = 0.obs;
  late CameraController cameraController;

  @override
  void onInit() {
    super.onInit();

    print("on init");
  }

  @override
  void onReady() {
    super.onReady();

    print("on ready");
  }

  @override
  void onClose() {
    print("on close");
  }

  void increment() => count.value++;
  void setCount(int val) => count.value = val;

  Future<CameraController> initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.high);
    await cameraController.initialize();

    return cameraController;
  }
}
