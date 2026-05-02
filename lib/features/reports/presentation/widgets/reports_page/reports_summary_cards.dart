import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import '../../bloc/reports_state.dart';
import 'status_summary_card.dart';

class ReportsSummaryCards extends StatelessWidget {
  final ReportsLoaded state;

  const ReportsSummaryCards({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusSummaryCard(
          title: 'Pending Orders',
          count: state.pendingOrdersCount.toString().padLeft(2, '0'),
          icon: Icons.hourglass_empty,
          accentColor: StatusColors.pending,
        ),
        const SizedBox(width: 24),
        StatusSummaryCard(
          title: 'Preparing',
          count: state.preparingCount.toString().padLeft(2, '0'),
          icon: Icons.restaurant,
          accentColor: StatusColors.preparing,
        ),
        const SizedBox(width: 24),
        StatusSummaryCard(
          title: 'Ready for Pickup',
          count: state.readyCount.toString().padLeft(2, '0'),
          icon: Icons.check_circle_outline,
          accentColor: StatusColors.ready,
        ),
      ],
    );
  }
}
