import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import '../widgets/table_status_legend.dart';
import '../widgets/reports_loading_state.dart';
import '../widgets/reports_error_state.dart';
import '../widgets/reports_summary_cards.dart';
import '../widgets/reports_grid_header.dart';
import '../widgets/reports_table_grid.dart';
import '../bloc/reports_bloc.dart';
import '../bloc/reports_event.dart';
import '../bloc/reports_state.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReportsBloc>()..add(FetchReportsData()),
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        body: BlocBuilder<ReportsBloc, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoading || state is ReportsInitial) {
              return const ReportsLoadingState();
            }

            if (state is ReportsError) {
              return ReportsErrorState(message: state.message);
            }

            if (state is ReportsLoaded) {
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
                    const SizedBox(height: 32),

                    // Grid Section
                    Expanded(child: ReportsTableGrid(state: state)),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
