import 'package:iron_byte/features/home/domain/services/consultation_default_message_generator.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_event.dart';
import 'package:iron_byte/features/home/presentation/consultation_booking_dependencies.dart';

/// Default wiring for [HomeConsultationBloc] on the standalone consultation route.
HomeConsultationBloc createDefaultHomeConsultationBloc(String? selectedServiceName) {
  return HomeConsultationBloc(
    bookConsultationReservation: ConsultationBookingDependencies.bookReservation,
    checkConsultationServerHealth:
        ConsultationBookingDependencies.checkServerHealth,
    messageGenerator: const ConsultationDefaultMessageGenerator(),
  )..add(HomeConsultationInitialized(serviceName: selectedServiceName));
}
