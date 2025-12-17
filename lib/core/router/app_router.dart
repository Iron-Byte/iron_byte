import 'package:go_router/go_router.dart';
import '../../features/main/main_screen.dart';
import '../../features/main/screens/home_screen.dart';
import '../../features/main/screens/careers_screen.dart';
import '../../features/main/screens/services_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/careers',
          name: 'careers',
          builder: (context, state) => const CareersScreen(),
        ),
        GoRoute(
          path: '/services',
          name: 'services',
          builder: (context, state) => const ServicesScreen(),
        ),
      ],
    ),
  ],
);
