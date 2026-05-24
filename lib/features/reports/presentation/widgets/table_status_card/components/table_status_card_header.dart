import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';

class TableStatusCardHeader extends StatelessWidget {
  final TableModel table;
  final String statusText;
  final Color statusColor;
  final bool showAsAvailable;

  const TableStatusCardHeader({
    super.key,
    required this.table,
    required this.statusText,
    required this.statusColor,
    required this.showAsAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: showAsAvailable
                ? Colors.transparent
                : statusColor.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(4),
            border: showAsAvailable
                ? Border.all(color: NeutralColors.border)
                : null,
          ),
          child: Text(
            table.name.padLeft(2, '0'),
            style: TextStyle(
              color: showAsAvailable
                  ? TextColors.secondary
                  : TextColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'STATUS',
              style: TextStyle(
                color: TextColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              statusText.toUpperCase(),
              style: TextStyle(
                color: showAsAvailable ? TextColors.secondary : statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
