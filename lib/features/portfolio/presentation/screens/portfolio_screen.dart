import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:iron_byte/features/portfolio/presentation/bloc/portfolio_event.dart';
import 'package:iron_byte/features/portfolio/presentation/bloc/portfolio_state.dart';
import 'package:iron_byte/features/portfolio/presentation/models/portfolio_ui_models.dart';
import 'package:iron_byte/features/portfolio/presentation/widgets/portfolio_filter_bar.dart';
import 'package:iron_byte/features/portfolio/presentation/widgets/portfolio_project_card.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioBloc()..add(LoadPortfolio()),
      child: const _PortfolioBody(),
    );
  }
}

class _PortfolioBody extends StatelessWidget {
  const _PortfolioBody();

  List<PortfolioProjectData> _visible(PortfolioFilter filter) {
    if (filter == PortfolioFilter.all) {
      return PortfolioProjectData.showcase;
    }
    return PortfolioProjectData.showcase
        .where((p) => p.filter == filter)
        .toList();
  }

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
            loaded: (filter) {
              final visible = _visible(filter);
              return LayoutBuilder(
                builder: (context, constraints) {
                  final maxW = constraints.maxWidth;
                  final horizontal = maxW >= 600 ? 48.0 : 24.0;
                  final crossAxisCount = maxW >= 1100
                      ? 3
                      : maxW >= 700
                          ? 2
                          : 1;

                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      horizontal,
                      AppSpacing.xxl24,
                      horizontal,
                      AppSpacing.huge36,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _Header(),
                        const SizedBox(height: AppSpacing.xxl24),
                        const PortfolioFilterBar(),
                        const SizedBox(height: AppSpacing.xxl24),
                        if (visible.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.xxl24,
                            ),
                            child: Text(
                              'portfolio.empty_category'.tr(),
                              style: AppTextStyles.body,
                            ),
                          )
                        else
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: AppSpacing.xxl24,
                              crossAxisSpacing: AppSpacing.xxl24,
                              childAspectRatio:
                                  crossAxisCount == 1 ? 0.72 : 0.68,
                            ),
                            itemCount: visible.length,
                            itemBuilder: (context, index) {
                              return PortfolioProjectCard(
                                project: visible[index],
                              );
                            },
                          ),
                      ],
                    ),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderPill36,
            border: Border.all(color: AppColors.primary),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg16,
              vertical: AppSpacing.sm8,
            ),
            child: Text(
              'portfolio.badge'.tr(),
              style: AppTextStyles.pill.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl20),
        Text(
          'portfolio.title'.tr(),
          style: AppTextStyles.hero.copyWith(fontFamily: 'Cinzel'),
        ),
        const SizedBox(height: AppSpacing.lg16),
        Text(
          'portfolio.subtitle'.tr(),
          style: AppTextStyles.body,
        ),
      ],
    );
  }
}
