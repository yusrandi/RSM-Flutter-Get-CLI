import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../cores/core_colors.dart';
import '../../../cores/core_images.dart';
import '../../../cores/core_styles.dart';
import '../../../routes/app_pages.dart';
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
        onTap: () => Get.toNamed(Routes.CAMERA),
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
        final size = MediaQuery.of(context).size;
        var scale = size.aspectRatio * cameraController.value.aspectRatio;
        scale = 1 / scale;

        return Column(
          children: [
            Container(
                width: size.width,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topCenter,
                  child: CameraPreview(cameraController),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (() => c.setCount(0)),
                  child: Icon(
                    Icons.cancel_sharp,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () async {
                    try {
                      // Attempt to take a picture and get the file `image`
                      // where it was saved.
                      final image = await cameraController.takePicture();
                      print(image.path);

                      await Get.toNamed(Routes.DISPLAY, arguments: image);
                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                    }
                    c.setCount(0);
                  },
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: new BoxDecoration(
                      color: CoreColor.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
