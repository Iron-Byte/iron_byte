import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/careers/presentation/bloc/careers_bloc.dart';
import 'package:iron_byte/features/careers/presentation/bloc/careers_event.dart';
import 'package:iron_byte/features/careers/presentation/bloc/careers_state.dart';
import 'package:iron_byte/features/careers/presentation/models/careers_ui_models.dart';
import 'package:iron_byte/features/careers/presentation/widgets/careers_job_card.dart';
import 'package:iron_byte/features/careers/presentation/widgets/careers_open_application_banner.dart';
import 'package:iron_byte/features/careers/presentation/widgets/careers_why_card.dart';

class CareersScreen extends StatelessWidget {
  const CareersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CareersBloc()..add(LoadCareers()),
      child: const _CareersBody(),
    );
  }
}

class _CareersBody extends StatelessWidget {
  const _CareersBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<CareersBloc, CareersState>(
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
            loaded: () {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final maxW = constraints.maxWidth;
                  final horizontal = maxW >= 600 ? 48.0 : 24.0;
                  final heroWide = maxW >= 900;
                  final whyRow = maxW >= 1100;
                  final whyGrid = maxW >= 640 && !whyRow;

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
                        _CareersHero(wide: heroWide),
                        const Gap(AppSpacing.huge36),
                        Text(
                          'careers.why.section'.tr(),
                          style: AppTextStyles.overline.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(AppSpacing.xxl24),
                        if (whyRow)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0;
                                  i < CareersWhyFeatureData.features.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.xxl24),
                                Expanded(
                                  child: CareersWhyCard(
                                    data: CareersWhyFeatureData.features[i],
                                  ),
                                ),
                              ],
                            ],
                          )
                        else if (whyGrid)
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSpacing.xxl24,
                            crossAxisSpacing: AppSpacing.xxl24,
                            childAspectRatio: 1.05,
                            children: [
                              for (final f in CareersWhyFeatureData.features)
                                CareersWhyCard(data: f),
                            ],
                          )
                        else
                          Column(
                            children: [
                              for (var i = 0;
                                  i < CareersWhyFeatureData.features.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.xxl24),
                                CareersWhyCard(
                                  data: CareersWhyFeatureData.features[i],
                                ),
                              ],
                            ],
                          ),
                        const Gap(AppSpacing.huge36),
                        Text(
                          'careers.jobs.section'.tr(),
                          style: AppTextStyles.overline.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(AppSpacing.xxl24),
                        Column(
                          children: [
                            for (var i = 0;
                                i < CareerOpeningData.openings.length;
                                i++) ...[
                              if (i > 0) const Gap(AppSpacing.xxl24),
                              CareersJobCard(
                                opening: CareerOpeningData.openings[i],
                              ),
                            ],
                          ],
                        ),
                        const Gap(AppSpacing.huge36),
                        const CareersOpenApplicationBanner(),
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

class _CareersHero extends StatelessWidget {
  const _CareersHero({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    final count = CareerOpeningData.openings.length;
    final intro = Column(
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
              'careers.badge'.tr(),
              style: AppTextStyles.pill.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl20),
        Text(
          'careers.title'.tr(),
          style: AppTextStyles.hero.copyWith(fontFamily: 'Cinzel'),
        ),
        const SizedBox(height: AppSpacing.lg16),
        Text(
          'careers.subtitle'.tr(),
          style: AppTextStyles.body,
        ),
      ],
    );

    final statCard = DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderLg16,
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: Padding(
        padding: AppSpacing.allXxl24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$count',
              style: AppTextStyles.heroAccent.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cinzel',
              ),
            ),
            const SizedBox(height: AppSpacing.sm8),
            Text(
              'careers.hero.stat_caption'.tr(),
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: intro),
          const Gap(AppSpacing.xxxl32),
          Expanded(flex: 2, child: statCard),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        intro,
        const Gap(AppSpacing.xxxl32),
        statCard,
      ],
    );
  }
}
