import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class TablePositionDisplay extends StatelessWidget {
  final TableModel table;

  const TablePositionDisplay({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: NeutralColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: NeutralColors.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on_rounded, size: 15, color: NeutralColors.icon),
            const SizedBox(width: 8),
            Text(
              'X: ${table.x.toStringAsFixed(0)}',
              style: const TextStyle(
                  fontSize: 12,
                  color: NeutralColors.icon,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 16),
            Text(
              'Y: ${table.y.toStringAsFixed(0)}',
              style: const TextStyle(
                  fontSize: 12,
                  color: NeutralColors.icon,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
