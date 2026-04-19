import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initial()) {
    on<LoadHome>((event, emit) async {
      emit(const HomeState.loading());

      try {
        emit(const HomeState.success());
      } catch (e) {
        emit(HomeState.error(e.toString()));
      }
    });
  }
}
