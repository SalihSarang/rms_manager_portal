import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/add_staff_sidebar.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

Future<dynamic> showAddStaffSidebar(
  BuildContext context, {
  StaffModel? staffToEdit,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.centerRight,
        child: BlocProvider(
          create: (context) {
            final bloc = getIt<AddStaffBloc>();
            if (staffToEdit != null) {
              bloc.add(InitializeEditMode(staffToEdit));
            } else {
              bloc.add(OpenAddStaffSidebar());
            }
            return bloc;
          },
          child: const AddStaffSidebar(),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );
    },
  );
}
