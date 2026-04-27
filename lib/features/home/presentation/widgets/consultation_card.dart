import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_event.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_state.dart';
import 'package:iron_byte/features/home/presentation/widgets/status_chip.dart';

class HomeConsultationCard extends StatefulWidget {
  const HomeConsultationCard({super.key, this.isJobApplication = false});

  final bool isJobApplication;

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
            SnackBar(content: Text('consultation.snackbar.mail_failed'.tr())),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            DecoratedBox(
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
                      widget.isJobApplication
                          ? 'consultation.job.card_title'.tr()
                          : 'get_consultation'.tr(),
                      style: AppTextStyles.label.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(AppSpacing.sm8),
                    SelectableText(
                      widget.isJobApplication
                          ? 'consultation.job.card_subtitle'.tr()
                          : 'Tell us about your project — no strings attached.',
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
                        hintText: widget.isJobApplication
                            ? 'consultation.job.note_hint'.tr()
                            : 'consultation.note_hint'.tr(),
                        alignLabelWithHint: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                      ).applyDefaults(theme.inputDecorationTheme),
                    ),
                    const Gap(AppSpacing.lg16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: AppSpacing.sm8,
                        runSpacing: AppSpacing.sm8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: state.isSending
                                ? null
                                : () async {
                                    final result = await FilePicker.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: const [
                                        'pdf',
                                        'doc',
                                        'docx',
                                        'png',
                                        'jpg',
                                        'jpeg',
                                      ],
                                      withData: kIsWeb,
                                    );
                                    if (result == null ||
                                        result.files.isEmpty) {
                                      return;
                                    }
                                    if (!context.mounted) return;
                                    context.read<HomeConsultationBloc>().add(
                                      HomeConsultationAttachmentPicked(
                                        result.files.single,
                                      ),
                                    );
                                  },
                            icon: const Icon(Icons.attach_file, size: 18),
                            label: Text(
                              state.attachment == null
                                  ? 'consultation.attachment.pick'.tr()
                                  : 'consultation.attachment.replace'.tr(),
                            ),
                          ),
                          if (state.attachment != null)
                            IconButton(
                              tooltip: MaterialLocalizations.of(
                                context,
                              ).deleteButtonTooltip,
                              onPressed: state.isSending
                                  ? null
                                  : () => context
                                        .read<HomeConsultationBloc>()
                                        .add(
                                          HomeConsultationAttachmentCleared(),
                                        ),
                              icon: const Icon(Icons.close),
                            ),
                        ],
                      ),
                    ),
                    if (state.attachment != null) ...[
                      const Gap(AppSpacing.sm8),
                      Text(
                        state.attachment!.fileName,
                        style: AppTextStyles.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (state.attachmentErrorKey != null) ...[
                      const Gap(AppSpacing.sm8),
                      Text(
                        state.attachmentErrorKey!.tr(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                    const Gap(AppSpacing.xxl24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.isSending
                            ? null
                            : () => context.read<HomeConsultationBloc>().add(
                                HomeConsultationSendRequested(),
                              ),
                        child: state.isSending
                            ? SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              )
                            : Text('send_message'.tr()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(82),
            // const HomeStatusChip(),
          ],
        );
      },
    );
  }
}
