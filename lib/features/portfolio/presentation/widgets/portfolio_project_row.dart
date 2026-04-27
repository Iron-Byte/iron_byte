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
            SelectableText(
              project.name,
              style: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: AppSpacing.sm8),
            SelectableText(
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final imageHeight = maxW >= 1200
            ? 560.0
            : (maxW >= 900 ? 480.0 : (maxW >= 700 ? 360.0 : 280.0));
        final imageWidth = maxW >= 1200
            ? 300.0
            : (maxW >= 900 ? 260.0 : (maxW >= 700 ? 220.0 : 180.0));
        return RepaintBoundary(
          child: SizedBox(
            height: imageHeight,
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
                    return _ImageTile(
                      path: widget.imagePaths[index],
                      width: imageWidth,
                      height: imageHeight,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({
    required this.path,
    required this.width,
    required this.height,
  });

  final String path;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.borderMd12,
      child: Container(
        width: width,
        height: height,
        color: AppColors.primaryBg,
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          gaplessPlayback: true,
          filterQuality: FilterQuality.medium,
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
    final maxW = MediaQuery.sizeOf(context).width;
    final width = maxW >= 1200 ? 300.0 : (maxW >= 700 ? 220.0 : 180.0);
    final height = maxW >= 1200
        ? 560.0
        : (maxW >= 900 ? 480.0 : (maxW >= 700 ? 360.0 : 280.0));
    return ClipRRect(
      borderRadius: AppRadius.borderMd12,
      child: Container(
        width: width,
        height: height,
        color: AppColors.background,
        child: Center(
          child: SelectableText(
            'No preview available',
            style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          ),
        ),
      ),
    );
  }
}
