import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_images.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_widgets.dart/item_product.dart';
import 'package:rsm_flutter_get_cli/app/data/models/dashboard_model.dart';
import 'package:rsm_flutter_get_cli/app/modules/cart/controllers/cart_controller.dart';
import 'package:rsm_flutter_get_cli/app/routes/app_pages.dart';

import '../../../cores/core_colors.dart';
import '../../../cores/loaders/item_product_skeleton.dart';
import '../../../data/models/cabang-product.dart';
import '../../../data/models/user.dart';
import '../../auth/controllers/authentication_manager.dart';
import '../../setting/controllers/setting_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final DashboardController c = Get.put(DashboardController());
  // final CarouselController _controller = CarouselController();
  final containerRadius = const Radius.circular(30.0);
  final cartController = Get.put(CartController());
  final userController = Get.put(SettingController());

  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  final AuthenticationManager _authManager = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), child: layout2(context)),
    );
  }

  layout2(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<User>(
                  future: userController.getUser(_authManager.getToken()!),
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

                    return Row(
                      children: [
                        Image.asset(
                          CoreImages.rsmMerah,
                          height: 40,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Hello',
                            style: CoreStyles.uTitle,
                            children: <TextSpan>[
                              TextSpan(
                                  text: u.name,
                                  style:
                                      CoreStyles.uTitle.copyWith(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
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
                                      cartController.cartItems.length
                                          .toString(),
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
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: FutureBuilder<DashboardModel>(
                future: c.fetchReport(_authManager.getToken()!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  print(snapshot.data);

                  DashboardModel model = snapshot.data!;

                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: IntrinsicHeight(
                        child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userKinerja(model),
                            SizedBox(height: 8),
                            userQty(model),
                          ],
                        ),
                        VerticalDivider(),
                        cabangTotal(model),
                      ],
                    )),
                  );
                }),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text("List Produk Terlaku",
                style: CoreStyles.uSubTitle.copyWith(color: Colors.black)),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: FutureBuilder<List<CabangProduct>>(
                future:
                    c.getAllProductById(int.parse(_authManager.getToken()!)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(height: 290, child: listTerlakuLoading());
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
                    child: ListView.builder(
                      // crossAxisCount is the number of columns
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        CabangProduct cb = snapshot.data![index];
                        return ItemProduct(cb: cb);
                      },
                    ),
                  );
                }),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("List Semua Produk",
                style: CoreStyles.uSubTitle.copyWith(color: Colors.black)),
          ),
          Container(
              margin: EdgeInsets.only(top: 8),
              child: FutureBuilder<List<CabangProduct>>(
                  future: c.getAllProductById(1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return listSemuaProdukLoading();
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
          SizedBox(height: 50),
        ],
      ),
    );
  }

  RichText cabangTotal(DashboardModel model) {
    return RichText(
      text: TextSpan(
        text: "Rp. " +
            NumberFormat("#,##0", "en_US")
                .format(int.parse(model.cabangTotal!.toString())),
        style:
            CoreStyles.uTitle.copyWith(fontSize: 16, color: CoreColor.primary),
        children: <TextSpan>[
          TextSpan(
              text: '\nTotal Penjualan Cabang',
              style: CoreStyles.uTitle
                  .copyWith(fontSize: 10, color: CoreColor.kTextColor)),
        ],
      ),
    );
  }

  RichText userQty(DashboardModel model) {
    return RichText(
      text: TextSpan(
        text: model.userQty.toString(),
        style: CoreStyles.uTitle.copyWith(fontSize: 16),
        children: <TextSpan>[
          TextSpan(
              text: '\nJumlah Barang Terjual',
              style: CoreStyles.uTitle
                  .copyWith(fontSize: 10, color: CoreColor.kTextColor)),
        ],
      ),
    );
  }

  RichText userKinerja(DashboardModel model) {
    return RichText(
      text: TextSpan(
        text: "Rp. " +
            NumberFormat("#,##0", "en_US")
                .format(int.parse(model.userTotal!.toString())),
        style: CoreStyles.uTitle.copyWith(fontSize: 16),
        children: <TextSpan>[
          TextSpan(
              text: '\nTotal Kinerja',
              style: CoreStyles.uTitle
                  .copyWith(fontSize: 10, color: CoreColor.kTextColor)),
        ],
      ),
    );
  }

  ListView listTerlakuLoading() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) => ItemProductSkeleton(),
      separatorBuilder: (context, index) => const SizedBox(width: 16),
    );
  }

  listSemuaProdukLoading() {
    return StaggeredGrid.count(
      // crossAxisCount is the number of columns
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      // This creates two columns with two items in each column
      children: List.generate(10, (index) {
        return ItemProductSkeleton();
      }),
    );
  }
}
