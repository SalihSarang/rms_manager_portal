import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_appbar.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_layouts.dart';

/// Screen that displays a list of all staff members.
///
/// Features include a responsive layout for different screen sizes and
/// an action to add new staff members via a sidebar.
class StaffListingScreen extends StatelessWidget {
  /// Creates a [StaffListingScreen].
  const StaffListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StaffListingBloc>()..add(LoadStaffs()),
      child: const Scaffold(
        appBar: StaffListingAppBar(),
        body: ResponsiveStaffLayout(),
      ),
    );
  }
}
