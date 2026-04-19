import 'package:flutter/material.dart';

enum PortfolioFilter {
  all,
  webApps,
  mobile,
  backend,
  ecommerce,
}

extension PortfolioFilterKeys on PortfolioFilter {
  String get labelKey {
    switch (this) {
      case PortfolioFilter.all:
        return 'portfolio.filter.all';
      case PortfolioFilter.webApps:
        return 'portfolio.filter.web_apps';
      case PortfolioFilter.mobile:
        return 'portfolio.filter.mobile';
      case PortfolioFilter.backend:
        return 'portfolio.filter.backend';
      case PortfolioFilter.ecommerce:
        return 'portfolio.filter.ecommerce';
    }
  }
}

@immutable
class PortfolioProjectData {
  const PortfolioProjectData({
    required this.filter,
    required this.categoryKey,
    required this.titleKey,
    required this.descriptionKey,
    required this.emojiKey,
    required this.gradient,
    required this.techKeys,
  });

  final PortfolioFilter filter;
  final String categoryKey;
  final String titleKey;
  final String descriptionKey;
  final String emojiKey;
  final LinearGradient gradient;
  final List<String> techKeys;

  static const List<PortfolioProjectData> showcase = [
    PortfolioProjectData(
      filter: PortfolioFilter.webApps,
      categoryKey: 'portfolio.category.web_app',
      titleKey: 'portfolio.projects.meditrack.title',
      descriptionKey: 'portfolio.projects.meditrack.description',
      emojiKey: 'portfolio.projects.meditrack.emoji',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0D2838),
          Color(0xFF1A4D5C),
        ],
      ),
      techKeys: [
        'portfolio.tech.react',
        'portfolio.tech.nodejs',
        'portfolio.tech.postgresql',
      ],
    ),
    PortfolioProjectData(
      filter: PortfolioFilter.ecommerce,
      categoryKey: 'portfolio.category.ecommerce',
      titleKey: 'portfolio.projects.shopflow.title',
      descriptionKey: 'portfolio.projects.shopflow.description',
      emojiKey: 'portfolio.projects.shopflow.emoji',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0D2618),
          Color(0xFF1A3D2E),
        ],
      ),
      techKeys: [
        'portfolio.tech.nextjs',
        'portfolio.tech.stripe',
        'portfolio.tech.aws',
      ],
    ),
    PortfolioProjectData(
      filter: PortfolioFilter.mobile,
      categoryKey: 'portfolio.category.mobile',
      titleKey: 'portfolio.projects.logiroute.title',
      descriptionKey: 'portfolio.projects.logiroute.description',
      emojiKey: 'portfolio.projects.logiroute.emoji',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2A1810),
          Color(0xFF4A3020),
        ],
      ),
      techKeys: [
        'portfolio.tech.flutter',
        'portfolio.tech.firebase',
      ],
    ),
  ];
}
