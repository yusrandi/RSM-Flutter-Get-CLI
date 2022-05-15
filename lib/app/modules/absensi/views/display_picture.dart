import 'dart:io';
import 'dart:ui';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';

import '../../../cores/core_colors.dart';
import '../controllers/absensi_controller.dart';

class DisplayPicture extends GetView<AbsensiController> {
  AbsensiController c = Get.find();
  final _resKeterangan = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    XFile image = Get.arguments;
    c.status.value = Status.none;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CoreColor.greyColor2,
      appBar: AppBar(
        title: Text('Display Picture'),
        centerTitle: false,
        backgroundColor: CoreColor.primary,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: _body(size, image),
    );
  }

  loading() {
    return CircularProgressIndicator(color: Colors.white);
  }

  Column _body(Size size, XFile image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            width: size.width / 2,
            height: size.width / 2,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fitWidth, image: FileImage(File(image.path))))),
        // store(image)
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CoreColor.primary.withOpacity(0.1)),
          height: 50,
          width: size.width,
          child: Row(
            children: [
              Expanded(child: _listItem("Hadir", 1)),
              SizedBox(width: 16),
              Expanded(child: _listItem("Sakit", 2)),
              SizedBox(width: 16),
              Expanded(child: _listItem("Izin", 3)),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              color: CoreColor.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            controller: _resKeterangan,
            maxLines: 4,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Keterangan apabila izin atau sakit",
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
        SizedBox(height: 16),

        GestureDetector(
          onTap: () {
            String keterangan = _resKeterangan.text.trim();
            String status = c.index == 1
                ? 'Hadir'
                : c.index == 2
                    ? 'Sakit'
                    : "Izin";

            print(status);
            print(keterangan);
            c.status.value = Status.running;
            c.absenStore(File(image.path), status, keterangan, "1");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CoreColor.primary),
            child: Center(
                child: Obx(
              () => c.status.value == Status.running
                  ? loading()
                  : Text(
                      "Submit",
                      style: CoreStyles.uTitle.copyWith(color: Colors.white),
                    ),
            )),
          ),
        ),
      ],
    );
  }

  _listItem(String title, int index) {
    return Obx(
      () => GestureDetector(
        onTap: () => c.setIndex(index),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: c.index.value == index
                  ? CoreColor.primary
                  : Colors.transparent),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      c.index.value == index ? Colors.white : CoreColor.primary,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<String> store(XFile image) {
    return FutureBuilder<String>(
        future: controller.absenStore(
            File(image.path), "status", "keterangan", "1"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: CoreColor.primary));
          }
          print(snapshot.data);
          return Text(snapshot.data!);
        });
  }

  void alertConfirm(BuildContext context) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "Mohon periksa kembali pesanan anda!",
            confirmButtonText: "Yes, Checkout",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      String keterangan = _resKeterangan.text.trim();
    }
  }
}
