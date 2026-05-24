import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';

class ChangePasswordForm extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  const ChangePasswordForm({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
          controller: currentPasswordController,
          label: 'Current Password',
          hintText: 'Enter current password',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        PrimaryTextField(
          controller: newPasswordController,
          label: 'New Password',
          hintText: 'Enter new password',
          prefixIcon: Icons.lock_reset_outlined,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        PrimaryTextField(
          controller: confirmPasswordController,
          label: 'Confirm New Password',
          hintText: 'Re-enter new password',
          prefixIcon: Icons.lock_reset_outlined,
          obscureText: true,
        ),
      ],
    );
  }
}
