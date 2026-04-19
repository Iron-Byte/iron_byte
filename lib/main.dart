import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/router.dart';
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

class IronByteApp extends StatelessWidget {
  const IronByteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
        routerConfig: AppRouter.createRouter()),
    );
  }
}
