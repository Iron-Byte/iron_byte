import 'dart:async' show unawaited;
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';

/// Reusable horizontal image carousel with page snapping, scaling, fade
/// transitions, and optional dot indicator.
///
/// Notes:
/// - This widget currently works with asset paths (`Image.asset`).
/// - It optionally precaches all images to avoid decode “pops” while paging.
class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.imagePaths,
    this.aspectRatio = 9.5 / 16,
    this.viewportFraction = 0.33, // 0.78,
    this.itemSpacing = 22,
    this.activeScaleBoost = 1.06,
    this.imageFit = BoxFit.cover,

    /// Inset for the pager so scaled “active” slides are not clipped by an
    /// outer [ClipRect].
    this.horizontalClipGutter = 0,
    this.borderRadius = AppRadius.borderMd12,
    this.pageIndicator = true,
    this.precacheImages = true,
    this.placeholderText = 'No images',
  });

  final List<String> imagePaths;
  final double aspectRatio;
  final double viewportFraction;
  final double itemSpacing;
  final double activeScaleBoost;

  /// [BoxFit.cover] fills the frame but crops; [BoxFit.contain] shows the full image.
  final BoxFit imageFit;
  final double horizontalClipGutter;
  final BorderRadius borderRadius;
  final bool pageIndicator;
  final bool precacheImages;
  final String placeholderText;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

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

class _ImageCarouselState extends State<ImageCarousel> {
  late final CarouselController _carouselController;

