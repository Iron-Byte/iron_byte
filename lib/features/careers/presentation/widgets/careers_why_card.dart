import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/careers/presentation/models/careers_ui_models.dart';

class CareersWhyCard extends StatelessWidget {
  const CareersWhyCard({
    super.key,
    required this.data,
  });

  final CareersWhyFeatureData data;

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
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: AppRadius.borderSm8,
                border: Border.all(color: AppColors.borderSurface),
              ),
              child: Padding(
                padding: AppSpacing.allSm8,
                child: Icon(
                  data.icon,
                  size: 22,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg16),
            SelectableText(
              data.titleKey.tr(),
              style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm8),
            SelectableText(
              data.descriptionKey.tr(),
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
