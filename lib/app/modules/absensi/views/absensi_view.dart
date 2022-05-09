import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../cores/core_colors.dart';
import '../controllers/absensi_controller.dart';

class AbsensiView extends GetView<AbsensiController> {
  AbsensiController c = Get.put(AbsensiController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<CameraController>(
            future: c.initCamera(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: CoreColor.primary));
              }

              CameraController cameraController = snapshot.data!;

              if (!cameraController.value.isInitialized) {
                return Center(child: Text('Not Initialised'));
              }
              return CameraPreview(cameraController);
            }));
  }
}
