import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/domain/models/stat_item.dart';
import 'package:iron_byte/features/home/presentation/widgets/stat_block.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final items = StatItem.homeDefaults
        .map((e) => (top: e.valueHeadline, bottom: e.labelTranslationKey.tr()))
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 420) {
          return Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) const Gap(AppSpacing.lg16),
                HomeStatBlock(top: items[i].top, bottom: items[i].bottom),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) ...[
                const Gap(AppSpacing.xl20),
                SizedBox(
                  height: 48,
                  child: VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: AppColors.borderSurface,
                  ),
                ),
                const Gap(AppSpacing.xl20),
              ],
              Expanded(
                child: HomeStatBlock(
                  top: items[i].top,
                  bottom: items[i].bottom,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
