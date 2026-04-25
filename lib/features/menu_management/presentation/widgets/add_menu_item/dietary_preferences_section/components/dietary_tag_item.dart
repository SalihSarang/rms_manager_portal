import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [DietaryTagItem] is a rounded, selectable chip-style widget.
/// It displays a label and visual selection state through colors and icons.
class DietaryTagItem extends StatelessWidget {
  /// The text displayed inside the tag.
  final String label;

  /// Whether this specific tag is currently active.
  final bool isSelected;

  /// Triggered when the user clicks on this specific tag.
  final VoidCallback onTap;

  const DietaryTagItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? null : NeutralColors.background,
          border: Border.all(
            color: isSelected
                ? PrimaryColors.defaultColor
                : NeutralColors.border,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.circle,
                color: PrimaryColors.defaultColor,
                size: 8,
              ),
              const SizedBox(width: 8),
            ] else ...[
              const Icon(
                Icons.circle_outlined,
                color: TextColors.secondary,
                size: 8,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? TextColors.primary : TextColors.secondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
