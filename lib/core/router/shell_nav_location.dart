import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/navigation/home_scroll_coordinator.dart';
import 'package:iron_byte/core/router/app_routes.dart';

/// Current shell path for comparing against [AppRoutes].
///
/// Uses [GoRouterState.of] so widgets rebuild when the route changes.
/// (`GoRouter.of(context).location` is not available in go_router 17;
/// [GoRouterState.matchedLocation] is the supported equivalent.)
String shellNavigationLocation(BuildContext context) {
  final loc = GoRouterState.of(context).matchedLocation;
  return loc.isEmpty ? '/' : loc;
}

/// App-bar highlight while on the main single-page shell (scroll spy).
///
/// On [consultation], returns the real location so no main tab appears selected.
/// On home (`/`), uses scroll-spy [HomeScrollCoordinator.navHighlightPath].
String shellNavHighlightLocation(
  BuildContext context,
  HomeScrollCoordinator coordinator,
) {
  final loc = shellNavigationLocation(context);
  if (loc == AppRoutes.consultation) return loc;
  return coordinator.navHighlightPath;
}
