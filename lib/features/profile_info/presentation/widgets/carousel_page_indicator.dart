import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';

class CarouselPageIndicator extends StatelessWidget {
  const CarouselPageIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
    required this.onTapIndex,
  }) : assert(count >= 0);

  final int count;
  final int activeIndex;
  final ValueChanged<int> onTapIndex;

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return GestureDetector(
          onTap: () => onTapIndex(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: active ? 18 : 7,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: active
                  ? AppColors.primary
                  : AppColors.textMuted.withValues(alpha: 0.45),
            ),
          ),
        );
      }),
    );
  }
}
