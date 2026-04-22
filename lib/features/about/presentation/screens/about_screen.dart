import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/about/presentation/bloc/about_bloc.dart';
import 'package:iron_byte/features/about/presentation/bloc/about_event.dart';
import 'package:iron_byte/features/about/presentation/bloc/about_state.dart';
import 'package:iron_byte/features/about/presentation/models/about_ui_models.dart';
import 'package:iron_byte/features/about/presentation/widgets/about_cta_banner.dart';
import 'package:iron_byte/features/about/presentation/widgets/about_stat_card.dart';
import 'package:iron_byte/features/about/presentation/widgets/about_team_member_card.dart';
import 'package:iron_byte/features/about/presentation/widgets/about_value_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AboutBloc()..add(LoadAbout()),
      child: const _AboutBody(),
    );
  }
}

class _AboutBody extends StatelessWidget {
  const _AboutBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<AboutBloc, AboutState>(
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
                  final valuesRow = maxW >= 1000;
                  final valuesGrid = maxW >= 640 && !valuesRow;
                  final teamRow = maxW >= 1100;
                  final teamGrid = maxW >= 520 && !teamRow;

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
                        _AboutHero(wide: heroWide),
                        const Gap(AppSpacing.huge36),
                        Text(
                          'about.story.section'.tr(),
                          style: AppTextStyles.overline.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(AppSpacing.xxl24),
                        Text(
                          'about.story.p1'.tr(),
                          style: AppTextStyles.body,
                        ),
                        const Gap(AppSpacing.lg16),
                        Text(
                          'about.story.p2'.tr(),
                          style: AppTextStyles.body,
                        ),
                        const Gap(AppSpacing.huge36),
                        Text(
                          'about.values.section'.tr(),
                          style: AppTextStyles.overline.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(AppSpacing.xxl24),
                        if (valuesRow)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0;
                                  i < AboutValuePillarData.pillars.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.xxl24),
                                Expanded(
                                  child: AboutValueCard(
                                    data: AboutValuePillarData.pillars[i],
                                  ),
                                ),
                              ],
                            ],
                          )
                        else if (valuesGrid)
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSpacing.xxl24,
                            crossAxisSpacing: AppSpacing.xxl24,
                            childAspectRatio: 0.92,
                            children: [
                              for (final p in AboutValuePillarData.pillars)
                                AboutValueCard(data: p),
                            ],
                          )
                        else
                          Column(
                            children: [
                              for (var i = 0;
                                  i < AboutValuePillarData.pillars.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.xxl24),
                                AboutValueCard(
                                  data: AboutValuePillarData.pillars[i],
                                ),
                              ],
                            ],
                          ),
                        const Gap(AppSpacing.huge36),
                        Text(
                          'about.team.section'.tr(),
                          style: AppTextStyles.overline.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(AppSpacing.xxl24),
                        if (teamRow)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0;
                                  i < AboutTeamMemberData.team.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.xxl24),
                                Expanded(
                                  child: AboutTeamMemberCard(
                                    member: AboutTeamMemberData.team[i],
                                  ),
                                ),
                              ],
                            ],
                          )
                        else if (teamGrid)
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSpacing.xxl24,
                            crossAxisSpacing: AppSpacing.xxl24,
                            childAspectRatio: 0.72,
                            children: [
                              for (final m in AboutTeamMemberData.team)
                                AboutTeamMemberCard(member: m),
                            ],
                          )
                        else
                          Column(
                            children: [
                              for (var i = 0;
                                  i < AboutTeamMemberData.team.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.xxl24),
                                AboutTeamMemberCard(
                                  member: AboutTeamMemberData.team[i],
                                ),
                              ],
                            ],
                          ),
                        const Gap(AppSpacing.huge36),
                        const AboutCtaBanner(),
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

class _AboutHero extends StatelessWidget {
  const _AboutHero({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
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
              'about.badge'.tr(),
              style: AppTextStyles.pill.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl20),
        Text.rich(
          TextSpan(
            style: AppTextStyles.hero.copyWith(fontFamily: 'Cinzel'),
            children: [
              TextSpan(text: 'about.hero.title_lead'.tr()),
              TextSpan(
                text: 'about.hero.title_accent'.tr(),
                style: AppTextStyles.hero.copyWith(
                  fontFamily: 'Cinzel',
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg16),
        Text(
          'about.hero.body'.tr(),
          style: AppTextStyles.body,
        ),
      ],
    );

    final stats = GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.lg16,
      crossAxisSpacing: AppSpacing.lg16,
      childAspectRatio: 1.45,
      children: [
        for (final s in AboutStatData.stats)
          AboutStatCard(
            value: s.valueKey.tr(),
            label: s.labelKey.tr(),
          ),
      ],
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: intro),
          const Gap(AppSpacing.xxxl32),
          Expanded(flex: 2, child: stats),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        intro,
        const Gap(AppSpacing.xxxl32),
        stats,
      ],
    );
  }
}
