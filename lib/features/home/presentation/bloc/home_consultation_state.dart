import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';

part 'home_consultation_state.freezed.dart';

/// Submission lifecycle for the consultation booking form.
enum ConsultationBookingStatus { idle, loading, success, error }

@freezed
abstract class HomeConsultationState with _$HomeConsultationState {
  const factory HomeConsultationState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String message,
    String? nameValidationError,
    String? emailValidationError,
  /// `null` while the initial health check is in progress.
    bool? isServerOnline,
    @Default(ConsultationBookingStatus.idle) ConsultationBookingStatus bookingStatus,
    String? bookingErrorMessage,
    ConsultationAttachment? attachment,
    String? attachmentErrorKey,
  }) = _HomeConsultationState;
}
