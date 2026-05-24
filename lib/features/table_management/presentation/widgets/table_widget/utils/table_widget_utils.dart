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
    final statusName = table.status.name;

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
    if (statusName == 'occupied') {
        return (
          TableColors.occupiedFill,
          SemanticColors.error,
          TableColors.occupiedText,
          SemanticColors.error.withValues(alpha: 0.2),
        );
    }
    if (statusName == 'reserved') {
        return (
          TableColors.reservedFill,
          SemanticColors.info,
          TableColors.reservedText,
          SemanticColors.info.withValues(alpha: 0.2),
        );
    }
    if (statusName == 'billRequested' || statusName == 'bill_requested') {
        return (
          TableColors.billRequestedFill,
          SemanticColors.warning,
          TableColors.billRequestedText,
          SemanticColors.warning.withValues(alpha: 0.2),
        );
    }
    if (statusName == 'cleaning') {
        return (
          TableColors.cleaningFill,
          SemanticColors.success,
          TableColors.cleaningText,
          SemanticColors.success.withValues(alpha: 0.2),
        );
    }
    return (
      NeutralColors.card,
      NeutralColors.border,
      NeutralColors.white,
      NeutralColors.border.withValues(alpha: 0.5),
    );
  }

  /// Resolves the gradient for a table based on its status.
  static LinearGradient? resolveGradient({
    required TableModel table,
    required bool isSelected,
  }) {
    final statusName = table.status.name;
    if (isSelected) return null;
    if (statusName == 'occupied') {
        return const LinearGradient(
          colors: [TableColors.occupiedGradientStart, TableColors.occupiedFill],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
    if (statusName == 'reserved') {
        return const LinearGradient(
          colors: [TableColors.reservedGradientStart, TableColors.reservedFill],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
    if (statusName == 'billRequested' || statusName == 'bill_requested') {
        return const LinearGradient(
          colors: [
            TableColors.billRequestedGradientStart,
            TableColors.billRequestedFill
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
    return const LinearGradient(
      colors: [NeutralColors.cardGradientStart, NeutralColors.cardGradientEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
