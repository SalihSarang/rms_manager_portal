import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/staff_validators.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/dialog_fields.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffPasswordField extends StatefulWidget {
  final TextEditingController controller;

  const StaffPasswordField({super.key, required this.controller});

  @override
  State<StaffPasswordField> createState() => _StaffPasswordFieldState();
}

class _StaffPasswordFieldState extends State<StaffPasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledTextField(
          label: 'Password',
          hint: 'Enter password for staff',
          obscureText: _obscurePassword,
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: TextColors.secondary,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(PasswordChanged(value)),
          validator: StaffValidators.validatePassword,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
