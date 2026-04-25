import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_details_screen/menu_details_header/components/menu_details_availability_badge.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_details_screen/menu_details_header/components/menu_details_tag.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class MenuDetailsHeaderInfo extends StatelessWidget {
  final FoodModel item;

  const MenuDetailsHeaderInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Availability
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  color: TextColors.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(width: 16),
            MenuDetailsAvailabilityBadge(isAvailable: item.isAvailable),
          ],
        ),
        const SizedBox(height: 12),

        // Category
        Text(
          item.category.name.toUpperCase(),
          style: TextStyle(
            color: TextColors.secondary.withValues(alpha: 0.8),
            fontSize: 14,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 32),

        // Tags
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            MenuDetailsTag(
              label: item.isVeg ? 'Vegetarian' : 'Non-Vegetarian',
              color: item.isVeg ? SemanticColors.success : SemanticColors.error,
              icon: Icons.eco_rounded,
            ),
            if (item.isFeatured)
              MenuDetailsTag(
                label: 'Featured',
                color: SemanticColors.warning,
                icon: Icons.star_rounded,
              ),
            if (item.isCustomNotes)
              MenuDetailsTag(
                label: 'Custom Notes',
                color: SemanticColors.info,
                icon: Icons.edit_note_rounded,
              ),
          ],
        ),
      ],
    );
  }
}
