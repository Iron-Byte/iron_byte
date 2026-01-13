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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      // ✅ Замедление делаем тут (а не speed<1)
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _DiagonalEnergyPainter(
            progress: _controller.value,
            lineCount: widget.lineCount,
            particlesPerLine: widget.particlesPerLine,
          ),
        );
      },
    );
  }
}

class _DiagonalEnergyPainter extends CustomPainter {
  final double progress;
  final int lineCount;
  final int particlesPerLine;

  _DiagonalEnergyPainter({
    required this.progress,
    required this.lineCount,
    required this.particlesPerLine,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final t = Curves.easeOutCubic.transform(progress);
    final center = Offset(size.width * 0.5, size.height * 0.5);

    final maxR = size.shortestSide * 0.9;
    final shockPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.cyanAccent.withValues(alpha: (1.0 - t) * 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    canvas.drawCircle(center, maxR * t, shockPaint);

    for (int i = 0; i < lineCount; i++) {
      final v = (i + 1) / (lineCount + 1);
      final goRight = i.isEven;

      final end = Offset(
        goRight ? size.width + 680 : -180,
        lerpDouble(0, size.height + 120, v)!,
      );

      final cp1 = Offset(
        lerpDouble(center.dx, end.dx, 0.25)!,
        center.dy + (i.isEven ? -520 : 220) * (0.35 + v),
      );
      final cp2 = Offset(
        lerpDouble(center.dx, end.dx, 0.65)!,
        end.dy + (i.isEven ? 560 : -160) * (0.25 + (1.0 - v)),
      );

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, end.dx, end.dy);

      final basePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 22
        ..color = Colors.cyan.withValues(alpha: 0.10);

      canvas.drawPath(path, basePaint);

      // ✅ Хаос: phase + speed, но speed >= 1, чтобы ДОЕЗЖАЛО ДО КОНЦА
      final double phase = (i * 0.173) % 1.0;

      // ✅ скорость (1.0..2.2) — всегда >= 1
      final double speed = 1.0 + ((i * 0.200) % 1.0) * 1.2;

      // ✅ local пробегает весь 0..1 (и поэтому всегда доезжает до конца)
      final double local = ((progress + phase) * speed) % 1.0;

      // без "остановки" на краях
      final double localT = Curves.linear.transform(local);

      final metric = path.computeMetrics().first;

      // ✅ Частица идёт от СТАРТА (center) к КОНЦУ (end)
      final double revealLen = metric.length * localT;
      final Path revealPath = metric.extractPath(0, revealLen);

      final revealPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = lerpDouble(6, 26, t)!
        ..strokeCap = StrokeCap.round
        ..shader = ui.Gradient.linear(
          center,
          end,
          [
            Colors.white.withValues(alpha: 0.95),
            Colors.cyanAccent.withValues(alpha: 0.65),
            Colors.cyan.withValues(alpha: 0.05),
          ],
          const [0.0, 0.35, 1.0],
        );

      canvas.drawPath(revealPath, revealPaint);

      // ✅ Голова — в конце текущего сегмента
      final head = metric.getTangentForOffset(revealLen)?.position ?? center;

      final outerGlow = Paint()
        ..color = Colors.cyanAccent.withValues(
          alpha: (1.0 - localT) * 0.35 + 0.10,
        )
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 32);

      canvas.drawOval(
        Rect.fromCenter(center: head, width: 70, height: 70),
        outerGlow,
      );

      final corePaint = Paint()..color = Colors.white.withValues(alpha: 0.95);
      canvas.drawOval(
        Rect.fromCenter(center: head, width: 40, height: 50),
        corePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DiagonalEnergyPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.lineCount != lineCount ||
        oldDelegate.particlesPerLine != particlesPerLine;
  }
}
