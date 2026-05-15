import 'package:iron_byte/features/home/domain/repositories/consultation_booking_repository.dart';

class LoadConsultationBookedSlots {
  LoadConsultationBookedSlots(this._repository);

  final ConsultationBookingRepository _repository;

  Future<List<DateTime>> call() => _repository.getBookedSlots();
}
