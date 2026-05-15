import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';
import 'package:iron_byte/features/home/domain/repositories/consultation_booking_repository.dart';

class BookConsultationReservation {
  BookConsultationReservation(this._repository);

  final ConsultationBookingRepository _repository;

  Future<void> call({
    required String name,
    required String guestEmail,
    required String note,
    ConsultationAttachment? attachment,
  }) {
    return _repository.createReservation(
      name: name,
      email: guestEmail,
      note: note,
      attachment: attachment,
    );
  }
}
