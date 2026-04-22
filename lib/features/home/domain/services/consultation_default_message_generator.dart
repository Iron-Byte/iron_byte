class ConsultationDefaultMessageGenerator {
  const ConsultationDefaultMessageGenerator();

  String call(String? serviceName) {
    final normalized = serviceName?.trim() ?? '';
    if (normalized.isEmpty) return '';
    return 'Hello IronByte,\n\nI\'m interested in your services, especially $normalized.';
  }
}
