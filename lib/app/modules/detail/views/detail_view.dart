import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';
import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';
import 'package:rsm_flutter_get_cli/app/data/config/api.dart';
import 'package:rsm_flutter_get_cli/app/data/models/cabang-product.dart';
import 'package:rsm_flutter_get_cli/app/routes/app_pages.dart';

import '../../cart/controllers/cart_controller.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    CabangProduct data = Get.arguments;

    print(data);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: CoreColor.primary,
                expandedHeight: 250.0,
                stretch: false,
                floating: true,
                snap: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text(
                      "${data.product!.productName}",
                    ),
                    background: Image.network(
                      Api.imageURL + '/' + data.product!.productImage!,
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.product!.productName!,
                                style: CoreStyles.uSubTitle),
                            Text(data.product!.productBarcode!,
                                style: CoreStyles.uHeading3),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                "Rp. " +
                                    NumberFormat("#,##0", "en_US").format(
                                        int.parse(data.harga.toString())),
                                style: CoreStyles.uHeading3
                                    .copyWith(color: CoreColor.primary)),
                            Text(
                                '${data.qty.toString()} ${data.product!.unit!.name!}',
                                style: CoreStyles.uHeading3),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: CoreColor.primary),
                    Text('Produk Merk',
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(data.product!.productMerk!,
                        style: CoreStyles.uSubTitle),
                    SizedBox(height: 16),
                    Text('Produk Material',
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(data.product!.productMaterial!,
                        style: CoreStyles.uSubTitle),
                    SizedBox(height: 50)
                  ],
                ),
              ),
              Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (() => cartController.addToCart(data)),
                        child: Container(
                          height: 50,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: CoreColor.primary.withOpacity(0.2)),
                          child: Center(
                              child: SvgPicture.asset(
                            "assets/icons/bag.svg",
                            color: CoreColor.primary,
                            height: 30,
                          )),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: (() {
                            cartController.addToCart(data);
                            Get.offAndToNamed(Routes.CART);
                          }),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: CoreColor.bottomShadow),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/cart.svg",
                                  color: Colors.white,
                                  height: 20,
                                ),
                                SizedBox(width: 16),
                                Center(
                                    child: Text('CheckOut',
                                        style: CoreStyles.uSubTitle
                                            .copyWith(color: Colors.white))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
