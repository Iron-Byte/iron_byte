abstract class HomeConsultationEvent {}

class HomeConsultationEmailChanged extends HomeConsultationEvent {
  HomeConsultationEmailChanged(this.email);
  final String email;
}

class HomeConsultationMessageChanged extends HomeConsultationEvent {
  HomeConsultationMessageChanged(this.message);
  final String message;
}

class HomeConsultationSendRequested extends HomeConsultationEvent {}

class HomeConsultationPreferredSlotChanged extends HomeConsultationEvent {
  HomeConsultationPreferredSlotChanged(this.slotUtc);
  final DateTime? slotUtc;
}
