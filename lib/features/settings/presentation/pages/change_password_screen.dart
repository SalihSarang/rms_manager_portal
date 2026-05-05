import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:manager_portal/features/settings/presentation/widgets/change_password/change_password_form.dart';
import 'package:manager_portal/features/settings/presentation/widgets/change_password/update_password_button.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: const RmsDetailAppBar(title: 'Change Password'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                ChangePasswordForm(
                  currentPasswordController: _currentPasswordController,
                  newPasswordController: _newPasswordController,
                  confirmPasswordController: _confirmPasswordController,
                ),
                const SizedBox(height: 40),
                UpdatePasswordButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
