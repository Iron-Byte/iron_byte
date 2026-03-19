import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/core/utils/assets.dart';
import 'package:iron_byte/core/utils/sizes.dart'; // Ensure this path is correct

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final CarouselSliderController controller = CarouselSliderController();

  // These are now correctly identified as WebP and JPG in assets.dart
  final List<String> images = [AppAssets.teamImage, AppAssets.ilustration];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // The old implementation used `context.height`, which breaks on
        // short viewports (landscape web/tablet) and caused overflows.
        // Here we compute a safe carousel height from available constraints.
        final mq = MediaQuery.sizeOf(context);
        final maxH = constraints.maxHeight.isFinite && constraints.maxHeight > 0
            ? constraints.maxHeight
            : mq.height;

        // Respect the available height from the parent.
        // Clamped to keep the carousel usable without overflowing.
        final carouselHeight = maxH.clamp(180.0, 420.0);

        return Column(
          children: [
            SizedBox(
              height: carouselHeight,
              child: CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  height: carouselHeight,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  viewportFraction: 0.6,
                  onPageChanged: (index, reason) {
                    setState(() => currentIndex = index);
                  },
                ),
                items: images.map((imagePath) {
                  return SizedBox(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.padding12),
                      child: imagePath.render(
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == entry.key
                        ? AppColors.tealLight
                        : AppColors.dirtyWhite,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
