import 'package:flutter/material.dart';
import 'package:rsm_flutter_get_cli/app/cores/loaders/item_product_skeleton.dart';

class Tes extends StatelessWidget {
  const Tes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Container(
        height: 290,
        child: absenLoading(),
      ),
    );
  }

  ListView absenLoading() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) => ItemProductSkeleton(),
      separatorBuilder: (context, index) => const SizedBox(width: 16),
    );
  }
}
