/// Responsive padding and width constraints for the consultation page body.
abstract final class ConsultationPageLayoutMetrics {
  ConsultationPageLayoutMetrics._();

  static double horizontalPadding(double maxWidth) {
    if (maxWidth >= 900) return 72.0;
    if (maxWidth >= 600) return 48.0;
    return 20.0;
  }

  static double cardMaxWidth(double maxWidth) {
    if (maxWidth >= 1200) return 640.0;
    if (maxWidth >= 700) return 560.0;
    return 520.0;
  }
}
