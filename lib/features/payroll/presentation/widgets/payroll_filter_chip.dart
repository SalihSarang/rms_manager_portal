import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PayrollFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelected;

  const PayrollFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: PrimaryColors.defaultColor.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? PrimaryColors.defaultColor : TextColors.secondary,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: NeutralColors.background,
      side: BorderSide(
        color: isSelected ? PrimaryColors.defaultColor : NeutralColors.border,
      ),
    );
  }
}
