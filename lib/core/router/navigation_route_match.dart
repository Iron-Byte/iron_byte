import 'app_routes.dart';

/// Pure route matching for shell navigation (no BuildContext — easy to test).
abstract final class NavigationRouteMatch {
  NavigationRouteMatch._();

  /// Whether [currentLocation] should highlight the nav item for [routePath].
  ///
  /// Home (`/`) matches only exactly `/` so `/consultation` does not activate Home.
  static bool isRouteActive({
    required String currentLocation,
    required String routePath,
  }) {
    final loc = currentLocation.isEmpty ? '/' : currentLocation;
    if (routePath == AppRoutes.home) {
      return loc == '/';
    }
    return loc == routePath || loc.startsWith('$routePath/');
  }
}
