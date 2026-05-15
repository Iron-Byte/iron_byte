import 'package:flutter/material.dart';
import 'package:iron_byte/core/navigation/home_scroll_coordinator.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/router/main_shell_nav_items.dart';
import 'package:iron_byte/core/router/navigation_route_match.dart';
import 'package:iron_byte/core/router/shell_nav_location.dart';
import 'package:iron_byte/core/themes/themes.dart';

class MainLayoutNavDrawer extends StatelessWidget {
  const MainLayoutNavDrawer({super.key, required this.coordinator});

  final HomeScrollCoordinator? coordinator;

  @override
  Widget build(BuildContext context) {
    Widget drawerBody(String highlight) {
      return ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg16,
          vertical: AppSpacing.md12,
        ),
        children: [
          ListTile(
            title: Text('iron_byte'.tr()),
            selected: NavigationRouteMatch.isRouteActive(
              currentLocation: highlight,
              routePath: AppRoutes.home,
            ),
            onTap: () {
              coordinator?.onShellNavTap(context, AppRoutes.home);
              Navigator.of(context).pop();
            },
          ),
          for (final item in kMainShellNavItems)
            ListTile(
              title: Text(item.labelKey.tr()),
              selected: NavigationRouteMatch.isRouteActive(
                currentLocation: highlight,
                routePath: item.route,
              ),
              onTap: () {
                coordinator?.onShellNavTap(context, item.route);
                Navigator.of(context).pop();
              },
            ),
        ],
      );
    }

    if (coordinator == null) {
      return Drawer(
        child: SafeArea(child: drawerBody(shellNavigationLocation(context))),
      );
    }

    return ListenableBuilder(
      listenable: coordinator!,
      builder: (context, _) {
        final highlight = shellNavHighlightLocation(context, coordinator!);
        return Drawer(child: SafeArea(child: drawerBody(highlight)));
      },
    );
  }
}
