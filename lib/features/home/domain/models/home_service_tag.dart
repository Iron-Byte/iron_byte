/// Translation key for a service tag shown in the home hero chip area.
class HomeServiceTag {
  const HomeServiceTag(this.translationKey);

  final String translationKey;
}

abstract final class HomeServiceTags {
  HomeServiceTags._();

  static const List<HomeServiceTag> defaults = [
    HomeServiceTag('custom_software_dev'),
    HomeServiceTag('web_dev'),
    HomeServiceTag('mobile_dev'),
    HomeServiceTag('cloud_solutions'),
    HomeServiceTag('saas'),
    HomeServiceTag('ci_cd_automation'),
    HomeServiceTag('ui_ux'),
    HomeServiceTag('web_view_platform_development'),
    HomeServiceTag('2d_animations'),
  ];
}
