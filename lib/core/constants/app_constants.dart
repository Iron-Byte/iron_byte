/// App-wide constant values (contact emails, API endpoints, static configuration).
abstract final class AppConstants {
  AppConstants._();

  static const String supportEmail = 'edgar.papik@gmail.com';
  static const String careersEmail = 'edgar.papik@gmail.com';

  /// Iron Byte REST API base URL (no trailing slash).
  static const String apiBaseUrl = 'https://api.ironbyte.info';

  /// Max consultation attachment size in bytes (10 MB).
  static const int maxConsultationAttachmentBytes = 10 * 1024 * 1024;
}
