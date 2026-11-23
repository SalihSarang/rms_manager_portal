import 'package:flutter/material.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:manager_portal/features/auth/domain/repositories/auth_repository.dart';
import 'package:manager_portal/features/settings/presentation/widgets/edit_profile/edit_profile_avatar.dart';
import 'package:manager_portal/features/settings/presentation/widgets/edit_profile/edit_profile_form.dart';
import 'package:manager_portal/features/settings/presentation/widgets/edit_profile/save_profile_button.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialEmail;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialEmail,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name cannot be empty'),
          backgroundColor: SemanticColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await getIt<ManagerAuthRepository>().updateManagerProfile(name, email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
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
      appBar: const RmsDetailAppBar(title: 'Edit Profile'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EditProfileAvatar(initialName: widget.initialName),
                const SizedBox(height: 32),
                EditProfileForm(
                  nameController: _nameController,
                  emailController: _emailController,
                ),
                const SizedBox(height: 40),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SaveProfileButton(onPressed: _saveProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
