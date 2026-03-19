import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/sizes.dart';
import 'package:iron_byte/widgets/info_container.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortestSide = MediaQuery.sizeOf(context).shortestSide;
        final isMobile = shortestSide < 600;
        final isTablet = !isMobile && shortestSide < 1024;

        final horizontalPadding = isMobile ? 16.0 : isTablet ? 40.0 : 80.0;
        final verticalPadding = isMobile ? 16.0 : 24.0;

        final crossAxisCount = isMobile ? 1 : isTablet ? 2 : 3;
        final spacing = isMobile ? 16.0 : 32.0;
        final mainAxisExtent = isMobile ? 220.0 : 250.0;

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap(AppSpacing.padding16),
                Text(
                  'Portfolio',
                  style: context.displayLarge!.copyWith(
                    fontSize: isMobile ? 28 : isTablet ? 36 : 40,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(AppSpacing.padding16),
                GridView(
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
                      cardItem: const Icon(Icons.web, size: 36),
                      cardTitle: 'Web Design',
                      cardDescription: 'Modern responsive layouts (coming soon)',
                      onTap: () {},
                    ),
                    InfoContainer(
                      cardItem: const Icon(Icons.phone_android, size: 36),
                      cardTitle: 'Mobile Apps',
                      cardDescription: 'iOS/Android projects (coming soon)',
                      onTap: () {},
                    ),
                    InfoContainer(
                      cardItem: const Icon(Icons.animation, size: 36),
                      cardTitle: 'Animations',
                      cardDescription: 'Neon & glass UI demos (coming soon)',
                      onTap: () {},
                    ),
                    InfoContainer(
                      cardItem: const Icon(Icons.shopping_bag, size: 36),
                      cardTitle: 'E-Commerce',
                      cardDescription: 'Product pages and flows (coming soon)',
                      onTap: () {},
                    ),
                    InfoContainer(
                      cardItem: const Icon(Icons.branding_watermark, size: 36),
                      cardTitle: 'Brand Identity',
                      cardDescription: 'Design systems (coming soon)',
                      onTap: () {},
                    ),
                    InfoContainer(
                      cardItem: const Icon(Icons.grid_view, size: 36),
                      cardTitle: 'UI Kit',
                      cardDescription: 'Reusable components (coming soon)',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}