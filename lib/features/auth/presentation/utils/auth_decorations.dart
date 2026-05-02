import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class AuthDecorations {
  static const BoxDecoration loginBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        NeutralColors.gradientStart,
        NeutralColors.background,
        NeutralColors.background,
        NeutralColors.background,
      ],
    ),
  );

  static BoxDecoration loginCardDecoration = BoxDecoration(
    color: NeutralColors.surface,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: NeutralColors.border),
    boxShadow: [
      BoxShadow(
        color: NeutralColors.shadow.withValues(alpha: 0.2),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
