import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';

/// Horizontal image carousel with dots; single image has no pager chrome.
class ProjectImageSlider extends StatefulWidget {
  const ProjectImageSlider({
    super.key,
    required this.imagePaths,
    required this.height,
  });

  final List<String> imagePaths;
  final double height;

  @override
  State<ProjectImageSlider> createState() => _ProjectImageSliderState();
}

class _ProjectImageSliderState extends State<ProjectImageSlider> {
  late final PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paths = widget.imagePaths;

    if (paths.isEmpty) {
      return SizedBox(
        height: widget.height,
        width: double.infinity,
        child: const _NoPreviewPlaceholder(),
      );
    }

    if (paths.length == 1) {
      return SizedBox(
        height: widget.height,
        width: double.infinity,
        child: _SliderImage(path: paths.single),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: paths.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, index) {
              return _SliderImage(path: paths[index]);
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(paths.length, (i) {
            final active = i == _page;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 18 : 7,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: active
                    ? AppColors.primary
                    : AppColors.textMuted.withValues(alpha: 0.45),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _SliderImage extends StatelessWidget {
  const _SliderImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) =>
          const _SliderImageErrorPlaceholder(),
    );
  }
}

class _SliderImageErrorPlaceholder extends StatelessWidget {
  const _SliderImageErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.background,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          size: 40,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

class _NoPreviewPlaceholder extends StatelessWidget {
  const _NoPreviewPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.hide_image_outlined,
              size: 40,
              color: AppColors.textMuted.withValues(alpha: 0.9),
            ),
            const SizedBox(height: AppSpacing.sm8),
            Text(
              'No preview available',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
