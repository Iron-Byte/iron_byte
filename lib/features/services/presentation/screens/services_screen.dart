import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/utils/assets.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/sizes.dart';
import 'package:iron_byte/widgets/info_container.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(AppSpacing.padding16),
          Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              'ourServices'.tr(),
              style: context.displayLarge!.copyWith(
                fontSize: 35,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ),
          Gap(AppSpacing.padding16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width / 4),
            child: Text(
              'weBring'.tr(),
              style: context.titleL,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSpacing.padding32),
            child: Center(
              child: GridView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 50,
                  mainAxisExtent: context.height / 3,
                ),
                children: [
                  InfoContainer(
                    cardItem: AppAssets.planet.svg(height: 40, width: 40),
                    cardTitle: 'serviceTitles.webdesign'.tr(),
                    cardDescription: 'serviseDescription.responsiveWebsites'.tr(),
                    onTap: () {},
                  ),
                  InfoContainer(
                    cardItem: AppAssets.smartphone.svg(height: 40, width: 40),
                    cardTitle: 'serviceTitles.mobileDevelopment'.tr(),
                    cardDescription: 'serviseDescription.nativeAndCrossPlatform'.tr(),

                    onTap: () {},
                  ),
                  InfoContainer(
                    cardItem: AppAssets.animation.svg(height: 40, width: 40),
                    cardTitle: 'serviceTitles.animations'.tr(),
                    cardDescription: 'serviseDescription.eyeCatchingAnimations'.tr(),

                    onTap: () {},
                  ),
                  InfoContainer(
                    cardItem: AppAssets.paint.svg(height: 40, width: 40),
                    cardTitle: 'serviceTitles.design'.tr(),
                    cardDescription: 'serviseDescription.uiuxDesign'.tr(),

                    onTap: () {},
                  ),
                  InfoContainer(
                    cardItem: AppAssets.bag.svg(height: 40, width: 40),
                    cardTitle: 'serviceTitles.eCommerce'.tr(),
                    cardDescription: 'serviseDescription.eCommerceSolutions'.tr(),
                    onTap: () {},
                  ),
                  InfoContainer(
                    cardItem: AppAssets.brand.svg(height: 40, width: 40),
                    cardTitle: 'serviceTitles.brand'.tr(),
                    cardDescription: 'serviseDescription.brandIdentity'.tr(),

                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
