import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_consultation_event.dart';
import 'home_consultation_state.dart';

class HomeConsultationBloc
    extends Bloc<HomeConsultationEvent, HomeConsultationState> {
  HomeConsultationBloc() : super(const HomeConsultationState()) {
    on<HomeConsultationEmailChanged>(_onEmailChanged);
    on<HomeConsultationMessageChanged>(_onMessageChanged);
  }

  void _onEmailChanged(
    HomeConsultationEmailChanged event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onMessageChanged(
    HomeConsultationMessageChanged event,
    Emitter<HomeConsultationState> emit,
  ) {
    emit(state.copyWith(message: event.message));
  }
}
