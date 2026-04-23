import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:iron_byte/core/constants/app_constants.dart';
import 'package:iron_byte/core/utils/consultation_schedule.dart';
import '../consultation_attachment_download.dart'
    if (dart.library.html) '../consultation_attachment_download_web.dart';
import '../consultation_attachment_persist.dart'
    if (dart.library.io) '../consultation_attachment_persist_io.dart';
import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';
import 'package:iron_byte/features/home/domain/repositories/consultation_mail_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultationMailRepositoryImpl implements ConsultationMailRepository {
  @override
  Future<void> openConsultationMail({
    required String guestEmail,
    required String note,
    DateTime? preferredSlotUtc,
    ConsultationAttachment? attachment,
  }) async {
    final webBytes = kIsWeb ? attachment?.bytes : null;
    if (webBytes != null && webBytes.isNotEmpty) {
      triggerConsultationAttachmentDownload(webBytes, attachment!.fileName);
    }

    final body = _buildBody(
      guestEmail: guestEmail,
      note: note,
      preferredSlotUtc: preferredSlotUtc,
      attachment: attachment,
      webAttachmentPrompt: kIsWeb && attachment != null,
    );
    const subject = 'Iron Byte consultation request';

    if (!kIsWeb && attachment != null) {
      final path = await persistAttachmentForEmail(attachment);
      final email = Email(
        body: body,
        subject: subject,
        recipients: [AppConstants.supportEmail],
        attachmentPaths: [path],
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
      return;
    }

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
    ConsultationAttachment? attachment,
    required bool webAttachmentPrompt,
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
    if (attachment != null) {
      buffer
        ..writeln()
        ..writeln('Attachment: ${attachment.fileName} '
            '(${attachment.sizeBytes} bytes)');
      if (webAttachmentPrompt) {
        buffer.writeln(
          'The same file should download from the browser — please attach it '
          'in your email before sending.',
        );
      }
    }
    return buffer.toString();
  }
}
