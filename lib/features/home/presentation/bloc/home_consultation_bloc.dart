import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/utils/validators.dart';
import 'package:iron_byte/features/home/data/consultation_api_exception.dart';
import 'package:iron_byte/features/home/domain/consultation_attachment_policy.dart';
import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';
import 'package:iron_byte/features/home/domain/services/consultation_default_message_generator.dart';
import 'package:iron_byte/features/home/domain/usecases/book_consultation_reservation.dart';
import 'package:iron_byte/features/home/domain/usecases/check_consultation_server_health.dart';
import 'home_consultation_event.dart';
import 'home_consultation_state.dart';

class HomeConsultationBloc
    extends Bloc<HomeConsultationEvent, HomeConsultationState> {
  HomeConsultationBloc({
    required BookConsultationReservation bookConsultationReservation,
    required CheckConsultationServerHealth checkConsultationServerHealth,
    required ConsultationDefaultMessageGenerator messageGenerator,
  }) : _bookConsultationReservation = bookConsultationReservation,
       _checkConsultationServerHealth = checkConsultationServerHealth,
       _messageGenerator = messageGenerator,
       super(const HomeConsultationState()) {
    on<HomeConsultationBootstrapRequested>(_onBootstrapRequested);
    on<HomeConsultationInitialized>(_onInitialized);
    on<HomeConsultationNameChanged>(_onNameChanged);
    on<HomeConsultationEmailChanged>(_onEmailChanged);
    on<HomeConsultationMessageChanged>(_onMessageChanged);
    on<HomeConsultationSendRequested>(_onSendRequested);
    on<HomeConsultationAttachmentPicked>(_onAttachmentPicked);
    on<HomeConsultationAttachmentCleared>(_onAttachmentCleared);
    on<HomeConsultationBookingStatusAcknowledged>(_onBookingStatusAcknowledged);
  }

  final BookConsultationReservation _bookConsultationReservation;
  final CheckConsultationServerHealth _checkConsultationServerHealth;
  final ConsultationDefaultMessageGenerator _messageGenerator;

  int _bootstrapGeneration = 0;

  Future<void> _onBootstrapRequested(
    HomeConsultationBootstrapRequested event,
    Emitter<HomeConsultationState> emit,
  ) async {
    final generation = ++_bootstrapGeneration;
    emit(state.copyWith(isServerOnline: null));

    final online = await _checkConsultationServerHealth();
    if (isClosed || generation != _bootstrapGeneration) return;
    emit(state.copyWith(isServerOnline: online));
  }

  void _onInitialized(
    HomeConsultationInitialized event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(
      state.copyWith(
        message: _messageGenerator(event.serviceName),
        bookingStatus: ConsultationBookingStatus.idle,
        bookingErrorMessage: null,
        nameValidationError: null,
        emailValidationError: null,
        attachment: null,
        attachmentErrorKey: null,
      ),
    );
  }

  void _onNameChanged(
    HomeConsultationNameChanged event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(state.copyWith(name: event.name, nameValidationError: null));
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

  void _onBookingStatusAcknowledged(
    HomeConsultationBookingStatusAcknowledged event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(
      state.copyWith(
        bookingStatus: ConsultationBookingStatus.idle,
        bookingErrorMessage: null,
      ),
    );
  }

  Future<void> _onSendRequested(
    HomeConsultationSendRequested event,
    Emitter<HomeConsultationState> emit,
  ) async {
    final nameKey = Validators.nameValidationKey(state.name);
    final emailKey = Validators.emailValidationKey(state.email);
    if (nameKey != null || emailKey != null) {
      emit(
        state.copyWith(
          nameValidationError: nameKey,
          emailValidationError: emailKey,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        bookingStatus: ConsultationBookingStatus.loading,
        bookingErrorMessage: null,
        nameValidationError: null,
        emailValidationError: null,
        attachmentErrorKey: null,
      ),
    );

    try {
      await _bookConsultationReservation(
        name: state.name.trim(),
        guestEmail: state.email.trim(),
        note: state.message,
        attachment: state.attachment,
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          bookingStatus: ConsultationBookingStatus.success,
          name: '',
          email: '',
          message: '',
          attachment: null,
        ),
      );
      add(HomeConsultationBootstrapRequested());
    } on ConsultationApiException catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          bookingStatus: ConsultationBookingStatus.error,
          bookingErrorMessage: e.serverMessage ?? e.messageKey,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          bookingStatus: ConsultationBookingStatus.error,
          bookingErrorMessage: 'consultation.error.unexpected',
        ),
      );
    }
  }
}
