import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/utils/extensions.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Avoid fixed width (600) which can overflow on small screens.
        final maxWidth = mathMin(600.0, constraints.maxWidth);
        final padding = constraints.maxWidth < 600 ? 20.0 : 32.0;
        final gapTitle = constraints.maxWidth < 600 ? 16.0 : 28.0;

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.secondary.withValues(alpha: 0.30),
            ),
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title != null
                    ? Text(
                        title!,
                        style:
                            context.h3?.copyWith(fontWeight: FontWeight.w500),
                        maxLines: 6,
                      )
                    : const SizedBox(),
                Gap(gapTitle),
                if (description1 != null)
                  descriptionBuilder(
                    context: context,
                    icon: Icon(
                      Icons.check_circle_outline_rounded,
                      size: constraints.maxWidth < 600 ? 24 : 32,
                      color: AppColors.tealLight,
                    ),
                    description: description1!,
                  ),
                Gap(constraints.maxWidth < 600 ? 8 : 12),
                if (description2 != null)
                  descriptionBuilder(
                    context: context,
                    icon: Icon(
                      Icons.check_circle_outline_rounded,
                      size: constraints.maxWidth < 600 ? 24 : 32,
                      color: Colors.lightBlueAccent,
                    ),
                    description: description2!,
                  ),
                Gap(constraints.maxWidth < 600 ? 8 : 12),
                if (description3 != null)
                  descriptionBuilder(
                    context: context,
                    icon: Icon(
                      Icons.check_circle_outline_rounded,
                      size: constraints.maxWidth < 600 ? 24 : 32,
                      color: Colors.deepOrangeAccent,
                    ),
                    description: description3!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Small helper to avoid importing dart:math just for min.
double mathMin(double a, double b) => a < b ? a : b;
