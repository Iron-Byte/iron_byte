import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/features/portfolio/presentation/models/portfolio_ui_models.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(const PortfolioState.initial()) {
    on<LoadPortfolio>(_onLoad);
    on<PortfolioFilterSelected>(_onFilter);
  }

  Future<void> _onLoad(
    LoadPortfolio event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const PortfolioState.loading());
    try {
      emit(const PortfolioState.loaded(filter: PortfolioFilter.all));
    } catch (e) {
      emit(PortfolioState.error(e.toString()));
    }
  }

  void _onFilter(
    PortfolioFilterSelected event,
    Emitter<PortfolioState> emit,
  ) {
    emit(PortfolioState.loaded(filter: event.filter));
  }
}
