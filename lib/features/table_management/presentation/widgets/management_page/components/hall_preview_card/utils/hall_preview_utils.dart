import 'package:flutter/material.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class HallPreviewUtils {
  /// Computes the tight bounding box around all tables with padding.
  static Rect computeBoundingBox(List<TableModel> tables) {
    if (tables.isEmpty) return const Rect.fromLTWH(0, 0, 400, 300);

    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;

    for (final t in tables) {
      if (t.x < minX) minX = t.x;
      if (t.y < minY) minY = t.y;
      if (t.x + t.width > maxX) maxX = t.x + t.width;
      if (t.y + t.height > maxY) maxY = t.y + t.height;
    }

    const padding = 60.0;
    return Rect.fromLTWH(
      minX - padding,
      minY - padding,
      (maxX - minX) + padding * 2,
      (maxY - minY) + padding * 2,
    );
  }
}
