import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/assets/image_paths.dart';
import 'package:iron_byte/core/navigation/home_scroll_coordinator.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/about/presentation/bloc/about_bloc.dart';
import 'package:iron_byte/features/about/presentation/bloc/about_event.dart';
import 'package:iron_byte/features/about/presentation/bloc/about_state.dart';
import 'package:iron_byte/features/about/presentation/screens/about_screen.dart';
import 'package:iron_byte/features/careers/presentation/bloc/careers_bloc.dart';
import 'package:iron_byte/features/careers/presentation/bloc/careers_event.dart';
import 'package:iron_byte/features/careers/presentation/bloc/careers_state.dart';
import 'package:iron_byte/features/careers/presentation/screens/careers_screen.dart';
import 'package:iron_byte/features/home/data/repositories/consultation_mail_repository_impl.dart';
import 'package:iron_byte/features/home/domain/services/consultation_default_message_generator.dart';
import 'package:iron_byte/features/home/domain/usecases/send_consultation_inquiry.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/widgets/consultation_card.dart';
import 'package:iron_byte/features/home/presentation/widgets/hero_section.dart';
import 'package:iron_byte/features/portfolio/data/datasources/portfolio_local_datasource.dart';
import 'package:iron_byte/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:iron_byte/features/portfolio/domain/usecases/get_portfolio_projects.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_bloc.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_event.dart';
import 'package:iron_byte/features/project_brief_review/presentation/widgets/project_info.dart';
import 'package:iron_byte/features/services/presentation/bloc/services_bloc.dart';
import 'package:iron_byte/features/services/presentation/bloc/services_event.dart';
import 'package:iron_byte/features/services/presentation/bloc/services_state.dart';
import 'package:iron_byte/features/services/presentation/screens/services_screen.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeConsultationBloc(
            sendConsultationInquiry: SendConsultationInquiry(
              ConsultationMailRepositoryImpl(),
            ),
            messageGenerator: const ConsultationDefaultMessageGenerator(),
          ),
        ),
        BlocProvider(create: (_) => ServicesBloc()..add(LoadServices())),
        BlocProvider(create: (_) => CareersBloc()..add(LoadCareers())),
        BlocProvider(create: (_) => AboutBloc()..add(LoadAbout())),
        BlocProvider(
          create: (_) => PortfolioBloc(
            getPortfolioProjects: GetPortfolioProjects(
              PortfolioRepositoryImpl(PortfolioLocalDataSource()),
            ),
          )..add(LoadPortfolio()),
        ),
      ],
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  Widget _spySection({
    required HomeScrollCoordinator coordinator,
    required HomeScrollSection section,
    GlobalKey? anchorKey,
    required String visibilityKey,
    required Widget child,
  }) {
    final wrapped = anchorKey != null
        ? KeyedSubtree(key: anchorKey, child: child)
        : child;
    return VisibilityDetector(
      key: Key(visibilityKey),
      onVisibilityChanged: (info) {
        coordinator.onSectionVisibility(section, info.visibleFraction);
      },
      child: wrapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxW = constraints.maxWidth;
                final wide = maxW >= 900;
                const hero = RepaintBoundary(child: HomeHeroSection());
                const card = RepaintBoundary(child: HomeConsultationCard());
                final coordinator = HomeScrollScope.of(context);

                final heroBlock = wide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(flex: 3, child: hero),
                          const Gap(AppSpacing.xxxl32),
                          const Expanded(flex: 2, child: card),
                        ],
                      )
                    : const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [hero, Gap(AppSpacing.xxxl32), card],
                      );

                return SingleChildScrollView(
                  controller: coordinator.scrollController,
                  child: Column(
                    children: [
                      _spySection(
                        coordinator: coordinator,
                        section: HomeScrollSection.home,
                        anchorKey: coordinator.homeHeroKey,
                        visibilityKey: 'home-hero',
                        child: heroBlock,
                      ),
                      const Gap(AppSpacing.lg16),
                      _spySection(
                        coordinator: coordinator,
                        section: HomeScrollSection.portfolio,
                        visibilityKey: 'portfolio-gallery',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            KeyedSubtree(
                              key: coordinator.languageKitSectionKey,
                              child: ProjectInfo(
                                imagePath: LanguageKitPaths.carousel,
                                appName: tr('language_kit'),
                                appDescription: tr('language_kit_desc'),
                              ),
                            ),
                            const Gap(AppSpacing.lg16),
                            ProjectInfo(
                              imagePath: MigraneAppPaths.carousel,
                              appName: tr('migrane_tracker'),
                              appDescription: tr('migrane_tracker_desc'),
                            ),
                            const Gap(AppSpacing.lg16),
                            ProjectInfo(
                              imagePath: NumisAiPaths.carousel,
                              appName: tr('nums_ai'),
                              appDescription: tr('numis_ai_desc'),
                            ),
                            const Gap(AppSpacing.lg16),
                            ProjectInfo(
                              imagePath: SymptomTrackerPaths.carousel,
                              appName: tr('symptom_tracker'),
                              appDescription: tr('symptom_tracker_desc'),
                            ),
                            const Gap(AppSpacing.lg16),
                            ProjectInfo(
                              imagePath: VibeKitPaths.carousel,
                              appName: tr('vibe_kit'),
                              appDescription: tr('vibe_kit_desc'),
                            ),
                            const Gap(AppSpacing.lg16),
                          ],
                        ),
                      ),
                      const Gap(AppSpacing.huge36),
                      _spySection(
                        coordinator: coordinator,
                        section: HomeScrollSection.services,
                        anchorKey: coordinator.servicesSectionKey,
                        visibilityKey: 'home-services',
                        child: BlocBuilder<ServicesBloc, ServicesState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loaded: () => const ServicesPageColumn(),
                              orElse: () => const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSpacing.xxl24,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(AppSpacing.huge36),
                      _spySection(
                        coordinator: coordinator,
                        section: HomeScrollSection.careers,
                        anchorKey: coordinator.careersSectionKey,
                        visibilityKey: 'home-careers',
                        child: BlocBuilder<CareersBloc, CareersState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loaded: () => const CareersPageColumn(),
                              orElse: () => const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSpacing.xxl24,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(AppSpacing.huge36),
                      _spySection(
                        coordinator: coordinator,
                        section: HomeScrollSection.about,
                        anchorKey: coordinator.aboutSectionKey,
                        visibilityKey: 'home-about',
                        child: BlocBuilder<AboutBloc, AboutState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loaded: () => const AboutPageColumn(),
                              orElse: () => const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSpacing.xxl24,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(AppSpacing.huge36),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
