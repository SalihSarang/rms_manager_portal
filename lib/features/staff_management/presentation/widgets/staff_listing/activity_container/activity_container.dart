import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'components/activity_doughnut_chart.dart';
import 'components/activity_stats_cards.dart';
import 'components/activity_title.dart';

class ActivityContainer extends StatelessWidget {
  const ActivityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeutralColors.border),
      ),
      child: BlocBuilder<StaffListingBloc, StaffListingState>(
        builder: (context, state) {
          int totalStaffs = 0;
          int activeStaffs = 0;
          int notActiveStaffs = 0;

          if (state is StaffListingLoaded) {
            totalStaffs = state.staffs.length;
            activeStaffs = state.staffs.where((staff) => staff.isActive).length;
            notActiveStaffs = state.staffs
                .where((staff) => !staff.isActive)
                .length;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ActivityTitle(),
              ActivityDoughnutChart(
                state: state,
                totalStaffs: totalStaffs,
                activeStaffs: activeStaffs,
                notActiveStaffs: notActiveStaffs,
              ),
              const SizedBox(height: 30),
              ActivityStatsCards(
                totalStaffs: totalStaffs,
                activeStaffs: activeStaffs,
                notActiveStaffs: notActiveStaffs,
              ),
            ],
          );
        },
      ),
    );
  }
}
