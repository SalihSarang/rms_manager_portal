import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/reports_bloc.dart';
import '../../bloc/reports_event.dart';
import '../../bloc/reports_state.dart';
import 'reports_summary_cards.dart';
import 'reports_grid_header.dart';
import 'table_status_legend.dart';
import 'hall_filter_chips.dart';
import 'reports_table_grid.dart';

class ReportsDashboardBody extends StatelessWidget {
  final ReportsLoaded state;

  const ReportsDashboardBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Stats Row
          ReportsSummaryCards(state: state),
          const SizedBox(height: 48),

          // Header Section
          const ReportsGridHeader(),
          const SizedBox(height: 24),

          // Legend
          const TableStatusLegend(),
          const SizedBox(height: 24),

          // Hall Filter
          HallFilterChips(
            halls: state.halls,
            selectedHallId: state.selectedHallId,
            onHallSelected: (hallId) {
              context.read<ReportsBloc>().add(SelectHall(hallId));
            },
          ),
          const SizedBox(height: 32),

          // Grid Section
          Expanded(child: ReportsTableGrid(state: state)),
        ],
      ),
    );
  }
}
