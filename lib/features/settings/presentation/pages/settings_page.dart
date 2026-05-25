import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_state.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/application_links_section.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/profile_section.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/restaurant_section.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => getIt<SettingsCubit>()..loadSettings(),
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String managerName = 'Manager';
              String managerEmail = '';

              if (state is Authenticated) {
                managerName = state.manager.name;
                managerEmail = state.manager.email;
              }

              return SingleChildScrollView(
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
                    ProfileSection(
                      managerName: managerName,
                      managerEmail: managerEmail,
                    ),
                    const RestaurantSection(),
                    const ApplicationLinksSection(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
