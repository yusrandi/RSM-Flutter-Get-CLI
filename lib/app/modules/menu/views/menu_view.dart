import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_widgets.dart/item_product.dart';
import 'package:rsm_flutter_get_cli/app/data/models/kategori_model.dart';

import '../../../cores/loaders/item_product_skeleton.dart';
import '../../../data/models/cabang-product.dart';
import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuController> {
  final MenuController c = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 8),
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
                                color: Colors.white, fontSize: 16)),
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
            SizedBox(height: 16),
            FutureBuilder<List<KategoriModel>>(
                future: c.getAllKategoris(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
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
                    height: 40,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          KategoriModel kategoriModel = snapshot.data![index];
                          return Obx(
                            () {
                              return GestureDetector(
                                onTap: () {
                                  c.count.value = index;
                                  c.runFilterKategori(kategoriModel.id!);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: c.count.value == index
                                          ? Colors.red
                                          : Colors.white),
                                  child: Center(
                                    child: Text(
                                      '${kategoriModel.name}',
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
                  );
                }),
            const SizedBox(height: 20),
            Container(
                child: Obx(
              () => StaggeredGrid.count(
                // crossAxisCount is the number of columns
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                // This creates two columns with two items in each column
                children: List.generate(controller.dataList.length, (index) {
                  CabangProduct cb = controller.dataList[index];
                  return ItemProduct(cb: cb);
                }),
              ),
            )),
            SizedBox(height: 50),
          ],
        ),
      ),
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
