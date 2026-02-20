import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/primary_add_button.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
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
          child: OutlinedButton(
            onPressed: onAddCategoryPressed,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              side: const BorderSide(color: NeutralColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: NeutralColors.surface,
            ),
            child: isIconOnly
                ? const Icon(Icons.add, color: TextColors.inverse, size: 20)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: TextColors.inverse, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Category',
                        style: TextStyle(color: TextColors.inverse),
                      ),
                    ],
                  ),
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
