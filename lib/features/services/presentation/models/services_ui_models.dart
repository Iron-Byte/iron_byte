import 'package:flutter/material.dart';

class ServicesCapabilityData {
  const ServicesCapabilityData({
    required this.icon,
    required this.iconBackground,
    required this.titleKey,
    required this.descriptionKey,
    required this.bulletKeys,
  });

  final IconData icon;
  final Color iconBackground;
  final String titleKey;
  final String descriptionKey;
  final List<String> bulletKeys;

  static const List<ServicesCapabilityData> items = [
    ServicesCapabilityData(
      icon: Icons.public_rounded,
      iconBackground: Color(0xFF1E3A5F),
      titleKey: 'services.capabilities.web.title',
      descriptionKey: 'services.capabilities.web.description',
      bulletKeys: [
        'services.capabilities.web.bullet1',
        'services.capabilities.web.bullet2',
        'services.capabilities.web.bullet3',
      ],
    ),
    ServicesCapabilityData(
      icon: Icons.smartphone_rounded,
      iconBackground: Color(0xFF2A3F4F),
      titleKey: 'services.capabilities.mobile.title',
      descriptionKey: 'services.capabilities.mobile.description',
      bulletKeys: [
        'services.capabilities.mobile.bullet1',
        'services.capabilities.mobile.bullet2',
        'services.capabilities.mobile.bullet3',
      ],
    ),
    ServicesCapabilityData(
      icon: Icons.settings_rounded,
      iconBackground: Color(0xFF263D4A),
      titleKey: 'services.capabilities.backend.title',
      descriptionKey: 'services.capabilities.backend.description',
      bulletKeys: [
        'services.capabilities.backend.bullet1',
        'services.capabilities.backend.bullet2',
        'services.capabilities.backend.bullet3',
      ],
    ),
    ServicesCapabilityData(
      icon: Icons.shopping_cart_outlined,
      iconBackground: Color(0xFF2F3848),
      titleKey: 'services.capabilities.ecommerce.title',
      descriptionKey: 'services.capabilities.ecommerce.description',
      bulletKeys: [
        'services.capabilities.ecommerce.bullet1',
        'services.capabilities.ecommerce.bullet2',
        'services.capabilities.ecommerce.bullet3',
      ],
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
