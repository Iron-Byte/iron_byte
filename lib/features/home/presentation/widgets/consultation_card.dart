import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_event.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_state.dart';

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

    return BlocConsumer<HomeConsultationBloc, HomeConsultationState>(
      listenWhen: (previous, current) =>
          previous.message != current.message ||
          previous.email != current.email ||
          (previous.isSending &&
              !current.isSending &&
              current.sendError == null) ||
          (previous.isSending &&
              !current.isSending &&
              current.sendError != null),
      listener: (context, state) {
        if (_messageController.text != state.message) {
          _messageController.value = _messageController.value.copyWith(
            text: state.message,
            selection: TextSelection.collapsed(offset: state.message.length),
            composing: TextRange.empty,
          );
        }
        if (_emailController.text != state.email) {
          _emailController.value = _emailController.value.copyWith(
            text: state.email,
            selection: TextSelection.collapsed(offset: state.email.length),
            composing: TextRange.empty,
          );
        }
        if (!state.isSending && state.sendError == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('consultation.snackbar.opening_mail'.tr())),
          );
        } else if (state.sendError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('consultation.snackbar.mail_failed'.tr()),
            ),
          );
        }
      },
      builder: (context, state) {
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
                  'get_consultation'.tr(),
                  style:
                      AppTextStyles.label.copyWith(fontWeight: FontWeight.w600),
                ),
                const Gap(AppSpacing.sm8),
                SelectableText(
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
                  autofillHints: const [AutofillHints.email],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'consultation.email_hint'.tr(),
                    errorText: state.emailValidationError?.tr(),
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
                    hintText: 'consultation.note_hint'.tr(),
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
                    onPressed: state.isSending
                        ? null
                        : () => context
                            .read<HomeConsultationBloc>()
                            .add(HomeConsultationSendRequested()),
                    child: state.isSending
                        ? SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
                        : Text('send_message'.tr()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
