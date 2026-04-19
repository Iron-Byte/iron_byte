import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iron_byte/features/portfolio/presentation/models/portfolio_ui_models.dart';

part 'portfolio_state.freezed.dart';

@freezed
class PortfolioState with _$PortfolioState {
  const factory PortfolioState.initial() = _Initial;
  const factory PortfolioState.loading() = _Loading;
  const factory PortfolioState.loaded({required PortfolioFilter filter}) = _Loaded;
  const factory PortfolioState.error(String message) = _Error;
}
