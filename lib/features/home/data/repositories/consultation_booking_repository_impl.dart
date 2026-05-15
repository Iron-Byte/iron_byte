import 'package:iron_byte/features/home/data/datasources/consultation_remote_datasource.dart';
import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';
import 'package:iron_byte/features/home/domain/repositories/consultation_booking_repository.dart';

class ConsultationBookingRepositoryImpl implements ConsultationBookingRepository {
  ConsultationBookingRepositoryImpl(this._remote);

  final ConsultationRemoteDataSource _remote;

  @override
  Future<bool> checkHealth() => _remote.checkHealth();

  @override
  Future<void> createReservation({
    required String name,
    required String email,
    String? note,
    ConsultationAttachment? attachment,
  }) {
    return _remote.createReservation(
      name: name,
      email: email,
      note: note,
      attachment: attachment,
    );
  }
}
