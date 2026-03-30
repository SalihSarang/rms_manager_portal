import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class EmptyPreview extends StatelessWidget {
  const EmptyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: PrimaryColors.defaultColor.withValues(alpha: 0.06),
            shape: BoxShape.circle,
            border: Border.all(
              color: PrimaryColors.defaultColor.withValues(alpha: 0.18),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.table_restaurant_rounded,
            color: PrimaryColors.defaultColor,
            size: 30,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'No tables yet',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: NeutralColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tap to open the editor',
          style: TextStyle(
            fontSize: 11,
            color: NeutralColors.white.withValues(alpha: 0.35),
          ),
        ),
      ],
    );
  }
}
