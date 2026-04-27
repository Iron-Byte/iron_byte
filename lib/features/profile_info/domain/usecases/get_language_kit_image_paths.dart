import 'package:iron_byte/features/profile_info/domain/repositories/language_kit_assets_repository.dart';

class GetLanguageKitImagePaths {
  const GetLanguageKitImagePaths(this._repository);

  final LanguageKitAssetsRepository _repository;

  Future<List<String>> call() => _repository.getLanguageKitImagePaths();
}
