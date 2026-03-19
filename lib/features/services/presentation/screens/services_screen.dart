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
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortestSide = MediaQuery.sizeOf(context).shortestSide;

        // Breakpoints: mobile / tablet / desktop
        final isMobile = shortestSide < 600;
        final isTablet = !isMobile && shortestSide < 1024;

        final horizontalPadding = isMobile ? 16.0 : isTablet ? 40.0 : 80.0;
        final titleFontSize = isMobile ? 26.0 : isTablet ? 32.0 : 35.0;

        final crossAxisCount = isMobile ? 1 : isTablet ? 2 : 3;
        final spacing = isMobile ? 18.0 : isTablet ? 32.0 : 50.0;
        final mainAxisExtent = isMobile ? 240.0 : isTablet ? 260.0 : 280.0;

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 16.0 : 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap(AppSpacing.padding16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      'ourServices'.tr(),
                      style: context.displayLarge!.copyWith(
                        fontSize: titleFontSize,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                ),
                Gap(AppSpacing.padding16),
                Text(
                  'weBring'.tr(),
                  style: context.titleL,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                Gap(isMobile ? AppSpacing.padding16 : AppSpacing.padding32),
                Center(
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(isMobile ? 12 : 20),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      mainAxisExtent: mainAxisExtent,
                    ),
                    children: [
                      InfoContainer(
                        cardItem:
                            AppAssets.planet.svg(height: 40, width: 40),
                        cardTitle: 'serviceTitles.webdesign'.tr(),
                        cardDescription:
                            'serviseDescription.responsiveWebsites'.tr(),
                        onTap: () {},
                      ),
                      InfoContainer(
                        cardItem: AppAssets.smartphone.svg(
                            height: 40, width: 40),
                        cardTitle:
                            'serviceTitles.mobileDevelopment'.tr(),
                        cardDescription:
                            'serviseDescription.nativeAndCrossPlatform'.tr(),
                        onTap: () {},
                      ),
                      InfoContainer(
                        cardItem: AppAssets.animation.svg(
                            height: 40, width: 40),
                        cardTitle: 'serviceTitles.animations'.tr(),
                        cardDescription:
                            'serviseDescription.eyeCatchingAnimations'.tr(),
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
                        cardDescription:
                            'serviseDescription.eCommerceSolutions'.tr(),
                        onTap: () {},
                      ),
                      InfoContainer(
                        cardItem: AppAssets.brand.svg(
                            height: 40, width: 40),
                        cardTitle: 'serviceTitles.brand'.tr(),
                        cardDescription:
                            'serviseDescription.brandIdentity'.tr(),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
