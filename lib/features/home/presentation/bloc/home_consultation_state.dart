import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';

part 'home_consultation_state.freezed.dart';

@freezed
abstract class HomeConsultationState with _$HomeConsultationState {
  const factory HomeConsultationState({
    @Default('') String email,
    @Default('') String message,
    String? emailValidationError,
    @Default(false) bool isSending,
    String? sendError,
    DateTime? preferredConsultationSlotUtc,
    ConsultationAttachment? attachment,
    String? attachmentErrorKey,
  }) = _HomeConsultationState;
}
