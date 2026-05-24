import 'package:flutter/material.dart';
import 'package:manager_portal/features/settings/presentation/pages/change_password_screen.dart';
import 'package:manager_portal/features/settings/presentation/pages/edit_profile_screen.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/settings_list_tile.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/settings_section_card.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class ProfileSection extends StatelessWidget {
  final String managerName;
  final String managerEmail;

  const ProfileSection({
    super.key,
    required this.managerName,
    required this.managerEmail,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'PROFILE',
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: PrimaryColors.defaultColor,
                child: Text(
                  managerName.isNotEmpty ? managerName[0].toUpperCase() : 'M',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      managerName,
                      style: const TextStyle(
                        color: TextColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      managerEmail,
                      style: const TextStyle(
                        color: TextColors.secondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        initialName: managerName,
                        initialEmail: managerEmail,
                      ),
                    ),
                  );
                },
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
        const Divider(color: NeutralColors.border, height: 1),
        SettingsListTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
            );
          },
          isLast: true,
        ),
      ],
    );
  }
}
