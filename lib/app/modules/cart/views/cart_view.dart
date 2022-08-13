import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';
import 'package:rsm_flutter_get_cli/app/modules/auth/controllers/authentication_manager.dart';

import '../../../cores/core_widgets.dart/cart_card.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  final CartController cartController = Get.find();
  final AuthenticationManager _authenticationManager = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreColor.greyColor2,
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: false,
        backgroundColor: CoreColor.primary,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                GetX<CartController>(builder: (controller) {
                  return Column(
                      children: cartController.cartItems
                          .map((e) => Padding(
                              padding: const EdgeInsets.all(16),
                              child: CartCArd(
                                function1: () {
                                  cartController.increasQty(e);
                                },
                                function2: () {
                                  cartController.decreasqty(cart: e);
                                },
                                product: e,
                              )))
                          .toList());
                }),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                      child: Obx(
                    () => Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () => cartController.payment.value = "Cash",
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: cartController.payment.value == "Cash"
                                      ? CoreColor.primary
                                      : Colors.white),
                              child: Center(
                                child: Text(
                                  "Cash",
                                  style: CoreStyles.uSubTitle.copyWith(
                                      color:
                                          cartController.payment.value != "Cash"
                                              ? CoreColor.primary
                                              : Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () =>
                                  cartController.payment.value = "Credit",
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color:
                                        cartController.payment.value == "Credit"
                                            ? CoreColor.primary
                                            : Colors.white),
                                child: Center(
                                  child: Text(
                                    "Utang",
                                    style: CoreStyles.uSubTitle.copyWith(
                                        color: cartController.payment.value !=
                                                "Credit"
                                            ? CoreColor.primary
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.only(top: 5),
                  color: CoreColor.greyColor2,
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total', style: CoreStyles.uHeading3),
                            GetBuilder<CartController>(builder: (controller) {
                              return Text(
                                "Rp. " +
                                    NumberFormat("#,##0", "en_US")
                                        .format(controller.count2),
                                style: CoreStyles.uSubTitle,
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          if (controller.cartItems.isNotEmpty) {
                            alertConfirm(context);
                          }
                          // EasyLoading.show(status: 'loading...');
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            gradient: CoreColor.bottomShadow,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              'Checkout',
                              style: CoreStyles.uSubTitle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
      var qtys = [];
      var cabangProductIds = [];
      controller.cartItems.forEach((element) {
        print(element.qty);
        qtys.add(element.qty);
        cabangProductIds.add(element.cabangProduct!.id!);
      });

      print(qtys.join(","));
      print(cabangProductIds.join(","));
      print(controller.count2);

      controller.transaksiStore(
          controller.count2.toString(),
          cabangProductIds.join(","),
          qtys.join(","),
          _authenticationManager.getToken()!);
      return;
    }
  }
}
