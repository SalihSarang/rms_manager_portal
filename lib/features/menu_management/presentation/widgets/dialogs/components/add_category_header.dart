import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class AddCategoryHeader extends StatelessWidget {
  const AddCategoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Add Category',
          style: TextStyle(
            color: TextColors.inverse,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: NeutralColors.icon),
          splashRadius: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
