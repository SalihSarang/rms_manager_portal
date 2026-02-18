import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff/presentation/widgets/add_staff_sidebar/components/dialog_header.dart';
import 'package:manager_portal/features/staff/presentation/widgets/add_staff_sidebar/components/sidebar_body.dart';
import 'package:manager_portal/features/staff/presentation/widgets/add_staff_sidebar/components/sidebar_footer.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class AddStaffSidebar extends StatefulWidget {
  const AddStaffSidebar({super.key});

  @override
  State<AddStaffSidebar> createState() => _AddStaffSidebarState();
}

class _AddStaffSidebarState extends State<AddStaffSidebar> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NeutralColors.background,
      child: SizedBox(
        width: 400,
        child: Column(
          children: [
            // Header
            BlocBuilder<AddStaffBloc, AddStaffState>(
              builder: (context, state) {
                final isEditing = state is StaffEditingState && state.isEditing;
                return DialogHeader(
                  title: isEditing ? 'Edit Staff' : 'Add New User',
                  subtitle: isEditing
                      ? 'Update staff details'
                      : 'Create a new staff account',
                );
              },
            ),

            const Divider(height: 1, color: NeutralColors.border),

            // Body
            SidebarBody(formKey: _formKey),

            const Divider(height: 1, color: NeutralColors.border),

            // Footer
            SidebarFooter(formKey: _formKey),
          ],
        ),
      ),
    );
  }
}
