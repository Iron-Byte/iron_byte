import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/app_colors.dart';

/// Department colours for the primary role tag (matches design accents).
enum CareersDepartment {
  engineering,
  design,
  operations,
  sales,
}

extension CareersDepartmentX on CareersDepartment {
  Color get tagBackground {
    switch (this) {
      case CareersDepartment.engineering:
        return AppColors.primary;
      case CareersDepartment.design:
        return const Color(0xFFB85C7A);
      case CareersDepartment.operations:
        return const Color(0xFFD4A03A);
      case CareersDepartment.sales:
        return const Color(0xFFCC4F3C);
    }
  }

  String get labelKey {
    switch (this) {
      case CareersDepartment.engineering:
        return 'careers.departments.engineering';
      case CareersDepartment.design:
        return 'careers.departments.design';
      case CareersDepartment.operations:
        return 'careers.departments.operations';
      case CareersDepartment.sales:
        return 'careers.departments.sales';
    }
  }
}

class CareersWhyFeatureData {
  const CareersWhyFeatureData({
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
  });

  final IconData icon;
  final String titleKey;
  final String descriptionKey;

  static const List<CareersWhyFeatureData> features = [
    CareersWhyFeatureData(
      icon: Icons.public_rounded,
      titleKey: 'careers.why.remote_first.title',
      descriptionKey: 'careers.why.remote_first.description',
    ),
    CareersWhyFeatureData(
      icon: Icons.trending_up_rounded,
      titleKey: 'careers.why.ownership.title',
      descriptionKey: 'careers.why.ownership.description',
    ),
    CareersWhyFeatureData(
      icon: Icons.track_changes_rounded,
      titleKey: 'careers.why.learning.title',
      descriptionKey: 'careers.why.learning.description',
    ),
    CareersWhyFeatureData(
      icon: Icons.schedule_rounded,
      titleKey: 'careers.why.flexible.title',
      descriptionKey: 'careers.why.flexible.description',
    ),
  ];
}

class CareerOpeningData {
  const CareerOpeningData({
    required this.titleKey,
    required this.department,
    required this.metaTagKeys,
    this.stackKey,
  });

  final String titleKey;
  final CareersDepartment department;
  final List<String> metaTagKeys;
  final String? stackKey;

  static const List<CareerOpeningData> openings = [
    CareerOpeningData(
      titleKey: 'careers.jobs.senior_fullstack.title',
      department: CareersDepartment.engineering,
      metaTagKeys: [
        'careers.tags.remote',
        'careers.tags.full_time',
      ],
      stackKey: 'careers.jobs.senior_fullstack.stack',
    ),
    CareerOpeningData(
      titleKey: 'careers.jobs.mobile_flutter.title',
      department: CareersDepartment.engineering,
      metaTagKeys: [
        'careers.tags.remote',
        'careers.tags.full_time',
      ],
      stackKey: 'careers.jobs.mobile_flutter.stack',
    ),
    CareerOpeningData(
      titleKey: 'careers.jobs.ux_ui.title',
      department: CareersDepartment.design,
      metaTagKeys: [
        'careers.tags.remote',
        'careers.tags.full_time',
      ],
      stackKey: 'careers.jobs.ux_ui.stack',
    ),
    CareerOpeningData(
      titleKey: 'careers.jobs.devops.title',
      department: CareersDepartment.engineering,
      metaTagKeys: [
        'careers.tags.remote',
        'careers.tags.contract',
      ],
      stackKey: 'careers.jobs.devops.stack',
    ),
    CareerOpeningData(
      titleKey: 'careers.jobs.pm.title',
      department: CareersDepartment.operations,
      metaTagKeys: [
        'careers.tags.remote',
        'careers.tags.full_time',
      ],
    ),
    CareerOpeningData(
      titleKey: 'careers.jobs.bd_lead.title',
      department: CareersDepartment.sales,
      metaTagKeys: [
        'careers.tags.hybrid',
        'careers.tags.full_time',
      ],
    ),
  ];
}
