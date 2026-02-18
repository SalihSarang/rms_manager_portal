import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff/presentation/widgets/add_staff_sidebar/components/dialog_fields.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class AddStaffDialogFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const AddStaffDialogFields({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddStaffBloc, AddStaffState>(
      builder: (context, state) {
        final isEditing = state is StaffEditingState && state.isEditing;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabeledTextField(
              label: 'Full Name',
              hint: 'e.g. Sarah Jenkins',
              initialValue: isEditing ? (state).fullName : null,
              onChanged: (value) =>
                  context.read<AddStaffBloc>().add(FullNameChanged(value)),
            ),
            const SizedBox(height: 20),

            LabeledTextField(
              label: 'Email Address',
              hint: 'e.g. sarah.j@bistro.com',
              keyboardType: TextInputType.emailAddress,
              initialValue: isEditing ? (state).email : null,
              onChanged: (value) =>
                  context.read<AddStaffBloc>().add(EmailChanged(value)),
            ),
            const SizedBox(height: 20),

            LabeledTextField(
              label: 'Phone Number',
              hint: '+91 5550001234',
              keyboardType: TextInputType.phone,
              initialValue: isEditing ? (state).phoneNumber : null,
              onChanged: (value) =>
                  context.read<AddStaffBloc>().add(PhoneNumberChanged(value)),
            ),
            const SizedBox(height: 20),

            if (!isEditing) ...[
              LabeledTextField(
                label: 'Password',
                hint: 'Enter password for staff',
                obscureText: true,
                onChanged: (value) =>
                    context.read<AddStaffBloc>().add(PasswordChanged(value)),
              ),
              const SizedBox(height: 20),
            ],

            // Role dropdown
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Role & Permissions',
                  style: TextStyle(
                    color: TextColors.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: state is StaffEditingState ? state.role : null,
                  hint: const Text(
                    'Select Role',
                    style: TextStyle(color: TextColors.secondary),
                  ),
                  style: const TextStyle(color: TextColors.inverse),
                  dropdownColor: NeutralColors.surface,
                  items: const ['Waiter', 'Chef']
                      .map(
                        (role) =>
                            DropdownMenuItem(value: role, child: Text(role)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<AddStaffBloc>().add(StaffRoleChanged(value));
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a role';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: NeutralColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: NeutralColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: PrimaryColors.defaultColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: TextColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
