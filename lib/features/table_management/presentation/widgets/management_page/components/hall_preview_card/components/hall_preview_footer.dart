import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class HallPreviewFooter extends StatelessWidget {
  final HallModel hall;
  final int tableCount;
  final bool isHovered;

  const HallPreviewFooter({
    super.key,
    required this.hall,
    required this.tableCount,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final hasNoTables = tableCount == 0;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: const BoxDecoration(color: NeutralColors.surface),
      child: Row(
        children: [
          // Hall icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PrimaryColors.defaultColor.withValues(
                alpha: 0.1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.grid_view_rounded,
              size: 16,
              color: PrimaryColors.defaultColor,
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  hall.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: TextColors.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  hasNoTables
                      ? 'Tap to add tables'
                      : '$tableCount ${tableCount == 1 ? "table" : "tables"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: hasNoTables
                        ? PrimaryColors.defaultColor
                        : NeutralColors.icon,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Arrow
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isHovered
                  ? PrimaryColors.defaultColor
                  : PrimaryColors.defaultColor.withValues(
                      alpha: 0.12,
                    ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_forward_rounded,
              color: isHovered
                  ? TextColors.primary
                  : PrimaryColors.defaultColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
