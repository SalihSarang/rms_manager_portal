import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/table_colors.dart';

class TableStatusLegend extends StatelessWidget {
  const TableStatusLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _LegendItem(color: TextColors.muted, label: 'AVAILABLE'),
        _LegendItem(color: StatusColors.pending, label: 'PENDING ORDER'),
        _LegendItem(color: StatusColors.preparing, label: 'PREPARING'),
        _LegendItem(color: StatusColors.ready, label: 'READY'),
        _LegendItem(color: StatusColors.purpleLight, label: 'SERVED'),
        _LegendItem(color: TableColors.destructive, label: 'FULLY OCCUPIED'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: TextColors.secondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
