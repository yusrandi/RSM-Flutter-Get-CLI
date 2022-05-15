import 'package:flutter/material.dart';

import 'skeleton.dart';

class ItemProductSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.4,
      height: 280.0,
      child: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.04),
                borderRadius: BorderRadius.circular(16)),
          ),
          const SizedBox(height: 16),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Skeleton(),
                const SizedBox(height: 16 / 2),
                Row(
                  children: const [
                    Expanded(
                      child: Skeleton(),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Skeleton(),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
