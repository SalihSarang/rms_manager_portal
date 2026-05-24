import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:manager_portal/features/settings/presentation/widgets/edit_profile/edit_profile_avatar.dart';
import 'package:manager_portal/features/settings/presentation/widgets/edit_profile/edit_profile_form.dart';
import 'package:manager_portal/features/settings/presentation/widgets/edit_profile/save_profile_button.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class EditProfileScreen extends StatelessWidget {
  final String initialName;
  final String initialEmail;

  EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialEmail,
  }) : _nameController = TextEditingController(text: initialName),
       _emailController = TextEditingController(text: initialEmail);

  final TextEditingController _nameController;
  final TextEditingController _emailController;

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
                EditProfileAvatar(initialName: initialName),
                const SizedBox(height: 32),
                EditProfileForm(
                  nameController: _nameController,
                  emailController: _emailController,
                ),
                const SizedBox(height: 40),
                SaveProfileButton(
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
