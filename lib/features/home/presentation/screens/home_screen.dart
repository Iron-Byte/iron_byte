import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/assets/image_paths.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/data/repositories/consultation_mail_repository_impl.dart';
import 'package:iron_byte/features/home/domain/services/consultation_default_message_generator.dart';
import 'package:iron_byte/features/home/domain/usecases/send_consultation_inquiry.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/widgets/consultation_card.dart';
import 'package:iron_byte/features/home/presentation/widgets/hero_section.dart';
import 'package:iron_byte/features/project_brief_review/presentation/widgets/project_info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeConsultationBloc(
        sendConsultationInquiry: SendConsultationInquiry(
          ConsultationMailRepositoryImpl(),
        ),
        messageGenerator: const ConsultationDefaultMessageGenerator(),
      ),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

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
                final horizontal = maxW >= 600 ? 48.0 : 24.0;
                const hero = RepaintBoundary(child: HomeHeroSection());
                const card = RepaintBoundary(child: HomeConsultationCard());
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      wide
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
                            ),
                      Gap(AppSpacing.lg16),

                      ProjectInfo(
                        imagePath: LanguageKitPaths.carousel,
                        appName: tr('language_kit'),
                        appDescription: tr('language_kit_desc'),
                      ),

                      Gap(AppSpacing.lg16),
                      ProjectInfo(
                        imagePath: MigraneAppPaths.carousel,
                        appName: tr('migrane_tracker'),
                        appDescription: tr('migrane_tracker_desc'),
                      ),

                      Gap(AppSpacing.lg16),

                      ProjectInfo(
                        imagePath: NumisAiPaths.carousel,
                        appName: tr('nums_ai'),
                        appDescription: tr('numis_ai_desc'),
                      ),
                      Gap(AppSpacing.lg16),
                      ProjectInfo(
                        imagePath: SymptomTrackerPaths.carousel,
                        appName: tr('symptom_tracker'),
                        appDescription: tr('symptom_tracker_desc'),
                      ),
                      Gap(AppSpacing.lg16),

                      ProjectInfo(
                        imagePath: VibeKitPaths.carousel,
                        appName: tr('vibe_kit'),
                        appDescription: tr('vibe_kit_desc'),
                      ),
                      Gap(AppSpacing.lg16),
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
