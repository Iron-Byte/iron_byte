import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_event.dart';

class HomeConsultationCard extends StatefulWidget {
  const HomeConsultationCard({super.key});

  @override
  State<HomeConsultationCard> createState() => _HomeConsultationCardState();
}

class _HomeConsultationCardState extends State<HomeConsultationCard> {
  late final TextEditingController _emailController;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<HomeConsultationBloc>();
    _emailController = TextEditingController(text: bloc.state.email);
    _messageController = TextEditingController(text: bloc.state.message);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            Text(
              'get_consultation'.tr(),
              style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w600),
            ),
            const Gap(AppSpacing.sm8),
            Text(
              'Tell us about your project — no strings attached.',
              style: AppTextStyles.bodySmall,
            ),
            const Gap(AppSpacing.xxl24),
            TextField(
              controller: _emailController,
              onChanged: (v) => context
                  .read<HomeConsultationBloc>()
                  .add(HomeConsultationEmailChanged(v)),
              keyboardType: TextInputType.emailAddress,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Your email',
              ).applyDefaults(theme.inputDecorationTheme),
            ),
            const Gap(AppSpacing.lg16),
            TextField(
              controller: _messageController,
              onChanged: (v) => context
                  .read<HomeConsultationBloc>()
                  .add(HomeConsultationMessageChanged(v)),
              maxLines: 5,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'What are you building?',
                alignLabelWithHint: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ).applyDefaults(theme.inputDecorationTheme),
            ),
            const Gap(AppSpacing.xxl24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('send_message'.tr()),
              ),
            ),
            const Gap(AppSpacing.lg16),
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.borderSurface)),
                Padding(
                  padding: AppSpacing.hMd12,
                  child: Text('or'.tr(), style: AppTextStyles.caption),
                ),
                const Expanded(child: Divider(color: AppColors.borderSurface)),
              ],
            ),
            const Gap(AppSpacing.lg16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
                label: const Text('Check available dates'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
