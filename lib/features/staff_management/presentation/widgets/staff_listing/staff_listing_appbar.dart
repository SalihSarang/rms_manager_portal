import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/sidebar_utils.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/appbar/appbar.dart';

class StaffListingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const StaffListingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StaffManagementAppbar(
      onAddPressed: () async {
        final result = await showAddStaffSidebar(context);
        if (result == true && context.mounted) {
          context.read<StaffListingBloc>().add(LoadStaffs());
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
