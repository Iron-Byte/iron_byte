import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/portfolio/domain/entities/portfolio_project.dart';

/// Full-width portfolio row with all project images shown together.
class PortfolioProjectRow extends StatelessWidget {
  const PortfolioProjectRow({
    super.key,
    required this.project,
  });

  final PortfolioProject project;

  static const double _imageHeight = 720;
  static const double _imageWidth = 320;

  @override
  Widget build(BuildContext context) {
    final description = project.description.trim().isEmpty
        ? 'No description available.'
        : project.description;

    return Material(
      color: AppColors.primaryBg,
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.24),
      borderRadius: AppRadius.borderLg16,
      child: Padding(
        padding: AppSpacing.allLg16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProjectImagesRow(imagePaths: project.imagePaths),
            const SizedBox(height: AppSpacing.lg16),
            Text(
              project.name,
              style: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: AppSpacing.sm8),
            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectImagesRow extends StatelessWidget {
  const _ProjectImagesRow({required this.imagePaths});

  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) {
      return const _NoImageTile();
    }

    return _HorizontalImageStrip(imagePaths: imagePaths);
  }
}

/// Isolates horizontal scrolling so trackpad gestures don't bubble into route/nav behavior.
class _HorizontalImageStrip extends StatefulWidget {
  const _HorizontalImageStrip({required this.imagePaths});

  final List<String> imagePaths;

  @override
  State<_HorizontalImageStrip> createState() => _HorizontalImageStripState();
}

class _HorizontalImageStripState extends State<_HorizontalImageStrip> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: PortfolioProjectRow._imageHeight,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.mouse,
          },
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            primary: false,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.imagePaths.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.md12),
            itemBuilder: (context, index) {
              return _ImageTile(path: widget.imagePaths[index]);
            },
          ),
        ),
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.borderMd12,
      child: Container(
      
        color: AppColors.primaryBg,
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          gaplessPlayback: true,
          filterQuality: FilterQuality.high,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(
              Icons.broken_image_outlined,
              size: 40,
              color: AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

class _NoImageTile extends StatelessWidget {
  const _NoImageTile();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.borderMd12,
      child: Container(
        width: PortfolioProjectRow._imageWidth,
        height: PortfolioProjectRow._imageHeight,
        color: AppColors.background,
        child: Center(
          child: Text(
            'No preview available',
            style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          ),
        ),
      ),
    );
  }
}
