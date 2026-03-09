import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/core/utils/assets.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/sizes.dart';
import 'package:iron_byte/features/about/presentation/widgets/rate_stars_widget.dart';

class CleintReviewContainer extends StatelessWidget {
  final String? image;
  final String clientName;
  final String clientReview;
  final int clientRate;
  const CleintReviewContainer({
    super.key,
    this.image,
    required this.clientName,
    required this.clientReview,
    required this.clientRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.padding12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.padding12),
        color: AppColors.tealLight.withValues(alpha: 0.33),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RateStarsWidget(rateCount: clientRate),
          const Gap(AppSpacing.padding12),
          Text(clientReview, style: context.bodyM),
          const Gap(AppSpacing.padding12),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.tealLight,
                backgroundImage: AssetImage(AppAssets.teamImage),
              ),
              Gap(AppSpacing.padding12),
              Text(clientName, style: context.bodyL),
            ],
          ),
        ],
      ),
    );
  }
}
