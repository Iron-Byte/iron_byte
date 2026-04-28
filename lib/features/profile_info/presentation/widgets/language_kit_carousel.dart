import 'dart:async' show unawaited;
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/profile_info/presentation/widgets/carousel_page_indicator.dart';

class LanguageKitCarousel extends StatefulWidget {
  const LanguageKitCarousel({
    super.key,
    required this.imagePaths,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.78,
    this.itemSpacing = 10,
    this.activeScaleBoost = 1.06,
    this.imageFit = BoxFit.contain,
    /// Inset for the pager so scaled “active” slides are not clipped by an outer [ClipRect].
    this.horizontalClipGutter = 0,
  });

  final List<String> imagePaths;
  final double aspectRatio;
  final double viewportFraction;
  final double itemSpacing;
  final double activeScaleBoost;
  /// [BoxFit.cover] fills the frame but crops; [BoxFit.contain] shows the full image.
  final BoxFit imageFit;
  final double horizontalClipGutter;

  @override
  State<LanguageKitCarousel> createState() => _LanguageKitCarouselState();
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

class _LanguageKitCarouselState extends State<LanguageKitCarousel> {
  late final PageController _pageController;
  /// Settled index for dots; [ValueNotifier] avoids [setState] full rebuild on snap.
  late final ValueNotifier<int> _settledPage;
  String? _loadedSignature;
  bool _allImagesReady = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: widget.viewportFraction);
    _settledPage = ValueNotifier(0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    unawaited(_loadAllImages());
  }

  @override
  void didUpdateWidget(covariant LanguageKitCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
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
      for (final path in paths)
        precacheImage(AssetImage(path), context),
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
    _settledPage.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goRelative(int delta) {
    if (!_pageController.hasClients || widget.imagePaths.length < 2) {
      return;
    }
    final cur = _settledPage.value;
    final target = (cur + delta).clamp(0, widget.imagePaths.length - 1);
    if (target == cur) return;
    _pageController.animateToPage(
      target,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (widget.imagePaths.length < 2) return;
    if (event is! PointerScrollEvent) return;
    final d = event.scrollDelta;
    if (d.dx.abs() <= d.dy.abs() * 1.25) return;
    if (d.dx < -2) {
      _goRelative(1);
    } else if (d.dx > 2) {
      _goRelative(-1);
    }
  }

  void _onTapDot(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  double _scaleForIndex(double pageValue, int index) {
    final delta = (pageValue - index).abs().clamp(0.0, 1.0);
    final boost = widget.activeScaleBoost - 1;
    return 1 + boost * (1 - delta);
  }

  /// Scroll-linked fade: centered slide fully opaque; neighbors fade toward [_opacityFloor]
  /// so outgoing/incoming slides crossfade smoothly while peek rails stay faintly visible at rest.
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
    final width = height * widget.aspectRatio;
    return (width: math.min(width, maxWidth), height: height);
  }

  @override
  Widget build(BuildContext context) {
    final paths = widget.imagePaths;

    if (paths.isEmpty) {
      return _CarouselPlaceholder(aspectRatio: widget.aspectRatio);
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
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
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
                  borderRadius: AppRadius.borderMd12,
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
                      child: AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, _) {
                          final pageVal =
                              _pageController.hasClients &&
                                  _pageController.page != null
                              ? _pageController.page!
                              : _settledPage.value.toDouble();

                          // Eager [children]: every slide is built & decoded before paging (no lazy decode pops).
                          return PageView(
                            controller: _pageController,
                            clipBehavior: Clip.none,
                            padEnds: true,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (i) => _settledPage.value = i,
                            children: [
                              for (var index = 0;
                                  index < paths.length;
                                  index++)
                                KeyedSubtree(
                                  key: ValueKey(paths[index]),
                                  child: RepaintBoundary(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            widget.itemSpacing / 2,
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
                                                AppRadius.borderMd12,
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm8),
            ValueListenableBuilder<int>(
              valueListenable: _settledPage,
              builder: (context, settled, _) {
                return CarouselPageIndicator(
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
  const _CarouselPlaceholder({required this.aspectRatio});

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ColoredBox(
        color: AppColors.background,
        child: Center(
          child: SelectableText(
            'No images',
            style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          ),
        ),
      ),
    );
  }
}
