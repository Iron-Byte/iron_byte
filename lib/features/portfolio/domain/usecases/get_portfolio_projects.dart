import 'package:iron_byte/features/portfolio/domain/entities/portfolio_project.dart';
import 'package:iron_byte/features/portfolio/domain/repositories/portfolio_repository.dart';

class GetPortfolioProjects {
  GetPortfolioProjects(this._repository);

  final PortfolioRepository _repository;

  Future<List<PortfolioProject>> call() => _repository.getProjectsOrdered();
}
