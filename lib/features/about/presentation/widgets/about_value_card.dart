import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/about/presentation/models/about_ui_models.dart';

class AboutValueCard extends StatelessWidget {
  const AboutValueCard({
    super.key,
    required this.data,
  });

  final AboutValuePillarData data;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderMd12,
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: Padding(
        padding: AppSpacing.allLg16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              data.indexKey.tr(),
              style: AppTextStyles.tag.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: AppSpacing.md12),
            SelectableText(
              data.titleKey.tr(),
              style: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: 'Cinzel',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: AppSpacing.sm8),
            SelectableText(
              data.bodyKey.tr(),
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
