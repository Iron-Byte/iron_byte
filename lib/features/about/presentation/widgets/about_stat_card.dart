import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';

class AboutStatCard extends StatelessWidget {
  const AboutStatCard({
    super.key,
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

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
            Text(
              value,
              style: AppTextStyles.heroAccent.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cinzel',
              ),
            ),
            const SizedBox(height: AppSpacing.sm8),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
