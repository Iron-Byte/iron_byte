import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/services/presentation/models/services_ui_models.dart';

class ServicesCapabilityCard extends StatefulWidget {
  const ServicesCapabilityCard({
    super.key,
    required this.data,
  });

  final ServicesCapabilityData data;

  @override
  State<ServicesCapabilityCard> createState() => _ServicesCapabilityCardState();
}

class _ServicesCapabilityCardState extends State<ServicesCapabilityCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.borderMd12,
          border: Border.all(
            color: _isHovered
                ? AppColors.borderSurface.withValues(alpha: 0.85)
                : AppColors.borderSurface,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : const [],
        ),
        child: Padding(
          padding: AppSpacing.allMd12,
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
                  child: data.illustrationAssetPath != null
                      ? Image.asset(
                          data.illustrationAssetPath!,
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                        )
                      : Icon(
                          data.icon,
                          size: 22,
                          color: AppColors.textPrimary,
                        ),
                ),
              ),
              const SizedBox(height: AppSpacing.md12),
              SelectableText(
                data.titleKey.tr(),
                style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSpacing.sm8),
              SelectableText(
                data.descriptionKey.tr(),
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: AppSpacing.md12),
              for (final key in data.bulletKeys) ...[
                _Bullet(text: key.tr()),
                const SizedBox(height: AppSpacing.sm8),
              ],
            ],
          ),
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
          child: SelectableText(
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
