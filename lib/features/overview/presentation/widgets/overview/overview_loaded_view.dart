import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_state.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview/overview_charts_row.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview/overview_filter_section.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview/overview_header.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview/overview_leaderboard_row.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview/overview_stat_grid.dart';

class OverviewLoadedView extends StatelessWidget {
  final OverviewLoaded state;

  const OverviewLoadedView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OverviewHeader(),
          const SizedBox(height: 24),
          const OverviewFilterSection(),
          const SizedBox(height: 32),
          OverviewStatGrid(data: state.data),
          const SizedBox(height: 32),
          OverviewChartsRow(
            data: state.data,
            timeframe: state.timeframe,
            startDate: state.startDate,
            endDate: state.endDate,
          ),
          const SizedBox(height: 32),
          OverviewLeaderboardRow(data: state.data),
        ],
      ),
    );
  }
}
