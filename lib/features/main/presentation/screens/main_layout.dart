import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/features/main/presentation/bloc/main_bloc.dart';
import 'package:iron_byte/features/main/presentation/bloc/main_state.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,

          children: [
            TextButton(onPressed: () {}, child: Text('Iron Byte')),
            TextButton(onPressed: () {}, child: Text('What we do')),

            TextButton(onPressed: () {}, child: Text('Contact us')),

           
          ],
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return child;
        },
      ),
    );
  }
}
