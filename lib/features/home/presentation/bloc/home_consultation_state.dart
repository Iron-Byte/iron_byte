import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_consultation_state.freezed.dart';

@freezed
abstract class HomeConsultationState with _$HomeConsultationState {
  const factory HomeConsultationState({
    @Default('') String email,
    @Default('') String message,
  }) = _HomeConsultationState;
}
