import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class EmptySelectionHint extends StatelessWidget {
  const EmptySelectionHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7C5CFC).withValues(alpha: 0.06),
            const Color(0xFF5CE0E6).withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: NeutralColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.touch_app_rounded,
              size: 16,
              color: NeutralColors.icon,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'No table selected',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: NeutralColors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tap a table to edit properties',
                  style: TextStyle(
                    fontSize: 11,
                    color: NeutralColors.icon,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
