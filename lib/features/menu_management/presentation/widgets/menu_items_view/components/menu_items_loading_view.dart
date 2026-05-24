import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [MenuItemsLoadingView] displays a centered loading indicator while menu data is being fetched.
class MenuItemsLoadingView extends StatelessWidget {
  const MenuItemsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: TextColors.primary),
    );
  }
}
