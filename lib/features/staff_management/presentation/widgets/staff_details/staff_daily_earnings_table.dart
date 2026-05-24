import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class StaffDailyEarningsTable extends StatelessWidget {
  final StaffModel staff;

  const StaffDailyEarningsTable({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    // Mock daily earnings data for demonstration.
    final List<_EarningsRow> rows = [
      _EarningsRow('2026-04-25', '292.3h', '₹0/hr', '₹0.00'),
      _EarningsRow('2026-04-24', '0.0h', '₹0/hr', '₹0.00'),
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
                  'DAILY EARNINGS',
                  style: TextStyle(
                    color: TextColors.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                Text(
                  'Showing last ${rows.length} sessions',
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
                Expanded(child: _HeaderCell('WORKED')),
                Expanded(child: _HeaderCell('RATE')),
                Expanded(child: _HeaderCell('TOTAL', rightAlign: true)),
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
                child: Text(
                  'No earnings data available.',
                  style: TextStyle(color: TextColors.secondary),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRow(_EarningsRow row, bool isAlternate) {
    return Container(
      color: isAlternate
          ? NeutralColors.surface
          : NeutralColors.background.withValues(alpha: 0.3),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              row.date,
              style: const TextStyle(
                color: TextColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.worked,
              style: const TextStyle(color: TextColors.secondary, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              row.rate,
              style: const TextStyle(color: TextColors.secondary, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              row.total,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: StatusColors.ready,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EarningsRow {
  final String date, worked, rate, total;
  const _EarningsRow(this.date, this.worked, this.rate, this.total);
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
      style: const TextStyle(
        color: TextColors.muted,
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    );
  }
}
