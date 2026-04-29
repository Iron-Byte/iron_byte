import 'package:flutter/material.dart';
import 'package:iron_byte/assets/assets.dart';
import 'package:iron_byte/core/common_widgets/image_carousel.dart';
import 'package:iron_byte/core/themes/themes.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width >= 600 ? 32.0 : 20.0;

    /// [ClipRect]: keep adjacent slide art from painting over the text column.
    /// Peek carousel: viewportFraction plus scale keeps center slide large and sides smaller.
    final carousel = ImageCarousel(
      imagePaths: LanguageKitPaths.carousel,
      aspectRatio: 9.5 / 16,
      viewportFraction: 0.87,
      activeScaleBoost: 1.08,
      horizontalClipGutter: 6,
      precacheImages: true,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: AppRadius.borderLg16,
        color: AppColors.surface,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontal,
          padding.top + AppSpacing.lg16,
          horizontal,
          padding.bottom + AppSpacing.lg16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                carousel,
                SizedBox(
                  width: width >= 480 ? AppSpacing.xxl24 : AppSpacing.sm8,
                ),
                Expanded(
                  child: ProjectInfoWidget(
                    appName: 'Language Kit',
                    appDescription: 'some desc',
                    appDownloads: '200',
                    appRate: '4/5',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectInfoWidget extends StatelessWidget {
  final String appName;
  final String appDescription;
  final String appDownloads;
  final String appRate;

  const ProjectInfoWidget({
    super.key,
    required this.appName,
    required this.appDescription,
    required this.appDownloads,
    required this.appRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appName, style: AppTextStyles.hero.copyWith(fontFamily: 'Cinzel')),
        const SizedBox(height: AppSpacing.sm8),
        Text(appDescription, style: AppTextStyles.body),
        const SizedBox(height: AppSpacing.sm8),
        Text('Downloads: $appDownloads', style: AppTextStyles.bodySmall),
        Text('Rate: $appRate', style: AppTextStyles.bodySmall),
      ],
    );
  }
}
