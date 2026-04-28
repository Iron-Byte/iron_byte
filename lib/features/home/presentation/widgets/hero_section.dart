import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/presentation/widgets/stats_row.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'we_turn_ideas'.tr(),
          style: AppTextStyles.hero.copyWith(
            fontFamily: 'Cinzel',
            color: AppColors.textPrimary,
          ),
        ),
        SelectableText(
          'software_works'.tr(),
          style: AppTextStyles.heroAccent.copyWith(fontFamily: 'Cinzel'),
        ),
        const Gap(AppSpacing.lg16),
        SelectableText(
          'web_apps'.tr(),
          style: AppTextStyles.body.copyWith(height: 1.75),
        ),
        const Gap(AppSpacing.xxl24),
        Wrap(
          spacing: AppSpacing.md12,
          runSpacing: AppSpacing.md12,
          children: [
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.portfolio),
              child: const Text('See our work'),
            ),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.services),
              child: const Text('Learn more'),
            ),
          ],
        ),
        const Gap(AppSpacing.huge36),
        const HomeStatsRow(),
        const Gap(AppSpacing.huge36),
        
      ],
    );
  }
}
