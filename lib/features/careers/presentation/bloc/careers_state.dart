import 'package:freezed_annotation/freezed_annotation.dart';

part 'careers_state.freezed.dart';

@freezed
class CareersState with _$CareersState {
  const factory CareersState.initial() = _Initial;
  const factory CareersState.loading() = _Loading;
  const factory CareersState.loaded() = _Loaded;
  const factory CareersState.error(String message) = _Error;
}
