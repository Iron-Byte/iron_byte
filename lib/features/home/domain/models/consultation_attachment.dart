import 'dart:typed_data';

/// User-selected file metadata for a consultation / job application inquiry.
class ConsultationAttachment {
  const ConsultationAttachment({
    required this.fileName,
    required this.sizeBytes,
    this.filePath,
    this.bytes,
  });

  final String fileName;
  final int sizeBytes;
  final String? filePath;
  final Uint8List? bytes;
}
