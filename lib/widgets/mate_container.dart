import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/extensions.dart';
import 'package:iron_byte/core/theme/app_theme.dart';

class MateContainer extends StatelessWidget {
  final String? title;
  final String? description1;
  final String? description2;
  final String? description3;
  const MateContainer({
    super.key,
    this.title,
    this.description1,
    this.description2,
    this.description3,
  });

  Widget descriptionBuilder({
    required BuildContext context,
    required Widget icon,
    required String description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        Gap(12),
        Text(
          description,
          style: context.titleL?.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.secondary.withValues(alpha: 0.30),
      ),
      padding: EdgeInsets.all(32),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  title!,
                  style: context.h3?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 6,
                )
              : SizedBox(),
          Gap(28),
          if (description1 != null)
            descriptionBuilder(
              context: context,
              icon: Icon(
                Icons.check_circle_outline_rounded,
                size: 32,
                color: AppColors.tealLight,
              ),
              description: description1!,
            ),
          Gap(12),
          if (description2 != null)
            descriptionBuilder(
              context: context,
              icon: Icon(
                Icons.check_circle_outline_rounded,
                size: 32,
                color: Colors.lightBlueAccent,
              ),
              description: description2!,
            ),
          Gap(12),
          if (description3 != null)
            descriptionBuilder(
              context: context,
              icon: Icon(
                Icons.check_circle_outline_rounded,
                size: 32,
                color: Colors.deepOrangeAccent,
              ),
              description: description3!,
            ),
        ],
      ),
    );
  }
}
