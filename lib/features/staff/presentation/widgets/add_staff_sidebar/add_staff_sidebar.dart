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
            BlocBuilder<AddStaffBloc, AddStaffState>(
              builder: (context, state) {
                final isEditing = state.mode == .edit;
                return DialogHeader(
                  title: isEditing ? 'Edit Staff' : 'Add New User',
                  subtitle: isEditing
                      ? 'Update staff details'
                      : 'Create a new staff account',
                  onClose: () {
                    context.read<AddStaffBloc>().add(CloseAddStaffSidebar());
                    Navigator.of(context).pop();
                  },
                );
              },
            ),

            const Divider(height: 1, color: NeutralColors.border),

            SidebarBody(formKey: _formKey),

            const Divider(height: 1, color: NeutralColors.border),
            SidebarFooter(formKey: _formKey),
          ],
        ),
      ),
    );
  }
}
