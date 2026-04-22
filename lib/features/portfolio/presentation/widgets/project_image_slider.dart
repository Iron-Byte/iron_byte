import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';

/// Horizontal image carousel with dots; supports touch swipe, mouse drag, and
/// horizontal trackpad/mouse wheel inside nested scroll views (e.g. web).
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

/// Ensures horizontal [PageView] receives drags from mouse / trackpad on web & desktop.
class _HorizontalPagerScrollBehavior extends MaterialScrollBehavior {
  const _HorizontalPagerScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.mouse,
      };
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

  void _goRelative(int delta) {
    if (!_pageController.hasClients || widget.imagePaths.length < 2) return;
    final target = (_page + delta).clamp(0, widget.imagePaths.length - 1);
    if (target == _page) return;
    _pageController.animateToPage(
      target,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (widget.imagePaths.length < 2) return;
    if (event is! PointerScrollEvent) return;

    final d = event.scrollDelta;
    // Prefer horizontal intent so vertical page scroll still works.
    if (d.dx.abs() <= d.dy.abs() * 1.25) return;

    if (d.dx < -2) {
      _goRelative(1);
    } else if (d.dx > 2) {
      _goRelative(-1);
    }
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
          child: ScrollConfiguration(
            behavior: const _HorizontalPagerScrollBehavior(),
            child: Listener(
              onPointerSignal: _onPointerSignal,
              child: PageView.builder(
                controller: _pageController,
                clipBehavior: Clip.hardEdge,
                itemCount: paths.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, index) {
                  return _SliderImage(path: paths[index]);
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(paths.length, (i) {
            final active = i == _page;
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                );
              },
              child: AnimatedContainer(
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
      width: double.infinity,
      height: double.infinity,
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
