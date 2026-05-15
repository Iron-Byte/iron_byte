import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/utils/consultation_booked_slots.dart';
import 'package:iron_byte/core/utils/validators.dart';
import 'package:iron_byte/features/home/data/consultation_api_exception.dart';
import 'package:iron_byte/features/home/data/consultation_feature_log.dart';
import 'package:iron_byte/features/home/domain/consultation_attachment_policy.dart';
import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';
import 'package:iron_byte/features/home/domain/services/consultation_default_message_generator.dart';
import 'package:iron_byte/features/home/domain/usecases/book_consultation_reservation.dart';
import 'package:iron_byte/features/home/domain/usecases/check_consultation_server_health.dart';
import 'package:iron_byte/features/home/domain/usecases/load_consultation_booked_slots.dart';
import 'home_consultation_event.dart';
import 'home_consultation_state.dart';

class HomeConsultationBloc
    extends Bloc<HomeConsultationEvent, HomeConsultationState> {
  HomeConsultationBloc({
    required BookConsultationReservation bookConsultationReservation,
    required LoadConsultationBookedSlots loadConsultationBookedSlots,
    required CheckConsultationServerHealth checkConsultationServerHealth,
    required ConsultationDefaultMessageGenerator messageGenerator,
  }) : _bookConsultationReservation = bookConsultationReservation,
       _loadConsultationBookedSlots = loadConsultationBookedSlots,
       _checkConsultationServerHealth = checkConsultationServerHealth,
       _messageGenerator = messageGenerator,
       super(const HomeConsultationState()) {
    on<HomeConsultationBootstrapRequested>(_onBootstrapRequested);
    on<HomeConsultationInitialized>(_onInitialized);
    on<HomeConsultationNameChanged>(_onNameChanged);
    on<HomeConsultationEmailChanged>(_onEmailChanged);
    on<HomeConsultationMessageChanged>(_onMessageChanged);
    on<HomeConsultationSendRequested>(_onSendRequested);
    on<HomeConsultationPreferredSlotChanged>(_onPreferredSlotChanged);
    on<HomeConsultationAttachmentPicked>(_onAttachmentPicked);
    on<HomeConsultationAttachmentCleared>(_onAttachmentCleared);
    on<HomeConsultationBookingStatusAcknowledged>(_onBookingStatusAcknowledged);
  }

  final BookConsultationReservation _bookConsultationReservation;
  final LoadConsultationBookedSlots _loadConsultationBookedSlots;
  final CheckConsultationServerHealth _checkConsultationServerHealth;
  final ConsultationDefaultMessageGenerator _messageGenerator;

  int _bootstrapGeneration = 0;

  Future<void> _onBootstrapRequested(
    HomeConsultationBootstrapRequested event,
    Emitter<HomeConsultationState> emit,
  ) async {
    ConsultationFeatureLog.d('Bootstrap: health check + booked slots');
    final generation = ++_bootstrapGeneration;
    emit(
      state.copyWith(
        isServerOnline: null,
        isLoadingBookedSlots: true,
        bookedSlotsErrorKey: null,
      ),
    );

    final healthFuture = _checkConsultationServerHealth();
    final slotsFuture = _loadConsultationBookedSlots();

    final online = await healthFuture;
    if (isClosed || generation != _bootstrapGeneration) return;
    ConsultationFeatureLog.d('Bootstrap: server online=$online');
    emit(state.copyWith(isServerOnline: online));

    try {
      final slots = await slotsFuture;
      if (isClosed || generation != _bootstrapGeneration) return;
      emit(
        state.copyWith(
          bookedSlotsUtc: slots,
          isLoadingBookedSlots: false,
          bookedSlotsErrorKey: null,
        ),
      );
    } on ConsultationApiException catch (e, st) {
      if (isClosed || generation != _bootstrapGeneration) return;
      ConsultationFeatureLog.e('Bootstrap: slots load failed', e, st);
      emit(
        state.copyWith(
          isLoadingBookedSlots: false,
          bookedSlotsErrorKey: e.serverMessage ?? e.messageKey,
        ),
      );
    } catch (e, st) {
      if (isClosed || generation != _bootstrapGeneration) return;
      ConsultationFeatureLog.e('Bootstrap: unexpected error', e, st);
      emit(
        state.copyWith(
          isLoadingBookedSlots: false,
          bookedSlotsErrorKey: 'consultation.error.unexpected',
        ),
      );
    }
  }

  void _onInitialized(
    HomeConsultationInitialized event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(
      state.copyWith(
        message: _messageGenerator(event.serviceName),
        preferredConsultationSlotUtc: null,
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
    ConsultationFeatureLog.d(
      'Attachment picked: name=${pf.name}, size=${pf.size}, '
      'extension=${pf.extension}, hasBytes=${pf.bytes != null}',
    );
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
    ConsultationFeatureLog.d('Submit requested');

    final nameKey = Validators.nameValidationKey(state.name);
    final emailKey = Validators.emailValidationKey(state.email);
    ConsultationFeatureLog.d(
      'Validation: nameKey=$nameKey, emailKey=$emailKey, '
      'name="${state.name.trim()}", email="${state.email.trim()}"',
    );
    if (nameKey != null || emailKey != null) {
      ConsultationFeatureLog.d('Submit blocked by client validation');
      emit(
        state.copyWith(
          nameValidationError: nameKey,
          emailValidationError: emailKey,
        ),
      );
      return;
    }

    final slot = state.preferredConsultationSlotUtc;
    if (slot != null &&
        isConsultationSlotBooked(slot, state.bookedSlotsUtc)) {
      ConsultationFeatureLog.d('Submit blocked: slot already booked');
      emit(
        state.copyWith(
          bookingStatus: ConsultationBookingStatus.error,
          bookingErrorMessage: 'consultation.error.slot_taken',
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
      ConsultationFeatureLog.d(
        'Calling API: name="${state.name.trim()}", '
        'email="${state.email.trim()}", '
        'hasNote=${state.message.trim().isNotEmpty}, '
        'hasSlot=${slot != null}, '
        'hasAttachment=${state.attachment != null}',
      );
      await _bookConsultationReservation(
        name: state.name.trim(),
        guestEmail: state.email.trim(),
        note: state.message,
        preferredSlotUtc: slot,
        attachment: state.attachment,
      );
      if (isClosed) return;
      ConsultationFeatureLog.d('Booking succeeded');
      emit(
        state.copyWith(
          bookingStatus: ConsultationBookingStatus.success,
          name: '',
          email: '',
          message: '',
          preferredConsultationSlotUtc: null,
          attachment: null,
        ),
      );
      add(HomeConsultationBootstrapRequested());
    } on ConsultationApiException catch (e, st) {
      if (isClosed) return;
      ConsultationFeatureLog.e(
        'Booking failed: status=${e.statusCode}, '
        'serverMessage=${e.serverMessage}, key=${e.messageKey}',
        e,
        st,
      );
      emit(
        state.copyWith(
          bookingStatus: ConsultationBookingStatus.error,
          bookingErrorMessage: e.serverMessage ?? e.messageKey,
        ),
      );
    } catch (e, st) {
      if (isClosed) return;
      ConsultationFeatureLog.e('Booking failed: unexpected error', e, st);
      emit(
        state.copyWith(
          bookingStatus: ConsultationBookingStatus.error,
          bookingErrorMessage: 'consultation.error.unexpected',
        ),
      );
    }
  }
}
