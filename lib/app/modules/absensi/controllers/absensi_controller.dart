import 'package:camera/camera.dart';
import 'package:get/get.dart';

class AbsensiController extends GetxController {
  final count = 0.obs;
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

  Future<CameraController> initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.max);
    await cameraController.initialize();

    return cameraController;
  }
}
