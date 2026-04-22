import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/utils/validators.dart';
import 'package:iron_byte/features/home/domain/usecases/send_consultation_inquiry.dart';
import 'home_consultation_event.dart';
import 'home_consultation_state.dart';

class HomeConsultationBloc
    extends Bloc<HomeConsultationEvent, HomeConsultationState> {
  HomeConsultationBloc({
    required SendConsultationInquiry sendConsultationInquiry,
  })  : _sendConsultationInquiry = sendConsultationInquiry,
        super(const HomeConsultationState()) {
    on<HomeConsultationEmailChanged>(_onEmailChanged);
    on<HomeConsultationMessageChanged>(_onMessageChanged);
    on<HomeConsultationSendRequested>(_onSendRequested);
    on<HomeConsultationPreferredSlotChanged>(_onPreferredSlotChanged);
  }

  final SendConsultationInquiry _sendConsultationInquiry;

  void _onEmailChanged(
    HomeConsultationEmailChanged event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        emailValidationError: null,
      ),
    );
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
      ),
    );

    try {
      await _sendConsultationInquiry(
        guestEmail: state.email.trim(),
        note: state.message,
        preferredSlotUtc: state.preferredConsultationSlotUtc,
      );
      emit(state.copyWith(isSending: false));
    } catch (e) {
      emit(
        state.copyWith(
          isSending: false,
          sendError: e.toString(),
        ),
      );
    }
  }
}
