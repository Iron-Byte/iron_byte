import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/portfolio/data/datasources/portfolio_local_datasource.dart';
import 'package:iron_byte/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:iron_byte/features/portfolio/domain/entities/portfolio_project.dart';
import 'package:iron_byte/features/portfolio/domain/usecases/get_portfolio_projects.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_bloc.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_event.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_state.dart';
import 'package:iron_byte/features/portfolio/presentation/widgets/project_image_slider.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  static const double _sliderHeight = 220;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioBloc(
        getPortfolioProjects: GetPortfolioProjects(
          PortfolioRepositoryImpl(PortfolioLocalDataSource()),
        ),
      )..add(LoadPortfolio()),
      child: const _PortfolioView(sliderHeight: _sliderHeight),
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView({required this.sliderHeight});

  final double sliderHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(
              child: Padding(
                padding: AppSpacing.allXxl24,
                child: Text(message, style: AppTextStyles.body),
              ),
            ),
            loaded: (projects) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final maxW = constraints.maxWidth;
                  final padH = maxW >= 720 ? 48.0 : 24.0;
                  final crossAxisCount = maxW >= 1000
                      ? 3
                      : maxW >= 600
                          ? 2
                          : 1;

                  const cardMainExtent = 400.0;

                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          padH,
                          AppSpacing.xxl24,
                          padH,
                          AppSpacing.lg16,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Portfolio',
                                style: AppTextStyles.hero.copyWith(
                                  fontFamily: 'Cinzel',
                                  fontSize: maxW >= 600 ? 36 : 28,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm8),
                              Text(
                                'portfolio.subtitle'.tr(),
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          padH,
                          0,
                          padH,
                          AppSpacing.huge36,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: AppSpacing.lg16,
                            crossAxisSpacing: AppSpacing.lg16,
                            mainAxisExtent: cardMainExtent,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return _PortfolioProjectCard(
                                project: projects[index],
                                sliderHeight: sliderHeight,
                              );
                            },
                            childCount: projects.length,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _PortfolioProjectCard extends StatelessWidget {
  const _PortfolioProjectCard({
    required this.project,
    required this.sliderHeight,
  });

  final PortfolioProject project;
  final double sliderHeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.35),
      borderRadius: AppRadius.borderMd12,
      child: ClipRRect(
        borderRadius: AppRadius.borderMd12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm8),
              child: ClipRRect(
                borderRadius: AppRadius.borderSm8,
                child: ProjectImageSlider(
                  imagePaths: project.imagePaths,
                  height: sliderHeight,
                ),
              ),
            ),
            Padding(
              padding: AppSpacing.hMd12.add(AppSpacing.vSm8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (project.description.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm8),
                    Text(
                      project.description,
                      style: AppTextStyles.bodySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
