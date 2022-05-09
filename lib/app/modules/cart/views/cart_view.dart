import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';
import 'package:rsm_flutter_get_cli/app/data/models/cart.dart';

import '../../../cores/core_widgets.dart/cart_card.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  final CartController cartController = Get.find();

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
      body: Stack(
        children: [
          ListView(
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
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
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
                          Text('Total',
                              style: TextStyle(
                                  fontSize: 16, color: CoreColor.kTextColor)),
                          GetBuilder<CartController>(builder: (controller) {
                            return Text(
                              "Rp. " +
                                  NumberFormat("#,##0", "en_US")
                                      .format(controller.count2),
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        var qtys = [];
                        controller.cartItems.forEach((element) {
                          print(element.qty);
                          qtys.add(element.qty);
                        });

                        print(qtys.join(","));
                      },
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          gradient: CoreColor.bottomShadow,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Center(
                          child: Text(
                            'Checkout',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
