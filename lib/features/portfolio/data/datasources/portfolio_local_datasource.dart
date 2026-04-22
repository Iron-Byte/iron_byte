import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:iron_byte/features/portfolio/domain/entities/portfolio_project.dart';

/// Local catalog + optional `order` from JSON.
class PortfolioLocalDataSource {
  static const String _orderAssetPath =
      'assets/data/portfolio_project_order.json';

  /// Paths sorted lexicographically by filename.
  static const List<PortfolioProject> _allProjects = <PortfolioProject>[
    PortfolioProject(
      id: 0,
      name: 'language_kit',
      imagePaths: <String>[
        'assets/images/pictures/language_kit/langauage_kit_05.webp',
        'assets/images/pictures/language_kit/language_kit_01.webp',
        'assets/images/pictures/language_kit/language_kit_02.webp',
        'assets/images/pictures/language_kit/language_kit_03.webp',
        'assets/images/pictures/language_kit/language_kit_04.webp',
        'assets/images/pictures/language_kit/language_kit_05.webp',
      ],
      description: '',
    ),
    PortfolioProject(
      id: 1,
      name: 'migrane_app',
      imagePaths: <String>[
        'assets/images/pictures/migrane_app/migrane_app_01.webp',
        'assets/images/pictures/migrane_app/migrane_app_02.webp',
        'assets/images/pictures/migrane_app/migrane_app_03.webp',
        'assets/images/pictures/migrane_app/migrane_app_04.webp',
        'assets/images/pictures/migrane_app/migrane_app_05.webp',
      ],
      description: '',
    ),
    PortfolioProject(
      id: 2,
      name: 'numis_ai',
      imagePaths: <String>[
        'assets/images/pictures/numis_ai/numis_ai_01.webp',
        'assets/images/pictures/numis_ai/numsi_ai_02.webp',
        'assets/images/pictures/numis_ai/numsi_ai_03.webp',
        'assets/images/pictures/numis_ai/numsi_ai_04.webp',
        'assets/images/pictures/numis_ai/numsi_ai_05.webp',
      ],
      description: '',
    ),
    PortfolioProject(
      id: 3,
      name: 'symptom_tracker',
      imagePaths: <String>[
        'assets/images/pictures/symptom_tracker/symptom_tracker.webp',
        'assets/images/pictures/symptom_tracker/symptom_tracker_02.webp',
        'assets/images/pictures/symptom_tracker/symptom_tracker_03.webp',
        'assets/images/pictures/symptom_tracker/symptom_tracker_04.webp',
      ],
      description: '',
    ),
    PortfolioProject(
      id: 4,
      name: 'vibe_kit',
      imagePaths: <String>[
        'assets/images/pictures/vibe_kit/vibe_kit.webp',
        'assets/images/pictures/vibe_kit/vibe_kit_02.webp',
        'assets/images/pictures/vibe_kit/vibe_kit_03.webp',
        'assets/images/pictures/vibe_kit/vibe_kit_04.webp',
        'assets/images/pictures/vibe_kit/vibe_kit_05.webp',
      ],
      description: '',
    ),
    PortfolioProject(
      id: 5,
      name: 'project_5',
      imagePaths: <String>[],
      description: '',
    ),
    PortfolioProject(
      id: 6,
      name: 'project_6',
      imagePaths: <String>[],
      description: '',
    ),
  ];

  Future<List<PortfolioProject>> loadProjectsOrdered() async {
    try {
      final raw = await rootBundle.loadString(_orderAssetPath);
      final decoded = json.decode(raw) as Map<String, dynamic>;
      final orderRaw = decoded['order'] as List<dynamic>?;
      if (orderRaw == null || orderRaw.isEmpty) {
        return List<PortfolioProject>.unmodifiable(_allProjects);
      }

      final byId = {for (final p in _allProjects) p.id: p};
      final seen = <int>{};
      final out = <PortfolioProject>[];

      for (final entry in orderRaw) {
        final id = entry is int ? entry : int.tryParse('$entry') ?? -1;
        if (id < 0 || seen.contains(id)) continue;
        final project = byId[id];
        if (project != null) {
          out.add(project);
          seen.add(id);
        }
      }

      for (final p in _allProjects) {
        if (!seen.contains(p.id)) out.add(p);
      }

      return List<PortfolioProject>.unmodifiable(out);
    } catch (_) {
      return List<PortfolioProject>.unmodifiable(_allProjects);
    }
  }
}
