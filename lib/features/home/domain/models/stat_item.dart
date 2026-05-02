class StatItem {
  const StatItem({
    required this.valueHeadline,
    required this.labelTranslationKey,
  });

  final String valueHeadline;
  final String labelTranslationKey;

  static const List<StatItem> homeDefaults = [
    StatItem(valueHeadline: '50+', labelTranslationKey: 'projects_delivered'),
    StatItem(valueHeadline: '24/7', labelTranslationKey: 'client_support'),
    StatItem(valueHeadline: '1hr', labelTranslationKey: 'consultation_time'),
  ];
}
