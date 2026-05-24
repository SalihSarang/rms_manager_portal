import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class TableStatusMultiOrderBadge extends StatelessWidget {
  final int orderCount;

  const TableStatusMultiOrderBadge({super.key, required this.orderCount});

  @override
  Widget build(BuildContext context) {
    if (orderCount <= 1) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: NeutralColors.surfaceLighter,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '$orderCount ACTIVE ORDERS',
          style: const TextStyle(
            color: TextColors.primary,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
