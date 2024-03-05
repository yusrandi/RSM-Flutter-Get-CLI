import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  RxString lokasi = "".obs;

  late CameraController cameraController;

  @override
  void onInit() async {
    super.onInit();

    print("on init");
    await initCamera();

    Position position = await _getGeoLocationPosition();
    print(
        ' AbsensiController Lat: ${position.latitude} , Long: ${position.longitude}');
    String loc = await GetAddressFromLatLong(position);
    lokasi.value = loc;
    print(' AbsensiController lokasi $loc');
  }

  @override
  void onReady() {
    super.onReady();

    print("on ready");
  }

  @override
  void onClose() {
    cameraController.dispose();
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
    request.fields['lokasi'] = lokasi.value;

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

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    var loc =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
    print(loc);
    return loc;
  }
}
