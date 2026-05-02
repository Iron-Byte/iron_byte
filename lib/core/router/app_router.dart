import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/router/consultation_route_extra.dart';
import 'package:iron_byte/features/consultation_item/presentation/pages/consultation_page.dart';
import 'package:iron_byte/features/home/home.dart';
import 'package:iron_byte/features/main/presentation/screens/main_layout.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.home,
      routerNeglect: true,
      redirect: (context, state) {
        final path = state.uri.path;
        if (path == '/porfolio') {
          return AppRoutes.home;
        }
        if (path == AppRoutes.portfolio ||
            path == AppRoutes.services ||
            path == AppRoutes.careers ||
            path == AppRoutes.about) {
          return AppRoutes.home;
        }
        return null;
      },
      routes: <RouteBase>[
        ShellRoute(
          builder: (context, state, child) {
            return MainLayout(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: AppRoutes.consultation,
              name: 'consultation',
              builder: (context, state) {
                final extra = state.extra;
                final routeExtra = extra is ConsultationRouteExtra
                    ? extra
                    : null;
                return ConsultationPage(
                  selectedServiceName: routeExtra?.serviceName,
                  isJobApplication: routeExtra?.isJobApplication ?? false,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
