import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_widgets.dart/item_product.dart';
import 'package:rsm_flutter_get_cli/app/modules/cart/controllers/cart_controller.dart';
import 'package:rsm_flutter_get_cli/app/routes/app_pages.dart';

import '../../../cores/core_colors.dart';
import '../../../data/models/cabang-product.dart';
import '../../../data/models/user.dart';
import '../../setting/controllers/setting_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardController c = Get.put(DashboardController());
  // final CarouselController _controller = CarouselController();
  var containerRadius = const Radius.circular(30.0);
  final cartController = Get.put(CartController());
  final userController = Get.put(SettingController());

  final kategoris = [
    'Sticker Sticker',
    'Sadel',
    'Plat',
    'Jasa',
    'Baju',
    'Sticker Sticker',
    'Sadel',
    'Plat',
    'Jasa',
    'Baju'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), child: layout2()),
    );
  }

  layout2() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<User>(
                future: userController.getUser("1"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("...",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: CoreColor.kTextColor));
                  }
                  User u = snapshot.data!;
                  print(snapshot.data);

                  return RichText(
                    text: TextSpan(
                      text: 'Hello',
                      style: CoreStyles.uTitle,
                      children: <TextSpan>[
                        TextSpan(
                            text: u.name,
                            style: CoreStyles.uTitle.copyWith(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: (() => Get.toNamed(Routes.CART)),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/cart.svg",
                        color: Colors.red,
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: new BoxDecoration(
                            color: CoreColor.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Obx(() => Text(
                                    cartController.cartItems.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: CoreColor.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(Icons.search, color: Colors.white),
                ),
                Expanded(
                    child: Container(
                  child: Text(
                    'What are you looking for ?',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 40,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: kategoris.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: c.count.value == index
                                  ? Colors.red
                                  : Colors.white),
                          child: Center(
                            child: Text(
                              '${kategoris[index]}',
                              style: TextStyle(
                                  color: c.count.value == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
          SizedBox(height: 16),
          SizedBox(height: 16),
          Text("List Produk Terlaku",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                  color: Colors.black)),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: FutureBuilder<List<CabangProduct>>(
                future: c.getAllProductById(1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: CoreColor.primary));
                  }

                  print(snapshot.data);
                  if (snapshot.data!.isEmpty) {
                    return Container(
                      child: Center(
                        child: Text('Produk Belum Tersedia'),
                      ),
                    );
                  }
                  return Container(
                    height: 280,
                    child: ListView.separated(
                      // crossAxisCount is the number of columns
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        CabangProduct cb = snapshot.data![index];
                        return ItemProduct(cb: cb);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(height: 16),
          SizedBox(height: 16),
          Text("List Semua Produk",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                  color: Colors.black)),
          Container(
              margin: EdgeInsets.only(top: 8),
              child: FutureBuilder<List<CabangProduct>>(
                  future: c.getAllProductById(1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: CoreColor.primary));
                    }

                    if (snapshot.data!.isEmpty) {
                      return Container(
                        child: Center(
                          child: Text('Produk Belum Tersedia'),
                        ),
                      );
                    }
                    print(snapshot.data);
                    return StaggeredGrid.count(
                      // crossAxisCount is the number of columns
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      // This creates two columns with two items in each column
                      children: List.generate(snapshot.data!.length, (index) {
                        CabangProduct cb = snapshot.data![index];
                        return ItemProduct(cb: cb);
                      }),
                    );
                  })),
          Container(
              margin: EdgeInsets.only(top: 8),
              child: FutureBuilder<List<CabangProduct>>(
                  future: c.getAllProductById(1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: CoreColor.primary));
                    }

                    print(snapshot.data);
                    return StaggeredGrid.count(
                      // crossAxisCount is the number of columns
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      // This creates two columns with two items in each column
                      children: List.generate(snapshot.data!.length, (index) {
                        CabangProduct cb = snapshot.data![index];
                        return ItemProduct(cb: cb);
                      }),
                    );
                  })),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
