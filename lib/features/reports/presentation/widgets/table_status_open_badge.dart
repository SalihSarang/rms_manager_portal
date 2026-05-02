import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class TableStatusOpenBadge extends StatelessWidget {
  final bool showAsAvailable;

  const TableStatusOpenBadge({super.key, required this.showAsAvailable});

  @override
  Widget build(BuildContext context) {
    if (!showAsAvailable) return const SizedBox.shrink();

    return Positioned(
      right: 12,
      top: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: NeutralColors.border),
        ),
        child: const Text(
          'OPEN',
          style: TextStyle(
            color: TextColors.muted,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
