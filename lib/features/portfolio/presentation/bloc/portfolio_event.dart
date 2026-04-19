import 'package:iron_byte/features/portfolio/presentation/models/portfolio_ui_models.dart';

abstract class PortfolioEvent {}

class LoadPortfolio extends PortfolioEvent {}

class PortfolioFilterSelected extends PortfolioEvent {
  PortfolioFilterSelected(this.filter);
  final PortfolioFilter filter;
}
