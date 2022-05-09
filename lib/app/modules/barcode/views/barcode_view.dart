import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/barcode_controller.dart';

class BarcodeView extends GetView<BarcodeController> {
  Barcode? result;
  QRViewController? qrcontroller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  _qrCallback(String? code) {
    print('tes $code');
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _tesQrCode2());
  }

  _tesBarcode3() {
    return SizedBox(
      width: 300.0,
      height: 600.0,
      child: new QrCamera(
        qrCodeCallback: (code) {
          _qrCallback(code);
        },
      ),
    );
  }

  _tesQrCode2() {
    return Center(
        child: ElevatedButton(
            onPressed: () => scanBarcodeNormal(),
            child: Text('Start barcode scan')));
  }

  _tesQRCode1() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: QRBarScannerCamera(
        onError: (context, error) => Text(
          error.toString(),
          style: TextStyle(color: Colors.red),
        ),
        qrCodeCallback: (code) {
          _qrCallback(code);
        },
      ),
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
