import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_state.dart';
import 'package:manager_portal/features/settings/presentation/pages/business_profile_screen.dart';
import 'package:manager_portal/features/settings/presentation/pages/tax_and_currency_screen.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/settings_list_tile.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/settings_section_card.dart';

class RestaurantSection extends StatelessWidget {
  const RestaurantSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        String restaurantName = 'Business Profile';
        String taxInfo = 'INR (₹), GST 18%';

        if (state is SettingsLoaded) {
          restaurantName = state.settings.name;
          taxInfo =
              '${state.settings.currency}, GST ${state.settings.cgstRate + state.settings.sgstRate}%';
        }

        return SettingsSectionCard(
          title: 'RESTAURANT',
          children: [
            SettingsListTile(
              icon: Icons.business_outlined,
              title: 'Business Profile',
              subtitle: restaurantName,
              onTap: () {
                final settingsCubit = context.read<SettingsCubit>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: settingsCubit,
                      child: const BusinessProfileScreen(),
                    ),
                  ),
                );
              },
            ),
            SettingsListTile(
              icon: Icons.payments_outlined,
              title: 'Currency & Tax',
              subtitle: taxInfo,
              onTap: () {
                final settingsCubit = context.read<SettingsCubit>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: settingsCubit,
                      child: const TaxAndCurrencyScreen(),
                    ),
                  ),
                );
              },
              isLast: true,
            ),
          ],
        );
      },
    );
  }
}
