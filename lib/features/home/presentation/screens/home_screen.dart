import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/widgets/filling_form.dart';

import 'package:iron_byte/widgets/mate_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(35),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Your Vision \n',
                        style: context.displayLarge!.copyWith(
                          fontSize: 80,
                          color: Colors.deepOrange,
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text: 'Our',
                        style: context.displayMedium!.copyWith(
                          fontSize: 65,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      TextSpan(
                        text: ' Innovative',
                        style: context.displayMedium!.copyWith(
                          fontSize: 80,
                          color: Colors.deepOrange,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      TextSpan(
                        text: ' solutions',
                        style: context.displayMedium!.copyWith(
                          fontSize: 65,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(55),
                MateContainer(
                  title: 'weBring'.tr(),
                  description1: '24/7 client and app support',
                  description2: 'Fast Turnaround Time',
                  description3: '1 hour Free Consultation',
                ),
              ],
            ),
            const Gap(122),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.tealLight.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: context.height,
                width: context.width,
                child: FillingForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
