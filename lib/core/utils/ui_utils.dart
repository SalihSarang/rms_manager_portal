import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class UiUtils {
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: NeutralColors.surface,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: NeutralColors.border),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get modalDecoration => BoxDecoration(
    color: NeutralColors.background,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: NeutralColors.border.withValues(alpha: 0.5)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.5),
        blurRadius: 40,
        spreadRadius: 10,
      ),
    ],
  );

  static BoxDecoration tableStatusCardDecoration({
    required bool showAsAvailable,
    required Color statusColor,
  }) => BoxDecoration(
    color: showAsAvailable
        ? NeutralColors.surface.withValues(alpha: 0.3)
        : NeutralColors.surface,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: showAsAvailable
          ? NeutralColors.border.withValues(alpha: 0.2)
          : statusColor.withValues(alpha: 0.3),
      width: showAsAvailable ? 1 : 1.5,
    ),
  );
}
