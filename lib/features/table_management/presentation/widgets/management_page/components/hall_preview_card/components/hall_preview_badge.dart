import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class HallPreviewBadge extends StatelessWidget {
  final int tableCount;

  const HallPreviewBadge({
    super.key,
    required this.tableCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: NeutralColors.surface.withValues(
          alpha: 0.9,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.table_restaurant_rounded,
            size: 11,
            color: PrimaryColors.defaultColor,
          ),
          const SizedBox(width: 4),
          Text(
            '$tableCount',
            style: const TextStyle(
              fontSize: 11,
              color: TextColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
