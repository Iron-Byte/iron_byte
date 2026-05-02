import 'dart:io';

import 'package:iron_byte/features/home/domain/models/consultation_attachment.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String> persistAttachmentForEmail(
  ConsultationAttachment attachment,
) async {
  final existing = attachment.filePath;
  if (existing != null && existing.isNotEmpty) {
    final f = File(existing);
    if (await f.exists()) return existing;
  }
  final bytes = attachment.bytes;
  if (bytes == null) {
    throw StateError('Attachment has no readable path or bytes.');
  }
  final dir = await getTemporaryDirectory();
  final safeName = p.basename(attachment.fileName);
  final path = p.join(
    dir.path,
    'consult_${DateTime.now().millisecondsSinceEpoch}_$safeName',
  );
  await File(path).writeAsBytes(bytes, flush: true);
  return path;
}
