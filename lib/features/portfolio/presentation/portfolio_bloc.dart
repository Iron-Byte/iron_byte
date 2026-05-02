import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/features/portfolio/domain/usecases/get_portfolio_projects.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_event.dart';
import 'package:iron_byte/features/portfolio/presentation/portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc({required GetPortfolioProjects getPortfolioProjects})
    : _getPortfolioProjects = getPortfolioProjects,
      super(const PortfolioState.initial()) {
    on<LoadPortfolio>(_onLoad);
  }

  final GetPortfolioProjects _getPortfolioProjects;

  Future<void> _onLoad(
    LoadPortfolio event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const PortfolioState.loading());
    try {
      final projects = await _getPortfolioProjects();
      emit(PortfolioState.loaded(projects));
    } catch (e) {
      emit(PortfolioState.error(e.toString()));
    }
  }
}
