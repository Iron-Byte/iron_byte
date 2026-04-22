import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/portfolio/data/datasources/portfolio_local_datasource.dart';
import 'package:iron_byte/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:iron_byte/features/portfolio/domain/usecases/get_portfolio_projects.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_bloc.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_event.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_state.dart';
import 'package:iron_byte/features/portfolio/presentation/widgets/portfolio_project_row.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioBloc(
        getPortfolioProjects: GetPortfolioProjects(
          PortfolioRepositoryImpl(PortfolioLocalDataSource()),
        ),
      )..add(LoadPortfolio()),
      child: const _PortfolioView(),
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView();

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
                child: SelectableText(message, style: AppTextStyles.body),
              ),
            ),
            loaded: (projects) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final maxW = constraints.maxWidth;
                  final padH = maxW >= 720 ? 40.0 : 20.0;
                  const contentMaxWidth = 1180.0;

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
                              SelectableText(
                                'Portfolio',
                                style: AppTextStyles.hero.copyWith(
                                  fontFamily: 'Cinzel',
                                  fontSize: maxW >= 600 ? 36 : 28,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm8),
                              SelectableText(
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
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: contentMaxWidth,
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: projects.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: AppSpacing.xxl24),
                                itemBuilder: (context, index) {
                                  return PortfolioProjectRow(
                                    project: projects[index],
                                  );
                                },
                              ),
                            ),
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
