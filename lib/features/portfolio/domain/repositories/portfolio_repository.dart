import 'package:iron_byte/features/portfolio/domain/entities/portfolio_project.dart';

abstract class PortfolioRepository {
  Future<List<PortfolioProject>> getProjectsOrdered();
}
