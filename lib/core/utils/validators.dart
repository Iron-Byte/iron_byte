/// Shared input validators for forms across the app.
abstract final class Validators {
  Validators._();

  /// HTML5-style local-part + domain pattern — strict enough for production UX
  /// without attempting full RFC 5322 compliance (which rejects many real addresses).
  static final RegExp emailPattern = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@'
    r'[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?'
    r'(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
  );

  static bool isValidEmail(String value) {
    final trimmed = value.trim();
    return trimmed.isNotEmpty && emailPattern.hasMatch(trimmed);
  }

  /// Returns an [easy_localization] key when invalid, or `null` when valid.
  static String? emailValidationKey(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 'consultation.validation.email_required';
    if (!emailPattern.hasMatch(trimmed)) {
      return 'consultation.validation.email_invalid';
    }
    return null;
  }
}
