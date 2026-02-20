import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/primary_add_button.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class SidebarFooter extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SidebarFooter({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              context.read<AddStaffBloc>().add(CloseAddStaffSidebar());
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: TextColors.secondary),
            ),
          ),
          const SizedBox(width: 16),
          BlocBuilder<AddStaffBloc, AddStaffState>(
            builder: (context, state) {
              final isEditing = state.mode == AddStaffMode.edit;
              final isSubmitting = state.status == AddStaffStatus.loading;

              return PrimaryAddButton(
                height:
                    48, // Adjusted height to match common button size or standard
                onPressed: isSubmitting
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          context.read<AddStaffBloc>().add(
                            SubmitStaffAddForm(),
                          );
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
