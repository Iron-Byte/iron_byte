/// Thrown when the consultation booking API returns an error or cannot be reached.
class ConsultationApiException implements Exception {
  ConsultationApiException({
    required this.messageKey,
    this.serverMessage,
    this.statusCode,
  });

  /// [easy_localization] key shown to the user.
  final String messageKey;

  /// Optional message from the API response body.
  final String? serverMessage;

  final int? statusCode;

  @override
  String toString() =>
      serverMessage ?? messageKey;
}
