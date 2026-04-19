import 'package:flutter_bloc/flutter_bloc.dart';
import 'services_event.dart';
import 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(const ServicesState.initial()) {
    on<LoadServices>(_onLoad);
  }

  Future<void> _onLoad(
    LoadServices event,
    Emitter<ServicesState> emit,
  ) async {
    emit(const ServicesState.loading());
    try {
      emit(const ServicesState.loaded());
    } catch (e) {
      emit(ServicesState.error(e.toString()));
    }
  }
}
