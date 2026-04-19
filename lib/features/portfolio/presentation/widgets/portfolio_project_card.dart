import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/portfolio/presentation/models/portfolio_ui_models.dart';

class PortfolioProjectCard extends StatelessWidget {
  const PortfolioProjectCard({
    super.key,
    required this.project,
  });

  final PortfolioProjectData project;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.borderMd12,
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: ClipRRect(
        borderRadius: AppRadius.borderMd12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _CardVisual(project: project),
            _CardBody(project: project),
          ],
        ),
      ),
    );
  }
}

class _CardVisual extends StatelessWidget {
  const _CardVisual({required this.project});

  final PortfolioProjectData project;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(gradient: project.gradient),
          ),
          Positioned(
            left: AppSpacing.md12,
            top: AppSpacing.md12,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.background.withValues(alpha: 0.55),
                borderRadius: AppRadius.borderSm8,
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.6)),
              ),
              child: Padding(
                padding: AppSpacing.hMd12.add(AppSpacing.vSm8),
                child: Text(
                  project.categoryKey.tr(),
                  style: AppTextStyles.pill.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              project.emojiKey.tr(),
              style: const TextStyle(fontSize: 48),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({required this.project});

  final PortfolioProjectData project;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Padding(
        padding: AppSpacing.allLg16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.titleKey.tr(),
              style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm8),
            Text(
              project.descriptionKey.tr(),
              style: AppTextStyles.bodySmall,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.lg16),
            Wrap(
              spacing: AppSpacing.sm8,
              runSpacing: AppSpacing.sm8,
              children: [
                for (final key in project.techKeys)
                  Text(
                    key.tr(),
                    style: AppTextStyles.tag.copyWith(fontSize: 12),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'portfolio.projects.view'.tr(),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
