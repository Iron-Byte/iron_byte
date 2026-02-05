import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/core/utils/assets.dart';
import 'package:iron_byte/core/utils/extensions.dart';
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
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            carouselController: controller,
            options: CarouselOptions(
              height: context.height,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              viewportFraction: 0.55,
              onPageChanged: (index, reason) {
                setState(() => currentIndex = index);
              },
            ),
            items: images.map((imagePath) {
              return SizedBox(
                // margin: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.padding12),
                  child: imagePath.render(fit: BoxFit.cover,),
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
  }
}
