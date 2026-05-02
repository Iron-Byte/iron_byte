import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/data/repositories/consultation_mail_repository_impl.dart';
import 'package:iron_byte/features/home/domain/services/consultation_default_message_generator.dart';
import 'package:iron_byte/features/home/domain/usecases/send_consultation_inquiry.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_event.dart';
import 'package:iron_byte/features/home/presentation/widgets/consultation_card.dart';

typedef ConsultationBlocFactory =
    HomeConsultationBloc Function(String? selectedServiceName);

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({
    super.key,
    this.selectedServiceName,
    this.isJobApplication = false,
    this.blocFactory,
  });

  final String? selectedServiceName;
  final bool isJobApplication;
  final ConsultationBlocFactory? blocFactory;

  HomeConsultationBloc _createDefaultBloc(String? serviceName) {
    return HomeConsultationBloc(
      sendConsultationInquiry: SendConsultationInquiry(
        ConsultationMailRepositoryImpl(),
      ),
      messageGenerator: const ConsultationDefaultMessageGenerator(),
    )..add(HomeConsultationInitialized(serviceName: serviceName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          (blocFactory ?? _createDefaultBloc).call(selectedServiceName),
      child: _ConsultationBody(isJobApplication: isJobApplication),
    );
  }
}

class _ConsultationBody extends StatelessWidget {
  const _ConsultationBody({required this.isJobApplication});

  final bool isJobApplication;

  double _horizontalPadding(double maxW) {
    if (maxW >= 900) return 72.0;
    if (maxW >= 600) return 48.0;
    return 20.0;
  }

  double _cardMaxWidth(double maxW) {
    if (maxW >= 1200) return 640.0;
    if (maxW >= 700) return 560.0;
    return 520.0;
  }

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
            final horizontal = _horizontalPadding(maxW);
            final cardMaxWidth = _cardMaxWidth(maxW);

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
                    const Gap(AppSpacing.xxxl32),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: cardMaxWidth),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.98, end: 1),
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOutCubic,
                        child: HomeConsultationCard(
                          isJobApplication: isJobApplication,
                        ),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value.clamp(0.0, 1.0),
                            child: Transform.scale(scale: value, child: child),
                          );
                        },
                      ),
                    ),
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
