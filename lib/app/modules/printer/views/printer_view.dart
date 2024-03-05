import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:rsm_flutter_get_cli/app/data/models/cart.dart';
import 'package:rsm_flutter_get_cli/app/modules/cart/controllers/cart_controller.dart';

class PrinterView extends StatefulWidget {
  const PrinterView({Key? key}) : super(key: key);

  @override
  State<PrinterView> createState() => _PrinterViewState();
}

class _PrinterViewState extends State<PrinterView> {
  bool connected = false;
  bool isLoading = false;
  List availableBluetoothDevices = [];

  final CartController cartController = Get.find();

  @override
  void initState() {
    super.initState();

    checkConnectionStatus();
    getBluetooth();
  }

  Future<void> checkConnectionStatus() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;

    if (isConnected == "true") {
      setState(() {
        connected = true;
      });
    } else {
      //Hadnle Not Connected Senario
    }
  }

  Future<void> getBluetooth() async {
    final List? bluetooths = await BluetoothThermalPrinter.getBluetooths;
    print("Print $bluetooths");
    setState(() {
      availableBluetoothDevices = bluetooths!;
    });
  }

  Future<void> setConnect(String mac) async {
    setState(() {
      isLoading = true;
    });
    final String? result = await BluetoothThermalPrinter.connect(mac);
    print("state conneected $result");

    setState(() {
      isLoading = false;
    });

    if (result == "true") {
      //   printTicket();
      setState(() {
        connected = true;
      });
    }
  }

  Future<void> printTicket() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getTicket();
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
    }
  }

  Future<List<int>> getTicket() async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.text("RSM",
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += generator.text("Rezky Sadel Motor",
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('085256376556',
        styles: PosStyles(align: PosAlign.center));

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'Item',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Qty',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Total',
          width: 4,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);

    for (var i = 0; i < cartController.cartItems.length; i++) {
      Cart e = cartController.cartItems[i];
      //   bluetooth.print3Column(
      //       e.cabangProduct!.product!.productName!,
      //       'X ${e.qty}',
      //       "Rp. " +
      //           NumberFormat("#,##0", "en_US").format(
      //               int.parse(e.cabangProduct!.product!.productPrice!) *
      //                   e.qty),
      //       Size.medium.val);

      bytes += generator.row([
        PosColumn(
            text: e.cabangProduct!.product!.productName!,
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
            )),
        PosColumn(
            text: e.qty.toString(),
            width: 2,
            styles: PosStyles(align: PosAlign.center)),
        PosColumn(
            text: priceFormat(
                (int.parse(e.cabangProduct!.harga!) * e.qty).toString()),
            width: 4,
            styles: PosStyles(align: PosAlign.right)),
      ]);
    }

    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          )),
      PosColumn(
          text: NumberFormat("#,##0", "en_US")
              .format(cartController.count2)
              .toString(),
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          )),
    ]);

    bytes += generator.hr(ch: '=', linesAfter: 1);

    // Print QR Code using native function
    bytes += generator.qrcode('https://reskysadelmotor.com/');

    bytes += generator.text("",
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    // ticket.feed(2);
    bytes += generator.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    String cdate1 = DateFormat("EEEE, d MMMM yyyy HH:mm:ss", "id_ID")
        .format(DateTime.now());

    bytes += generator.text(cdate1,
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += generator.text(
        'Note: Goods once sold will not be taken back or exchanged.',
        styles: PosStyles(align: PosAlign.center, bold: false));
    bytes += generator.cut();
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cetak Struk'),
          backgroundColor: CoreColor.primary,
          elevation: 0),
      body: Column(
        children: [
          Center(
            child: Text('print '),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: availableBluetoothDevices.length > 0
                  ? availableBluetoothDevices.length
                  : 0,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    String select = availableBluetoothDevices[index];
                    List list = select.split("#");
                    // String name = list[0];
                    String mac = list[1];

                    print(mac);
                    this.setConnect(mac);
                  },
                  title: Text('${availableBluetoothDevices[index]}'),
                  subtitle: isLoading ? Text('...') : Text("Click to Connect"),
                );
              },
            ),
          ),
          TextButton(
            onPressed: connected ? this.printTicket : null,
            child: Text("Print Ticket"),
          ),
        ],
      ),
    );
  }

  String priceFormat(String value) {
    return NumberFormat("#,##0", "en_US").format(int.parse(value)).toString();
  }
}
