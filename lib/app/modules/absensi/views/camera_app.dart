import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraApp extends StatefulWidget {
  final CameraDescription camera;

  CameraApp(this.camera);

  @override
  _CameraAppState createState() => _CameraAppState(camera);
}

class _CameraAppState extends State<CameraApp> {
  final CameraDescription camera;
  late CameraController controller;

  _CameraAppState(this.camera);

  @override
  void initState() {
    super.initState();
    controller = CameraController(camera, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}
