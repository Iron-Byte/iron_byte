import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/main/presentation/bloc/main_bloc.dart';
import 'package:iron_byte/features/main/presentation/bloc/main_state.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(height: 1.5, color: AppColors.borderSurface),
        ),
        title: Padding(
          padding: AppSpacing.allXxxl32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: AppSpacing.xxxl32,
                    width: AppSpacing.xxxl32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppRadius.borderXs6,
                    ),
                    child: Center(
                      child: Text('IB', style: AppTextStyles.labelLarge),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: Text(
                      'iron_byte'.tr(),
                      style: AppTextStyles.labelLarge.copyWith(
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: Text('home'.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/portfolio');
                    },
                    child: Text('portfolio'.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/services');
                    },
                    child: Text('services'.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/careers');
                    },
                    child: Text('careers'.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/about');
                    },
                    child: Text('about'.tr()),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/consultation');
                },
                child: Text('free_consulatation'.tr()),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Padding(padding: AppSpacing.allXxxl32, child: child);
        },
      ),
    );
  }
}
