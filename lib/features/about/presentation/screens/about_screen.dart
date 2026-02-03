import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/sizes.dart';
import 'package:iron_byte/features/about/presentation/widgets/custom_carousel.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.padding32),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
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
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                 Expanded(child: CustomCarousel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
