import 'package:flutter/material.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/search_bar_container/components/dearchbar.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class MenuAppbarSearch extends StatelessWidget {
  const MenuAppbarSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: PrimarySearchBar(
          hintText: 'Search menu items, categories...',
          backgroundColor: NeutralColors.card,
          iconColor: NeutralColors.icon,
          textColor: TextColors.primary,
          height: 45,
          width: double.infinity,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
