import 'package:iron_byte/features/portfolio/data/datasources/portfolio_local_datasource.dart';
import 'package:iron_byte/features/portfolio/domain/entities/portfolio_project.dart';
import 'package:iron_byte/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this._local);

  final PortfolioLocalDataSource _local;

  @override
  Future<List<PortfolioProject>> getProjectsOrdered() =>
      _local.loadProjectsOrdered();
}
