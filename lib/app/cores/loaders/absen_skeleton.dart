import 'package:flutter/material.dart';

import 'skeleton.dart';

class AbsenSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 150),
              const SizedBox(height: 16 / 2),
              Row(
                children: const [
                  Expanded(
                    flex: 3,
                    child: Skeleton(),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
