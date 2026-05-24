import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

/// [MenuItemStatusBadge] provides a stylized indicator of food item availability.
/// It uses semantic colors (success/error) to reflect "Available" vs "Sold Out".
class MenuItemStatusBadge extends StatelessWidget {
  final bool isAvailable;

  const MenuItemStatusBadge({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable
            ? SemanticColors.success.withAlpha(25)
            : SemanticColors.error.withAlpha(25),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isAvailable
                  ? SemanticColors.success
                  : SemanticColors.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isAvailable ? 'AVAILABLE' : 'SOLD OUT',
            style: TextStyle(
              color: isAvailable
                  ? SemanticColors.success
                  : SemanticColors.error,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
