import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import '../widgets/reports_page/reports_loading_state.dart';
import '../widgets/reports_page/reports_error_state.dart';
import '../widgets/reports_page/reports_dashboard_body.dart';
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
              return ReportsDashboardBody(state: state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
