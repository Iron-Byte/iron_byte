import 'package:iron_byte/features/home/data/repositories/consultation_mail_repository_impl.dart';
import 'package:iron_byte/features/home/domain/services/consultation_default_message_generator.dart';
import 'package:iron_byte/features/home/domain/usecases/send_consultation_inquiry.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_event.dart';

/// Default wiring for [HomeConsultationBloc] on the standalone consultation route.
HomeConsultationBloc createDefaultHomeConsultationBloc(String? selectedServiceName) {
  return HomeConsultationBloc(
    sendConsultationInquiry: SendConsultationInquiry(
      ConsultationMailRepositoryImpl(),
    ),
    messageGenerator: const ConsultationDefaultMessageGenerator(),
  )..add(HomeConsultationInitialized(serviceName: selectedServiceName));
}
