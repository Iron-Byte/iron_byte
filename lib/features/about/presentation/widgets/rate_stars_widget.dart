import 'package:flutter/material.dart';
import 'package:iron_byte/core/utils/assets.dart';
import 'package:iron_byte/core/utils/sizes.dart';

class RateStarsWidget extends StatelessWidget {
  final int rateCount;
  const RateStarsWidget({super.key, this.rateCount = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.padding12,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
        5,
        (index) => AppAssets.rateStar.svg(
          width: 20,
          height: 20,
          color: index < rateCount ? Colors.amber : Colors.grey,
        ),
      ),
    );
  }
}
