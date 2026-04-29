import 'package:flutter/material.dart';
import 'package:iron_byte/assets/assets.dart';
import 'package:iron_byte/core/common_widgets/image_carousel.dart';
import 'package:iron_byte/core/themes/themes.dart';

const _loremShort =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do '
    'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad '
    'minim veniam, quis nostrud exercitation ullamco laboris. Duis aute irure '
    'dolor in reprehenderit in voluptate velit esse cillum dolore.';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width >= 600 ? 32.0 : 20.0;

    /// [ClipRect]: keep adjacent slide art from painting over the text column.
    /// Peek carousel: viewportFraction plus scale keeps center slide large and sides smaller.
    final carousel = ClipRect(
      child: ImageCarousel(
        imagePaths: LanguageKitPaths.carousel,
        aspectRatio: 9.5 / 16,
        viewportFraction: 0.87,
        activeScaleBoost:  1.08,
        horizontalClipGutter: 6,
        precacheImages: true,
      ),
    );

    final textBlock = SelectableText(
      _loremShort,
      style: AppTextStyles.body.copyWith(
        color: AppColors.textPrimary,
        height: 1.45,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color:  AppColors.primary,
        borderRadius: AppRadius.borderMd12
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontal,
          padding.top + AppSpacing.lg16,
          horizontal,
          AppSpacing.xxl24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Language Kit',
              style: AppTextStyles.labelLarge.copyWith(fontSize: 20),
            ),
            const SizedBox(height: AppSpacing.lg16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Expanded(flex: 3, child: carousel),
                SizedBox(
                  width: width >= 480 ? AppSpacing.xxl24 : AppSpacing.sm8,
                ),
                Expanded(flex: 7, child: textBlock),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
