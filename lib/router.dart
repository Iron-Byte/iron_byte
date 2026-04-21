import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/features/home/home.dart';
import 'package:iron_byte/features/main/presentation/screens/main_layout.dart';
import 'package:iron_byte/features/portfolio/portfolio.dart';
import 'package:iron_byte/screens/about_screen.dart';
import 'package:iron_byte/screens/careers_screen.dart';
import 'package:iron_byte/screens/consultation_screen.dart';
import 'package:iron_byte/screens/services_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.home,
      redirect: (context, state) {
        if (state.uri.path == '/porfolio') {
          return AppRoutes.portfolio;
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
              path: AppRoutes.portfolio,
              name: 'portfolio',
              builder: (context, state) => const PortfolioScreen(),
            ),
            GoRoute(
              path: AppRoutes.services,
              name: 'services',
              builder: (context, state) => const ServicesScreen(),
            ),
            GoRoute(
              path: AppRoutes.careers,
              name: 'careers',
              builder: (context, state) => const CareersScreen(),
            ),
            GoRoute(
              path: AppRoutes.about,
              name: 'about',
              builder: (context, state) => const AboutScreen(),
            ),
            GoRoute(
              path: AppRoutes.consultation,
              name: 'consultation',
              builder: (context, state) => const ConsultationScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
