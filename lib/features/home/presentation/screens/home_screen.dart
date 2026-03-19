import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/widgets/filling_form.dart';

import 'package:iron_byte/widgets/mate_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Breakpoints: mobile / tablet / desktop
        final isMobile = width < 1280;
        final isTablet = width >= 600 && width < 1280;

        final horizontalPadding = isMobile ? 16.0 : isTablet ? 48.0 : 80.0;
        final verticalPadding = isMobile ? 24.0 : 32.0;

        final visionFont = isMobile ? 52.0 : isTablet ? 70.0 : 80.0;
        final ourFont = isMobile ? 42.0 : isTablet ? 55.0 : 65.0;
        final innovativeFont = isMobile ? 52.0 : isTablet ? 70.0 : 80.0;
        final solutionsFont = isMobile ? 42.0 : isTablet ? 55.0 : 65.0;

        final hero = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Your Vision \n',
                    style: context.displayLarge!.copyWith(
                      fontSize: visionFont,
                      color: Colors.deepOrange,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: 'Our',
                    style: context.displayMedium!.copyWith(
                      fontSize: ourFont,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: ' Innovative',
                    style: context.displayMedium!.copyWith(
                      fontSize: innovativeFont,
                      color: Colors.deepOrange,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: ' solutions',
                    style: context.displayMedium!.copyWith(
                      fontSize: solutionsFont,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            MateContainer(
              title: 'weBring'.tr(),
              description1: '24/7 client and app support',
              description2: 'Fast Turnaround Time',
              description3: '1 hour Free Consultation',
            ),
          ],
        );

        final formCard = Container(
          decoration: BoxDecoration(
            color: AppColors.tealLight.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: const FillingForm(),
        );

        final content = isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hero,
                  const SizedBox(height: 64),
                  formCard,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Give hero more space on wide screens.
                  Flexible(flex: 3, child: hero),
                  SizedBox(width: isTablet ? 32 : 64),
                  Flexible(flex: 2, child: formCard),
                ],
              );

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: content,
          ),
        );
      },
    );
  }
}
