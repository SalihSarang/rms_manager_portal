import 'package:flutter/material.dart';
import 'transformation_manager.dart';

class EditorUiUtils {
  static void handleTransformationChanged({
    required TransformationController controller,
    required double currentScale,
    required void Function(double) onScaleChanged,
  }) {
    final scale = TransformationManager.getScale(controller);
    if (scale != currentScale) {
      onScaleChanged(scale);
    }
  }

  static void centerCanvas({
    required TransformationController controller,
    required Size? viewportSize,
  }) {
    if (viewportSize == null) return;
    TransformationManager.centerCanvas(
      controller: controller,
      viewportSize: viewportSize,
    );
  }

  static void zoomIn(TransformationController controller) {
    TransformationManager.zoomIn(controller);
  }

  static void zoomOut(TransformationController controller) {
    TransformationManager.zoomOut(controller);
  }
}
