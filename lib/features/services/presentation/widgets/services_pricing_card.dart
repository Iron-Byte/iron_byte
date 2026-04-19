import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/services/presentation/models/services_ui_models.dart';

class ServicesPricingCard extends StatelessWidget {
  const ServicesPricingCard({
    super.key,
    required this.plan,
  });

  final ServicesPricingPlanData plan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.borderMd12,
            border: Border.all(
              color: plan.highlighted
                  ? AppColors.primary.withValues(alpha: 0.55)
                  : AppColors.borderSurface,
              width: plan.highlighted ? 1 : 0.5,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg16,
              plan.highlighted ? AppSpacing.xxl24 : AppSpacing.lg16,
              AppSpacing.lg16,
              AppSpacing.lg16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.nameKey.tr(),
                  style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.lg16),
                Text(
                  plan.priceKey.tr(),
                  style: AppTextStyles.hero.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Cinzel',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm8),
                Text(
                  plan.subtitleKey.tr(),
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.xxl24),
                for (final key in plan.featureKeys) ...[
                  _FeatureRow(text: key.tr()),
                  const SizedBox(height: AppSpacing.md12),
                ],
                const SizedBox(height: AppSpacing.lg16),
                SizedBox(
                  width: double.infinity,
                  child: plan.highlighted
                      ? ElevatedButton(
                          onPressed: () => context.push('/consultation'),
                          child: Text(plan.ctaKey.tr()),
                        )
                      : OutlinedButton(
                          onPressed: () => context.push('/consultation'),
                          child: Text(plan.ctaKey.tr()),
                        ),
                ),
              ],
            ),
          ),
        ),
        if (plan.highlighted)
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadius.borderPill36,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg16,
                    vertical: AppSpacing.sm8,
                  ),
                  child: Text(
                    'services.pricing.popular_badge'.tr(),
                    style: AppTextStyles.pill.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_rounded,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: AppSpacing.sm8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall,
          ),
        ),
      ],
    );
  }
}
