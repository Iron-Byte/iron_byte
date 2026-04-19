import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_state.freezed.dart';

@freezed
class PortfolioState with _$PortfolioState {
  const factory PortfolioState.initial() = _Initial;
  const factory PortfolioState.loading() = _Loading;
  const factory PortfolioState.success() = _Success;
  const factory PortfolioState.error(String message) = _Error;
}
