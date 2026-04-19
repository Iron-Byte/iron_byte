import 'package:flutter_bloc/flutter_bloc.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(const PortfolioState.initial()) {
    on<LoadPortfolio>((event, emit) async {
      emit(const PortfolioState.loading());

      try {
        // TODO: call usecase
        emit(const PortfolioState.success());
      } catch (e) {
        emit(PortfolioState.error(e.toString()));
      }
    });
  }
}
