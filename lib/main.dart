import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/router/go_router.dart';
import 'features/home/home.dart';
import 'features/main/main.dart';

void main() {
  runApp(IronByteApp());
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

      child: MaterialApp.router(routerConfig: AppRouter.createRouter()),
    );
  }
}
