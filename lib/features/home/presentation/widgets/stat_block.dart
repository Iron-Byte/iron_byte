import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';

class HomeStatBlock extends StatelessWidget {
  const HomeStatBlock({super.key, required this.top, required this.bottom});

  final String top;
  final String bottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          top,
          style: AppTextStyles.statNumber.copyWith(fontFamily: 'Cinzel'),
        ),
        const Gap(AppSpacing.xs4),
        SelectableText(bottom, style: AppTextStyles.statLabel),
      ],
    );
  }
}
