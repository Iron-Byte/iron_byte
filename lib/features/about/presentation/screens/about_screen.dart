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
    return Padding(
      padding: EdgeInsets.all(AppSpacing.padding32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: RichText(
                            maxLines: 5,
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Who we are \n',
                                  style: context.displayLarge!.copyWith(
                                    fontSize: 80,
                                    color: Colors.deepOrange,
                                    height: 1.3,
                                  ),
                                ),
                                TextSpan(
                                  text: 'about_explain'.tr(),
                                  style: context.displayMedium!.copyWith(
                                    fontSize: 35,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
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
                        Gap(AppSpacing.padding32),
                      ],
                    ),
                  ),
                ),
                const Gap(124),
                Expanded(child: CustomCarousel()),
              ],
            ),
          ),
          Gap(AppSpacing.padding32),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: AppSpacing.padding32,
              children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
