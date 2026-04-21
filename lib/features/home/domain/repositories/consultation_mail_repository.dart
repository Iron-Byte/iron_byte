/// Opens a mail composer to contact support (mailto — no backend required).
abstract class ConsultationMailRepository {
  Future<void> openConsultationMail({
    required String guestEmail,
    required String note,
    DateTime? preferredSlotUtc,
  });
}
