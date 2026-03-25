import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

/// [ItemShimmerPlaceholder] provides a simple image placeholder for food item images.
/// It is used during network fetching and as a fallback for missing or broken images.
class ItemShimmerPlaceholder extends StatelessWidget {
  const ItemShimmerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: NeutralColors.border,
          width: 1,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 16,
          color: NeutralColors.icon,
        ),
      ),
    );
  }
}
