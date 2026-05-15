import 'package:iron_byte/features/home/domain/repositories/consultation_booking_repository.dart';

class CheckConsultationServerHealth {
  CheckConsultationServerHealth(this._repository);

  final ConsultationBookingRepository _repository;

  Future<bool> call() => _repository.checkHealth();
}
