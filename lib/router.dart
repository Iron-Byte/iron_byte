import 'package:go_router/go_router.dart';
import 'package:iron_byte/features/main/presentation/screens/main_layout.dart';
import 'package:iron_byte/pages/about_page.dart';
import 'package:iron_byte/pages/careers_page.dart';
import 'package:iron_byte/pages/consultation_page.dart';
import 'package:iron_byte/pages/home_page.dart';
import 'package:iron_byte/pages/portfolio_page.dart';
import 'package:iron_byte/pages/services_page.dart';

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
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/portfolio',
              name: 'portfolio',
              builder: (context, state) => const PortfolioPage(),
            ),
            GoRoute(
              path: '/services',
              name: 'services',
              builder: (context, state) => const ServicesPage(),
            ),
            GoRoute(
              path: '/careers',
              name: 'careers',
              builder: (context, state) => const CareersPage(),
            ),
            GoRoute(
              path: '/about',
              name: 'about',
              builder: (context, state) => const AboutPage(),
            ),
            GoRoute(
              path: '/consultation',
              name: 'consultation',
              builder: (context, state) => const ConsultationPage(),
            ),
          ],
        ),
      ],
    );
  }
}
