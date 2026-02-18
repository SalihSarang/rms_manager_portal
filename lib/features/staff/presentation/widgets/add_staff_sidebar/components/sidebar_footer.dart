import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/primary_add_button.dart';
import 'package:manager_portal/features/staff/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class SidebarFooter extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SidebarFooter({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: TextColors.secondary.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(width: 16),
          BlocBuilder<AddStaffBloc, AddStaffState>(
            builder: (context, state) {
              final isEditing = state is StaffEditingState && state.isEditing;
              return PrimaryAddButton(
                height: 40,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AddStaffBloc>().add(SubmitStaffAddForm());
                  }
                },
                label: isEditing ? 'Update Staff' : 'Save New Staff',
              );
            },
          ),
        ],
      ),
    );
  }
}
