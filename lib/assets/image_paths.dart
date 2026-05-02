/// Canonical [ImageKey] → full asset paths for bundled rasters under
/// `assets/images/pictures/`. Add new files here when you add images.
library;

const String kPicturesRoot = 'assets/images/pictures';

/// Short filename keys (no directory) for lookup via [imagePathByKey].
abstract final class ImageKey {
  // language_kit
  static const languageKit01 = 'language_kit_01.webp';
  static const languageKit02 = 'language_kit_02.webp';
  static const languageKit03 = 'language_kit_03.webp';
  static const languageKit04 = 'language_kit_04.webp';
  static const languageKit05 = 'language_kit_05.webp';
  static const languageKit05Typo = 'langauage_kit_05.webp';

  // migrane_app
  static const migraneApp01 = 'migrane_app_01.webp';
  static const migraneApp02 = 'migrane_app_02.webp';
  static const migraneApp03 = 'migrane_app_03.webp';
  static const migraneApp04 = 'migrane_app_04.webp';
  static const migraneApp05 = 'migrane_app_05.webp';

  // numis_ai
  static const numisAi01 = 'numis_ai_01.webp';
  static const numisAi02 = 'numsi_ai_02.webp';
  static const numisAi03 = 'numsi_ai_03.webp';
  static const numisAi04 = 'numsi_ai_04.webp';
  static const numisAi05 = 'numsi_ai_05.webp';

  // symptom_tracker
  static const symptomTracker = 'symptom_tracker.webp';
  static const symptomTracker02 = 'symptom_tracker_02.webp';
  static const symptomTracker03 = 'symptom_tracker_03.webp';
  static const symptomTracker04 = 'symptom_tracker_04.webp';

  // vibe_kit
  static const vibeKit = 'vibe_kit.webp';
  static const vibeKit02 = 'vibe_kit_02.webp';
  static const vibeKit03 = 'vibe_kit_03.webp';
  static const vibeKit04 = 'vibe_kit_04.webp';
  static const vibeKit05 = 'vibe_kit_05.webp';
}

abstract final class LanguageKitPaths {
  static const String _d = '$kPicturesRoot/language_kit';

  static const kit01 = '$_d/${ImageKey.languageKit01}';
  static const kit02 = '$_d/${ImageKey.languageKit02}';
  static const kit03 = '$_d/${ImageKey.languageKit03}';
  static const kit04 = '$_d/${ImageKey.languageKit04}';
  static const kit05 = '$_d/${ImageKey.languageKit05}';
  static const kit05TypoDuplicate = '$_d/${ImageKey.languageKit05Typo}';

  /// Order used for carousels (canonical five; excludes the duplicate typo file).
  static const List<String> carousel = [kit01, kit02, kit03, kit04, kit05];
}

abstract final class MigraneAppPaths {
  static const String _d = '$kPicturesRoot/migrane_app';
  static const shot01 = '$_d/${ImageKey.migraneApp01}';
  static const shot02 = '$_d/${ImageKey.migraneApp02}';
  static const shot03 = '$_d/${ImageKey.migraneApp03}';
  static const shot04 = '$_d/${ImageKey.migraneApp04}';
  static const shot05 = '$_d/${ImageKey.migraneApp05}';
  static const List<String> carousel = [shot01, shot02, shot03, shot04, shot05];
}

abstract final class NumisAiPaths {
  static const String _d = '$kPicturesRoot/numis_ai';

  static const shot01 = '$_d/${ImageKey.numisAi01}';
  static const shot02 = '$_d/${ImageKey.numisAi02}';
  static const shot03 = '$_d/${ImageKey.numisAi03}';
  static const shot04 = '$_d/${ImageKey.numisAi04}';
  static const shot05 = '$_d/${ImageKey.numisAi05}';
  static const List<String> carousel = [shot01, shot02, shot03, shot04, shot05];
}

abstract final class SymptomTrackerPaths {
  static const String _d = '$kPicturesRoot/symptom_tracker';

  static const cover = '$_d/${ImageKey.symptomTracker}';
  static const shot02 = '$_d/${ImageKey.symptomTracker02}';
  static const shot03 = '$_d/${ImageKey.symptomTracker03}';
  static const shot04 = '$_d/${ImageKey.symptomTracker04}';
  static const List<String> carousel = [cover, shot02, shot03, shot04];
}

abstract final class VibeKitPaths {
  static const String _d = '$kPicturesRoot/vibe_kit';

  static const cover = '$_d/${ImageKey.vibeKit}';
  static const shot02 = '$_d/${ImageKey.vibeKit02}';
  static const shot03 = '$_d/${ImageKey.vibeKit03}';
  static const shot04 = '$_d/${ImageKey.vibeKit04}';
  static const shot05 = '$_d/${ImageKey.vibeKit05}';
  static const List<String> carousel = [cover, shot02, shot03, shot04, shot05];
}

/// Every picture asset keyed by its filename (last segment), for dynamic lookup.
final Map<String, String> imagePathByKey = Map<String, String>.unmodifiable({
  ImageKey.languageKit01: LanguageKitPaths.kit01,
  ImageKey.languageKit02: LanguageKitPaths.kit02,
  ImageKey.languageKit03: LanguageKitPaths.kit03,
  ImageKey.languageKit04: LanguageKitPaths.kit04,
  ImageKey.languageKit05: LanguageKitPaths.kit05,
  ImageKey.languageKit05Typo: LanguageKitPaths.kit05TypoDuplicate,
  ImageKey.migraneApp01: MigraneAppPaths.shot01,
  ImageKey.migraneApp02: MigraneAppPaths.shot02,
  ImageKey.migraneApp03: MigraneAppPaths.shot03,
  ImageKey.migraneApp04: MigraneAppPaths.shot04,
  ImageKey.migraneApp05: MigraneAppPaths.shot05,
  ImageKey.numisAi01: NumisAiPaths.shot01,
  ImageKey.numisAi02: NumisAiPaths.shot02,
  ImageKey.numisAi03: NumisAiPaths.shot03,
  ImageKey.numisAi04: NumisAiPaths.shot04,
  ImageKey.numisAi05: NumisAiPaths.shot05,
  ImageKey.symptomTracker: SymptomTrackerPaths.cover,
  ImageKey.symptomTracker02: SymptomTrackerPaths.shot02,
  ImageKey.symptomTracker03: SymptomTrackerPaths.shot03,
  ImageKey.symptomTracker04: SymptomTrackerPaths.shot04,
  ImageKey.vibeKit: VibeKitPaths.cover,
  ImageKey.vibeKit02: VibeKitPaths.shot02,
  ImageKey.vibeKit03: VibeKitPaths.shot03,
  ImageKey.vibeKit04: VibeKitPaths.shot04,
  ImageKey.vibeKit05: VibeKitPaths.shot05,
});

/// Resolves [key] from [imagePathByKey], e.g. `language_kit_01.webp`.
String? imagePathForKey(String key) => imagePathByKey[key];
