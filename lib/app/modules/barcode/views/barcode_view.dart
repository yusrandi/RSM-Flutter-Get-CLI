import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';

import '../../../cores/core_images.dart';
import '../controllers/barcode_controller.dart';

class BarcodeView extends GetView<BarcodeController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  BarcodeController _barcodeController = Get.put(BarcodeController());

  @override
  Widget build(BuildContext context) {
    return Center(child: _tesQrCode2());
  }

  _tesQrCode2() {
    return GestureDetector(
      onTap: () => _barcodeController.scanBarcodeNormal(),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(CoreImages.qrJson),
          Text(
            'Tap For scan',
            style: CoreStyles.uTitle.copyWith(color: CoreColor.gradient1),
          ),
        ],
      )),
    );
  }

  Future scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print('tes $barcodeScanRes');
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
