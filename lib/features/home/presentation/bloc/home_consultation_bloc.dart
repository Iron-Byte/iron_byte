import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/utils/validators.dart';
import 'package:iron_byte/features/home/domain/consultation_attachment_policy.dart';
import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';
import 'package:iron_byte/features/home/domain/services/consultation_default_message_generator.dart';
import 'package:iron_byte/features/home/domain/usecases/send_consultation_inquiry.dart';
import 'home_consultation_event.dart';
import 'home_consultation_state.dart';

class HomeConsultationBloc
    extends Bloc<HomeConsultationEvent, HomeConsultationState> {
  HomeConsultationBloc({
    required SendConsultationInquiry sendConsultationInquiry,
    required ConsultationDefaultMessageGenerator messageGenerator,
  }) : _sendConsultationInquiry = sendConsultationInquiry,
       _messageGenerator = messageGenerator,
       super(const HomeConsultationState()) {
    on<HomeConsultationInitialized>(_onInitialized);
    on<HomeConsultationEmailChanged>(_onEmailChanged);
    on<HomeConsultationMessageChanged>(_onMessageChanged);
    on<HomeConsultationSendRequested>(_onSendRequested);
    on<HomeConsultationPreferredSlotChanged>(_onPreferredSlotChanged);
    on<HomeConsultationAttachmentPicked>(_onAttachmentPicked);
    on<HomeConsultationAttachmentCleared>(_onAttachmentCleared);
  }

  final SendConsultationInquiry _sendConsultationInquiry;
  final ConsultationDefaultMessageGenerator _messageGenerator;

  void _onInitialized(
    HomeConsultationInitialized event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(
      state.copyWith(
        message: _messageGenerator(event.serviceName),
        preferredConsultationSlotUtc: null,
        sendError: null,
        emailValidationError: null,
        attachment: null,
        attachmentErrorKey: null,
      ),
    );
  }

  void _onEmailChanged(
    HomeConsultationEmailChanged event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(state.copyWith(email: event.email, emailValidationError: null));
  }

  void _onMessageChanged(
    HomeConsultationMessageChanged event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(state.copyWith(message: event.message));
  }

  void _onPreferredSlotChanged(
    HomeConsultationPreferredSlotChanged event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(state.copyWith(preferredConsultationSlotUtc: event.slotUtc));
  }

  void _onAttachmentPicked(
    HomeConsultationAttachmentPicked event,
    Emitter<HomeConsultationState> emit,
  ) {
    final pf = event.platformFile;
    if (pf.size > kConsultationAttachmentMaxBytes) {
      emit(
        state.copyWith(
          attachment: null,
          attachmentErrorKey: 'consultation.attachment.error.size',
        ),
      );
      return;
    }
    if (!isAllowedConsultationAttachmentName(pf.name)) {
      emit(
        state.copyWith(
          attachment: null,
          attachmentErrorKey: 'consultation.attachment.error.type',
        ),
      );
      return;
    }
    if (kIsWeb && (pf.bytes == null || pf.bytes!.isEmpty)) {
      emit(
        state.copyWith(
          attachment: null,
          attachmentErrorKey: 'consultation.attachment.error.read',
        ),
      );
      return;
    }
    if (!kIsWeb &&
        (pf.path == null || pf.path!.isEmpty) &&
        (pf.bytes == null || pf.bytes!.isEmpty)) {
      emit(
        state.copyWith(
          attachment: null,
          attachmentErrorKey: 'consultation.attachment.error.read',
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        attachment: ConsultationAttachment(
          fileName: pf.name,
          sizeBytes: pf.size,
          filePath: pf.path,
          bytes: pf.bytes,
        ),
        attachmentErrorKey: null,
      ),
    );
  }

  void _onAttachmentCleared(
    HomeConsultationAttachmentCleared event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(state.copyWith(attachment: null, attachmentErrorKey: null));
  }

  Future<void> _onSendRequested(
    HomeConsultationSendRequested event,
    Emitter<HomeConsultationState> emit,
  ) async {
    final key = Validators.emailValidationKey(state.email);
    if (key != null) {
      emit(state.copyWith(emailValidationError: key));
      return;
    }

    emit(
      state.copyWith(
        isSending: true,
        sendError: null,
        emailValidationError: null,
        attachmentErrorKey: null,
      ),
    );

    try {
      await _sendConsultationInquiry(
        guestEmail: state.email.trim(),
        note: state.message,
        preferredSlotUtc: state.preferredConsultationSlotUtc,
        attachment: state.attachment,
      );
      emit(state.copyWith(isSending: false));
    } catch (e) {
      emit(state.copyWith(isSending: false, sendError: e.toString()));
    }
  }
}
