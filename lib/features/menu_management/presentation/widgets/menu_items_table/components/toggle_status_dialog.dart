import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class ToggleStatusDialog extends StatelessWidget {
  final FoodModel item;
  final VoidCallback onConfirm;

  const ToggleStatusDialog({
    super.key,
    required this.item,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: NeutralColors.surface,
      title: Text(
        item.isAvailable ? 'Mark Sold Out?' : 'Mark Available?',
        style: const TextStyle(color: Colors.white),
      ),
      content: Text(
        'Are you sure you want to mark ${item.name} as ${item.isAvailable ? 'sold out' : 'available'}?',
        style: const TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            'Confirm',
            style: TextStyle(
              color: item.isAvailable
                  ? SemanticColors.error
                  : SemanticColors.success,
            ),
          ),
        ),
      ],
    );
  }
}
