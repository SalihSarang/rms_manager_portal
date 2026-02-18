import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff/presentation/utils/sidebar_utils.dart';
import 'package:manager_portal/features/staff/presentation/widgets/appbar/appbar.dart';
import 'package:manager_portal/features/staff/presentation/widgets/staff_listing_layouts.dart';
import 'package:manager_portal/core/widgets/responsive_layout.dart';

class StaffListingScreen extends StatelessWidget {
  const StaffListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StaffListingBloc>()..add(LoadStaffs()),
      child: Scaffold(
        appBar: StaffManagementAppbar(
          onAddPressed: () async {
            final result = await showAddStaffSidebar(context);
            if (result == true && context.mounted) {
              context.read<StaffListingBloc>().add(LoadStaffs());
            }
          },
        ),
        body: ResponsiveLayout(
          mobile: Padding(
            padding: const EdgeInsets.all(20),
            child: const StaffSmallScreenLayout(),
          ),
          desktop: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: const StaffLargeScreenLayout(),
          ),
        ),
      ),
    );
  }
}
