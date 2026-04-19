import 'package:flutter_bloc/flutter_bloc.dart';
import 'about_event.dart';
import 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(const AboutState.initial()) {
    on<LoadAbout>(_onLoad);
  }

  Future<void> _onLoad(
    LoadAbout event,
    Emitter<AboutState> emit,
  ) async {
    emit(const AboutState.loading());
    try {
      emit(const AboutState.loaded());
    } catch (e) {
      emit(AboutState.error(e.toString()));
    }
  }
}
