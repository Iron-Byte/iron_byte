import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_state.freezed.dart';

@freezed
class AboutState with _$AboutState {
  const factory AboutState.initial() = _Initial;
  const factory AboutState.loading() = _Loading;
  const factory AboutState.loaded() = _Loaded;
  const factory AboutState.error(String message) = _Error;
}
