import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/core/utils/assets.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/sizes.dart';
import 'package:iron_byte/features/about/presentation/widgets/cleint_review_container.dart';
import 'package:iron_byte/features/about/presentation/widgets/custom_carousel.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortestSide = MediaQuery.sizeOf(context).shortestSide;

        // Breakpoints
        final isMobile = shortestSide < 600;
        final isTablet = !isMobile && shortestSide < 1024;

        final outerPadding =
            EdgeInsets.all(isMobile ? AppSpacing.padding16 : AppSpacing.padding32);
        final gap = isMobile ? 16.0 : AppSpacing.padding32.toDouble();

        final whoFontSize = isMobile ? 56.0 : isTablet ? 72.0 : 80.0;
        final explainFontSize = isMobile ? 22.0 : isTablet ? 28.0 : 35.0;

        // Reserve a safe height for the carousel to prevent overflows.
        final carouselSlotHeight = isMobile ? 320.0 : isTablet ? 360.0 : 420.0;

        final whoSection = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              maxLines: isMobile ? 4 : 5,
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Who we are \n',
                    style: context.displayLarge!.copyWith(
                      fontSize: whoFontSize,
                      color: Colors.deepOrange,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: 'about_explain'.tr(),
                    style: context.displayMedium!.copyWith(
                      fontSize: explainFontSize,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
            Gap(AppSpacing.padding16),
            Text(
              'about_topic'.tr(),
              style: context.titleL!.copyWith(
                fontWeight: FontWeight.w300,
                color: AppColors.dirtyWhite,
              ),
            ),
          ],
        );

        final reviews = [
          CleintReviewContainer(
            image: AppAssets.teamImage,
            clientName: 'John',
            clientRate: 4,
            clientReview: 'Very good team',
          ),
          CleintReviewContainer(
            image: AppAssets.teamImage,
            clientName: 'John',
            clientRate: 4,
            clientReview: 'Very good team',
          ),
          CleintReviewContainer(
            image: AppAssets.teamImage,
            clientName: 'John',
            clientRate: 4,
            clientReview: 'Very good team',
          ),
          CleintReviewContainer(
            image: AppAssets.teamImage,
            clientName: 'John',
            clientRate: 4,
            clientReview: 'Very good team',
          ),
          CleintReviewContainer(
            image: AppAssets.teamImage,
            clientName: 'John',
            clientRate: 4,
            clientReview: 'Very good team',
          ),
          CleintReviewContainer(
            image: AppAssets.teamImage,
            clientName: 'John',
            clientRate: 4,
            clientReview: 'Very good team',
          ),
          CleintReviewContainer(
            image: AppAssets.teamImage,
            clientName: 'John',
            clientRate: 4,
            clientReview: 'Very good team',
          ),
          CleintReviewContainer(
            image: AppAssets.teamImage,
            clientName: 'John',
            clientRate: 4,
            clientReview: 'Very good team',
          ),
        ];

        return SafeArea(
          child: SingleChildScrollView(
            padding: outerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section: responsive row/column
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          whoSection,
                          SizedBox(height: gap),
                          SizedBox(
                            height: carouselSlotHeight,
                            width: double.infinity,
                            child: CustomCarousel(),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: whoSection),
                          SizedBox(width: isTablet ? 48.0 : 124.0),
                          Expanded(
                            child: SizedBox(
                              height: carouselSlotHeight,
                              child: CustomCarousel(),
                            ),
                          ),
                        ],
                      ),
                Gap(AppSpacing.padding32),

                // Reviews: wrap on small screens, horizontal scroll on wide screens.
                isMobile
                    ? Wrap(
                        spacing: AppSpacing.padding16.toDouble(),
                        runSpacing: AppSpacing.padding16.toDouble(),
                        children: reviews
                            .map(
                              (w) => SizedBox(
                                width: (shortestSide / 2) - 24,
                                child: w,
                              ),
                            )
                            .toList(),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: AppSpacing.padding32,
                          children: reviews,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
