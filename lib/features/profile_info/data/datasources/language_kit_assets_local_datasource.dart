import 'package:flutter/services.dart';

class LanguageKitAssetsLocalDataSource {
  const LanguageKitAssetsLocalDataSource();

  static const String _folderPrefix = 'assets/images/pictures/language_kit/';

  Future<List<String>> loadLanguageKitImagePaths() async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final paths =
        manifest.listAssets().where(_isLanguageKitRasterAsset).toSet().toList()
          ..sort();
    return List<String>.unmodifiable(paths);
  }

  bool _isLanguageKitRasterAsset(String path) {
    if (!path.startsWith(_folderPrefix)) return false;
    final lower = path.toLowerCase();
    return lower.endsWith('.webp') ||
        lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif');
  }
}
