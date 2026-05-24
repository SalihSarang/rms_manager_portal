import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

/// [ItemImagePlaceholder] provides a static fallback for food item images.
class ItemImagePlaceholder extends StatelessWidget {
  const ItemImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      color: NeutralColors.surface,
      child: const Icon(Icons.fastfood, size: 16, color: NeutralColors.icon),
    );
  }
}
