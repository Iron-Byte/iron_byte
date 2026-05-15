import 'package:iron_byte/core/constants/app_constants.dart';
import 'package:path/path.dart' as p;

/// Max attachment size for consultation / job application uploads.
int get kConsultationAttachmentMaxBytes =>
    AppConstants.maxConsultationAttachmentBytes;

const Set<String> kConsultationAttachmentExtensions = {
  'pdf',
  'doc',
  'docx',
  'png',
  'jpg',
  'jpeg',
};

bool isAllowedConsultationAttachmentName(String fileName) {
  final ext = p.extension(fileName).toLowerCase();
  if (ext.length < 2) return false;
  return kConsultationAttachmentExtensions.contains(ext.substring(1));
}
