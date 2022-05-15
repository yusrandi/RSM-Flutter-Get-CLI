import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:rsm_flutter_get_cli/app/routes/app_pages.dart';

import '../../../cores/core_colors.dart';
import '../../../data/config/api.dart';

enum Status { none, running, stopped, paused }

class AbsensiController extends GetxController {
  RxInt count = 0.obs;
  RxInt index = 1.obs;
  Rx<Status> status = Status.none.obs;

  late CameraController cameraController;

  @override
  void onInit() async {
    super.onInit();

    print("on init");
    await initCamera();
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

  void setIndex(indexx) => index.value = indexx;

  Future<CameraController> initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.high);
    await cameraController.initialize();

    return cameraController;
  }

  tes() {
    status.value = Status.running;
  }

  Future<String> absenStore(
      File? file, String status, String? keterangan, String userId) async {
    var request = http.MultipartRequest("POST", Uri.parse(Api.instance.absen));

    request.fields['user_id'] = userId;
    request.fields['status'] = status;
    request.fields['keterangan'] = keterangan!;

    if (file != null) {
      final resFile = await http.MultipartFile.fromPath('foto', file.path,
          contentType: MediaType('application', 'x-tar'));
      request.files.add(resFile);
    } else {
      request.fields['foto'] = "";
    }

    final data = await request.send();
    final response = await http.Response.fromStream(data);
    print("response ${response.statusCode}");

    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      print("Data ${data['responsemsg']}");

      Get.snackbar("absen bos", "${data['responsemsg']}",
          backgroundColor: CoreColor.whiteSoft, duration: Duration(seconds: 2));
      Get.offAndToNamed(Routes.HOME);

      return 'berhasil';
    } else {
      throw Exception();
    }
  }
}
