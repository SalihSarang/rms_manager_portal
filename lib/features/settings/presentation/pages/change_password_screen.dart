import 'package:flutter/material.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:manager_portal/features/auth/domain/repositories/auth_repository.dart';
import 'package:manager_portal/features/settings/presentation/widgets/change_password/change_password_form.dart';
import 'package:manager_portal/features/settings/presentation/widgets/change_password/update_password_button.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    if (DemoSessionManager.isDemoMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password change is disabled in Demo Mode to protect shared accounts.'),
          backgroundColor: SemanticColors.error,
        ),
      );
      return;
    }

    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your current password'),
          backgroundColor: SemanticColors.error,
        ),
      );
      return;
    }

    if (newPassword.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New password must be at least 6 characters long'),
          backgroundColor: SemanticColors.error,
        ),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New passwords do not match'),
          backgroundColor: SemanticColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await getIt<ManagerAuthRepository>().changePassword(currentPassword, newPassword);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update password: $e'),
          backgroundColor: SemanticColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : UpdatePasswordButton(onPressed: _updatePassword),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
