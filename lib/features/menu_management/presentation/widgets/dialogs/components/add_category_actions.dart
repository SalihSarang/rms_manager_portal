import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class AddCategoryActions extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController categoryController;
  final bool showInMenu;

  const AddCategoryActions({
    super.key,
    required this.formKey,
    required this.categoryController,
    required this.showInMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Cancel Button
        SizedBox(
          height: 48,
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: NeutralColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: TextColors.inverse,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Temporarily removed BLoC action to save the category
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColors.defaultColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              elevation: 4,
              shadowColor: PrimaryColors.defaultColor.withValues(alpha: 0.5),
            ),
            child: const Text(
              'Save Category',
              style: TextStyle(
                color: TextColors.inverse,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
