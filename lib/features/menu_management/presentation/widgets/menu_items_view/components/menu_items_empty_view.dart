import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [MenuItemsEmptyView] provides a visual placeholder for empty states (no categories/no items).
class MenuItemsEmptyView extends StatelessWidget {
  final IconData icon;
  final String label;

  const MenuItemsEmptyView({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: TextColors.secondary.withValues(alpha: 0.3),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: TextColors.secondary.withValues(alpha: 0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
