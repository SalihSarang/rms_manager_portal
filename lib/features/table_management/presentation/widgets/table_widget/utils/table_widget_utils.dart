import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class TableWidgetUtils {
  /// Resolves the colors for a table based on its status and state.
  static (Color, Color, Color, Color) resolveColors({
    required TableModel table,
    required bool isSelected,
    required bool isPreview,
  }) {
    if (isPreview) {
      return (
        NeutralColors.surface,
        NeutralColors.border,
        NeutralColors.icon,
        NeutralColors.background,
      );
    }
    if (isSelected) {
      return (
        PrimaryColors.defaultColor,
        PrimaryColors.hoverColor,
        NeutralColors.white,
        NeutralColors.white.withValues(alpha: 0.2),
      );
    }
    switch (table.status) {
      case TableStatus.occupied:
        return (
          TableColors.occupiedFill,
          SemanticColors.error,
          TableColors.occupiedText,
          SemanticColors.error.withValues(alpha: 0.2),
        );
      case TableStatus.reserved:
        return (
          TableColors.reservedFill,
          SemanticColors.info,
          TableColors.reservedText,
          SemanticColors.info.withValues(alpha: 0.2),
        );
      case TableStatus.billRequested:
        return (
          TableColors.billRequestedFill,
          SemanticColors.warning,
          TableColors.billRequestedText,
          SemanticColors.warning.withValues(alpha: 0.2),
        );
      case TableStatus.cleaning:
        return (
          TableColors.cleaningFill,
          SemanticColors.success,
          TableColors.cleaningText,
          SemanticColors.success.withValues(alpha: 0.2),
        );
      default:
        return (
          NeutralColors.card,
          NeutralColors.border,
          NeutralColors.white,
          NeutralColors.border.withValues(alpha: 0.5),
        );
    }
  }

  /// Resolves the gradient for a table based on its status.
  static LinearGradient? resolveGradient({
    required TableModel table,
    required bool isSelected,
  }) {
    if (isSelected) return null;
    switch (table.status) {
      case TableStatus.occupied:
        return const LinearGradient(
          colors: [TableColors.occupiedGradientStart, TableColors.occupiedFill],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case TableStatus.reserved:
        return const LinearGradient(
          colors: [TableColors.reservedGradientStart, TableColors.reservedFill],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case TableStatus.billRequested:
        return const LinearGradient(
          colors: [
            TableColors.billRequestedGradientStart,
            TableColors.billRequestedFill
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [
            NeutralColors.cardGradientStart,
            NeutralColors.cardGradientEnd
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}
