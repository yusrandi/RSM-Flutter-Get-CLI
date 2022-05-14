import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:rsm_flutter_get_cli/app/routes/app_pages.dart';
import '../../data/config/api.dart';
import '../../data/models/cabang-product.dart';
import '../core_colors.dart';

class ItemProduct extends StatelessWidget {
  final CabangProduct cb;
  const ItemProduct({Key? key, required this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Get.toNamed(Routes.DETAIL, arguments: cb)),
      child: Container(
        width: 150,
        height: 290,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        Api.imageURL + '/' + cb.product!.productImage!)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${cb.product!.productName!}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CoreColor.kTextColor)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rp. " +
                            NumberFormat("#,##0", "en_US")
                                .format(int.parse(cb.harga.toString())),
                        style: TextStyle(color: Colors.black),
                      ),
                      Text('${cb.qty.toString()} ${cb.product!.unit!.name!}',
                          style: TextStyle(color: CoreColor.primary))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
