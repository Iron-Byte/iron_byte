import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/services/presentation/models/services_ui_models.dart';

class ServicesCapabilityCard extends StatelessWidget {
  const ServicesCapabilityCard({
    super.key,
    required this.data,
  });

  final ServicesCapabilityData data;

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
                color: data.iconBackground,
                borderRadius: AppRadius.borderSm8,
                border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
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
            Text(
              data.titleKey.tr(),
              style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm8),
            Text(
              data.descriptionKey.tr(),
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: AppSpacing.lg16),
            for (final key in data.bulletKeys) ...[
              _Bullet(text: key.tr()),
              const SizedBox(height: AppSpacing.sm8),
            ],
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
