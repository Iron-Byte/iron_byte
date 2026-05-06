import 'package:flutter/material.dart';
import 'package:iron_byte/assets/image_paths.dart';

class AboutStatData {
  const AboutStatData({required this.valueKey, required this.labelKey});

  final String valueKey;
  final String labelKey;

  static const List<AboutStatData> stats = [
    AboutStatData(
      valueKey: 'about.stats.founded.value',
      labelKey: 'about.stats.founded.label',
    ),
    AboutStatData(
      valueKey: 'about.stats.projects.value',
      labelKey: 'about.stats.projects.label',
    ),
    AboutStatData(
      valueKey: 'about.stats.countries.value',
      labelKey: 'about.stats.countries.label',
    ),
    AboutStatData(
      valueKey: 'about.stats.retention.value',
      labelKey: 'about.stats.retention.label',
    ),
  ];
}

class AboutValuePillarData {
  const AboutValuePillarData({
    required this.indexKey,
    required this.titleKey,
    required this.bodyKey,
  });

  final String indexKey;
  final String titleKey;
  final String bodyKey;

  static const List<AboutValuePillarData> pillars = [
    AboutValuePillarData(
      indexKey: 'about.values.1.index',
      titleKey: 'about.values.1.title',
      bodyKey: 'about.values.1.body',
    ),
    AboutValuePillarData(
      indexKey: 'about.values.2.index',
      titleKey: 'about.values.2.title',
      bodyKey: 'about.values.2.body',
    ),
    AboutValuePillarData(
      indexKey: 'about.values.3.index',
      titleKey: 'about.values.3.title',
      bodyKey: 'about.values.3.body',
    ),
  ];
}

class AboutSocialLinkData {
  const AboutSocialLinkData({required this.labelKey, required this.uri});

  final String labelKey;
  final Uri uri;
}

class AboutTeamMemberData {
  const AboutTeamMemberData({
    required this.initials,
    required this.avatarColor,
    required this.nameKey,
    required this.roleKey,
    required this.links,
    this.avatarImage,
  });

  final String initials;
  final String? avatarImage;
  final Color avatarColor;
  final String nameKey;
  final String roleKey;
  final List<AboutSocialLinkData> links;

  static final List<AboutTeamMemberData> team = [
    AboutTeamMemberData(
      initials: 'EP',
      avatarImage: MembersPaths.kit01,
      avatarColor: Color(0xFF2563EB),
      nameKey: 'Edgar Papikyan',
      roleKey: 'Co-Founder & CEO',
      links: [
        AboutSocialLinkData(
          labelKey: 'about.team.social.linkedin',
          uri: Uri.parse('https://www.linkedin.com'),
        ),
      ],
    ),
    AboutTeamMemberData(
      initials: 'KH',
      avatarImage: MembersPaths.kit02,
      avatarColor: Color(0xFF92400E),
      nameKey: 'Knyaz Harutyunyan',
      roleKey: 'Co-Founder & CEO',
      links: [
        AboutSocialLinkData(
          labelKey: 'about.team.social.linkedin',
          uri: Uri.parse('https://www.linkedin.com'),
        ),
      ],
    ),

    AboutTeamMemberData(
      initials: 'SP',
      avatarColor: Color(0xFF9333EA),
      nameKey: 'about.team.sara.name',
      roleKey: 'about.team.sara.role',
      links: [
        AboutSocialLinkData(
          labelKey: 'about.team.social.linkedin',
          uri: Uri.parse('https://www.linkedin.com'),
        ),
      ],
    ),
  ];
}
