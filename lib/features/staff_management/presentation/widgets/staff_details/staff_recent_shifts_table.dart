import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class StaffRecentShiftsTable extends StatelessWidget {
  final StaffModel staff;

  const StaffRecentShiftsTable({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    // Mock shift history data for demonstration.
    final List<_ShiftRow> rows = [
      _ShiftRow('2026-04-25', '12:02 PM - 4:22 PM', '4h 20m'),
      _ShiftRow('2026-04-24', '10:17 AM - 10:20 AM', '0h 2m'),
      _ShiftRow('2026-04-23', '9:00 AM - 5:00 PM', '8h 0m'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RECENT SHIFTS',
                  style: TextStyle(
                    color: TextColors.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                Text(
                  'Last ${rows.length} sessions',
                  style: const TextStyle(color: TextColors.muted, fontSize: 11),
                ),
              ],
            ),
          ),
          const Divider(color: NeutralColors.border, height: 1),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: const [
                Expanded(flex: 2, child: _HeaderCell('DATE')),
                Expanded(flex: 3, child: _HeaderCell('TIME')),
                Expanded(child: _HeaderCell('WORKED', rightAlign: true)),
              ],
            ),
          ),
          const Divider(color: NeutralColors.border, height: 1),
          // Rows
          ...rows.asMap().entries.map((e) => _buildRow(e.value, e.key.isOdd)),
          if (rows.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text('No shift history available.', style: TextStyle(color: TextColors.secondary)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRow(_ShiftRow row, bool isAlternate) {
    return Container(
      color: isAlternate ? NeutralColors.surface : NeutralColors.background.withValues(alpha: 0.3),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(row.date, style: const TextStyle(color: TextColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          Expanded(
            flex: 3,
            child: Text(row.time, style: const TextStyle(color: TextColors.secondary, fontSize: 13)),
          ),
          Expanded(
            child: Text(
              row.worked,
              textAlign: TextAlign.end,
              style: const TextStyle(color: StatusColors.ready, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShiftRow {
  final String date, time, worked;
  const _ShiftRow(this.date, this.time, this.worked);
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final bool rightAlign;
  const _HeaderCell(this.label, {this.rightAlign = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: rightAlign ? TextAlign.end : TextAlign.start,
      style: const TextStyle(color: TextColors.muted, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.1),
    );
  }
}
