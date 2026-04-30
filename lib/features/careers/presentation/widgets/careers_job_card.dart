import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/router/consultation_route_extra.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/careers/presentation/models/careers_ui_models.dart';

class CareersJobCard extends StatelessWidget {
  const CareersJobCard({super.key, required this.opening});

  final CareerOpeningData opening;

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 520;
            final titleStyle = AppTextStyles.hero.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontFamily: 'Cinzel',
            );
            final title = SelectableText(
              opening.titleKey.tr(),
              style: titleStyle,
            );
            final apply = TextButton(
              onPressed: () => context.push(
                AppRoutes.consultation,
                extra: const ConsultationRouteExtra(isJobApplication: true),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'careers.apply'.tr(),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (narrow)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      const SizedBox(height: AppSpacing.md12),
                      Align(alignment: Alignment.centerLeft, child: apply),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: title),
                      apply,
                    ],
                  ),
                const SizedBox(height: AppSpacing.lg16),
                Wrap(
                  spacing: AppSpacing.sm8,
                  runSpacing: AppSpacing.sm8,
                  children: [
                    _DepartmentTag(department: opening.department),
                    for (final key in opening.metaTagKeys)
                      _MetaTag(label: key.tr()),
                    if (opening.stackKey != null)
                      _MetaTag(label: opening.stackKey!.tr()),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DepartmentTag extends StatelessWidget {
  const _DepartmentTag({required this.department});

  final CareersDepartment department;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: department.tagBackground,
        borderRadius: AppRadius.borderPill36,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md12,
          vertical: AppSpacing.sm8,
        ),
        child: SelectableText(
          department.labelKey.tr(),
          style: AppTextStyles.pill.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _MetaTag extends StatelessWidget {
  const _MetaTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.textSecondary.withValues(alpha: 0.12),
        borderRadius: AppRadius.borderPill36,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md12,
          vertical: AppSpacing.sm8,
        ),
        child: SelectableText(
          label,
          style: AppTextStyles.pill.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
