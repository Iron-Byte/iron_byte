import 'package:file_picker/file_picker.dart';

abstract class HomeConsultationEvent {}

/// Runs health check and loads booked slots (screen open).
class HomeConsultationBootstrapRequested extends HomeConsultationEvent {}

class HomeConsultationInitialized extends HomeConsultationEvent {
  HomeConsultationInitialized({this.serviceName});

  final String? serviceName;
}

class HomeConsultationNameChanged extends HomeConsultationEvent {
  HomeConsultationNameChanged(this.name);
  final String name;
}

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

class HomeConsultationAttachmentPicked extends HomeConsultationEvent {
  HomeConsultationAttachmentPicked(this.platformFile);
  final PlatformFile platformFile;
}

class HomeConsultationAttachmentCleared extends HomeConsultationEvent {}

class HomeConsultationBookingStatusAcknowledged extends HomeConsultationEvent {}
