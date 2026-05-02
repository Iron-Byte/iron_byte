import 'package:iron_byte/features/profile_info/data/datasources/language_kit_assets_local_datasource.dart';
import 'package:iron_byte/features/profile_info/domain/repositories/language_kit_assets_repository.dart';

class LanguageKitAssetsRepositoryImpl implements LanguageKitAssetsRepository {
  const LanguageKitAssetsRepositoryImpl(this._localDataSource);

  final LanguageKitAssetsLocalDataSource _localDataSource;

  @override
  Future<List<String>> getLanguageKitImagePaths() =>
      _localDataSource.loadLanguageKitImagePaths();
}
