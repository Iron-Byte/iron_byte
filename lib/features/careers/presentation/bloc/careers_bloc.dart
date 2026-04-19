import 'package:flutter_bloc/flutter_bloc.dart';
import 'careers_event.dart';
import 'careers_state.dart';

class CareersBloc extends Bloc<CareersEvent, CareersState> {
  CareersBloc() : super(const CareersState.initial()) {
    on<LoadCareers>(_onLoad);
  }

  Future<void> _onLoad(
    LoadCareers event,
    Emitter<CareersState> emit,
  ) async {
    emit(const CareersState.loading());
    try {
      emit(const CareersState.loaded());
    } catch (e) {
      emit(CareersState.error(e.toString()));
    }
  }
}
