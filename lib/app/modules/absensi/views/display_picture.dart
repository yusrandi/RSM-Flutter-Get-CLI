import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/absensi_controller.dart';

class DisplayPicture extends GetView<AbsensiController> {
  @override
  Widget build(BuildContext context) {
    XFile image = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(image.path)),
    );
  }
}
