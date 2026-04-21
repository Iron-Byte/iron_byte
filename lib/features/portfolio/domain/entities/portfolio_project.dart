import 'package:flutter/foundation.dart';

/// Portfolio grid item (ids 0–6). [imagePaths] lists every image in the project folder (slider).
@immutable
class PortfolioProject {
  const PortfolioProject({
    required this.id,
    required this.name,
    required this.imagePaths,
    this.description = '',
  });

  final int id;
  final String name;
  final List<String> imagePaths;
  final String description;

  bool get hasImages => imagePaths.isNotEmpty;
}
