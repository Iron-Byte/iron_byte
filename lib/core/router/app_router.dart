import 'package:go_router/go_router.dart';
import '../../features/main/main_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

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
       
      ],
    ),
  ],
);
