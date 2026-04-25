import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/overview/data/repositories/mock_overview_repository.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_bloc.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_event.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_state.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview_charts_row.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview_error_view.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview_header.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview_leaderboard_row.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview_loading_view.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview_stat_grid.dart';
import 'package:rms_design_system/rms_design_system.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OverviewBloc(repository: MockOverviewRepository())
            ..add(LoadOverviewData()),
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        body: BlocBuilder<OverviewBloc, OverviewState>(
          builder: (context, state) {
            if (state is OverviewLoading) {
              return const OverviewLoadingView();
            } else if (state is OverviewLoaded) {
              final data = state.data;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverviewHeader(),
                    const SizedBox(height: 40),
                    OverviewStatGrid(data: data),
                    const SizedBox(height: 32),
                    OverviewChartsRow(data: data),
                    const SizedBox(height: 32),
                    OverviewLeaderboardRow(data: data),
                  ],
                ),
              );
            } else if (state is OverviewError) {
              return OverviewErrorView(message: state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
