import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';

class StaffRoleDropdown extends StatelessWidget {
  final UserRole? initialRole;

  const StaffRoleDropdown({super.key, required this.initialRole});

  String _formatRole(UserRole role) {
    return role.name[0].toUpperCase() + role.name.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          initialValue: initialRole,
          hint: const Text(
            'Select Role',
            style: TextStyle(color: TextColors.secondary),
          ),
          style: const TextStyle(color: TextColors.inverse),
          dropdownColor: NeutralColors.surface,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
              borderSide: const BorderSide(color: PrimaryColors.defaultColor),
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
    );
  }
}
