import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/domain/models/home_service_tag.dart';

class HomeTagPill extends StatelessWidget {
  const HomeTagPill({
    super.key,
    required this.label,
    this.backgroundColor,
  });

  final String label;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg16,
        vertical: AppSpacing.sm8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: SelectableText(
        label,
        style: AppTextStyles.pill.copyWith(color: AppColors.textMuted),
      ),
    );
  }
}

class HomeStatusChip extends StatelessWidget {
  const HomeStatusChip({super.key});



  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md12,
      runSpacing: AppSpacing.md12,
      children: [
        for (final tag in HomeServiceTags.defaults)
          HomeTagPill(label: tag.translationKey.tr()),
      ],
    );
  }
}
