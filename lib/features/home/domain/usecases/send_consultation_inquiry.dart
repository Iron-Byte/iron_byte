import 'package:iron_byte/features/home/domain/repositories/consultation_mail_repository.dart';

class SendConsultationInquiry {
  SendConsultationInquiry(this._repository);

  final ConsultationMailRepository _repository;

  Future<void> call({
    required String guestEmail,
    required String note,
    DateTime? preferredSlotUtc,
  }) {
    return _repository.openConsultationMail(
      guestEmail: guestEmail,
      note: note,
      preferredSlotUtc: preferredSlotUtc,
    );
  }
}
