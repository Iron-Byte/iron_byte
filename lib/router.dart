import 'package:go_router/go_router.dart';
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
      initialLocation: '/',
      redirect: (context, state) {
        if (state.uri.path == '/porfolio') {
          return '/portfolio';
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
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/portfolio',
              name: 'portfolio',
              builder: (context, state) => const PortfolioScreen(),
            ),
            GoRoute(
              path: '/services',
              name: 'services',
              builder: (context, state) => const ServicesScreen(),
            ),
            GoRoute(
              path: '/careers',
              name: 'careers',
              builder: (context, state) => const CareersScreen(),
            ),
            GoRoute(
              path: '/about',
              name: 'about',
              builder: (context, state) => const AboutScreen(),
            ),
            GoRoute(
              path: '/consultation',
              name: 'consultation',
              builder: (context, state) => const ConsultationScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
