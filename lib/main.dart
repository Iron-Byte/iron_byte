import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/navigation/home_scroll_coordinator.dart';
import 'package:iron_byte/core/router/app_router.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'features/home/home.dart';
import 'features/main/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: IronByteApp(),
    ),
  );
}

class IronByteApp extends StatefulWidget {
  const IronByteApp({super.key});

  @override
  State<IronByteApp> createState() => _IronByteAppState();
}

class _IronByteAppState extends State<IronByteApp> {
  late final HomeScrollCoordinator _homeScrollCoordinator;

  @override
  void initState() {
    super.initState();
    _homeScrollCoordinator = HomeScrollCoordinator();
  }

  @override
  void dispose() {
    _homeScrollCoordinator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScrollScope(
      coordinator: _homeScrollCoordinator,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(
            create: (context) => MainBloc()..add(LoadMain()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc()..add(LoadHome()),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.dark,
          scrollBehavior: const AppScrollBehavior(),
          routerConfig: AppRouter.createRouter(),
        ),
      ),
    );
  }
}

/// App-wide scroll behavior with no edge glow/stretch indicators.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.mouse,
  };

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Remove glow/stretch/edge hints globally.
    return child;
  }
}
