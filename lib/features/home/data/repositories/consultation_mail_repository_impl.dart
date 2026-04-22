import 'package:iron_byte/core/constants/app_constants.dart';
import 'package:iron_byte/core/utils/consultation_schedule.dart';
import 'package:iron_byte/features/home/domain/repositories/consultation_mail_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultationMailRepositoryImpl implements ConsultationMailRepository {
  @override
  Future<void> openConsultationMail({
    required String guestEmail,
    required String note,
    DateTime? preferredSlotUtc,
  }) async {
    final body = _buildBody(
      guestEmail: guestEmail,
      note: note,
      preferredSlotUtc: preferredSlotUtc,
    );
    final subject = 'Iron Byte consultation request';
    final uri = Uri(
      scheme: 'mailto',
      path: AppConstants.supportEmail,
      queryParameters: <String, String>{
        'subject': subject,
        'body': body,
      },
    );

    if (!await canLaunchUrl(uri)) {
      throw StateError('No application available to handle email.');
    }
    final launched =
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw StateError('Could not open mail composer.');
    }
  }

  String _buildBody({
    required String guestEmail,
    required String note,
    DateTime? preferredSlotUtc,
  }) {
    final buffer = StringBuffer()
      ..writeln('Guest email: $guestEmail')
      ..writeln();
    final trimmedNote = note.trim();
    if (trimmedNote.isNotEmpty) {
      buffer
        ..writeln('Note:')
        ..writeln(trimmedNote)
        ..writeln();
    }
    if (preferredSlotUtc != null) {
      buffer.writeln(
        'Preferred consultation slot: '
        '${formatConsultationSlotForBody(preferredSlotUtc)}',
      );
    }
    return buffer.toString();
  }
}
