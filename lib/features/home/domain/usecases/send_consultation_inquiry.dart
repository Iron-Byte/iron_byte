import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';
import 'package:iron_byte/features/home/domain/repositories/consultation_mail_repository.dart';

class SendConsultationInquiry {
  SendConsultationInquiry(this._repository);

  final ConsultationMailRepository _repository;

  Future<void> call({
    required String guestEmail,
    required String note,
    DateTime? preferredSlotUtc,
    ConsultationAttachment? attachment,
  }) {
    return _repository.openConsultationMail(
      guestEmail: guestEmail,
      note: note,
      preferredSlotUtc: preferredSlotUtc,
      attachment: attachment,
    );
  }
}
