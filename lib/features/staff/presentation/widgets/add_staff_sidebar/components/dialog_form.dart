import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff/presentation/widgets/add_staff_sidebar/components/dialog_fields.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';

class AddStaffDialogFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const AddStaffDialogFields({super.key, required this.formKey});

  @override
  State<AddStaffDialogFields> createState() => _AddStaffDialogFieldsState();
}

class _AddStaffDialogFieldsState extends State<AddStaffDialogFields> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _formatRole(UserRole role) {
    return role.name[0].toUpperCase() + role.name.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddStaffBloc, AddStaffState>(
      listener: (context, state) {
        if (state.mode == AddStaffMode.edit) {
          if (_nameController.text != state.fullName) {
            _nameController.text = state.fullName;
          }
          if (_emailController.text != state.email) {
            _emailController.text = state.email;
          }
          if (_phoneController.text != state.phoneNumber) {
            _phoneController.text = state.phoneNumber;
          }
        }
      },
      builder: (context, state) {
        final isEditing = state.mode == AddStaffMode.edit;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabeledTextField(
              label: 'Full Name',
              hint: 'e.g. Sarah Jenkins',
              controller: _nameController,
              onChanged: (value) =>
                  context.read<AddStaffBloc>().add(FullNameChanged(value)),
            ),
            const SizedBox(height: 20),

            LabeledTextField(
              label: 'Email Address',
              hint: 'e.g. sarah.j@bistro.com',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              onChanged: (value) =>
                  context.read<AddStaffBloc>().add(EmailChanged(value)),
            ),
            const SizedBox(height: 20),

            LabeledTextField(
              label: 'Phone Number',
              hint: '+91 5550001234',
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              onChanged: (value) =>
                  context.read<AddStaffBloc>().add(PhoneNumberChanged(value)),
            ),
            const SizedBox(height: 20),

            if (!isEditing) ...[
              LabeledTextField(
                label: 'Password',
                hint: 'Enter password for staff',
                obscureText: true,
                controller: _passwordController,
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
                DropdownButtonFormField<UserRole>(
                  value: state.role,
                  hint: const Text(
                    'Select Role',
                    style: TextStyle(color: TextColors.secondary),
                  ),
                  style: const TextStyle(color: TextColors.inverse),
                  dropdownColor: NeutralColors.surface,
                  items: UserRole.values
                      .map(
                        (role) => DropdownMenuItem(
                          value: role,
                          child: Text(_formatRole(role)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<AddStaffBloc>().add(StaffRoleChanged(value));
                    }
                  },
                  validator: (value) {
                    if (value == null) {
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
