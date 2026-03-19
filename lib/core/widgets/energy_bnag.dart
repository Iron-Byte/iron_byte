import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';

class DiagonalEnergyLines extends StatefulWidget {
  final double width;
  final double height;
  final int lineCount;
  final int particlesPerLine;

  const DiagonalEnergyLines({
    super.key,
    this.width = 800,
    this.height = 500,
    this.lineCount = 12,
    this.particlesPerLine = 3,
  });

  @override
  State<DiagonalEnergyLines> createState() => _DiagonalEnergyLinesState();
}

class _DiagonalEnergyLinesState extends State<DiagonalEnergyLines>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late _DiagonalEnergyPainter _painter;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      // ✅ Замедление делаем тут (а не speed<1)
      duration: const Duration(seconds: 6),
    )..repeat();

    // Performance: create the painter once, and let the controller drive repaints.
    _painter = _DiagonalEnergyPainter(
      controller: _controller,
      width: widget.width,
      height: widget.height,
      lineCount: widget.lineCount,
    );
  }

  @override
  void didUpdateWidget(covariant DiagonalEnergyLines oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Performance: if static inputs change, rebuild cached geometry/paints.
    if (oldWidget.width != widget.width ||
        oldWidget.height != widget.height ||
        oldWidget.lineCount != widget.lineCount) {
      _painter = _DiagonalEnergyPainter(
        controller: _controller,
        width: widget.width,
        height: widget.height,
        lineCount: widget.lineCount,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Performance: isolate repainting to this widget.
    return RepaintBoundary(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          isComplex: true,
          willChange: true,
          painter: _painter,
        ),
      ),
    );
  }
}

class _DiagonalEnergyPainter extends CustomPainter {
  // Performance: `super(repaint: controller)` makes this painter repaint on
  // each tick, without requiring parent widget rebuilds.
  final AnimationController controller;
  final double width;
  final double height;
  final int lineCount;

  // Cached geometry (stable for a given size + lineCount).
  late final Offset _center;
  late final double _maxR;
  late final List<Path> _basePaths;
  late final List<PathMetric> _metrics;
  late final List<double> _metricLengths;
  late final List<double> _phases;
  late final List<double> _speeds;

  // Cached paints/shaders to avoid per-frame allocations.
  final Paint _shockPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

  final Paint _basePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 22
    ..color = Colors.cyan.withValues(alpha: 0.10);

  final Paint _outerGlowPaint = Paint()
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 32);

  late final Paint _corePaint;
  late final List<Paint> _revealPaints;

  _DiagonalEnergyPainter({
    required this.controller,
    required this.width,
    required this.height,
    required this.lineCount,
  }) : super(repaint: controller) {
    _initCaches();
  }

  void _initCaches() {
    _center = Offset(width * 0.5, height * 0.5);
    _maxR = (width < height ? width : height) * 0.9;

    _basePaths = List<Path>.generate(lineCount, (_) => Path());
    _metrics = List<PathMetric>.empty(growable: true);
    _metricLengths = List<double>.empty(growable: true);
    _phases = List<double>.empty(growable: true);
    _speeds = List<double>.empty(growable: true);

    _corePaint = Paint()..color = Colors.white.withValues(alpha: 0.95);

    // Each line has a static gradient (center -> end), so cache a Paint per line.
    _revealPaints = List<Paint>.generate(lineCount, (_) {
      return Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
    });

    for (int i = 0; i < lineCount; i++) {
      final v = (i + 1) / (lineCount + 1);
      final bool goRight = i.isEven;

      final end = Offset(
        goRight ? width + 680 : -180,
        lerpDouble(0, height + 120, v)!,
      );

      final cp1 = Offset(
        lerpDouble(_center.dx, end.dx, 0.25)!,
        _center.dy + (i.isEven ? -520 : 220) * (0.35 + v),
      );
      final cp2 = Offset(
        lerpDouble(_center.dx, end.dx, 0.65)!,
        end.dy + (i.isEven ? 560 : -160) * (0.25 + (1.0 - v)),
      );

      final path = Path()
        ..moveTo(_center.dx, _center.dy)
        ..cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, end.dx, end.dy);

      // Performance: expensive PathMetrics are computed once.
      final metric = path.computeMetrics().first;

      _basePaths[i] = path;
      _metrics.add(metric);
      _metricLengths.add(metric.length);

      // Performance: precompute constants used each frame.
      _phases.add((i * 0.173) % 1.0);
      _speeds.add(1.0 + ((i * 0.200) % 1.0) * 1.2);

      // Performance: gradient shader endpoints don't change with time.
      _revealPaints[i].shader = ui.Gradient.linear(
        _center,
        end,
        [
          Colors.orangeAccent.withValues(alpha: 0.95),
          Colors.cyanAccent.withValues(alpha: 0.65),
          Colors.purple.withValues(alpha: 0.45),
        ],
        const [0.0, 0.35, 1.0],
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Performance: read current progress directly from the controller.
    final double progress = controller.value;
    final double t = Curves.easeOutCubic.transform(progress);

    // Shock circle.
    _shockPaint.color =
        Colors.cyanAccent.withValues(alpha: (1.0 - t) * 0.25);
    canvas.drawCircle(_center, _maxR * t, _shockPaint);

    // Performance: `Curves.linear.transform(x)` is identity, so avoid the call.
    final double revealStrokeWidth = lerpDouble(6, 26, t)!;

    for (int i = 0; i < lineCount; i++) {
      // Base line (static).
      canvas.drawPath(_basePaths[i], _basePaint);

      // Chaos constants precomputed: phase + speed (speed >= 1).
      final double local = ((progress + _phases[i]) * _speeds[i]) % 1.0;
      final double localT = local;

      final metric = _metrics[i];
      final double revealLen = _metricLengths[i] * localT;

      // Animated revealed segment.
      final Path revealPath = metric.extractPath(0, revealLen);
      _revealPaints[i].strokeWidth = revealStrokeWidth;
      canvas.drawPath(revealPath, _revealPaints[i]);

      // Head at the end of the revealed segment.
      final Offset head =
          metric.getTangentForOffset(revealLen)?.position ?? _center;

      _outerGlowPaint.color = Colors.cyanAccent.withValues(
        alpha: (1.0 - localT) * 0.35 + 0.10,
      );
      canvas.drawOval(
        Rect.fromCenter(center: head, width: 70, height: 70),
        _outerGlowPaint,
      );

      canvas.drawOval(
        Rect.fromCenter(center: head, width: 40, height: 50),
        _corePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DiagonalEnergyPainter oldDelegate) {
    // Performance: repaints are driven by `super(repaint: controller)`.
    // This only matters if a new painter instance is swapped in due to geometry changes.
    return oldDelegate.lineCount != lineCount ||
        oldDelegate.width != width ||
        oldDelegate.height != height;
  }
}
