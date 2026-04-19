import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/themes/themes.dart';

class CareersOpenApplicationBanner extends StatelessWidget {
  const CareersOpenApplicationBanner({super.key});

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
                  'careers.open_application.title'.tr(),
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm8),
                Text(
                  'careers.open_application.subtitle'.tr(),
                  style: AppTextStyles.bodySmall,
                ),
              ],
            );

            final cta = SizedBox(
              width: narrow ? double.infinity : null,
              child: ElevatedButton(
                onPressed: () => context.push('/consultation'),
                child: Text('careers.open_application.cta'.tr()),
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
