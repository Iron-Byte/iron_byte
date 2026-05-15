import 'dart:developer' as developer;

/// Persistent debug logging for the consultation booking flow.
abstract final class ConsultationFeatureLog {
  ConsultationFeatureLog._();

  static const String _tag = '[ConsultationFeature]';

  static void d(String message) {
    developer.log(message, name: _tag);
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: _tag,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
