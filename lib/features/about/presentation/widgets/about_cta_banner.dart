import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/themes/themes.dart';

class AboutCtaBanner extends StatelessWidget {
  const AboutCtaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderLg16,
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: Padding(
        padding: AppSpacing.allXxl24,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 640;
            final textBlock = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'about.cta.title'.tr(),
                  style: AppTextStyles.hero.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Cinzel',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm8),
                Text(
                  'about.cta.subtitle'.tr(),
                  style: AppTextStyles.bodySmall,
                ),
              ],
            );

            final cta = SizedBox(
              width: narrow ? double.infinity : null,
              child: ElevatedButton(
                onPressed: () => context.push(AppRoutes.consultation),
                child: Text('about.cta.button'.tr()),
              ),
            );

            if (narrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  textBlock,
                  const SizedBox(height: AppSpacing.xxl24),
                  cta,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: textBlock),
                const SizedBox(width: AppSpacing.xxl24),
                cta,
              ],
            );
          },
        ),
      ),
    );
  }
}
