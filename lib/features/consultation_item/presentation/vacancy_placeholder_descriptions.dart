/// TEMPORARY placeholder descriptions for job applications on the consultation screen.
/// Replace each value when real vacancy copy is available.
abstract final class VacancyPlaceholderDescriptions {
  VacancyPlaceholderDescriptions._();

  static const String _lorem =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.';

  static const Map<String, String> byVacancyTitleKey = {
    'careers.jobs.senior_fullstack.title': _lorem,
    'careers.jobs.mobile_flutter.title': _lorem,
    'careers.jobs.ux_ui.title': _lorem,
    'careers.jobs.devops.title': _lorem,
    'careers.jobs.pm.title': _lorem,
    'careers.jobs.bd_lead.title': _lorem,
    'services.capabilities.web.title': _lorem,
    'services.capabilities.mobile.title': _lorem,
    'services.capabilities.cloud.title': _lorem,
    'services.capabilities.saas.title': _lorem,
    'services.capabilities.cicd.title': _lorem,
    'services.capabilities.uiux.title': _lorem,
    'services.capabilities.webview.title': _lorem,
    'services.capabilities.animations.title': _lorem,
  };

  static String? forTitleKey(String? titleKey) {
    if (titleKey == null) return null;
    return byVacancyTitleKey[titleKey];
  }
}
