import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../cores/core_colors.dart';
import '../../../cores/core_images.dart';
import '../../../cores/core_styles.dart';
import '../controllers/absensi_controller.dart';

class AbsensiView extends GetView<AbsensiController> {
  AbsensiController c = Get.put(AbsensiController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => c.count.value == 0 ? takeReady() : takeSelfi());
  }

  Center takeReady() {
    return Center(
      child: GestureDetector(
        onTap: () => c.setCount(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(CoreImages.faceScanningJson),
            Text(
              'Tap For Take Selfie',
              style: CoreStyles.uTitle.copyWith(color: CoreColor.gradient1),
            ),
            // CameraPreview(cameraController),
          ],
        ),
      ),
    );
  }

  takeSelfi() {
    return FutureBuilder<CameraController>(
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
        return Column(
          children: [
            Container(child: CameraPreview(cameraController)),
            GestureDetector(
              onTap: () => c.setCount(0),
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: new BoxDecoration(
                  color: CoreColor.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
