import 'package:flutter/material.dart';

enum ServicesCapabilitySection {
  web,
  mobile,
  cloud,
  saas,
  cicd,
  uiux,
  webview,
  animations,
}

class ServicesCapabilityData {
  const ServicesCapabilityData({
    required this.section,
    required this.icon,
    required this.iconBackground,
    required this.titleKey,
    required this.descriptionKey,
    required this.bulletKeys,
    this.illustrationAssetPath,
  });

  final ServicesCapabilitySection section;
  final IconData icon;
  final Color iconBackground;
  final String titleKey;
  final String descriptionKey;
  final List<String> bulletKeys;
  final String? illustrationAssetPath;

  ServicesCapabilityData.section({
    required this.section,
    required this.icon,
    required this.iconBackground,
    required String sectionId,
    this.illustrationAssetPath,
  }) : titleKey = 'services.capabilities.$sectionId.title',
       descriptionKey = 'services.capabilities.$sectionId.description',
       bulletKeys = [
         'services.capabilities.$sectionId.bullet1',
         'services.capabilities.$sectionId.bullet2',
         'services.capabilities.$sectionId.bullet3',
       ];

  static final List<ServicesCapabilityData> items = [
    ServicesCapabilityData.section(
      section: ServicesCapabilitySection.web,
      icon: Icons.public_rounded,
      iconBackground: Color(0xFF1E3A5F),
      sectionId: 'web',
    ),
    ServicesCapabilityData.section(
      section: ServicesCapabilitySection.mobile,
      icon: Icons.smartphone_rounded,
      iconBackground: Color(0xFF2A3F4F),
      sectionId: 'mobile',
    ),
    ServicesCapabilityData.section(
      section: ServicesCapabilitySection.cloud,
      icon: Icons.cloud_queue_rounded,
      iconBackground: Color(0xFF263D4A),
      sectionId: 'cloud',
    ),
    ServicesCapabilityData.section(
      section: ServicesCapabilitySection.saas,
      icon: Icons.rocket_launch_rounded,
      iconBackground: Color(0xFF2F3848),
      sectionId: 'saas',
    ),
    ServicesCapabilityData.section(
      section: ServicesCapabilitySection.cicd,
      icon: Icons.alt_route_rounded,
      iconBackground: Color(0xFF1F3342),
      sectionId: 'cicd',
    ),
    ServicesCapabilityData.section(
      section: ServicesCapabilitySection.uiux,
      icon: Icons.design_services_rounded,
      iconBackground: Color(0xFF30404A),
      sectionId: 'uiux',
    ),
    ServicesCapabilityData.section(
      section: ServicesCapabilitySection.webview,
      icon: Icons.web_asset_rounded,
      iconBackground: Color(0xFF2A3A4A),
      sectionId: 'webview',
    ),
    ServicesCapabilityData.section(
      section: ServicesCapabilitySection.animations,
      icon: Icons.animation_rounded,
      iconBackground: Color(0xFF263347),
      sectionId: 'animations',
    ),
  ];
}

class ServicesHowWeWorkStep {
  const ServicesHowWeWorkStep({
    required this.numberKey,
    required this.titleKey,
    required this.descriptionKey,
  });

  final String numberKey;
  final String titleKey;
  final String descriptionKey;

  static const List<ServicesHowWeWorkStep> steps = [
    ServicesHowWeWorkStep(
      numberKey: 'services.how_we_work.step1.number',
      titleKey: 'services.how_we_work.step1.title',
      descriptionKey: 'services.how_we_work.step1.description',
    ),
    ServicesHowWeWorkStep(
      numberKey: 'services.how_we_work.step2.number',
      titleKey: 'services.how_we_work.step2.title',
      descriptionKey: 'services.how_we_work.step2.description',
    ),
    ServicesHowWeWorkStep(
      numberKey: 'services.how_we_work.step3.number',
      titleKey: 'services.how_we_work.step3.title',
      descriptionKey: 'services.how_we_work.step3.description',
    ),
    ServicesHowWeWorkStep(
      numberKey: 'services.how_we_work.step4.number',
      titleKey: 'services.how_we_work.step4.title',
      descriptionKey: 'services.how_we_work.step4.description',
    ),
  ];
}

enum ServicesPricingPlanKind { starter, growth, enterprise }

class ServicesPricingPlanData {
  const ServicesPricingPlanData({
    required this.kind,
    required this.nameKey,
    required this.priceKey,
    required this.subtitleKey,
    required this.featureKeys,
    required this.ctaKey,
    required this.highlighted,
  });

  final ServicesPricingPlanKind kind;
  final String nameKey;
  final String priceKey;
  final String subtitleKey;
  final List<String> featureKeys;
  final String ctaKey;
  final bool highlighted;

  static const List<ServicesPricingPlanData> plans = [
    ServicesPricingPlanData(
      kind: ServicesPricingPlanKind.starter,
      nameKey: 'services.pricing.starter.name',
      priceKey: 'services.pricing.starter.price',
      subtitleKey: 'services.pricing.starter.subtitle',
      featureKeys: [
        'services.pricing.starter.feature1',
        'services.pricing.starter.feature2',
        'services.pricing.starter.feature3',
        'services.pricing.starter.feature4',
      ],
      ctaKey: 'services.pricing.starter.cta',
      highlighted: false,
    ),
    ServicesPricingPlanData(
      kind: ServicesPricingPlanKind.growth,
      nameKey: 'services.pricing.growth.name',
      priceKey: 'services.pricing.growth.price',
      subtitleKey: 'services.pricing.growth.subtitle',
      featureKeys: [
        'services.pricing.growth.feature1',
        'services.pricing.growth.feature2',
        'services.pricing.growth.feature3',
        'services.pricing.growth.feature4',
        'services.pricing.growth.feature5',
      ],
      ctaKey: 'services.pricing.growth.cta',
      highlighted: true,
    ),
    ServicesPricingPlanData(
      kind: ServicesPricingPlanKind.enterprise,
      nameKey: 'services.pricing.enterprise.name',
      priceKey: 'services.pricing.enterprise.price',
      subtitleKey: 'services.pricing.enterprise.subtitle',
      featureKeys: [
        'services.pricing.enterprise.feature1',
        'services.pricing.enterprise.feature2',
        'services.pricing.enterprise.feature3',
        'services.pricing.enterprise.feature4',
        'services.pricing.enterprise.feature5',
      ],
      ctaKey: 'services.pricing.enterprise.cta',
      highlighted: false,
    ),
  ];
}
