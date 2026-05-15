import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/consultation_item/presentation/consultation_page_layout_metrics.dart';
import 'package:iron_byte/features/consultation_item/presentation/home_consultation_bloc_factory.dart';
import 'package:iron_byte/features/consultation_item/presentation/vacancy_placeholder_descriptions.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/widgets/consultation_card.dart';

typedef ConsultationBlocFactory =
    HomeConsultationBloc Function(String? selectedServiceName);

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({
    super.key,
    this.selectedServiceName,
    this.isJobApplication = false,
    this.vacancyTitleKey,
    this.serviceTitleKey,
    this.blocFactory,
  });

  final String? selectedServiceName;
  final bool isJobApplication;
  final String? vacancyTitleKey;
  final String? serviceTitleKey;
  final ConsultationBlocFactory? blocFactory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => (blocFactory ?? createDefaultHomeConsultationBloc).call(
        selectedServiceName,
      ),
      child: _ConsultationBody(
        isJobApplication: isJobApplication,
        vacancyTitleKey: vacancyTitleKey,
        serviceTitleKey: serviceTitleKey,
      ),
    );
  }
}

class _ConsultationBody extends StatelessWidget {
  const _ConsultationBody({
    required this.isJobApplication,
    this.vacancyTitleKey,
    this.serviceTitleKey,
  });

  final bool isJobApplication;
  final String? vacancyTitleKey;
  final String? serviceTitleKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),

          child: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxW = constraints.maxWidth;
            final horizontal = ConsultationPageLayoutMetrics.horizontalPadding(
              maxW,
            );
            final cardMaxWidth = ConsultationPageLayoutMetrics.cardMaxWidth(
              maxW,
            );
            final wide = maxW >= 900;
            final detailsTitleKey = vacancyTitleKey ?? serviceTitleKey;
            final showDetails = detailsTitleKey != null;

            final consultationForm = ConstrainedBox(
              constraints: BoxConstraints(maxWidth: cardMaxWidth),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.98, end: 1),
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                child: HomeConsultationCard(isJobApplication: isJobApplication),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value.clamp(0.0, 1.0),
                    child: Transform.scale(scale: value, child: child),
                  );
                },
              ),
            );

            final detailsCard = showDetails
                ? ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: cardMaxWidth),
                    child: _VacancyDetailsCard(
                      titleKey: detailsTitleKey,
                      description: VacancyPlaceholderDescriptions.forTitleKey(
                        detailsTitleKey,
                      )!,
                    ),
                  )
                : null;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontal,
                  AppSpacing.huge36,
                  horizontal,
                  AppSpacing.huge36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SelectableText(
                      isJobApplication
                          ? 'consultation.job.title'.tr()
                          : 'get_consultation'.tr(),
                      style: AppTextStyles.hero.copyWith(
                        fontFamily: 'Cinzel',
                        fontSize: maxW >= 720 ? 38 : 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(AppSpacing.md12),
                    SelectableText(
                      isJobApplication
                          ? 'consultation.job.subtitle'.tr()
                          : 'Tell us about your project and we will help you shape the right delivery plan.',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(AppSpacing.xxl24),
                    if (showDetails && wide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: consultationForm),
                          const Gap(AppSpacing.xxxl32),
                          Expanded(child: detailsCard!),
                        ],
                      )
                    else ...[
                      consultationForm,
                      if (showDetails) ...[
                        detailsCard!,
                        const Gap(AppSpacing.xxl24),
                      ],
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _VacancyDetailsCard extends StatelessWidget {
  const _VacancyDetailsCard({
    required this.titleKey,
    required this.description,
  });

  final String titleKey;
  final String description;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderLg16,
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: Padding(
        padding: AppSpacing.allXxl24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectableText(
              titleKey.tr(),
              style: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontFamily: 'Cinzel',
              ),
            ),
            const Gap(AppSpacing.lg16),
            SelectableText(
              description,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
