import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';

/// Backend API for consultation meeting reservations.
abstract class ConsultationBookingRepository {
  Future<bool> checkHealth();

  Future<void> createReservation({
    required String name,
    required String email,
    String? note,
    ConsultationAttachment? attachment,
  });
}
