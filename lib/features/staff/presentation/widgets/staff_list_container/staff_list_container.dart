import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff/presentation/widgets/staff_listing_table/staff_listing_table.dart';

import 'package:rms_design_system/app_colors/neutral_colors.dart';

class StaffListContainer extends StatelessWidget {
  const StaffListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 1150, // Removed fixed width
      height: 600,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeutralColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BlocBuilder<StaffListingBloc, StaffListingState>(
          builder: (context, state) {
            if (state is StaffListingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StaffListingLoaded) {
              return StaffListTable(staffList: state.staffs);
            } else if (state is StaffListingError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
