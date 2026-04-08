import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState.initial()) {
    on<LoadMain>((event, emit) async {
      emit(const MainState.loading());

      try {
        // TODO: call usecase
        emit(const MainState.success());
      } catch (e) {
        emit(MainState.error(e.toString()));
      }
    });
  }
}
