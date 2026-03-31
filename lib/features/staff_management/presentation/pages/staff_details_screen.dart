import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_details/staff_details_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_details/staff_details_widgets.dart';

/// Screen that displays detailed information for a specific staff member.
///
/// Fetches [staffId] details upon initialization and handles loading/error states.
class StaffDetailsScreen extends StatelessWidget {
  /// The unique identifier of the staff member to display.
  final String staffId;

  /// Creates a [StaffDetailsScreen] for the given [staffId].
  const StaffDetailsScreen({super.key, required this.staffId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<StaffDetailsBloc>()..add(FetchStaffDetails(staffId)),
      child: const Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: StaffDetailsAppBar(),
        body: StaffDetailsStateView(),
      ),
    );
  }
}
