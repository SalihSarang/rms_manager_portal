import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/sidebar_utils.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/appbar/appbar.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_layouts.dart';

class StaffListingScreen extends StatelessWidget {
  const StaffListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StaffListingBloc>()..add(LoadStaffs()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: StaffManagementAppbar(
              onAddPressed: () async {
                final result = await showAddStaffSidebar(context);
                if (result == true && context.mounted) {
                  context.read<StaffListingBloc>().add(LoadStaffs());
                }
              },
            ),
            body: const ResponsiveStaffLayout(),
          );
        },
      ),
    );
  }
}
