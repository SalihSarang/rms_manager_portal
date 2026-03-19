import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DotGridPainter extends CustomPainter {
  final Color color;

  const DotGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const gridSize = 24.0;

    // Small dots at every intersection
    final dotPaint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Larger accent dots every 5 intersections
    final accentPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final List<Offset> smallPoints = [];
    final List<Offset> accentPoints = [];

    for (double i = 0; i < size.width + gridSize; i += gridSize) {
      for (double j = 0; j < size.height + gridSize; j += gridSize) {
        final col = (i / gridSize).round();
        final row = (j / gridSize).round();
        final isAccent = col % 5 == 0 && row % 5 == 0;
        if (isAccent) {
          accentPoints.add(Offset(i, j));
        } else {
          smallPoints.add(Offset(i, j));
        }
      }
    }

    canvas.drawPoints(ui.PointMode.points, smallPoints, dotPaint);
    canvas.drawPoints(ui.PointMode.points, accentPoints, accentPaint);
  }

  @override
  bool shouldRepaint(covariant DotGridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
