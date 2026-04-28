import 'package:path/path.dart' as p;

/// Max attachment size for consultation / job application uploads.
const int kConsultationAttachmentMaxBytes = 10 * 1024 * 1024;

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
