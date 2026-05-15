import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_event.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_state.dart';
class HomeConsultationCard extends StatefulWidget {
  const HomeConsultationCard({super.key, this.isJobApplication = false});

  final bool isJobApplication;

  @override
  State<HomeConsultationCard> createState() => _HomeConsultationCardState();
}

class _HomeConsultationCardState extends State<HomeConsultationCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<HomeConsultationBloc>();
    _nameController = TextEditingController(text: bloc.state.name);
    _emailController = TextEditingController(text: bloc.state.email);
    _messageController = TextEditingController(text: bloc.state.message);
    bloc.add(HomeConsultationBootstrapRequested());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('consultation.booking.success_title'.tr()),
        content: Text('consultation.booking.success_body'.tr()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<HomeConsultationBloc>().add(
                HomeConsultationBookingStatusAcknowledged(),
              );
            },
            child: Text('consultation.booking.success_ok'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<HomeConsultationBloc, HomeConsultationState>(
      listenWhen: (previous, current) =>
          previous.message != current.message ||
          previous.name != current.name ||
          previous.email != current.email ||
          previous.bookingStatus != current.bookingStatus,
      listener: (context, state) {
        if (_messageController.text != state.message) {
          _messageController.value = _messageController.value.copyWith(
            text: state.message,
            selection: TextSelection.collapsed(offset: state.message.length),
            composing: TextRange.empty,
          );
        }
        if (_nameController.text != state.name) {
          _nameController.value = _nameController.value.copyWith(
            text: state.name,
            selection: TextSelection.collapsed(offset: state.name.length),
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
        if (state.bookingStatus == ConsultationBookingStatus.success) {
          _showSuccessDialog(context);
        } else if (state.bookingStatus == ConsultationBookingStatus.error &&
            state.bookingErrorMessage != null) {
          final message = state.bookingErrorMessage!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message.startsWith('consultation.') ? message.tr() : message,
              ),
            ),
          );
          context.read<HomeConsultationBloc>().add(
            HomeConsultationBookingStatusAcknowledged(),
          );
        }
      },
      builder: (context, state) {
        final isSending =
            state.bookingStatus == ConsultationBookingStatus.loading;

        return Column(
          children: [
            if (state.isServerOnline == false) ...[
              _ServerStatusBanner(),
              const Gap(AppSpacing.md12),
            ],
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
                      controller: _nameController,
                      onChanged: (v) => context
                          .read<HomeConsultationBloc>()
                          .add(HomeConsultationNameChanged(v)),
                      textCapitalization: TextCapitalization.words,
                      autofillHints: const [AutofillHints.name],
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'consultation.name_hint'.tr(),
                        errorText: state.nameValidationError?.tr(),
                      ).applyDefaults(theme.inputDecorationTheme),
                    ),
                    const Gap(AppSpacing.lg16),
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
                            onPressed: isSending
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
                              onPressed: isSending
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
                        '${state.attachment!.fileName} · '
                        '${_formatFileSize(state.attachment!.sizeBytes)}',
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
                        onPressed: isSending
                            ? null
                            : () => context.read<HomeConsultationBloc>().add(
                                HomeConsultationSendRequested(),
                              ),
                        child: isSending
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
                            : Text(
                                widget.isJobApplication
                                    ? 'consultation.job.submit'.tr()
                                    : 'book_meeting'.tr(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(AppSpacing.xxl24),
          ],
        );
      },
    );
  }
}

class _ServerStatusBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderMd12,
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg16,
          vertical: AppSpacing.md12,
        ),
        child: Row(
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 18,
              color: Theme.of(context).colorScheme.error,
            ),
            const Gap(AppSpacing.md12),
            Expanded(
              child: Text(
                'consultation.server.offline'.tr(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
