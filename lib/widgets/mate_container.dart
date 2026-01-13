import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/extensions.dart';
import 'package:iron_byte/core/theme/app_theme.dart';

class MateContainer extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? description1;
  final String? description2;
  final String? description3;
  const MateContainer({
    super.key,
    this.title,
    this.subtitle,
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
        Text(description, style: context.h2?.copyWith(color: Colors.black)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.secondary.withValues(alpha: 0.70),
     
      ),
      padding: EdgeInsets.all(32),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(title!, style: context.h1?.copyWith(color: Colors.black))
              : SizedBox(),
          Gap(22),
          subtitle != null
              ? Text(
                  subtitle!,
                  style: context.h2?.copyWith(color: Colors.black),
                )
              : SizedBox(),
          Gap(22),
          if (description1 != null)
            descriptionBuilder(
              context: context,
              icon: Icon(Icons.check_rounded, color: Colors.black),
              description: description1!,
            ),
          if (description2 != null)
            descriptionBuilder(
              context: context,
              icon: Icon(Icons.check_rounded, color: Colors.black),
              description: description2!,
            ),

          if (description3 != null)
            descriptionBuilder(
              context: context,
              icon: Icon(Icons.check_rounded, color: Colors.black),
              description: description3!,
            ),
        ],
      ),
    );
  }
}
