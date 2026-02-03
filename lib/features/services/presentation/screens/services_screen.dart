import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
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
            padding: EdgeInsets.symmetric(horizontal: context.width / 4 ,),
            child: Text('weBring'.tr(), style: context.titleL, maxLines: 3, textAlign: TextAlign.center,),
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
                  // maxCrossAxisExtent: context.width / 3.5,
                  mainAxisExtent: context.height / 3,
                ),
                children: [
                  InfoContainer(
                    cardItem: AppAssets.planet.svg(height: 20, width: 20),
                    onTap: () {}),
                  InfoContainer(onTap: () {}),
                  InfoContainer(onTap: () {}),
                  InfoContainer(onTap: () {}),
                  InfoContainer(onTap: () {}),
                  InfoContainer(onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
