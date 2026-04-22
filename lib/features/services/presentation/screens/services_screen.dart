import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/services/presentation/bloc/services_bloc.dart';
import 'package:iron_byte/features/services/presentation/bloc/services_event.dart';
import 'package:iron_byte/features/services/presentation/bloc/services_state.dart';
import 'package:iron_byte/features/services/presentation/models/services_ui_models.dart';
import 'package:iron_byte/features/services/presentation/widgets/services_capability_card.dart';
import 'package:iron_byte/features/services/presentation/widgets/services_pricing_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServicesBloc()..add(LoadServices()),
      child: const _ServicesBody(),
    );
  }
}

class _ServicesBody extends StatelessWidget {
  const _ServicesBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ServicesBloc, ServicesState>(
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
            loaded: () {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final maxW = constraints.maxWidth;
                  final horizontal = maxW >= 600 ? 48.0 : 24.0;
                  final wideCapabilities = maxW >= 900;
                  final howWeWorkWide = maxW >= 1000;
                  final pricingWide = maxW >= 1000;

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
                        const _ServicesHeroHeader(),
                        const Gap(AppSpacing.xxxl32),
                        SelectableText(
                          'services.capabilities.section'.tr(),
                          style: AppTextStyles.overline.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(AppSpacing.xxl24),
                        if (wideCapabilities)
                          LayoutBuilder(
                            builder: (context, capabilitiesConstraints) {
                              final itemWidth =
                                  (capabilitiesConstraints.maxWidth -
                                          AppSpacing.lg16) /
                                      2;
                              return Wrap(
                                spacing: AppSpacing.lg16,
                                runSpacing: AppSpacing.lg16,
                                children: [
                                  for (final item in ServicesCapabilityData.items)
                                    SizedBox(
                                      width: itemWidth,
                                      child: ServicesCapabilityCard(data: item),
                                    ),
                                ],
                              );
                            },
                          )
                        else
                          Column(
                            children: [
                              for (var i = 0;
                                  i < ServicesCapabilityData.items.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.lg16),
                                ServicesCapabilityCard(
                                  data: ServicesCapabilityData.items[i],
                                ),
                              ],
                            ],
                          ),
                        const Gap(AppSpacing.huge36),
                        SelectableText(
                          'services.how_we_work.title'.tr(),
                          style: AppTextStyles.overline.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(AppSpacing.xxl24),
                        if (howWeWorkWide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0;
                                  i < ServicesHowWeWorkStep.steps.length;
                                  i++) ...[
                                Expanded(
                                  child: _HowWeWorkColumn(
                                    step: ServicesHowWeWorkStep.steps[i],
                                  ),
                                ),
                                if (i != ServicesHowWeWorkStep.steps.length - 1)
                                  const Gap(AppSpacing.xxl24),
                              ],
                            ],
                          )
                        else
                          Column(
                            children: [
                              for (var i = 0;
                                  i < ServicesHowWeWorkStep.steps.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.xxl24),
                                _HowWeWorkColumn(
                                  step: ServicesHowWeWorkStep.steps[i],
                                ),
                              ],
                            ],
                          ),
                        const Gap(AppSpacing.huge36),
                        SelectableText(
                          'services.pricing.title'.tr(),
                          style: AppTextStyles.overline.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(AppSpacing.xxl24),
                        if (pricingWide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0;
                                  i < ServicesPricingPlanData.plans.length;
                                  i++) ...[
                                Expanded(
                                  child: ServicesPricingCard(
                                    plan: ServicesPricingPlanData.plans[i],
                                  ),
                                ),
                                if (i != ServicesPricingPlanData.plans.length - 1)
                                  const Gap(AppSpacing.xxl24),
                              ],
                            ],
                          )
                        else
                          Column(
                            children: [
                              for (var i = 0;
                                  i < ServicesPricingPlanData.plans.length;
                                  i++) ...[
                                if (i > 0) const Gap(AppSpacing.xxl24),
                                ServicesPricingCard(
                                  plan: ServicesPricingPlanData.plans[i],
                                ),
                              ],
                            ],
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

class _ServicesHeroHeader extends StatelessWidget {
  const _ServicesHeroHeader();

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
            child: SelectableText(
              'services.badge'.tr(),
              style: AppTextStyles.pill.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl20),
        SelectableText(
          'services.title'.tr(),
          style: AppTextStyles.hero.copyWith(fontFamily: 'Cinzel'),
        ),
        const SizedBox(height: AppSpacing.lg16),
        SelectableText(
          'services.subtitle'.tr(),
          style: AppTextStyles.body,
        ),
      ],
    );
  }
}

class _HowWeWorkColumn extends StatelessWidget {
  const _HowWeWorkColumn({required this.step});

  final ServicesHowWeWorkStep step;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          step.numberKey.tr(),
          style: AppTextStyles.tag.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(AppSpacing.sm8),
        SelectableText(
          step.titleKey.tr(),
          style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
        ),
        const Gap(AppSpacing.md12),
        SelectableText(
          step.descriptionKey.tr(),
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
