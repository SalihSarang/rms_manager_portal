import 'package:flutter/material.dart';
import 'package:manager_portal/features/settings/presentation/pages/business_profile_screen.dart';
import 'package:manager_portal/features/settings/presentation/pages/tax_and_currency_screen.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/settings_list_tile.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/settings_section_card.dart';

class RestaurantSection extends StatelessWidget {
  const RestaurantSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'RESTAURANT',
      children: [
        SettingsListTile(
          icon: Icons.business_outlined,
          title: 'Business Profile',
          subtitle: 'Name, Address, Contact Info',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BusinessProfileScreen()),
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
              MaterialPageRoute(builder: (context) => TaxAndCurrencyScreen()),
            );
          },
          isLast: true,
        ),
      ],
    );
  }
}
