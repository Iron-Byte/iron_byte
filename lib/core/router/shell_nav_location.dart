import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Current shell path for comparing against [AppRoutes].
///
/// Uses [GoRouterState.of] so widgets rebuild when the route changes.
/// (`GoRouter.of(context).location` is not available in go_router 17;
/// [GoRouterState.matchedLocation] is the supported equivalent.)
String shellNavigationLocation(BuildContext context) {
  final loc = GoRouterState.of(context).matchedLocation;
  return loc.isEmpty ? '/' : loc;
}
