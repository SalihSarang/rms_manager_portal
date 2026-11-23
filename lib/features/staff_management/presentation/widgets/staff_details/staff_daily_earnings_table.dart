import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/shift_models/shift_session.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class StaffDailyEarningsTable extends StatelessWidget {
  final StaffModel staff;
  final List<ShiftSession> history;

  const StaffDailyEarningsTable({
    super.key,
    required this.staff,
    this.history = const [],
  });

  @override
  Widget build(BuildContext context) {
    final ratePerHr = staff.baseWage ?? 0.0;
    final rateLabel = staff.wageType == WageType.monthly
        ? 'Monthly'
        : '₹${ratePerHr.toStringAsFixed(0)}/hr';

    final List<_EarningsRow> rows = history.map((session) {
      final dateStr = session.actualStart != null
          ? DateFormat('yyyy-MM-dd').format(session.actualStart!)
          : '-';
      final workedHours = session.workedMinutes / 60.0;
      final totalPay = staff.wageType == WageType.monthly
          ? (ratePerHr / 30) // estimated daily equivalent for monthly wage
          : (workedHours * ratePerHr);

      return _EarningsRow(
        dateStr,
        '${workedHours.toStringAsFixed(1)}h',
        rateLabel,
        '₹${totalPay.toStringAsFixed(2)}',
      );
    }).toList();

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
