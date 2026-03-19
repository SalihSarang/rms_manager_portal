import 'package:flutter/material.dart';

/// A utility class to manage TransformationController logic for the editor.
class TransformationManager {
  /// Constants for the canvas dimensions.
  static const double canvasWidth = 1600.0;
  static const double canvasHeight = 1200.0;

  /// Centers the canvas within the given viewport size.
  static void centerCanvas({
    required TransformationController controller,
    required Size viewportSize,
  }) {
    // Only pan if the canvas is larger than the viewport
    final dx = ((canvasWidth - viewportSize.width) / 2).clamp(0.0, canvasWidth);
    final dy = ((canvasHeight - viewportSize.height) / 2).clamp(0.0, canvasHeight);
    
    controller.value = Matrix4.identity()..translate(-dx, -dy);
  }

  /// Performs a zoom-in operation on the given controller.
  static void zoomIn(TransformationController controller) {
    final s = controller.value.getMaxScaleOnAxis();
    controller.value = Matrix4.identity()
      ..multiply(Matrix4.diagonal3Values(s * 1.1, s * 1.1, 1.0));
  }

  /// Performs a zoom-out operation on the given controller.
  static void zoomOut(TransformationController controller) {
    final s = controller.value.getMaxScaleOnAxis();
    if (s <= 1.0) return;
    
    controller.value = Matrix4.identity()
      ..multiply(Matrix4.diagonal3Values(s * 0.9, s * 0.9, 1.0));
  }
  
  /// Extracts the current scale from the transformation matrix.
  static double getScale(TransformationController controller) {
    return controller.value.getMaxScaleOnAxis();
  }
}
