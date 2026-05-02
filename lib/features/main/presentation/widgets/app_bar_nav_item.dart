import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/router/navigation_route_match.dart';
import 'package:iron_byte/core/themes/themes.dart';

/// App bar link: highlights when [currentLocation] matches [route].
class AppBarNavItem extends StatelessWidget {
  const AppBarNavItem({
    super.key,
    required this.label,
    required this.route,
    required this.currentLocation,
    this.dense = false,
    this.onPressed,
  });

  final String label;
  final String route;
  final String currentLocation;

  /// When set, called instead of [context.go(route)] (e.g. Home / Portfolio).
  final VoidCallback? onPressed;

  /// Tighter padding for the brand / logo text button.
  final bool dense;

  static const _animDuration = Duration(milliseconds: 220);

  @override
  Widget build(BuildContext context) {
    final active = NavigationRouteMatch.isRouteActive(
      currentLocation: currentLocation,
      routePath: route,
    );
    final activeColor = AppColors.textPrimarybrand;
    final inactiveColor = AppColors.textMuted;

    final baseStyle = dense ? AppTextStyles.labelLarge : AppTextStyles.label;

    return TextButton(
      onPressed: onPressed ?? () => context.go(route),
      style: TextButton.styleFrom(
        padding: dense
            ? const EdgeInsets.symmetric(horizontal: 8)
            : const EdgeInsets.symmetric(horizontal: 12),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: AnimatedDefaultTextStyle(
        duration: _animDuration,
        curve: Curves.easeOutCubic,
        style: baseStyle.copyWith(
          color: active ? activeColor : inactiveColor,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          letterSpacing: dense ? 0 : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: _animDuration,
              curve: Curves.easeOutCubic,
              height: 2,
              width: active ? 22 : 0,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
