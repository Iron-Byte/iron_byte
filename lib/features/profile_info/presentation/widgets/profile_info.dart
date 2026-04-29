import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/profile_info/data/datasources/language_kit_assets_local_datasource.dart';
import 'package:iron_byte/features/profile_info/data/repositories/language_kit_assets_repository_impl.dart';
import 'package:iron_byte/features/profile_info/domain/usecases/get_language_kit_image_paths.dart';
import 'package:iron_byte/features/common_widgets/image_carousel.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({
    super.key,
    GetLanguageKitImagePaths? getLanguageKitImagePaths,
  }) : _getLanguageKitImagePaths = getLanguageKitImagePaths;

  final GetLanguageKitImagePaths? _getLanguageKitImagePaths;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late final Future<List<String>> _pathsFuture;

  GetLanguageKitImagePaths _resolveUseCase() {
    return widget._getLanguageKitImagePaths ??
        const GetLanguageKitImagePaths(
          LanguageKitAssetsRepositoryImpl(LanguageKitAssetsLocalDataSource()),
        );
  }

  @override
  void initState() {
    super.initState();
    _pathsFuture = _resolveUseCase().call();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    final horizontal = shortest >= 600 ? AppSpacing.xxl24 : AppSpacing.lg16;

    return FutureBuilder<List<String>>(
      future: _pathsFuture,
      builder: (context, snapshot) {
        final paths = snapshot.data ?? const <String>[];

        Widget carousel = ImageCarousel(imagePaths: paths);

        if (snapshot.connectionState == ConnectionState.waiting &&
            paths.isEmpty) {
          carousel = const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xxl24),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontal,
            padding.top + AppSpacing.lg16,
            horizontal,
            padding.bottom + AppSpacing.xxl24,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: shortest >= 900 ? 960 : double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Language Kit',
                    style: AppTextStyles.labelLarge.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: AppSpacing.sm8),
                  Text(
                    'Carousel previews loaded from assets.',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.xxl24),
                  carousel,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
