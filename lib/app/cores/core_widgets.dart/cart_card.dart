import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';

import '../../data/config/api.dart';
import '../../data/models/cart.dart';
import '../../modules/cart/controllers/cart_controller.dart';

class CartCArd extends StatelessWidget {
  final CartController cartController = Get.find();
  final Cart product;
  final Function() function1;
  final Function() function2;

  CartCArd(
      {required this.product,
      required this.function1,
      required this.function2});
  @override
  Widget build(BuildContext context) {
    return tes();
  }

  tes() {
    return Container(
      height: 114,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 82,
            width: 82,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(Api.imageURL +
                      '/' +
                      product.cabangProduct!.product!.productImage!)),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.cabangProduct!.product!.productName!,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  product.cabangProduct!.product!.productBarcode!,
                  style: TextStyle(color: CoreColor.kTextColor, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rp. " +
                      NumberFormat("#,##0", "en_US").format(
                          int.parse(product.cabangProduct!.harga!.toString())),
                  style: TextStyle(fontSize: 16, color: CoreColor.kTextColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: function2,
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: CoreColor.primary,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/remove.svg",
                            color: Colors.white,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                        height: 30,
                        width: 30,
                        child:
                            GetBuilder<CartController>(builder: (controller) {
                          return Center(
                              child: Text(
                            product.qty.toString(),
                            style: TextStyle(fontSize: 18),
                          ));
                        })),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: function1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: CoreColor.primary,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/Plus Icon.svg",
                            color: Colors.white,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
