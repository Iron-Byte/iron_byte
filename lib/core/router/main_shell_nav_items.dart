import 'package:flutter/foundation.dart';
import 'package:iron_byte/core/router/app_routes.dart';

/// Top-level shell destinations shown in the app bar (order = display order).
@immutable
class MainShellNavItem {
  const MainShellNavItem({
    required this.labelKey,
    required this.route,
  });

  final String labelKey;
  final String route;
}

const List<MainShellNavItem> kMainShellNavItems = <MainShellNavItem>[
  MainShellNavItem(labelKey: 'home', route: AppRoutes.home),
  MainShellNavItem(labelKey: 'portfolio', route: AppRoutes.portfolio),
  MainShellNavItem(labelKey: 'services', route: AppRoutes.services),
  MainShellNavItem(labelKey: 'careers', route: AppRoutes.careers),
  MainShellNavItem(labelKey: 'about', route: AppRoutes.about),
];
