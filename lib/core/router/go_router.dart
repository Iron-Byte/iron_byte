import 'package:go_router/go_router.dart';
import 'package:iron_byte/features/home/home.dart';
import 'package:iron_byte/features/main/presentation/screens/main_layout.dart';
import 'package:iron_byte/features/portfolio/portfolio.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      
      routes: <RouteBase>[
        ShellRoute(
          builder: (context, state, child) {
            return MainLayout(child: child);
          },
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
            GoRoute(
              path: '/porfolio',
              builder: (context, state) => const PortfolioScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
