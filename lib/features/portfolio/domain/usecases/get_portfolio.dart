import '../repositories/portfolio_repository.dart';

class GetPortfolio {
  final PortfolioRepository repository;

  GetPortfolio(this.repository);

  Future<void> call() async {
    return repository.getPortfolio();
  }
}
