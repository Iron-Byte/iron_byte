import 'package:iron_byte/features/home/data/datasources/consultation_remote_datasource.dart';
import 'package:iron_byte/features/home/data/repositories/consultation_booking_repository_impl.dart';
import 'package:iron_byte/features/home/domain/usecases/book_consultation_reservation.dart';
import 'package:iron_byte/features/home/domain/usecases/check_consultation_server_health.dart';

/// Shared API wiring for [HomeConsultationBloc] on home and consultation routes.
final class ConsultationBookingDependencies {
  ConsultationBookingDependencies._();

  static final _remote = ConsultationRemoteDataSource();
  static final _repository = ConsultationBookingRepositoryImpl(_remote);

  static final bookReservation = BookConsultationReservation(_repository);
  static final checkServerHealth = CheckConsultationServerHealth(_repository);
}
