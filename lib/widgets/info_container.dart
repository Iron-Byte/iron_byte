import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/sizes.dart';

class InfoContainer extends StatelessWidget {
  final Widget? cardItem;
  final String? cardTitle;
  final String? cardDescription;
  final VoidCallback? onTap;

  const InfoContainer({
    super.key,
    this.cardItem,
    this.cardTitle,
    this.cardDescription,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.padding24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.secondary.withValues(alpha: 0.30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cardItem != null)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.dirtyWhite,
                  borderRadius: BorderRadius.circular(AppSpacing.padding12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.padding8),
                  child: cardItem,
                ),
              ),
            ...[
              Gap(AppSpacing.padding16),
              if (cardTitle != null)
                Text(maxLines: 3, cardTitle!, style: context.titleL),
            ],
            ...[
              if (cardDescription != null) Gap(AppSpacing.padding16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(  
                    maxLines: 5,
                    cardDescription!,
                    style: context.titleM!.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
