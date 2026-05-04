import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_state.dart';
import 'package:manager_portal/features/settings/presentation/pages/business_profile_screen.dart';
import 'package:manager_portal/features/settings/presentation/pages/change_password_screen.dart';
import 'package:manager_portal/features/settings/presentation/pages/edit_profile_screen.dart';
import 'package:manager_portal/features/settings/presentation/pages/legal_document_viewer.dart';
import 'package:manager_portal/features/settings/presentation/pages/tax_and_currency_screen.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings_section_card.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          String managerName = 'Manager';
          String managerEmail = '';

          if (state is Authenticated) {
            managerName = state.manager.name;
            managerEmail = state.manager.email;
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: TextColors.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Profile Section
                  SettingsSectionCard(
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
                                managerName.isNotEmpty
                                    ? managerName[0].toUpperCase()
                                    : 'M',
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
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordScreen(),
                            ),
                          );
                        },
                        isLast: true,
                      ),
                    ],
                  ),

                  // Restaurant Section
                  SettingsSectionCard(
                    title: 'RESTAURANT',
                    children: [
                      SettingsListTile(
                        icon: Icons.business_outlined,
                        title: 'Business Profile',
                        subtitle: 'Name, Address, Contact Info',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BusinessProfileScreen(),
                            ),
                          );
                        },
                      ),
                      SettingsListTile(
                        icon: Icons.payments_outlined,
                        title: 'Currency & Tax',
                        subtitle: 'INR (₹), GST 18%',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TaxAndCurrencyScreen(),
                            ),
                          );
                        },
                        isLast: true,
                      ),
                    ],
                  ),

                  // About Section
                  SettingsSectionCard(
                    title: 'ABOUT',
                    children: [
                      SettingsListTile(
                        icon: Icons.info_outline,
                        title: 'App Version',
                        trailing: const Text(
                          '1.0.0 (Build 1)',
                          style: TextStyle(color: TextColors.secondary),
                        ),
                      ),
                      SettingsListTile(
                        icon: Icons.description_outlined,
                        title: 'Terms of Service',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LegalDocumentViewer(
                                title: 'Terms of Service',
                                content:
                                    'Full Terms of Service content goes here...',
                              ),
                            ),
                          );
                        },
                      ),
                      SettingsListTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LegalDocumentViewer(
                                title: 'Privacy Policy',
                                content:
                                    'Full Privacy Policy content goes here...',
                              ),
                            ),
                          );
                        },
                        isLast: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