  /// Settled index for dots; [ValueNotifier] avoids [setState] full rebuild on snap.
  late final ValueNotifier<int> _settledPage;
  late final ValueNotifier<double> _scrollItemValue;
  String? _loadedSignature;
  bool _allImagesReady = false;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    _carouselController.addListener(_syncScrollState);
    _settledPage = ValueNotifier(0);
    _scrollItemValue = ValueNotifier(0);
    _allImagesReady = !widget.precacheImages;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.precacheImages) {
      unawaited(_loadAllImages());
    }
  }

  @override
  void didUpdateWidget(covariant ImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.precacheImages != widget.precacheImages) {
      setState(() => _allImagesReady = !widget.precacheImages);
      if (widget.precacheImages) unawaited(_loadAllImages());
      return;
    }

    if (!widget.precacheImages) return;

    if (!_samePathList(oldWidget.imagePaths, widget.imagePaths)) {
      setState(() => _allImagesReady = false);
      unawaited(_loadAllImages());
    }
  }

  bool _samePathList(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  /// Wait until every asset is decoded so paging only slides in-memory bitmaps.
  Future<void> _loadAllImages() async {
    final paths = widget.imagePaths;
    if (paths.isEmpty) {
      if (mounted) setState(() => _allImagesReady = false);
      return;
    }

    final sig = paths.join('\u0001');
    if (_loadedSignature == sig && _allImagesReady) return;

    await Future.wait([
      for (final path in paths) precacheImage(AssetImage(path), context),
    ]);

    if (!mounted) return;
    if (widget.imagePaths.join('\u0001') != sig) return;

    setState(() {
      _allImagesReady = true;
      _loadedSignature = sig;
    });
  }

  @override
  void dispose() {
    _carouselController.removeListener(_syncScrollState);
    _carouselController.dispose();
    _settledPage.dispose();
    _scrollItemValue.dispose();
    super.dispose();
  }

  double _carouselItemExtent(double viewportWidth) {
    return (viewportWidth * widget.viewportFraction).clamp(1.0, viewportWidth);
  }

  void _syncScrollState() {
    if (!_carouselController.hasClients || widget.imagePaths.isEmpty) return;
    final position = _carouselController.position;
    final viewport = position.viewportDimension;
    if (viewport <= 0) return;
    final itemExtent = _carouselItemExtent(viewport);
    final rawItem = (position.pixels / itemExtent).clamp(
      0.0,
      (widget.imagePaths.length - 1).toDouble(),
    );
    _scrollItemValue.value = rawItem;
    _settledPage.value = rawItem.round();
  }

  void _goRelative(int delta) {
    if (!_carouselController.hasClients || widget.imagePaths.length < 2) return;
    final cur = _settledPage.value;
    final target = (cur + delta).clamp(0, widget.imagePaths.length - 1);
    if (target == cur) return;
    _carouselController.animateToItem(
      target,
      duration: const Duration(milliseconds: 360),
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

  void _onTapDot(int index) {
    _carouselController.animateToItem(
      index,
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  double _scaleForIndex(double pageValue, int index) {
    final delta = (pageValue - index).abs().clamp(0.0, 1.0);
    final boost = widget.activeScaleBoost - 1;
    return 1 + boost * (1 - delta);
  }

  /// Scroll-linked fade: centered slide fully opaque; neighbors fade toward [_opacityFloor]
  /// so outgoing/incoming slides crossfade smoothly while peek rails stay
  /// faintly visible at rest.
  static const double _opacityFloor = 0.32;

  double _opacityForIndex(double pageValue, int index) {
    final delta = (pageValue - index).abs().clamp(0.0, 1.0);
    final eased = Curves.easeInOutCubic.transform(1 - delta);
    return _opacityFloor + (1.0 - _opacityFloor) * eased;
  }

  ({double width, double height}) _resolveBox(Size screen, double maxWidth) {
    final shortest = math.min(screen.width, screen.height);
    final maxHeight = math.min(shortest * 0.52, 560.0);
    final idealHeight = maxWidth / widget.aspectRatio;
    final height = idealHeight.clamp(140.0, maxHeight);
    final baseWidth = height * widget.aspectRatio;
    final widenedWidth = math.min(baseWidth * 1.3, maxWidth);
    final widenedHeight = widenedWidth / widget.aspectRatio;
    return (width: widenedWidth, height: widenedHeight);
  }

  @override
  Widget build(BuildContext context) {
    final paths = widget.imagePaths;

    if (paths.isEmpty) {
      return _CarouselPlaceholder(
        aspectRatio: widget.aspectRatio,
        text: widget.placeholderText,
      );
    }

    final screen = MediaQuery.sizeOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final box = _resolveBox(screen, constraints.maxWidth);

        if (!_allImagesReady) {
          return Center(
            child: SizedBox(
              width: box.width,
              height: box.height,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
          );
        }

        if (paths.length == 1) {
          return Center(
            child: SizedBox(
              width: box.width,
              height: box.height,
              child: Transform.scale(
                scale: widget.activeScaleBoost,
                alignment: Alignment.center,
                child: _CarouselImageTile(
                  path: paths.single,
                  borderRadius: widget.borderRadius,
                  fit: widget.imageFit,
                ),
              ),
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: SizedBox(
                width: box.width,
                height: box.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.horizontalClipGutter,
                  ),
                  child: ScrollConfiguration(
                    behavior: const _HorizontalPagerScrollBehavior(),
                    child: Listener(
                      onPointerSignal: _onPointerSignal,
                      child: LayoutBuilder(
                        builder: (context, carouselConstraints) {
                          final itemExtent = _carouselItemExtent(
                            carouselConstraints.maxWidth,
                          );
                          // Eager [children]: every slide is built & decoded before paging.
                          return ValueListenableBuilder<double>(
                            valueListenable: _scrollItemValue,
                            builder: (context, pageVal, _) {
                              return CarouselView(
                                controller: _carouselController,
                                itemExtent: itemExtent,
                                itemSnapping: true,
                                shrinkExtent: itemExtent * 0.62,
                                padding: EdgeInsets.zero,
                                enableSplash: false,
                                children: [
                                  for (
                                    var index = 0;
                                    index < paths.length;
                                    index++
                                  )
                                    KeyedSubtree(
                                      key: ValueKey(paths[index]),
                                      child: RepaintBoundary(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: widget.itemSpacing / 2,
                                          ),
                                          child: Opacity(
                                            opacity: _opacityForIndex(
                                              pageVal,
                                              index,
                                            ),
                                            child: Transform.scale(
                                              scale: _scaleForIndex(
                                                pageVal,
                                                index,
                                              ),
                                              alignment: Alignment.center,
                                              filterQuality:
                                                  FilterQuality.medium,
                                              child: _CarouselImageTile(
                                                path: paths[index],
                                                borderRadius:
                                                    widget.borderRadius,
                                                fit: widget.imageFit,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.pageIndicator) const SizedBox(height: AppSpacing.sm8),
            if (widget.pageIndicator)
              ValueListenableBuilder<int>(
                valueListenable: _settledPage,
                builder: (context, settled, _) {
                  return _CarouselPageIndicator(
                    count: paths.length,
                    activeIndex: settled.clamp(0, paths.length - 1),
                    onTapIndex: _onTapDot,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _CarouselImageTile extends StatelessWidget {
  const _CarouselImageTile({
    required this.path,
    required this.borderRadius,
    required this.fit,
  });

  final String path;
  final BorderRadius borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: AppColors.background,
        child: Image.asset(
          path,
          fit: fit,
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          gaplessPlayback: true,
          errorBuilder: (context, error, stackTrace) =>
              const _CarouselImageError(),
        ),
      ),
    );
  }
}

class _CarouselImageError extends StatelessWidget {
  const _CarouselImageError();

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

class _CarouselPlaceholder extends StatelessWidget {
  const _CarouselPlaceholder({required this.aspectRatio, required this.text});

  final double aspectRatio;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ColoredBox(
        color: AppColors.background,
        child: Center(
          child: SelectableText(
            text,
            style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          ),
        ),
      ),
    );
  }
}

class _CarouselPageIndicator extends StatelessWidget {
  const _CarouselPageIndicator({
    required this.count,
    required this.activeIndex,
    required this.onTapIndex,
  });

  final int count;
  final int activeIndex;
  final ValueChanged<int> onTapIndex;

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return GestureDetector(
          onTap: () => onTapIndex(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
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
    );
  }
}
