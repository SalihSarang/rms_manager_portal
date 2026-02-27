import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/buttons/primary_outlined_button.dart';
import 'package:manager_portal/core/widgets/primary_add_button.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class MenuAppbarActions extends StatelessWidget {
  final VoidCallback onAddCategoryPressed;
  final VoidCallback onAddItemPressed;
  final bool isIconOnly;
  final double buttonHeight;
  final double buttonWidth;

  const MenuAppbarActions({
    super.key,
    required this.onAddCategoryPressed,
    required this.onAddItemPressed,
    required this.isIconOnly,
    required this.buttonHeight,
    required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        // Category Button
        SizedBox(
          height: buttonHeight,
          width: isIconOnly ? buttonHeight : buttonWidth,
          child: PrimaryOutlinedButton(
            onPressed: onAddCategoryPressed,
            label: isIconOnly ? null : 'Category',
            icon: const Icon(Icons.add, color: TextColors.inverse, size: 20),
          ),
        ),

        // New Item Button
        SizedBox(
          height: buttonHeight,
          width: isIconOnly ? buttonHeight : buttonWidth,
          child: PrimaryAddButton(
            icon: Icons.add,
            label: isIconOnly ? '' : 'New Item',
            height: buttonHeight,
            width: buttonWidth,
            onPressed: onAddItemPressed,
          ),
        ),

        const SizedBox(width: 8),
      ],
    );
  }
}
