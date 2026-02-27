import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_details/staff_details_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_details/staff_details_widgets.dart';

class StaffDetailsScreen extends StatelessWidget {
  final String staffId;

  const StaffDetailsScreen({super.key, required this.staffId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<StaffDetailsBloc>()..add(FetchStaffDetails(staffId)),
      child: const Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: StaffDetailsAppBar(),
        body: _StaffDetailsStateView(),
      ),
    );
  }
}

class _StaffDetailsStateView extends StatelessWidget {
  const _StaffDetailsStateView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffDetailsBloc, StaffDetailsState>(
      builder: (context, state) {
        if (state is StaffDetailsLoading || state is StaffDetailsInitial) {
          return const Center(
            child: CircularProgressIndicator(color: PrimaryColors.defaultColor),
          );
        }
        if (state is StaffDetailsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: SemanticColors.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: ${state.message}',
                  style: const TextStyle(
                    color: SemanticColors.error,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        if (state is StaffDetailsLoaded) {
          return StaffDetailsBody(staff: state.staff);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
