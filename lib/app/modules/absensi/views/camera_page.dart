import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cores/core_colors.dart';
import '../../../routes/app_pages.dart';

class CameraPage extends StatefulWidget {
  CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;

  Future initializeCamera() async {
    var cameras = await availableCameras();
    _cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
          future: initializeCamera(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: CoreColor.primary));
            }

            final size = MediaQuery.of(context).size;
            var scale = size.aspectRatio * _cameraController.value.aspectRatio;
            scale = 1 / scale;

            return Stack(
              children: [
                Container(
                  width: size.width,
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topCenter,
                    child: CameraPreview(_cameraController),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        // Attempt to take a picture and get the file `image`
                        // where it was saved.
                        final image = await _cameraController.takePicture();
                        print(image.path);

                        await Get.toNamed(Routes.DISPLAY, arguments: image);
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                      }
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
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
