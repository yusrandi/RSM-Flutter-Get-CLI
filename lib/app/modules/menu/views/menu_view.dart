import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_styles.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_widgets.dart/item_product.dart';

import '../../../data/models/cabang-product.dart';
import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuController> {
  // final MenuController cartController = Get.find();
  MenuController c = Get.put(MenuController());
  final _userSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          Text("List Produk",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: CoreColor.kTextColor)),
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
                  child: Icon(Icons.search, color: Colors.red),
                ),
                Expanded(
                  child: Container(
                    child: TextFormField(
                      onChanged: (value) => c.runFilter(value),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nama atau Kode",
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.scanBarcodeNormal(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SvgPicture.asset(
                      "assets/icons/qr-code.svg",
                      color: CoreColor.primary,
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Obx(
            () => StaggeredGrid.count(
              // crossAxisCount is the number of columns
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              // This creates two columns with two items in each column
              children:
                  List.generate(controller.dataList.value.length, (index) {
                CabangProduct cb = controller.dataList.value[index];
                return ItemProduct(cb: cb);
              }),
            ),
          )),
        ],
      ),
    );
  }

  tesFilter() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (value) => controller.filterPlayer(value),
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => Text(controller.dataList.value.length.toString())),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.foundPlayers.value.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    controller.foundPlayers.value[index]['name'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                      Text(controller.foundPlayers.value[index]['country']),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}