import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/navigation/home_scroll_coordinator.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/router/shell_nav_location.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/main/presentation/widgets/app_bar_nav_item.dart';

class MainLayoutCompactAppBarTitle extends StatelessWidget {
  const MainLayoutCompactAppBarTitle({super.key, required this.coordinator});

  final HomeScrollCoordinator? coordinator;

  @override
  Widget build(BuildContext context) {
    if (coordinator == null) {
      final loc = shellNavigationLocation(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg16),
        child: Row(
          children: [
            AppBarNavItem(
              label: 'iron_byte'.tr(),
              route: AppRoutes.home,
              currentLocation: loc,
              dense: true,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.consultation),
              child: Text('free_consulatation'.tr()),
            ),
            const SizedBox(width: AppSpacing.sm8),
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: const Icon(Icons.menu),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
        ),
      );
    }

    return ListenableBuilder(
      listenable: coordinator!,
      builder: (context, _) {
        final actualLoc = shellNavigationLocation(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg16),
          child: Row(
            children: [
              AppBarNavItem(
                label: 'iron_byte'.tr(),
                route: AppRoutes.home,
                currentLocation: actualLoc,
                dense: true,
                onPressed: () =>
                    coordinator!.onShellNavTap(context, AppRoutes.home),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.consultation);
                },
                child: Text('free_consulatation'.tr()),
              ),
              const SizedBox(width: AppSpacing.sm8),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: const Icon(Icons.menu),
                  tooltip: MaterialLocalizations.of(
                    context,
                  ).openAppDrawerTooltip,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
