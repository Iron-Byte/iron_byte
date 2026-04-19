import 'package:freezed_annotation/freezed_annotation.dart';

part 'services_state.freezed.dart';

@freezed
class ServicesState with _$ServicesState {
  const factory ServicesState.initial() = _Initial;
  const factory ServicesState.loading() = _Loading;
  const factory ServicesState.loaded() = _Loaded;
  const factory ServicesState.error(String message) = _Error;
}
